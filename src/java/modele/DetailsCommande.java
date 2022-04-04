package modele;

public class DetailsCommande {

    String id;
    String idPlat;
    String idserveur;
    Double prixUnitaire;
    String idCommande;

    public DetailsCommande() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdPlat() {
        return idPlat;
    }

    public void setIdPlat(String idPlat) {
        this.idPlat = idPlat;
    }

    public String getIdserveur() {
        return idserveur;
    }

    public void setIdserveur(String idserveur) {
        this.idserveur = idserveur;
    }

    public Double getPrixUnitaire() {
        return prixUnitaire;
    }

    public void setPrixUnitaire(Double prixUnitaire) {
        this.prixUnitaire = prixUnitaire;
    }

    public String getIdCommande() {
        return idCommande;
    }

    public void setIdCommande(String idCommande) {
        this.idCommande = idCommande;
    }

}
