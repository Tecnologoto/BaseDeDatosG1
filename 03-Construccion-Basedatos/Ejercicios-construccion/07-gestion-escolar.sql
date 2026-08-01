-- CREAR BASE DE DATOS
CREATE DATABASE gestion_escolar;
GO

-- USAR BASE DE DATOS
USE gestion_escolar;
GO

-- 1. TABLA DEPARTAMENTO (Sin dependencias)
CREATE TABLE departamento(
    numero_departamento INT NOT NULL IDENTITY(1,1),
    CONSTRAINT pk_numero_departamento PRIMARY KEY(numero_departamento),
    nombre_departamento VARCHAR(30) NOT NULL,
    edificio VARCHAR(30) NOT NULL
);
GO

-- 2. TABLA PROFESOR (Depende de departamento)
CREATE TABLE profesor(
    numero_profesor INT NOT NULL IDENTITY(1,1),
    CONSTRAINT pk_numero_profesor PRIMARY KEY(numero_profesor),
    nombre_profesor VARCHAR(20) NOT NULL,
    apellido_paterno VARCHAR(20) NOT NULL,
    apellido_materno VARCHAR(20) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    numero_departamento INT NOT NULL,
    CONSTRAINT fk_profesor_numero_departamento FOREIGN KEY(numero_departamento) REFERENCES departamento(numero_departamento)
);
GO

-- 3. TABLA MATERIA (Depende de profesor)
CREATE TABLE materia(
    clave_materia INT NOT NULL IDENTITY(1,1),
    CONSTRAINT pk_clave_materia PRIMARY KEY(clave_materia),
    nombre_materia VARCHAR(30) NOT NULL,
    creditos INT NOT NULL,
    numero_profesor INT NOT NULL,
    CONSTRAINT fk_materia_numero_profesor FOREIGN KEY(numero_profesor) REFERENCES profesor(numero_profesor)
);
GO

-- 4. TABLA PROYECTO (Sin dependencias)
CREATE TABLE proyecto(
    numero_proyecto INT NOT NULL IDENTITY(1,1),
    CONSTRAINT pk_numero_proyecto PRIMARY KEY(numero_proyecto),
    nombre_proyecto VARCHAR(30) NOT NULL,
    presupuesto DECIMAL(10,2) NOT NULL
);
GO

-- 5. TABLA PARTICIPA (Depende de profesor y proyecto)
CREATE TABLE participa(
    numero_profesor INT NOT NULL,
    CONSTRAINT fk_participa_numero_profesor FOREIGN KEY(numero_profesor) REFERENCES profesor(numero_profesor),
    numero_proyecto INT NOT NULL,
    CONSTRAINT fk_participa_numero_proyecto FOREIGN KEY(numero_proyecto) REFERENCES proyecto(numero_proyecto),
    CONSTRAINT pk_participa PRIMARY KEY(numero_profesor, numero_proyecto),
    rol VARCHAR(20) NOT NULL,
    fecha_inicio DATE NOT NULL
);
GO

-- 6. TABLA ALUMNO (Sin dependencias externas principales)
CREATE TABLE alumno(
    matricula INT NOT NULL IDENTITY(1,1),
    CONSTRAINT pk_matricula PRIMARY KEY(matricula),
    nombre VARCHAR(20) NOT NULL,
    apellido_paterno VARCHAR(20) NOT NULL,
    apellido_materno VARCHAR(20) NOT NULL,
    fecha_nacimiento DATE NOT NULL
);
GO

-- 7. TABLA CREDENCIAL (Relación 1 a 1 con alumno, la FK vive aquí)
CREATE TABLE credencial(
    num_cred INT NOT NULL IDENTITY(1,1),
    CONSTRAINT pk_num_cred PRIMARY KEY(num_cred),
    fecha_emision DATE NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    matricula INT NOT NULL,
    CONSTRAINT uq_credencial_matricula UNIQUE(matricula),
    CONSTRAINT fk_credencial_matricula FOREIGN KEY(matricula) REFERENCES alumno(matricula)
);
GO

-- 8. TABLA TELEFONO (Depende de alumno)
CREATE TABLE telefono(
    id_telefono INT NOT NULL IDENTITY(1,1),
    CONSTRAINT pk_id_telefono PRIMARY KEY(id_telefono),
    numero_telefono VARCHAR(15) NOT NULL,
    matricula INT NOT NULL,
    CONSTRAINT fk_telefono_matricula FOREIGN KEY(matricula) REFERENCES alumno(matricula)
);
GO

-- 9. TABLA CURSA (Tabla intermedia Alumno - Materia)
CREATE TABLE cursa(
    matricula INT NOT NULL,
    CONSTRAINT fk_cursa_matricula FOREIGN KEY(matricula) REFERENCES alumno(matricula),
    clave_materia INT NOT NULL,
    CONSTRAINT fk_cursa_clave_materia FOREIGN KEY(clave_materia) REFERENCES materia(clave_materia),
    CONSTRAINT pk_cursa PRIMARY KEY(matricula, clave_materia),
    fecha_inscripcion DATE NOT NULL
);
GO

-- 10. TABLA DEPENDIENTE (Depende de profesor)
CREATE TABLE dependiente(
    nombre_dependiente VARCHAR(20) NOT NULL,
    numero_profesor INT NOT NULL,
    CONSTRAINT fk_dependiente_numero_profesor FOREIGN KEY(numero_profesor) REFERENCES profesor(numero_profesor),
    CONSTRAINT pk_dependiente PRIMARY KEY(nombre_dependiente, numero_profesor),
    paretesco VARCHAR(20) NOT NULL,
    fecha_nacimiento DATE NOT NULL
);
GO