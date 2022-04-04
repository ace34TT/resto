/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Jonah
 */
public class Connect {
    
    public Connection getConnection() throws Exception {
        Connection con = null;
        try {
            Class.forName("org.postgresql.Driver");
            System.out.print("driver ok");
            con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/resto", "postgres", "jonah");
            System.out.print("\nconnected !!!!!!\n");
            con.setAutoCommit(false);
        } catch (ClassNotFoundException | SQLException e) {
            System.out.print("\n  probleme : "+e.getMessage());
        }
        return con;
    }
    
    public static void main(String[] args) throws Exception {
        Connect conn = new Connect();
        Connection c = conn.getConnection();
    }
}
