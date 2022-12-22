/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Utils;

import java.util.Date;

/**
 *
 * @author Jhon
 */
public class Reserva {
    private int idUsuario;
    private int idAlojamiento;
    private Date fechaEntrada;
    private Date fechaSalida;  
    private int numeroHuespedes;
    private String comentariosAdicionales;
    private String estado;
    private Boolean divideElPago;


    public Reserva (){
    idUsuario = 0;
    idAlojamiento = 0;
    fechaEntrada = null;
    fechaSalida =  null;
    numeroHuespedes = 0;
    comentariosAdicionales = "";
    estado = "";
    divideElPago = null;
}

    public Reserva (int idUsuario, int idAlojamiento, Date fechaEntrada, Date fechaSalida, int numeroHuespedes, String comentariosAdicionales, String estado, Boolean divideElPago){
        setIdUsuario(idUsuario);
        setIdAlojamiento(idAlojamiento);
        setFechaEntrada(fechaEntrada);
        setFechaSalida(fechaSalida);
        setNumeroHuespedes(numeroHuespedes);
        setComentariosAdicionales(comentariosAdicionales);
        setEstado(estado);
        setDivideElPago(divideElPago);
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public int getIdAlojamiento() {
        return idAlojamiento;
    }

    public void setIdAlojamiento(int idAlojamiento) {
        this.idAlojamiento = idAlojamiento;
    }

    public Date getFechaEntrada() {
        return fechaEntrada;
    }

    public void setFechaEntrada(Date fechaEntrada) {
        this.fechaEntrada = fechaEntrada;
    }

    public Date getFechaSalida() {
        return fechaSalida;
    }

    public void setFechaSalida(Date fechaSalida) {
        this.fechaSalida = fechaSalida;
    }

    public int getNumeroHuespedes() {
        return numeroHuespedes;
    }

    public void setNumeroHuespedes(int numeroHuespedes) {
        this.numeroHuespedes = numeroHuespedes;
    }

    public String getComentariosAdicionales() {
        return comentariosAdicionales;
    }

    public void setComentariosAdicionales(String comentariosAdicionales) {
        this.comentariosAdicionales = comentariosAdicionales;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public Boolean getDivideElPago() {
        return divideElPago;
    }

    public void setDivideElPago(Boolean divideElPago) {
        this.divideElPago = divideElPago;
    }
    
}
