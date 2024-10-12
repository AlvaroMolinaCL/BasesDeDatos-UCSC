--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4
-- Dumped by pg_dump version 16.4

-- Started on 2024-10-12 17:48:12

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 5 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 16941)
-- Name: categoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categoria (
    categoria character varying(100) NOT NULL,
    descripcion character varying(100),
    moderador bigint NOT NULL
);


ALTER TABLE public.categoria OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16944)
-- Name: registro_entrada; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.registro_entrada (
    codigo bigint NOT NULL,
    fecha_hora timestamp without time zone NOT NULL,
    usuario bigint NOT NULL
);


ALTER TABLE public.registro_entrada OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16947)
-- Name: respuesta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.respuesta (
    cuerpo character varying(1000),
    fecha timestamp without time zone NOT NULL,
    usuario bigint NOT NULL,
    tema bigint NOT NULL
);


ALTER TABLE public.respuesta OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16952)
-- Name: tema; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tema (
    codigo bigint NOT NULL,
    fecha timestamp without time zone NOT NULL,
    titulo character varying(100) NOT NULL,
    cuerpo character varying(1000),
    creador bigint NOT NULL,
    categoria character varying(100)
);


ALTER TABLE public.tema OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16957)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario (
    codigo bigint NOT NULL,
    nombre character varying(100),
    alias character varying(100) NOT NULL,
    fecha_nacimiento date NOT NULL,
    password character varying(10) NOT NULL
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- TOC entry 4862 (class 0 OID 16941)
-- Dependencies: 215
-- Data for Name: categoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categoria (categoria, descripcion, moderador) FROM stdin;
Matematicas	Cualquier tema de matematicas o estadisticas	6
Animales	Zoologia, veterinaria, etc	7
Otros	temas que no entren en las otras categorias	7
Salud	\N	7
Historia	\N	8
Musica	\N	6
Deportes		14
\.


--
-- TOC entry 4863 (class 0 OID 16944)
-- Dependencies: 216
-- Data for Name: registro_entrada; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.registro_entrada (codigo, fecha_hora, usuario) FROM stdin;
1	2022-06-02 23:50:00	1
2	2022-07-02 13:10:11	1
3	2022-06-07 18:20:00	1
4	2022-09-16 14:47:00	1
5	2022-06-02 23:50:00	2
6	2022-06-02 23:50:00	3
7	2022-06-02 23:50:00	4
8	2022-06-02 23:50:00	5
9	2022-09-18 14:47:00	5
10	2022-06-02 23:50:00	6
11	2022-09-18 14:07:00	6
12	2022-06-02 23:50:00	7
13	2022-06-02 23:50:00	13
14	2022-06-02 23:50:00	8
15	2022-06-02 23:50:00	9
16	2022-06-03 00:10:00	10
17	2022-06-02 23:55:00	11
18	2022-06-02 23:50:00	12
19	2022-06-02 23:52:00	14
20	2022-06-03 03:50:00	15
21	2022-06-06 23:50:00	16
\.


--
-- TOC entry 4864 (class 0 OID 16947)
-- Dependencies: 217
-- Data for Name: respuesta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.respuesta (cuerpo, fecha, usuario, tema) FROM stdin;
Nadie ayuda?	2022-09-18 14:23:00	2	1
No	2022-09-18 14:28:00	1	1
Hola Fifi!	2022-09-18 14:30:00	5	2
Diviertete en el foro	2022-09-19 01:45:21	11	2
Seamos amigas	2022-09-19 13:05:04	3	2
No soy la indicada para ayudarte	2022-09-18 19:22:01	7	5
La saga de Dead Space	2022-07-08 17:34:06	10	6
Habia una de un asesino serial que me gusto mucho	2022-07-09 17:00:06	5	6
Eso es un videojuego, no una pelicula. Yo recomiendo "La morgue" 	2022-07-09 11:34:06	2	6
Son muy lindos	2022-07-14 12:11:32	8	8
Yo he estado ahi tambien	2022-08-11 01:37:05	1	7
Me apunto	2022-08-29 19:45:07	16	9
entro	2022-08-29 19:59:00	6	9
entro	2022-08-29 23:45:01	7	9
Me apunto	2022-08-30 11:45:02	5	9
Entro. Les ganaré a todos	2022-08-30 15:00:00	15	9
Frank Sinatra es el mejor!	2022-06-26 00:35:30	7	10
hay muchos buenos como para elegir	2022-06-27 10:02:10	12	10
Es verdad. Fue dificil tener que elegir entre Frank y Billy IDol	2022-06-27 10:32:00	7	10
\.


--
-- TOC entry 4865 (class 0 OID 16952)
-- Dependencies: 218
-- Data for Name: tema; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tema (codigo, fecha, titulo, cuerpo, creador, categoria) FROM stdin;
2	2022-09-18 14:25:45.559	Hola a todos	Me presento. Soy Fifi, mucho gusto	13	Otros
3	2022-06-02 23:50:00	Se abre el foro	\N	7	Otros
4	2022-06-23 14:17:20	Discutamos sobre Alejandro Magno	\N	11	Historia
5	2022-09-18 14:31:01	¿conocen algun truco de magia matemático?	Quiero impresionar en mi presentación	6	Matematicas
6	2022-07-08 17:34:06	Recomendaciones de peliculas	Recomienden peliculas de terror	8	Otros
1	2022-09-17 21:21:00	Cuantos lados tiene un triangulo equilatero???	Ayuda pls	2	Matematicas
9	2022-08-29 19:45:07	Primer campeonato de pingpong	Inscripciones más abajo	14	Deportes
7	2022-08-10 12:31:05	Descubrimiento arqueologico	Se encontraron nuevos artefactos arqueológicos en mi localidad.  Les comparto están todas las fotos que tome el dia de ayer	8	Historia
8	2022-07-13 18:01:37	Se regalan gatitos	Quien quiera adoptar uno, llamar a el siguiente número: 8065234	9	Animales
10	2022-06-26 00:00:00	Nuestros cantantes favoritos	¿Quienes son? Mi cantante favorita es Dolores O Riordan	6	Musica
11	2022-09-17 09:04:27	Sobre el campeonato de pingpong	Gracias a todos los que participaron. Pese al incidente, fue divertido	14	Deportes
12	2022-09-19 17:40:23	Descubrí que soy adoptado	No sé que más decir	11	Otros
\.


--
-- TOC entry 4866 (class 0 OID 16957)
-- Dependencies: 219
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuario (codigo, nombre, alias, fecha_nacimiento, password) FROM stdin;
2	Roberto Alberto	Roberto	1998-12-10	678754432
3	Romina Paredes	Rana_saltarina	2006-01-09	rana12345
4	\N	Renato	2001-06-27	Destroyer
5	Raul Silva	Romulo	1979-02-17	hubhub2
6	Alejandro	el general	2009-10-10	89922as
7	Daniela Brokeesmith	Armadillo99	1999-07-04	blur
1	Fanita	Fanita666	1989-06-06	Fanita666
8	Renato  Javier Retamal	Javierillo	2001-09-04	dampol
9	\N	Reina1981	1981-05-27	dorotea123
10	\N	Jaime	1997-10-10	2222111
11	\N	Godofredo	2004-11-17	cjsn42p1
12	\N	Megaman	1989-08-19	2334324
13	Fatima Melgarejo	Fifi	2009-03-23	Furia1236
14	Luna	Princesa Luna 	1998-09-12	LunaLuna
15	\N	Fanita123	1989-06-06	Fanita123
16	Gerardo Mendez	Gera12	1990-10-11	grt192
\.


--
-- TOC entry 4704 (class 2606 OID 16961)
-- Name: categoria categoria_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT categoria_pk PRIMARY KEY (categoria);


--
-- TOC entry 4706 (class 2606 OID 16963)
-- Name: registro_entrada registro_entrada_usuario_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.registro_entrada
    ADD CONSTRAINT registro_entrada_usuario_pk PRIMARY KEY (codigo);


--
-- TOC entry 4708 (class 2606 OID 16965)
-- Name: respuesta respuesta_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.respuesta
    ADD CONSTRAINT respuesta_pk PRIMARY KEY (fecha, usuario, tema);


--
-- TOC entry 4710 (class 2606 OID 16967)
-- Name: tema tema_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tema
    ADD CONSTRAINT tema_pk PRIMARY KEY (codigo);


--
-- TOC entry 4712 (class 2606 OID 16969)
-- Name: usuario usuario_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pk PRIMARY KEY (codigo);


--
-- TOC entry 4713 (class 2606 OID 16970)
-- Name: categoria categoria_usuario_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT categoria_usuario_fk FOREIGN KEY (moderador) REFERENCES public.usuario(codigo);


--
-- TOC entry 4714 (class 2606 OID 16975)
-- Name: registro_entrada registro_entrada_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.registro_entrada
    ADD CONSTRAINT registro_entrada_fk FOREIGN KEY (usuario) REFERENCES public.usuario(codigo);


--
-- TOC entry 4715 (class 2606 OID 16980)
-- Name: respuesta respuesta_tema_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.respuesta
    ADD CONSTRAINT respuesta_tema_fk FOREIGN KEY (tema) REFERENCES public.tema(codigo);


--
-- TOC entry 4716 (class 2606 OID 16985)
-- Name: respuesta respuesta_usuario_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.respuesta
    ADD CONSTRAINT respuesta_usuario_fk FOREIGN KEY (usuario) REFERENCES public.usuario(codigo);


--
-- TOC entry 4717 (class 2606 OID 16990)
-- Name: tema tema_categoria_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tema
    ADD CONSTRAINT tema_categoria_fk FOREIGN KEY (categoria) REFERENCES public.categoria(categoria);


--
-- TOC entry 4718 (class 2606 OID 16995)
-- Name: tema tema_usuario_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tema
    ADD CONSTRAINT tema_usuario_fk FOREIGN KEY (creador) REFERENCES public.usuario(codigo);


-- Completed on 2024-10-12 17:48:12

--
-- PostgreSQL database dump complete
--

