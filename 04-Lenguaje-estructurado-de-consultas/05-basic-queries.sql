/*==================================================================================
DQL (Data Query Languaje) en SQLServer

Archivo: 05-basic-queries.sql

Descripción: Se realizan consultas básicas con SELECT

====================================================================================*/

USE comercial_db;
GO
-- Uso de SELECT * 

/*==================
Sintaxis:

SELECT * 
FROM nombre_tabla

El asterisco significa todas las columnas de la tabla.
No se recomienda utilizarla siempre, es preferible evitarlo:

	1) Reduce la claridad de la consulta
	2) Puede aumentar el consumo de recursos
	3) Puede afectar aplicaciones futuras


===================*/

Select * 
FROM productos;
GO

-- Proyección de la tabla productos
SELECT 
	codigo, 
	nombre,
	precio
FROM productos;
GO

SELECT 
	nombre,
	codigo,
	precio
FROM productos;
GO

-- Alias de columna (sobrenombre que se le pone a cada campo)
SELECT 
	codigo AS codigo_producto,
	nombre AS nombre_producto,
	precio AS precio_unitario
FROM productos;

-- Alias con espacios
SELECT 
	codigo AS [codigo producto],
	nombre AS [nombre producto],
	precio AS [precio unitario]
FROM productos;

SELECT 
	codigo AS 'codigo producto',
	nombre AS 'nombre producto',
	precio AS 'precio unitario'
FROM productos;

-- Alias sin la instrucción AS -> NO RECOMENDADO
SELECT 
	codigo codigo_producto,
	nombre nombre_producto,
	precio precio_unitario
FROM productos;

SELECT 
	codigo [codigo producto],
	nombre [nombre producto],
	precio [precio unitario]
FROM productos;

--Alias de tabla: útil cuando hacemos JOIN y en nombres ambigüos
SELECT 
	p.codigo,
	p.nombre,
	p.precio
FROM productos AS p;

SELECT 
categorias.id_categoria, 
categorias.nombre, 
productos.id_producto, 
productos.nombre, 
productos.precio
FROM categorias
INNER JOIN
productos
ON categorias.id_categoria = productos.id_categoria;
GO

SELECT 
	p.codigo,
	p.nombre,
	p.precio
FROM productos AS p;

SELECT 
c.id_categoria, 
c.nombre, 
p.id_producto, 
p.nombre, 
p.precio
FROM categorias AS c
INNER JOIN
productos
ON categorias.id_categoria = productos.id_categoria;
GO

SELECT 
	p.codigo AS Codigo,
	p.nombre AS [Nombre producto],
	p.precio AS 'Precio unitario'
FROM productos AS p;

--Columnas calculadas
-- Campos calculados y E-R (atributo derivado)

-- Seleccionar el código, nombre, precio, existencia 
-- y el valor del inventario

SELECT 
	p.codigo AS codigo_producto,
	p.nombre AS nombre_producto,
	p.precio AS precio_unitario,
	p.existencia,
	(p.existencia * p.precio) AS precio_inventario
FROM productos AS p;

-- TODO: Operadores aritméticos
/*=======================
+ suma
- resta
* multiplicación 
/ división
% módulo o residuo
=======================*/

SELECT
	e.nombre,
	e.apellido_paterno,
	e.salario AS salario_anual,
	(salario*12) AS salario_anual

FROM empleado AS e;
GO

/*SELECCIONAR EL DETALLE DE LAS VENTAS, MOSTRANDO 
EL NÚMERO DE VENTAS, CANTIDAD, PRECIO, DESCUENTO Y 
CALCULAR EL IMPORTE BRUTO (CANTIDAD*PRECIO). TAMBIÉN
DESEAMOS CALCULAR EL IMPORTE CON DESCUENTO
(IMPORTE_BRUTO*DESCUENTO/100) Y EL IMPORTE NETO
(IMPORTE_BRUTO*1-EL DESCUENTO/100)*/

SELECT
	dv.id_venta AS #venta,
	dv.cantidad AS #cantidad_vendida,
	dv.precio AS [precio de venta],
	dv.descuento AS 'descuento de venta',
	dv.cantidad * dv.precio AS importe_bruto,
	(dv.cantidad * dv.precio) / 100.0 AS importe_descuento,
	(dv.cantidad * dv.precio) * (1 - descuento / 100) AS importe_neto
FROM detalle_ventas AS dv;