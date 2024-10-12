--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4
-- Dumped by pg_dump version 16.4

-- Started on 2024-10-12 19:16:32

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
-- TOC entry 853 (class 1247 OID 17489)
-- Name: categoria_evento; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.categoria_evento AS text
	CONSTRAINT categoria_evento_check CHECK (((VALUE = 'música'::text) OR (VALUE = 'deporte'::text) OR (VALUE = 'teatro'::text) OR (VALUE = 'especial'::text)));


ALTER DOMAIN public.categoria_evento OWNER TO postgres;

--
-- TOC entry 857 (class 1247 OID 17492)
-- Name: nombre_plataforma; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.nombre_plataforma AS text
	CONSTRAINT nombre_plataforma_check CHECK (((VALUE = 'Twitch'::text) OR (VALUE = 'YouTube'::text) OR (VALUE = 'Amazon'::text)));


ALTER DOMAIN public.nombre_plataforma OWNER TO postgres;

--
-- TOC entry 861 (class 1247 OID 17495)
-- Name: tipo_imprevisto; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.tipo_imprevisto AS text
	CONSTRAINT tipo_imprevisto_check CHECK (((VALUE = 'cancelación'::text) OR (VALUE = 'cambio de fecha'::text)));


ALTER DOMAIN public.tipo_imprevisto OWNER TO postgres;

--
-- TOC entry 865 (class 1247 OID 17498)
-- Name: tipo_publico; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.tipo_publico AS text
	CONSTRAINT tipo_publico_check CHECK (((VALUE = 'general'::text) OR (VALUE = 'estudiante'::text) OR (VALUE = 'adulto mayor'::text)));


ALTER DOMAIN public.tipo_publico OWNER TO postgres;

--
-- TOC entry 869 (class 1247 OID 17501)
-- Name: tipo_reclamo; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.tipo_reclamo AS text
	CONSTRAINT tipo_reclamo_check CHECK (((VALUE = 'reclamo'::text) OR (VALUE = 'consulta'::text) OR (VALUE = 'sugerencia'::text) OR (VALUE = 'felicitación'::text)));


ALTER DOMAIN public.tipo_reclamo OWNER TO postgres;

--
-- TOC entry 873 (class 1247 OID 17504)
-- Name: tipo_restriccion; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.tipo_restriccion AS text
	CONSTRAINT tipo_restriccion_check CHECK (((VALUE = 'sí'::text) OR (VALUE = 'no'::text)));


ALTER DOMAIN public.tipo_restriccion OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 17506)
-- Name: cliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cliente (
    rut integer NOT NULL,
    nombre text NOT NULL,
    edad integer NOT NULL,
    correo_electronico text NOT NULL
);


ALTER TABLE public.cliente OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 17511)
-- Name: entrada; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.entrada (
    numero_entrada integer NOT NULL,
    fecha date NOT NULL,
    hora time with time zone NOT NULL,
    valor integer NOT NULL,
    publico public.tipo_publico NOT NULL,
    descuento integer,
    fk_rut_cliente integer
);


ALTER TABLE public.entrada OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 17516)
-- Name: entrada_presencial; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.entrada_presencial (
    fk_numero_entrada integer NOT NULL,
    fk_id_evento_presencial integer NOT NULL,
    numero_asiento integer NOT NULL
);


ALTER TABLE public.entrada_presencial OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 17519)
-- Name: entrada_virtual; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.entrada_virtual (
    fk_numero_entrada integer NOT NULL,
    url_acceso text NOT NULL,
    fk_id_evento_virtual integer NOT NULL
);


ALTER TABLE public.entrada_virtual OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17524)
-- Name: evento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.evento (
    id integer NOT NULL,
    nombre text NOT NULL,
    descripcion text NOT NULL,
    fecha_inicio date NOT NULL,
    fecha_termino date NOT NULL,
    hora_inicio time with time zone NOT NULL,
    hora_termino time with time zone NOT NULL,
    duracion integer NOT NULL,
    categoria public.categoria_evento NOT NULL,
    restriccion public.tipo_restriccion NOT NULL
);


ALTER TABLE public.evento OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 17529)
-- Name: evento_presencial; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.evento_presencial (
    fk_id integer NOT NULL,
    fk_codigo_lugar integer NOT NULL
);


ALTER TABLE public.evento_presencial OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17532)
-- Name: evento_virtual; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.evento_virtual (
    fk_id integer NOT NULL,
    plataforma public.nombre_plataforma NOT NULL
);


ALTER TABLE public.evento_virtual OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 17537)
-- Name: imprevisto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.imprevisto (
    numero_imprevisto integer NOT NULL,
    descripcion text NOT NULL,
    categoria_imprevisto public.tipo_imprevisto NOT NULL
);


ALTER TABLE public.imprevisto OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 17542)
-- Name: lugar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lugar (
    codigo integer NOT NULL,
    nombre_lugar text NOT NULL,
    direccion text NOT NULL,
    coordenadas_geograficas_latitud integer NOT NULL,
    coordenadas_geograficas_longitud integer NOT NULL,
    ciudad text NOT NULL
);


ALTER TABLE public.lugar OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 17547)
-- Name: ocurre; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ocurre (
    fk_numero_imprevisto integer NOT NULL,
    fk_id integer NOT NULL
);


ALTER TABLE public.ocurre OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 17550)
-- Name: productora; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.productora (
    rut integer NOT NULL,
    nombre text NOT NULL
);


ALTER TABLE public.productora OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 17555)
-- Name: realiza; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realiza (
    fk_rut integer NOT NULL,
    fk_id integer NOT NULL
);


ALTER TABLE public.realiza OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 17558)
-- Name: reclamo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reclamo (
    codigo_reclamo integer NOT NULL,
    descripcion text NOT NULL,
    categoria_reclamo public.tipo_reclamo NOT NULL,
    fk_rut_cliente integer NOT NULL
);


ALTER TABLE public.reclamo OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 17563)
-- Name: tiene; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tiene (
    fk_codigo_reclamo integer NOT NULL,
    fk_id integer NOT NULL
);


ALTER TABLE public.tiene OWNER TO postgres;

--
-- TOC entry 4951 (class 0 OID 17506)
-- Dependencies: 215
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cliente (rut, nombre, edad, correo_electronico) FROM stdin;
76353675	Otro Cliente	25	otrocliente@gmail.com
27276363	Cliente MMM	30	clientemmm@gmail.com
\.


--
-- TOC entry 4952 (class 0 OID 17511)
-- Dependencies: 216
-- Data for Name: entrada; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.entrada (numero_entrada, fecha, hora, valor, publico, descuento, fk_rut_cliente) FROM stdin;
641446	2023-12-12	08:00:00-03	15000	general	\N	\N
493222	2023-12-12	08:00:00-03	1700	estudiante	\N	\N
435728	2024-09-12	13:00:00-03	15000	adulto mayor	\N	\N
\.


--
-- TOC entry 4953 (class 0 OID 17516)
-- Dependencies: 217
-- Data for Name: entrada_presencial; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.entrada_presencial (fk_numero_entrada, fk_id_evento_presencial, numero_asiento) FROM stdin;
493222	555969	1
641446	555969	2
\.


--
-- TOC entry 4954 (class 0 OID 17519)
-- Dependencies: 218
-- Data for Name: entrada_virtual; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.entrada_virtual (fk_numero_entrada, url_acceso, fk_id_evento_virtual) FROM stdin;
435728	http://www.proyectobd.cl/8XXjXO1zQy	939622
\.


--
-- TOC entry 4955 (class 0 OID 17524)
-- Dependencies: 219
-- Data for Name: evento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.evento (id, nombre, descripcion, fecha_inicio, fecha_termino, hora_inicio, hora_termino, duracion, categoria, restriccion) FROM stdin;
555969	evento 190739827	JK	2024-03-16	2024-03-19	09:00:00-03	19:00:00-03	245	deporte	no
939622	Evento MKL	Bla bla bla	2023-12-09	2024-01-12	11:00:00-03	22:00:00-03	23	deporte	no
\.


--
-- TOC entry 4956 (class 0 OID 17529)
-- Dependencies: 220
-- Data for Name: evento_presencial; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.evento_presencial (fk_id, fk_codigo_lugar) FROM stdin;
555969	767676
\.


--
-- TOC entry 4957 (class 0 OID 17532)
-- Dependencies: 221
-- Data for Name: evento_virtual; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.evento_virtual (fk_id, plataforma) FROM stdin;
939622	Twitch
\.


--
-- TOC entry 4958 (class 0 OID 17537)
-- Dependencies: 222
-- Data for Name: imprevisto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.imprevisto (numero_imprevisto, descripcion, categoria_imprevisto) FROM stdin;
672758	se cancelo de nuevo la cuestion... que rabia	cancelación
\.


--
-- TOC entry 4959 (class 0 OID 17542)
-- Dependencies: 223
-- Data for Name: lugar; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lugar (codigo, nombre_lugar, direccion, coordenadas_geograficas_latitud, coordenadas_geograficas_longitud, ciudad) FROM stdin;
839986	Estadio ABC1	Calle Nueva 123	123435	123435	Concepcion
767676	abcddjd	sdssd 23	8782782	87628762	Copiapo
\.


--
-- TOC entry 4960 (class 0 OID 17547)
-- Dependencies: 224
-- Data for Name: ocurre; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ocurre (fk_numero_imprevisto, fk_id) FROM stdin;
672758	555969
\.


--
-- TOC entry 4961 (class 0 OID 17550)
-- Dependencies: 225
-- Data for Name: productora; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.productora (rut, nombre) FROM stdin;
72767673	Productora Number Five
\.


--
-- TOC entry 4962 (class 0 OID 17555)
-- Dependencies: 226
-- Data for Name: realiza; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realiza (fk_rut, fk_id) FROM stdin;
\.


--
-- TOC entry 4963 (class 0 OID 17558)
-- Dependencies: 227
-- Data for Name: reclamo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reclamo (codigo_reclamo, descripcion, categoria_reclamo, fk_rut_cliente) FROM stdin;
914488	el concierto fue muy fome... devuelvanme la plata ahora	reclamo	76353675
\.


--
-- TOC entry 4964 (class 0 OID 17563)
-- Dependencies: 228
-- Data for Name: tiene; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tiene (fk_codigo_reclamo, fk_id) FROM stdin;
914488	555969
\.


--
-- TOC entry 4764 (class 2606 OID 17567)
-- Name: cliente Cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT "Cliente_pkey" PRIMARY KEY (rut);


--
-- TOC entry 4766 (class 2606 OID 17569)
-- Name: entrada Entrada_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entrada
    ADD CONSTRAINT "Entrada_pkey" PRIMARY KEY (numero_entrada);


--
-- TOC entry 4768 (class 2606 OID 17571)
-- Name: entrada_presencial Entrada_presencial_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entrada_presencial
    ADD CONSTRAINT "Entrada_presencial_pkey" PRIMARY KEY (fk_numero_entrada);


--
-- TOC entry 4770 (class 2606 OID 17573)
-- Name: entrada_virtual Entrada_virtual_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entrada_virtual
    ADD CONSTRAINT "Entrada_virtual_pkey" PRIMARY KEY (fk_numero_entrada);


--
-- TOC entry 4774 (class 2606 OID 17575)
-- Name: evento Evento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento
    ADD CONSTRAINT "Evento_pkey" PRIMARY KEY (id);


--
-- TOC entry 4776 (class 2606 OID 17577)
-- Name: evento_presencial Evento_presencial_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_presencial
    ADD CONSTRAINT "Evento_presencial_pkey" PRIMARY KEY (fk_id);


--
-- TOC entry 4778 (class 2606 OID 17579)
-- Name: evento_virtual Evento_virtual_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_virtual
    ADD CONSTRAINT "Evento_virtual_pkey" PRIMARY KEY (fk_id);


--
-- TOC entry 4780 (class 2606 OID 17581)
-- Name: imprevisto Imprevisto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.imprevisto
    ADD CONSTRAINT "Imprevisto_pkey" PRIMARY KEY (numero_imprevisto);


--
-- TOC entry 4782 (class 2606 OID 17583)
-- Name: lugar Lugar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lugar
    ADD CONSTRAINT "Lugar_pkey" PRIMARY KEY (codigo);


--
-- TOC entry 4786 (class 2606 OID 17585)
-- Name: productora Productora_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productora
    ADD CONSTRAINT "Productora_pkey" PRIMARY KEY (rut);


--
-- TOC entry 4790 (class 2606 OID 17587)
-- Name: reclamo Reclamo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reclamo
    ADD CONSTRAINT "Reclamo_pkey" PRIMARY KEY (codigo_reclamo);


--
-- TOC entry 4772 (class 2606 OID 17589)
-- Name: entrada_virtual URL_acceso_uq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entrada_virtual
    ADD CONSTRAINT "URL_acceso_uq" UNIQUE (url_acceso);


--
-- TOC entry 4784 (class 2606 OID 17591)
-- Name: ocurre ocurre_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ocurre
    ADD CONSTRAINT ocurre_pkey PRIMARY KEY (fk_numero_imprevisto, fk_id);


--
-- TOC entry 4788 (class 2606 OID 17593)
-- Name: realiza realiza_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realiza
    ADD CONSTRAINT realiza_pkey PRIMARY KEY (fk_rut, fk_id);


--
-- TOC entry 4792 (class 2606 OID 17595)
-- Name: tiene tiene_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tiene
    ADD CONSTRAINT tiene_pkey PRIMARY KEY (fk_codigo_reclamo, fk_id);


--
-- TOC entry 4798 (class 2606 OID 17596)
-- Name: evento_presencial EventoPresencal_lugar; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_presencial
    ADD CONSTRAINT "EventoPresencal_lugar" FOREIGN KEY (fk_codigo_lugar) REFERENCES public.lugar(codigo) NOT VALID;


--
-- TOC entry 4799 (class 2606 OID 17601)
-- Name: evento_presencial EventoPresencial_evento_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_presencial
    ADD CONSTRAINT "EventoPresencial_evento_fk" FOREIGN KEY (fk_id) REFERENCES public.evento(id) NOT VALID;


--
-- TOC entry 4800 (class 2606 OID 17606)
-- Name: evento_virtual EventoVirtual_evento_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento_virtual
    ADD CONSTRAINT "EventoVirtual_evento_fk" FOREIGN KEY (fk_id) REFERENCES public.evento(id) NOT VALID;


--
-- TOC entry 4794 (class 2606 OID 17611)
-- Name: entrada_presencial entradaPresencial_entrada; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entrada_presencial
    ADD CONSTRAINT "entradaPresencial_entrada" FOREIGN KEY (fk_numero_entrada) REFERENCES public.entrada(numero_entrada) NOT VALID;


--
-- TOC entry 4795 (class 2606 OID 17616)
-- Name: entrada_presencial entradaPresencial_eventoPresencial_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entrada_presencial
    ADD CONSTRAINT "entradaPresencial_eventoPresencial_fk" FOREIGN KEY (fk_id_evento_presencial) REFERENCES public.evento_presencial(fk_id) NOT VALID;


--
-- TOC entry 4796 (class 2606 OID 17621)
-- Name: entrada_virtual entradaVirtual_entrada_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entrada_virtual
    ADD CONSTRAINT "entradaVirtual_entrada_fk" FOREIGN KEY (fk_numero_entrada) REFERENCES public.entrada(numero_entrada) NOT VALID;


--
-- TOC entry 4797 (class 2606 OID 17626)
-- Name: entrada_virtual entradaVirtual_eventoVirtual_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entrada_virtual
    ADD CONSTRAINT "entradaVirtual_eventoVirtual_fk" FOREIGN KEY (fk_id_evento_virtual) REFERENCES public.evento_virtual(fk_id) NOT VALID;


--
-- TOC entry 4793 (class 2606 OID 17631)
-- Name: entrada entrada_cliente_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entrada
    ADD CONSTRAINT entrada_cliente_fk FOREIGN KEY (fk_rut_cliente) REFERENCES public.cliente(rut) NOT VALID;


--
-- TOC entry 4801 (class 2606 OID 17636)
-- Name: ocurre ocurre_evento_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ocurre
    ADD CONSTRAINT ocurre_evento_fk FOREIGN KEY (fk_id) REFERENCES public.evento(id) NOT VALID;


--
-- TOC entry 4802 (class 2606 OID 17641)
-- Name: ocurre ocurre_imprevisto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ocurre
    ADD CONSTRAINT ocurre_imprevisto_fk FOREIGN KEY (fk_numero_imprevisto) REFERENCES public.imprevisto(numero_imprevisto) NOT VALID;


--
-- TOC entry 4803 (class 2606 OID 17646)
-- Name: realiza realiza_evento_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realiza
    ADD CONSTRAINT realiza_evento_fk FOREIGN KEY (fk_id) REFERENCES public.evento(id) NOT VALID;


--
-- TOC entry 4804 (class 2606 OID 17651)
-- Name: realiza realiza_productora_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realiza
    ADD CONSTRAINT realiza_productora_fk FOREIGN KEY (fk_rut) REFERENCES public.productora(rut) NOT VALID;


--
-- TOC entry 4805 (class 2606 OID 17656)
-- Name: reclamo reclamo_cliente_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reclamo
    ADD CONSTRAINT reclamo_cliente_fk FOREIGN KEY (fk_rut_cliente) REFERENCES public.cliente(rut) NOT VALID;


--
-- TOC entry 4806 (class 2606 OID 17661)
-- Name: tiene tiene_evento_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tiene
    ADD CONSTRAINT tiene_evento_fk FOREIGN KEY (fk_id) REFERENCES public.evento(id) NOT VALID;


--
-- TOC entry 4807 (class 2606 OID 17666)
-- Name: tiene tiene_reclamo_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tiene
    ADD CONSTRAINT tiene_reclamo_fk FOREIGN KEY (fk_codigo_reclamo) REFERENCES public.reclamo(codigo_reclamo) NOT VALID;


-- Completed on 2024-10-12 19:16:32

--
-- PostgreSQL database dump complete
--

