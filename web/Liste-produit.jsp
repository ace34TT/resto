<%@page import="modele.Categorie"%>
<%@page import="modele.Plat"%>
<%@page import="java.util.List"%>


<%
    List<Plat> plats = (List<Plat>) request.getAttribute("listeplat");

    List<Categorie> categories = (List<Categorie>) request.getAttribute("listecategorie");
%>
<br>
<div>
    <% for (Categorie categorie : categories) {%>
    <a href="Index?idcategorie=<%= categorie.getId()%>"> <button class="btn-info"> <%= categorie.getNom()%> </button> </a> 
    <% }  %>
</div>
<div>
    <table class="table">
        <thead>
            <tr>
                <th scope="col">Id</th>
                <th scope="col">Nom</th>
                <th scope="col">Prix (en Ariary)</th>


            </tr>
        </thead>
        <tbody>
            <% for (Plat plat : plats) {%>
            <tr>
        <form action="commander" method="post"/>
            <input type="hidden" name="idplat" value="<%=plat.getId()%>"/>
            <th scope="row"><%=plat.getId()%></th>
            <td><%=plat.getNom()%></td>
            <td><%=plat.getPrix()%></td>
            <td><input type="number" name="quantite" min-value="1" value="1"><input type="submit" value="Commander"/></td>
        </form>
        </tr>
        <% }%>
        </tbody>
    </table>
</div>