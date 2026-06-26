-- Crear base de datos

CREATE DATABASE bdconstraint;
GO
-- Razon dde cardinalidad 1:1

-- Usar la base de datos

USE bdconstraint;
GO

-- Crear tabla paciente

CREATE TABLE PACIENTE(
	Idpaciente INT NOT NULL,
	Nombre VARCHAR (40) NOT NULL,
	Apellido1 VARCHAR(20) NOT NULL,
	Apellido2 VARCHAR(20) NULL,
	Fechanaci DATE NOT NULL,
	CONSTRAINT pk_paciente
	PRIMARY KEY (Idpaciente)
);
GO

CREATE TABLE expediente (
	Idexp INT NOT NULL PRIMARY KEY, 
	Fechaapertura DATE NOT NULL,
	Tiposangre CHAR(3) NULL,
	Idpaciente INT NOT NULL
	CONSTRAINT unique_idpaciente
	UNIQUE (Idpaciente),
	CONSTRAINT fk_expediente_paciente
	FOREIGN KEY(Idpaciente)
	REFERENCES paciente (Idpaciente)
);
GO

-- Datos para las tablas

INSERT INTO paciente
VALUES (2, 'José Domingo', 'Perez', 'Hernández', '1995-03-21');
INSERT INTO paciente
VALUES (3, 'Anakin', 'Sky', 'Walker', '5768-12-04');
INSERT INTO paciente
VALUES (4, 'Georg Wilhelm', 'Friedrich', 'Hegel', '1770-08-27')

SELECT * FROM PACIENTE;

-- Insertar expedientes

INSERT INTO expediente
VALUES (1, GETDATE(), '+O', 1);
INSERT INTO expediente
VALUES (2, '2026-06-17', '+O', 2);

SELECT * FROM expediente
