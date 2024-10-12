--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4
-- Dumped by pg_dump version 16.4

-- Started on 2024-10-12 17:28:20

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
-- TOC entry 842 (class 1247 OID 16840)
-- Name: membresia; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.membresia AS text
	CONSTRAINT membresia_check CHECK ((VALUE = ANY (ARRAY['miembro'::text, 'miembro premium'::text, 'presidente'::text, 'libro humano'::text, 'tesorero'::text, 'paria'::text])));


ALTER DOMAIN public.membresia OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 16842)
-- Name: integrante; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.integrante (
    rut integer NOT NULL,
    nombre character varying(30) NOT NULL,
    apellido character varying(30),
    nacimiento date,
    cargo public.membresia
);


ALTER TABLE public.integrante OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16847)
-- Name: integrante_libro; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.integrante_libro (
    integrante integer NOT NULL,
    libro integer NOT NULL,
    fecha_inicio date NOT NULL,
    fecha_termino date
);


ALTER TABLE public.integrante_libro OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16850)
-- Name: libro; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.libro (
    codigo integer NOT NULL,
    titulo character varying(50) NOT NULL,
    autor character varying(50),
    anio smallint,
    editorial character varying(30)
);


ALTER TABLE public.libro OWNER TO postgres;

--
-- TOC entry 4850 (class 0 OID 16842)
-- Dependencies: 215
-- Data for Name: integrante; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.integrante (rut, nombre, apellido, nacimiento, cargo) FROM stdin;
17676109	Alfredo	Riquelme	1990-10-10	miembro
8932711	Daniela	Rojas	1985-11-21	miembro
16724561	Fanita	Peres	1666-06-06	paria
20787111	Ronaldo	Aedo	2001-05-09	miembro premium
19561003	Frank	Teodoro	1997-12-05	tesorero
15932921	Mark	Hoppus	1975-01-01	miembro
18511998	Ignacio	Del Pino	1996-01-01	presidente
\.


--
-- TOC entry 4851 (class 0 OID 16847)
-- Dependencies: 216
-- Data for Name: integrante_libro; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.integrante_libro (integrante, libro, fecha_inicio, fecha_termino) FROM stdin;
17676109	1	2019-01-01	\N
17676109	4	2020-06-12	2021-06-12
17676109	5	2009-01-01	2009-01-12
8932711	6	2015-09-10	2015-11-25
16724561	7	2010-03-19	2021-09-27
16724561	1	2021-10-01	\N
16724561	2	2021-10-01	\N
16724561	3	2021-10-02	\N
19561003	3	2018-05-19	2018-12-07
19561003	1	2009-04-06	\N
15932921	6	1999-09-10	2000-07-08
15932921	1	2021-12-10	\N
18511998	2	2021-12-10	\N
18511998	3	2021-11-01	\N
\.


--
-- TOC entry 4852 (class 0 OID 16850)
-- Dependencies: 217
-- Data for Name: libro; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.libro (codigo, titulo, autor, anio, editorial) FROM stdin;
1	El placer de la cocina	Romulo Ingeniero Caballo	1966	Pueblo
2	Numeros misteriosos	Abby Garcia	2001	Samillian
3	The Watcher	Nipp	2016	Pueblo
4	Crimen en la calle Brave	Armando Leal Jr	1998	Pueblo
5	Las aventuras del gran cineasta de Nueva York	Mark Rosenthal	1981	Tinta Azul
6	J the Mage	Mark Rosenthal	1976	Tinta Azul
7	El gran oceano	Javier Hidalgo, Romulo Ingeniero Caballo	2004	Pueblo
\.


--
-- TOC entry 4702 (class 2606 OID 16854)
-- Name: integrante_libro integrante_libro_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.integrante_libro
    ADD CONSTRAINT integrante_libro_pk PRIMARY KEY (integrante, libro);


--
-- TOC entry 4700 (class 2606 OID 16856)
-- Name: integrante integrante_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.integrante
    ADD CONSTRAINT integrante_pk PRIMARY KEY (rut);


--
-- TOC entry 4704 (class 2606 OID 16858)
-- Name: libro libro_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.libro
    ADD CONSTRAINT libro_pkey PRIMARY KEY (codigo);


--
-- TOC entry 4705 (class 2606 OID 16859)
-- Name: integrante_libro integrante_libro_integrante_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.integrante_libro
    ADD CONSTRAINT integrante_libro_integrante_fk FOREIGN KEY (integrante) REFERENCES public.integrante(rut);


--
-- TOC entry 4706 (class 2606 OID 16864)
-- Name: integrante_libro integrante_libro_libro_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.integrante_libro
    ADD CONSTRAINT integrante_libro_libro_fk FOREIGN KEY (libro) REFERENCES public.libro(codigo);


-- Completed on 2024-10-12 17:28:20

--
-- PostgreSQL database dump complete
--

