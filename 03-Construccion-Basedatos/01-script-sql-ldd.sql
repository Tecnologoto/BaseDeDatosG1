/*Construcción de base de datos 
con SQL-LDD (CREATE, ALTER, DROP)*/


-- Restricciones
-- Primary key

-- Crear una base de datos
CREATE DATABASE empresa_patito;
GO

--Utilizar la base de datos
USE empresa_patito;
GO

-- Crear tabla 
CREATE TABLE alumno(
	alumno_id INT NOT NULL,
	nombre VARCHAR(30),
	apellido_paterno VARCHAR(20),
	apellido_materno VARCHAR(20),
	fecha_nacimiento DATE,
	correo VARCHAR(25)
	CONSTRAINT pk_alumno
	PRIMARY KEY(alumno_id)
);
GO

DROP TABLE alumno;
GO

INSERT INTO alumno
VALUES (1,'Domingo', 'Sarabia', 'Mendez', '1942-03-14', 'domingo@gomingo.com');

INSERT INTO alumno
VALUES (1,'Patricio', 'Hernández', 'Chequez', '1955-06-22', 'patricio@patito.com')
GO

SELECT *
FROM alumno;

-- Primary Key con IDENTITY

CREATE TABLE categoria(
	categoria_id INT IDENTITY (1,1) PRIMARY KEY,
	nombre VARCHAR (25) NOT NULL,
	activo bit NOT NULL 
);
GO

INSERT INTO categoria
VALUES('Carnes frías',1);
INSERT INTO categoria
VALUES('Carnes frías',1);

SELECT *
FROM categoria;

DROP TABLE categoria;
GO

-- Restriccion CHECK

CREATE TABLE categoria(
	categoria_id INT IDENTITY (1,1),
	CONSTRAINT pk_categoria
	PRIMARY KEY(categoria_id),
	nombre VARCHAR (25) NOT NULL UNIQUE,
	activo bit NOT NULL 
);
GO

INSERT INTO categoria
VALUES('Carnes frías',1);
INSERT INTO categoria
VALUES('Carnes frías',1);

SELECT *
FROM categoria;

DROP TABLE categoria;
GO

CREATE TABLE categoria(
	categoria_id INT IDENTITY (1,1),
	CONSTRAINT pk_categoria
	PRIMARY KEY(categoria_id),
	nombre VARCHAR (25) NOT NULL
	CONSTRAINT uq_categoria_nombre
	UNIQUE,
	activo bit NOT NULL 
);
GO

INSERT INTO categoria
VALUES('Carnes frías',1);
INSERT INTO categoria
VALUES('Carnes frías',1);

SELECT *
FROM categoria;

DROP TABLE categoria;
GO

CREATE TABLE categoria(
	categoria_id INT IDENTITY (1,1),
	nombre VARCHAR (25) NOT NULL,
	activo bit NOT NULL,
	CONSTRAINT pk_categoria
	PRIMARY KEY(categoria_id),
	CONSTRAINT uq_categoria_nombre
	UNIQUE(nombre)
);
GO

INSERT INTO categoria
VALUES('Carnes frías',1);
INSERT INTO categoria
VALUES('Carnes frías',1);

SELECT *
FROM categoria;

DROP TABLE categoria;
GO