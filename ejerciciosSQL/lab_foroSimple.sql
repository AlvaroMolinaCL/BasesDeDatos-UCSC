/*
Laboratorio - Ejercicios SQL (consultas): Foro Simple

La base de datos es utilizada por un foro web de diseño minimalista. En el foro cada usuario registrado 
(tabla USUARIO) puede crear diferentes temas (TEMA) en diferentes categorías (CATEGORIA), así como 
también contestar los temas creados por otros usuarios (RESPUESTA). Cada categoría es moderada por 
un usuario específico. Por razones de seguridad, se guarda registro de cada vez que un usuario entra a 
la plataforma (REGISTRO_ENTRADA).

Realizar los ejercicios propuestos. Todos los ejercicios (incluyendo las preguntas) deben ser resueltos 
utilizando SQL.
*/

/*
1) Seleccionar los nombres de los usuarios junto con sus apodos y contraseñas. Los resultados 
deben aparecer en orden alfabético primero por el alias, y luego por el nombre.
*/

SELECT nombre, alias, password
FROM usuario
ORDER BY alias, nombre;

/*
2) Seleccionar a todos los usuarios moderadores. Debe mostrarse solo el alias y código de cada 
moderador. No deben aparecer registros repetidos.
*/

SELECT DISTINCT codigo, alias 
FROM usuario, categoria
WHERE usuario.codigo = moderador;

/*
3) Seleccionar el nombre de cada categoría junto con el alias de su moderador.
*/

SELECT categoria, alias
FROM usuario, categoria
WHERE codigo = moderador;

/*
4) Seleccionar a todos los usuarios cuyo primer nombre es "Roberto". Se debe tener en cuenta que 
en la base de datos, los nombres y apellidos se guardan en la misma columna.
*/

SELECT codigo, nombre
FROM usuario
WHERE nombre LIKE 'Roberto%';

/*
5) Seleccione todos los temas publicados entre el 15 de agosto y el 20 de septiembre del 2022. 
Debe mostrar el nombre del autor, el título del tema y la fecha de publicación. Los registros 
deben ordenarse desde el más reciente al más antiguo.
*/

SELECT titulo, nombre, fecha
FROM tema, usuario
WHERE tema.creador = usuario.codigo
AND   fecha BETWEEN '15-8-2022' AND '20-9-2022'
ORDER BY fecha DESC;

/*
6) Seleccionar todos los temas que pertenecen a la categoría de “Historia”. Mostrar el código y 
título del tema, junto con el alias y nombre del autor.
*/

SELECT tema.codigo, titulo, nombre, alias
FROM usuario, tema
WHERE usuario.codigo = creador
AND   categoria = 'Historia';

/*
7) ¿Cuáles usuarios nacieron durante el siglo XX? Listar el nombre y la fecha de nacimiento de 
solo dos de ellos.
*/

SELECT nombre, fecha_nacimiento
FROM usuario
WHERE fecha_nacimiento < '2001-1-1';

/*
8) Mostrar todos los temas en los que ha respondido la usuaria “Daniela Brokeesmith”. Se debe 
listar el código del tema, el titulo, y no deben aparecer registros repetidos.
*/

SELECT DISTINCT tema.codigo, titulo
FROM usuario, tema, respuesta
WHERE usuario.codigo = respuesta.usuario
AND   respuesta.tema = tema.codigo
AND   usuario.nombre = 'Daniela Brokeesmith';

/*
9) Mostrar todos los registros de veces que el autor del tema “Nuestros cantantes favoritos” ha 
entrado al foro. Deben mostrarse desde el más reciente al más antiguo.
*/

-- Con fecha y hora.
SELECT fecha_hora
FROM registro_entrada, usuario, tema
WHERE registro_entrada.usuario = usuario.codigo
AND   tema.creador = usuario.codigo
AND   tema.titulo = 'Nuestros cantantes favoritos'
ORDER BY fecha_hora DESC;

/*
10) Seleccionar todos los temas con la siguiente información: codigo, título, fecha y categoría del 
tema, junto con el código, alias y nombre del usuario al que le corresponde moderalo. Por 
legibilidad, se deben etiquetar las columnas de la siguiente manera: 
codigo del tema, titulo, fecha de publicación, categoria, codigo del 
moderador, alias del moderador, moderador.
*/

SELECT tema.codigo AS "codigo del tema",
       titulo, 
       fecha AS "fecha publicacion", 
       tema.categoria,
       usuario.codigo AS "codigo del moderador", 
       alias AS "alias moderador", 
       nombre AS moderador
FROM usuario, categoria, tema
WHERE usuario.codigo = moderador
AND categoria.categoria = tema.categoria;

/*
11) Encontrar todas las respuestas "negativas" en el foro. Se considera una respuesta como negativa
cuando está conformada por un “No”, independientemente del contenido restante. Debe 
aparecer la siguiente información: código del tema, alias del autor del tema, alias del autor de la
respuesta, el cuerpo de la respuesta y  la fecha de la respuesta. Los registros deben estar 
ordenados de acuerdo al código del tema y a la fecha de la respuesta.
*/

-- Esta respuesta toma erróneamente también palabras que tienen "no" entremedio (ej: asesino).
SELECT tema.codigo,
	   autor_tema.alias AS autor,
	   autor_respuesta.alias AS respondedor_negativo,
	   respuesta.cuerpo,
	   respuesta.fecha
FROM usuario autor_tema,
	 usuario autor_respuesta,
	 respuesta,
	 tema
WHERE autor_tema.codigo = tema.creador
AND   respuesta.tema = tema.codigo
AND   autor_respuesta.codigo = respuesta.usuario
AND   UPPER(respuesta.cuerpo) LIKE '%NO%' 
ORDER BY tema.codigo, respuesta.fecha;

-- Esta respuesta toma solamente la palabra "no" cuando está entre espacios en blanco.
SELECT tema.codigo,
	   autor_tema.alias AS autor,
	   autor_respuesta.alias AS respondedor_negativo,
	   respuesta.cuerpo,
	   respuesta.fecha
FROM usuario autor_tema,
	 usuario autor_respuesta,
	 respuesta,
	 tema
WHERE autor_tema.codigo = tema.creador
AND   respuesta.tema = tema.codigo
AND   autor_respuesta.codigo = respuesta.usuario
AND   UPPER(respuesta.cuerpo) LIKE '% NO %'  --Se incluye espacio en blanco
ORDER BY tema.codigo, respuesta.fecha;

-- Esta respuesta incluye la palabra "no" aislada y toma en cuenta enunciados que empiezan o terminan con "no".

SELECT tema.codigo,
	   autor_tema.alias AS autor,
	   autor_respuesta.alias AS respondedor_negativo,
	   respuesta.cuerpo,
	   respuesta.fecha
FROM usuario autor_tema,
	 usuario autor_respuesta,
	 respuesta,
	 tema
WHERE autor_tema.codigo = tema.creador
AND   respuesta.tema = tema.codigo
AND   autor_respuesta.codigo = respuesta.usuario
AND   (UPPER(respuesta.cuerpo) LIKE '% NO %' -- Palabra NO en medio de la oración.
OR     UPPER(respuesta.cuerpo) LIKE 'NO %' -- Cuando la oración empieza con NO.
OR     UPPER(respuesta.cuerpo) LIKE 'NO' -- Cuando la oración es solo un NO.
OR     UPPER(respuesta.cuerpo) LIKE '% NO')  -- Cuando la oración termina en NO.
ORDER BY tema.codigo, respuesta.fecha;