/*
Laboratorio 06 - Ejercicios SQL (Funciones de Agregación): Profesionales y Proyectos

Realizar los ejercicios propuestos. Todos los ejercicios (incluyendo las preguntas) deben ser resueltos 
utilizando SQL.
*/

/*
1) Cree una sentencia SQL que liste todos los profesionales (rut_prof, nom_prof) que han 
trabajado en proyectos anteriores al año 2000. Los nombres no deben repetirse.
*/

SELECT profesional.rut_prof, profesional.nom_prof
FROM profesional, profesional_proyecto, proyecto
WHERE profesional.rut_prof = profesional_proyecto.rut_prof
AND   profesional_proyecto.id_proyecto = proyecto.id_proyecto
AND   fecha < '01/01/2000'
GROUP BY profesional.rut_prof;

/*
-- con 'date_part()'
SELECT profesional.rut_prof, profesional.nom_prof
FROM profesional, profesional_proyecto, proyecto
WHERE profesional.rut_prof = profesional_proyecto.rut_prof
AND   profesional_proyecto.id_proyecto = proyecto.id_proyecto
AND   date_part('YEAR', fecha) < 2000
GROUP BY profesional.rut_prof;
*/

/*
2) Cree una sentencia SQL que liste la cantidad de profesionales por nombre de profesión 
(nombre_profesion, cantidad).
*/

SELECT nom_profesion AS nombre, COUNT(*) AS cantidad
FROM profesion, profesional
WHERE profesion.cd_profesion = profesional.cd_profesion
GROUP BY nom_profesion;

/*
3) Cree una sentencia SQL que seleccione el mayor valor_hora de un cargo.
*/

SELECT MAX(valor_hora)
FROM cargo;

-- Si se quiere saber cuál es el cargo que tiene ese valor hora, ¿cómo sería la consulta?
SELECT nom_cargo  
FROM cargo
WHERE valor_hora = (SELECT MAX(valor_hora)
                    FROM cargo);

/*
4) Cree una consulta SQL que permita conocer las horas totales que ha trabajado cada profesional
en proyectos (nom_prof, total_horas).
*/

SELECT profesional.rut_prof, profesional.nom_prof, SUM(nro_horas)
FROM profesional_proyecto, profesional
WHERE profesional.rut_prof = profesional_proyecto.rut_prof
GROUP BY profesional.rut_prof;

/*
5) Cree una sentencia SQL para seleccionar todos los proyectos desarrollados con la siguiente
información: id_proyecto, fecha, valor_total, rut_jefe, nom_jefe. (rut_jefe y nom_jefe se refiere
a conocer sólo los datos del jefe del proyecto). Compruebe en el resultado que no tiene el
valor_total del proyecto en la tabla proyecto. ¿Cómo calcularía ese valor si éste corresponde al
costo de los profesionales que trabajan en el proyecto?
*/

SELECT proyecto.id_proyecto, fecha, valor_total,
       profesional_proyecto.rut_prof, profesional.nom_prof
FROM proyecto, profesional, profesional_proyecto
WHERE proyecto.id_proyecto = profesional_proyecto.id_proyecto
AND   profesional_proyecto.rut_prof = profesional.rut_prof
AND   profesional_proyecto.nom_cargo = 'Jefe';

-- Costo total por proyecto
SELECT id_proyecto, SUM(valor_hora * nro_horas)
FROM cargo, profesional_proyecto
WHERE profesional_proyecto.nom_cargo = cargo.nom_cargo
GROUP BY id_proyecto;

-- Corrección
SELECT id_proyecto, SUM(valor_hora::integer * nro_horas)
FROM cargo, profesional_proyecto
WHERE profesional_proyecto.nom_cargo = cargo.nom_cargo
GROUP BY id_proyecto;