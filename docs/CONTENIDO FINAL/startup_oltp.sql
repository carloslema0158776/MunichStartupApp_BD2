CREATE SCHEMA IF NOT EXISTS oltp;

-- TABLAS 

CREATE TABLE oltp.persona (
    id_persona INT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    apellido VARCHAR(30) NOT NULL,
    direccion VARCHAR(50),
    email VARCHAR(30),
    telefono INT,
    fecha_nacimiento DATE
);

CREATE TABLE oltp.roles (
    id_rol INT PRIMARY KEY,
    nombre_rol VARCHAR(20) NOT NULL
);

CREATE TABLE oltp.startup (
    id_startup INT PRIMARY KEY,
    nombre_startup VARCHAR(50) NOT NULL,
    ubicacion_startup VARCHAR(50),
    descripcion VARCHAR(100),
    anio_fundacion DATE,
    sitio_web VARCHAR(100),
    estado_startup VARCHAR(100)
);

CREATE TABLE oltp.institucion (
    id_institucion INT PRIMARY KEY,
    nombre_institucion VARCHAR(50) NOT NULL,
    tipo_institucion VARCHAR(50)
);


-- SUBTIPOS DE PERSONA


CREATE TABLE oltp.mentor (
    id_persona INT PRIMARY KEY,
    especialidad VARCHAR(50),
    CONSTRAINT fk_mentor_persona
        FOREIGN KEY (id_persona)
        REFERENCES oltp.persona(id_persona)
);

CREATE TABLE oltp.emprendedor (
    id_persona INT PRIMARY KEY,
    nivel_educacion VARCHAR(30),
    CONSTRAINT fk_emprendedor_persona
        FOREIGN KEY (id_persona)
        REFERENCES oltp.persona(id_persona)
);

CREATE TABLE oltp.inversor (
    id_persona INT PRIMARY KEY,
    tipo_inversor VARCHAR(30),
    CONSTRAINT fk_inversor_persona
        FOREIGN KEY (id_persona)
        REFERENCES oltp.persona(id_persona)
);


-- RELACIONES DE PERSONA


CREATE TABLE oltp.persona_rol (
    id_persona INT NOT NULL,
    id_rol INT NOT NULL,
    fecha_inicio_rol DATE,
    fecha_fin_rol DATE,
    estado VARCHAR(10),
    CONSTRAINT pk_persona_rol
        PRIMARY KEY (id_persona, id_rol),
    CONSTRAINT fk_persona_rol_persona
        FOREIGN KEY (id_persona)
        REFERENCES oltp.persona(id_persona),
    CONSTRAINT fk_persona_rol_rol
        FOREIGN KEY (id_rol)
        REFERENCES oltp.roles(id_rol)
);

CREATE TABLE oltp.persona_institucion (
    id_persona INT NOT NULL,
    id_institucion INT NOT NULL,
    CONSTRAINT pk_persona_institucion
        PRIMARY KEY (id_persona, id_institucion),
    CONSTRAINT fk_persona_institucion_persona
        FOREIGN KEY (id_persona)
        REFERENCES oltp.persona(id_persona),
    CONSTRAINT fk_persona_institucion_institucion
        FOREIGN KEY (id_institucion)
        REFERENCES oltp.institucion(id_institucion)
);


-- RELACIONES DE STARTUP


CREATE TABLE oltp.startup_emprendedor (
    id_startup INT NOT NULL,
    id_persona INT NOT NULL,
    CONSTRAINT pk_startup_emprendedor
        PRIMARY KEY (id_startup, id_persona),
    CONSTRAINT fk_startup_emprendedor_startup
        FOREIGN KEY (id_startup)
        REFERENCES oltp.startup(id_startup),
    CONSTRAINT fk_startup_emprendedor_emprendedor
        FOREIGN KEY (id_persona)
        REFERENCES oltp.emprendedor(id_persona)
);

CREATE TABLE oltp.mentor_startup (
    id_startup INT NOT NULL,
    id_persona INT NOT NULL,
    CONSTRAINT pk_mentor_startup
        PRIMARY KEY (id_startup, id_persona),
    CONSTRAINT fk_mentor_startup_startup
        FOREIGN KEY (id_startup)
        REFERENCES oltp.startup(id_startup),
    CONSTRAINT fk_mentor_startup_mentor
        FOREIGN KEY (id_persona)
        REFERENCES oltp.mentor(id_persona)
);

CREATE TABLE oltp.oferta (
    id_oferta INT PRIMARY KEY,
    id_startup INT NOT NULL,
    nombre_oferta VARCHAR(50) NOT NULL,
    tipo_oferta VARCHAR(50),
    fecha_lanzamiento DATE,
    precio_oferta DECIMAL(15,2),
    CONSTRAINT fk_oferta_startup
        FOREIGN KEY (id_startup)
        REFERENCES oltp.startup(id_startup)
);


-- EVENTOS Y COMPETENCIAS


CREATE TABLE oltp.evento (
    id_evento INT PRIMARY KEY,
    id_startup INT NOT NULL,
    nombre_evento VARCHAR(50) NOT NULL,
    tipo_evento VARCHAR(50),
    fecha_inicio_evento DATE,
    fecha_fin_evento DATE,
    capacidad INT,
    CONSTRAINT fk_evento_startup
        FOREIGN KEY (id_startup)
        REFERENCES oltp.startup(id_startup)
);

CREATE TABLE oltp.competencia (
    id_competencia INT PRIMARY KEY,
    id_evento INT NOT NULL,
    premio_total DECIMAL(15,2),
    CONSTRAINT fk_competencia_evento
        FOREIGN KEY (id_evento)
        REFERENCES oltp.evento(id_evento)
);

CREATE TABLE oltp.sponsor_institucion (
    id_institucion INT NOT NULL,
    id_evento INT NOT NULL,
    monto_sponsor DECIMAL(15,2),
    CONSTRAINT pk_sponsor_institucion
        PRIMARY KEY (id_institucion, id_evento),
    CONSTRAINT fk_sponsor_institucion_institucion
        FOREIGN KEY (id_institucion)
        REFERENCES oltp.institucion(id_institucion),
    CONSTRAINT fk_sponsor_institucion_evento
        FOREIGN KEY (id_evento)
        REFERENCES oltp.evento(id_evento)
);


-- FINANCIACION E INVERSION


CREATE TABLE oltp.financiacion (
    id_financiacion INT PRIMARY KEY,
    id_startup INT NOT NULL,
    monto_recaudado DECIMAL(15,2),
    tipo_moneda VARCHAR(10),
    fecha_inicio_financiacion DATE,
    fecha_cierre_financiacion DATE,
    CONSTRAINT fk_financiacion_startup
        FOREIGN KEY (id_startup)
        REFERENCES oltp.startup(id_startup)
);

CREATE TABLE oltp.inversion (
    id_persona INT NOT NULL,
    id_financiacion INT NOT NULL,
    monto_invertido DECIMAL(15,2),
    CONSTRAINT pk_inversion
        PRIMARY KEY (id_persona, id_financiacion),
    CONSTRAINT fk_inversion_inversor
        FOREIGN KEY (id_persona)
        REFERENCES oltp.inversor(id_persona),
    CONSTRAINT fk_inversion_financiacion
        FOREIGN KEY (id_financiacion)
        REFERENCES oltp.financiacion(id_financiacion)
);