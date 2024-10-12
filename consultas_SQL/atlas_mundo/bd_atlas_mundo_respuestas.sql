/* Laboratorio - Ejercicios SQL (Consultas): Base de Datos "Atlas del Mundo" */
/* Bases de Datos (IN1075C) */

/* 
 * 1. Seleccionar todos los continentes mostrando solo su nombre y el código.
 */

SELECT codigo, nombre
FROM continente;

/*
 * 2. Seleccionar los registros de ciudades en Japón.
 */

SELECT ciudad.nombre,              --Se debe especificar tabla porque PAIS tiene campos con igual nombre
	   ciudad.poblacion, 
	   ciudad.superficie
FROM ciudad, pais                  --Se requiere la tabla pais para buscar a 'japon'
WHERE pais.codigo = ciudad.pais    --Enlace entre las dos tablas
AND pais.nombre = 'Japon';         --Restricción que pide el ejercicio

/* 
 * 3. ¿A qué continente pertenece la ciudad de Luxor?
 */

SELECT continente.nombre
FROM continente, pais, ciudad
WHERE continente.codigo = pais.continente
AND pais.codigo = ciudad.pais
AND ciudad.nombre = 'Luxor';

/*
 * 4. ¿Qué ciudades tienen más de un millón de habitantes?
 */

SELECT nombre, poblacion
FROM ciudad
WHERE poblacion > 1000000;

/*
 * 5. Seleccionar todas las ciudades africanas donde se habla inglés.
 */

SELECT ciudad.nombre, pais.idioma, continente.nombre
FROM pais, continente, ciudad
WHERE continente.codigo = pais.continente
AND pais.codigo = ciudad.pais
AND idioma = 'ingles'                  -- Se debe hablar ingles
AND continente.nombre = 'Africa';      -- Se requiere que sea una ciudad africana

/*
 * 6. Listar todos los datos de las organizaciones de las que Chile es miembro.
 */

SELECT organizacion.codigo, 
	   organizacion.sigla, 
	   organizacion.nombre,
	   organizacion.fundacion
FROM organizacion, pais_organizacion, pais
WHERE pais.codigo =  pais_organizacion.pais
AND pais_organizacion.organizacion = organizacion.codigo
AND pais.nombre = 'Chile';

/*
 * 7. Listar cinco de las ciudades más pobladas junto con la siguiente información: 
 * nombre de la ciudad, continente donde se ubica y población.
 */

SELECT ciudad.nombre, continente.nombre, ciudad.poblacion
FROM ciudad, pais, continente
WHERE continente.codigo = pais.continente
AND pais.codigo = ciudad.pais
ORDER BY ciudad.poblacion DESC  --Se ordena el resultado por poblaon, decendente
LIMIT 5;                        --Se limita para que solo se muestren los 5 primeros registros


/*
 * 8. Listar las organizaciones compuestas solamente por países ubicados en 
 * América o Europa.
 */

SELECT DISTINCT organizacion.* 
FROM continente, pais, pais_organizacion, organizacion
WHERE continente.codigo = pais.continente
AND pais.codigo = pais_organizacion.pais 
AND pais_organizacion.organizacion = organizacion.codigo
AND (continente.nombre = 'America'
     OR continente.nombre = 'Europa') -- Se utiliza un OR
     
/*
 * 9. Identificar a los países miembros de la organización cuya sigla es “BFA”. 
 * La consulta debe retornar el nombre del país, el nombre de su capital y el continente
 * donde se ubica.
 */
     
SELECT pais.nombre,
       ciudad.nombre,
       continente.nombre
FROM continente, pais, ciudad, pais_organizacion, organizacion
WHERE continente.codigo = pais.continente
--Notese que la union entre tabla PAIS y CIUDAD se hace a traves del enlace de capital
AND pais.capital = ciudad.nombre
AND pais.codigo = pais_organizacion.pais      
AND pais_organizacion.organizacion = organizacion.codigo
AND organizacion.sigla = 'BFA';
-- NOTA: Esta respuesta no incluye paises sin capital registrada