-- CREAR BASE DE DATOS
CREATE DATABASE control_escolar;
GO  

-- USAR BASE DE DATOS
USE control_escolar;
GO  

-- PRIMERO SE HACE LA QUE NO TIENE FOREIGN KEY
-- TABLA ALUMNO
CREATE TABLE Alumno(
    alumno_id INT NOT NULL IDENTITY(1,1)
    CONSTRAINT pk_alumno
    PRIMARY KEY,

    nombre VARCHAR(30) NOT NULL,
    apellido_paterno VARCHAR(20) NOT NULL,
    apellido_materno VARCHAR(20),
    semestre INT NOT NULL
    CONSTRAINT ck_alumno_semestre
    CHECK (semestre > 0),    
    matricula CHAR(10) NOT NULL
    CONSTRAINT uq_alumno_matricula  
    UNIQUE
);

--TABLA MATERIA
CREATE TABLE Materia(
    materia_id INT NOT NULL IDENTITY(1,1)
    CONSTRAINT pk_materia
    PRIMARY KEY,
    
    nombre VARCHAR(30) NOT NULL
    CONSTRAINT uq_materia_nombre
    UNIQUE,
    creditos INT NOT NULL
    CONSTRAINT ck_materia_creditos
    CHECK (creditos > 0)
);

-- SE HACE LA QUE TIENE MENOS FOREIGN KEYS
-- TABLA INSCRIPCION
CREATE TABLE Inscripcion (
    alumno_id INT NOT NULL,
    materia_id INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    cali_final DECIMAL(10,2) NOT NULL,

    CONSTRAINT pk_inscripcion
    PRIMARY KEY (alumno_id, materia_id),

    CONSTRAINT fk_inscripcion_alumno
    FOREIGN KEY (alumno_id)
    REFERENCES Alumno(alumno_id),

    CONSTRAINT fk_inscripcion_materia
    FOREIGN KEY (materia_id)
    REFERENCES Materia(materia_id)
);

SELECT * FROM Alumno;
SELECT * FROM Materia;
SELECT * FROM Inscripcion;