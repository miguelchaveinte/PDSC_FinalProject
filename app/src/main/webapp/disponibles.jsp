
<%@page import="Utils.UsuarioRegistrado"%>
<%-- 
    Document   : disponibles
    Created on : 08-dic-2022, 1:54:33
    Author     : Jhon
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="Utils.Alojamiento"%>
<%@page import="java.util.ArrayList"%>

<%
    UsuarioRegistrado usuario = (UsuarioRegistrado) session.getAttribute("user");
    System.out.println("usuario es:"+usuario);
    
    if (usuario==null){
        usuario = new UsuarioRegistrado();
        usuario.setRol("usuario");
        System.out.println("rol es"+usuario.getRol());
    }
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

                    <!--Make sure the form has the autocomplete function switched off:-->
                    <form autocomplete="off" name="myForm">
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
                            <%
                                String localizacion = (String)request.getAttribute("local");
                            %>
                            <label for="localidad" style="font-size: 24px;">Localidad</label><br>
                            <input id="myInput" type="text" name="myLocalidad" placeholder="Localidad" required>
                        </div>
                        <br>
                        <input type="submit" id="submit" class="button button1" onclick="function2()">
                    </form>
                    
                </div>
            </div>

            <!--------Tabla de Alojamientos Disponibles-------->
            <div style="width: 55%; float: right;">
                <div class="header-text" >
                <!--Select para filtros-->
                <label for="my-select" style="font-size: 24px;">Filtrar por:</label>
                <select id="my-select" onchange="sortTable()">
                    <option>Seleccione</option>
                    <option value="option-1" onclick="">De menor a mayor capacidad</option>
                      <option value="option-2">De mayor a menor capacidad</option>
                      <option value="option-3">De menor a mayor valoración</option>
                      <option value="option-4">De mayor a menor valoración</option>
                </select><br><br>
                <label id= "localidad" for="my-select" style="font-size: 24px;">Localidad:</label><span id="nombreLocalidad" style="font-size: 24px;"><%= localizacion %></span>
         
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
                        //Obtenemos la lista de alojamientos disponibles desde el servlet Disponibles
                        ArrayList<Alojamiento> alojamientos_disponibles = (ArrayList<Alojamiento>)request.getAttribute("alojamientos_disponibles");
                                                
                        for (Alojamiento alojamiento : alojamientos_disponibles) {      
                    %>
                      <tr>
                        <td><%= alojamiento.getNombre() %></td>
                        <td><%= alojamiento.getMaximoHuespedes() %></td>
                        <td><%= alojamiento.getValoracion()%></td>
                        <td><a href="InformacionServlet?tipo=Disponibles&idAlojamiento=<%=alojamiento.getIdAlojamiento()%>"> <img src = <%= alojamiento.getIdFotoPortada()%> width="250" height="179"/></a></td>
                      </tr>
                      <%
                          }
                      %>
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
