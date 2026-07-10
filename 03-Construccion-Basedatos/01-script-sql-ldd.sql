/*Construcción de base de datos con SQL-LDD (CREATE, ALTER, DROP)*/


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

/*INSERT INTO alumno
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
*/

-- Restricciones check
-- Primera forma de construcción (no se usa, porque no podemos manipular)

CREATE TABLE producto(
	producto_id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	NOMBRE varchar (20) NOT NULL UNIQUE,
	precio DECIMAL (10,2) NOT NULL CHECK (precio > 0.0),
	existencia int NOT NULL CHECK (existencia > 0 AND existencia <= 100),
	activo BIT NOT NULL DEFAULT 1
);
GO

INSERT INTO producto
VALUES('Pitufo', 450, 98, DEFAULT);

INSERT INTO producto
VALUES('Quemadita', 1, 2, DEFAULT);

INSERT INTO producto (nombre, existencia, precio)
VALUES('Pantera rosa', 77, 123);

TRUNCATE TABLE producto;

Select *
FROM producto;
GO

-- Segunda forma de construcción
CREATE TABLE producto(
	producto_id INT NOT NULL IDENTITY (1,1)
	CONSTRAINT pk_producto
	PRIMARY KEY,
	nombre VARCHAR (20) NOT NULL 
	CONSTRAINT uq_producto_nombre
	UNIQUE,
	precio DECIMAL (10,2) NOT NULL 
	CONSTRAINT ck_producto_precio
	CHECK(precio > 0.0),
	existencia INT NOT NULL 
	CONSTRAINT ck_producto_existencia
	CHECK(precio BETWEEN 1 AND 100),
	tipo CHAR(1) NOT NULL
	CONSTRAINT ck_producto_tipo
	CHECK(tipo = 'R' OR tipo = 'p'),
	activo BIT NOT NULL
	CONSTRAINT df_producto_activo
	DEFAULT 1
);
DROP TABLE producto;

-- Tercera forma de construcción (al final de las instrucciones)
CREATE TABLE producto(
	producto_id INT NOT NULL IDENTITY (1,1),
	nombre VARCHAR (20) NOT NULL,
	precio DECIMAL (10,2) NOT NULL, 
	existencia INT NOT NULL,
	tipo CHAR(1) NOT NULL,
	CONSTRAINT df_producto_activo
	DEFAULT 1,
	CONSTRAINT dk_producto
	PRIMARY KEY (producto_id),
	CONSTRAINT uq_producto_nombre
	UNIQUE (nombre),
	CONSTRAINT ck_producto_precio
	CHECK (precio > 0.0),
	CONSTRAINT ck_producto_existencia
	CHECK (existencia BETWEEN 1 AND 100),
	CONSTRAINT ck_producto_tipo
	CHECK (tipo IN ('R', 'P'))
);
GO

-- CREATE DATABASE EMPRESA YODA 
CREATE DATABASE empresa_yoda;
GO

USE empresa_yoda;
GO

CREATE TABLE categoria (
	categoria_id INT NOT NULL IDENTITY (1,1)
	CONSTRAINT pk_categoria
	PRIMARY KEY,
	nombre VARCHAR (20) NOT NULL
	CONSTRAINT uq_categoria_nombre
	UNIQUE, 
	activo BIT NOT NULL
	CONSTRAINT df_categoria_activo
	DEFAULT 1
);
GO

CREATE TABLE producto (
	producto_id INT NOT NULL,
	fabricante_id CHAR (3) NOT NULL,
	nombre VARCHAR (25) NOT NULL,
	existencia INT NOT NULL,
	precio NUMERIC (10,2) NOT NULL,
	activo BIT NOT NULL
	CONSTRAINT df_producto_activo
	DEFAULT 1,
	categoria_id INT NOT NULL
	CONSTRAINT pk_producto
	PRIMARY KEY(producto_id, fabricante_id),
	CONSTRAINT uq_producto_nombre
	UNIQUE (nombre),
	CONSTRAINT ck_producto_existencia
	CHECK (existencia > 0),
	CONSTRAINT ck_producto_precio
	CHECK (precio BETWEEN 1 AND 100000),
	CONSTRAINT fk_producto_categoria
	FOREIGN KEY(categoria_id)
	REFERENCES categoria (categoria_id)
);
GO

INSERT INTO categoria(nombre)
VALUES('frontend'),
	  ('backend'),
	  ('cloud');

SELECT * 
FROM categoria;

INSERT INTO producto
VALUES (1, 'ff1', 'Tailwind', 987.34, 45, DEFAULT, 1); -- Tienene llaves compuestas (1, 'ff1',...)
INSERT INTO producto
VALUES (2, 'ff1', 'Bootstrap', 567.8, 24, 0, 0, 1);
INSERT INTO producto
VALUES (1, 'ff2', 'aws', 567.8, 24, 0, DEFAULT, 3);

CREATE TABLE proveedor(
	proveedor_id INT NOT NULL
	CONSTRAINT pk_proveedor
	PRIMARY KEY,
	empresa VARCHAR(30) NOT NULL,
	direccion VARCHAR(60),
	limite_credito DECIMAL (10,2) NOT NULL,
);
GO

CREATE TABLE contacto_proveedor(
	contacto_id INT NOT NULL IDENTITY (1,1),
	nombre VARCHAR (20) NOT NULL,
	apellido_paterno VARCHAR (15) NOT NULL,
	apellido_materno VARCHAR (15),
	telefono VARCHAR (15) NOT NULL,
	proveedor_id INT
	CONSTRAINT pk_contacto_proveedor
	PRIMARY KEY (contacto_id),
	CONSTRAINT fk_contacto_proveedor
	FOREIGN KEY (proveedor_id)
	REFERENCES proveedor (proveedor_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

INSERT INTO proveedor
VALUES (1, 'patito de hule', NULL, 67888.01),
		(2, 'Bimbo', NULL, 5778.01),
		(3, 'Dulces Domingo', NULL, 6789.01),
		(4, 'Drugs Kevin', NULL, 4759.01);

INSERT INTO contacto_proveedor
VALUES ('Soyla', 'vaca', 'delcorral', '1234567890', 2),
('Carmen', 'seperdiola', 'cadenita', '1234567890', 2),
('Juanito', 'Dulce', 'Teluño', '1234567890', 2),
('Laura', 'nosta', 'comiendo', '1234567890', 2);

SELECT * FROM proveedor;
SELECT * FROM contacto_proveedor;

DELETE FROM proveedor
WHERE proveedor_id = 2;

UPDATE proveedor
SET proveedor_id = 10
WHERE proveedor_id = 2;

DROP TABLE contacto_proveedor
DROP TABLE proveedor

-- Integridad referencial ON DELETE y ON UPDATE SET NULL

CREATE TABLE proveedor(
	proveedor_id INT NOT NULL
	CONSTRAINT pk_proveedor
	PRIMARY KEY,
	empresa VARCHAR(30) NOT NULL,
	direccion VARCHAR(60),
	limite_credito DECIMAL (10,2) NOT NULL,
);
GO

CREATE TABLE contacto_proveedor(
	contacto_id INT NOT NULL IDENTITY (1,1),
	nombre VARCHAR (20) NOT NULL,
	apellido_paterno VARCHAR (15) NOT NULL,
	apellido_materno VARCHAR (15),
	telefono VARCHAR (15) NOT NULL,
	proveedor_id INT
	CONSTRAINT pk_contacto_proveedor
	PRIMARY KEY (contacto_id),
	CONSTRAINT fk_contacto_proveedor
	FOREIGN KEY (proveedor_id)
	REFERENCES proveedor (proveedor_id)
	ON DELETE SET NULL
	ON UPDATE SET NULL
);

INSERT INTO proveedor
VALUES (1, 'patito de hule', NULL, 67888.01),
		(2, 'Bimbo', NULL, 5778.01),
		(3, 'Dulces Domingo', NULL, 6789.01),
		(4, 'Drugs Kevin', NULL, 4759.01);

INSERT INTO contacto_proveedor
VALUES ('Soyla', 'vaca', 'delcorral', '1234567890', 2),
('Carmen', 'seperdiola', 'cadenita', '1234567890', 2),
('Juanito', 'Dulce', 'Teluño', '1234567890', 2),
('Laura', 'nosta', 'comiendo', '1234567890', 2);

SELECT * 
FROM proveedor AS p 
INNER JOIN contacto_proveedor AS cp
ON p.proveedor_id = cp.proveedor_id;

DELETE FROM proveedor
WHERE proveedor_id = 2;

SELECT * FROM proveedor;
SELECT * FROM contacto_proveedor;

-- Integridad referneical ON DELETE, ON UPDATE SET DEFAULT

CREATE TABLE proveedor(
	proveedor_id INT NOT NULL
	CONSTRAINT pk_proveedor
	PRIMARY KEY,
	empresa VARCHAR(30) NOT NULL,
	direccion VARCHAR(60),
	limite_credito DECIMAL (10,2) NOT NULL,
);
GO

CREATE TABLE contacto_proveedor(
	contacto_id INT NOT NULL IDENTITY (1,1),
	nombre VARCHAR (20) NOT NULL,
	apellido_paterno VARCHAR (15) NOT NULL,
	apellido_materno VARCHAR (15),
	telefono VARCHAR (15) NOT NULL,
	proveedor_id INT
	CONSTRAINT df_contacto_proveedor_id
	DEFAULT 0,
	CONSTRAINT pk_contacto_proveedor
	PRIMARY KEY (contacto_id),
	CONSTRAINT fk_contacto_proveedor
	FOREIGN KEY (proveedor_id)
	REFERENCES proveedor (proveedor_id)
	ON DELETE SET DEFAULT
	ON UPDATE SET DEFAULT
);

INSERT INTO proveedor
VALUES (1, 'patito de hule', NULL, 67888.01),
		(2, 'Bimbo', NULL, 5778.01),
		(3, 'Dulces Domingo', NULL, 6789.01),
		(4, 'Drugs Kevin', NULL, 4759.01),
		(0, 'Todas Mías', 'Engañifas', 666.69);

INSERT INTO contacto_proveedor
VALUES ('Soyla', 'vaca', 'delcorral', '1234567890', 2),
('Carmen', 'seperdiola', 'cadenita', '1234567890', 2),
('Juanito', 'Dulce', 'Teluño', '1234567890', 2),
('Laura', 'nosta', 'comiendo', '1234567890', 2);

SELECT * FROM proveedor;
SELECT * FROM contacto_proveedor;

DELETE proveedor 
WHERE proveedor_id = 2;

UPDATE contacto_proveedor
SET proveedor_id = 3
WHERE proveedor_id = 0;

UPDATE proveedor 
SET proveedor_id = 6
WHERE proveedor_id = 3;

--TODO:  Realizar ejercicio completo de costrucción de un diagrama relacional aplicando las restricciones
-- y se continua con ALTER y DROP