<%-- 
    Document   : DisponiblesView
    Created on : 18-dic-2022, 12:40:38
    Author     : Jhon
--%>

<%@page import="Modelo.UsuarioRegistrado"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    UsuarioRegistrado usuario = (UsuarioRegistrado) session.getAttribute("user");    
    System.out.println("usuario es:"+usuario);
    
    if (usuario==null){
        usuario = new UsuarioRegistrado();
        usuario.setRol("usuario");
        System.out.println("rol es"+usuario.getRol());
    }
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
    <script type="text/javascript" src="localidades_spain.js"></script>
    <script type="text/javascript" src="CrtlVistaDisponibles.js"></script>
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
        
        <c:if test="${rol=='usuario'}">
            <%@include file="./Usuario_Header.jsp" %>
        </c:if>

            <!--------Fechas y Buscador Localidad-------->
            <div style="width: 40%; float: left;">
                <div class="header-text">
                    <h1>VacationAsHome</h1>
                    <br>
                    
                    <!--Make sure the form has the autocomplete function switched off-->
                    <form autocomplete="off" name="myForm" action="Disponibles" method="GET" > <!-- action="Disponibles" method="GET" -->
                        <!--------Filtro Fechas-------->
                        <div style="width: 40%; float: left;">
                            <!--Fecha Inicio-->
                            <label for="date_ini" style="font-size: 24px;">Fecha de Entrada</label><br>
                            <input type="date" id="date_ini" name="date_ini" onchange="changeDate()" required><br><br>
                        </div>

                        <div style="width: 40%; float: right;">
                            <!--Fecha Fin-->
                            <label for="date_fin" style="font-size: 24px;">Fecha de Salida</label><br>
                            <input type="date" id="date_fin" name="date_fin" required>
                            <br><br>
                        </div>

                        <!--Buscar Localidad-->                    
                        <div class="autocomplete" style="width:300px;">
                            <label for="localidad" style="font-size: 24px;">Localidad</label><br>
                            <input id="myInput" type="text" name="myLocalidad" placeholder="Localidad" required>
                        </div>
                        <br>
                        <input type="submit" id="submit1" class="button button1" onclick="function1()">
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
                </table>
                
                <h4 id="erro1" style="display: none">No existen alojamientos disponibles para el municipio y las fechas introducidas</h4>
                
                </div>
            </div>        

        </div>
    </div>

    <script>
        /*Array que contiene las localidades de España*/
        var local_spain = localidades;

        /*initiate the autocomplete function on the "myInput" element, and pass along the locations array as possible autocomplete values:*/
        autocomplete(document.getElementById("myInput"), local_spain);
    </script>
    

</body>
</html>