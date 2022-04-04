<%@page import="modele.DetailsCommande"%>
<%@page import="java.util.Vector"%>
<%@page import="modele.Categorie"%>
<%@page import="modele.Plat"%>
<%@page import="java.util.List"%>


<%
    Vector listedetail = (Vector) request.getAttribute("listedetail");
    Double somme = (Double) request.getAttribute("somme");
%>
<br>
<br>
<h2> Somme = <%= somme %> Ar</h2>
<div>
    <table class="table">
        <thead>
            <tr>
                <th scope="col">Id plat</th>
                <th scope="col">Quantite </th>
                <th scope="col">Prix unitaire</th>
            </tr>
        </thead>
        <tbody>
            <% for (int i=0;i<listedetail.size();i++) {
                DetailsCommande dc = (DetailsCommande)listedetail.get(i); %>
                <tr>
                    <td><%= dc.getIdPlat() %></td>
                </tr>
            <% }%>
        </tbody>
    </table>
</div>