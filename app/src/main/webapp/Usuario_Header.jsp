<%-- 
    Document   : UsuarioHeader
    Created on : 21-dic-2022, 18:03:24
    Author     : Jhon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src='https://code.jquery.com/jquery-3.3.1.slim.min.js'></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script type="text/javascript" src="CrtlVistaLogin.js"></script>
    

<nav>
    <ul id="sidemenu">
        <li style="margin: 50px 400px;"><a href="#">Alojamientos Disponibles</a></li>
        <button class="button button1" onclick="document.getElementById('id01').style.display='block'" style="width: auto;">Log In</button>

        <div id="id01" class="modal">
            <!--Form-->
            <form class="modal-content animate" action="RegistroServlet" method="POST">

                <div class="imgcontainer">
                    <span onclick="document.getElementById('id01').style.display='none'" class="close" title="Close Modal">&times;</span>
                    <img src="./Imgs_Alojamientos/icon_vacation.png" alt="Avatar" class="avatar">
                </div>

                <div class="container" style="padding: 16px">

                    <h1>Identificarse</h1>
                        <br><br><br>

                    <!-- Email -->
                    <label for="email"><b>Correo Electrónico</b></label><br>
                    <input type="email" placeholder="Correo Electrónico" name="email" id="email" required><br><br>

                    <!-- Password -->
                    <label for="password"><b>Contraseña</b></label>
                    <input type="password" placeholder="Introduce tu contraseña" name="password" id="password" required><br><br>
                    
                    <h4 id="erro1" style="display: none">El email introducido no existe en la base de datos</h4>

                    <!-- Submit Button -->
                    <button type="submit" id="submit2" onclick="compruebaLogin()">Login</button>

                </div>
            </form>
        </div>
    </ul>
</nav>