/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Datos.DAO;

import Datos.ConnectionPool;
import Modelo.Alojamiento;
import Modelo.Precio;
import Modelo.UsuarioRegistrado;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
public class AlojamientoDB {

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
        //Falta obtener la ValoracionGlobal y la imagen de los Alojamientos --> TODO
        String lista = "SELECT * FROM ALOJAMIENTO WHERE idAlojamiento NOT IN (SELECT idAlojamiento FROM RESERVA WHERE(fechaEntrada <= ? AND fechaSalida >= ?) OR (fechaSalida <= ? AND fechaSalida >= ?))"
        + "AND localidad = ?";
        
        String valoraciones = "SELECT AVG(globalValoracion) AS VALORACIONMEDIA FROM VALORACION WHERE idAlojamiento = ?";
        float valoracion = 0;
        
        String precio = "SELECT * FROM PRECIO WHERE idPrecio = ?";

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
                ps3 = connection.prepareStatement(precio);
                ps3.setInt(1,rs.getInt("idPrecioActual")); 
                rs3 = ps2.executeQuery();
                rs3.next();
                Precio precioActual =new Precio(rs2.getInt("idPrecio"), rs2.getFloat("precioNoche"), rs2.getFloat("precioFinDeSemana"), rs2.getFloat("precioSemana"), rs2.getFloat("precioMes"), rs2.getDate("fechaInicio"), rs2.getDate("fechaFin"), rs2.getInt("idAlojamiento"));

                while (rs2.next()){
                    valoracion=rs2.getFloat("VALORACIONMEDIA");
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
                rs4 = ps2.executeQuery();
                rs4.next();
                Precio precioActual =new Precio(rs2.getInt("idPrecio"), rs2.getFloat("precioNoche"), rs2.getFloat("precioFinDeSemana"), rs2.getFloat("precioSemana"), rs2.getFloat("precioMes"), rs2.getDate("fechaInicio"), rs2.getDate("fechaFin"), rs2.getInt("idAlojamiento"));
                
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
   
}