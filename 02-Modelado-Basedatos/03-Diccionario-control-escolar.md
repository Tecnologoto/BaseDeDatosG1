# Diccionario de datos de la base de datos del control escolar (ejemplo)

1. Información general

| Elemento | Valor |
|-----------|------|
| Proyecto | Control Escolar |
| Versión | 1.0 |
| Fecha | Junio 2026 |
| Elaboró | Lic. Patricio Fernando Panales Nolasco |
| SGBD | SQLServer |

2. Descripción del sistema de base de datos 

El sistema administra:
- Carreras
- Alumnos
- Profesores
- Materias
- Grupos
- Inscripciones

Permite controlar la oferta académica y la inscripción de estudiantes

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

## Tabla: Carrera

**Descripción**

Almacena las carrera ofertadas por la universidad

| Campo | Tipo | Longitud | Restricciones | Descripción |
|-----------|-----------|-----------|-----------|-----------|
| id_carrera | INT | - | PK, AI, NN | Identificador único de la carrera |
| nombre | VARCHAR | 100 | UQ, NN | Nombre de la carrera |
| duración_cuatrimestre | INT | - | NN, CK(>0) | Nombre de la carrera |

## Tabla: Alumnos

**Descripción**

Almacena información de los estudiantes

| Campo | Tipo | Longitud | Restricciones | Descripción |
|-----------|-----------|-----------|-----------|-----------|
| id_alumno    | INT    | -    | PK, AI, NN    | Identificador único del alumno    |
| matricula    | VARCHAR    | 100    | UQ, NN    | Matrícula institucional   |
| nombre    | VARCHAR    | 30    | NN    | Nombre   |
| apellido_paterno    | VARCHAR    | 50    | NN    | Apellido paterno   |
| apellido_materno    | VARCHAR    | 50    | NULL    | Apellido materno   |
| correo    | VARCHAR    | 100    | UQ, NN    | Correo institucional   |
| fecha_nacimiento    | DATE    | -    | NN    | Fecha de nacimiento   |
| id_carrera    | INT    | -    | FK, NN    | Carrera   |

--

5. Relaciones en la base de datos

| Relación | Cardinalidad | Descripción |
|-----------|-----------|-----------|
| Carrera -> Alumno    |  1:N   | Una carrera tiene muchos alumnos    |
| Carrera -> Materia    |  1:N   | Una carrera tiene muchas materias    |
| Profesor -> Grupo    |  1:N   | Un profesor puede impartir varios grupos    |
| Materia -> Grupo    |  1:N   | Una materia puede abrirse en varios grupos    |
| Alumno -> Inscripción    |  1:N   | Un alumno puede tener varias inscripciones    |
| Grupo -> Inscripción    |  1:N   | Una grupo puede tener muchos alumnos    |

6. Matriz de claves foráneas

| Tabla | Campo FK | Referencia |
|-----------|-----------|-----------|
| Alumno    |  id_carrera   | Carrera (id_carrera)    |
| Materia   |  id_carrera   | Carrera (id_carrera)    |
| Grupo   |  id_profesor   | Profesor (id_profesor)    |
| Grupo   |  id_materia   | Materia (id_materia)    |
| Inscripción   |  id_alumno   | Alumno (id_alumno)    |
| Inscripción   |  id_grupo   | Grupo (id_grupo)    |

7. Integridad referencial

| Código | Reglas |
|-----------|-----------|
| IR-01    | No se puede registrar un alumno con una carrera inexistente    |
| IR-02    | No se puede crear un grupo para una materia inexistente    |
| IR-03    | No se puede crear un grupo para un profesor inexistente    |
| IR-04    | No se puede escribir un alumno en un grupo inexistente    |
| IR-05    | No se puede eliminar una carrera que tenga alumnos asociados sin antes reasignarlos o eliminarlos    |

8. Reglas del negocio

| Código | Descripción |
|-----------|-----------|
| RN-01    | Un alumno pertenece a una sola carrera    |
| RN-02    | Una carrera puede tener muchos alumnos    |
| RN-03    | Una carrera puede tener muchas materias    |
| RN-04    | Un profesor puede impartir varios grupos    |
| RN-05    | Un grupo solo puede tener un profesor asignado    |
| RN-06    | La calificación debe estar entre 0.0 y 10.0     |

9. Diagrama relacional