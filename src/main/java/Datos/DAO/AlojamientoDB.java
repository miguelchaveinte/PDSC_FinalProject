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

        System.out.println("Fecha entrada sin cast: " + fechaEntrada);
        System.out.println("Fecha salida sin cast: " + fechaSalida);
        
        ArrayList<Alojamiento> alojamientos = new ArrayList<Alojamiento>();
        PreparedStatement ps = null;
        ResultSet rs = null;
        PreparedStatement ps2 = null;
        ResultSet rs2 = null;
        //Falta obtener la ValoracionGlobal y la imagen de los Alojamientos --> TODO
        String lista = "SELECT * FROM ALOJAMIENTO WHERE idAlojamiento NOT IN (SELECT idAlojamiento FROM RESERVA WHERE(fechaEntrada <= ? AND fechaSalida >= ?) OR (fechaSalida <= ? AND fechaSalida >= ?))"
        + "AND localidad = ?";
        
        String valoraciones = "SELECT globalValoracion FROM VALORACION WHERE idAlojamiento = ?";

        try {
            ps = connection.prepareStatement(lista);
            ps.setString(1, fechaEntrada);
            ps.setString(2, fechaEntrada);
            ps.setString(3, fechaSalida);
            ps.setString(4, fechaSalida);
            ps.setString(5,localidad);
            System.out.println("CARENCIAS1");
            rs=ps.executeQuery();
            System.out.println("CARENCIAS2");
            //ps2 = connection.prepareStatement(fechas);
            while(rs.next()){  
                ps2 = connection.prepareStatement(valoraciones);
                ps2.setInt(1,rs.getInt("idAlojamiento")); 
                rs2 = ps2.executeQuery();
                ArrayList<Date> reservas = new ArrayList<Date>();
                double valoracion = 0;
                int contador = 0;
                while(rs2.next()){
                    valoracion += rs2.getInt("globalValoracion");
                    contador++;
                }
                valoracion = valoracion / contador;
                Alojamiento alojamiento=new Alojamiento(rs.getInt("idAlojamiento"),rs.getInt("idAnfitrion"),rs.getString("idFotoPortada"),rs.getInt("idPrecioActual"),rs.getDate("fechaEntradaEnSimpleBnB"),rs.getString("nombre"),rs.getInt("maximoHuespedes"),rs.getInt("numeroDormitorios"),rs.getInt("numeroCamas"),rs.getInt("numeroBanos"),rs.getString("ubicacionDescrita"),rs.getFloat("longitud"),rs.getFloat("latitud"),rs.getBoolean("reservaRequiereAceptacionPropietario"),localidad, valoracion);
                alojamientos.add(alojamiento);
            }
                
            System.out.println("En la DB: " + alojamientos);
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
    
}