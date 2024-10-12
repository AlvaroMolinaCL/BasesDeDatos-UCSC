/* Laboratorio - Ejercicios SQL: Base de Datos "Cadena Hotelera" */
/* Bases de Datos (IN1075C) */

/*
 * La base de datos "cadena_hoteles" guarda los datos correspondiente a una cadena de hoteles con
 * diferentes sucursales.
 * 
 * Cada cliente es registrado en la tabla CLIENTES. Los clientes realizan reservas (tabla RESERVAS) por
 * un determinado periodo de tiempo en las distintas habitaciones (tabla HABITACIONES) pertenecientes
 * a los distintas sucursales (tabla EDIFICIO). Los clientes pueden obtener beneficios si pagan una
 * membresia (campo membresia).
 * 
 * Cada sucursal es mantenida por diferentes trabajadores, siendo uno de ellos el gerente (campo
 * gerente en EDIFICIO). Las sucursales tienen una serie de diferentes instalaciones disponibles para
 * los huéspedes (tabla INSTALACION).
 */

-- PREGUNTA 1 --
/*
 * 1.1. Imprima una lista de los clientes con información de las reservas vigentes asociadas.
 * Debe aparecer la siguiente información:
 * ✔ rut, nombre y apellido del cliente
 * ✔ código de la habitación
 * ✔ nombre y dirección del edificio
 * Una reserva vigente es aquella que aún no se ha completado, es decir reservas cuya fecha
 * límite (hasta) no se ha alcanzado. 
 */

SELECT rut, cliente.nombre, apellido, habitacion,
	   edificio.nombre, direccion
FROM cliente, reserva, habitacion, edificio
WHERE cliente.rut = reserva.cliente
AND   reserva.habitacion = habitacion.codigo
AND   habitacion.edificio = edificio.nombre
-- AND   hasta > '8-11-2021';
AND   hasta > current_date;

/*
 * 1.2. Generar un listado de todas las reservas registradas con los siguientes campos:
 * ✔ código de la reserva
 * ✔ nombre, rut y apellido del cliente asociado
 * ✔ nombre del edificio y nombre de su gerente
 * ✔ habitación y fecha de inicio y término
 * Ordenar los registros según el número de reserva.
 */

SELECT reserva.codigo, cliente.nombre, rut, apellido,
	   edificio.nombre, gerente, reserva.habitacion,
	   desde, hasta
FROM cliente, reserva, habitacion, edificio
WHERE cliente.rut = reserva.cliente
AND   reserva.habitacion = habitacion.codigo
AND   habitacion.edificio = edificio.nombre
ORDER BY reserva.codigo;

/*
 * 1.3. Generar un listado de las reservas realizadas solo por clientes con membresía. Se debe
 * imprimir lo siguiente:
 * ✔ código de la reserva
 * ✔ nombre, rut y apellido del cliente asociado
 * ✔ nombre del edificio
 * ✔ habitación y fecha de inicio y término
 */

SELECT reserva.codigo, cliente.nombre, rut, apellido,
	   edificio.nombre, reserva.habitacion, desde, hasta
FROM cliente, reserva, habitacion, edificio
WHERE cliente.rut = reserva.cliente
AND   reserva.habitacion = habitacion.codigo
AND   habitacion.edificio = edificio.nombre
AND   cliente.membresia = true;

-- PREGUNTA 2 --
/*
 * 2.1. Obtener el número total de reservas realizado en cada edificio junto con el número total de
 * días reservados por todos los clientes en habitaciones de dicho edificio. Se deben considerar
 * los siguientes datos:
 * ✔ Nombre del edificio, rut del gerente
 * ✔ Número total de reservas
 * ✔ Número total de días reservados por los clientes.
 */

SELECT nombre, gerente,
	   COUNT(*) AS numero_de_reservas,
	   SUM(hasta - desde) AS total_dias
FROM edificio, reserva, habitacion
WHERE edificio.nombre = habitacion.edificio
AND   habitacion.codigo = reserva.habitacion
GROUP BY edificio.nombre;

-- ¿En qué edificios se han reservado mas de 50 días? (elaborar respuesta con SQL) 

-- HAVING sum(hasta - desde) > 50;
SELECT *
FROM (SELECT nombre, gerente,
	         COUNT(*) AS numero_de_reservas,
	         SUM(hasta - desde) AS total_dias
	  FROM edificio, reserva, habitacion
	  WHERE edificio.nombre = habitacion.edificio
	  AND   habitacion.codigo = reserva.habitacion
	  GROUP BY edificio.nombre) AS tablal
WHERE total_dias > 50;

/*
 * 2.2. Listar a todos los clientes junto con los siguientes datos:
 * ✔ rut, nombre y apellido del cliente
 * ✔ número de reservas realizadas
 * ✔ gasto total que registra
 * Tener en cuenta que el precio registrado en la BD representa un precio diario. ¿Cuál es el
 * monto mas alto de gastos realizado por un cliente?
 */

SELECT rut, nombre, apellido,
       COUNT(*) AS numero_reservas,
	   SUM(precio * (hasta - desde)) AS gastos
FROM cliente, reserva, habitacion
WHERE cliente.rut = reserva.cliente
AND   reserva.habitacion = habitacion.codigo
GROUP BY rut;

/*
 * 2.3. Obtener un resumen de precios de cada edificio con la siguiente información:
 * ✔ nombre del edificio y del gerente encargado
 * ✔ precio mínimo, promedio y máximo
 */

SELECT edificio.nombre, trabajador.nombre,
       MIN(precio), AVG(precio), MAX(precio)
FROM edificio, habitacion, trabajador
WHERE edificio.nombre = habitacion.edificio
AND   edificio.gerente = trabajador.rut
GROUP BY edificio.nombre, trabajador.rut;
-- ¿Qué edificios tienen habitaciones con precios por sobre 20.000 la noche?
HAVING MAX(precio) >= 20000;

-- PREGUNTA 3 --
/*
 * 3.1. Un potencial cliente quiere realizar una reserva pero necesita una habitación que cumpla 
 * con sus requerimientos:
 * ✔ Como el cliente no sabe nadar, no quiere una habitación con acceso a piscinas
 * ✔ El cliente practica tenis, por lo que requiere acceso a una cancha de tenis.
 * Seleccionar las habitaciones que cumplan con lo esperado por el cliente, listando el código 
 * de la habitación, la cantidad de camas. la planta donde está y el edificio al que pertenece.
 */

SELECT codigo, camas, planta, edificio
FROM habitacion
WHERE edificio NOT IN (SELECT edificio
                       FROM edificio_instalacion
					   WHERE instalacion = 'piscina')
AND   edificio IN (SELECT edificio
                   FROM edificio_instalacion
				   WHERE instalacion = 'cancha de tenis');

/*
 * 3.2. Un potencial cliente quiere realizar una reserva. Anteriormente realizó una reserva en la 
 * habitación ‘A6’, llevándose una buena impresión. Esta vez está dispuesto a aumentar su 
 * presupuesto, por lo que necesita ayuda para escoger una habitación. 
 * Listar todas las habitaciones teniendo en cuenta lo siguiente:
 * ✔ Se debe listar el código de la habitación, el edificio donde se ubica y el precio.
 * ✔ Como el cliente aumentará el presupuesto, se deben listar solo habitaciones igual o 
 * más caras que ‘A6’
 * ✔ El cliente no quiere hospedarse en el mismo edificio de su anterior reserva (no deben
 * sugerirse habitaciones pertenecientes al edificio donde esta ‘A6’)
 * ✔ Se requiere un mínimo de 2 camas.
 */

SELECT codigo, edificio, precio
FROM habitacion
WHERE precio >= (SELECT precio
				 FROM habitacion
                 WHERE codigo ='A6')
AND   edificio != (SELECT edificio
				   FROM habitacion
                   WHERE codigo ='A6')
AND   camas >= 2;