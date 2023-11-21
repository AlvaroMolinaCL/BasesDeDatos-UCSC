/*
Laboratorio - Ejercicios SQL (Subconsultas): Música y Sucursales

Realizar los ejercicios propuestos utilizando la base de datos “Música y sucursales”. Todos los
ejercicios (incluyendo las preguntas) deben ser resueltos utilizando SQL.
*/

/*
1) ¿Cuál es el número de canciones incluidas en los albumes registrados en la base de datos 
(mostrar album y cantidad de canciones)?
*/

SELECT codigo_album, COUNT(*) AS cantidad
FROM conforma
GROUP BY codigo_album;

-- Calcular el promedio total de canciones por album
SELECT AVG(cantidad)
FROM (SELECT COUNT(*) AS cantidad
	  FROM conforma
	  GROUP BY codigo_album) AS tablal;

/*
2) Seleccionar el nombre, tipo y código de los albumes que no se venden en la sucursal “MUSIC 
FOREVER”.
*/

-- Los albumes que se venden
SELECT album
FROM sucursal, inventario
WHERE sucursal.nombre = inventario.sucursal
AND   nombre = 'MUSIC FOREVER';

-- Los albumes que no se venden
SELECT nombre, tipo, codigo
FROM album
WHERE codigo NOT IN (SELECT album
					 FROM sucursal, inventario
					 WHERE sucursal.nombre = inventario.sucursal
					 AND   nombre = 'MUSIC FOREVER'); 

/*
3) Seleccionar los datos de las sucursales junto al precio minimo, promedio y máximo de los 
productos de cada una.
*/

SELECT sucursal.nombre, sucursal.ciudad, 
	   AVG(precio) AS promedio,
	   MIN(precio) AS minimo,
	   MAX(precio) AS maximo
FROM sucursal, inventario
WHERE sucursal.nombre = inventario.sucursal
GROUP BY sucursal.nombre;

/*
4) Seleccionar todas las compras junto con su precio total.
*/

SELECT compra.*, SUM(precio * cantidad) AS total
FROM compra, canasta, inventario
WHERE compra.codigo = canasta.codigo_compra
AND   inventario.producto = canasta.codigo_producto
GROUP BY codigo;

-- ¿Cuál es la compra en la que más dinero se ha gastado?, seleccionar el registro completo.

SELECT *
FROM (SELECT compra.*, SUM(precio * cantidad) AS total
	  FROM compra, canasta, inventario
	  WHERE compra.codigo = canasta.codigo_compra
	  AND   inventario.producto = canasta.codigo_producto
	  GROUP BY codigo) AS tablal
WHERE tablal.total = (SELECT MAX(precio) 
					  FROM (SELECT SUM(precio * cantidad) AS precio
							FROM compra, canasta, inventario
							WHERE compra.codigo = canasta.codigo_compra
							AND   inventario.producto = canasta.codigo_producto
							GROUP BY codigo) AS tablal2);

/*
5) Se está realizando un estudio para ver la viabilidad de la tienda virtual frente a las sucursales 
tradicionales. Se requiere conocer:
◦ el monto total de dinero obtenido en la tienda virtual (sucursal llamada “VIRTUAL”)
◦ el nombre y monto total de ganancias de las sucursales que han obtenido una menor 
ganancia monetaria que ta tienda virtual
◦ el nombre y monto total de ganancias de las sucursales que han obtenido una mayor 
ganancia monetaria que ta tienda virtual.
*/

-- Compras realizadas en la sucursal llamada "VIRTUAL"
SELECT sucursal, SUM(precio * cantidad) AS total
FROM inventario, canasta
WHERE inventario.producto = canasta.codigo_producto
AND   sucursal = 'VIRTUAL'
GROUP BY sucursal;

SELECT sucursal, SUM(precio * cantidad) AS total
FROM inventario, canasta
WHERE inventario.producto = canasta.codigo_producto
GROUP BY sucursal
HAVING SUM(precio * cantidad) < (SELECT SUM(precio * cantidad) AS total
								FROM inventario, canasta
								WHERE inventario.producto = canasta.codigo_producto
								AND   sucursal = 'VIRTUAL'
								GROUP BY sucursal);