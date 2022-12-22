package Persistencia.DAO;

import Persistencia.ConnectionPool;
import Utils.UsuarioRegistrado;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author hecto
 */
public class UsuarioRegistradoDAO {


    public static boolean emailExists(String correo) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        String query = "SELECT email FROM USUARIOREGISTRADO "
        + "WHERE email = ?";
        try {
            /*Creamos un objeto PreparedStatement a partir de una sentencia SQL proporcionada en la 
            cadena query y una conexión a la base de datos proporcionada en el objeto connection.*/
            ps = connection.prepareStatement(query);
            /*Enviamos el parametro correspondiente a la sentencia*/
            ps.setString(1, correo);
            /*Ejecutamos la sentencia SQL compilada y obtenemos el resultado en un objeto ResultSet*/
            rs = ps.executeQuery();
            boolean res = rs.next();
            rs.close();
            ps.close();
            pool.freeConnection(connection);
            return res;
            } catch (SQLException e) {
            e.printStackTrace();
            return false;
            }
    }

    public static int comprobarUsuario(String correo, String password) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        String query = "SELECT id,email,contrasena FROM USUARIOREGISTRADO "
        + "WHERE email = ?";
        try {
            ps = connection.prepareStatement(query);
            ps.setString(1, correo);
            rs = ps.executeQuery();
            int res=-1;
            if(rs.next()){
                if(correo.equals(rs.getString("email")) && password.equals(rs.getString("contrasena")))
                    res=rs.getInt("id");
            }
            rs.close();
            ps.close();
            pool.freeConnection(connection);
            return res;
            } catch (SQLException e) {
            e.printStackTrace();
            return -1;
            }
    }

    public static UsuarioRegistrado seleccionaUsuario(int idUsuario)throws SQLException{
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        UsuarioRegistrado usuario = null;

        String query = "SELECT * FROM USUARIOREGISTRADO "
        + "WHERE id = ?";
        try {
            ps = connection.prepareStatement(query);
            ps.setInt(1, idUsuario);
            rs = ps.executeQuery();

            while (rs.next()){
                usuario = new UsuarioRegistrado(rs.getInt("id"), rs.getString("rol"), rs.getString("email"), rs.getDate("fechaDeSuscripcion") ,rs.getString("contrasena"));
            }
            rs.close();
            ps.close();
            pool.freeConnection(connection);
            return usuario;
            } catch (SQLException e) {
            e.printStackTrace();
            return null;
            }
    }
    
}