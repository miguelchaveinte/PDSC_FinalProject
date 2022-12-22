/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


//Filtro de fechas para evitar fechas previas al dia actual
window.onload=function(){
    var today = new Date().toISOString().split('T')[0];
    document.getElementsByName("date_ini")[0].setAttribute('min', today);
    document.getElementsByName("date_fin")[0].setAttribute('min', today);
};


/*Filtramos la fecha de salida una vez escojamos la fecha de entrada
    1. Evitamos fecha de salida previa a la de entrada.
    2. Establecemos una fecha de salida maxima segun el [RN-6].
*/
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

//Autocompletado del buscador de Localidades
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


//Filtro de Tablas
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


//AJAX correspondiente a DisponiblesView.jsp
function function1(){
    // Get the text from the two inputs.   
    var fecha_ini = $("#date_ini").val();
    var fecha_fin = $("#date_fin").val();
    var localidad = $("#myInput").val();

    var resultado=new XMLHttpRequest();

    if(fecha_ini!="" && fecha_fin!="" && localidad!=""){

        //Check de localidad
        let x = document.forms["myForm"]["myLocalidad"].value;
        if (!(localidades.includes(x))) {
          alert("Introduzca una localidad válida");
          event.preventDefault();
          return false;
        }

       // Ajax POST request.
       resultado= $.ajax({
           type: 'GET',
           url: 'http://localhost:8080/PDSC/DisponiblesServlet',
           data: {"date_ini": fecha_ini, "date_fin": fecha_fin, "myLocalidad": localidad},
           dataType: "text",
            async: false,
           success: function( datos ) {
               return datos;
           }
       });

        if(resultado.responseText=="No existen alojamientos disponibles para el municipio y las fechas introducidas\r\n") {
            if(document.getElementById('myTable') != null){
                
                document.getElementById('myTable').style.display="none";

                // Obtener el elemento a comprobar
                var element = document.getElementById('aqui');

                // Eliminar todos los hijos del elemento
                while (element.firstChild) {
                  element.removeChild(element.firstChild);
                }

                var h4 = document.createElement('h4');
                // Establecer los atributos del elemento h4
                h4.setAttribute('id', 'error1');
                h4.style.display = 'block';
                // Establecer el contenido del elemento h4
                h4.textContent = 'No existen alojamientos disponibles para el municipio y las fechas introducidas';
                // Obtener la tabla a la que se desea agregar el elemento h4
                var container = document.getElementById('aqui');
                // Agregar el elemento h4 a la tabla utilizando appendChild
                container.appendChild(h4);           

                //document.getElementById('erro1').style.display="block";
                //document.getElementById('erro1').innerHTML="No existen alojamientos disponibles para el municipio y las fechas introducidas";

                //event.preventDefault();
                //return false;
            }
            event.preventDefault();
            return false;
            
        }else {
            window.location.href= 'http://localhost:8080/PDSC/disponibles.jsp';
            //window.reload(true);
            //event.preventDefault();
            return false;
        }
    }
}


//AJAX correspondiente a disponibles.jsp
function function2(){
    // Get the text from the two inputs.   
    var fecha_ini = $("#date_ini").val();
    var fecha_fin = $("#date_fin").val();
    var localidad = $("#myInput").val();

    var resultado=new XMLHttpRequest();

    if(fecha_ini!="" && fecha_fin!="" && localidad!=""){

        //Check de localidad
        let x = document.forms["myForm"]["myLocalidad"].value;
        if (!(localidades.includes(x))) {
          alert("Introduzca una localidad válida");
          event.preventDefault();
          return false;
        }

       // Ajax POST request.
       resultado= $.ajax({
           type: 'GET',
           url: 'http://localhost:8080/PDSC/DisponiblesServlet',
           data: {"date_ini": fecha_ini, "date_fin": fecha_fin, "myLocalidad": localidad},
           dataType: "text",
            async: false,
           success: function( datos ) {
               return datos;
           }
       });   

        if(resultado.responseText=="No existen alojamientos disponibles para el municipio y las fechas introducidas\r\n") {
            document.getElementById('myTable').style.display="none";
            document.getElementById('nombreLocalidad').innerHTML=localidad;
            document.getElementById('erro1').style.display="block"; 
            document.getElementById('erro1').innerHTML="No existen alojamientos disponibles para el municipio y las fechas introducidas";
            event.preventDefault();
            return false; 
        }else {
            //window.location.href= 'http://localhost:8080/PDSC/disponibles.jsp';
            window.reload(true);
            //event.preventDefault();
            return false;
        }
    }

}