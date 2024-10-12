/* Laboratorio - Ejercicios SQL: Base de Datos "Ordenes Mantenimiento" */
/* Bases de Datos (IN1075C) */

/*
 * 1. Cree una consulta que contenga el detalle de las empresas con sus órdenes de mantenimiento con
 * los siguientes datos: id_empresa, nombre_empresa, cod_orden, fecha_orden, rut, costo_repuestos
 * (calculado como la sumatoria de todos los repuestos utilizados en la orden por el valor de cada
 * repuesto). Deben aparecer todas las empresas. 
 */

SELECT e.id_empresa, e.nombre_empresa, om.cod_orden, om.fecha_orden, om.rut,
	 SUM(ro.cantidad_repuesto * r.valor_repuesto) AS costo_repuestos
FROM empresa e, orden_mantenimiento om, repuesto_orden ro, repuesto r
WHERE om.id_empresa = e.id_empresa
AND   ro.cod_orden = om.cod_orden
AND   ro.cod_repuesto = r.cod_repuesto
GROUP BY e.id_empresa, om.cod_orden;
/*
SELECT id_empresa, nombre_empresa, cod_orden, fecha_orden, rut,
        SUM(valor_repuesto * cantidad_repuesto) AS costo_repuestos
FROM empresa LEFT JOIN orden_mantenimiento USING(id_empresa)
    LEFT JOIN repuesto_orden USING(cod_orden)
    LEFT JOIN repuesto USING(cod_repuesto)
GROUP BY id_empresa, cod_orden;

SELECT om.cod_orden, SUM(ro.cantidad_repuesto * r.valor_repuesto) AS costo_repuestos
FROM orden_mantenimiento om, repuesto_orden ro, repuesto r
WHERE ro.cod_orden = om.cod_orden
AND ro.cod_repuesto = r.cod_repuesto
GROUP BY om.cod_orden;

SELECT e.id_empresa, e.nombre_empresa, om.cod_orden, om.fecha_orden, om.rut,
	 ta.costo_repuestos
FROM empresa e, orden_mantenimiento om,
		(SELECT om.cod_orden, SUM(ro.cantidad_repuesto * r.valor_repuesto) AS costo_repuestos
		 FROM orden_mantenimiento om, repuesto_orden ro, repuesto r
		 WHERE ro.cod_orden = om.cod_orden
		 AND ro.cod_repuesto = r.cod_repuesto
		 GROUP BY om.cod_orden) AS ta
WHERE om.id_empresa = e.id_empresa
AND ta.cod_orden = om.cod_orden;

SELECT e.id_empresa, e.nombre_empresa, om.cod_orden, om.fecha_orden, om.rut,
	 (SELECT COALESCE(SUM(ro.cantidad_repuesto * r.valor_repuesto), 0)
	  FROM repuesto_orden ro, repuesto r
	  WHERE ro.cod_orden = om.cod_orden
	  AND r.cod_repuesto = ro.cod_repuesto) AS costo_repuestos -- SELECT con único valor
FROM empresa e, orden_mantenimiento om
WHERE om.id_empresa = e.id_empresa;
*/

/*
 * 2. Cree una consulta que contenga el detalle de los supervisores con sus órdenes de
 * mantenimiento con los siguientes datos: rut, nombre_supervisor, cod_orden, fecha_orden,
 * id_empresa, costo_repuestos (calculado como la sumatoria de todos los repuestos utilizados
 * en la orden por el valor de cada repuesto). Deben aparecer todos los supervisores.
 */

SELECT s.rut, nombre_supervisor, om.cod_orden, fecha_orden, id_empresa, 
       SUM(valor_repuesto * cantidad_repuesto) AS costo_repuestos
FROM supervisor s, orden_mantenimiento om, repuesto_orden ro, repuesto r
WHERE om.rut = s.rut
AND   ro.cod_orden = om.cod_orden
AND   r.cod_repuesto = ro.cod_repuesto
GROUP BY s.rut, om.cod_orden;
/*
SELECT rut, nombre_supervisor, cod_orden, fecha_orden, id_empresa,
       SUM(valor_repuesto * cantidad_repuesto) AS costo_repuestos
FROM supervisor LEFT JOIN orden_mantenimiento USING(rut)
     LEFT JOIN repuesto_orden USING(cod_orden)
     LEFT JOIN repuesto USING(cod_repuesto)
GROUP BY rut, cod_orden;
*/

/*
 * 3. Cree una consulta que contenga el detalle de las órdenes de mantenimiento con los
 * siguientes datos: cod_orden, fecha_orden, id_empresa, rut, nombre_supervisor,
 * costo_repuestos (calculado como la sumatoria de todos los repuestos utilizados en la orden
 * por el valor de cada repuesto). Deben aparecer todas las órdenes.
 */

SELECT om.cod_orden, fecha_orden, id_empresa, s.rut, nombre_supervisor, 
       SUM(valor_repuesto * cantidad_repuesto) AS costo_repuestos
FROM supervisor s, orden_mantenimiento om, repuesto_orden ro, repuesto r
WHERE om.rut = s.rut
AND   ro.cod_orden = om.cod_orden
AND   r.cod_repuesto = ro.cod_repuesto
GROUP BY s.rut, om.cod_orden;
/*
SELECT cod_orden, fecha_orden, id_empresa, rut, nombre_supervisor,
       SUM(valor_repuesto * cantidad_repuesto) AS costo_repuestos
FROM supervisor JOIN orden_mantenimiento USING(rut)
     LEFT JOIN repuesto_orden USING(cod_orden)
     LEFT JOIN repuesto USING(cod_repuesto)
GROUP BY rut, cod_orden;
*/

/*
 * 4. Seleccione los datos de la o las empresas (id_empresa, nombre_empresa, cantidad de
 * órdenes) que han solicitado la mayor cantidad de órdenes de mantenimiento.
 */

SELECT e.id_empresa, nombre_empresa, COUNT(cod_orden)
FROM empresa e, orden_mantenimiento om
WHERE om.id_empresa = e.id_empresa
GROUP BY e.id_empresa
HAVING COUNT(cod_orden) = (SELECT MAX(cantidad_orden.cantidad) 
                           FROM (SELECT id_empresa, COUNT(cod_orden) AS cantidad
                                 FROM orden_mantenimiento
                                 GROUP BY id_empresa) AS cantidad_orden);
/*
SELECT id_empresa, nombre_empresa, COUNT(cod_orden)
FROM empresa JOIN orden_mantenimiento USING(id_empresa)
GROUP BY id_empresa
HAVING count(cod_orden) = (SELECT MAX(cantidad_orden.cantidad) 
FROM (SELECT id_empresa, COUNT(cod_orden) AS cantidad
      FROM orden_mantenimiento
      GROUP BY id_empresa) AS cantidad_orden);
*/

/*
 * 5. Seleccione los datos de la o las órdenes de mantenimiento (cod_orden, fecha_orden,
 * cantidad de repuestos) que han utilizado una mayor cantidad de repuestos. 
 */

SELECT om.cod_orden, fecha_orden, SUM(cantidad_repuesto)
FROM repuesto_orden ro, orden_mantenimiento om
WHERE ro.cod_orden = om.cod_orden
GROUP BY om.cod_orden, fecha_orden
HAVING SUM(cantidad_repuesto) = (SELECT MAX(cantidad_orden.cantidad) 
                                 FROM (SELECT SUM(cantidad_repuesto) AS cantidad
                                       FROM repuesto_orden
                                       GROUP BY cod_orden) AS cantidad_orden);
/*
SELECT cod_orden, fecha_orden, SUM(cantidad_repuesto)
FROM repuesto_orden JOIN orden_mantenimiento USING(cod_orden)
GROUP BY cod_orden, fecha_orden
HAVING SUM(cantidad_repuesto) = (SELECT MAX(cantidad_orden.cantidad) 
FROM (SELECT SUM(cantidad_repuesto) AS cantidad
      FROM repuesto_orden
      GROUP BY cod_orden) AS cantidad_orden);
*/

/*
 * 6. Seleccione los datos del o los supervisores (rut, nombre_supervisor, cantidad de órdenes)
 * que han supervisado la menor cantidad de órdenes de mantenimiento
*/

SELECT s.rut, nombre_supervisor, COUNT(cod_orden)
FROM supervisor s, orden_mantenimiento om
WHERE om.rut = s.rut
GROUP BY s.rut
HAVING COUNT(cod_orden) = (SELECT MIN(cantidad_orden.cantidad) 
                           FROM (SELECT COUNT(cod_orden) AS cantidad
                                 FROM orden_mantenimiento
                                 GROUP BY rut) AS cantidad_orden);
/*
SELECT rut, nombre_supervisor, COUNT(cod_orden)
FROM supervisor JOIN orden_mantenimiento USING(rut)
GROUP BY rut
HAVING COUNT(cod_orden) = (SELECT MIN(cantidad_orden.cantidad) 
FROM (SELECT COUNT(cod_orden) AS cantidad
      FROM orden_mantenimiento
      GROUP BY rut) AS cantidad_orden);
*/

/*
 * 7. Listar todos los repuestos (cod_repuesto, nombre_repuesto, valor_repuesto, stock_repuesto)
 * que tienen un stock menor al stock promedio de todos los repuestos.
 */

SELECT cod_repuesto, nombre_repuesto, valor_repuesto, stock_repuesto
FROM repuesto
WHERE stock_repuesto < (SELECT AVG(stock_repuesto)
                        FROM repuesto);

/*
 * 8. Listar todos los repuestos (cod_repuesto, nombre_repuesto, valor_repuesto, stock_repuesto)
 * que tienen un valor mayor al valor promedio de todos los repuestos.
 */

SELECT cod_repuesto, nombre_repuesto, valor_repuesto, stock_repuesto
FROM repuesto
WHERE valor_repuesto > (SELECT AVG(valor_repuesto)
                        FROM repuesto); 

/*
 * 9. Listar todas las órdenes de mantenimiento (cod_orden, fecha_orden, id_empresa, rut,
 * valor_total) que tienen un valor total menor al valor promedio de todas las órdenes
 */

SELECT * 
FROM orden_mantenimiento
WHERE valor_total < (SELECT AVG(valor_total)
                     FROM orden_mantenimiento);

/*
 * 10. Seleccione los datos de las órdenes de mantenimiento que utilizan dos o más repuestos.
 */

SELECT om.*, COUNT(cod_repuesto)
FROM orden_mantenimiento om, repuesto_orden ro
WHERE ro.cod_orden = om.cod_orden
GROUP BY om.cod_orden
HAVING COUNT(cod_repuesto) >=2;
/*
SELECT om.*, SUM(cantidad_repuesto)
FROM orden_mantenimiento om, repuesto_orden ro
WHERE ro.cod_orden = om.cod_orden
GROUP BY om.cod_orden
HAVING SUM(cantidad_repuesto) >=2;

SELECT om.*, count(cod_repuesto)
FROM orden_mantenimiento om JOIN repuesto_orden ro USING(cod_orden)
GROUP BY cod_orden
HAVING count(cod_repuesto) >=2;

SELECT om.*, SUM(cantidad_repuesto)
FROM orden_mantenimiento om JOIN repuesto_orden ro USING(cod_orden)
GROUP BY cod_orden
HAVING SUM(cantidad_repuesto) >=2;
*/

/*
 * 11. Seleccione los datos de las empresas que han solicitado dos o más órdenes de
 * mantenimiento.
 */

SELECT e.*, COUNT(cod_orden)
FROM empresa e, orden_mantenimiento om
WHERE om.id_empresa = e.id_empresa
GROUP BY e.id_empresa
HAVING COUNT(cod_orden) >=2; 
/*
SELECT empresa.*, COUNT(cod_orden)
FROM empresa JOIN orden_mantenimiento USING(id_empresa)
GROUP BY id_empresa
HAVING COUNT(cod_orden) >=2; 
*/

/*
 * 12. Seleccione los datos de los supervisores que han supervisado más de dos órdenes de
 * mantenimiento
 */

SELECT s.*, COUNT(cod_orden)
FROM supervisor s, orden_mantenimiento om
WHERE om.rut = s.rut
GROUP BY s.rut
HAVING COUNT(cod_orden) >=2;
/*
SELECT supervisor.*, COUNT(cod_orden)
FROM supervisor JOIN orden_mantenimiento USING(rut)
GROUP BY rut
HAVING COUNT(cod_orden) >=2;
*/