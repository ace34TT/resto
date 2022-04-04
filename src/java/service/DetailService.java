package service;

import DAO.Connect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;
import modele.DetailsCommande;

public class DetailService {

    public DetailService() {
    }

    public void ajouterDetail(String idPlat, int quantite, Vector<DetailsCommande> liste) throws Exception {
        Connection c = new Connect().getConnection();
        String sql = "SELECT prixdevente FROM prixdevente where id=" + idPlat;
        PreparedStatement pat = c.prepareStatement(sql);
        ResultSet res = pat.executeQuery();
        DetailsCommande d = new DetailsCommande();
        while (res.next()) {
            d.setIdPlat(idPlat);
            d.setPrixUnitaire(res.getDouble("prixdevente"));
        }
        for (int i = 0; i < quantite; i++) {
            liste.add(d);
        }
    }

    public void supprimerDetail(int index, Vector<DetailsCommande> liste) {
        liste.removeElementAt​(index);
    }
    
     public Double sommerDetails(Vector list)
     {
        Double ret = 0.0;
        for(int i=0;i<list.size();i++)
        {
            DetailsCommande dc = (DetailsCommande) list.get(i);
            ret = ret + dc.getPrixUnitaire();
        }
        return ret;
     }
}
