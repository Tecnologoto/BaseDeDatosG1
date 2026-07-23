-- CREAR BASE DE DATOS
CREATE DATABASE comercializadora;
GO

-- USAR BASE DE DATOS
USE comercializadora;
GO

-- PRIMERO SE HACE LA QUE NO TIENE FOREIGN KEY
-- TABLA PRODUCTO
CREATE TABLE producto(
	producto_id CHAR(5) NOT NULL,
	fabricante_id CHAR(3) NOT NULL,
	-- NO SE PUEDE HACER IDENTITY, PORQUE SÓLO SE APLICA A LOS INT
	descripcion VARCHAR(40) NOT NULL,
	existencia INT NOT NULL,
	CONSTRAINT pk_producto
	PRIMARY KEY(producto_id, fabricante_id),
	CONSTRAINT uq_producto_descripcion
	UNIQUE (descripcion),
	CONSTRAINT ck_producto_existencia
	CHECK (existencia > 0)
);
GO

-- SE HACE LA QUE TIENE MENOS FOREIGN KEYS
-- TABLA CLIENTE
CREATE TABLE cliente(
	cliente_id INT NOT NULL IDENTITY(1,1)
	CONSTRAINT pk_cliente
	PRIMARY KEY,
	-- AQUÍ PONEMOS LA PRIMARY KEY EN UNA SOLA LÍNEA, ARRIBA LO PUSIMOS DESPUÉS DE LA DELCARACIÓN DE VARIABLES
	empresa VARCHAR(30) NOT NULL
	CONSTRAINT uq_cliente_empresa
	UNIQUE,
	limite_credito DECIMAL(10,2) NOT NULL
	CONSTRAINT ck_cliente_limite_credito
	CHECK(limite_credito BETWEEN 10000 AND 100000),
	representante_id INT NOT NULL
);
GO

-- SIGUEN TODAS LAS DEMÁS TABLAS
-- TABLA REPRESENTANTE
CREATE TABLE representante(
	representante_id INT NOT NULL IDENTITY (1,1),
	nombre VARCHAR(20) NOT NULL,
	apellido_paterno VARCHAR(15) NOT NULL,
	apellido_materno VARCHAR(15), 
	fecha_contrato DATETIME2 NOT NULL
	CONSTRAINT df_representante_fecha_contrato
	-- ESTE COMANDO SIRVE PARA OBTENER LA HORA DEL SISTEMA Y PARA USARLO HAY QUE USAR "DATETIME2"
	DEFAULT SYSDATETIME(),
	edad INT NOT NULL,
	puesto VARCHAR (15), 
	cuota DECIMAL (10,2) NOT NULL, 
	ventas DECIMAL (10,2),
	-- ESTA ES LA FOREIGN KEY RECURSIVA JERÁRQUICA DE JEFE EN LA TABLA REPRESENTANTE
	representante_id_jefe INT,
	-- FOREIGN KEY DE OFICINA
	oficina_id INT NOT NULL,
	CONSTRAINT pk_representante
	PRIMARY KEY (representante_id),
	CONSTRAINT ck_representante_edad
	CHECK(edad >= 18 AND edad <= 55),
	CONSTRAINT ck_representante_cuota
	CHECK(cuota > 0.0), 
	CONSTRAINT ck_representante_venta
	CHECK (ventas >= 0.0),
	CONSTRAINT fk_representante_representante
	FOREIGN KEY(representante_id_jefe)
	REFERENCES representante (representante_id)
);

-- TABLA PEDIDOS
CREATE TABLE pedido (
	pedido_id INT NOT NULL IDENTITY (1,1)
	CONSTRAINT pk_pedido
	PRIMARY KEY,
	fecha_pedido DATETIME2 NOT NULL
	CONSTRAINT df_pedido_fecha_pedido
	DEFAULT SYSDATETIME(), 
	cliente_id INT NOT NULL,
	CONSTRAINT fk_pedido_cliente
	FOREIGN KEY (cliente_id)
	REFERENCES cliente(cliente_id),
	representante_id INT NOT NULL
	CONSTRAINT fk_pedido_representante
	FOREIGN KEY (representante_id)
	REFERENCES representante(representante_id)
);

-- AGREGAR LA FOREIGN KEY A LA TABLA CLIENTE QUE VIENE DE REPRESENTANTE
ALTER TABLE cliente
ADD CONSTRAINT fk_cliente_representante
FOREIGN KEY (representante_id)
REFERENCES representante(representante_id);
GO

CREATE TABLE detalle_pedido(
	pedido_id INT NOT NULL,
	producto_id CHAR(5) NOT NULL,
	fabricante_id CHAR(3) NOT NULL,
	precio DECIMAL (10,2) NOT NULL,
	created_at DATETIME2 NOT NULL
	CONSTRAINT df_detalle_pedido_created_at
	DEFAULT SYSDATETIME(),
	updated_at DATETIME2 NOT NULL
	CONSTRAINT df_detalle_pedido_updated_at
	DEFAULT SYSDATETIME(),
	CONSTRAINT ck_detalle_pedido_precio
	CHECK (precio > 0.0),
	cantidad INT NOT NULL,
	CONSTRAINT ck_detalle_pedido_cantidad
	CHECK (cantidad > 0.0),
	CONSTRAINT pk_detalle_pedido
	PRIMARY KEY (pedido_id, producto_id, fabricante_id),
	CONSTRAINT fk_detalle_pedido
	FOREIGN Key (pedido_id) --Foreign Key de pedido
	REFERENCES pedido(pedido_id),
	CONSTRAINT fk_detalle_pedido_producto
	FOREIGN KEY (producto_id, fabricante_id)
	REFERENCES producto(producto_id, fabricante_id)
);