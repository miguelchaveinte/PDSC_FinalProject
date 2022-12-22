<%-- 
    Document   : ConfirmarReserva
    Created on : 19-dic-2022, 12:49:30
    Author     : Jhon
--%>

<%@page import="Utils.Alojamiento"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src='https://code.jquery.com/jquery-3.3.1.slim.min.js'></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script type="text/javascript" src="CrtlVistaReservas.js"></script>
                   
<!-- Boton de confirmar Reserva + Modal que estara oculto en funcion del CU -->
<button class="button button1" onclick="document.getElementById('id02').style.display='block'" style="width: auto;">Reservar</button>

<!--Confirmar Reserva-->
<div id="id02" class="modal">
    <!--Form-->
    <form class="modal-content animate">
        <div class="imgcontainer">
            <span onclick="document.getElementById('id02').style.display='none'" class="close" title="Close Modal">&times;</span>
            <img src="./Imgs_Alojamientos/icon_vacation.png" alt="Avatar" class="avatar">
        </div>

        <div class="container" style="padding: 16px">
            <h1 style="font-size: 24px;">Confirmar Reserva</h1>
            <br>

            <div style="width: 40%; float: left;">
                <!--Fecha Inicio-->
                <label for="date_ini" style="font-size: 24px;">Fecha de Entrada</label><br>
                <input type="date" id="date_ini" name="date_ini" onchange="changeDate()" required><br><br>
            </div>

            <div style="width: 40%; float: right;">
                <!--Fecha Fin-->
                <label for="date_fin" style="font-size: 24px;">Fecha de Salida</label><br>
                <input type="date" id="date_fin" name="date_fin" required>                                    
            </div>

            <div style="width: 40%; float: bottom;">
                <!-- Mensaje -->
                <label for="message" style="font-size: 16px;"><b>Mensaje para el anfitrión</b></label><br>
                <textarea class="form-control" rows="5" cols="82" name="biografia" id="biografia" required></textarea><br>

                <!--Pago-->
                <input type="checkbox" id="pago" name="pago"><label for="page" style="font-size: 18px;"><b> Fraccionar Pago</b></label>

            </div>
            
            <h4 id="erro1" style="display: none">Lo sentimos, el alojamiento está reservado en esas fechas</h4>
            
            <!-- Submit Button -->
            <button type="submit" id="submit" onclick="confirmReserva()">Confirmar reserva</button>
        </div>
    </form>
</div>
<!-- Fin del Modal Oculto -->

<script>
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
</script>