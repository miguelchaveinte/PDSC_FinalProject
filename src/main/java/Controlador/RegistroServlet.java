/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controlador;

import Persistencia.DAO.UsuarioRegistradoDAO;
import Utils.UsuarioRegistrado;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Jhon
 */
@WebServlet(name = "RegistroServlet", urlPatterns = {"/RegistroServlet"})
public class RegistroServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Registro</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Registro at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        UsuarioRegistrado user = new UsuarioRegistrado();
        request.setCharacterEncoding("UTF-8");
        /*Obtenemos los valores de los parametros indicados en una solicitud HTTP*/
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        int id=-1;
        String url="";
        boolean error = false;
        int tipoError = 0;
        
        if (UsuarioRegistradoDAO.emailExists(email) && (id = UsuarioRegistradoDAO.comprobarUsuario(email,password)) != -1) {
            url = "/Logged.jsp";
            try{
                user = UsuarioRegistradoDAO.seleccionaUsuario(id);
            } catch(Exception e){
                //user.setContraseña(password);
                //user.setEmail(email);
                //user.setId(id);
            }

            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            // forward the request and response to the view
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);
            dispatcher.forward(request, response);
            //PrintWriter out=response.getWriter();
            //out.println();
        }else if(UsuarioRegistradoDAO.emailExists(email) == false){
            error = true;
            tipoError = 1;
        }else{
            error = true;
            tipoError = 2;
        }
        if(error){
            if(tipoError==1){
                PrintWriter out=response.getWriter();
                out.println("El email introducido no existe en la base de datos");
             
            }else if(tipoError == 2){
                PrintWriter out=response.getWriter();
                out.println("La contrasena no se corresponde con el correo introducido");
            }
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
