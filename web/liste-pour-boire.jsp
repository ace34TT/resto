
<%@page import="modele.ListePourBoire"%>
<%@page import="java.util.List"%>
<%
    List<ListePourBoire> listepourboire = (List<ListePourBoire>) request.getAttribute("listepourboire");
%>
<br>

<div>
<form action="listepourboire" method="post">
    DATE 1 :<input type="date" name="date1"/><br>
    DATE 2 :<input type="date" name="date2"/><br>
    <input type="submit" value="filtrer"/>
</form>
</div>
<div>
    <table class="table table-responsive-md">
        <thead>
            <tr>
                <th scope="col">Id du serveur</th>
                <th scope="col">Nom</th>
                <th scope="col">Pourboire</th>

            </tr>
        </thead>
        <tbody>
            <%
                for (ListePourBoire lp : listepourboire) {
            %>
            <tr>
                <th scope="row"><%= lp.getIdserveur()%></th>
                <td><%= lp.getNom()%></td>
                <td><%= lp.getPourboire() %></td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>
</div>