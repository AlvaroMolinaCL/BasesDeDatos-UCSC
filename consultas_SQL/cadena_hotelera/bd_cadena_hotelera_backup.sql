--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4
-- Dumped by pg_dump version 16.4

-- Started on 2024-10-12 17:36:26

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
-- TOC entry 215 (class 1259 OID 16870)
-- Name: cliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cliente (
    rut integer NOT NULL,
    nombre character varying(30),
    apellido character varying(30),
    telefono integer NOT NULL,
    membresia boolean NOT NULL
);


ALTER TABLE public.cliente OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16873)
-- Name: edificio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.edificio (
    nombre character varying(50) NOT NULL,
    direccion character varying(50) NOT NULL,
    localidad character varying(30),
    gerente integer
);


ALTER TABLE public.edificio OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16876)
-- Name: edificio_instalacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.edificio_instalacion (
    edificio character varying(30) NOT NULL,
    instalacion character varying(30) NOT NULL
);


ALTER TABLE public.edificio_instalacion OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16879)
-- Name: habitacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.habitacion (
    codigo character varying(4) NOT NULL,
    edificio character varying(50) NOT NULL,
    tipo character varying(50),
    planta smallint,
    precio integer,
    camas smallint
);


ALTER TABLE public.habitacion OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16882)
-- Name: instalacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.instalacion (
    nombre character varying(30) NOT NULL,
    descripcion character varying(50)
);


ALTER TABLE public.instalacion OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16885)
-- Name: reserva; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reserva (
    codigo integer NOT NULL,
    cliente integer NOT NULL,
    habitacion character varying(4) NOT NULL,
    desde date,
    hasta date
);


ALTER TABLE public.reserva OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16888)
-- Name: trabajador; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trabajador (
    rut integer NOT NULL,
    nombre character varying(30),
    apellido character varying(30),
    edificio character varying(50) NOT NULL
);


ALTER TABLE public.trabajador OWNER TO postgres;

--
-- TOC entry 4875 (class 0 OID 16870)
-- Dependencies: 215
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cliente (rut, nombre, apellido, telefono, membresia) FROM stdin;
18992766	Rodrigo	Fica	541823	t
12000700	Ernestina	Romulianelica	560012	f
22001823	Roberto	Romero	800010	f
7110931	Juan	Duende	602311	f
19454100	Daniela	Flores	200000	t
9129800	Romina	Chimosa	509012	t
\.


--
-- TOC entry 4876 (class 0 OID 16873)
-- Dependencies: 216
-- Data for Name: edificio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.edificio (nombre, direccion, localidad, gerente) FROM stdin;
Risas del Mar	Playa verde 89702	Ciudad Brookesmith	12883400
Bosque Norte	Parque Lom, Km 120	Costamarfil	16123122
Bosque Sur	Donovo 701	Costamarfil	20444880
Estrella	Avenida San Martin 889	Los Angeles	15998123
\.


--
-- TOC entry 4877 (class 0 OID 16876)
-- Dependencies: 217
-- Data for Name: edificio_instalacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.edificio_instalacion (edificio, instalacion) FROM stdin;
Estrella	cancha de tenis
Bosque Norte	cancha de tenis
Bosque Sur	cancha de tenis
Estrella	piscina
Bosque Sur	piscina
Estrella	piscina olimpica
Estrella	salon de baile
Estrella	sala de eventos
Risas del Mar	sala de eventos
Estrella	sala de juegos
\.


--
-- TOC entry 4878 (class 0 OID 16879)
-- Dependencies: 218
-- Data for Name: habitacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.habitacion (codigo, edificio, tipo, planta, precio, camas) FROM stdin;
A1	Risas del Mar	\N	1	2000	1
A2	Risas del Mar	\N	1	2000	1
A3	Risas del Mar	\N	1	2100	2
A4	Risas del Mar	\N	2	2100	2
A5	Risas del Mar	\N	2	2500	3
A6	Risas del Mar	\N	3	4000	2
B1	Bosque Norte	\N	1	5000	3
B2	Bosque Norte	\N	1	5000	3
B3	Bosque Norte	\N	1	15000	6
B4	Bosque Norte	\N	1	15400	6
C1	Bosque Sur	\N	1	1500	1
C2	Bosque Sur	\N	1	1500	1
C3	Bosque Sur	\N	1	1400	1
C4	Bosque Sur	\N	2	1400	1
C5	Bosque Sur	\N	2	1500	1
C6	Bosque Sur	\N	3	1500	1
C7	Bosque Sur	\N	3	1800	1
C8	Bosque Sur	\N	4	2630	1
D1	Estrella	\N	1	23000	1
D2	Estrella	\N	2	25000	1
D3	Estrella	\N	3	23800	2
D4	Estrella	\N	4	28900	1
\.


--
-- TOC entry 4879 (class 0 OID 16882)
-- Dependencies: 219
-- Data for Name: instalacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.instalacion (nombre, descripcion) FROM stdin;
cancha de tenis	\N
piscina	\N
piscina olimpica	\N
salon de baile	\N
sala de juegos	\N
sala de eventos	\N
\.


--
-- TOC entry 4880 (class 0 OID 16885)
-- Dependencies: 220
-- Data for Name: reserva; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reserva (codigo, cliente, habitacion, desde, hasta) FROM stdin;
1	18992766	D1	2012-10-10	2012-10-20
2	18992766	D1	2012-11-01	2013-01-01
3	18992766	D2	2017-07-10	2017-07-12
10	18992766	D1	2020-12-07	2020-12-21
11	18992766	D3	2021-12-12	2022-01-03
4	19454100	D1	2021-12-25	2022-01-02
5	22001823	D2	2021-12-27	2022-01-05
6	12000700	A1	1999-09-07	1999-09-08
7	12000700	A3	2018-09-05	2018-09-06
8	12000700	A1	2021-12-19	2021-12-24
9	22001823	A1	2021-12-27	2022-01-05
12	7110931	C1	2009-10-10	2009-10-15
13	7110931	C7	2017-06-18	2017-07-18
14	9129800	B1	2017-02-02	2017-02-04
15	9129800	C4	2019-05-14	2019-05-18
16	9129800	C4	2022-01-05	2022-01-17
\.


--
-- TOC entry 4881 (class 0 OID 16888)
-- Dependencies: 221
-- Data for Name: trabajador; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.trabajador (rut, nombre, apellido, edificio) FROM stdin;
15998123	Roberto	Rojas	Estrella
16123122	Yandira	San Martin	Bosque Norte
20444880	Ignacion	Marin	Bosque Sur
12883400	Yuri	Carmona	Risas del Mar
11245667	Marina	Salado	Bosque Sur
17990451	Ignacio	Gonzales	Estrella
20675118	Dimarco	Rosenthal	Estrella
\.


--
-- TOC entry 4712 (class 2606 OID 16892)
-- Name: cliente cliente_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pk PRIMARY KEY (rut);


--
-- TOC entry 4714 (class 2606 OID 16894)
-- Name: edificio edificio_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edificio
    ADD CONSTRAINT edificio_pk PRIMARY KEY (nombre);


--
-- TOC entry 4716 (class 2606 OID 16896)
-- Name: edificio_instalacion edifico_instalacion_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edificio_instalacion
    ADD CONSTRAINT edifico_instalacion_pk PRIMARY KEY (edificio, instalacion);


--
-- TOC entry 4718 (class 2606 OID 16898)
-- Name: habitacion habitacion_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.habitacion
    ADD CONSTRAINT habitacion_pk PRIMARY KEY (codigo);


--
-- TOC entry 4720 (class 2606 OID 16900)
-- Name: instalacion instalacion_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instalacion
    ADD CONSTRAINT instalacion_pk PRIMARY KEY (nombre);


--
-- TOC entry 4722 (class 2606 OID 16902)
-- Name: reserva reserva_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reserva
    ADD CONSTRAINT reserva_pk PRIMARY KEY (codigo);


--
-- TOC entry 4724 (class 2606 OID 16904)
-- Name: trabajador trabajador_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trabajador
    ADD CONSTRAINT trabajador_pk PRIMARY KEY (rut);


--
-- TOC entry 4726 (class 2606 OID 16905)
-- Name: edificio_instalacion edificio_instalacion_edificio_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edificio_instalacion
    ADD CONSTRAINT edificio_instalacion_edificio_fk FOREIGN KEY (edificio) REFERENCES public.edificio(nombre);


--
-- TOC entry 4727 (class 2606 OID 16910)
-- Name: edificio_instalacion edificio_instalacion_instalacion_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edificio_instalacion
    ADD CONSTRAINT edificio_instalacion_instalacion_fk FOREIGN KEY (instalacion) REFERENCES public.instalacion(nombre);


--
-- TOC entry 4725 (class 2606 OID 16915)
-- Name: edificio edificio_trabajador_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edificio
    ADD CONSTRAINT edificio_trabajador_fk FOREIGN KEY (gerente) REFERENCES public.trabajador(rut) NOT VALID;


--
-- TOC entry 4728 (class 2606 OID 16920)
-- Name: habitacion habitacion_edificio_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.habitacion
    ADD CONSTRAINT habitacion_edificio_fk FOREIGN KEY (edificio) REFERENCES public.edificio(nombre);


--
-- TOC entry 4729 (class 2606 OID 16925)
-- Name: reserva reserva_cliente_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reserva
    ADD CONSTRAINT reserva_cliente_fk FOREIGN KEY (cliente) REFERENCES public.cliente(rut);


--
-- TOC entry 4730 (class 2606 OID 16930)
-- Name: reserva reserva_habitacion_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reserva
    ADD CONSTRAINT reserva_habitacion_fk FOREIGN KEY (habitacion) REFERENCES public.habitacion(codigo);


--
-- TOC entry 4731 (class 2606 OID 16935)
-- Name: trabajador trabajador_edificio_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trabajador
    ADD CONSTRAINT trabajador_edificio_fk FOREIGN KEY (edificio) REFERENCES public.edificio(nombre) NOT VALID;


-- Completed on 2024-10-12 17:36:27

--
-- PostgreSQL database dump complete
--

