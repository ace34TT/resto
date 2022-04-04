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
import modele.Serveur;

/**
 *
 * @author Jonah
 */
public class ServeurService {
     public List<Serveur> getListeServeur() throws Exception {
        Connection c = new Connect().getConnection();
        String sql = "select * from Serveur";
        PreparedStatement pst = c.prepareStatement(sql);
        ResultSet res = pst.executeQuery();
        List<Serveur> retour = new ArrayList();
        
        while (res.next()) {
            Serveur cat = new Serveur();
            cat.setId(res.getString("id"));
            cat.setNom(res.getString("nom"));
            retour.add(cat);
        }
        return retour;
     }
     
    
}
