-- CREAR BASE DE DATOS
CREATE DATABASE company;
GO

-- USAR BASE DE DATOS
USE company;
GO

-- 1. TABLA DEPARTMENT (Creada primero, pero el supervisor_ssn permite NULL para romper el ciclo inicial)
CREATE TABLE department(
    name VARCHAR(20) NOT NULL,
    number INT NOT NULL,
    CONSTRAINT pk_department_name_number 
    PRIMARY KEY(name, number),
    start_date DATE NOT NULL,
    supervisor_ssn INT NULL -- Permite NULL temporalmente para evitar el bloqueo circular con employee
);
GO

-- 2. TABLA EMPLOYEE (Depende de department)
CREATE TABLE employee(
    ssn INT NOT NULL IDENTITY(1,1),
    CONSTRAINT pk_ssn 
    PRIMARY KEY(ssn),
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    address VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2) NOT NULL,
    CONSTRAINT ck_employee_salary 
    CHECK(salary > 0),
    gender CHAR(1) NOT NULL,
    CONSTRAINT ck_employee_gender 
    CHECK(gender IN ('M','F')),
    birth_date DATE NOT NULL,
    name_department VARCHAR(20) NOT NULL,
    number_department INT NOT NULL,
    CONSTRAINT fk_employee_department 
    FOREIGN KEY(name_department, number_department) 
    REFERENCES department(name, number),
    supervisor_ssn INT,
    CONSTRAINT fk_employee_supervisor 
    FOREIGN KEY(supervisor_ssn) 
    REFERENCES employee(ssn)
);
GO

-- 3. Actualizar la FK pendiente de department hacia employee (para el supervisor oficial)
ALTER TABLE department
ADD CONSTRAINT fk_department_supervisor 
FOREIGN KEY(supervisor_ssn) 
REFERENCES employee(ssn);
GO

-- 4. TABLA DEPENDENT (Depende de employee)
CREATE TABLE dependent(
    name VARCHAR(20) NOT NULL,
    ssn_employee INT NOT NULL,
    relationship VARCHAR(20) NOT NULL,
    gender CHAR(1) NOT NULL,
    CONSTRAINT ck_dependent_gender 
    CHECK(gender IN ('M','F')),
    birth_date DATE NOT NULL,
    CONSTRAINT pk_dependent_name_ssn 
    PRIMARY KEY(name, ssn_employee),
    CONSTRAINT fk_dependent_employee 
    FOREIGN KEY(ssn_employee) 
    REFERENCES employee(ssn)
);
GO

-- 5. TABLA LOCATION (Depende de department)
CREATE TABLE location(
    name_department VARCHAR(20) NOT NULL,
    number_department INT NOT NULL,
    number_location VARCHAR(20) NOT NULL,
    CONSTRAINT pk_location_name_number_location 
    PRIMARY KEY(name_department, number_department, number_location),
    CONSTRAINT fk_location_department 
    FOREIGN KEY(name_department, number_department) 
    REFERENCES department(name, number)
);
GO

-- 6. TABLA PROJECT (Depende de department)
CREATE TABLE project(
    name VARCHAR(20) NOT NULL,
    project_code VARCHAR(20) NOT NULL, -- Renombrado para evitar confusión con el nombre de la tabla
    location VARCHAR(20) NOT NULL,
    CONSTRAINT pk_project_name_project 
    PRIMARY KEY(name, project_code),
    name_department 
    VARCHAR(20) NOT NULL,
    number_department 
    INT NOT NULL,
    CONSTRAINT fk_project_department 
    FOREIGN KEY(name_department, number_department) 
    REFERENCES department(name, number)
);
GO

-- 7. TABLA WORKS_ON (Depende de employee y project)
CREATE TABLE works_on(
    ssn_employee INT NOT NULL,
    name_project VARCHAR(20) NOT NULL,
    project_code VARCHAR(20) NOT NULL,
    CONSTRAINT pk_works_on_ssn_name_project 
    PRIMARY KEY(ssn_employee, name_project, project_code),
    hours DECIMAL(5,2) NOT NULL,
    CONSTRAINT ck_works_on_hours 
    CHECK(hours >= 0),
    CONSTRAINT fk_works_on_employee 
    FOREIGN KEY(ssn_employee) 
    REFERENCES employee(ssn),
    CONSTRAINT fk_works_on_project 
    FOREIGN KEY(name_project, project_code) 
    REFERENCES project(name, project_code)
);
GO