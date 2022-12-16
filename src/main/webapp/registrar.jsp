<%@page import="java.util.ArrayList"%>
<%@page import="Modelo.Alojamiento"%>
<!DOCTYPE html>
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
    <div id="header">
        <div class="container">
            <nav>
                <ul id="sidemenu">
                    <!--<img src="icon_vacation.png" alt="VacationAsHome" width="210" height="120">-->
                    <li><a href="disponibles.html">Alojamientos Disponibles</a></li>
                    <li><a href="reserva.html">Reservar Alojamiento</a></li>
                    <li><a href="#">Registrar Nuevos Precios</a></li>
                    <button class="button button1" style="width: auto;">Bienvenido</button>
                </ul>
            </nav>
        
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
                    int tipoerror = (int)request.getAttribute("tipoerror");
                    int idbutton = 0;
                    int idpulsado = 0;
                    if(tipoerror == 1){
            
            %>
            </table>
                    <br>
                    <label id= "error" for="my-select" style="font-size: 24px;">No existen alojamientos disponibles para el municipio y las fechas introducidas</label><!-- comment -->
            <%        
                    }else{
                        for (Alojamiento alojamiento : alojamientos_anfitrion) {
                            
            %>
            <tr>
                        <td><img src="<%= alojamiento.getIdFotoPortada()%>" width="250" height="179"></td>
                        <td><button name = "boton" class="button button1" onclick="funcion()" style="width: auto;">Modificar <br> Precios</button></td>
                        <td><%= alojamiento.getNombre()%></td>
                        <td><%= alojamiento.getLocalidad()%></td>
                        <td><%= alojamiento.getUbicacionDescrita()%></td>
                        <td>Noche: <%= alojamiento.getIdPrecioActual().getPrecioNoche()%>
                            <br>Fin de Semana: <%= alojamiento.getIdPrecioActual().getPrecioFinDeSemana()%>
                            <br>Semana: <%= alojamiento.getIdPrecioActual().getPrecioSemana()%>
                            <br>Mes:<%= alojamiento.getIdPrecioActual().getPrecioMes()%></td>
            </tr>
                    <% 
                        idbutton = idbutton +1;}
                    }%>
        </table>
        <div id = "botpulsado"></div>
        
        <!--Modal-->
        <div id="id03" class="modal">
            <!--Form-->
           
            <form class="modal-content animate" action="/inicio_2.html"> <!--action="/usuarioregistrado.jsp" method="POST"-->
            
                <div class="imgcontainer">
                    <span onclick="document.getElementById('id03').style.display='none'" class="close" title="Close Modal">&times;</span>
                    <img src="./Imgs_Alojamientos/img1.jpeg" alt="Avatar" class="avatar">
                </div>

                <div class="container" style="padding: 16px">
                    <h1 id = 'miEncabezado'></h1>
                        <br>

                    <!-- Noche -->
                    <p>
                        <label for="noche"><b>Precio por noche:</b></label>
                        <!--<input type="text" placeholder="70?" name="noche"><br>-->
                        <input type="number" value="70" id = 'Noche'><br><br>
                    </p>

                    <!-- Finde -->
                    <p>
                        <label for="finde"><b>Precio fin de semana:</b></label>
                        <!--<input type="text" placeholder="200?" name="finde"><br>-->
                        <input type="number" value="200" id = 'FinSemana'><br><br>
                    </p>

                    <!-- Semana -->
                    <p>
                        <label for="semana"><b>Precio una semana:</b></label>
                        <!--<input type="text" placeholder="500?" name="semana"><br>-->
                        <input type="number" value="500" id = 'Semana'><br><br>
                    </p>

                    <!-- Mes -->
                    <p>
                        <label for="mes"><b>Precio por mes:</b></label>
                        <!--<input type="text" placeholder="3000?" name="mes"><br>-->
                        <input type="number" value="3000" id = 'Mes'><br><br>
                    </p>

                    <!--Fin Vigencia-->
                    <label for="date_fin" style="font-size: 24px;">Fecha de fin de vigencia: </label>
                    <input type="date" id="date_fin" name="date_fin">
                    <br><br>
                    
                    <!-- Submit Button -->
                    <button type="submit">Guardar Tarjeta</button>

                </div>
            </form>
            
        </div>
        


        </div>
    </div>
    
    <!-----------------Filtro de fechas, evitar fechas previas al dia actual----------------->
    <script type="text/javascript">
        window.onload=function(){
            var today = new Date().toISOString().split('T')[0];
            document.getElementsByName("date_fin")[0].setAttribute('min', today);
        }
        
        function funcion(){
            
            var fila = event.target.parentNode.parentNode;
            var numFila = fila.rowIndex - 1;
            document.getElementById("botpulsado").innerHTML=numFila;

    </script>
    
</body>
</html>