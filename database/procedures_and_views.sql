USE munich_startup_db;

-- Vista: Resumen de Financiamiento de Proyectos
CREATE OR REPLACE VIEW vw_resumen_proyectos AS
SELECT 
    p.id_proyecto,
    p.nombre_proyecto,
    u.nombre AS emprendedor,
    p.meta_financiamiento,
    p.monto_recaudado,
    ROUND((p.monto_recaudado / p.meta_financiamiento) * 100, 2) AS porcentaje_alcanzado,
    p.estado
FROM proyectos p
JOIN usuarios u ON p.id_emprendedor = u.id_usuario;

-- Procedimiento Almacenado: Registrar Inversion y actualizar recaudacion
DELIMITER //

CREATE PROCEDURE sp_registrar_inversion(
    IN p_id_inversionista INT,
    IN p_id_proyecto INT,
    IN p_monto DECIMAL(12,2)
)
BEGIN
    -- Insertar la nueva inversion
    INSERT INTO inversiones (id_inversionista, id_proyecto, monto)
    VALUES (p_id_inversionista, p_id_proyecto, p_monto);

    -- Actualizar el monto recaudado en la tabla proyectos
    UPDATE proyectos
    SET monto_recaudado = monto_recaudado + p_monto
    WHERE id_proyecto = p_id_proyecto;

    -- Verificar si se alcanzo la meta para cambiar estado a COMPLETADO
    UPDATE proyectos
    SET estado = 'COMPLETADO'
    WHERE id_proyecto = p_id_proyecto AND monto_recaudado >= meta_financiamiento;
END //

DELIMITER ;
