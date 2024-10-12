--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4
-- Dumped by pg_dump version 16.4

-- Started on 2024-10-12 18:28:31

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 17304)
-- Name: ciudad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ciudad (
    nombre character varying NOT NULL,
    pais smallint NOT NULL,
    poblacion bigint,
    superficie bigint
);


ALTER TABLE public.ciudad OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 17309)
-- Name: continente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.continente (
    codigo smallint NOT NULL,
    nombre character varying(40),
    poblacion bigint,
    superficie integer
);


ALTER TABLE public.continente OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 17312)
-- Name: organizacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.organizacion (
    codigo integer NOT NULL,
    sigla character varying(10),
    nombre character varying(40) NOT NULL,
    fundacion smallint
);


ALTER TABLE public.organizacion OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 17315)
-- Name: pais; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pais (
    codigo smallint NOT NULL,
    nombre character varying(40),
    continente smallint,
    capital character varying(40),
    idioma character varying(40),
    poblacion bigint,
    superficie integer
);


ALTER TABLE public.pais OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17318)
-- Name: pais_organizacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pais_organizacion (
    pais smallint NOT NULL,
    organizacion integer NOT NULL
);


ALTER TABLE public.pais_organizacion OWNER TO postgres;

--
-- TOC entry 4861 (class 0 OID 17304)
-- Dependencies: 215
-- Data for Name: ciudad; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ciudad (nombre, pais, poblacion, superficie) FROM stdin;
Concepcion	152	263574	221
Talca	152	220357	232
El Cairo	818	8259461	553
Luxor	818	1328429	416
Alejandria	818	4800000	2679
Ulan Bator	496	1466125	4704
Wellington	554	212100	290
Tauranga	554	116400	168
Bhisho	710	11192	8
Jambi	360	437012	205
Fukuoka	392	1588924	343
Ciudad de Mexico	484	9209944	1495
Sakai	392	828741	149
Copenhague	208	596557	77
\.


--
-- TOC entry 4862 (class 0 OID 17309)
-- Dependencies: 216
-- Data for Name: continente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.continente (codigo, nombre, poblacion, superficie) FROM stdin;
2	Africa	922011000	30370000
19	America	910000000	42330000
150	Europa	731000000	10180000
142	Asia	3879000000	43810000
9	Oceania	27000000	8720710
10	Antartida	1000	13720000
\.


--
-- TOC entry 4863 (class 0 OID 17312)
-- Dependencies: 217
-- Data for Name: organizacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.organizacion (codigo, sigla, nombre, fundacion) FROM stdin;
1	UA	Union Africana	1956
2	\N	Liga Árabe	1945
3	ODEBO	Organización Deportiva Bolivariana	1938
4	AP	Alianza del Pacífico	2012
5	BFA	Foro de Boao para Asia	2001
6	UE	Unión Europea	1993
7	\N	Benelux	1948
\.


--
-- TOC entry 4864 (class 0 OID 17315)
-- Dependencies: 218
-- Data for Name: pais; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pais (codigo, nombre, continente, capital, idioma, poblacion, superficie) FROM stdin;
36	Australia	9	\N	ingles	25637110	7741220
152	Chile	19	\N	español	17574000	756102
392	Japon	142	\N	japones	127094745	377975
250	Francia	150	\N	frances	67407241	675417
360	Indonesia	142	\N	indonesio	259903244	1904569
231	Etipia	2	\N	amharico	98665000	1104300
710	Sudafrica	2	\N	ingles	60110000	1219090
208	Dinamarca	150	Copenhague	Danes	5837213	43094
484	Mexico	19	Ciudad de Mexico	español	128649565	1964375
496	Mongolia	142	Ulan Bator	mongol	3112827	1564116
554	Nueva Zelandia	9	Wellington	ingles	4699755	268838
818	Egipto	2	El Cairo	arabe	101400000	1001450
\.


--
-- TOC entry 4865 (class 0 OID 17318)
-- Dependencies: 219
-- Data for Name: pais_organizacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pais_organizacion (pais, organizacion) FROM stdin;
818	1
231	1
152	3
152	4
484	4
36	5
392	5
496	5
250	6
\.


--
-- TOC entry 4704 (class 2606 OID 17322)
-- Name: ciudad ciudad_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ciudad
    ADD CONSTRAINT ciudad_pk PRIMARY KEY (nombre);


--
-- TOC entry 4706 (class 2606 OID 17324)
-- Name: continente continente_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.continente
    ADD CONSTRAINT continente_pk PRIMARY KEY (codigo);


--
-- TOC entry 4708 (class 2606 OID 17326)
-- Name: organizacion organizacion_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizacion
    ADD CONSTRAINT organizacion_pk PRIMARY KEY (codigo);


--
-- TOC entry 4712 (class 2606 OID 17328)
-- Name: pais_organizacion pais_organizacion_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pais_organizacion
    ADD CONSTRAINT pais_organizacion_pk PRIMARY KEY (pais, organizacion);


--
-- TOC entry 4710 (class 2606 OID 17330)
-- Name: pais pais_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pais
    ADD CONSTRAINT pais_pkey PRIMARY KEY (codigo);


--
-- TOC entry 4713 (class 2606 OID 17331)
-- Name: ciudad ciudad_pais_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ciudad
    ADD CONSTRAINT ciudad_pais_fk FOREIGN KEY (pais) REFERENCES public.pais(codigo);


--
-- TOC entry 4714 (class 2606 OID 17336)
-- Name: pais pais_ciudad_fl; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pais
    ADD CONSTRAINT pais_ciudad_fl FOREIGN KEY (capital) REFERENCES public.ciudad(nombre) NOT VALID;


--
-- TOC entry 4715 (class 2606 OID 17341)
-- Name: pais pais_continente_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pais
    ADD CONSTRAINT pais_continente_fk FOREIGN KEY (continente) REFERENCES public.continente(codigo) NOT VALID;


--
-- TOC entry 4716 (class 2606 OID 17346)
-- Name: pais_organizacion pais_organizacion_organizacion_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pais_organizacion
    ADD CONSTRAINT pais_organizacion_organizacion_fk FOREIGN KEY (organizacion) REFERENCES public.organizacion(codigo) NOT VALID;


--
-- TOC entry 4717 (class 2606 OID 17351)
-- Name: pais_organizacion pais_organizacion_pais_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pais_organizacion
    ADD CONSTRAINT pais_organizacion_pais_fk FOREIGN KEY (pais) REFERENCES public.pais(codigo) NOT VALID;


-- Completed on 2024-10-12 18:28:31

--
-- PostgreSQL database dump complete
--

