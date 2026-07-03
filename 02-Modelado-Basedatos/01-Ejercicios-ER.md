# EJERCICIO MODELO ENTIDAD E-R

---
# Ejercicio uno

Se registra la información de los pacientes en un hospital

> De los paciente se almacena
- Nombre
- Fecha de nacimimiento

>De un expediente médico se almacena:
- Número de expediente
- Fecha de apertura
- Tipo de sangre

>Reglas del negocio:
1. Cada paciente debe tener exactmanete un expdiente médico
2. Cada expdiente pertenece a un único paciente
3. No puede existir ningún expdiente médico sin paciente
4. No puede existir un paciente sin expediente médico

## Resultado modelo E-R

![Hospital](../img/E%20-%20R/Ejercicio1.png)

---
# Ejercicio dos

Una universidad administra profesores y cursos

> De cada profesor se almacena:
- Clave profesor
- Nombre
- Especialidad

> De cada curso se almacena_
- Identificación del curso
- Nombre del curso
- Créditos

 > Reglas del negocio
1. Un profesor puede impartir varios cursos
2. Un curso solamente puede ser impartido por un profesor
3. Puede existir un profesor que actualmente no imparta cursos
4. Todo curso debe ser asignado a un profesor

Se debe realizar lo siguiente

- Entidades
- Identificar la relación **IMPARTE**
- Determinar la cardinalidad
- Determinar la participación

## Resultado modelo E-R

![Profesor](../img/E%20-%20R/Ejercicio2.png)

---
# Ejercicio tres

Una escuela administra alumnos y materias

> De cada alumno se almacena
- Matrícula
- Nombre
- Semestre

> De cada materia se almacena
- Clave de la materia
- Nombre de la materia
- Créditos 

> Reglas del negocio
1. Un alumno puede inscribirse en varias materias
2. Una materia puede tener muchos alumnos inscritos
3. Puede existir una materia sin alumnos inscritos
4. Todo alumno debe estar inscrito en al menos una materia
5. De cada inscripción se debe almacenar: 
- Fecha de inscripción 
- Calificación final

Se debe realizar lo siguiente

- Entidades
- Identificar la relación **INSCRIBE**
- Determinar la cardinalidad
- Determinar la participación

## Resultado modelo E-R

![Inscripcion](../img/E%20-%20R/Ejercicio3.png)

---
# Ejercicio cuatro

Una empresa encargada de realizar venta de productos:

> De cada cliente se almacena
- Número de cliente (ID)
- Nombre, que es una persona moral
- RFC

> La empresa realiza pedidos en los cuales almacena:
- Numero pedido
- Fecha

> La empresa también almacena productos de los cuáles registra lo siguiente
- Numero de producto
- Nombre
- Precio

> Al realizar los pedidos deben registrar la cantidad de productos pedidos y su precio

> Reglas del negocio 
1. Un cliente puede realizar muchos pedidos 
2. Cada pedido pertenece a un solo cliente
3. Un pedido puede contener varios productos
4. Un producto puede aparecer en muchos pedidos
5. Un pedido debe contener al menos un producto
6. Un producto puede no haber sido vendido 
7. El detalle del pedido no existe sin pedido
8. El detalle de pedido no existe sin producto
9. El detalle almacena cantidad y precio de venta

## Resultado modelo E-R

![Pedidos](../img/E%20-%20R/Ejercicio4.png)


--
## Ejercicio cinco

Una compañía está organizada en departamentos:

> Cada departamento tiene
- Nombre único
- Número único
- Supervisor
- Tiene diversas localidades

> Un departamento maneja varios proyectos, los cuales tienen
- Nombre único
- Número único
- Localidad

> De los empleados almacenamos
- Nombre
- Número de seguro social
- Dirección
- Salario
- Género
- Fecha de nacimiento

> Cada empleado tiene un dependiente con propósito de apoyo, que tiene
- Nombre
- Género
- Fecha de nacimiento
- Tipo de relación

> Reglas del negocio
1. Un empleado es asignado a un departamento
2. Un empleado puede trabajar en varios proyectos
3. Un departamento no controla un único proyecto, pero un proyecto es controlado por un único proyecto
4. Se registra el número de horas a la semana que un empleado trabaja en un proyecto
5. Se registra un supervisor directo de cada empleado, que a su vez, el supervisor, también es un empleado
6. Se registra la fecha de inicio en la que un supervisor administra un departamento

## Resultado modelo E-R

![Departamento](../img/E%20-%20R/Ejercicio5.png)
