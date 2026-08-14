/*==================================================================================
DQL (Data Query Languaje) en SQLServer

Archivo: 06-filtrado-registros-where.sql

Descripción: Se rerecuperan únicamente las filas que cumplen determinadas
condiciones mediante la clausla WHERE

ORDEN SINTÁCTICO:               
FROM 
JOINS/ON
WHERE
GROUP BY
HAVING 
ORDER BY

ORDEN DE EJECUCIÓN:
FROM / JOINS (INNER, LEFT, RIGHT, CROSS, FULL, SELF)
WHERE
GROUP BY
HAVING
SELECT
DISTINCT
ORDER BY
TOP
====================================================================================*/

/*====================================================================================
Sintaxis:

SELECT
	columna_1,
	columna_2,
	columna_n
FROM nombre_tabla 
WHERE condición;

Nota: La condición puede ser relacional y combinación de esta con lógica
Nota: El SELECT no filtra registrosm lo hacen otros comandos
====================================================================================*/

-- Seleccionar el producto cuyo precio es $200
SELECT 
	p.codigo AS [Código],
	p.nombre AS [Producto],
	p.precio AS [Precio]
FROM productos AS p
WHERE precio = 200;

-- Seleccionar el cliente cuyo dientificadro es 25
SELECT
	c.id_cliente AS [ID],
	c.nombre AS [Nombre],
	c.apellido_paterno AS [Apellido paterno],
	c.apellido_materno AS [Apellido materno],
	c.fecha_nacimiento AS [Fecha de nacimiento],
	c.id_ciudad AS [Ciudad],
	c.sexo AS [Sexo],
	c.telefono AS [Teléfono],
	c.correo AS [Correo]
FROM clientes AS c
WHERE id_cliente = 25;

SELECT
	c.id_cliente,
	CONCAT(c.nombre, '',
	c.apellido_paterno, '',
	c.apellido_paterno, '') AS [ClienteInfo]
FROM clientes AS c
WHERE c.id_cliente = 25;

--Comparación de cadenas de texto
--Los valores de texto debe escribirse entre comillas simples
--Seleccionar las catégorías donde el nombre sea Cómputo
SELECT 
	c.nombre AS [Categoría]
	
FROM categorias AS c
WHERE c.nombre = 'Cómputo';

--Seleccionar los datos del cliente con nombre Cliente1
SELECT 
	c.nombre AS [Numero de cliente]
FROM clientes AS c
WHERE c.nombre = 'Cliente1';

--Seleccionar los datos del empleado que no pertenezcan al departamento 1
SELECT 
	d.nombre
FROM departamentos AS d
WHERE d.nombre <> 'departamento 1';

--Seleccionar los datos de los productos donse el precio sea superior a $490
SELECT
	p.precio AS [Precio]
FROM productos AS p
WHERE p.precio > 490.0;

--Seleccionar los datos de los productos con existencia crítica inferior a $10 unidades
SELECT
	p.existencia AS [Existencia]
FROM productos AS p
WHERE p.existencia <= 10;

-- Seleccionar los datos de los empleados donde su salario sea de $30,000 en adelante
SELECT 
	e.salario AS [Salario]
FROM empleados AS e
WHERE e.salario < 30000;

--Seleccionar los datos de los productos donde sus precios sean de $10 o menos
SELECT
	p.precio AS [Precio]
FROM productos AS p
WHERE p.precio <= 10;

--Comparación de fechas
--Las fechas deben escribirse entre comillas simples
--Se recomienda el formato AAAA-MM-DD

--Seleccionar los datos de las ventas realizadas del 24 de Dicimebre del 2025
SELECT
	v.id_venta,
	v.id_cliente,
	v.id_empleado,
	v.fecha
FROM ventas AS v
WHERE fecha = '2025-12-24';

--Seleccionar los datos de las ventas realizadas en los meses de Abril
SELECT
	v.id_venta,
	v.id_cliente,
	v.id_empleado,
	v.fecha,
	YEAR(v.fecha) AS [Año],
	MONTH(v.fecha) AS [Mes],
	DAY(v.fecha) AS [Día]
FROM ventas AS v
WHERE MONTH (fecha) = 4;

--Seleccionar todas las ventas anteriores al primero de febrero del 2025
SELECT
	v.id_venta,
	v.id_cliente,
	v.id_empleado,
	v.fecha,
	YEAR(v.fecha) AS [Año],
	MONTH(v.fecha) AS [Mes],
	DAY(v.fecha) AS [Día]
FROM ventas AS v
WHERE fecha < '2025-02-01';

-- Seleccionar las fechas anteriores al 1 de febrero del 2025
SELECT
	v.id_venta,
	v.fecha,
	YEAR(v.fecha) AS [AÑO],
	MONTH(v.fecha) AS [MES],
	DAY(v.fecha) AS [DÍA],
	FORMAT (v.fecha, 'MMMM') AS [MES EN INGLÉS],
	UPPER (FORMAT (v.fecha, 'MMMM', 'es-ES')) AS [MES EN ESPAÑOL],
	FORMAT(v.fecha, 'MMMM') AS [MES ABREVIADO],
	FORMAT(v.fecha, 'MMM', 'es-ES') AS [MES ABREVIADO],
	FORMAT (v.fecha, 'dddd') AS [DÍA EN INLÉS],
	FORMAT (v.fecha, 'dddd', 'es-ES') AS [DÍA EN INGLÉS],
	v.id_cliente,
	v.id_empleado
FROM ventas AS v
WHERE fecha < '2025-02-01';

--DISTINCT
--quita elementos repetidos de una o la combinación de columnas

--Muestra los sexos de los clientes
SELECT
	sexo
FROM CLIENTES AS c;

SELECT DISTINCT
	sexo	
FROM CLIENTES AS c;


SELECT DISTINCT
	id_ciudad
FROM clientes;

SELECT COUNT(*)
FROM ciudades;

SELECT DISTINCT
	cu.nombre
FROM clientes AS c
INNER JOIN ciudades AS cu
ON c.id_ciudad = cu.id_ciudad;

--Seleccionar los descuentos únicos de las ventas
SELECT DISTINCT
	dv.descuento
FROM detalle_ventas AS dv
ORDER BY dv.descuento DESC;

SELECT DISTINCT
	p.id_categoria,
	p.id_proveedor
FROM productos AS p;
GO

--TOP
--Limita la cantidad de filas devueltas por una consulta
SELECT 
	dv.id_venta,
	dv.precio,
	dv.cantidad,
	dv.descuento
FROM detalle_ventas AS dv;

SELECT TOP(10)
	dv.id_venta,
	dv.precio,
	dv.cantidad,
	dv.descuento
FROM detalle_ventas AS dv;

SELECT TOP(10) PERCENT
	dv.id_venta,
	dv.precio,
	dv.cantidad,
	dv.descuento
FROM detalle_ventas AS dv;

-- Seleccionar las fechas anteriores al 1 de febrero del 2025
SELECT
	v.id_venta,
	v.fecha,
	YEAR(v.fecha) AS [AÑO],
	MONTH(v.fecha) AS [MES],
	DAY(v.fecha) AS [DÍA],
	FORMAT (v.fecha, 'MMMM') AS [MES EN INGLÉS],
	UPPER (FORMAT (v.fecha, 'MMMM', 'es-ES')) AS [MES EN ESPAÑOL],
	FORMAT(v.fecha, 'MMMM') AS [MES ABREVIADO],
	FORMAT(v.fecha, 'MMM', 'es-ES') AS [MES ABREVIADO],
	FORMAT (v.fecha, 'dddd') AS [DÍA EN INLÉS],
	FORMAT (v.fecha, 'dddd', 'es-ES') AS [DÍA EN INGLÉS],
	v.id_cliente,
	v.id_empleado
FROM ventas AS v
WHERE fecha < '2025-02-01';

--Seleccionar los datos de los productos mostrando el código 
--y el valor del inventario, donde el valor del inventario debe ser mayor a 50000

SELECT 
	p.codigo AS codigo_producto,
	p.existencia AS existencia,
	p.precio AS precio,
	(p.precio * p.existencia) AS valor_inventario
FROM productos AS p
WHERE (p.precio * p.existencia) > 50000;

--Mostrar los productos con precio que estén entre $200 y $300
SELECT 
	p.codigo AS codigo_producto,
	p.existencia AS existencia,
	p.precio AS precio,
	(p.precio * p.existencia) AS valor_inventario
FROM productos AS p
WHERE precio >= 200.0 AND precio <= 300.0;

--Mostrar los productos con precio que estén entre $200 y $300 con BETWEEN
--BETWEEN sólo funciona para rangos
SELECT 
	p.codigo AS codigo_producto,
	p.existencia AS existencia,
	p.precio AS precio,
	(p.precio * p.existencia) AS valor_inventario
FROM productos AS p
WHERE precio BETWEEN 200.0 AND 300.0;