USE munich_startup_db;

-- Insertar Usuarios Iniciales
INSERT INTO usuarios (nombre, email, password_hash, rol) VALUES
('Carlos Mendoza', 'carlos.mendoza@email.com', 'hash_pass_123', 'EMPRENDEDOR'),
('Ana Gutierrez', 'ana.gutierrez@email.com', 'hash_pass_456', 'INVERSIONISTA'),
('Sofia Martinez', 'sofia.martinez@email.com', 'hash_pass_789', 'INVERSIONISTA'),
('Admin Munich', 'admin@munichstartup.com', 'hash_pass_admin', 'ADMIN');

-- Insertar Proyectos Iniciales
INSERT INTO proyectos (id_emprendedor, nombre_proyecto, descripcion, meta_financiamiento, monto_recaudado, estado) VALUES
(1, 'EcoTech Solutions', 'Plataforma IoT para optimización de consumo energético en empresas.', 50000.00, 15000.00, 'ACTIVO'),
(1, 'HealthSmart App', 'Aplicación móvil de monitoreo de salud mediante IA.', 30000.00, 30000.00, 'COMPLETADO');

-- Insertar Inversiones Iniciales
INSERT INTO inversiones (id_inversionista, id_proyecto, monto) VALUES
(2, 1, 10000.00),
(3, 1, 5000.00),
(2, 2, 30000.00);
