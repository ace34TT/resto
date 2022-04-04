/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modele;

/**
 *
 * @author Jonah
 */
public class ListePourBoire {
    String idserveur;
    String nom;
    Double pourboire;

    public String toString() {
        return "ListePourBoire{" + "idserver=" + idserveur + ", nom=" + nom + ", pourboire=" + pourboire + '}';
    }

    public String getIdserveur() {
        return idserveur;
    }

    public void setIdserveur(String idserver) {
        this.idserveur = idserver;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public Double getPourboire() {
        return pourboire;
    }

    public void setPourboire(Double pourboire) {
        this.pourboire = pourboire;
    }
    
    
}
