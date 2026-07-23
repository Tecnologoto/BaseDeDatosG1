-- CREAR BASE DE DATOS
CREATE DATABASE company;
GO

--USAR BASE DE DATOS
USE company;
GO

-- PRIMERO SE HACE LA QUE NO TIENE FOREIGN KEY
--EN ESTE CASO TODAS TIENEN FOREIGN KEY
-- TABLA EMPLOYEE
CREATE TABLE employee(
    ssn INT NOT NULL IDENTITY(1,1)
    CONSTRAINT pk_ssn
    PRIMARY KEY,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    address VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2) NOT NULL
    CONSTRAINT ck_employee_salary
    CHECK(salary > 0),
    gender CHAR(1) NOT NULL
    CONSTRAINT ck_employee_gender
    CHECK(gender IN ('M','F')),
    birth_date DATE NOT NULL,
    
);

CREATE TABLE department(
    name INT NOT NULL,
    number INT NOT NULL,
    CONSTRAINT pk_department_number
    PRIMARY KEY,
    name VARCHAR(30) NOT NULL
    CONSTRAINT uq_department_name
    UNIQUE,
    location VARCHAR(50) NOT NULL
);