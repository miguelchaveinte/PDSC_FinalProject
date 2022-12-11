
<%-- 
    Document   : disponibles
    Created on : 08-dic-2022, 1:54:33
    Author     : Jhon
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="Modelo.Alojamiento"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VacationAsHome</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="./font-awesome-4.7.0/css/font-awesome.min.css">
    <script type="text/javascript" src="localidades_spain.js"></script>
</head>


<body>
    <div id="header">
        <div class="container">
            <nav>
                <ul id="sidemenu">
                    <!--<img src="icon_vacation.png" alt="VacationAsHome" width="210" height="120">-->
                    <li><a href="#">Alojamientos Disponibles</a></li>
                    <li><a href="reserva.html">Reservar Alojamiento</a></li>
                    <li><a href="registrar.html">Registrar Nuevos Precios</a></li>
                    <button class="button button1" style="width: auto;">Bienvenido</button>
                </ul>
            </nav>

            <!--------Fechas y Buscador Localidad-------->
            <div style="width: 40%; float: left;">
                <div class="header-text">
                    <h1>VacationAsHome</h1>
                    <br>
                    
                    <!--Make sure the form has the autocomplete function switched off:-->
                    <form autocomplete="off" name="myForm" action="Disponibles" method="GET" onsubmit="return checkLocalidad()">
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
                                System.out.println(localizacion);
                                %>
                            <label for="localidad" style="font-size: 24px;">Localidad</label><br>
                            <input id="myInput" type="text" name="myLocalidad" placeholder=Escribe... required>
                        </div>
                        <br>
                        <input type="submit" class="button button1" value="Buscar">
                    </form>
                    
                </div>
            </div>

            <!--------Tabla de Alojamientos Disponibles-------->
            <div style="width: 55%; float: right;">
                <div class="header-text">
                <!--Select para filtros-->
                <label for="my-select" style="font-size: 24px;">Filtrar por:</label>
                <select id="my-select" onchange="sortTable()">
                    <option>Seleccione</option>
                    <option value="option-1" onclick="">De menor a mayor capacidad</option>
                      <option value="option-2">De mayor a menor capacidad</option>
                      <option value="option-3">De menor a mayor valoración</option>
                      <option value="option-4">De mayor a menor valoración</option>
                </select><br><br>
                <label id= "localidad" for="my-select" style="font-size: 24px;">Localidad: <%= localizacion %></label>
         
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
                    <label id= "error" for="my-select" style="font-size: 24px;">No existen alojamientos disponibles para el municipio y las fechas introducidas</label>
               
                        
                            <%        
                        }else{
                            for (Alojamiento alojamiento : alojamientos_disponibles) {
                            
                    %>
                      <tr>
                        <td><%= alojamiento.getNombre() %></td>
                        <td><%= alojamiento.getMaximoHuespedes() %></td>
                        <td><%= alojamiento.getValoracion()%></td>
                        <td><a href="info_alojamiento.html"> <img src = <%= alojamiento.getIdFotoPortada()%> width="250" height="179"/></a></td>
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
        function autocomplete(inp, arr) {
          /*the autocomplete function takes two arguments,
          the text field element and an array of possible autocompleted values:*/
          var currentFocus;
          /*execute a function when someone writes in the text field:*/
          inp.addEventListener("input", function(e) {
              var a, b, i, val = this.value;
              /*close any already open lists of autocompleted values*/
              closeAllLists();
              if (!val) { return false;}
              currentFocus = -1;
              /*create a DIV element that will contain the items (values):*/
              a = document.createElement("DIV");
              a.setAttribute("id", this.id + "autocomplete-list");
              a.setAttribute("class", "autocomplete-items");
              /*append the DIV element as a child of the autocomplete container:*/
              this.parentNode.appendChild(a);
              /*for each item in the array...*/
              for (i = 0; i < arr.length; i++) {
                /*check if the item starts with the same letters as the text field value:*/
                if (arr[i].substr(0, val.length).toUpperCase() == val.toUpperCase()) {
                  /*create a DIV element for each matching element:*/
                  b = document.createElement("DIV");
                  /*make the matching letters bold:*/
                  b.innerHTML = "<strong>" + arr[i].substr(0, val.length) + "</strong>";
                  b.innerHTML += arr[i].substr(val.length);
                  /*insert a input field that will hold the current array item's value:*/
                  b.innerHTML += "<input type='hidden' value='" + arr[i] + "'>";
                  /*execute a function when someone clicks on the item value (DIV element):*/
                  b.addEventListener("click", function(e) {
                      /*insert the value for the autocomplete text field:*/
                      inp.value = this.getElementsByTagName("input")[0].value;
                      /*close the list of autocompleted values,
                      (or any other open lists of autocompleted values:*/
                      closeAllLists();
                  });
                  a.appendChild(b);
                }
              }
          });
          /*execute a function presses a key on the keyboard:*/
          inp.addEventListener("keydown", function(e) {
              var x = document.getElementById(this.id + "autocomplete-list");
              if (x) x = x.getElementsByTagName("div");
              if (e.keyCode == 40) {
                /*If the arrow DOWN key is pressed,
                increase the currentFocus variable:*/
                currentFocus++;
                /*and and make the current item more visible:*/
                addActive(x);
              } else if (e.keyCode == 38) { //up
                /*If the arrow UP key is pressed,
                decrease the currentFocus variable:*/
                currentFocus--;
                /*and and make the current item more visible:*/
                addActive(x);
              } else if (e.keyCode == 13) {
                /*If the ENTER key is pressed, prevent the form from being submitted,*/
                e.preventDefault();
                if (currentFocus > -1) {
                  /*and simulate a click on the "active" item:*/
                  if (x) x[currentFocus].click();
                }
              }
          });
          function addActive(x) {
            /*a function to classify an item as "active":*/
            if (!x) return false;
            /*start by removing the "active" class on all items:*/
            removeActive(x);
            if (currentFocus >= x.length) currentFocus = 0;
            if (currentFocus < 0) currentFocus = (x.length - 1);
            /*add class "autocomplete-active":*/
            x[currentFocus].classList.add("autocomplete-active");
          }
          function removeActive(x) {
            /*a function to remove the "active" class from all autocomplete items:*/
            for (var i = 0; i < x.length; i++) {
              x[i].classList.remove("autocomplete-active");
            }
          }
          function closeAllLists(elmnt) {
            /*close all autocomplete lists in the document,
            except the one passed as an argument:*/
            var x = document.getElementsByClassName("autocomplete-items");
            for (var i = 0; i < x.length; i++) {
              if (elmnt != x[i] && elmnt != inp) {
                x[i].parentNode.removeChild(x[i]);
              }
            }
          }
          /*execute a function when someone clicks in the document:*/
          document.addEventListener("click", function (e) {
              closeAllLists(e.target);
          });
        }
        
        /*Array que contiene las localidades de España*/
        var local_spain = localidades;
        
        /*initiate the autocomplete function on the "myInput" element, and pass along the locations array as possible autocomplete values:*/
        autocomplete(document.getElementById("myInput"), local_spain);        
        </script>
        
        <!-- Comprobamos que la localidad sea correcta -->
        <script>
            function checkLocalidad(){
                //Obtenemos el valor de la localidad seleccionada
                let x = document.forms["myForm"]["myLocalidad"].value;
                if (!(localidades.includes(x))) {
                  alert("Introduzca una localidad válida");
                  return false;
                }
            }
        </script>

        <!-----------------Filtro de Tablas----------------->
        <script>
        function sortTable() {

          var select = document.getElementById('my-select');
          var selectedOption = select.options[select.selectedIndex].value;
          /*console.log(selectedOption);*/

          var table, rows, switching, i, x, y, shouldSwitch;
          table = document.getElementById("myTable");
          switching = true;
          /*Make a loop that will continue until
          no switching has been done:*/
          while (switching) {
              //start by saying: no switching is done:
              switching = false;
              rows = table.rows;
              /*Loop through all table rows (except the
              first, which contains table headers):*/
              for (i = 1; i < (rows.length - 1); i++) {
                  //start by saying there should be no switching:
                  shouldSwitch = false;
                  /*Get the two elements you want to compare,
                  one from current row and one from the next:*/

                  /*Comprobamos tipo de filtro*/
                  if (selectedOption == "option-1" || selectedOption == "option-2"){
                      /*Filtro por capacidad del alojamiento*/
                      x = rows[i].getElementsByTagName("TD")[1];
                      y = rows[i + 1].getElementsByTagName("TD")[1];

                      //Comprobamos el orden de filtro
                      if (selectedOption == "option-1"){
                          if (parseInt(x.innerHTML,10) > parseInt(y.innerHTML,10)) {
                              //if so, mark as a switch and break the loop:
                              shouldSwitch = true;
                              break;
                          }
                      } else{
                          if (parseInt(x.innerHTML,10) < parseInt(y.innerHTML,10)) {
                              //if so, mark as a switch and break the loop:
                              shouldSwitch = true;
                              break;
                          }
                      }

                  } else{
                      /*Filtro por valoracion del alojamiento*/
                      x = rows[i].getElementsByTagName("TD")[2];
                      y = rows[i + 1].getElementsByTagName("TD")[2];

                      //Comprobamos el orden de filtro
                      if (selectedOption == "option-3"){
                          if (parseFloat(x.innerHTML) > parseFloat(y.innerHTML)) {
                              //if so, mark as a switch and break the loop:
                              shouldSwitch = true;
                              break;
                          }
                      } else if (selectedOption == "option-4"){
                          if (parseFloat(x.innerHTML) < parseFloat(y.innerHTML)) {
                              //if so, mark as a switch and break the loop:
                              shouldSwitch = true;
                              break;
                          }
                      }
                  }
              } /*Fin bucle for*/

              if (shouldSwitch) {
                  /*If a switch has been marked, make the switch
                  and mark that a switch has been done:*/
                  rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                  switching = true;
              }
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
