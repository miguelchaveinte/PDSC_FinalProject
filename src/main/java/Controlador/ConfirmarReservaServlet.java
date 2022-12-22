/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controlador;

import Persistencia.DAO.AlojamientoDAO;
import Utils.Reserva;
import Utils.UsuarioRegistrado;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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
@WebServlet(name = "ConfirmarReservaServlet", urlPatterns = {"/ConfirmarReservaServlet"})
public class ConfirmarReservaServlet extends HttpServlet {

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
            out.println("<title>Servlet ConfirmarReservaServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ConfirmarReservaServlet at " + request.getContextPath() + "</h1>");
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

         /*Informacion de los alojamientos*/
        HttpSession session = request.getSession();
        UsuarioRegistrado user = (UsuarioRegistrado) session.getAttribute("user");

        String idAlojamiento = request.getParameter("idAlojamiento");
        String huespedes = request.getParameter("huespedes");
       
        String fecha_inicio = request.getParameter("date_ini");
        String fecha_fin = request.getParameter("date_fin");

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date inicio = new Date();
        Date fin = new Date();

        Boolean resultado = false;

        String message = request.getParameter("biografia");
        String fraccionar = request.getParameter("pago");
        boolean pago_fraccionado = Boolean.parseBoolean(fraccionar);
        String estado = request.getParameter("estado");

        //Creacion de la Reserva
        try{
            if(user.getRol().equals("anfitrion")){
                //El Anfitrion no puede realizar Reservas
                PrintWriter out=response.getWriter();
                out.println("Lo sentimos, el anfitrion no puede realizar reservas");
            } else if(message==""){
                //El mensaje para el anfitrion no puede ser vacio
                PrintWriter out=response.getWriter();
                out.println("Lo sentimos, el mensaje para el anfitrion no puede estar vacio");
            } else{

                resultado = AlojamientoDAO.insertReserva(user.getId(), Integer.parseInt(idAlojamiento), fecha_inicio, fecha_fin, Integer.parseInt(huespedes), message, estado, pago_fraccionado);

                if(!resultado){
                    //Si es False, el Alojamiento no puede ser Reservado en esas fechas
                    PrintWriter out=response.getWriter();
                    out.println("Lo sentimos, el alojamiento esta reservado en esas fechas");
                }
            }

        } catch (ParseException ex) {
            Logger.getLogger(ConfirmarReservaServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(ConfirmarReservaServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        /*
        //Podemos llevarlo al mismo jsp de info alojamiento y cambiar el texto del boton a 'Reservado' (opcional)
        String url = "/ReservasView.jsp";
        // forward the request and response to the view
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);
        dispatcher.forward(request, response);*/
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
