CREATE SCHEMA IF NOT EXISTS dw;


-- DIM_INSTITUCION

CREATE TABLE dw.dim_institucion (
    id_institucion INT PRIMARY KEY,
    nombre_institucion VARCHAR(50) NOT NULL,
    tipo_institucion VARCHAR(50)
);


-- DIM_TIEMPO

CREATE TABLE dw.dim_tiempo (
    id_tiempo INT PRIMARY KEY,
    fecha DATE NOT NULL,
    anio INT NOT NULL,
    semestre INT NOT NULL,
    trimestre INT NOT NULL,
    mes INT NOT NULL,
    nombre_mes VARCHAR(20) NOT NULL,
    dia INT NOT NULL,
    dia_semana INT NOT NULL,
    nombre_dia VARCHAR(20) NOT NULL,
    es_fin_semana BOOLEAN NOT NULL,
    CONSTRAINT uq_dim_tiempo_fecha UNIQUE (fecha)
);


-- DIM_INVERSOR

CREATE TABLE dw.dim_inversor (
    id_persona INT PRIMARY KEY,
    tipo_inversor VARCHAR(30),
    nombre_rol VARCHAR(20),
    nombre VARCHAR(30) NOT NULL,
    apellido VARCHAR(30) NOT NULL,
    direccion VARCHAR(50),
    email VARCHAR(30),
    telefono INT,
    fecha_nacimiento DATE
);


-- DIM_FINANCIACION

CREATE TABLE dw.dim_financiacion (
    id_financiacion INT PRIMARY KEY,
    monto_recaudado DECIMAL(15,2),
    tipo_moneda VARCHAR(10),
    duracion_financiacion INT,
    fecha_inicio_financiacion DATE,
    fecha_cierre_financiacion DATE
);


-- DIM_STARTUP

CREATE TABLE dw.dim_startup (
    id_startup INT PRIMARY KEY,
    cantidad_mentores INT,
    cantidad_emprendedores INT,
    cantidad_ofertas INT,
    precio_promedio_oferta DECIMAL(15,2),
    tipo_oferta VARCHAR(50),
    especialidad VARCHAR(50),
    nivel_educacion VARCHAR(30),
    nombre_startup VARCHAR(50) NOT NULL,
    ubicacion_startup VARCHAR(50),
    descripcion VARCHAR(100),
    anio_fundacion DATE,
    sitio_web VARCHAR(100),
    estado_startup VARCHAR(100)
);


-- FACT_INVERSION


CREATE TABLE dw.fact_inversion (
    id_inversion_fact INT PRIMARY KEY,
    id_persona INT NOT NULL,
    id_financiacion INT NOT NULL,
    id_institucion INT NOT NULL,
    id_startup INT NOT NULL,
    id_tiempo INT NOT NULL,
    monto_invertido DECIMAL(15,2) NOT NULL,

    CONSTRAINT fk_fact_inversion_inversor
        FOREIGN KEY (id_persona)
        REFERENCES dw.dim_inversor(id_persona),

    CONSTRAINT fk_fact_inversion_financiacion
        FOREIGN KEY (id_financiacion)
        REFERENCES dw.dim_financiacion(id_financiacion),

    CONSTRAINT fk_fact_inversion_institucion
        FOREIGN KEY (id_institucion)
        REFERENCES dw.dim_institucion(id_institucion),

    CONSTRAINT fk_fact_inversion_startup
        FOREIGN KEY (id_startup)
        REFERENCES dw.dim_startup(id_startup),

    CONSTRAINT fk_fact_inversion_tiempo
        FOREIGN KEY (id_tiempo)
        REFERENCES dw.dim_tiempo(id_tiempo)
);