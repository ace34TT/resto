<%-- 
    Document   : Prix-De-Revient
    Created on : Mar 24, 2022, 2:35:38 PM
    Author     : aceky
--%>

<%@page import="modele.PrixDeRevient"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<% List<PrixDeRevient> prixDeRevients = (List<PrixDeRevient>) request.getAttribute("listeprixderevient"); %>

<br>
        <table class="table">
            <thead>
                <tr>
                    <th scope="col">ID</th>
                    <th scope="col">Produit</th>
                    <th scope="col">Prix de Revient (en Ariary) </th>
                    <th scope="col">Prix de Vente (en Ariary) </th>
                    <th scope="col">Marge (en %) </th>

                </tr>
            </thead>
            <tbody>
                <%
                    for (PrixDeRevient prixDeRevient : prixDeRevients) {
                %>
                <tr>
                    <th scope="row"><%=prixDeRevient.getId()%></th>
                    <td><a href="Detailcomposition?idplat=<%=prixDeRevient.getId()%>"><%=prixDeRevient.getNom()%></a></td>
                    <td><%=prixDeRevient.getPrixderevient()%> </td>
                    <td><%=prixDeRevient.getPrixdevente()%> </td>
                    <td><%=prixDeRevient.getMarge()%> </td>
                    <td><a href="Detailcomposition?idplat=<%=prixDeRevient.getId()%>"> <button class="btn-theme02"> Ingredients  </button> </a> </td>
                </tr>
                <%
                }
                %>
            </tbody>
        </table>