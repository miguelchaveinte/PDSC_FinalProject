/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Utils;

import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author Jhon
 */
public class Alojamiento {

    private int idAlojamiento;
    private int idAnfitrion;
    private String idFotoPortada;
    private Precio idPrecioActual;
    private Date fechaEntradaEnSimpleBnB;
    private String nombre;
    private int maximoHuespedes;
    private int numeroDormitorios;
    private int numeroCamas;
    private int numeroBanos;
    private String ubicacionDescrita;
    private float longitud;
    private float latitud;
    private Boolean reservaRequiereAceptacionPropietario;
    private String localidad;
    private double valoracion;
    private ArrayList<String> servicios;
    private ArrayList<String> caracteristicas;

    public Alojamiento(){
        idAlojamiento = 0;
        idAnfitrion = 0;
        idFotoPortada = "";
        idPrecioActual = new Precio();
        fechaEntradaEnSimpleBnB = null;
        nombre = "";
        maximoHuespedes = 0;
        numeroDormitorios = 0;
        numeroCamas = 0;
        numeroBanos = 0;
        ubicacionDescrita = "";
        longitud = 0;
        latitud = 0;
        reservaRequiereAceptacionPropietario = false;
        localidad = "";
        valoracion = 0;
        servicios = new ArrayList<String>();
        caracteristicas = new ArrayList<String>();
    }

    public Alojamiento(int idAlojamiento, int idAnfitrion, String idFotoPortada, Precio idPrecioActual, Date fechaEntradaEnSimpleBnB, String nombre, int maximoHuespedes, int numeroDormitorios, int numeroCamas, int numeroBanos, String ubicacionDescrita, float longitud, float latitud, Boolean reservaRequiereAceptacionPropietario, String localidad, double valoracion, ArrayList<String> servicios, ArrayList<String> caracteristicas){
        
        setFechaEntradaEnSimpleBnB(fechaEntradaEnSimpleBnB);
        setIdAlojamiento(idAlojamiento);
        setIdAnfitrion(idAnfitrion);
        setIdFotoPortada(idFotoPortada);
        setIdPrecioActual(idPrecioActual);
        setLatitud(latitud);
        setLocalidad(localidad);
        setLongitud(longitud);
        setMaximoHuespedes(maximoHuespedes);
        setNombre(nombre);
        setNumeroBanos(numeroBanos);
        setNumeroCamas(numeroCamas);
        setNumeroDormitorios(numeroDormitorios);
        setReservaRequiereAceptacionPropietario(reservaRequiereAceptacionPropietario);
        setUbicacionDescrita(ubicacionDescrita);
        setValoracion(valoracion);
        setServicios(servicios);
        setCaracteristicas(caracteristicas);
    }

    public ArrayList<String> getServicios() {
        return servicios;
    }

    public void setServicios(ArrayList<String> servicios) {
        this.servicios = servicios;
    }

    public ArrayList<String> getCaracteristicas() {
        return caracteristicas;
    }

    public void setCaracteristicas(ArrayList<String> caracteristicas) {
        this.caracteristicas = caracteristicas;
    }

    public double getValoracion() {
        return valoracion;
    }

    public void setValoracion(double valoracion) {
        this.valoracion = valoracion;
    }

    
    public int getIdAlojamiento() {
        return idAlojamiento;
    }

    public void setIdAlojamiento(int idAlojamiento) {
        this.idAlojamiento = idAlojamiento;
    }

    public int getIdAnfitrion() {
        return idAnfitrion;
    }

    public void setIdAnfitrion(int idAnfitrion) {
        this.idAnfitrion = idAnfitrion;
    }

    public String getIdFotoPortada() {
        return idFotoPortada;
    }

    public void setIdFotoPortada(String idFotoPortada) {
        this.idFotoPortada = idFotoPortada;
    }

    public Precio getIdPrecioActual() {
        return idPrecioActual;
    }

    public void setIdPrecioActual(Precio idPrecioActual) {
        this.idPrecioActual = idPrecioActual;
    }

    public Date getFechaEntradaEnSimpleBnB() {
        return fechaEntradaEnSimpleBnB;
    }

    public void setFechaEntradaEnSimpleBnB(Date fechaEntradaEnSimpleBnB) {
        this.fechaEntradaEnSimpleBnB = fechaEntradaEnSimpleBnB;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getMaximoHuespedes() {
        return maximoHuespedes;
    }

    public void setMaximoHuespedes(int maximoHuespedes) {
        this.maximoHuespedes = maximoHuespedes;
    }

    public int getNumeroDormitorios() {
        return numeroDormitorios;
    }

    public void setNumeroDormitorios(int numeroDormitorios) {
        this.numeroDormitorios = numeroDormitorios;
    }

    public int getNumeroCamas() {
        return numeroCamas;
    }

    public void setNumeroCamas(int numeroCamas) {
        this.numeroCamas = numeroCamas;
    }

    public int getNumeroBanos() {
        return numeroBanos;
    }

    public void setNumeroBanos(int numeroBanos) {
        this.numeroBanos = numeroBanos;
    }

    public String getUbicacionDescrita() {
        return ubicacionDescrita;
    }

    public void setUbicacionDescrita(String ubicacionDescrita) {
        this.ubicacionDescrita = ubicacionDescrita;
    }

    public float getLongitud() {
        return longitud;
    }

    public void setLongitud(float longitud) {
        this.longitud = longitud;
    }

    public float getLatitud() {
        return latitud;
    }

    public void setLatitud(float latitud) {
        this.latitud = latitud;
    }

    public Boolean getReservaRequiereAceptacionPropietario() {
        return reservaRequiereAceptacionPropietario;
    }

    public void setReservaRequiereAceptacionPropietario(Boolean reservaRequiereAceptacionPropietario) {
        this.reservaRequiereAceptacionPropietario = reservaRequiereAceptacionPropietario;
    }

    public String getLocalidad() {
        return localidad;
    }

    public void setLocalidad(String localidad) {
        this.localidad = localidad;
    }

}
