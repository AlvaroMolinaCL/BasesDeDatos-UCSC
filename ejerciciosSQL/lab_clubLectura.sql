/*
Laboratorio - Ejercicios SQL: Club de Lectura

Realizar los ejercicios propuestos. Todos los ejercicios (incluyendo las preguntas) deben ser resueltos 
utilizando SQL.
*/

/*
1) Imprimir un resumen que muestre a todos los miembros del club junto con los libros que han 
leído o han comenzado a leer. Debe aparecer el nombre y el apellido del miembro junto con el 
título del libro. La lista desplegada debe estar ordenada alfabéticamente de acuerdo al apellido 
primero y al titulo del libro segundo, en orden descendente.
*/

SELECT apellido, nombre, titulo
FROM integrante, integrante_libro, libro
WHERE integrante.rut = integrante_libro.integrante
AND   libro.codigo = integrante_libro.libro
ORDER BY apellido, titulo DESC;

/*
2) Realizar la misma lista del ejercicio 1, pero solo considerando libros terminados.
*/

SELECT apellido, nombre, titulo
FROM integrante, integrante_libro, libro
WHERE integrante.rut = integrante_libro.integrante
AND   libro.codigo = integrante_libro.libro
AND   fecha_termino IS NOT NULL
ORDER BY apellido, titulo DESC;

/*
3) Listar las editoriales ordenadas de forma ascendente en base a la cantidad de lecturas que tiene
cada editorial. Debe mostrarse el nombre de la editorial junto con la cantidad de lecturas que
tienen sus libros. ¿Cuál es la editorial más leída en el club?
*/

SELECT editorial, COUNT(*) AS numero_libros
FROM libro, integrante_libro
WHERE integrante_libro.libro = libro.codigo
GROUP BY editorial
ORDER BY COUNT(*); 

/*
4) Listar a cada miembro junto a la cantidad de libros que aún está leyendo (libros sin fecha de
término).
*/

SELECT nombre, apellido, COUNT(*) AS libros_en_lectura
FROM integrante, integrante_libro
WHERE integrante_libro.integrante = integrante.rut
AND   fecha_termino IS NULL
GROUP BY integrante.rut;

/*
5) Seleccione los datos de los miembros que no han leído ningún libro.
*/

SELECT *
FROM integrante
WHERE rut NOT IN (SELECT integrante
                  FROM integrante_libro)

-- De la misma manera, seleccione los datos de los libros en la base de datos que aún no han sido leídos
SELECT *
FROM libro
WHERE codigo NOT IN (SELECT libro
                     FROM integrante_libro)

/*
6) Seleccione todos los libros junto con el promedio de días que han tardado en ser leídos.
*/

SELECT titulo, AVG(fecha_termino - fecha_inicio) AS promedio
FROM libro, integrante_libro
WHERE integrante_libro.libro = libro.codigo
AND   fecha_termino IS NOT NULL
GROUP BY libro.codigo 