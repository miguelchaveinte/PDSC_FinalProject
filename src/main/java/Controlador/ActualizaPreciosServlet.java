/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controlador;

import Persistencia.DAO.AlojamientoDAO;
import Utils.Alojamiento;
import Utils.Precio;
import Utils.UsuarioRegistrado;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
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
 * @author hecto
 */
@WebServlet(name = "ActualizaPreciosServlet", urlPatterns = {"/ActualizaPreciosServlet"})
public class ActualizaPreciosServlet extends HttpServlet {

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
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ActualizaPrecios</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ActualizaPrecios at " + request.getContextPath() + "</h1>");
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
        //Obtenemos los campos que ha introducido el usuario como Strings
        String precioNoche = request.getParameter("noche");
        String precioFinSemana = request.getParameter("finde");
        String precioSemana = request.getParameter("semana");
        String precioMes = request.getParameter("mes");
        String fin = request.getParameter("date_fin");
        
        //Cogemos el número del botón que se ha pulsado que está en un input hidden y coincide con la posición del alojamiento en el vector
        String idboton = request.getParameter("botpulsado");
       
        
        //Parseamos los precios que ha metido el usuario a Floats
        Float noche = Float.parseFloat(precioNoche);
        Float finsemana = Float.parseFloat(precioFinSemana);
        Float semana = Float.parseFloat(precioSemana);
        Float mes = Float.parseFloat(precioMes);
        
        //Recogemos el id del usuario
        HttpSession session = request.getSession();
        UsuarioRegistrado usuario = (UsuarioRegistrado)session.getAttribute("user");
        int idAnf = usuario.getId();
        
        try {
            //Creamos el parser, parseamos la fecha de fin y obtenemos la fecha actual
            SimpleDateFormat parseo = new SimpleDateFormat("yyyy-MM-dd");
            Calendar cal = Calendar.getInstance();
            Date fechaActu = cal.getTime();
            Date finParseado = parseo.parse(fin);
            
            //Obtenemos los alojamientos del anfitrión
            ArrayList<Alojamiento> alojs = AlojamientoDAO.getAlojamientosAnf(idAnf);
            //Creamos un nuevo precio con el id del precio anterior (cuando se añada a la base de datos el id va a ser un autoincrement, ponemos el id del precio anterior para facilitar la segunda consulta que se hace en el metodo update)
            Precio precioNuevo = new Precio(alojs.get(Integer.parseInt(idboton)).getIdPrecioActual().getIdPrecio(),noche,finsemana,semana,mes,fechaActu,finParseado,alojs.get(Integer.parseInt(idboton)).getIdAlojamiento());
            
            //Seteamos otra vez los alojamientos para obtenerlos en el jsp al que vamos a pasar
            request.setAttribute("alojamientos_anfitrion", alojs);
            
            //Actualizamos el precio
            AlojamientoDAO.updatePrecio(precioNuevo.getIdAlojamiento(), precioNuevo);

            String url = "/registrar.jsp";
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);
            dispatcher.forward(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(ActualizaPreciosServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(ActualizaPreciosServlet.class.getName()).log(Level.SEVERE, null, ex);
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
