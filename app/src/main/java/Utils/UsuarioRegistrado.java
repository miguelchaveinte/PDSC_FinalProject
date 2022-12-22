/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Utils;

import java.util.Date;

/**
 *
 * @author hecto
 */
public class UsuarioRegistrado {

    private Integer id;
    private String rol;
    private String email;
    private Date fechaSus;
    private String contrasena;

    public UsuarioRegistrado(){
        id = 0;
        rol = "";
        email = "";
        fechaSus = null;
        contrasena = "";
    }

  
    public UsuarioRegistrado(int id, String rol, String email, Date fechaSus, String contrasena){
        setContraseña(contrasena);
        setRol(rol);
        setEmail(email);
        setFechaSus(fechaSus);
        setId(id);
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    public String getContrasena() {
        return contrasena;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Date getFechaSus() {
        return fechaSus;
    }

    public void setFechaSus(Date fechaSus) {
        this.fechaSus = fechaSus;
    }

    public void setContraseña(String contrasena) {
        this.contrasena = contrasena;
    }
    
}
