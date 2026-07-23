--CREAR BASE DE DATOS
CREATE DATABASE cursos_profesor;
GO

--USAR BASE DE DATOS
USE cursos_profesor;

-- PRIMERO SE HACE LA QUE NO TIENE FOREIGN KEY
-- TABLA PROFESOR
CREATE TABLE profesor(
    profesor_id INT NOT NULL IDENTITY(1,1)
    CONSTRAINT pk_profesor
    PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    apellido_paterno VARCHAR(15) NOT NULL,
    apellido_materno VARCHAR(15),
);
GO 

CREATE TABLE especialidad(
    especialidad_id INT NOT NULL IDENTITY(1,1)
    CONSTRAINT pk_especialidad
    PRIMARY KEY,
    profesor_id INT NOT NULL,
    CONSTRAINT fk_especialidad_profesor
    FOREIGN KEY (profesor_id) 
    REFERENCES profesor(profesor_id),
    nombre VARCHAR(30) NOT NULL
);
GO

CREATE TABLE curso(
    curso_id INT NOT NULL IDENTITY(1,1)
    CONSTRAINT pk_curso
    PRIMARY KEY,
    profesor_id INT NOT NULL,
    CONSTRAINT fk_curso_profesor
    FOREIGN KEY (profesor_id) 
    REFERENCES profesor(profesor_id),
    nombre VARCHAR(30) NOT NULL,
    creditos INT NOT NULL
    CONSTRAINT ck_curso_creditos
    CHECK (creditos > 0)
);
GO

SELECT * FROM profesor
SELECT * FROM especialidad
SELECT * FROM curso