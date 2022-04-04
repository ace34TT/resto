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
import modele.Categorie;
import modele.DetailComposition;
import modele.ListePourBoire;
import modele.Plat;
import modele.PrixDeRevient;

/**
 *
 * @author Jonah
 */
public class Service {
    
     public List<Plat> getListePlatDisponible(String idcategorie) throws Exception {
        Connection c = new Connect().getConnection();
        String sql = "select * from PlatDisponible";
        if(idcategorie == null)
        {
            sql =  sql + " where idcategorie = '1 '";
        }
        else
        {
            sql =  sql + " where idcategorie = '"+idcategorie+"'";
        }
        System.out.println(sql);
        PreparedStatement pst = c.prepareStatement(sql);
        ResultSet res = pst.executeQuery();
        List<Plat> retour = new ArrayList();
        while (res.next()) {
            Plat plat =new Plat();
            plat.setId(res.getString("id"));
            plat.setNom(res.getString("nom"));
            plat.setPrix(res.getDouble("prix"));
            retour.add(plat);
            System.out.println(plat.toString());
        }
        return retour;
    }
     
     public List<Categorie> getListeCategorie() throws Exception {
        Connection c = new Connect().getConnection();
        String sql = "select * from Categorie";
        PreparedStatement pst = c.prepareStatement(sql);
        ResultSet res = pst.executeQuery();
        List<Categorie> retour = new ArrayList();
        
        while (res.next()) {
            Categorie cat = new Categorie();
            cat.setId(res.getString("id"));
            cat.setNom(res.getString("nom"));
            retour.add(cat);
        }
        return retour;
     }
     
     public List<PrixDeRevient> getListePrixDeRevient() throws Exception {
        Connection c = new Connect().getConnection();
        String sql = "select * from PrixDeVente order by id";
        PreparedStatement pst = c.prepareStatement(sql);
        ResultSet res = pst.executeQuery();
        List<PrixDeRevient> retour = new ArrayList();
        
        while (res.next()) {
            PrixDeRevient cat = new PrixDeRevient();
            cat.setId(res.getString("id"));
            cat.setNom(res.getString("nom"));
            cat.setPrixderevient(res.getDouble("prixderevient"));
            cat.setPrixdevente(res.getDouble("prixdevente"));
            cat.setMarge(res.getInt("marge"));
            retour.add(cat);
        }
        return retour;
     }
     public List<DetailComposition> getListeDetailComposition(String idplat) throws Exception {
        Connection c = new Connect().getConnection();
        String sql = "select * from DetailsComposition where id = "+idplat;
        PreparedStatement pst = c.prepareStatement(sql);
        ResultSet res = pst.executeQuery();
        List<DetailComposition> retour = new ArrayList();
        
        while (res.next()) {
            DetailComposition cat = new DetailComposition();
            cat.setPlat(res.getString("plat_nom"));
            cat.setIngredient(res.getString("ingredient_nom"));
            cat.setPrixunitaire(res.getDouble("prixunitaire"));
            cat.setQuantite(res.getInt("quantite"));
            cat.setPrixfinale(res.getDouble("prixfinale"));
            retour.add(cat);
        }
        return retour;
     }
    
     public List<ListePourBoire> getPourBoire(String date1, String date2) throws Exception {
        Connection c = new Connect().getConnection();
        String sql = "select idServeur , (select nom from serveur where Serveur.id = idServeur) as nom, sum(pourboire) as pourboire  from ListePourBoire";
        if((date1 == null || date2 == null) || (date1.compareTo("")==0 || date2.compareTo("") == 0))
        {
            sql =  sql ;
        }
        else
        {
            sql =  sql + " where datecommande>='"+date1+"' and datecommande<='"+date2+"'" ;
        }
        sql = sql + " group by idServeur";
        System.out.println(sql);
        PreparedStatement pst = c.prepareStatement(sql);
        ResultSet res = pst.executeQuery();
        List<ListePourBoire> retour = new ArrayList();
        while (res.next()) {
            ListePourBoire plat =new ListePourBoire();
            plat.setIdserveur(res.getString("idServeur"));
            plat.setNom(res.getString("nom"));
            plat.setPourboire(res.getDouble("pourboire"));
            retour.add(plat);
            System.out.println(plat.toString());
        }
        return retour;
    }
}
