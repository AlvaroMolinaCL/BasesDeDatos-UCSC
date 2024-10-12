--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4
-- Dumped by pg_dump version 16.4

-- Started on 2024-10-12 18:36:11

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
-- TOC entry 215 (class 1259 OID 17357)
-- Name: capitulo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.capitulo (
    serie integer NOT NULL,
    titulo text NOT NULL,
    emision date,
    temporada smallint,
    capitulo smallint,
    duracion interval
);


ALTER TABLE public.capitulo OWNER TO postgres;

--
-- TOC entry 4923 (class 0 OID 0)
-- Dependencies: 215
-- Name: TABLE capitulo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.capitulo IS 'capítulos que componen series';


--
-- TOC entry 216 (class 1259 OID 17362)
-- Name: cliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cliente (
    codigo integer NOT NULL,
    nombre text NOT NULL,
    nacimiento date NOT NULL,
    alias text,
    pais integer NOT NULL,
    activo boolean DEFAULT true NOT NULL
);


ALTER TABLE public.cliente OWNER TO postgres;

--
-- TOC entry 4924 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN cliente.codigo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cliente.codigo IS 'código unico de cliente';


--
-- TOC entry 217 (class 1259 OID 17368)
-- Name: critica; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.critica (
    cliente integer NOT NULL,
    obra integer NOT NULL,
    fecha date NOT NULL,
    estrellas smallint NOT NULL,
    comentario text
);


ALTER TABLE public.critica OWNER TO postgres;

--
-- TOC entry 4925 (class 0 OID 0)
-- Dependencies: 217
-- Name: TABLE critica; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.critica IS 'criticas realizadas por clientes a las obras disponibles';


--
-- TOC entry 218 (class 1259 OID 17373)
-- Name: documental; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.documental (
    codigo integer NOT NULL,
    duracion interval NOT NULL
);


ALTER TABLE public.documental OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17376)
-- Name: estudio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estudio (
    codigo integer NOT NULL,
    nombre text NOT NULL
);


ALTER TABLE public.estudio OWNER TO postgres;

--
-- TOC entry 4926 (class 0 OID 0)
-- Dependencies: 219
-- Name: TABLE estudio; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.estudio IS 'Estudio cinematográfico';


--
-- TOC entry 220 (class 1259 OID 17381)
-- Name: obra; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.obra (
    codigo integer NOT NULL,
    titulo text NOT NULL,
    anio smallint,
    trailer boolean NOT NULL,
    resumen text,
    estudio integer NOT NULL
);


ALTER TABLE public.obra OWNER TO postgres;

--
-- TOC entry 4927 (class 0 OID 0)
-- Dependencies: 220
-- Name: TABLE obra; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.obra IS 'obras conematográficas, series, peliculas y documentales';


--
-- TOC entry 221 (class 1259 OID 17386)
-- Name: obra_zona; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.obra_zona (
    obra integer NOT NULL,
    zona text NOT NULL
);


ALTER TABLE public.obra_zona OWNER TO postgres;

--
-- TOC entry 4928 (class 0 OID 0)
-- Dependencies: 221
-- Name: TABLE obra_zona; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.obra_zona IS 'Disponibilidad de las obras en las distintas zonas';


--
-- TOC entry 222 (class 1259 OID 17391)
-- Name: pais; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pais (
    codigo integer NOT NULL,
    nombre text NOT NULL,
    zona text NOT NULL
);


ALTER TABLE public.pais OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 17396)
-- Name: pelicula; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pelicula (
    codigo integer NOT NULL,
    duracion interval NOT NULL
);


ALTER TABLE public.pelicula OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 17399)
-- Name: serie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.serie (
    codigo integer NOT NULL,
    en_emision boolean DEFAULT false NOT NULL,
    n_capitulos smallint,
    n_temporadas smallint DEFAULT 1
);


ALTER TABLE public.serie OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 17404)
-- Name: zona; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.zona (
    nombre text NOT NULL,
    descripcion text,
    mensualidad integer DEFAULT 1000 NOT NULL
);


ALTER TABLE public.zona OWNER TO postgres;

--
-- TOC entry 4929 (class 0 OID 0)
-- Dependencies: 225
-- Name: TABLE zona; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.zona IS 'zonas geográficas y administratibas identificadas por la plataforma';


--
-- TOC entry 4907 (class 0 OID 17357)
-- Dependencies: 215
-- Data for Name: capitulo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.capitulo (serie, titulo, emision, temporada, capitulo, duracion) FROM stdin;
27	Planeando el viaje	2024-06-10	1	1	00:45:00
27	Inicia la aventura	2024-06-20	1	2	00:45:00
24	Encuentro inesperado	2020-10-10	1	1	00:42:00
24	Odio	2020-10-10	1	2	00:42:00
24	Navidad amarga	2020-10-10	1	3	00:42:00
24	No todos tienen un final feliz	2020-10-10	1	4	00:42:00
25	¡Detente Renata!	2023-02-20	1	1	01:00:00
25	El camino a los problemas	2023-02-28	1	2	01:00:00
25	Bang Bang	2023-03-08	1	3	01:00:00
28	Río abajo	2021-04-01	2	4	00:57:00
28	Rubén	2021-05-01	3	5	00:57:45
28	Cocodrilo del Nilo	2021-06-01	3	6	00:57:00
28	Cocodrilo	2021-01-01	1	1	00:57:00
28	Caimán	2021-02-01	1	2	00:57:00
28	Cacería	2021-03-01	2	3	00:57:00
\.


--
-- TOC entry 4908 (class 0 OID 17362)
-- Dependencies: 216
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cliente (codigo, nombre, nacimiento, alias, pais, activo) FROM stdin;
100	Alberto Finot	1989-10-10	\N	2	t
101	Fanita Retamal	2002-08-13	La Fanita	10	f
102	Gerardo Gonzalez	1980-05-17	El Gera	1	t
103	Daniela Alberta Retamal	1989-01-10	Dani	1	t
104	Mark Hoppus	1989-10-31	\N	9	t
105	Juan Roberto Valdebenito	1995-10-10	\N	8	t
106	Natalia Alarcón	1978-02-28	\N	2	t
107	Bernardo Nuñez	1997-09-08	\N	2	t
108	Luna	1998-10-10	Princess	9	t
109	Rodrigo Bustamante	2005-12-08	\N	4	t
110	Malfurion Stormrage	1985-03-15	\N	9	t
111	Zapallo Plátano	1993-06-10	Daniel	1	f
112	Gerardo Brookesmith	1968-05-08	Bloom	9	t
113	Ramon Zúñiga	2008-07-19	Pollo	4	t
114	Daniel Moreno	2005-12-08	\N	12	f
115	Natalia Plátano	1990-07-10	\N	3	t
116	Renato Ortiz	1987-12-05	Renato	3	t
\.


--
-- TOC entry 4909 (class 0 OID 17368)
-- Dependencies: 217
-- Data for Name: critica; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.critica (cliente, obra, fecha, estrellas, comentario) FROM stdin;
102	11	2023-11-16	5	Exelente película
102	19	2020-10-18	4	\N
102	20	2020-10-18	4	\N
102	21	2020-11-30	3	\N
102	22	2023-02-14	5	La saga recuperó su antigua gloria
111	13	2019-11-10	3	\N
111	19	2022-08-01	2	\N
107	19	2022-05-11	4	\N
115	19	2019-07-18	5	\N
115	20	2019-07-18	5	\N
115	21	2019-07-21	5	La cúlmine del cine arte
116	12	2023-11-16	1	\N
109	26	2023-11-16	5	\N
113	26	2019-04-27	4	Es buena, pero parte muy lenta
104	10	2023-04-16	3	\N
104	13	2019-03-09	5	\N
104	14	2021-07-12	3	\N
104	19	2019-03-09	2	\N
108	13	2023-03-22	0	NO
110	19	2022-11-16	5	Obra maestra de acción e intriga
110	12	2022-11-16	4	\N
110	10	2022-03-17	4	\N
112	11	2022-06-07	3	\N
101	10	2021-06-07	1	Muy mala
101	11	2021-06-07	1	mala
101	12	2022-02-16	0	aburrida
101	13	2022-01-17	1	muy mala
114	21	2023-11-16	5	\N
114	15	2023-11-18	4	\N
\.


--
-- TOC entry 4910 (class 0 OID 17373)
-- Dependencies: 218
-- Data for Name: documental; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.documental (codigo, duracion) FROM stdin;
14	01:15:00
16	01:05:00
17	02:00:00
23	00:45:50
29	00:56:00
30	01:17:00
\.


--
-- TOC entry 4911 (class 0 OID 17376)
-- Dependencies: 219
-- Data for Name: estudio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.estudio (codigo, nombre) FROM stdin;
1	Estudios Metal de Bromo
2	Rómulo Studios
3	Estudios 
4	Cine Azul
5	Television Abierta
6	Jupiter Studios
7	Piña
\.


--
-- TOC entry 4912 (class 0 OID 17381)
-- Dependencies: 220
-- Data for Name: obra; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.obra (codigo, titulo, anio, trailer, resumen, estudio) FROM stdin;
10	El mar está en calma	2009	t	\N	1
11	El armario	1980	t	Un enorme armario siniestro se presenta en los sueños de la protagonista , Rocío Rodriguez, quien debe correr para salvar su vida	1
12	Ampliación de la mente	1995	t	\N	4
13	The Biggest roach	2008	f	\N	2
14	La triste vida de una araña	2018	f	\N	5
15	Arnold does not like it	1991	f	Arnold is a complicated man	2
16	Leones en África	1999	f	Acompañe a una manada de leones durante la lucha por la supervivencia	5
17	El sol	2010	t	La estrella que nos da vida no vivirá para siempre	4
18	Aventuras en Armenia	1972	f	\N	1
19	El imperio del mal	1995	t	Roberto es un policía corrupto que no permitirá que nadie se meta en su camino	1
20	El imperio del mal 2, la venganza	2006	t	Tras la muerte de Roberto se ha creado un vacío de poder ¿Quién logrará tomar el control del Imperio del Mal?	1
21	El imperio del mal 3, recargado	2007	t	¡El Imperio del mal no se detendrá!	1
22	El imperio del mal 4, destruccion total	2018	t	Metal de Bromo nos trae de vuelta un clásico del cine	1
23	El interior de la mente	1998	t		5
24	Viajero del tiempo	1995	t	Drama romántico	5
25	Renata y la escopeta	2020	t	\N	1
26	Billy	2007	f	\N	2
27	La conquista de Plutón	2024	t	\N	2
28	Cocodrilo	2019	f	\N	4
29	Cocinando con Juanita	2012	f	La habilidad de Juana Drake queda plasmada en menos de 60 minutos	1
30	La vida de los grandes maestros	1997	t	\N	7
\.


--
-- TOC entry 4913 (class 0 OID 17386)
-- Dependencies: 221
-- Data for Name: obra_zona; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.obra_zona (obra, zona) FROM stdin;
10	America Norte
11	America Norte
12	America Norte
13	America Norte
14	America Norte
15	America Norte
16	America Norte
17	America Norte
18	America Norte
19	America Norte
25	America Norte
26	America Norte
27	America Norte
11	America Sur
12	America Sur
13	America Sur
14	America Sur
15	America Sur
19	America Sur
20	America Sur
21	America Sur
22	America Sur
28	America Sur
17	America Sur
10	Europa y Asia
11	Europa y Asia
12	Europa y Asia
13	Europa y Asia
14	Europa y Asia
15	Europa y Asia
16	Europa y Asia
17	Europa y Asia
18	Europa y Asia
19	Europa y Asia
20	Europa y Asia
21	Europa y Asia
22	Europa y Asia
28	Europa y Asia
12	Otros
27	Otros
28	Otros
26	China
29	America Norte
30	Otros
30	China
\.


--
-- TOC entry 4914 (class 0 OID 17391)
-- Dependencies: 222
-- Data for Name: pais; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pais (codigo, nombre, zona) FROM stdin;
1	Chile	America Sur
2	Argentina	America Sur
3	Colombia	America Sur
4	China	China
5	España	Europa y Asia
6	Polonia	Europa y Asia
7	Japon	Europa y Asia
8	Egipto	Otros
9	USA	America Norte
10	Mexico	America Norte
11	Alemania	Europa y Asia
12	Taiwan	Europa y Asia
\.


--
-- TOC entry 4915 (class 0 OID 17396)
-- Dependencies: 223
-- Data for Name: pelicula; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pelicula (codigo, duracion) FROM stdin;
10	01:35:00
11	05:00:00
12	01:06:00
13	02:01:00
15	02:05:00
18	01:57:00
19	01:23:00
20	01:40:00
21	01:39:00
22	01:55:00
26	01:37:00
\.


--
-- TOC entry 4916 (class 0 OID 17399)
-- Dependencies: 224
-- Data for Name: serie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.serie (codigo, en_emision, n_capitulos, n_temporadas) FROM stdin;
25	f	14	1
27	t	10	1
24	t	4	1
28	f	6	3
\.


--
-- TOC entry 4917 (class 0 OID 17404)
-- Dependencies: 225
-- Data for Name: zona; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.zona (nombre, descripcion, mensualidad) FROM stdin;
America Norte	\N	1200
Otros	Casos especiales	800
America Sur	Centro y sur América	1050
Europa y Asia	No se considera China	1360
China	Solo china	1070
\.


--
-- TOC entry 4732 (class 2606 OID 17411)
-- Name: capitulo capitulo_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.capitulo
    ADD CONSTRAINT capitulo_pk PRIMARY KEY (serie, titulo);


--
-- TOC entry 4734 (class 2606 OID 17413)
-- Name: cliente cliente_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pk PRIMARY KEY (codigo);


--
-- TOC entry 4736 (class 2606 OID 17415)
-- Name: critica critica_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.critica
    ADD CONSTRAINT critica_pk PRIMARY KEY (cliente, obra);


--
-- TOC entry 4738 (class 2606 OID 17417)
-- Name: documental documental_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documental
    ADD CONSTRAINT documental_pk PRIMARY KEY (codigo);


--
-- TOC entry 4740 (class 2606 OID 17419)
-- Name: estudio estudio_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estudio
    ADD CONSTRAINT estudio_pk PRIMARY KEY (codigo);


--
-- TOC entry 4752 (class 2606 OID 17421)
-- Name: zona newtable_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.zona
    ADD CONSTRAINT newtable_pk PRIMARY KEY (nombre);


--
-- TOC entry 4742 (class 2606 OID 17423)
-- Name: obra obra_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.obra
    ADD CONSTRAINT obra_pk PRIMARY KEY (codigo);


--
-- TOC entry 4744 (class 2606 OID 17425)
-- Name: obra_zona obra_zona_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.obra_zona
    ADD CONSTRAINT obra_zona_pk PRIMARY KEY (obra, zona);


--
-- TOC entry 4746 (class 2606 OID 17427)
-- Name: pais pais_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pais
    ADD CONSTRAINT pais_pk PRIMARY KEY (codigo);


--
-- TOC entry 4748 (class 2606 OID 17429)
-- Name: pelicula pelicula_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pelicula
    ADD CONSTRAINT pelicula_pk PRIMARY KEY (codigo);


--
-- TOC entry 4750 (class 2606 OID 17431)
-- Name: serie serie_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serie
    ADD CONSTRAINT serie_pk PRIMARY KEY (codigo);


--
-- TOC entry 4753 (class 2606 OID 17432)
-- Name: capitulo capitulo_serie_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.capitulo
    ADD CONSTRAINT capitulo_serie_fk FOREIGN KEY (serie) REFERENCES public.serie(codigo);


--
-- TOC entry 4754 (class 2606 OID 17437)
-- Name: cliente cliente_pais_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pais_fk FOREIGN KEY (pais) REFERENCES public.pais(codigo);


--
-- TOC entry 4755 (class 2606 OID 17442)
-- Name: critica critica_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.critica
    ADD CONSTRAINT critica_fk FOREIGN KEY (cliente) REFERENCES public.cliente(codigo);


--
-- TOC entry 4756 (class 2606 OID 17447)
-- Name: critica critica_obra_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.critica
    ADD CONSTRAINT critica_obra_fk FOREIGN KEY (obra) REFERENCES public.obra(codigo);


--
-- TOC entry 4757 (class 2606 OID 17452)
-- Name: documental documental_obra_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documental
    ADD CONSTRAINT documental_obra_fk FOREIGN KEY (codigo) REFERENCES public.obra(codigo);


--
-- TOC entry 4758 (class 2606 OID 17457)
-- Name: obra obra_estudio_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.obra
    ADD CONSTRAINT obra_estudio_fk FOREIGN KEY (estudio) REFERENCES public.estudio(codigo);


--
-- TOC entry 4759 (class 2606 OID 17462)
-- Name: obra_zona obra_zona_obra_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.obra_zona
    ADD CONSTRAINT obra_zona_obra_fk FOREIGN KEY (obra) REFERENCES public.obra(codigo);


--
-- TOC entry 4760 (class 2606 OID 17467)
-- Name: obra_zona obra_zona_zona_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.obra_zona
    ADD CONSTRAINT obra_zona_zona_fk FOREIGN KEY (zona) REFERENCES public.zona(nombre);


--
-- TOC entry 4761 (class 2606 OID 17472)
-- Name: pais pais_zona_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pais
    ADD CONSTRAINT pais_zona_fk FOREIGN KEY (zona) REFERENCES public.zona(nombre);


--
-- TOC entry 4762 (class 2606 OID 17477)
-- Name: pelicula pelicula_obra_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pelicula
    ADD CONSTRAINT pelicula_obra_fk FOREIGN KEY (codigo) REFERENCES public.obra(codigo);


--
-- TOC entry 4763 (class 2606 OID 17482)
-- Name: serie serie_obra_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serie
    ADD CONSTRAINT serie_obra_fk FOREIGN KEY (codigo) REFERENCES public.obra(codigo);


-- Completed on 2024-10-12 18:36:11

--
-- PostgreSQL database dump complete
--

