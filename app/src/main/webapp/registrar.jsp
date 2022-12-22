<%@page import="Utils.UsuarioRegistrado"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Utils.Alojamiento"%>
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
    <script type="text/javascript" src="CrtlVistaPrecios.js"></script>
</head>

<body>
    <div id="header">
        <div class="container">
            
            <!-- Comprobamos la cabecera correspondiente -->
            <c:set var = "rol" value = "<%=usuario.getRol()%>"/>
            <c:if test="${rol=='anfitrion'}">
                <%@include file="./Anfitrion_Header.jsp" %>
            </c:if>            
        
        <h1 style="text-align: center;">Sus alojamientos</h1><br>
       
        <!--Tabla Alojamientos-->
        <table>
            <!--Cabeceras Tabla-->
            <tr>
              <th>Descripción</th>
              <th></th>
              <th>Nombre</th>
              <th>Localidad</th>
              <th>Ubicación precisa</th>
              <th>Precios</th>
            </tr>

            <!--Rows de la tabla-->
            <%
                ArrayList<Alojamiento> alojamientos_anfitrion = (ArrayList<Alojamiento>)request.getAttribute("alojamientos_anfitrion");// obtenemos la lista de alojamientos disponibles desde el servlet Disponibles
                int idbutton = 0;
                request.setAttribute("alojamientos_anfitrion", alojamientos_anfitrion);
            %>
            
            <c:set var = "alojamientos" value = "<%=alojamientos_anfitrion%>"/>
            <c:if test="${alojamientos.isEmpty()== true}">
            
            </table>
                    <br>
                    <label id= "error" for="my-select" style="font-size: 24px;">Usted no dipone de Alojamientos</label><!-- comment -->
            
            </c:if>
            
            <c:if test="${alojamientos.isEmpty()== false}">
            <%        
                for (Alojamiento alojamiento : alojamientos_anfitrion) {      
            %>
            <tr>
                        <td><img src="<%= alojamiento.getIdFotoPortada()%>" width="250" height="179"></td>
                        <td><button name = "boton" class="button button1" onclick="tarjeta()" type="button" style="width: auto;">Modificar <br> Precios</button></td>
                        <td id = "<%=idbutton%>"><%= alojamiento.getNombre()%></td>
                        <td><%= alojamiento.getLocalidad()%></td>
                        <td><%= alojamiento.getLatitud()%>, <%= alojamiento.getLongitud()%></td>
                        <td>Noche: <%= alojamiento.getIdPrecioActual().getPrecioNoche()%>
                            <br>Fin de Semana: <%= alojamiento.getIdPrecioActual().getPrecioFinDeSemana()%>
                            <br>Semana: <%= alojamiento.getIdPrecioActual().getPrecioSemana()%>
                            <br>Mes:<%= alojamiento.getIdPrecioActual().getPrecioMes()%></td>
            </tr>
                    <% 
                        idbutton = idbutton +1;}
                    %>
                    
             </c:if>
        </table>
        
        <!--Modal-->
        <div id="id03" class="modal">
            <!--Form-->
           
            <form class="modal-content animate">
            
                <div class="imgcontainer">
                    <input name = 'botpulsado' id = "botpulsado" hidden></input>
                    <span onclick="document.getElementById('id03').style.display='none'" class="close" title="Close Modal">&times;</span>
                </div>

                <div class="container" style="padding: 16px">
                    <h1 id = 'miEncabezado'></h1>
                        <br>

                    <!-- Noche -->
                    <p>
                        <label for="noche"><b>Precio por noche:</b></label>
                        <!--<input type="text" placeholder="70?" name="noche"><br>-->
                        <input type="number" placeholder="Cantidad" name = 'Noche' id="noche"><br><br>
                    </p>

                    <!-- Finde -->
                    <p>
                        <label for="finde"><b>Precio fin de semana:</b></label>
                        <!--<input type="text" placeholder="200?" name="finde"><br>-->
                        <input type="number" placeholder="Cantidad" name = 'FinSemana' id="finde"><br><br>
                    </p>

                    <!-- Semana -->
                    <p>
                        <label for="semana"><b>Precio una semana:</b></label>
                        <!--<input type="text" placeholder="500?" name="semana"><br>-->
                        <input type="number" placeholder="Cantidad" name = 'Semana' id="semana"><br><br>
                    </p>

                    <!-- Mes -->
                    <p>
                        <label for="mes"><b>Precio por mes:</b></label>
                        <!--<input type="text" placeholder="3000?" name="mes"><br>-->
                        <input type="number" placeholder="Cantidad" name = 'Mes' id="mes"><br><br>
                    </p>

                    <!--Fin Vigencia-->
                    <label for="date_fin" style="font-size: 24px;">Fecha de fin de vigencia: </label>
                    <input type="date" id="date_fin" name='date_fin'>
                    <br><br>
                    <br>
                    <h4 name='erro1' id="erro1" style="display: none">No existen alojamientos disponibles</h4>
                    <br>
                    <!-- Submit Button -->
                    <button type="submit" id="submit1" onclick="comprobaciones()">Guardar Tarjeta</button>

                </div>
            </form>
            
        </div>
        
        </div>
    </div>
       
</body>
</html>