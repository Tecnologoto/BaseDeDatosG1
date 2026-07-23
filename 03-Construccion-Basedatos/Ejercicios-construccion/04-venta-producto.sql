--CREAR BASE DE DATOS
CREATE DATABASE venta_producto;
GO

--USAR BASE DE DATOS
USE venta_producto;
GO

-- PRIMERO SE HACE LA QUE NO TIENE FOREIGN KEY
-- TABLA CLIENTE
CREATE TABLE Cliente(
    cliente_id INT NOT NULL IDENTITY(1,1)
    CONSTRAINT pk_cliente
    PRIMARY KEY,

    empresa VARCHAR(30) NOT NULL,
    rfc VARCHAR(13) NOT NULL
    CONSTRAINT uq_cliente_rfc
    UNIQUE
);

-- TABLA PRODUCTO
CREATE TABLE Producto(
    producto_id INT NOT NULL IDENTITY(1,1)
    CONSTRAINT pk_producto
    PRIMARY KEY,

    nombre VARCHAR(30) NOT NULL,
    precio DECIMAL(10,2) NOT NULL
    CONSTRAINT ck_producto_precio
    CHECK (precio > 0)
);

--TABLA PEDIDO
CREATE TABLE Pedido(
    pedido_id INT NOT NULL IDENTITY(1,1)
    CONSTRAINT pk_pedido
    PRIMARY KEY,

    cliente_id INT NOT NULL
    CONSTRAINT fk_pedido_cliente
    FOREIGN KEY REFERENCES Cliente(cliente_id),
    fecha DATETIME NOT NULL
);

--TABLA TIENE
CREATE TABLE Tiene(
    tiene_id INT NOT NULL IDENTITY(1,1)
    CONSTRAINT pk_tiene
    PRIMARY KEY,

    pedido_id INT NOT NULL
    CONSTRAINT fk_tiene_pedido
    FOREIGN KEY REFERENCES Pedido(pedido_id),

    producto_id INT NOT NULL
    CONSTRAINT fk_tiene_producto
    FOREIGN KEY REFERENCES Producto(producto_id),
);