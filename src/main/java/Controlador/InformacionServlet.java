/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controlador;

import Persistencia.DAO.AlojamientoDAO;
import Utils.Alojamiento;
import Utils.UsuarioRegistrado;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
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
@WebServlet(name = "InformacionServlet", urlPatterns = {"/InformacionServlet"})
public class InformacionServlet extends HttpServlet {

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
            out.println("<title>Servlet Informacion</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Informacion at " + request.getContextPath() + "</h1>");
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
        
        /*Informacion de los alojamientos*/
        HttpSession session = request.getSession();
        UsuarioRegistrado user= (UsuarioRegistrado) session.getAttribute("user");
        
        int idAlojamiento = Integer.parseInt(request.getParameter("idAlojamiento"));
        Alojamiento alojamiento = null;

        int value = 0;
        String tipo = request.getParameter("tipo");
        if (tipo.equals("Disponibles")){
            value = 1; //Valor 1 si la informacion es referente a los alojamientos disponibles
        } else{
            value = 2; //Valor 2 si la informacion es referente a los alojamientos para reservar
        }  

        try {
            alojamiento = AlojamientoDAO.getInfoAlojamiento(idAlojamiento);
            System.out.println(alojamiento);
            System.out.println("Chequeo de alojamiento");
            
        } catch (SQLException ex) {
            Logger.getLogger(InformacionServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        request.setAttribute("infoAlojamiento",alojamiento);
        //Seteamos el valor en funcion del tipo obtenido
        request.setAttribute("value", value);
        
        String url = "/info_alojamiento.jsp?idAlojamiento="+idAlojamiento;
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);
        dispatcher.forward(request, response);
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
        processRequest(request, response);
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
