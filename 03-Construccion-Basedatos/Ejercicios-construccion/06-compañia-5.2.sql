--CREAR BASE DE DATOS
CREATE DATABASE company;
GO

--USAR BASE DE DATOS
USE company;
GO

--PRIMERO SE HACE LA QUE NO TIENE FOREIGN KEY
--EN ESTE CASO TODAS TIENEN FOREIGN KEY

--TABLA EMPLOYEE
CREATE TABLE employee(
    employee_id INT NOT NULL IDENTITY(1,1),
    CONSTRAINT pk_employee_id
    PRIMARY KEY,
    ssn INT NOT NULL 
    CONSTRAINT uq_employee_ssn
    UNIQUE,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    employee_address VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2) NOT NULL,
    CONSTRAINT ck_employee_salary
    CHECK(salary > 0),
    gender CHAR(1) NOT NULL,
    CONSTRAINT ck_employee_gender
    CHECK(gender IN ('M','F')),
    birth_date DATE NOT NULL,
    number_department INT NOT NULL,
    CONSTRAINT fk_employee_department
    FOREIGN KEY(number_department) REFERENCES department(department_id),
    boss_id INT,
    CONSTRAINT fk_employee_boss
    FOREIGN KEY(boss_id) REFERENCES employee(employee_id)
);
GO

--TABLA DEPENDENT
CREATE TABLE dependent(
    dependent_id INT NOT NULL IDENTITY(1,1),
    CONSTRAINT pk_dependent_id
    PRIMARY KEY,
    dependent_name VARCHAR(20) NOT NULL,
    relationship VARCHAR(20) NOT NULL,
    gender CHAR(1) NOT NULL,
    CONSTRAINT ck_dependent_gender
    CHECK(gender IN ('M','F')),
    employee_id INT NOT NULL,
    CONSTRAINT fk_dependent_employee
    FOREIGN KEY(employee_id) REFERENCES employee(employee_id)
);
GO

--TABLA DEPARTMENT
CREATE TABLE department(
    department_id INT NOT NULL IDENTITY(1,1),
    CONSTRAINT pk_department_id
    PRIMARY KEY,
    department_name VARCHAR(30) NOT NULL,
    CONSTRAINT uq_department_name
    UNIQUE
);
GO

-- TABLA LOCATIONS
CREATE TABLE locations(
    location_id INT NOT NULL IDENTITY(1,1),
    CONSTRAINT pk_location_id
    PRIMARY KEY,
    location_name VARCHAR(30) NOT NULL,
    department_id INT NOT NULL,
    CONSTRAINT fk_location_department
    FOREIGN KEY(department_id) REFERENCES department(department_id)
);
GO

-- TABLA PROJECT
CREATE TABLE project(
    project_id INT NOT NULL IDENTITY(1,1),
    CONSTRAINT pk_project_id
    PRIMARY KEY,
    project_name VARCHAR(30) NOT NULL,
    CONSTRAINT uq_project_name
    UNIQUE,
    project_location VARCHAR(50) NOT NULL,
    department_id INT NOT NULL,
    CONSTRAINT fk_project_department
    FOREIGN KEY(department_id) REFERENCES department(department_id)
);
GO

--TABLA WORKS_ON
CREATE TABLE works_on(
    employee_id INT NOT NULL,
    project_id INT NOT NULL,
    works_on_tablehours DECIMAL(5,2) NOT NULL,
    CONSTRAINT ck_works_on_hours
    CHECK(works_on_tablehours > 0),
    CONSTRAINT pk_works_on
    PRIMARY KEY(employee_id, project_id),
    CONSTRAINT fk_works_on_employee
    FOREIGN KEY(employee_id) REFERENCES employee(employee_id),
    CONSTRAINT fk_works_on_project
    FOREIGN KEY(project_id) REFERENCES project(project_id)
);
GO

