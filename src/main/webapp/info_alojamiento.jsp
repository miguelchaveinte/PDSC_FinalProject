<%-- 
    Document   : info_alojamiento
    Created on : 11-dic-2022, 18:37:46
    Author     : Jhon
--%>

<%@page import="Modelo.UsuarioRegistrado"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="Modelo.Alojamiento"%>
<%@page import="java.util.ArrayList"%>

<%
    UsuarioRegistrado usuario = (UsuarioRegistrado) session.getAttribute("user");
    Alojamiento alojamiento = (Alojamiento) request.getAttribute("infoAlojamiento");
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
</head>


<body>
    <div id="headerP">
        <div class="container">
            
            <!-- Comprobamos la cabecera correspondiente -->
            <c:set var = "rol" value = "<%=usuario.getRol()%>"/>
            <%
                System.out.println("-----");
                System.out.println(usuario.getRol());
                System.out.println("-----");
            %>
            <c:if test="${rol=='anfitrion'}">
                <%@include file="./Anfitrion_Header.jsp" %>
            </c:if>
            
            <c:if test="${rol=='cliente'}">
                <%@include file="./Cliente_Header.jsp" %>
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
    
    <!-----------------Filtro de fechas, evitar fechas previas al dia actual----------------->
    <script type="text/javascript">
        window.onload=function(){
            var today = new Date().toISOString().split('T')[0];
            document.getElementsByName("date_ini")[0].setAttribute('min', today);
            document.getElementsByName("date_fin")[0].setAttribute('min', today);
        }
    </script>
    
    <!--Filtramos la fecha de salida una vez escojamos la fecha de entrada
    1. Evitamos fecha de salida previa a la de entrada.
    2. Establecemos una fecha de salida maxima segun el [RN-6].
    -->
    <script>
      function changeDate(){
        var min_date = document.getElementById("date_ini").value;
        //Maximo tiempo de alquiler es 1 mes(30 dias) [RN-6]
        var date = new Date(min_date);
        date.setDate(date.getDate() + 30);
        //Formato correcto
        var max_date = date.toISOString().substring(0,10);

        document.getElementsByName("date_fin")[0].setAttribute('min', min_date);
        document.getElementsByName("date_fin")[0].setAttribute('max', max_date);
      }
    </script>

</body>
</html>