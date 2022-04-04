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
import modele.Addition;
import modele.DetailsAddition;
import modele.Tabla;

/**
 *
 * @author Jonah
 */
public class TableService {

     public List<Tabla> getListeTabla() throws Exception {
        Connection c = new Connect().getConnection();
        String sql = "select * from Tabla";
        PreparedStatement pst = c.prepareStatement(sql);
        ResultSet res = pst.executeQuery();
        List<Tabla> retour = new ArrayList();
        
        while (res.next()) {
            Tabla cat = new Tabla();
            cat.setId(res.getString("id"));
            cat.setNom(res.getString("nom"));
            retour.add(cat);
        }
        return retour;
     }
     
    
    public List<Addition> getListeAddition() throws Exception {
        Connection c = new Connect().getConnection();
        String sql = "select * from addition";
        PreparedStatement pst = c.prepareStatement(sql);
        ResultSet res = pst.executeQuery();
        List<Addition> retour = new ArrayList();

        while (res.next()) {
            Addition cat = new Addition();
            cat.setIdtabla(res.getString("idtabla"));
            cat.setNom(res.getString("nom"));
            cat.setAddition(res.getDouble("sum"));
            retour.add(cat);
        }
        return retour;
    }

    public Addition getAddition(String idtabla) throws Exception {
        Connection c = new Connect().getConnection();
        String sql = "select * from addition where idtabla='" + idtabla + "'";
        PreparedStatement pst = c.prepareStatement(sql);
        ResultSet res = pst.executeQuery();
            Addition cat = new Addition();
        while (res.next()) {
            cat.setIdtabla(res.getString("idtabla"));
            cat.setNom(res.getString("nom"));
            cat.setAddition(res.getDouble("sum"));
        }
        return cat;
    }

    public List<DetailsAddition> getListeDetailsAddition(String idtabla) throws Exception {
        Connection c = new Connect().getConnection();
        String sql = "select * from detailsaddition where idtabla = '" + idtabla + "'";
        PreparedStatement pst = c.prepareStatement(sql);
        ResultSet res = pst.executeQuery();
        List<DetailsAddition> retour = new ArrayList();
        while (res.next()) {
            DetailsAddition cat = new DetailsAddition();
            cat.setNom(res.getString("nom"));
            cat.setNombre(res.getInt("nombre"));
            cat.setPrixunitaire(res.getDouble("prixunitaire"));
            cat.setSomme(res.getDouble(5));
            retour.add(cat);
        }
        return retour;
    }
}
