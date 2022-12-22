/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Persistencia.DAO;

import Persistencia.ConnectionPool;
import Utils.Alojamiento;
import Utils.Precio;
import Utils.Reserva;
import Utils.UsuarioRegistrado;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author Jhon
 */
public class AlojamientoDAO {

    public static ArrayList<Alojamiento> getListaAlojamientos(String localidad, String fechaEntrada, String fechaSalida) throws SQLException, ParseException{
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        
        ArrayList<Alojamiento> alojamientos = new ArrayList<Alojamiento>();
        PreparedStatement ps = null;
        ResultSet rs = null;
        PreparedStatement ps2 = null;
        ResultSet rs2 = null;
        PreparedStatement ps3 = null;
        ResultSet rs3 = null;
       
        String lista = "SELECT * FROM ALOJAMIENTO WHERE idAlojamiento NOT IN (SELECT idAlojamiento FROM RESERVA WHERE(fechaEntrada <= ? AND fechaSalida >= ?) OR (fechaSalida <= ? AND fechaSalida >= ?))"
        + "AND localidad = ?";
        
        String valoraciones = "SELECT AVG(globalValoracion) AS VALORACIONMEDIA FROM VALORACION WHERE idAlojamiento = ?";
        float valoracion = 0;
        
        String precio = "SELECT * FROM PRECIO WHERE idPrecio = ?";
        Precio precioActual = null;

        try {
            ps = connection.prepareStatement(lista);
            ps.setString(1, fechaEntrada);
            ps.setString(2, fechaEntrada);
            ps.setString(3, fechaSalida);
            ps.setString(4, fechaSalida);
            ps.setString(5,localidad);

            rs=ps.executeQuery();
            
            while(rs.next()){  
                ps2 = connection.prepareStatement(valoraciones);
                ps2.setInt(1,rs.getInt("idAlojamiento")); 
                rs2 = ps2.executeQuery();
                while (rs2.next()){
                    valoracion=rs2.getFloat("VALORACIONMEDIA");
                }
                rs2.close();
                ps2.close();

                ps3 = connection.prepareStatement(precio);
                ps3.setInt(1,rs.getInt("idPrecioActual")); 
                rs3 = ps3.executeQuery();
                while (rs3.next()){
                    precioActual =new Precio(rs3.getInt("idPrecio"), rs3.getFloat("precioNoche"), rs3.getFloat("precioFinDeSemana"), rs3.getFloat("precioSemana"), rs3.getFloat("precioMes"), rs3.getDate("fechaInicio"), rs3.getDate("fechaFin"), rs.getInt("idAlojamiento"));
                }

                Alojamiento alojamiento=new Alojamiento(rs.getInt("idAlojamiento"),rs.getInt("idAnfitrion"),rs.getString("idFotoPortada"),precioActual,rs.getDate("fechaEntradaEnSimpleBnB"),rs.getString("nombre"),rs.getInt("maximoHuespedes"),rs.getInt("numeroDormitorios"),rs.getInt("numeroCamas"),rs.getInt("numeroBanos"),rs.getString("ubicacionDescrita"),rs.getFloat("longitud"),rs.getFloat("latitud"),rs.getBoolean("reservaRequiereAceptacionPropietario"),localidad, valoracion, null, null);
                alojamientos.add(alojamiento);
            }
            rs.close();
            ps.close();
            pool.freeConnection(connection);
            
            return alojamientos;
        } catch (SQLException e) {
            
            e.printStackTrace();
            return null;
        }
        finally{
            ps.close();
            pool.freeConnection(connection);
        }
    }


    public static Alojamiento getInfoAlojamiento (int idAlojamiento) throws SQLException{
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        PreparedStatement ps2 = null;
        ResultSet rs2 = null;
        PreparedStatement ps3 = null;
        ResultSet rs3 = null;
        PreparedStatement ps4 = null;
        ResultSet rs4 = null;

        Alojamiento alojamiento=new Alojamiento();
        ArrayList<String> services = new ArrayList<String>();
        ArrayList<String> caracteristicas = new ArrayList<String>();
        String caract = "";
        String service = "";
        Precio precioActual = null;

        String infoAlojamiento = "SELECT * FROM ALOJAMIENTO WHERE idAlojamiento = ?";
        String infoServicios = "SELECT * FROM SERVICIO WHERE idAlojamiento = ?";
        String infoCaracteristicas = "SELECT * FROM CARACTERISTICA WHERE idAlojamiento = ?";
        String precio = "SELECT * FROM PRECIO WHERE idPrecio = ?";
       
        try {
            ps = connection.prepareStatement(infoAlojamiento);
            ps.setInt(1, idAlojamiento);
            rs=ps.executeQuery();
            
            while(rs.next()){
                //Obtenemos los servicios del alojamiento
                ps2 = connection.prepareStatement(infoServicios);
                ps2.setInt(1,rs.getInt("idAlojamiento")); 
                rs2 = ps2.executeQuery();
                while(rs2.next()){
                    service=rs2.getString("servicio");
                    services.add(service);
                }
                //Obtenemos las caracteristicas del alojamiento
                ps3 = connection.prepareStatement(infoCaracteristicas);
                ps3.setInt(1,rs.getInt("idAlojamiento")); 
                rs3 = ps3.executeQuery();
                while(rs3.next()){
                    caract=rs3.getString("caracteristica");
                    caracteristicas.add(caract);
                }
                
                ps4 = connection.prepareStatement(precio);
                ps4.setInt(1,rs.getInt("idPrecioActual")); 
                rs4 = ps4.executeQuery();
                while(rs4.next()){
                    precioActual =new Precio(rs4.getInt("idPrecio"), rs4.getFloat("precioNoche"), rs4.getFloat("precioFinDeSemana"), rs4.getFloat("precioSemana"), rs4.getFloat("precioMes"), rs4.getDate("fechaInicio"), rs4.getDate("fechaFin"), rs4.getInt("idAlojamiento"));
                }
                
                alojamiento=new Alojamiento(rs.getInt("idAlojamiento"),rs.getInt("idAnfitrion"),rs.getString("idFotoPortada"),precioActual,rs.getDate("fechaEntradaEnSimpleBnB"),rs.getString("nombre"),rs.getInt("maximoHuespedes"),rs.getInt("numeroDormitorios"),rs.getInt("numeroCamas"),rs.getInt("numeroBanos"),rs.getString("ubicacionDescrita"),rs.getFloat("longitud"),rs.getFloat("latitud"),rs.getBoolean("reservaRequiereAceptacionPropietario"),"",0,services,caracteristicas);
            }
            
            ps.close();
            pool.freeConnection(connection);
            return alojamiento;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
        finally{
            ps.close();
            pool.freeConnection(connection);
        }
    }
    
    public static ArrayList<Alojamiento> getAlojamientosAnf (int idAnfitrion) throws SQLException{
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        
        ArrayList<Alojamiento> alojamientos = new ArrayList<Alojamiento>();
        PreparedStatement ps = null;
        ResultSet rs = null;
        PreparedStatement ps2 = null;
        ResultSet rs2 = null;
        //Falta obtener la ValoracionGlobal y la imagen de los Alojamientos --> TODO
        String lista = "SELECT * FROM ALOJAMIENTO WHERE idAnfitrion = ?";
        
        String precio = "SELECT * FROM PRECIO WHERE idPrecio = ?";

        try {
            ps = connection.prepareStatement(lista);
            ps.setInt(1, idAnfitrion);
            rs=ps.executeQuery();
            
            while(rs.next()){  
                ps2 = connection.prepareStatement(precio);
                ps2.setInt(1,rs.getInt("idPrecioActual")); 
                rs2 = ps2.executeQuery();
                rs2.next();
                Precio precioActual =new Precio(rs2.getInt("idPrecio"), rs2.getFloat("precioNoche"), rs2.getFloat("precioFinDeSemana"), rs2.getFloat("precioSemana"), rs2.getFloat("precioMes"), rs2.getDate("fechaInicio"), rs2.getDate("fechaFin"), rs2.getInt("idAlojamiento"));
                
                Alojamiento alojamiento=new Alojamiento(rs.getInt("idAlojamiento"),rs.getInt("idAnfitrion"),rs.getString("idFotoPortada"),precioActual,rs.getDate("fechaEntradaEnSimpleBnB"),rs.getString("nombre"),rs.getInt("maximoHuespedes"),rs.getInt("numeroDormitorios"),rs.getInt("numeroCamas"),rs.getInt("numeroBanos"),rs.getString("ubicacionDescrita"),rs.getFloat("longitud"),rs.getFloat("latitud"),rs.getBoolean("reservaRequiereAceptacionPropietario"),rs.getString("localidad"), 0, null, null);
                alojamientos.add(alojamiento);
            }
                
            ps.close();
            pool.freeConnection(connection);
            System.out.println("En el método: " + alojamientos);
            return alojamientos;
        } catch (SQLException e) {
            
            e.printStackTrace();
            return null;
        }
        finally{
            ps.close();
            pool.freeConnection(connection);
        }
    }


    public static ArrayList<Alojamiento> getListaReservas(String localidad, int huespedes) throws SQLException, ParseException{
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        
        ArrayList<Alojamiento> alojamientos = new ArrayList<Alojamiento>();
        PreparedStatement ps = null;
        ResultSet rs = null;
        PreparedStatement ps2 = null;
        ResultSet rs2 = null;
        PreparedStatement ps3 = null;
        ResultSet rs3 = null;
       
        String lista = "SELECT * FROM ALOJAMIENTO WHERE localidad = ? AND maximoHuespedes >= ?";
        
        String valoraciones = "SELECT AVG(globalValoracion) AS VALORACIONMEDIA FROM VALORACION WHERE idAlojamiento = ?";
        float valoracion = 0;
        
        String precio = "SELECT * FROM PRECIO WHERE idPrecio = ?";
        Precio precioActual = null;

        try {
            ps = connection.prepareStatement(lista);
            ps.setString(1, localidad);
            ps.setInt(2, huespedes);
            rs=ps.executeQuery();
            
            while(rs.next()){  
                ps2 = connection.prepareStatement(valoraciones);
                ps2.setInt(1,rs.getInt("idAlojamiento")); 
                rs2 = ps2.executeQuery();
                while (rs2.next()){
                    valoracion=rs2.getFloat("VALORACIONMEDIA");
                }
                ps3 = connection.prepareStatement(precio);
                ps3.setInt(1,rs.getInt("idPrecioActual")); 
                rs3 = ps3.executeQuery();
                while (rs3.next()){
                    precioActual =new Precio(rs3.getInt("idPrecio"), rs3.getFloat("precioNoche"), rs3.getFloat("precioFinDeSemana"), rs3.getFloat("precioSemana"), rs3.getFloat("precioMes"), rs3.getDate("fechaInicio"), rs3.getDate("fechaFin"), rs.getInt("idAlojamiento"));
                }

                Alojamiento alojamiento=new Alojamiento(rs.getInt("idAlojamiento"),rs.getInt("idAnfitrion"),rs.getString("idFotoPortada"),precioActual,rs.getDate("fechaEntradaEnSimpleBnB"),rs.getString("nombre"),rs.getInt("maximoHuespedes"),rs.getInt("numeroDormitorios"),rs.getInt("numeroCamas"),rs.getInt("numeroBanos"),rs.getString("ubicacionDescrita"),rs.getFloat("longitud"),rs.getFloat("latitud"),rs.getBoolean("reservaRequiereAceptacionPropietario"),localidad, valoracion, null, null);
                alojamientos.add(alojamiento);
            }
                
            ps.close();
            pool.freeConnection(connection);
            
            return alojamientos;
        } catch (SQLException e) {
            
            e.printStackTrace();
            return null;
        }
        finally{
            ps.close();
            pool.freeConnection(connection);
        }
    }

    public static Boolean insertReserva(int idUsuario, int idAlojamiento, String inicio, String fin, int num_huespedes, String message, String estado, Boolean pago) throws SQLException, ParseException{
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        PreparedStatement ps2 = null;
        ResultSet rs2 = null;

        //Debemos comprobar que en las fechas deseadas el Alojamiento esté disponible
        String lista = "SELECT * FROM ALOJAMIENTO WHERE idAlojamiento NOT IN (SELECT idAlojamiento FROM RESERVA WHERE(fechaEntrada <= ? AND fechaSalida >= ?) OR (fechaSalida <= ? AND fechaSalida >= ?)) AND idAlojamiento = ?";

        String consulta = "INSERT INTO RESERVA ( idUsuario, idAlojamiento, fechaEntrada, fechaSalida, numeroHuespedes, comentariosAdicionales, estado, divideElPago) VALUES (?,?,?,?,?,?,?,?)";

        try {
            ps = connection.prepareStatement(lista);
            ps.setString(1, inicio);
            ps.setString(2, inicio);
            ps.setString(3, fin);
            ps.setString(4, fin);
            ps.setInt(5,idAlojamiento);
            rs=ps.executeQuery();
            
            //ResultSet devuelve False, el alojamiento no esta disponible
            if(!rs.next()){
                System.out.println("Lo sentimos, el alojamiento está reservado en esas fechas");
                return false;
            } else{
                ps2 = connection.prepareStatement(consulta);
                ps2.setInt(1, idUsuario);
                ps2.setInt(2, idAlojamiento);
                ps2.setString(3, inicio);
                ps2.setString(4, fin);
                ps2.setInt(5, num_huespedes);
                ps2.setString(6, message);
                ps2.setString(7, estado);
                ps2.setBoolean(8, pago);
                //Ejecucion
                ps2.executeUpdate();
            }
  
            ps.close();
            //ps2.close();
            pool.freeConnection(connection);
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static void updatePrecio(int id, Precio precioNuevo) throws SQLException{    
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        PreparedStatement ps2 = null;
        ResultSet rs2 = null;
        PreparedStatement ps3 = null;
        ResultSet rs3 = null;
        
	//Consulta para añadir el nuevo precio
        String añade = "INSERT INTO PRECIO(precioNoche,precioFinDeSemana,precioSemana,precioMes,fechaInicio,fechaFin,idAlojamiento) VALUES(?,?,?,?,?,?,?)  ";
        
        //Consulta para cambiar la fechaFin del precio anterior a la actual
        String cambiafecha = "UPDATE Precio SET fechaFin = ? WHERE idPrecio = ?";
        
	//Consulta para actualizar el precio actual del alojamiento
        String update = "UPDATE Alojamiento SET idPrecioActual = ? WHERE idAlojamiento = ?";
        
        try{
		  //Paresaemos las fechas obtenidas de precioNuevo, metemos todos los parametros en la primera consulta y ejecutamos
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            String inicioStr = dateFormat.format(precioNuevo.getFechaInicio());
            String finStr = dateFormat.format(precioNuevo.getFechaFin());
            ps = connection.prepareStatement(añade, Statement.RETURN_GENERATED_KEYS);
            ps.setFloat(1, precioNuevo.getPrecioNoche());
            ps.setFloat(2, precioNuevo.getPrecioFinDeSemana());
            ps.setFloat(3, precioNuevo.getPrecioSemana());
            ps.setFloat(4, precioNuevo.getPrecioMes());
            ps.setDate(5, java.sql.Date.valueOf(inicioStr));
            ps.setDate(6, java.sql.Date.valueOf(finStr));
            ps.setInt(7, id);
            ps.executeUpdate();

            //Obtenemos el índice añadido al nuevo precio, metemos los parametros en la segunda consulta y ejecutamos
            int res = 0;
            rs = ps.getGeneratedKeys();
            if(rs.next()){
                res = rs.getInt(1);
            }
            
            //Ejecutamos la segunda consulta en la que pondremos en la fecha de fin del precio anterior la fecha actual
            ps2 = connection.prepareStatement(cambiafecha);
            ps2.setDate(1, java.sql.Date.valueOf(inicioStr));
            ps2.setInt(2, precioNuevo.getIdPrecio());
            ps2.executeUpdate();
            
            //Ultima query para actualizar l id del precio actual del Alojamiento
            ps3 = connection.prepareStatement(update);
            ps3.setInt(1, res);
            ps3.setInt(2, id);
            ps3.executeUpdate();
            
            //Liberamos espacio
            ps.close();
            ps2.close();
            ps3.close();
            pool.freeConnection(connection);
            
        } catch (SQLException e) {
            System.out.println("FALLITOS");
            e.printStackTrace();
        }
        
    }
   
}