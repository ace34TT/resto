<%-- 
    Document   : Liste-addition
    Created on : Mar 31, 2022, 3:11:48 PM
    Author     : aceky
--%>

<%@page import="modele.Addition"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    List<Addition> additions = (List<Addition>) request.getAttribute("listeaddition");
%>
<div class="container">
    <div class="row">
        <h1>Liste additions</h1>
    </div>
    <div class="row">
        <table class="table">
            <thead>
                <tr>
                    <th scope="col">Table</th>
                    <th scope="col">Nom</th>
                    <th scope="col">Addition</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (Addition addition : additions) {
                %>
                <tr onclick="location.href = 'detailaddition?idtabla=<%=addition.getIdtabla()%>';" >
                    <th scope="row"><%=addition.getIdtabla()%></th>
                    <td><%=addition.getNom()%></td>
                    <td><%=addition.getAddition()%></td>
                </tr>
                <%
                    }
                %>>
            </tbody>
        </table>
    </div>
</div>
