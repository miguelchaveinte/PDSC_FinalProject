/*
CREATE DATABASE db_VacationAsHome;
USE db_VacationAsHome;

BORRAR TABLAS */

DROP TABLE IF EXISTS
FOTO,
PRECIO,
IDIOMA,
RESERVA,
VALORACION,
CARACTERISTICA,
SERVICIO,
ALOJAMIENTO,
ANFITRION,
USUARIOREGISTRADO,
IDIOMAANFITRION,
CLIENTE;

/* Cliente forma parte de Generalizacion */
/* DROP TABLE CLIENTE */

/* ELIMINACION DE LAS ENUMS */

/*REVISAR LO DE LOS AUTO_INCREMENT*/

/*Cualquier usuario registrado es un cliente o un anfitrión*/
CREATE TABLE USUARIOREGISTRADO(
    id                     INTEGER AUTO_INCREMENT,
    rol                    ENUM('cliente','anfitrion') NOT NULL,
    email                  VARCHAR (50) NOT NULL,
    fechaDeSuscripcion     DATE,
    contrasena             VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE CLIENTE(
    idCliente          INTEGER NOT NULL,
    Primary key(idCliente),
    foreign Key (idCliente) REFERENCES USUARIOREGISTRADO(id)
);

CREATE TABLE ANFITRION(
    idAnfitrion             INTEGER NOT NULL,
    nombre                  VARCHAR(50) NOT NULL,
    identidadVerificada     BOOLEAN NOT NULL,
    esSuperAnfitrion        BOOLEAN NOT NULL,
    ratioRespuestas         INTEGER,
    tiempoMedioRespuesta    INTEGER,  /*float????*/
    primary key(idAnfitrion),
    foreign key(idAnfitrion) references USUARIOREGISTRADO(id)
);

CREATE TABLE FOTO(
    etiqueta                VARCHAR(50),
    imagen                  VARCHAR(250),					/*Cuidao con el tipo-> TIPO BLOB*/
    primary key(imagen)
    /*Le meteremos el id Alojamiento despues con alter table*/
);

CREATE TABLE PRECIO(
    idPrecio                INTEGER AUTO_INCREMENT,
    precioNoche             FLOAT NOT NULL,
    precioFinDeSemana       FLOAT NOT NULL,
    precioSemana            FLOAT NOT NULL,
    precioMes               FLOAT NOT NULL,
    fechaInicio             DATE NOT NULL,
    fechaFin                DATE NOT NULL,
    primary key(idPrecio)
    /*Le meteremos el idAlojamiento despues con alter Table  foreign key(id_Alojamiento) references ALOJAMIENTO*/
   
);

CREATE TABLE ALOJAMIENTO(
    idAlojamiento           INTEGER AUTO_INCREMENT,
    idAnfitrion             INTEGER NOT NULL,
    idFotoPortada           VARCHAR(250),
    idPrecioActual          INTEGER NOT NULL,
    fechaEntradaEnSimpleBnB DATE NOT NULL,
    nombre                  VARCHAR(50) NOT NULL,
    maximoHuespedes         INTEGER NOT NULL,
    numeroDormitorios       INTEGER NOT NULL,
    numeroCamas             INTEGER NOT NULL,
    numeroBanos             INTEGER NOT NULL,
    ubicacionDescrita       VARCHAR(50) NOT NULL,

    /* ubicacion exacta referencia a una cordenada --> sustituimos esto por los 2 atributos */
    longitud                FLOAT NOT NULL,
    latitud                 FLOAT NOT NULL,
    reservaRequiereAceptacionPropietario BOOLEAN NOT NULL,
    localidad               VARCHAR(50),
    primary key(idAlojamiento),
    foreign key(idAnfitrion) references ANFITRION(idAnfitrion),
    foreign key(idFotoPortada) references FOTO(imagen),
    foreign key(idPrecioActual) references PRECIO(idPrecio)
);

/* Añado relaciones entre tablas */
ALTER TABLE FOTO ADD COLUMN idAlojamiento INTEGER REFERENCES ALOJAMIENTO(idAlojamiento);
ALTER TABLE PRECIO ADD COLUMN idAlojamiento INTEGER REFERENCES ALOJAMIENTO(idAlojamiento);

CREATE TABLE RESERVA(
    idUsuario               INTEGER NOT NULL,
    idAlojamiento           INTEGER NOT NULL,
    fechaEntrada            DATE NOT NULL,
    fechaSalida             DATE NOT NULL,
    numeroHuespedes         INTEGER  NOT NULL,
    comentariosAdicionales  VARCHAR(50),
    estado                  ENUM('realizada','aceptadaPorElAnfitrion','confirmada','pagada','canceladaPorCliente','canceladaPorAnfitrion','ejecutada','cancelacionPorFuerzaMayor') not null,
    divideElPago            BOOLEAN NOT NULL,
    primary key(idAlojamiento, fechaEntrada),
    foreign Key (idUsuario) REFERENCES CLIENTE (idCliente),
    foreign key(idAlojamiento) references ALOJAMIENTO(idAlojamiento)
);


/* LOS IDIOMAS DE UN ANFITRION VAN CON FORANEAS */
CREATE TABLE IDIOMA(
    nombre                 VARCHAR(50) NOT NULL UNIQUE,
    abreviatura            VARCHAR(50),
    primary key(abreviatura)
);

CREATE TABLE IDIOMAANFITRION(
    idUsuario           INTEGER NOT NULL,
    abreviatura         VARCHAR(50),
    PRIMARY KEY (idUsuario, abreviatura),
    foreign Key (idUsuario) REFERENCES ANFITRION(idAnfitrion),
    foreign Key (abreviatura) REFERENCES IDIOMA(abreviatura)
);


CREATE TABLE VALORACION(
    idValoracion           INTEGER AUTO_INCREMENT,
    idAlojamiento          INTEGER NOT NULL,
    limpieza               INTEGER,
    llegada                INTEGER,
    calidad                INTEGER,
    comunicacion           INTEGER,
    comentario             VARCHAR(50),
    primary key(idValoracion),
    foreign key(idAlojamiento) references ALOJAMIENTO(idAlojamiento)
);


CREATE TABLE SERVICIO(
    idAlojamiento           INTEGER NOT NULL,
    servicio                ENUM('con cocina','lavavajillas','lavadora','wifi','aparcamiento privada','calefaccion','aire acondicionado','admite mascota') NOT NULL,
    primary key(idAlojamiento, servicio),
    foreign key(idAlojamiento) references ALOJAMIENTO(idAlojamiento)
);

CREATE TABLE CARACTERISTICA(
    idAlojamiento           INTEGER NOT NULL,
    caracteristica          ENUM('cabana','apartamento','casa','castillo','molino','barco','granja','singular','primera linea de playa','a pie de pista','con piscina','en la montana','deluxe') NOT NULL,
    primary key(idAlojamiento, caracteristica),
    foreign key(idAlojamiento) references ALOJAMIENTO(idAlojamiento)
  );



/* INSERTS */
/* POBLACIÓN BASE DE DATOS */


/*Modificado con el insert de los roles*/
INSERT INTO USUARIOREGISTRADO VALUES (1,'anfitrion',"manolo@gmail.com","2022-11-04","1234");
/*INSERT INTO USUARIOREGISTRADO VALUES (1,'cliente',"manolo@gmail.com","2022-11-04","1234");*/
INSERT INTO USUARIOREGISTRADO VALUES (2,'cliente',"carlos@gmail.com","2022-11-15","abc");
INSERT INTO USUARIOREGISTRADO VALUES (3,'cliente',"prueba@gmail.com","2022-11-17","1234");
INSERT INTO USUARIOREGISTRADO VALUES (4,'anfitrion',"toribio@gmail.com","2022-12-02","toribio");

INSERT INTO CLIENTE VALUES (2);
INSERT INTO CLIENTE VALUES (3);
INSERT INTO CLIENTE VALUES (1);

INSERT INTO ANFITRION VALUES (1,"manolo",TRUE,TRUE,4,5);
INSERT INTO ANFITRION VALUES (4,"hector",FALSE,TRUE,5,4);

INSERT INTO PRECIO VALUES (1,70.0,200.0,500.0,3000.0,"2022-11-15","2022-12-31",1);
INSERT INTO PRECIO VALUES (2,56.0,180.0,530.0,3200.0,"2022-10-12","2022-12-16",1);
INSERT INTO PRECIO VALUES (3,62.0,140.0,480.0,2900.0,"2022-7-10","2022-12-31",2);
INSERT INTO PRECIO VALUES (4,62.0,140.0,480.0,2920.0,"2022-10-10","2022-12-31",2);
INSERT INTO PRECIO VALUES (5,42.0,120.0,350.0,2200.0,"2022-7-10","2022-12-31",1);
INSERT INTO PRECIO VALUES (6,73.0,210.0,520.0,3500.0,"2022-11-10","2022-12-29",2);
INSERT INTO PRECIO VALUES (7,32.0,100.0,240.0,1900.0,"2022-7-10","2022-12-31",2);
INSERT INTO PRECIO VALUES (8,67.0,190.0,420.0,2670.0,"2022-9-25","2022-12-31",1);
INSERT INTO PRECIO VALUES (9,102.0,340.0,780.0,3900.0,"2022-7-10","2022-12-31",1);
INSERT INTO PRECIO VALUES (10,62.0,140.0,420.0,2910.0,"2022-11-10","2022-12-30",2);

INSERT INTO FOTO VALUES ("etiqueta", "Imgs_Alojamientos/casapedro.jpeg",1);
INSERT INTO FOTO VALUES ("etiqueta", "Imgs_Alojamientos/casacaminoreal.jpg",2);
INSERT INTO FOTO VALUES ("etiqueta", "Imgs_Alojamientos/casaazul.jpeg",3);
INSERT INTO FOTO VALUES ("etiqueta", "Imgs_Alojamientos/casamonasterio.jpeg",4);
INSERT INTO FOTO VALUES ("etiqueta", "Imgs_Alojamientos/casatorreon.jpeg",5);
INSERT INTO FOTO VALUES ("etiqueta", "Imgs_Alojamientos/granjapaco.jpg",6);
INSERT INTO FOTO VALUES ("etiqueta", "Imgs_Alojamientos/casamartin.jpg",7);
INSERT INTO FOTO VALUES ("etiqueta", "Imgs_Alojamientos/casaporeltejado.jpg",8);
INSERT INTO FOTO VALUES ("etiqueta", "Imgs_Alojamientos/casaparda.jpg",9);
INSERT INTO FOTO VALUES ("etiqueta", "Imgs_Alojamientos/casaacogedora.jpg",10);


INSERT INTO ALOJAMIENTO VALUES (1,1,"Imgs_Alojamientos/casapedro.jpeg",1,"2022-07-30",'Casa Pedro',10,4,7,3,'Apartamento acogedor y amplio',10.35,50.36,FALSE,"Peñafiel");
INSERT INTO ALOJAMIENTO VALUES (2,4,"Imgs_Alojamientos/casacaminoreal.jpg",2,"2022-07-22",'Casa Camino Real',20,6,14,6,'Estancia muy apmlia y con buenas vistas',18.35,20.36,FALSE,"Boecillo");
INSERT INTO ALOJAMIENTO VALUES (3,4,"Imgs_Alojamientos/casaazul.jpeg",3,"2022-08-03",'Casa Azul',5,2,4,1,'Pequeña y acogedora',19.35,112.36,FALSE,"Aldeamayor de San Martín");
INSERT INTO ALOJAMIENTO VALUES (4,1,"Imgs_Alojamientos/casamonasterio.jpeg",4,"2022-11-11",'Casa monasterio',8,4,4,3,'Vintage y clásico',59.35,12.36,FALSE,"Campaspero");
INSERT INTO ALOJAMIENTO VALUES (5,1,"Imgs_Alojamientos/casatorreon.jpeg",5,"2022-09-14",'Casa torreón',12,6,6,3,'Buenas vistas del pueblo',18.35,111.36,FALSE,"Aldeamayor de San Martín");
INSERT INTO ALOJAMIENTO VALUES (6,4,"Imgs_Alojamientos/granjapaco.jpg",6,"2022-10-30",'Granja de Paco',17,2,10,2,'Jardín muy amplio',25.35,82.36,FALSE,"Valladolid");
INSERT INTO ALOJAMIENTO VALUES (7,1,"Imgs_Alojamientos/casamartin.jpg",7,"2022-10-25",'Casa Martin',2,1,1,1,'Acogedor',26.35,62.36,TRUE,"Laguna de Duero");
INSERT INTO ALOJAMIENTO VALUES (8,4,"Imgs_Alojamientos/casaporeltejado.jpg",8,"2022-08-31",'Casa por el tejado',4,2,2,1,'Centrico',23.35,84.36,FALSE,"Valladolid");
INSERT INTO ALOJAMIENTO VALUES (9,4,"Imgs_Alojamientos/casaparda.jpg",9,"2022-12-30",'Casa Parda',7,4,7,3,'A las afueras de la ciudad',35.35,12.36,FALSE,"Viana de Cega");
INSERT INTO ALOJAMIENTO VALUES (10,4,"Imgs_Alojamientos/casaacogedora.jpg",10,"2022-07-28",'Casa acogedora',4,4,4,2,'Rústica',85.75,82.26,FALSE,"Valoria la Buena");

INSERT INTO RESERVA VALUES (2,3,"2022-12-4","2022-12-10",2,"Necesitamos una cama doble","realizada",TRUE);
INSERT INTO RESERVA VALUES (1,4,"2022-12-10","2022-12-20",6,"","pagada",FALSE);
INSERT INTO RESERVA VALUES (2,5,"2022-11-12","2022-11-24",4,"","canceladaPorCliente",FALSE);
INSERT INTO RESERVA VALUES (3,6,"2022-11-13","2022-11-15",6,"","ejecutada",FALSE);
INSERT INTO RESERVA VALUES (2,3,"2022-12-20","2022-12-25",2,"","cancelacionPorFuerzaMayor",TRUE);
INSERT INTO RESERVA VALUES (3,7,"2022-10-20","2022-10-25",3,"¿Podemos ir con niños pequeños?","canceladaPorAnfitrion",FALSE);
INSERT INTO RESERVA VALUES (2,7,"2022-12-20","2022-12-30",8,"Necesitariamos entrar antes de las 14:00","confirmada",TRUE);

INSERT INTO IDIOMA VALUES ('Español','ESP');
INSERT INTO IDIOMA VALUES ('Francés','FR');
INSERT INTO IDIOMA VALUES ('Italiano','ITL');
INSERT INTO IDIOMA VALUES ('Portugues','PGS');

INSERT INTO IDIOMAANFITRION VALUES (1,'ESP');
INSERT INTO IDIOMAANFITRION VALUES (1,'FR');
INSERT INTO IDIOMAANFITRION VALUES (4,'ESP');
INSERT INTO IDIOMAANFITRION VALUES (4,'ITL');
INSERT INTO IDIOMAANFITRION VALUES (4,'PGS');

INSERT INTO VALORACION VALUES (1,1,3,3,4,3,'Recomendable para un fin de semana.');
INSERT INTO VALORACION VALUES (2,10,4,5,4,4,'Muy contentos con la experiencia');
INSERT INTO VALORACION VALUES (3,4,1,2,3,1,'Falta bastante limpieza');
INSERT INTO VALORACION VALUES (4,5,3,5,4,2,"");
INSERT INTO VALORACION VALUES (5,1,2,3,4,3,'Recomendable para unas vacaciones con la familia.');
INSERT INTO VALORACION VALUES (6,2,5,5,2,4,'Muy contentos con la experiencia, todo perfecto');
INSERT INTO VALORACION VALUES (7,3,5,5,5,1,'Todo bastante limpio y buena confianza');
INSERT INTO VALORACION VALUES (8,6,2,5,2,1,"");
INSERT INTO VALORACION VALUES (9,7,2,2,4,3,'Recomendable para un fin de semana.');
INSERT INTO VALORACION VALUES (10,8,4,5,5,4,'Muy contentos con la experiencia');
INSERT INTO VALORACION VALUES (11,9,1,2,3,2,'Falta bastante limpieza');
INSERT INTO VALORACION VALUES (12,10,3,3,1,1,'Pesimo no volveria');

/* AÑADIMOS EL CAMPO VALORACION GLOBAL QUE SE CALCULA A PARTIR DE LOS OTROS 4 CAMPOS */
ALTER TABLE VALORACION ADD COLUMN globalValoracion DECIMAL(10,2) AS ((limpieza + llegada + calidad + comunicacion) / 4);

INSERT INTO SERVICIO VALUES (1,'con cocina');
INSERT INTO SERVICIO VALUES (1,'wifi');
INSERT INTO SERVICIO VALUES (1,'admite mascota');
INSERT INTO SERVICIO VALUES (2,'lavavajillas');
INSERT INTO SERVICIO VALUES (3,'aparcamiento privada');
INSERT INTO SERVICIO VALUES (3,'aire acondicionado');
INSERT INTO SERVICIO VALUES (4,'calefaccion');
INSERT INTO SERVICIO VALUES (4,'lavadora');
INSERT INTO SERVICIO VALUES (5,'wifi');
INSERT INTO SERVICIO VALUES (6,'con cocina');
INSERT INTO SERVICIO VALUES (7,'wifi');
INSERT INTO SERVICIO VALUES (7,'calefaccion');
INSERT INTO SERVICIO VALUES (8,'con cocina');
INSERT INTO SERVICIO VALUES (9,'lavavajillas');
INSERT INTO SERVICIO VALUES (10,'aparcamiento privada');

INSERT INTO CARACTERISTICA VALUES (1,'apartamento');
INSERT INTO CARACTERISTICA VALUES (1,'deluxe');
INSERT INTO CARACTERISTICA VALUES (1,'singular');
INSERT INTO CARACTERISTICA VALUES (2,'castillo');
INSERT INTO CARACTERISTICA VALUES (3,'casa');
INSERT INTO CARACTERISTICA VALUES (4,'singular');
INSERT INTO CARACTERISTICA VALUES (5,'castillo');
INSERT INTO CARACTERISTICA VALUES (5,'deluxe');
INSERT INTO CARACTERISTICA VALUES (5,'en la montana');
INSERT INTO CARACTERISTICA VALUES (6,'granja');
INSERT INTO CARACTERISTICA VALUES (7,'con piscina');
INSERT INTO CARACTERISTICA VALUES (8,'a pie de pista');
INSERT INTO CARACTERISTICA VALUES (9,'en la montaña');
INSERT INTO CARACTERISTICA VALUES (10,'deluxe');