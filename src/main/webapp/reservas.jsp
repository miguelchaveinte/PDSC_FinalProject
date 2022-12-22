<%-- 
    Document   : reservas
    Created on : 17-dic-2022, 19:43:54
    Author     : Jhon
--%>

<%@page import="Utils.UsuarioRegistrado"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Utils.Alojamiento"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    UsuarioRegistrado usuario = (UsuarioRegistrado) session.getAttribute("user");
%>

<!DOCTYPE html>
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
    <script type="text/javascript" src="localidades_spain.js"></script>
    <script type="text/javascript" src="CrtlVistaReservas.js"></script>
</head>


<body>
    <div id="header">
        <div class="container">
            
            <!-- Comprobamos la cabecera correspondiente -->
            <c:set var = "rol" value = "<%=usuario.getRol()%>"/>
            <c:if test="${rol=='anfitrion'}">
                <%@include file="./Anfitrion_Header.jsp" %>
            </c:if>
            
            <c:if test="${rol=='cliente'}">
                <%@include file="./Cliente_Header.jsp" %>
            </c:if>

            <!--------Fechas y Buscador Localidad-------->
            <div style="width: 40%; float: left;">
                <div class="header-text">
                    <h1>VacationAsHome</h1>
                    <br>

                    <!--Make sure the form has the autocomplete function switched off:-->
                    <form autocomplete="off" name="myForm" action="ReservasServlet" onsubmit="return checkLocalidad()">
                        <!--Buscar Localidad-->                    
                        <div class="autocomplete" style="width:300px;">
                            <label for="localidad" style="font-size: 24px;">Localidad</label><br>
                            <input id="myInput" type="text" name="myLocalidad" placeholder="Localidad" required>
                        </div>
                        <br><br>
                        <!--Numero de Huespedes-->
                        <div>
                            <label for="huespedes" style="font-size: 24px;">Huespedes:</label>
                            <input type="number" id="huespedes" name="huespedes" min="1" max="20" step="1" value="3">
                        </div>
                        
                        <br>
                        <input type="submit" class="button button1" value="Buscar">
                    </form>
                    
                </div>
            </div>

            <!--------Tabla de Alojamientos Disponibles-------->
            <div style="width: 55%; float: right;">
                <div class="header-text">    
                    
                <!--Creacion de tabla para mostrar los Alojamientos Disponibles-->
                <table id="myTable">
                    <!--Cabeceras Tabla-->
                    <tr>
                        <th>Nombre</th>
                      <th>Capacidad</th>
                      <th>Valoración</th>
                      <th>Imagen</th>
                    </tr>

                    <!--Rows de la tabla-->
                    <!-- Uso de etiquetas JSP para mostrar informacion dinamica -->
                    <%
                        ArrayList<Alojamiento> alojamientos_disponibles = (ArrayList<Alojamiento>)request.getAttribute("alojamientos_disponibles");// obtenemos la lista de alojamientos disponibles desde el servlet Disponibles
                        int tipoerror = (int)request.getAttribute("tipoerror");
                        if(tipoerror == 1){
                    %>
                    </table>
                    <br>
                    <label id= "error" for="my-select" style="font-size: 24px;">No existen alojamientos disponibles para el municipio</label>
               
                        
                    <%        
                        }else{
                            for (Alojamiento alojamiento : alojamientos_disponibles) {
                            
                    %>
                      <tr>
                        <td><%= alojamiento.getNombre() %></td>
                        <td><%= alojamiento.getMaximoHuespedes() %></td>
                        <td><%= alojamiento.getValoracion()%></td>
                        <td><a href="InformacionServlet?tipo=Reservas&idAlojamiento=<%=alojamiento.getIdAlojamiento()%>"> <img src = <%= alojamiento.getIdFotoPortada()%> width="250" height="179"/></a></td>
                      </tr>
                      <%
                          }
                      %>
                       </table>
                       <%
                        }
                      %>
                      
                </div>
            </div>        

        </div>
    </div>

    <!-----------------Autocompletado del buscador de Localidades----------------->
    <script>        
        /*Array que contiene las localidades de España*/
        var local_spain = localidades;
        
        /*initiate the autocomplete function on the "myInput" element, and pass along the countries array as possible autocomplete values:*/
        autocomplete(document.getElementById("myInput"), local_spain);
    </script>

    
</body>
</html>
