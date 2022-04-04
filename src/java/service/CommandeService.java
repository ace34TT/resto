/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package service;

import DAO.Connect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import modele.CommandeActuel;

/**
 *
 * @author Jonah
 */
public class CommandeService {
    
    public CommandeActuel getCommandeActuel(String idtabla) throws Exception {
        Connection c = new Connect().getConnection();
        String sql = "select * from commandeActuel where idtabla = '" + idtabla + "'";
        PreparedStatement pst = c.prepareStatement(sql);
        ResultSet res = pst.executeQuery();
            CommandeActuel cat = new CommandeActuel();
        while (res.next()) {
            cat.setIdcommande(res.getString("idcommande"));
            cat.setIdtabla(res.getString("idtabla"));
        }
        return cat;
    }
}
