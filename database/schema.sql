CREATE DATABASE IF NOT EXISTS munich_startup_db;
USE munich_startup_db;

CREATE TABLE IF NOT EXISTS usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    rol ENUM('EMPRENDEDOR', 'INVERSIONISTA', 'ADMIN') NOT NULL,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS proyectos (
    id_proyecto INT AUTO_INCREMENT PRIMARY KEY,
    id_emprendedor INT NOT NULL,
    nombre_proyecto VARCHAR(150) NOT NULL,
    descripcion TEXT NOT NULL,
    meta_financiamiento DECIMAL(12,2) NOT NULL,
    monto_recaudado DECIMAL(12,2) DEFAULT 0.00,
    estado ENUM('ACTIVO', 'COMPLETADO', 'CANCELADO') DEFAULT 'ACTIVO',
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_emprendedor) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS inversiones (
    id_inversion INT AUTO_INCREMENT PRIMARY KEY,
    id_inversionista INT NOT NULL,
    id_proyecto INT NOT NULL,
    monto DECIMAL(12,2) NOT NULL,
    fecha_inversion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_inversionista) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_proyecto) REFERENCES proyectos(id_proyecto) ON DELETE CASCADE
);
