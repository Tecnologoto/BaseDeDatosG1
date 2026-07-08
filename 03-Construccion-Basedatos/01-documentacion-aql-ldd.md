# Construcción de base de datos con SQL-LDD

SQL (Structured Query Language) se divide en cinco grandes categorías (los marcados en negritas se ven en este curso):

1. **DDL (Data Definition Language)**
2. **DML (Data Manipulation Language)**
3. **DQL (Data Query Language)**
4. DCL (Data Control Language)
5. TCL (Transaction Control Language)

## SQL-DDL

**Lenguaje de definición de datos**


Se utiliza para **crear y modificar la estructura** de una base de datos

Con DDL trabajamos sobre los objetos de la base de datos:

- Base de datos
- Tablas
- Vistas
- Índices
- Restricciones
- Esquemas
- Store procedures
- Triggers
- Functions

**Comandos principales**

|Comando|Función|
|----|----|
|CREATE|Crear objetos|
|ALTER|Modificar objetos|
|DROP|Eliminar objetos|
|TRUNCATE|Vaciar una tabla|

## SQL-DML

**Lenguaje de manipulación de datos**

Sirve para **trabajar con la información almacenada**
Aquí no cambia la estructura, sino los registros

**COMANDOS PRINCIPALES**

|Comando|Función|
|----|----|
|INSERT|Inserta registros|
|UPDATE|Actualizar registros|
|DELETE|Eliminar registros|

## SQL-DQL

**Lenguaje de consulta de datos**

Su función es **consultar información**

**Comando principal**

|Comando|Función|
|----|----|
|SELECT|Consultar información|

Generalmente se combina con: 
- WHERE
- ORDER BY
- GROUP BY
- HAVING
- JOIN (LEFT, RIGHT, INNER, CROSS Y FULL)
- DISTINCT
- TOP / LIMIT
- Fuciones de agregado (SUM, AVG, MAX, MIN, COUNT)
- Funciones de ventana (window functions)

## Nomenclatura snake_case

**snake_case** es la convención más recomendada hoy si se busca una nomenclatura moderna, portable y alineada con buenas prácticas en distintos motores de base de datos. 

La razón es que funciona de forma consistente en **SQLServer**, ***MySQL** y especialmente en **PostgreSQL**. Con snake_case se evitan problemas de mayúsculas y se hacen las consultas sean más legibles

**Estandar de construcción:**

|Objeto|Convención|Ejemplo|
|----|----|---|
|Base de datos|snake_case|control_escolar|
|Esquema|snake_case|venta, rh, seguridad|
|Tabla|Singular en snake_case|cliente, pedido, detalle_pedido|
|Columna|snake_case|cliente_id, fecha_registro, detalle_pedido, nombre, correo_electronico|
|PK|<tabla>_id|cliente_id, categoria_id|
|FK|Igual que la PK referenciada|cliente_id, producto_id|
|Tabla puente|<tabla1>_<tabla2>|alumno_curso, proveedor_producto|


**Nombrar las restricciones**

- pk_cliente
- fk_pedido_cliente -> pk_tablaorigen_tablareferenciada
- uq_cliente_correo_electronico
- ck_producto_precio
- df_cliente_activo
