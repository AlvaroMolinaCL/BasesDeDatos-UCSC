/* Laboratorio - Ejercicios SQL: Base de Datos "Plataforma de Películas" */
/* Bases de Datos (IN1075C) */

/*
 * La base de datos plataforma_de_peliculas guarda la información utilizada por una plataforma de 
 * streaming por suscripción, que exhibe obras audiovisuales como películas, documentales y series de 
 * televisión.
 * En el catálogo disponible (OBRA) se distinguen las películas (PELICULA), series (SERIE) y 
 * documentales (DOCUMENTAL). Cada obra fue realizada por un estudio cinematográfico (ESTUDIO), 
 * quien posee los derechos de distribución. 
 * Los clientes (CLIENTES) se suscriben a la plataforma para poder acceder al contenido y tienen la 
 * posibilidad de ingresar una reseña por cada película, serie o documental que ven (CRITICA). Por 
 * diversos temas administrativos, la plataforma debe limitar el acceso a su catálogo dependiendo de la 
 * zona geográfica (ZONA) en la que residen sus clientes (disponibilidad en ZONA_OBRA). Las tarifas 
 * mensuales son de acuerdo a esta zona geográfica.
 */

/*
 * 1.1.
 * Listar todas las obras cinematográficas a las que el cliente de nombre completo es 'Luna'
 * puede acceder a traves de la plataforma. Se debe mostrar la siguiente información:
 * 
 *  - Título de la obra
 *  - Año
 *  - Nombre del estudio
 * 
 * La lista debe estar ordenada alfabeticamente segun el título.
 */

SELECT obra.titulo, obra.anio, estudio.nombre
FROM cliente, pais, zona, obra_zona, obra, estudio
WHERE cliente.pais = pais.codigo
AND pais.zona = zona.nombre
AND zona.nombre = obra_zona.zona
AND obra.codigo = obra_zona.obra
AND obra.estudio = estudio.codigo
AND  cliente.nombre = 'Luna'
ORDER BY obra.titulo;

/*
 * 1.2.
 * Seleccionar todos los documentales que duran una hora o más y que pueden ser 
 * vistos en Mexico. Se debe seleccionar la siguiente infromación:
 * 
 *  - Título y anio del documental
 *  - Nombre del estudio
 *  - Duración
 * Ordenar la lista según su duración de forma ascendente.
 */

SELECT titulo, anio, duracion, estudio.nombre
FROM pais, zona, obra_zona, obra, documental, estudio
WHERE pais.zona = zona.nombre
AND zona.nombre = obra_zona.zona
AND obra_zona.obra = obra.codigo
AND obra.codigo = documental.codigo
AND obra.estudio = estudio.codigo
AND pais.nombre = 'Mexico'
AND documental.duracion > '60 m'
ORDER BY duracion;

/*
 * 1.3.
 * Seleccionar todas las críticas realizadas por clientes que tengan el nombre
 * Natalia. Deben mostrarse las siguientes columnas:
 * 
 *  - Nombre completo del cliente
 *  - Título de la obra
 *  - fecha de la crítica
 *  - Cantidad de estrellas de puntuación
 *  - Comentario
 * 
 * Nota: Considerar el nombre "Natalia" ya sea primer nombre, segundo u otro.
 */

SELECT cliente.nombre, 
	   obra.titulo,
	   critica.fecha,
	   estrellas,
	   comentario
FROM cliente, critica, obra, estudio
WHERE cliente.codigo = critica.cliente
AND critica.obra = obra.codigo
AND obra.estudio = estudio.codigo
AND cliente.nombre LIKE '%Natalia%'; 

/*
 * 2.1.
 * Listar las obras audiovisuales junto con un resumen de las críticas que obtuvo. 
 * Se debe mostrar la siguiente información:
 * 
 *  - Código y título de la obra
 *  - Cantidad de críticas registradas
 *  - Puntuación de estrellas más baja y más alta obtenida 
 * 
 * Utilizar solamente las críticas realizadas por clientes adultos
 * (18 años o más).
 * 
 * Se ha decidido que solo se considerarán obras con un mínimo
 * de 3 críticas ¿Cómo sería la consulta? (responder con SQL)
 */

SELECT obra.codigo,
	   titulo, 
	   COUNT(*) AS cantidad_reviews, 
	   MIN(estrellas) AS estrellas_minimas, 
	   MAX(estrellas) AS estrellas_maximas
FROM obra, critica, cliente
WHERE obra.codigo = critica.obra
AND cliente.codigo = critica.cliente
AND (current_date - cliente.nacimiento)/365 >= 18  --La resta da la diferencia en días
GROUP BY obra.codigo;

--3 críticas o más
SELECT obra.codigo,
	   titulo, 
	   COUNT(*) AS cantidad_reviews, 
	   MIN(estrellas) AS estrellas_minimas, 
	   MAX(estrellas) AS estrellas_maximas
FROM obra, critica, cliente
WHERE obra.codigo = critica.obra
AND cliente.codigo = critica.cliente
AND (current_date - cliente.nacimiento)/365 >= 18
GROUP BY obra.codigo
HAVING COUNT(*) >= 3;

/*
 * 2.2. 
 * Listar las series disponibles con la siguiente información:
 *  - Código y nombre de la serie
 *  - Nombre del estudio cinematográfico
 *  - Cantidad de capítulos disponibles en la plataforma
 *  - Duración total de la serie (duracion en términos de horas, minutos y segundos)
 * 
 * ¿Cuáles series tienen una duración total de al menos 3 horas? (responder con SQL)
 */

SELECT obra.codigo, 
       obra.titulo,
       estudio.nombre,
	   COUNT(*) AS cantidad_capitulos,
	   SUM(capitulo.duracion) AS duracion_total
FROM obra, estudio, serie, capitulo
WHERE obra.estudio = estudio.codigo
AND serie.codigo = obra.codigo
AND capitulo.serie = serie.codigo
GROUP BY obra.codigo, estudio.nombre
ORDER BY obra.codigo;

--al menos 3 horas
SELECT obra.codigo, 
       obra.titulo,
       estudio.nombre,
	   COUNT(*) AS cantidad_capitulos,
	   SUM(capitulo.duracion) AS duracion_total
FROM obra, estudio, serie, capitulo
WHERE obra.estudio = estudio.codigo
AND serie.codigo = obra.codigo
AND capitulo.serie = serie.codigo
GROUP BY obra.codigo, estudio.nombre
HAVING SUM(capitulo.duracion) >='3 h'
--HAVING SUM(capitulo.duracion) >='3:00:00' --otro formato para intervalo de tiempo

/*
 * 2.3. 
 * Listar todas las zonas junto con la siguiente información:
 *  - Nombre y descripción de la zona
 *  - Ingresto mensual total esperado para la zona
 *  - Cantidad de clientes en la zona
 *  
 * Para todos los cálculos se deben tomar en cuenta solo usuarios con cuenta activa
 * (cliente.activo)
 * 
 * ¿Cual es el mayor monto de ingresos mensual (responder con SQL)?
 */

SELECT zona.nombre, 
       SUM(mensualidad) AS ingreso_mensual, 
       COUNT(DISTINCT cliente.codigo) AS cantidad_de_clientes
FROM zona, pais, cliente
WHERE cliente.pais = pais.codigo
AND pais.zona = zona.nombre
AND cliente.activo IS True
GROUP BY zona.nombre;


-- Mayor monto
SELECT MAX(ingreso_mensual) AS mayor_monto
FROM (SELECT zona.nombre AS zona, 
	         SUM(mensualidad) AS ingreso_mensual, 
	         COUNT(DISTINCT cliente.codigo) AS cantidad_de_clientes
	  FROM zona, pais, cliente
	  WHERE cliente.pais = pais.codigo
	  AND pais.zona = zona.nombre
	  AND cliente.activo IS True
	  GROUP BY zona.nombre) AS tablal

/*
 * 3.1.
 * Listar todas las zonas en las que trabaja la plataforma junto
 * con la siguiente información:
 * 
 *  - Nombre y descripción de la zona
 *  - Cantidad de películas disponibles
 *  - Cantidad de documentales disponibles
 * 
 * EJEMPLO DE RESULTADO ESPERADO:
 * 
 *  zona         |descripcion          |peliculas|documentales|
 *  -------------+---------------------+---------+------------+
 *  America Norte|                     |        8|           4|
 *  Otros        |Casos especiales     |        1|           1|
 *  America Sur  |Centro y sur América |        8|           2|
 *  Europa y Asia|No se considera China|       10|           3|
 *  China        |Solo china           |        1|           1|
 * 
 */

--documentales por zona
SELECT obra_zona.zona, COUNT(DISTINCT documental.codigo)
FROM obra_zona, documental
WHERE obra_zona.obra = documental.codigo
GROUP BY obra_zona.zona;

--peliculas por zona
SELECT obra_zona.zona, COUNT(DISTINCT pelicula.codigo)
FROM obra_zona, pelicula
WHERE obra_zona.obra = pelicula.codigo
GROUP BY obra_zona.zona;

--Respuesta completa
SELECT zona.nombre, 
       zona.descripcion,
       peliculas,
       documentales
FROM zona, 
	 (SELECT obra_zona.zona, 
	 		 COUNT(DISTINCT pelicula.codigo) AS peliculas
	 FROM obra_zona, pelicula
	 WHERE obra_zona.obra = pelicula.codigo
	 GROUP BY obra_zona.zona) AS tabla_pelicula,
	 (SELECT obra_zona.zona,
	         COUNT(DISTINCT documental.codigo) AS documentales
	 FROM obra_zona, documental
	 WHERE obra_zona.obra = documental.codigo
	 GROUP BY obra_zona.zona )AS tabla_documental
WHERE zona.nombre = tabla_pelicula.zona
AND zona.nombre = tabla_documental.zona
ORDER BY zona.nombre;

--Utilizando OUTER JOIN (No visto en los laboratorios)
SELECT zona.nombre, 
       zona.descripcion,
       COUNT(DISTINCT pelicula.codigo) AS peliculas,
       COUNT(DISTINCT documental.codigo)AS documentales
FROM zona
JOIN obra_zona ON(zona.nombre=obra_zona.zona)
LEFT JOIN pelicula ON(pelicula.codigo=obra_zona.obra)
LEFT JOIN documental ON(documental.codigo=obra_zona.obra)
GROUP BY zona.nombre
ORDER BY zona.nombre;


/*
 * 3.2.
 * Listar todas las series que estén disponibles y completas en la plataforma
 * con la siguiente información:
 * 
 *  - Código y título de la serie
 *  - ¿Se encuentra la serie en emisión?
 *  - Cantidad de capítulos
 *  - Fecha de la primera emisión de la serie en la plataforma
 * 
 *  Nota: Para que una serie esté completa, deben estar todos sus capítulos registrados en la BD.
 *  La cantidad total de capítulos de una serie (independiente de su disponibilidad en la plataforma)
 *  está almacenada en el campo serie.n_capitulos
 */

-- Capítulos por serie
SELECT serie, COUNT(*) AS capitulos
FROM capitulo
GROUP BY serie

-- Respuesta completa
SELECT obra.codigo,
       obra.titulo,
       serie.en_emision,
       "cantidad de capitulos",
       "primera emision",
       n_capitulos -- Solo para comprobar, no incluir en respuesta final
FROM serie, obra,
     (SELECT serie, 
             COUNT(*) AS "cantidad de capitulos",
             MIN(emision) AS "primera emision"
	 FROM capitulo
	 GROUP BY serie) AS tablal
WHERE tablal.serie = serie.codigo
AND obra.codigo = serie.codigo
AND "cantidad de capitulos" = n_capitulos