/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Persistencia;

import java.sql.Connection;
import java.sql.SQLException;
import javax.naming.InitialContext;
import javax.sql.DataSource;

/**
 *
 * @author Jhon
 */
public class ConnectionPool {
    private static ConnectionPool pool = null;
	private static DataSource dataSource = null;

	public static ConnectionPool getInstance() {
		if (pool == null) {
			pool = new ConnectionPool();
		}
		return pool;
	}

	private ConnectionPool() {
		try {
			InitialContext ic = new InitialContext();
			dataSource = (DataSource) ic.lookup("java:/comp/env/jdbc/db_vacationashome");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void freeConnection(Connection c) {
		try {
			c.close();
		} catch (SQLException sqle) {
			sqle.printStackTrace();
		}
	}

	public Connection getConnection() {
		try {
			return dataSource.getConnection();
		} catch (SQLException sqle) {
			sqle.printStackTrace();
			return null;
		}
	}

}