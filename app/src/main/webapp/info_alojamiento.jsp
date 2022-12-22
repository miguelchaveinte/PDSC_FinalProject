<%-- 
    Document   : info_alojamiento
    Created on : 11-dic-2022, 18:37:46
    Author     : Jhon
--%>

<%@page import="Utils.UsuarioRegistrado"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="Utils.Alojamiento"%>
<%@page import="java.util.ArrayList"%>

<%
    UsuarioRegistrado usuario = (UsuarioRegistrado) session.getAttribute("user");
    if (usuario==null){
        usuario = new UsuarioRegistrado();
        usuario.setRol("usuario");
        System.out.println("rol es"+usuario.getRol());
    }
    
    Alojamiento alojamiento = (Alojamiento) request.getAttribute("infoAlojamiento");
    int value = (Integer) request.getAttribute("value");
    ArrayList<String> servicios = alojamiento.getServicios();
    ArrayList<String> caracteristicas = alojamiento.getCaracteristicas();
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VacationAsHome</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="./font-awesome-4.7.0/css/font-awesome.min.css">
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script src='https://code.jquery.com/jquery-3.3.1.slim.min.js'></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    <!--<script type="text/javascript" src="CrtlVistaReservas.js"></script>-->
</head>


<body>
    <div id="headerP">
        <div class="container">
            
            <!-- Comprobamos la cabecera correspondiente -->
            <c:set var = "rol" value = "<%=usuario.getRol()%>"/>
            <c:if test="${rol=='anfitrion'}">
                <%@include file="./Anfitrion_Header.jsp" %>
            </c:if>
            
            <c:if test="${rol=='cliente'}">
                <%@include file="./Cliente_Header.jsp" %>
            </c:if>
            
             <c:if test="${rol=='usuario'}">
            <%@include file="./Usuario_Header.jsp" %>
            </c:if>

            <!--------Imagen del alojamiento-------->
            <div style="width: 40%; float: left;">
                <div class="header-text">
                <img src= <%= alojamiento.getIdFotoPortada()%> width="700" height="500">
                </div>
            </div>

            <!--------Caracteristicas del alojamiento-------->
            <div style="width: 40%; float: right;">
                <div class="header-text">
                    <label for="huespedes" style="font-size: 24px;">Nombre:</label> <span style="font-size: 20px;"><%=alojamiento.getNombre()%></span>
                    <br>
                    <label for="huespedes" style="font-size: 24px;">Máximo huéspedes:</label> <span style="font-size: 20px;"><%=alojamiento.getMaximoHuespedes()%></span>
                    <br>
                    <label for="huespedes" style="font-size: 24px;">Número de dormitorios:</label> <span style="font-size: 20px;"><%=alojamiento.getNumeroDormitorios()%></span>
                    <br>
                    <label for="huespedes" style="font-size: 24px;">Número de camas:</label> <span style="font-size: 20px;"><%=alojamiento.getNumeroCamas()%></span>
                    <br>
                    <label for="huespedes" style="font-size: 24px;">Número de baños:</label> <span style="font-size: 20px;"><%=alojamiento.getNumeroBanos()%></span>
                    <br>
                    <label for="huespedes" style="font-size: 24px;">Servicios:</label> <span style="font-size: 20px;">
                        <%
                            for (String servicio : servicios) {
                                out.println( "<br>" + "- " + servicio);
                            }
                        %>
                    </span><br><br><br>
                    
                    <!-- En funcion del value se mostrara o no lo siguiente (boton para realizar reserva) -->
                    <c:set var = "check" value = "<%=value%>"/>
                    <c:if test="${check==2}">
                        <%@include file="./ConfirmarReserva.jsp" %>
                    </c:if>                   

                </div>
            </div>
        </div>
    </div>

    <div id="header2">
        <!--Descripcion del alojamientos + Fecha de Reserva-->
        <div class="container">
            <div style="width: 40%; float: left;">
                <label for="date_ini" style="font-size: 24px;">Características del alojamiento:</label><br>
                <p>
                    <%
                        for (String caracteristica : caracteristicas) {
                            out.println("- "+caracteristica + "<br>");
                        }
                    %>
                </p>
            </div>

        </div>
        
    </div>
                
    <!--Texto aqui-->
    <h4 class= "reservaComplete" id="reservaComplete" style="display: none">Reserva Realizada</h4>

    
    <!--Script-->
    <script>
        // Get the modal
        var modal = document.getElementById('id02');
        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function(event) {
        if (event.target == modal) {
        modal.style.display = "none";
        }
        }
    </script>
    
    
</body>
</html>