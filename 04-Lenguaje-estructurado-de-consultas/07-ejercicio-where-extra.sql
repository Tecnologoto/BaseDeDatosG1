/*===========================================================================================================

Ejercico extra con la base de datos Northwind 

===========================================================================================================*/

USE NORTHWND;

-- Mostrar las ventas realizadas en Francia, brazil y belgica
-- del 10 de julio de 1996 al 31 de Diciembre de 1998, que tenga Region de Envio,

SELECT 
	o.OrderID AS numero_orden,
	o.CustomerID AS cliente,
	o.ShipCountry AS pais_emvio,
	o.OrderDate AS fecha_orden,
	UPPER(FORMAT(o.OrderDate, 'MMMM', 'es-ES')) AS [mes_orden],
	UPPER(FORMAT(o.OrderDate, 'dddd', 'es-ES')) AS [dia_orden],
	DATEPART(YEAR, o.OrderDate ) AS [año_orden]
FROM Orders AS o
WHERE o.ShipCountry IN ('France', 'Brazil', 'belgium');

-- para los clientes VICTE, HANAR y SUPRD, y ordenados por fecha de pedido de la mas

SELECT 
	o.OrderID AS numero_orden,
	o.CustomerID AS cliente,
	o.ShipCountry AS pais_emvio,
	o.OrderDate AS fecha_orden,
	UPPER(FORMAT(o.OrderDate, 'MMMM', 'es-ES')) AS [mes_orden],
	UPPER(FORMAT(o.OrderDate, 'dddd', 'es-ES')) AS [dia_orden],
	DATEPART(YEAR, o.OrderDate ) AS [año_orden]
FROM Orders AS o
WHERE o.ShipCountry IN ('France', 'Brazil', 'Belgium')
	AND
	o.CustomerID IN ('VICTE', 'HANAR', 'SUPRD')
	AND
	o.OrderDate BETWEEN '1996-07-10' AND '1998-12-24';

-- cercana a la mas antigua.

SELECT 
	o.OrderID AS numero_orden,
	o.CustomerID AS cliente,
	o.ShipCountry AS pais_emvio,
	o.OrderDate AS fecha_orden,
	UPPER(FORMAT(o.OrderDate, 'MMMM', 'es-ES')) AS [mes_orden],
	UPPER(FORMAT(o.OrderDate, 'dddd', 'es-ES')) AS [dia_orden],
	DATEPART(YEAR, o.OrderDate ) AS [año_orden]
FROM Orders AS o
WHERE o.ShipCountry IN ('France', 'Brazil', 'belgium')
	AND
	o.CustomerID IN ('VICTE', 'HANAR', 'SUPRD')
	AND
	o.OrderDate BETWEEN '1996-07-10' AND '1998-12-24'
	ORDER BY o.OrderDate ASC;

/*
/*============================================================================

Ejercicio extra con la base de datos Northwind



============================================================================*/

USE NORTHWND;
GO

-- Mostrar las ventas realizadas en Francia, brazil y belgica
-- de 10 de julio de 1996 al 31 de Diciembre de 1998, que tenga Region de Envio,
-- para los clientes VICTE, HANAR y SUPRD, y ordenados por fecha de pedido de la mas
-- cercana a la mas antigua.
SELECT     
    o.OrderID AS numero_orden,
    o.CustomerID AS cliente,
    o.ShipCountry AS pais_envio,
    o.OrderDate AS fecha_orden,
    UPPER(FORMAT(o.OrderDate, 'MMMM', 'es-ES')) AS [mes_orden],
    UPPER(FORMAT(o.OrderDate, 'dddd', 'es-ES')) AS [dia_orden],
    DATEPART(YEAR, o.OrderDate) AS [anio_orden] -- <-- AQUÍ SE QUITÓ LA COMA SOBRANTE
FROM Orders AS o
WHERE o.ShipCountry IN ('France', 'Brazil', 'Belgium')
    AND o.CustomerID IN ('VICTE', 'HANAR', 'SUPRD')
    AND o.OrderDate BETWEEN '1996-07-10' AND '1998-12-31'
    AND o.ShipRegion IS NOT NULL -- Condición por "que tenga Region de Envio"
ORDER BY o.OrderDate DESC; -- DESC para que sea de la más cercana (reciente) a la más antigua
GO


-- OPERADOR BETWEEN
-- Permite comprobar si un valor se encuentra dentro de un rango inclusivo
/*==================================================================
WHERE columna BETWEEN limite_inferior AND limite_superior
====================================================================*/

-- Mostrar empleados con salario entre $15,000 y $20,000, incluyendo ambos limites
SELECT    
    e.id_empleado,
    e.nombre,
    e.salario
FROM empleados AS e
WHERE salario BETWEEN 15000 AND 20000
ORDER BY 3 DESC;

SELECT    
    e.id_empleado,
    e.nombre,
    e.salario
FROM empleados AS e
WHERE e.salario >= 15000 
  AND e.salario <= 20000;


-- Mostrar los productos que los precios esten en el rango de 100 y 200
SELECT    
    p.codigo,
    p.nombre,
    p.precio,
    p.existencia
FROM productos AS p
WHERE p.precio BETWEEN 100 AND 200;


-- Mostrar las ventas del 1 de enero de 2025 al 10 de enero de 2025
SELECT    
    v.id_venta AS [numero_venta],
    v.id_cliente AS [cliente],
    v.id_empleado AS [vendedor],
    v.fecha AS [fecha_venta],
    UPPER(FORMAT(v.fecha, 'MMMM', 'es-ES')) AS [mes_venta],
    UPPER(FORMAT(v.fecha, 'dddd', 'es-ES')) AS [dia_venta],
    DATEPART(YEAR, v.fecha) AS [año_venta]
FROM ventas AS v
WHERE v.fecha BETWEEN '2025-01-01' AND '2025-01-10'
ORDER BY [cliente] ASC;


-- Mostrar los productos que su rango de precios no este entre 100 y 400
SELECT    
    p.codigo,
    p.nombre,
    p.precio,
    p.existencia
FROM productos AS p
WHERE p.precio NOT BETWEEN 100 AND 400;


-- OPERADOR IN
-- permite comparar una columna con una lista de valores
/*==================================================================
WHERE columna IN (valor_1, valor_2, valor_3)
====================================================================*/

-- Mostrar productos pertenecientes a las categorias 1, 7 o 12
SELECT    
    p.codigo,
    p.nombre,
    p.precio,
    p.existencia,
    p.id_categoria
FROM productos AS p
WHERE p.id_categoria IN (1, 7, 12)
ORDER BY p.id_categoria;

SELECT    
    p.codigo,
    p.nombre,
    p.precio,
    p.existencia,
    p.id_categoria
FROM productos AS p
WHERE p.id_categoria = 1 
   OR p.id_categoria = 7 
   OR p.id_categoria = 12
ORDER BY p.id_categoria;


-- Mostrar todos los productos que no pertenecen a la categoria 1, 7 o 12
SELECT    
    p.codigo,
    p.nombre,
    p.precio,
    p.existencia,
    p.id_categoria
FROM productos AS p
WHERE p.id_categoria NOT IN (1, 7, 12)
ORDER BY p.id_categoria;


-- TODO: OPERADOR LIKE
/*==================================
OPERADOR LIKE
Permite buscar patrones dentro de valores de texto
Sintaxis: WHERE columna LIKE 'patron';
Comodines:
- %: cero, uno o varios valores
- _: representa un solo carácter
- [abc]: un caracter incluido en la lista
- [a-f]: un caracter incluido en el rango
- [^abc]: un caracter no incluido en la lista
==================================*/

-- Buscar codigos de productos que comiencen con P001 (Se eliminó coma sobrante antes de FROM)
SELECT    
    p.codigo,
    p.nombre,
    p.precio
FROM productos AS p
WHERE p.codigo LIKE 'P001%';

SELECT *
FROM Customers AS c
WHERE c.CompanyName LIKE 'Bo';


-- Buscar los correos de los clientes que terminen exactamente con 10@mail.com (Se corrigió sintaxis de columnas)
SELECT    
    c.id_cliente,
    c.nombre,
    c.correo
FROM clintes AS c
WHERE c.correo LIKE '%10@mail.com';


-- Mostrar los nombres de los productos que contienen el caracter 1 (Se eliminó coma sobrante)
SELECT    
    p.codigo,
    p.nombre,
    p.precio
FROM productos AS p
WHERE p.nombre LIKE '%1%'; -- Usado %1% para que contenga el 1 en cualquier posición

SELECT *
FROM Customers AS c
WHERE c.CompanyName LIKE 'Bo%';

SELECT *
FROM Customers AS c
WHERE c.CompanyName LIKE '%er%';


-- Comodin de un caracter (_)
-- Mostrar los codigos con P000 y exactamente un caracter adicional
SELECT    
    p.codigo,
    p.nombre,
    p.precio
FROM productos AS p
WHERE p.codigo LIKE 'P000_';


-- Patrones con corchetes
SELECT    
    p.codigo,
    p.nombre,
    p.precio
FROM productos AS p
WHERE p.codigo LIKE 'P000[1-5]';

SELECT    
    p.codigo,
    p.nombre,
    p.precio
FROM productos AS p
WHERE p.codigo LIKE 'P000[^1-5]';


-- Buscar un guion bajo literal
-- En LIKE, el guion bajo _ es un comodin. Para buscarlo literal se usa [_]
SELECT * 
FROM CIUDADES AS c
WHERE c.NOMBRE LIKE '%[_]%';
*/