# Diccionario de datos de la base de datos sobre los cursos que imparte un profesor (ejercicio 2)

1. Información general

| Elemento | Valor |
|-----------|------|
| Proyecto | Registro expediente de cursos impartidos por un profesor |
| Versión | 1.0 |
| Fecha | Junio 2026 |
| Elaboró | Lic. Patricio Fernando Panales Nolasco |
| SGBD | SQLServer |

2. Descripción del sistema de base de datos 

- Profesor
- Curso

Permite controlar la asignación de cursos a profesores 

3. Catálogo de restricciones utlizadas

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

## Tabla: Profesor

**Descripción**

Almacena la información de los profesores de la universidad

| Campo | Tipo | Longitud | Restricciones | Descripción |
|-----------|-----------|-----------|-----------|-----------|
| id_profesor | INT | - | PK, AI, NN | Identificador único del profesor |
| nombre    | NVARCHAR    | 40    | NN    | Nombre   |
| apellido_paterno    | NVARCHAR    | 20    | NN    | Apellido paterno   |
| apellido_materno    | NVARCHAR    | 20    | NULL    | Apellido materno   |

## Tabla: Especialidad

Tabla de atributo multivalor

| Campo | Tipo | Longitud | Restricciones | Descripción |
|-----------|-----------|-----------|-----------|-----------|
| id_especialidad | INT | - | PK, AI, NN | Área de especialidad del profesor |
| id_profesor | INT | - | FK, NN | Identificador único del profesor |
| nombre    | NVARCHAR    | 30    | NN    | Nombre   |


## Tabla: Curso

**Descripción**

Almacena la información de los cursos ofertados por la universidad

| Campo | Tipo | Longitud | Restricciones | Descripción |
|-----------|-----------|-----------|-----------|-----------|
| id_curso | INT | - | PK, AI, NN | Identificador único del curso |
| nombre | NVARCHAR | 20 | NN | Nombre del curso |
| creditos | INT | - | NN | Número de créditos del curso |
| id_profesor | INT | - | FK, NN | Identificador único del profesor |

--

5. Relaciones en la base de datos

| Relación | Cardinalidad | Descripción |
|-----------|-----------|-----------|
| Profesor -> Curso | 1:N | Un profesor puede impartir varios cursos |

6. Matriz de claves foráneas

| Tabla | Campo FK | Referencia |
|-----------|-----------|-----------|
| Curso | id_profesor | Profesor (id_profesor) |
| Especialidad | id_profesor | Profesor (id_profesor) |


7. Integridad referencial

| Código | Reglas |
|-----------|-----------|
| IR-01 | No se puede registrar un curso con un profesor inexistente |
| IR-02 | Todo curso debe estar asignado a un profesor válido |
| IR-03 | No se puede eliminar un profesor que tenga cursos asignados sin antes reasignarlos o eliminarlos |

8. Reglas del negocio

| Código | Descripción |
|-----------|-----------|
| RN-01 | Un profesor puede impartir varios cursos |
| RN-02 | Un curso solamente puede ser impartido por un profesor |
| RN-03 | Puede existir un profesor que actualmente no imparta cursos |
| RN-04 | Todo curso debe ser asignado a un profesor |

9. Diagrama relacional

![Profesor](../img/Relacional/Ejercicio2.jpg)

