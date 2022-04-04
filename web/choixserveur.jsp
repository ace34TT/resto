
<%@page import="modele.Tabla"%>
<%@page import="modele.Serveur"%>
<%@page import="java.util.List"%>
<%
    List<Serveur> listeserveur = (List<Serveur>) request.getAttribute("listeserveur");

    List<Tabla> listetabla = (List<Tabla>) request.getAttribute("listetabla");
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="Dashboard">
        <meta name="keyword" content="Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">
        <title>Gestion rESTO</title>

        <!-- Favicons -->
        <link href="img/favicon.png" rel="icon">
        <link href="img/apple-touch-icon.png" rel="apple-touch-icon">

        <!-- Bootstrap core CSS -->
        <link href="lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <!--external css-->
        <link href="lib/font-awesome/css/font-awesome.css" rel="stylesheet" />
        <!-- Custom styles for this template -->
        <link href="css/style.css" rel="stylesheet">
        <link href="css/style-responsive.css" rel="stylesheet">

        <!-- === -->
    </head>

    <body>
        <section id="container">
            <!-- **********************************************************************************************************************************************************
                TOP BAR CONTENT & NOTIFICATIONS
                *********************************************************************************************************************************************************** -->
            <!--header start-->
            <header class="header black-bg">
                <div class="sidebar-toggle-box">
                    <div class="fa fa-bars tooltips" data-placement="right" data-original-title="Toggle Navigation"></div>
                </div>
                <!--logo start-->
                <a href="#" class="logo"><b>GESTION RESTO</b></a>
            </header>

            <br>

            <br>

            <section id="main-content">
                <section class="wrapper site-min-height">

                    <div>

                        <form action="choixserveur" method="post">
                            <div class="form-group">
                                <label for="exampleFormControlSelect1">Choix serveur</label>
                                <select  class="form-control" id="exampleFormControlSelect1"   name="serveur">
                                    <% for (Serveur serveur : listeserveur) {%>
                                    <option value="<%= serveur.getId()%>" title="<%= serveur.getId()%>"><%= serveur.getNom()%></option>            
                                    <% }%>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="exampleFormControlSelect1">Choix table</label>
                                <select class="form-control" id="exampleFormControlSelect1"  name="tabla">
                                    <% for (Tabla tabla : listetabla) {%>
                                    <option value="<%= tabla.getId()%>" title="<%= tabla.getId()%>"><%= tabla.getNom()%></option>            
                                    <% }%>
                                </select>
                            </div>
                            <input  class="btn btn-primary" id="exampleFormControlSelect1"  type="submit" value="OK"/>
                        </form>
                    </div>  
                </section>
                <!-- /wrapper -->
            </section>

            <footer class="site-footer">
                <div class="text-center">
                    <p>
                        &copy; Copyrights <strong>Jonah </strong>. All Rights Reserved
                    </p>
                    <div class="credits">
                        <!--
                          You are NOT allowed to delete the credit link to TemplateMag with free version.
                          You can delete the credit link only if you bought the pro version.
                          Buy the pro version with working PHP/AJAX contact form: https://templatemag.com/dashio-bootstrap-admin-template/
                          Licensing information: https://templatemag.com/license/
                        -->
                    </div>
                    <a href="#" class="go-top">
                        <i class="fa fa-angle-up"></i>
                    </a>
                </div>
            </footer>
            <!--footer end-->
        </section>

        <!-- js placed at the end of the document so the pages load faster -->
        <script src="lib/jquery/jquery.min.js"></script>
        <script src="lib/bootstrap/js/bootstrap.min.js"></script>
        <script src="lib/jquery-ui-1.9.2.custom.min.js"></script>
        <script src="lib/jquery.ui.touch-punch.min.js"></script>
        <script class="include" type="text/javascript" src="lib/jquery.dcjqaccordion.2.7.js"></script>
        <script src="lib/jquery.scrollTo.min.js"></script>
        <script src="lib/jquery.nicescroll.js" type="text/javascript"></script>

        <!--common script for all pages-->
        <script src="lib/common-scripts.js"></script>
        <script src="lib/form-component.js"></script>
        <!--script for this page-->

    </body>

</html>
