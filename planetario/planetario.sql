--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4
-- Dumped by pg_dump version 16.4

-- Started on 2024-10-12 20:20:46

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

--
-- TOC entry 840 (class 1247 OID 17673)
-- Name: tipo_objeto; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.tipo_objeto AS character varying(20)
	CONSTRAINT tipo_objeto_check CHECK (((VALUE)::text = ANY (ARRAY[('estrella'::character varying)::text, ('planeta enano'::character varying)::text, ('planeta rocoso'::character varying)::text, ('gigante gaseoso'::character varying)::text, ('otros'::character varying)::text])));


ALTER DOMAIN public.tipo_objeto OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 17675)
-- Name: objetos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.objetos (
    id integer NOT NULL,
    nombre character varying(20),
    tipo public.tipo_objeto,
    masa double precision,
    diametro double precision,
    sistema_planetario character varying(20)
);


ALTER TABLE public.objetos OWNER TO postgres;

--
-- TOC entry 4836 (class 0 OID 17675)
-- Dependencies: 215
-- Data for Name: objetos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.objetos (id, nombre, tipo, masa, diametro, sistema_planetario) FROM stdin;
1	Urano	gigante gaseoso	14.54	51118	sistema solar
2	Tierra	planeta rocoso	1	12756.24	sistema solar
3	Thessia	planeta rocoso	0.947	11880	Parnitha
4	Eden Prime	planeta rocoso	1.253	14052	Utopia
5	Jupiter	gigante gaseoso	1317	142984	sistema solar
6	Ceres	planeta enano	0.00016	952.4	sistema solar
7	Luna	otros	0.0123	3474	sistema solar
8	Sol	estrella	332950	1392000	sistema solar
10	Eris	planeta enano	0.0028	2700	sistema solar
11	Makemake	planeta enano	0.00067	1600	sistema solar
\.


--
-- TOC entry 4692 (class 2606 OID 17681)
-- Name: objetos objetos_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.objetos
    ADD CONSTRAINT objetos_pk PRIMARY KEY (id);


--
-- TOC entry 4842 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2024-10-12 20:20:46

--
-- PostgreSQL database dump complete
--

