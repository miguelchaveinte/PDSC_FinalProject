<%-- 
    Document   : inicio_1
    Created on : 10-dic-2022, 13:06:13
    Author     : carlo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VacationAsHome</title>
    <link rel="stylesheet" href="style.css">
    <script src="https://kit.fontawesome.com/c4254e24a8.js" crossorigin="anonymous"></script>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
</head>


<body>
    <div id="header">
        <div class="container">
            <nav>
                <ul id="sidemenu">
                    <li style="margin: 50px 400px;"><a href="disponible_NO_login.html">Alojamientos Disponibles</a></li>
                    <button class="button button1" onclick="document.getElementById('id01').style.display='block'" style="width: auto;">Log In</button>

                    <div id="id01" class="modal">
                        <!--Form-->
                        <form class="modal-content animate"> <!--action="/usuarioregistrado.jsp" method="POST"-->

                            <div class="imgcontainer">
                                <span onclick="document.getElementById('id01').style.display='none'" class="close" title="Close Modal">&times;</span>
                                <img src="icon_vacation.png" alt="Avatar" class="avatar">
                            </div>

                            <div class="container" style="padding: 16px">

                                <h1>Identificarse</h1>
                                    <br><br><br>

                                <!-- Email -->
                                <label for="email"><b>Correo Electrónico</b></label><br>
                                <input type="email" placeholder="Correo Electrónico" name="email" id="email" required><br><br>

                                <!-- Password -->
                                <label for="psw"><b>Contraseña</b></label>
                                <input type="password" placeholder="Introduce tu contraseña" name="psw" id="psw" required><br><br>

                                <h4 class="" id="erro1" style="display:none;">Revisa tus creedenciales</h4>
                                
                                <!-- Submit Button -->
                                <button id="submit1" type="submit">Login</button>

                            </div>
                        </form>
                    </div>

                </ul>
            </nav>

            <div style="width: 40%; float: left;">
                <div class="header-text">
                    <h1>VacationAsHome</h1>
                    <br>
                    <p>Un mundo ideal.<br>Aunque sólo sea por una noche.
                    <br><br>The dream of your dreams</p>
                </div>
            </div>

            <div style="width: 50%; float: right;">
                <img src="img_principal.jpg" alt="VacationAsHome" width="550" height="450">
            </div>
        
        </div>
    </div>


    <!--Script-->
    <script>
        // Get the modal
        var modal = document.getElementById('id01');
        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function(event) {
        if (event.target == modal) {
        modal.style.display = "none";
        }
        }
    </script>
    
    <script>
        $("#submit1").click(function() {
            // Get the text from the two inputs.
            var email = $("#email").val();
            var password = $("#psw").val();

            var resultado=new XMLHttpRequest();
            var emailUser=document.getElementById('email');
            var antiguaUrl= location.href;

        if(password!="" && email!="" && emailUser.checkValidity()){
            // Ajax POST request.
        resultado= $.ajax({
            type: 'POST',
            url: 'http://localhost:8080/PDSC/Registro',
            data: {"password": password,"email": email},
            dataType: "text",
             async: false,
            success: function( datos ) {
                //console.log(username);
                console.log(password);
                console.log(email);
                console.log(datos);
                resultado=datos;
                console.log(resultado);
                //console.log(resultado=="Revisa tus creedenciales");
                //$( "#username1" ).html(datos);*/
                return datos;

            }
        });
        
        if(resultado.responseText=="Revisa tus creedenciales") {
            document.getElementById('erro1').style.display="block"; 
            return false;
        }else {
            window.location.href= antiguaUrl;
            window.location.reload(true); 
            return false;
        }
}
});



    </script>

</body>
</html>
