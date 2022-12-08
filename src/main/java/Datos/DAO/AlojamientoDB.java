/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Datos.DAO;

import Datos.ConnectionPool;
import Modelo.Alojamiento;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author Jhon
 */
public class AlojamientoDB {

    public static ArrayList<Alojamiento> getListaAlojamientos(String localidad, Date fechaEntrada, Date fechaSalida) throws SQLException{
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();

        ArrayList<Alojamiento> alojamientos = new ArrayList<Alojamiento>();
        PreparedStatement ps = null;
        PreparedStatement ps2 = null;
        ResultSet rs = null;
        ResultSet rs2 = null;
        //Falta obtener la ValoracionGlobal y la imagen de los Alojamientos --> TODO
        String lista = "SELECT idAlojamiento, idAnfitrion, idFotoPortada, idPrecioActual, fechaEntradaEnSimpleBnB, nombre, maximoHuespedes, numeroDormitorios, numeroCamas, numeroBanos, ubicacionDescrita, longitud, latitud, reservaRequiereAceptacionPropietario FROM ALOJAMIENTO "
        + "WHERE localidad = ?";
        
        String precio = "SELECT fechaInicio, fechaFin FROM PRECIO WHERE idPrecio = ? AND idAlojamiento = ?";
        

        try {
            ps = connection.prepareStatement(lista);
            ps.setString(1,localidad);         
            rs=ps.executeQuery();
            ps2 = connection.prepareStatement(precio);
            while(rs.next()){
                ps2.setInt(1,rs.getInt("idPrecioActual"));  
                ps2.setInt(2,rs.getInt("idAlojamiento")); 
                rs2 = ps2.executeQuery();
                rs2.next();
                if(fechaEntrada.after(rs2.getDate("fechaInicio")) && rs2.getDate("fechaFin").after(fechaSalida)){
                
                Alojamiento alojamiento=new Alojamiento(rs.getInt("idAlojamiento"),rs.getInt("idAnfitrion"),rs.getInt("idFotoPortada"),rs.getInt("idPrecioActual"),rs.getDate("fechaEntradaEnSimpleBnB"),rs.getString("nombre"),rs.getInt("maximoHuespedes"),rs.getInt("numeroDormitorios"),rs.getInt("numeroCamas"),rs.getInt("numeroBanos"),rs.getString("ubicacionDescrita"),rs.getFloat("longitud"),rs.getFloat("latitud"),rs.getBoolean("reservaRequiereAceptacionPropietario"),localidad);
                alojamientos.add(alojamiento);
                }
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
    
    public static Integer getValoraAlojamientos(int id, String localidad) throws SQLException{
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();

        ArrayList<Alojamiento> alojamientos = new ArrayList<Alojamiento>();
        PreparedStatement ps = null;
        PreparedStatement ps2 = null;
        ResultSet rs = null;
        ResultSet rs2 = null;
        
        String lista = "SELECT idAlojamiento, idAnfitrion, idFotoPortada, idPrecioActual, fechaEntradaEnSimpleBnB, nombre, maximoHuespedes, numeroDormitorios, numeroCamas, numeroBanos, ubicacionDescrita, longitud, latitud, reservaRequiereAceptacionPropietario FROM ALOJAMIENTO "
        + "WHERE localidad = ?";
     
        String valoraciones = "SELECT globalValoracion FROM VALORACION WHERE idAlojamiento = ?";

        return 0;
    }
    
}
