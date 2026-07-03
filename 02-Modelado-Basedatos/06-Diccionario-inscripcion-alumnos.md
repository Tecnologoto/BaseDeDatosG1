# Diccionario de datos de la base de datos sobre la inscirpción de alumnos a materias (ejercicio 3)

1. Información general

| Elemento | Valor |
|-----------|------|
| Proyecto | Registro expediente de cursos impartidos por un profesor |
| Versión | 1.0 |
| Fecha | Junio 2026 |
| Elaboró | Lic. Patricio Fernando Panales Nolasco |
| SGBD | SQLServer |

2. Descripción del sistema de base de datos 

- Alumno
- Materia
- Inscripción

Permite controlar la inscrición de alumnos a materias 

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

## Tabla: Alumno

**Descripción**

Almacena la información de los alumnos de la institución

| Campo | Tipo | Longitud | Restricciones | Descripción |
|-----------|-----------|-----------|-----------|-----------|
| id_alumno | INT | - | PK, AI, NN | Identificador único del alumno |
| matricula | VARCHAR | 10 | UQ, NN | Matrícula del alumno |
| nombre    | VARCHAR    | 30    | NN    | Nombre   |
| apellido_paterno    | VARCHAR    | 20    | NN    | Apellido paterno   |
| apellido_materno    | VARCHAR    | 20    | NULL    | Apellido materno   |
| semestre | VARCHAR | 10 | NN | Semestre que cursa el alumno |

## Tabla Inscripción

**Descripción**

Se trata de la tabla de relación M:N entre la entidad Alumno y Materia

| Campo | Tipo | Longitud | Restricciones | Descripción |
|-----------|-----------|-----------|-----------|-----------|
| id_alumno | INT | - | FK, NN | Alumno |
| id_materia | INT | - | FK, NN | Materia |
| fecha_inicio | DATE | - | NN | Fecha en que se realizó la inscripción |
| calificacion_final | DECIMAL | 10,2 | CK | Calificación final obtenida por el alumno |

## Tabla Materia

**Descripción**

Almacena la información de las materias ofertadas por la escuela

| Campo | Tipo | Longitud | Restricciones | Descripción |
|-----------|-----------|-----------|-----------|-----------|
| id_materia | INT | - | PK, AI, NN | Identificador único de la materia |
| nombre_materia | NVARCHAR | 30 | NN, UQ | Nombre de la materia |
| creditos | INT | - | NN, CK(>0) | Número de créditos de la materia |

--

5. Relaciones en la base de datos

| Relación | Cardinalidad | Descripción |
|-----------|-----------|-----------|
| Alumno -> Inscripcion | 1:N | Un alumno puede tener varias inscripciones |
| Materia -> Inscripcion | 1:N | Una materia puede tener muchos alumnos inscritos |

6. Matriz de claves foráneas

| Tabla | Campo FK | Referencia |
|-----------|-----------|-----------|
| Inscripcion | id_alumno | Alumno (id_alumno) |
| Inscripcion | id_materia | Materia (id_materia) |

7. Integridad referencial

| Código | Reglas |
|-----------|-----------|
| IR-01 | No se puede registrar una inscripción para un alumno inexistente |
| IR-02 | No se puede registrar una inscripción para una materia inexistente |
| IR-03 | No se puede eliminar un alumno con inscripciones registradas sin antes eliminarlas |
| IR-04 | No se puede eliminar una materia que tenga alumnos inscritos sin antes eliminar las inscripciones |
| IR-05 | Toda inscripción debe estar asociada a un alumno y una materia válidos |

8. Reglas del negocio

| Código | Descripción |
|-----------|-----------|
| RN-01 | Un alumno puede inscribirse en varias materias |
| RN-02 | Una materia puede tener muchos alumnos inscritos |
| RN-03 | Puede existir una materia sin alumnos inscritos |
| RN-04 | Todo alumno debe estar inscrito en al menos una materia |
| RN-05 | De cada inscripción se debe almacenar la fecha de inscripción |
| RN-06 | De cada inscripción se debe almacenar la calificación final |

9. Diagrama relacional

![Inscripción](../img/Relacional/Ejercicio3.jpg)
