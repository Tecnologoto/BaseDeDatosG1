
-- Crear Base de Datos prueba G1

-- Permite crear una BD (SQL-LDD)
CREATE DATABASE Prueba1;

-- Utilizar la BD 
USE prueba1;

-- Crear tabla (SQL-LDD)
CREATE TABLE alumno (
	id int NOT NULL,
	alumno VARCHAR(20) NOT NULL,
	edad INT NOT NULL,
	matricula INT NOT NULL,
	direccion VARCHAR (30) NULL,
	CONSTRAINT pk_alumno
	PRIMARY KEY (id),
	CONSTRAINT unique_matricula
	UNIQUE (matricula)
);

-- AGREGAR DOA ALUMNOS(SQL-LMD)
INSERT INTO alumno (id, alumno, edad, matricula, direccion)
VALUES (1, 'ARCADIA', 65, 123456, 'Calle del infierno')
	   (2, 'NARNIA', 19, 125689, 'Rosa Melano');

-- Seleccionar los alumnos (SQL-LMD)
SELECT *
FROM alumno;

-- Cambiar el nombre de Arcadia a Monico (SQL-LMD)
UPDATE alumno
SET nombre = 'MONICO'
WHERE id = 1;

-----

CREATE DATABASE pruebaatributos;

CREATE TABLE alumno(
num_Alumno int not null primary key,
nombre varchar(50) not null,
apellido_1 varchar(30) not null,
apellido_2 varchar(30) NULL,
fecha_Naci date NOT NULL
);

INSERT INTO alumno
VALUES (1, 'Ángel Patricio', 'Perez', 'Hernández', '1998-09-08');

INSERT INTO alumno
VALUES (2, 'Ian Uriel', 'Rizo', NULL, '2007-09-08');

SELECT *
FROM alumno;

SELECT 
	nombre, apellido_1, apellido_2, YEAR(fecha_Naci),
	MONTH(fecha_Naci), DAY(fecha_Naci),
	(DATEDIFF(YEAR, fecha_Naci, GETDATE())) AS Edad
FROM alumno;