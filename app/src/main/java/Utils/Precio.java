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
public class Precio {
    private int idPrecio;
    private float precioNoche;
    private float precioFinDeSemana;
    private float precioSemana;
    private float precioMes;
    private Date fechaInicio;
    private Date fechaFin;
    private int idAlojamiento;
    
    public Precio(){
        precioNoche = 0;
        precioFinDeSemana = 0;
        precioSemana = 0;
        precioMes = 0;
        fechaInicio = null;
        fechaFin = null;
        idAlojamiento = 0;
    }

    public Precio(int idPrecio, float precioNoche, float precioFinDeSemana, float precioSemana, float precioMes, Date fechaInicio, Date fechaFin, int idAlojamiento){
        setIdPrecio(idPrecio);
        setFechaFin(fechaFin);
        setFechaInicio(fechaInicio);
        setIdAlojamiento(idAlojamiento);
        setPrecioSemana(precioSemana);
        setPrecioFinDeSemana(precioFinDeSemana);
        setPrecioMes(precioMes);
        setPrecioNoche(precioNoche);
    }

    public void setIdPrecio(int idPrecio) {
        this.idPrecio = idPrecio;
    }

    public int getIdPrecio() {
        return idPrecio;
    }
    
    public float getPrecioNoche() {
        return precioNoche;
    }

    public void setPrecioNoche(float precioNoche) {
        this.precioNoche = precioNoche;
    }

    public float getPrecioFinDeSemana() {
        return precioFinDeSemana;
    }

    public void setPrecioFinDeSemana(float precioFinDeSemana) {
        this.precioFinDeSemana = precioFinDeSemana;
    }

    public float getPrecioSemana() {
        return precioSemana;
    }

    public void setPrecioSemana(float precioSemana) {
        this.precioSemana = precioSemana;
    }

    public float getPrecioMes() {
        return precioMes;
    }

    public void setPrecioMes(float precioMes) {
        this.precioMes = precioMes;
    }

    public Date getFechaInicio() {
        return fechaInicio;
    }

    public void setFechaInicio(Date fechaInicio) {
        this.fechaInicio = fechaInicio;
    }

    public Date getFechaFin() {
        return fechaFin;
    }

    public void setFechaFin(Date fechaFin) {
        this.fechaFin = fechaFin;
    }

    public int getIdAlojamiento() {
        return idAlojamiento;
    }

    public void setIdAlojamiento(int idAlojamiento) {
        this.idAlojamiento = idAlojamiento;
    }
    
    
}
