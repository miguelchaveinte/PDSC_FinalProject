/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


function compruebaLogin(){
    // Get the text from the two inputs.
    console.log("COSITIIIIS");
    var email = $("#email").val();
    var password = $("#password").val();

    var resultado=new XMLHttpRequest();
    //var emailUser=document.getElementById('email');
    
    

    if(password!="" && email!=""){

        // Ajax POST request.
        resultado= $.ajax({
            type: 'POST',
            url: 'http://localhost:8080/PDSC/RegistroServlet',
            data: {"password": password,"email": email},
            dataType: "text",
             async: false,
            success: function( datos ) {
                return datos;
            }
        });
        
        console.log(resultado.responseText);

        if(resultado.responseText=="El email introducido no existe en la base de datos\r\n") {
            document.getElementById('erro1').style.display="block"; 
            document.getElementById('erro1').innerHTML="El email introducido no existe en la base de datos";
            event.preventDefault();
            return false;
        }else if(resultado.responseText=="La contrasena no se corresponde con el correo introducido\r\n"){
            document.getElementById('erro1').style.display="block"; 
            document.getElementById('erro1').innerHTML="La contraseña no se corresponde con el correo introducido";
            event.preventDefault();
            return false;
        }else {
            window.location.href= 'http://localhost:8080/PDSC/Logged.jsp';
            //return false;
        }
    }
}
