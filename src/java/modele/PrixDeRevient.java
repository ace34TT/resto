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
public class PrixDeRevient {
    String id;
    String nom;
    Double prixderevient;
    Double prixdevente;
    int marge;

    public int getMarge() {
        return marge;
    }

    public void setMarge(int marge) {
        this.marge = marge;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public Double getPrixderevient() {
        return prixderevient;
    }

    public void setPrixderevient(Double prixderevient) {
        this.prixderevient = prixderevient;
    }

    public Double getPrixdevente() {
        return prixdevente;
    }

    public void setPrixdevente(Double prixdevente) {
        this.prixdevente = prixdevente;
    }

    public String toString() {
        return "PrixDeRevient{" + "id=" + id + ", nom=" + nom + ", prixUnitaire=" + prixderevient + '}';
    }

    
}
