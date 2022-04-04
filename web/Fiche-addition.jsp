<%-- 
    Document   : Fiche-addition
    Created on : Mar 31, 2022, 3:24:57 PM
    Author     : aceky
--%>

<%@page import="modele.Addition"%>
<%@page import="modele.DetailsAddition"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    List<DetailsAddition> details = (List<DetailsAddition>) request.getAttribute("detailaddition");
    Addition addition = (Addition) request.getAttribute("addition");
%>  
<div class="container border mt-4">
    <div class="row d-flex mt-4 justify-content-center">
        <h1>Fiche addition : <%= addition.getNom()%></h1>
    </div>
    <div class="row mt-4">
        <div class="col-12">
            <table class="table">
                <thead>
                    <tr>
                        <th scope="col">Plat</th>
                        <th scope="col">Quantite</th>
                        <th scope="col">Prix unitaire</th>
                        <th scope="col">Prix total</th>
                    </tr>
                </thead>
                <tbody>
                    <%  int total = 0;
                                for (DetailsAddition detail : details) {%>
                    <tr>
                        <th scope="row"><%=detail.getNom()%></th>
                        <td><%=detail.getNombre()%></td>
                        <td><%=detail.getPrixunitaire()%></td>
                        <td><%=detail.getSomme()%></td>
                    </tr>
                    <% }
                    %>
                    <tr>
                        <th scope="row"></th>
                        <td></td>
                        <td></td>
                        <td> Total : <%= addition.getAddition() %> Ar </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
