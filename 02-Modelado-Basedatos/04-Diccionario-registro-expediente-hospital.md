# Diccionario de datos de la base de datos del registro de expediente hospitalario (ejercicio 1)

1. Información general

| Elemento | Valor |
|-----------|------|
| Proyecto | Registro expediente hospitalario |
| Versión | 1.0 |
| Fecha | Junio 2026 |
| Elaboró | Lic. Patricio Fernando Panales Nolasco |
| SGBD | SQLServer |

2. Descripción del sistema de base de datos 

- Pacientes
- Expedientes médicos

Permite controlar el registro de pacientes y la administración de sus expedientes médicos

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

## Tabla: Paciente

**Descripción**

Almacena la información de los pacientes registrados en el hospital


| Campo | Tipo | Longitud | Restricciones | Descripción |
|-----------|-----------|-----------|-----------|-----------|
| id_paciente | INT | - | PK, AI, NN | Identificador único del paciente |
| nombre-de-pila | VARCHAR | 100 | NN | Nombre completo del paciente |
| apellido_paterno    | VARCHAR    | 50    | NN    | Apellido paterno   |
| apellido_materno    | VARCHAR    | 50    | NN    | Apellido materno   |
| fecha_nacimiento    | DATE    | -    | NN    | Fecha de nacimiento   |

## Tabla: Expediente

**Descripción**

Almacena la información médica básica asociada a cada paciente

| Campo | Tipo | Longitud | Restricciones | Descripción |
|-----------|-----------|-----------|-----------|-----------|
| id_expediente | INT | - | PK, AI, NN | Identificador del expediente |
| fecha_apertura | DATE | - | NN | Fecha de apertura del expediente |
| tipo_sangre | VARCHAR | 5 | NN, CK | Tipo de sangre del paciente |
| id_paciente | INT | - | FK, UQ, NN | Paciente propietario del expediente |

--

5. Relaciones en la base de datos

| Relación | Cardinalidad | Descripción |
|-----------|-----------|-----------|
| Paciente -> Expediente | 1:1 | Cada paciente tiene un expediente médico |
| Expediente -> Paciente | 1:1 | Cada expediente médico pertenece a un único paciente |

6. Matriz de claves foráneas

| Tabla | Campo FK | Referencia |
|-----------|-----------|-----------|
| Expediente_Medico | id_paciente | Paciente (id_paciente) |

7. Integridad referencial

| Código | Regla |
|-----------|-----------|
| IR-01 | No se puede registrar un expediente médico para un paciente inexistente |
| IR-02 | No se puede eliminar un paciente mientras exista un expediente médico asociado |
| IR-03 | Cada expediente médico debe estar vinculado a un paciente válido |
| IR-04 | El campo id_paciente debe ser único en la tabla Expediente_Medico para garantizar la relación 1:1 |

8. Reglas del negocio

| Código | Descripción |
|-----------|-----------|
| RN-01 | Cada paciente debe tener exactamente un expediente médico |
| RN-02 | Cada expediente médico pertenece a un único paciente |
| RN-03 | No puede existir ningún expediente médico sin paciente |
| RN-04 | No puede existir un paciente sin expediente médico |

9. Diagrama relacional

![Hospital](../img/Relacional/Ejercicio1.jpg)
