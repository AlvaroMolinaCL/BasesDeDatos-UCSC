--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4
-- Dumped by pg_dump version 16.4

-- Started on 2024-10-12 18:02:50

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
-- TOC entry 852 (class 1247 OID 17002)
-- Name: clasificacion; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.clasificacion AS text
	CONSTRAINT clasificacion_check CHECK ((VALUE = ANY (ARRAY['soundtrack'::text, 'estudio'::text, 'live'::text, 'recopilatorio'::text])));


ALTER DOMAIN public.clasificacion OWNER TO postgres;

--
-- TOC entry 856 (class 1247 OID 17005)
-- Name: formato; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.formato AS text
	CONSTRAINT formato_check CHECK ((VALUE = ANY (ARRAY['CD'::text, 'DVD'::text, 'vinilo'::text, 'casete'::text, 'digital'::text, 'BD'::text])));


ALTER DOMAIN public.formato OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 17007)
-- Name: album; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.album (
    codigo integer NOT NULL,
    nombre text NOT NULL,
    tipo public.clasificacion,
    pistas smallint,
    fecha_salida date
);


ALTER TABLE public.album OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 17012)
-- Name: artista; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.artista (
    codigo character varying(15) NOT NULL,
    pais character varying(20),
    nombre character varying(30) NOT NULL,
    nacimiento date
);


ALTER TABLE public.artista OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 17015)
-- Name: artista_grupo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.artista_grupo (
    codigo_artista character varying(15) NOT NULL,
    codigo_grupo integer NOT NULL,
    ingreso date NOT NULL,
    salida date
);


ALTER TABLE public.artista_grupo OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 17018)
-- Name: canasta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.canasta (
    codigo_compra integer NOT NULL,
    codigo_producto integer NOT NULL,
    cantidad smallint NOT NULL
);


ALTER TABLE public.canasta OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17021)
-- Name: cancion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cancion (
    codigo integer NOT NULL,
    nombre character varying(30) NOT NULL,
    fecha date NOT NULL,
    duracion interval NOT NULL
);


ALTER TABLE public.cancion OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 17024)
-- Name: cliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cliente (
    rut integer NOT NULL,
    nombre character varying(20) NOT NULL,
    direccion character varying(20) NOT NULL,
    subscripcion boolean NOT NULL,
    ciudad character varying(20) NOT NULL
);


ALTER TABLE public.cliente OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17027)
-- Name: compone; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.compone (
    codigo_cancion integer NOT NULL,
    codigo_artista character varying(15) NOT NULL
);


ALTER TABLE public.compone OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 17030)
-- Name: compra; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.compra (
    codigo integer NOT NULL,
    cliente integer,
    fecha timestamp without time zone NOT NULL,
    sucursal character varying(20) NOT NULL,
    monto_total integer
);


ALTER TABLE public.compra OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 17033)
-- Name: conforma; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conforma (
    codigo_cancion integer NOT NULL,
    codigo_album integer NOT NULL,
    pista smallint
);


ALTER TABLE public.conforma OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 17036)
-- Name: crea; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.crea (
    codigo_cancion integer NOT NULL,
    codigo_grupo integer NOT NULL
);


ALTER TABLE public.crea OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 17039)
-- Name: grupo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.grupo (
    codigo integer NOT NULL,
    fecha_fundacion date,
    procedencia character varying(20),
    nombre character varying(30) NOT NULL
);


ALTER TABLE public.grupo OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 17042)
-- Name: inventario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventario (
    producto integer NOT NULL,
    album integer NOT NULL,
    sucursal character varying(20) NOT NULL,
    tipo public.formato NOT NULL,
    precio integer NOT NULL,
    stock smallint
);


ALTER TABLE public.inventario OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 17047)
-- Name: sucursal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sucursal (
    nombre character varying(20) NOT NULL,
    direccion character varying(20) NOT NULL,
    ciudad character varying(20) NOT NULL,
    gerente character varying(20) NOT NULL
);


ALTER TABLE public.sucursal OWNER TO postgres;

--
-- TOC entry 4927 (class 0 OID 17007)
-- Dependencies: 215
-- Data for Name: album; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.album (codigo, nombre, tipo, pistas, fecha_salida) FROM stdin;
120031	Silent Hill 3 Original Soundtrack	soundtrack	26	2003-07-07
319731	Waterloo	estudio	11	1973-09-24
319801	Super Trouper	estudio	10	1980-11-03
319941	Parklife	estudio	16	1994-04-25
319861	Pensamientos	estudio	10	1986-11-11
419881	Debo hacerlo	recopilatorio	12	1988-01-01
319831	Fastway	estudio	11	1983-04-01
319971	Dude Ranch	estudio	15	1997-06-17
220001	The Mark, Tom, and Travis Show	live	20	2000-11-07
319841	The Smiths	estudio	11	1984-02-20
319942	Vauxhall and I	estudio	11	1994-03-14
\.


--
-- TOC entry 4928 (class 0 OID 17012)
-- Dependencies: 216
-- Data for Name: artista; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.artista (codigo, pais, nombre, nacimiento) FROM stdin;
1972USA1	Estados Unidos	Mark Hoppus	1972-03-15
1975USA1	Estados Unidos	Travis Barker	1975-11-14
1976USA1	Estados Unidos	Matthew Skiba	1976-02-24
1978USA1	Estados Unidos	Scott Raynor	1978-05-23
1975USA2	Estados Unidos	Thomas DeLonge	1975-12-13
1968JP1	Japon	Akira Yamaoka	1968-02-06
1966USA1	Estados Unidos	Mary Elizabeth McGlynn	1966-10-16
1956USA1	Estados Unidos	Joe Romersa	1956-07-27
1950SU1	Suecia	Agnetha Fältskog	1950-04-05
1945SU1	Suecia	Björn Ulvaeus	1945-04-29
1946SU1	Suecia	Benny Andersson	1946-12-16
1945SU2	Suecia	Anni-Frid Lyngstad	1945-11-15
1985COL1	Colombia	J Balvin	1985-05-07
1974JP1	Japon	Taku Takahashi	1974-03-29
1975JP1	Japon	VERBAL	1975-08-21
1974JP2	Japon	Elizabeth Sakura Narita	1974-10-26
1968EN1	Inglaterra	Damon Albarn	1968-03-23
1969EN1	Inglaterra	Graham Coxon	1969-03-12
1968EN2	Inglaterra	Alex James	1968-11-21
1964EN1	Inglaterra	Dave Rowntree	1964-05-08
1950MX1	Mexico	Juan Gabriel	1950-01-07
1950EN1	Inglaterra	Edward  Clarke	1950-10-05
1967EN1	Inglaterra	Toby Jepson	1967-10-09
1961IR1	Irlanda	Dave King 	1961-12-11
1959EN1	Inglaterra	Steven Patrick Morrissey	1959-05-22
1963EN1	Inglaterra	Mike Joyce	1963-06-01
1963EN2	Inglaterra	John Martin Maher	1963-10-31
\.


--
-- TOC entry 4929 (class 0 OID 17015)
-- Dependencies: 217
-- Data for Name: artista_grupo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.artista_grupo (codigo_artista, codigo_grupo, ingreso, salida) FROM stdin;
1972USA1	19921	1992-08-02	\N
1975USA1	19921	1992-08-02	\N
1975USA2	19921	1992-08-02	2015-01-01
1978USA1	19921	1992-08-02	1998-01-01
1976USA1	19921	2015-09-01	\N
1950SU1	19721	1992-08-02	1982-12-11
1945SU1	19721	1992-08-02	1982-12-11
1946SU1	19721	1992-08-02	1982-12-11
1945SU2	19721	1992-08-02	1982-12-11
1968EN1	19881	1988-12-01	\N
1969EN1	19881	1988-12-01	\N
1968EN2	19881	1988-12-01	\N
1964EN1	19881	1988-12-01	\N
1950EN1	19831	1983-01-01	2018-01-10
1967EN1	19831	2007-05-01	2010-01-01
1961IR1	19831	1983-01-01	1986-01-01
1959EN1	19821	1982-01-01	1997-01-01
1963EN1	19821	1982-01-01	1997-01-01
1963EN2	19821	1982-01-01	1997-01-01
\.


--
-- TOC entry 4930 (class 0 OID 17018)
-- Dependencies: 218
-- Data for Name: canasta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.canasta (codigo_compra, codigo_producto, cantidad) FROM stdin;
250520211	116	1
250520211	117	1
270920131	111	1
920119991	101	2
920119991	102	1
920119991	105	3
920119991	110	3
101220201	121	2
190320211	114	2
190320211	100	1
190320211	127	1
230520191	104	6
261219991	124	1
301220201	122	1
100220191	100	1
100220191	114	1
160719991	125	1
911020201	107	2
180920201	121	1
911020201	115	10
0	102	5
0	103	1
0	110	2
\.


--
-- TOC entry 4931 (class 0 OID 17021)
-- Dependencies: 219
-- Data for Name: cancion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cancion (codigo, nombre, fecha, duracion) FROM stdin;
20031	Lost Carol	2003-07-07	00:00:37
20032	You're Not Here	2003-07-07	00:03:45
20033	End of Small Sanctuary	2003-07-07	00:01:42
20034	Prayer	2003-07-07	00:01:40
20035	Hometown	2003-07-07	00:06:04
20036	I Want Love (Studio Mix)	2003-07-07	00:04:40
19731	Waterloo	1973-09-24	00:02:44
19732	King Kong Song	1973-09-24	00:03:11
19733	Honey, Honey	1973-09-24	00:02:55
19801	Super-Trouper	1980-11-03	00:04:11
19802	Me And I	1980-11-03	00:04:18
19803	Happy New Year	1980-11-03	00:04:23
19804	Our Last Summer	1980-11-03	00:04:19
19941	Girls & Boys	1994-04-25	00:04:50
19942	Tracy Jacks	1994-04-25	00:04:20
19943	End of a Century	1994-04-25	00:02:46
19861	Doquiera estas tu	1986-11-11	00:03:12
19862	Amor es amor	1986-11-11	00:03:24
19881	Debo hacerlo	1988-01-01	00:09:42
19882	Que lastima	1988-01-01	00:03:59
20191	HUMAN LOST	2019-10-10	00:03:17
19831	Easy Livin	1983-04-01	00:02:47
19832	We Become One	1983-04-01	00:03:59
19833	Give It All You Got	1983-04-01	00:03:01
19971	Pathetic	1997-06-17	00:02:27
19972	Dammit	1997-06-17	00:01:41
19973	Untitled	1997-06-17	00:02:46
19944	Degenerate	1997-06-17	00:02:28
20001	Adam's Song	2000-09-05	00:04:01
19841	Reel Around the Fountain	1984-02-20	00:05:58
19842	You've Got Everything Now	1984-02-20	00:03:59
19843	This Charming Man	1984-02-20	00:02:41
19945	Now My Heart Is Full	1994-03-14	00:04:57
19946	Billy Budd	1994-03-14	00:02:08
\.


--
-- TOC entry 4932 (class 0 OID 17024)
-- Dependencies: 220
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cliente (rut, nombre, direccion, subscripcion, ciudad) FROM stdin;
15678654	Juan Fica	El gran Cerro	t	Yumbel
12000002	Fanita Perez	Hell 34	t	Ciudad de Mexico
23007512	Alberto Figueroa	San Martin 456	f	Chillan
20912322	Amelia atkinson	Big Wolf 54	f	Londres
11744010	Mark Hoppus	Zapata 7890	t	Talca
0	Luna	Cerro Amarillo	f	Hualpen
\.


--
-- TOC entry 4933 (class 0 OID 17027)
-- Dependencies: 221
-- Data for Name: compone; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.compone (codigo_cancion, codigo_artista) FROM stdin;
20031	1966USA1
20031	1968JP1
20032	1968JP1
20033	1968JP1
20034	1968JP1
20035	1968JP1
20036	1968JP1
20032	1966USA1
20036	1966USA1
20035	1956USA1
19861	1950MX1
19862	1950MX1
19881	1950MX1
19882	1950MX1
20191	1985COL1
19945	1959EN1
19946	1959EN1
\.


--
-- TOC entry 4934 (class 0 OID 17030)
-- Dependencies: 222
-- Data for Name: compra; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.compra (codigo, cliente, fecha, sucursal, monto_total) FROM stdin;
250520211	\N	2021-05-25 13:56:00	VIRTUAL	\N
270920131	\N	2013-09-27 20:00:00	RECORTE	\N
920119991	11744010	1999-01-02 15:43:00	RAMONA	\N
101220201	15678654	2020-12-10 03:00:00	VIRTUAL	\N
190320211	20912322	2021-03-19 13:07:00	DIMETRODON MUSICAL	\N
230520191	\N	2019-05-23 11:00:00	RED FLAG	\N
261219991	\N	1997-12-26 16:00:00	RAMONA	\N
301220201	\N	2020-12-30 13:09:00	VIRTUAL	\N
100220191	\N	2019-02-10 16:02:00	DIMETRODON MUSICAL	\N
160719991	\N	1999-07-15 17:16:00	RED FLAG	\N
911020201	15678654	2020-10-01 19:57:00	MUSIC FOREVER	\N
180920201	15678654	2020-09-18 19:00:00	VIRTUAL	\N
0	0	2021-06-03 00:00:00	RAMONA	82300
\.


--
-- TOC entry 4935 (class 0 OID 17033)
-- Dependencies: 223
-- Data for Name: conforma; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conforma (codigo_cancion, codigo_album, pista) FROM stdin;
20031	120031	1
20032	120031	2
20033	120031	4
20034	120031	15
20035	120031	24
20036	120031	25
19731	319731	1
19732	319731	3
19733	319731	7
19801	319801	1
19802	319801	5
19803	319801	6
19804	319801	7
19941	319941	1
19942	319941	2
19943	319941	3
19862	319861	3
19861	319861	1
19831	319831	1
19832	319831	6
19833	319831	7
19971	319971	1
19972	319971	3
19973	319971	8
19944	319971	13
20001	220001	12
19973	220001	9
19972	220001	19
19971	220001	11
19945	319942	1
19946	319942	3
19841	319841	1
19842	319841	2
19843	319841	11
\.


--
-- TOC entry 4936 (class 0 OID 17036)
-- Dependencies: 224
-- Data for Name: crea; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.crea (codigo_cancion, codigo_grupo) FROM stdin;
19731	19721
19732	19721
19733	19721
19801	19721
19802	19721
19803	19721
19804	19721
19941	19881
19942	19881
19943	19881
20191	19971
19831	19831
19832	19831
19833	19831
19971	19921
19972	19921
19973	19921
19944	19921
20001	19921
19841	19821
19842	19821
19843	19821
\.


--
-- TOC entry 4937 (class 0 OID 17039)
-- Dependencies: 225
-- Data for Name: grupo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.grupo (codigo, fecha_fundacion, procedencia, nombre) FROM stdin;
19921	1992-08-02	Estados Unidos	Blink 182
19721	1972-04-30	Suecia	ABBA
19881	1988-12-01	Inglaterra	Blur
19971	1997-01-01	Japon	M-Flo
19831	1983-01-01	Inglaterra	Fastway
19951	1995-01-01	Estados Unidos	Me First and the Gimme Gimmes
19821	1982-01-01	Inglaterra	The Smiths
\.


--
-- TOC entry 4938 (class 0 OID 17042)
-- Dependencies: 226
-- Data for Name: inventario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inventario (producto, album, sucursal, tipo, precio, stock) FROM stdin;
100	220001	DIMETRODON MUSICAL	CD	12000	12
101	220001	RAMONA	CD	12600	1
102	220001	RAMONA	casete	8000	20
103	220001	RAMONA	vinilo	17550	17
104	220001	RED FLAG	CD	12000	4
105	120031	RAMONA	CD	8000	21
106	120031	RAMONA	casete	5900	5
107	120031	MUSIC FOREVER	CD	20000	2
108	319731	RECORTE	casete	2400	1
109	319731	RECORTE	DVD	10000	2
110	319861	RAMONA	CD	15600	10
111	319861	RECORTE	CD	15600	2
112	319861	RECORTE	vinilo	18000	9
113	319941	RAMONA	CD	15800	1
114	319941	DIMETRODON MUSICAL	CD	15000	2
116	120031	VIRTUAL	digital	4000	\N
117	220001	VIRTUAL	digital	4000	\N
118	319731	VIRTUAL	digital	4000	\N
119	319861	VIRTUAL	digital	2700	\N
120	419881	VIRTUAL	digital	4000	\N
121	319971	VIRTUAL	digital	2700	\N
122	319941	VIRTUAL	digital	3450	\N
123	319971	RAMONA	casete	2800	4
124	319971	RAMONA	CD	15000	7
125	319971	RED FLAG	CD	14600	2
126	319841	RED FLAG	casete	4600	5
127	319841	DIMETRODON MUSICAL	casete	10000	6
115	319941	MUSIC FOREVER	casete	28000	10
\.


--
-- TOC entry 4939 (class 0 OID 17047)
-- Dependencies: 227
-- Data for Name: sucursal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sucursal (nombre, direccion, ciudad, gerente) FROM stdin;
MUSIC FOREVER	Green Street 8972	Londres	Gordon Freeman
RECORTE	Alerce 121	Concepcion	Roberto Toledo
DIMETRODON MUSICAL	Alberto Hurtado 56	Concepcion	Gerarda Roberta
RED FLAG	El Gran atraco 89	Talca	Fernanda  Chávez
RAMONA	Submarino 43	Temuco	Juan Maturana
VIRTUAL	Pasaje Azul 33	Talca	Luna
\.


--
-- TOC entry 4745 (class 2606 OID 17051)
-- Name: album album_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.album
    ADD CONSTRAINT album_pk PRIMARY KEY (codigo);


--
-- TOC entry 4749 (class 2606 OID 17053)
-- Name: artista_grupo artista_grupo_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.artista_grupo
    ADD CONSTRAINT artista_grupo_pk PRIMARY KEY (codigo_artista, codigo_grupo);


--
-- TOC entry 4747 (class 2606 OID 17055)
-- Name: artista artista_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.artista
    ADD CONSTRAINT artista_pk PRIMARY KEY (codigo);


--
-- TOC entry 4751 (class 2606 OID 17057)
-- Name: canasta canasta_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.canasta
    ADD CONSTRAINT canasta_pk PRIMARY KEY (codigo_compra, codigo_producto);


--
-- TOC entry 4753 (class 2606 OID 17059)
-- Name: cancion cancion_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cancion
    ADD CONSTRAINT cancion_pk PRIMARY KEY (codigo);


--
-- TOC entry 4755 (class 2606 OID 17061)
-- Name: cliente cliente_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pk PRIMARY KEY (rut);


--
-- TOC entry 4757 (class 2606 OID 17063)
-- Name: compone compone_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compone
    ADD CONSTRAINT compone_pk PRIMARY KEY (codigo_cancion, codigo_artista);


--
-- TOC entry 4743 (class 2606 OID 17064)
-- Name: compra compra_monto_total_check; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.compra
    ADD CONSTRAINT compra_monto_total_check CHECK ((monto_total >= 0)) NOT VALID;


--
-- TOC entry 4759 (class 2606 OID 17066)
-- Name: compra compra_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compra
    ADD CONSTRAINT compra_pkey PRIMARY KEY (codigo);


--
-- TOC entry 4761 (class 2606 OID 17068)
-- Name: conforma conforma_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conforma
    ADD CONSTRAINT conforma_pk PRIMARY KEY (codigo_cancion, codigo_album);


--
-- TOC entry 4763 (class 2606 OID 17070)
-- Name: crea crea_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.crea
    ADD CONSTRAINT crea_pk PRIMARY KEY (codigo_cancion, codigo_grupo);


--
-- TOC entry 4765 (class 2606 OID 17072)
-- Name: grupo grupo_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grupo
    ADD CONSTRAINT grupo_pk PRIMARY KEY (codigo);


--
-- TOC entry 4767 (class 2606 OID 17074)
-- Name: inventario inventario:pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventario
    ADD CONSTRAINT "inventario:pk" PRIMARY KEY (producto);


--
-- TOC entry 4769 (class 2606 OID 17076)
-- Name: sucursal sucursal_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sucursal
    ADD CONSTRAINT sucursal_pk PRIMARY KEY (nombre);


--
-- TOC entry 4770 (class 2606 OID 17077)
-- Name: artista_grupo artista_grupo_artista_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.artista_grupo
    ADD CONSTRAINT artista_grupo_artista_fk FOREIGN KEY (codigo_artista) REFERENCES public.artista(codigo) NOT VALID;


--
-- TOC entry 4771 (class 2606 OID 17082)
-- Name: artista_grupo artista_grupo_grupo_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.artista_grupo
    ADD CONSTRAINT artista_grupo_grupo_fk FOREIGN KEY (codigo_grupo) REFERENCES public.grupo(codigo) NOT VALID;


--
-- TOC entry 4772 (class 2606 OID 17087)
-- Name: canasta canasta_compra_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.canasta
    ADD CONSTRAINT canasta_compra_fk FOREIGN KEY (codigo_compra) REFERENCES public.compra(codigo);


--
-- TOC entry 4773 (class 2606 OID 17092)
-- Name: canasta canasta_producto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.canasta
    ADD CONSTRAINT canasta_producto_fk FOREIGN KEY (codigo_producto) REFERENCES public.inventario(producto);


--
-- TOC entry 4774 (class 2606 OID 17097)
-- Name: compone compone_artista_pk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compone
    ADD CONSTRAINT compone_artista_pk FOREIGN KEY (codigo_artista) REFERENCES public.artista(codigo);


--
-- TOC entry 4775 (class 2606 OID 17102)
-- Name: compone compone_cancion_pk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compone
    ADD CONSTRAINT compone_cancion_pk FOREIGN KEY (codigo_cancion) REFERENCES public.cancion(codigo);


--
-- TOC entry 4776 (class 2606 OID 17107)
-- Name: compra compra_cliente_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compra
    ADD CONSTRAINT compra_cliente_fk FOREIGN KEY (cliente) REFERENCES public.cliente(rut) NOT VALID;


--
-- TOC entry 4777 (class 2606 OID 17112)
-- Name: compra compra_sucursal_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compra
    ADD CONSTRAINT compra_sucursal_fk FOREIGN KEY (sucursal) REFERENCES public.sucursal(nombre) NOT VALID;


--
-- TOC entry 4778 (class 2606 OID 17117)
-- Name: conforma conforma_album_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conforma
    ADD CONSTRAINT conforma_album_fk FOREIGN KEY (codigo_album) REFERENCES public.album(codigo);


--
-- TOC entry 4779 (class 2606 OID 17122)
-- Name: conforma conforma_cancion_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conforma
    ADD CONSTRAINT conforma_cancion_fk FOREIGN KEY (codigo_cancion) REFERENCES public.cancion(codigo);


--
-- TOC entry 4780 (class 2606 OID 17127)
-- Name: crea crea_cancion_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.crea
    ADD CONSTRAINT crea_cancion_fk FOREIGN KEY (codigo_cancion) REFERENCES public.cancion(codigo);


--
-- TOC entry 4781 (class 2606 OID 17132)
-- Name: crea crea_grupo_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.crea
    ADD CONSTRAINT crea_grupo_fk FOREIGN KEY (codigo_grupo) REFERENCES public.grupo(codigo);


--
-- TOC entry 4782 (class 2606 OID 17137)
-- Name: inventario inventario_album_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventario
    ADD CONSTRAINT inventario_album_fk FOREIGN KEY (album) REFERENCES public.album(codigo);


--
-- TOC entry 4783 (class 2606 OID 17142)
-- Name: inventario inventario_sucursal_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventario
    ADD CONSTRAINT inventario_sucursal_fk FOREIGN KEY (sucursal) REFERENCES public.sucursal(nombre);


-- Completed on 2024-10-12 18:02:51

--
-- PostgreSQL database dump complete
--

