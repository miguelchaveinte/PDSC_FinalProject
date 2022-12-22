/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controlador;

import Persistencia.DAO.AlojamientoDAO;
import Utils.Alojamiento;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
@WebServlet(name = "DisponiblesServlet", urlPatterns = {"/DisponiblesServlet"})
public class DisponiblesServlet extends HttpServlet {

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
            out.println("<title>Servlet Disponibles</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Disponibles at " + request.getContextPath() + "</h1>");
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
        
        response.setContentType("text/html;charset=UTF-8");

        /* Creacion booleano que detecta errores */
        boolean error = false;
        
        /*Obtenemos los valores de los parametros indicados en una solicitud HTTP*/
        String entrada = request.getParameter("date_ini");
        String salida = request.getParameter("date_fin");
        String localidad = request.getParameter("myLocalidad");

        request.setAttribute("local", localidad);
        
        ArrayList<Alojamiento> alojamientos_disponibles = new ArrayList<Alojamiento>();

        try {
            alojamientos_disponibles = AlojamientoDAO.getListaAlojamientos(localidad, entrada, salida);
            /* Si no existe alojamientos es null entonces error */
            if(alojamientos_disponibles.isEmpty()){
                error = true;
            }
            
            if(error){
                PrintWriter out=response.getWriter();
                out.println("No existen alojamientos disponibles para el municipio y las fechas introducidas");
            }else{
                request.setAttribute("alojamientos_disponibles", alojamientos_disponibles);
                String url = "/disponibles.jsp";
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);
                dispatcher.forward(request, response);
            }
        } catch (SQLException ex) {
                Logger.getLogger(DisponiblesServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(DisponiblesServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
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
