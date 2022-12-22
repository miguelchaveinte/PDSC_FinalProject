/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

//Filtro de fechas, evitar fechas previas al dia actual----------------->
window.onload=function(){
    var today = new Date().toISOString().split('T')[0];
    document.getElementsByName("date_fin")[0].setAttribute('min', today);
};


function tarjeta(){
     //Obtenemos el numero del boton que se ha pulsado y lo metemos en el input hidden
     var fila = event.target.parentNode.parentNode;
     var numFila = fila.rowIndex - 1;
     document.getElementById("botpulsado").value=numFila;

     //Mostramos la tarjeta con valores por defecto y con el nombre del alojamiento como t?tulo
     document.getElementById('id03').style.display='block';
     document.getElementById('erro1').style.display='none';
     document.getElementById("noche").value = "";
     document.getElementById("finde").value = "";
     document.getElementById("semana").value = "";
     document.getElementById("mes").value = "";
     document.getElementById("date_fin").value = 00/00/0000;
     document.getElementById("miEncabezado").innerHTML = document.getElementById(numFila).textContent;   
 }


function comprobaciones(){
    //Obtenemos como enteros los precios que ha introducido el usuario
    var noche = parseInt(document.getElementById("noche").value);
    var finsemana = parseInt(document.getElementById("finde").value);
    var semana = parseInt(document.getElementById("semana").value);
    var mes = parseInt(document.getElementById("mes").value);

    console.log(noche);
    //Hacemos las comprobaciones pertinentes y, en caso de que los datos no sean correctos, se muestra un mensaje para que el usuario corrija lo que ha metido mal
    if(noche <= 0 || finsemana <=0 || semana <=0 || mes <=0){
        document.getElementById('erro1').style.display='block'; 
        document.getElementById('erro1').innerHTML="Los precios introducidos han de ser valores positivos";
        event.preventDefault();return false;
    }else if(noche >= finsemana || noche >= semana || noche >= mes || finsemana >= semana || finsemana >= mes || semana >= mes){
        document.getElementById('erro1').style.display='block'; 
        document.getElementById('erro1').innerHTML="Los precios introducidos tienen que ser correctos, para ello el precio ha de ser incremental, noche mas barato que fin de semana y asi sucecivamente";
        event.preventDefault();return false;
    }else if(isNaN(noche) || isNaN(semana) || isNaN(mes) || isNaN(finsemana)){
        document.getElementById('erro1').style.display='block'; 
        document.getElementById('erro1').innerHTML="Los precios introducidos no pueden estar vacios";
        event.preventDefault();return false;
    }else{
        //Si el usuerio ha metido bien los datos, procedemos a derivar al servlet
        var date_fin = $("#date_fin").val();
        var botpulsado = $("#botpulsado").val();
        var resultado=new XMLHttpRequest();
        resultado= $.ajax({
            type: 'POST',
            url: 'http://localhost:8080/PDSC/ActualizaPreciosServlet',
            data: {"noche": noche,"finde": finsemana, "semana": semana,"mes": mes,"date_fin":date_fin,"botpulsado":botpulsado},
            dataType: "text",
            async: false,
            success: function( datos ) {
                return datos;
            }
        });

        //Tenemos que volver a setear el array de alojamientos para bajarle desde el servlet
        window.location.href= 'http://localhost:8080/PDSC/registrar.jsp';
        return false;
    }
}
