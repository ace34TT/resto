<%-- 
    Document   : Details-Composition
    Created on : Mar 24, 2022, 3:41:33 PM
    Author     : aceky
--%>
<%@page import="modele.DetailComposition"%>
<%@page import="java.util.List"%>
<%
    List<DetailComposition> detailsCompositions = (List<DetailComposition>) request.getAttribute("listeDetailsComposition");
%>
<div class="mt-5">
            <div class="container border shadow-sm p-3 mb-5 bg-white rounded">
                <div class="row">
                    <div class="col-md-12" style="color: #353f45">
                        <h1>Fiche composition de <b><%= detailsCompositions.get(0).getPlat() %></b></h1>
                        <p><b>Produit</b> :  <%= detailsCompositions.get(0).getPlat() %> </p>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-1-12"></div>
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">Nom ingredient</th>
                                <th scope="col">Quantite</th>
                                <th scope="col">Prix unitaire</th>
                                <th scope="col">Prix final</th>
                            </tr>
                        </thead>
                        <tbody>

                            <%  int total = 0 ;
                                for(DetailComposition detailComposition : detailsCompositions) {%>
                            <tr>
                                <th scope="row"><%=detailComposition.getIngredient()%></th>
                                <td><%=detailComposition.getQuantite()%></td>
                                <td><%=detailComposition.getPrixunitaire()%></td>
                                <td><%=detailComposition.getPrixfinale()%></td>
                            </tr>
                            <%
                                total += detailComposition.getPrixfinale();
                                }
                            %>
                            <tr>
                                <th scope="row"></th>
                                <td></td>
                                <td></td>
                                <td> Total : <%= total %> </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
