# Diccionario de datos de la base de datos de la venta de productos (ejercicio 4)

1. Información general

| Elemento | Valor |
|-----------|------|
| Proyecto | Venta de productos |
| Versión | 1.0 |
| Fecha | Junio 2026 |
| Elaboró | Lic. Patricio Fernando Panales Nolasco |
| SGBD | SQLServer |

2. Descripción del sistema de base de datos 

El sistema administra:
- Cliente
- Pedido
- Tiene
- Producto

Permite controlar las ventas realizadas por la empresa

3. Catálogo de restricciones utilizadas

| Código | Significado |
|----------|----------|
| PK    | Primary Key |
| FK    | Foreign Key |
| NN    | Not Null |
| UQ    | Unique |
| AI    | Auto Increment |
| CK    | Check |
| DF    | Default |

4. Diccionario de datos

## Tabla Cliente

**Descripción**

Almacena la información de los clientes de la empresa

| Campo | Tipo | Longitud | Restricciones | Descripción |
|-----------|-----------|-----------|-----------|-----------|
| id_cliente | INT | - | PK, AI, NN | Identificador único del cliente |
| nombre | VARCHAR | 150 | NN | Nombre o razón social del cliente |
| rfc | NVARCHAR | 20 | UQ, NN | RFC del cliente |

## Tabla Pedido

**Descripción**

Almacena los pedidos realizados por los clientes

| Campo | Tipo | Longitud | Restricciones | Descripción |
|-----------|-----------|-----------|-----------|-----------|
| id_pedido | INT | - | PK, AI, NN | Identificador único del pedido |
| fecha | DATE | - | NN | Fecha de realización del pedido |
| id_cliente | INT | - | FK, NN | Cliente que realizó el pedido |

## Tabla Producto

**Descripción**

Almacena los productos ofrecidos por la empresa

| Campo | Tipo | Longitud | Restricciones | Descripción |
|-----------|-----------|-----------|-----------|-----------|
| id_producto | INT | - | PK, AI, NN | Identificador único del producto |
| nombre | NVARCHAR | 40 | NN | Nombre del producto |
| precio | DECIMAL | 10,2 | NN, CK(>0) | Precio del producto |

## Tabla Tiene

**Descripción**

Se trata de la relación entre las entidades Pedido y Producto

| Campo | Tipo | Longitud | Restricciones | Descripción |
|-----------|-----------|-----------|-----------|-----------|
| id_cliente | INT | - | FK, NN | Cliente |
| id_producto | INT | - | FK, NN | Producto |

--

5. Relaciones en la base de datos

| Relación | Cardinalidad | Descripción |
|-----------|-----------|-----------|
| Cliente -> Pedido | 1:N | Un cliente puede realizar muchos pedidos |
| Pedido -> Tiene | 1:N | Un pedido puede tener varios productos |
| Producto -> Tiene | 1:N | Un producto puede tener muchos pedidos |

6. Matriz de claves foráneas

| Tabla | Campo FK | Referencia |
|-----------|-----------|-----------|
| Pedido | id_cliente | Cliente (id_cliente) |
| Tiene | id_pedido | Pedido (id_pedido) |
| Tiene | id_producto | Producto (id_producto) |

7. Integridad referencial

| Código | Reglas |
|-----------|-----------|
| IR-01 | No se puede registrar un pedido con un cliente inexistente |
| IR-02 | No se puede registrar un detalle de pedido con un pedido inexistente |
| IR-03 | No se puede registrar un detalle de pedido con un producto inexistente |
| IR-04 | No se puede eliminar un pedido que tenga detalles asociados sin antes eliminarlos |
| IR-05 | No se puede eliminar un producto que esté asociado a un detalle de pedido |
| IR-06 | Todo detalle de pedido debe estar asociado a un pedido y a un producto válidos |

8. Reglas del negocio

| Código | Descripción |
|-----------|-----------|
| RN-01 | Un cliente puede realizar muchos pedidos |
| RN-02 | Cada pedido pertenece a un solo cliente |
| RN-03 | Un pedido puede contener varios productos |
| RN-04 | Un producto puede aparecer en muchos pedidos |
| RN-05 | Un pedido debe contener al menos un producto |
| RN-06 | Un producto puede no haber sido vendido |
| RN-07 | El detalle del pedido no existe sin pedido |
| RN-08 | El detalle del pedido no existe sin producto |
| RN-09 | El detalle almacena la cantidad de productos pedidos |
| RN-10 | El detalle almacena el precio de venta del producto |

9. Diagrama relacional

![Pedidos](../img/Relacional/Ejercicio4.jpg)
