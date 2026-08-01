--CREAR BASE DE DATOS
CREATE DATABASE proyecto;
GO

--USAR BASE DE DATOS
USE proyecto;
GO

--TABLA SUCURSAL (Sin dependencias)
CREATE TABLE sucursal(
    clave_sucursal INT NOT NULL IDENTITY(1,1),
    CONSTRAINT pk_clave_sucursal PRIMARY KEY(clave_sucursal),
    nombre_sucursal VARCHAR(30) NOT NULL,
    ciudad VARCHAR(30) NOT NULL,
    estado VARCHAR(30) NOT NULL
);

--TABLA PUESTO (Sin dependencias)
CREATE TABLE puesto(
    clave_puesto INT NOT NULL IDENTITY(1,1),
    CONSTRAINT pk_clave_puesto PRIMARY KEY(clave_puesto),
    nombre_puesto VARCHAR(30) NOT NULL,
    salario_minimo DECIMAL(10,2) NOT NULL,
    CONSTRAINT ck_puesto_salario_minimo CHECK(salario_minimo >= 0),
    salario_maximo DECIMAL(10,2) NOT NULL,
    CONSTRAINT ck_puesto_salario_maximo CHECK(salario_maximo >= 0),
    CONSTRAINT ck_puesto_salario CHECK(salario_maximo >= salario_minimo),
    nivel_jerarquico INT NOT NULL
);

--TABLA PROYECTO (Sin dependencias)
CREATE TABLE proyecto(
    clave_proyecto INT NOT NULL IDENTITY(1,1),
    CONSTRAINT pk_clave_proyecto PRIMARY KEY(clave_proyecto),
    nombre_proyecto VARCHAR(30) NOT NULL,
    CONSTRAINT uq_proyecto_nombre UNIQUE(nombre_proyecto),
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    CONSTRAINT ck_proyecto_fecha CHECK(fecha_fin >= fecha_inicio),
    presupuesto DECIMAL(10,2) NOT NULL,
    CONSTRAINT ck_proyecto_presupuesto CHECK(presupuesto >= 0)
);

--TABLA CAPACITACION (Sin dependencias)
CREATE TABLE capacitacion(
    capacitacion_id INT NOT NULL IDENTITY(1,1),
    CONSTRAINT pk_capacitacion_id PRIMARY KEY(capacitacion_id),
    nombre_capacitacion VARCHAR(30) NOT NULL,
    CONSTRAINT uq_capacitacion_nombre UNIQUE(nombre_capacitacion),    
    duracion_horas DECIMAL(5,2) NOT NULL,
    CONSTRAINT ck_capacitacion_duracion CHECK(duracion_horas > 0)
);

--TABLA TELEFONO (Depende de sucursal)
CREATE TABLE telefono(
    numero_telefono VARCHAR(15) NOT NULL,
    CONSTRAINT pk_numero_telefono PRIMARY KEY(numero_telefono),
    clave_sucursal INT NOT NULL,
    CONSTRAINT fk_telefono_clave_sucursal FOREIGN KEY(clave_sucursal) REFERENCES sucursal(clave_sucursal)
);

--TABLA DEPARTAMENTO 
-- Nota: numero_empleado se define temporalmente como NULL para romper la dependencia circular con empleado
CREATE TABLE departamento(
    clave_departamento INT NOT NULL IDENTITY(1,1),
    CONSTRAINT pk_clave_departamento PRIMARY KEY(clave_departamento),
    nombre_departamento VARCHAR(30) NOT NULL,
    ubicacion VARCHAR(30) NOT NULL,
    presupuesto DECIMAL(10,2) NOT NULL,
    CONSTRAINT ck_departamento_presupuesto CHECK(presupuesto >= 0),
    numero_empleado INT NULL -- Se permite NULL inicialmente para evitar conflicto circular
);

--TABLA EMPLEADO (Depende de sucursal, puesto y departamento)
CREATE TABLE empleado(
    numero_empleado INT NOT NULL IDENTITY(1,1),
    CONSTRAINT pk_numero_empleado PRIMARY KEY(numero_empleado),
    nombre VARCHAR(20) NOT NULL,
    apellido_paterno VARCHAR(20) NOT NULL,
    apellido_materno VARCHAR(20) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    curp VARCHAR(18) NOT NULL,
    CONSTRAINT uq_empleado_curp UNIQUE(curp),
    id_jefe INT,
    CONSTRAINT fk_empleado_jefe FOREIGN KEY(id_jefe) REFERENCES empleado(numero_empleado),
    clave_departamento INT NOT NULL,
    CONSTRAINT fk_empleado_departamento FOREIGN KEY(clave_departamento) REFERENCES departamento(clave_departamento),
    clave_puesto INT NOT NULL,
    CONSTRAINT fk_empleado_puesto FOREIGN KEY(clave_puesto) REFERENCES puesto(clave_puesto),
    clave_sucursal INT NOT NULL,
    CONSTRAINT fk_empleado_sucursal FOREIGN KEY(clave_sucursal) REFERENCES sucursal(clave_sucursal)
);

--Actualizar la relación faltante: Agregar la FK de departamento hacia empleado
ALTER TABLE departamento
ADD CONSTRAINT fk_departamento_numero_empleado 
FOREIGN KEY(numero_empleado) REFERENCES empleado(numero_empleado);

--TABLA PARTICIPA (Tabla intermedia Empleado - Proyecto)
CREATE TABLE participa(
    numero_empleado INT NOT NULL,
    CONSTRAINT fk_participa_numero_empleado FOREIGN KEY(numero_empleado) REFERENCES empleado(numero_empleado),
    clave_proyecto INT NOT NULL,
    CONSTRAINT fk_participa_clave_proyecto FOREIGN KEY(clave_proyecto) REFERENCES proyecto(clave_proyecto),
    CONSTRAINT pk_participa PRIMARY KEY(numero_empleado, clave_proyecto),
    fecha_asignacion DATE NOT NULL,
    horas_trabajadas DECIMAL(5,2) NOT NULL,
    rol VARCHAR(30) NOT NULL
);

--TABLA ASISTIR (Tabla intermedia Empleado - Capacitacion)
CREATE TABLE asistir(
    numero_empleado INT NOT NULL,
    CONSTRAINT fk_asistir_numero_empleado FOREIGN KEY(numero_empleado) REFERENCES empleado(numero_empleado),
    capacitacion_id INT NOT NULL,
    CONSTRAINT fk_asistir_capacitacion FOREIGN KEY(capacitacion_id) REFERENCES capacitacion(capacitacion_id),
    CONSTRAINT pk_asistir PRIMARY KEY(numero_empleado, capacitacion_id),
    fecha_inscripcion DATE NOT NULL,
    calificacion DECIMAL(3,1) NOT NULL,
    CONSTRAINT ck_asistir_calificacion CHECK(calificacion >= 0 AND calificacion <= 10),
    status VARCHAR(20) NOT NULL,
    CONSTRAINT ck_asistir_status CHECK(status IN ('inscrito', 'completado', 'cancelado'))
);