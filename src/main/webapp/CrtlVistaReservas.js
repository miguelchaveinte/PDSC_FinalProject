/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

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

 //Comprobamos que la localidad sea correcta
function checkLocalidad(){
    //Obtenemos el valor de la localidad seleccionada
    let x = document.forms["myForm"]["myLocalidad"].value;
    if (!(localidades.includes(x))) {
      alert("Introduzca una localidad válida");
      return false;
    }
}

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


//Filtro de fechas, evitar fechas previas al dia actual
//Sera necesaria unicamente para la ventana de informacion de alojamientos
window.onload=function(){
    var today = new Date().toISOString().split('T')[0];
    document.getElementsByName("date_ini")[0].setAttribute('min', today);
    document.getElementsByName("date_fin")[0].setAttribute('min', today);
};


function confirmReserva(){   
    // Get the text from the two inputs.   
    var idAlojamiento = '<%=alojamiento.getIdAlojamiento()%>';
    var fecha_ini = $("#date_ini").val();
    var fecha_fin = $("#date_fin").val();
    var huespedes = '<%=alojamiento.getMaximoHuespedes()%>';
    var message = $("#biografia").val();
    var estado = 'realizada';
    var pago_fraccionado = document.getElementById("pago");
    var pulsado = false;
    if (pago_fraccionado.checked){
        pulsado = true;
    } else{
        pulsado = false;
    }

    var resultado=new XMLHttpRequest();

    // Ajax POST request.
    resultado= $.ajax({
        type: 'POST',
        url: 'http://localhost:8080/PDSC/ConfirmarReservaServlet',
        data: {"idAlojamiento": idAlojamiento, "date_ini": fecha_ini,"date_fin": fecha_fin, "huespedes":huespedes, "biografia":message, "pago":pulsado, "estado":estado},
        dataType: "text",
         async: false,
        success: function( datos ) {
            return datos;
        }
    });
    
    console.log(resultado.responseText);

    if(resultado.responseText=="Lo sentimos, el alojamiento esta reservado en esas fechas\r\n") {
        document.getElementById('erro1').style.display="block"; 
        document.getElementById('erro1').innerHTML="Lo sentimos, el alojamiento esta reservado en esas fechas";
        event.preventDefault();
        return false;
    } else if(resultado.responseText=="Lo sentimos, el anfitrion no puede realizar reservas\r\n") {
        document.getElementById('erro1').style.display="block"; 
        document.getElementById('erro1').innerHTML="Lo sentimos, el anfitrion no puede realizar reservas";
        event.preventDefault();
        return false;
    } else if(resultado.responseText=="Lo sentimos, el mensaje para el anfitrion no puede estar vacio\r\n") {
        document.getElementById('erro1').style.display="block"; 
        document.getElementById('erro1').innerHTML="Lo sentimos, el mensaje para el anfitrion no puede estar vacio";
        event.preventDefault();
        return false;
    } else {
        //Meter mensaje oculto y mostrar cuando reserve (display="block")
        
        document.getElementById('id02').style.display='none';
        
        //Mostrar el mensaje de confirmacion en el jsp de info alojamiento
        var elem = document.querySelector('.reservaComplete');
        elem.style.display = 'block';
        document.getElementById('reservaComplete').style.display="block";
        
        event.preventDefault();
        return false;
    }
}