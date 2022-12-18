<%-- 
    Document   : reservas
    Created on : 17-dic-2022, 19:43:54
    Author     : Jhon
--%>

<%@page import="Modelo.UsuarioRegistrado"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Modelo.Alojamiento"%>
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
    <script type="text/javascript" src="localidades_spain.js"></script>
</head>


<body>
    <div id="header">
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
                    <label id= "error" for="my-select" style="font-size: 24px;">No existen alojamientos disponibles para el municipio y las fechas introducidas</label>
               
                        
                    <%        
                        }else{
                            for (Alojamiento alojamiento : alojamientos_disponibles) {
                            
                    %>
                      <tr>
                        <td><%= alojamiento.getNombre() %></td>
                        <td><%= alojamiento.getMaximoHuespedes() %></td>
                        <td><%= alojamiento.getValoracion()%></td>
                        <td><a href="Informacion?idAlojamiento=<%=alojamiento.getIdAlojamiento()%>"> <img src = <%= alojamiento.getIdFotoPortada()%> width="250" height="179"/></a></td>
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
        
        /*initiate the autocomplete function on the "myInput" element, and pass along the countries array as possible autocomplete values:*/
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

    
</body>
</html>
