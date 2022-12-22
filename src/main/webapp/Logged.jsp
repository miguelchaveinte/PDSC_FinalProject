<%-- 
    Document   : Logged
    Created on : 17-dic-2022, 17:17:14
    Author     : Jhon
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="Utils.UsuarioRegistrado"%>

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
    <script src="https://kit.fontawesome.com/c4254e24a8.js" crossorigin="anonymous"></script>
</head>


<body>
    <div id="header">
        <div class="container">
            
            <!-- Comprobamos la cabecera correspondiente -->
            <c:set var = "rol" value = "<%=usuario.getRol()%>"/>
            <c:if test="${rol=='anfitrion'}">
                <%@include file="./Anfitrion_Header.jsp" %>
            </c:if>
            
            <c:if test="${rol=='cliente'}">
                <%@include file="./Cliente_Header.jsp" %>
            </c:if>
            
            <div style="width: 40%; float: left;">
                <div class="header-text">
                    <h1>VacationAsHome</h1>
                    <br>
                    <p>Un mundo ideal.<br>Aunque sólo sea por una noche.
                    <br><br>The dream of your dreams</p>
                </div>
            </div>

            <div style="width: 50%; float: right;">
                <img src="./Imgs_Alojamientos/img_principal.jpg" alt="VacationAsHome" width="550" height="450">
            </div>
                     

        </div>
    </div>

</body>
</html>