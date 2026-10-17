-- Script de inicialización para SIGA
-- Tabla de alumnos

CREATE TABLE IF NOT EXISTS alumnos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    registro VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    carrera VARCHAR(100) NOT NULL,
    estado VARCHAR(20) DEFAULT 'Inscrito',
    fecha_inscripcion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insertar un registro de prueba
INSERT INTO alumnos (registro, nombre, carrera) 
VALUES ('2023001', 'Ana García', 'Ingeniería de Sistemas');