--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4
-- Dumped by pg_dump version 16.4

-- Started on 2024-10-12 18:17:57

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
-- TOC entry 916 (class 0 OID 0)
-- Name: cube; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.cube;


--
-- TOC entry 223 (class 1255 OID 17149)
-- Name: cube_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.cube_in(cstring) RETURNS public.cube
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_in';


ALTER FUNCTION public.cube_in(cstring) OWNER TO postgres;

--
-- TOC entry 224 (class 1255 OID 17150)
-- Name: cube_out(public.cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.cube_out(public.cube) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_out';


ALTER FUNCTION public.cube_out(public.cube) OWNER TO postgres;

--
-- TOC entry 915 (class 1247 OID 17148)
-- Name: cube; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.cube (
    INTERNALLENGTH = variable,
    INPUT = public.cube_in,
    OUTPUT = public.cube_out,
    ALIGNMENT = double,
    STORAGE = plain
);


ALTER TYPE public.cube OWNER TO postgres;

--
-- TOC entry 4968 (class 0 OID 0)
-- Dependencies: 915
-- Name: TYPE cube; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE public.cube IS 'multi-dimensional cube ''(FLOAT-1, FLOAT-2, ..., FLOAT-N), (FLOAT-1, FLOAT-2, ..., FLOAT-N)''';


--
-- TOC entry 919 (class 1247 OID 17154)
-- Name: tablefunc_crosstab_2; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.tablefunc_crosstab_2 AS (
	row_name text,
	category_1 text,
	category_2 text
);


ALTER TYPE public.tablefunc_crosstab_2 OWNER TO postgres;

--
-- TOC entry 922 (class 1247 OID 17157)
-- Name: tablefunc_crosstab_3; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.tablefunc_crosstab_3 AS (
	row_name text,
	category_1 text,
	category_2 text,
	category_3 text
);


ALTER TYPE public.tablefunc_crosstab_3 OWNER TO postgres;

--
-- TOC entry 925 (class 1247 OID 17160)
-- Name: tablefunc_crosstab_4; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.tablefunc_crosstab_4 AS (
	row_name text,
	category_1 text,
	category_2 text,
	category_3 text,
	category_4 text
);


ALTER TYPE public.tablefunc_crosstab_4 OWNER TO postgres;

--
-- TOC entry 225 (class 1255 OID 17161)
-- Name: addgeometrycolumn(character varying, character varying, integer, character varying, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.addgeometrycolumn(character varying, character varying, integer, character varying, integer) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
	ret  text;
BEGIN
	SELECT AddGeometryColumn('','',$1,$2,$3,$4,$5) into ret;
	RETURN ret;
END;
$_$;


ALTER FUNCTION public.addgeometrycolumn(character varying, character varying, integer, character varying, integer) OWNER TO postgres;

--
-- TOC entry 226 (class 1255 OID 17162)
-- Name: addgeometrycolumn(character varying, character varying, character varying, integer, character varying, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.addgeometrycolumn(character varying, character varying, character varying, integer, character varying, integer) RETURNS text
    LANGUAGE plpgsql STABLE STRICT
    AS $_$
DECLARE
	ret  text;
BEGIN
	SELECT AddGeometryColumn('',$1,$2,$3,$4,$5,$6) into ret;
	RETURN ret;
END;
$_$;


ALTER FUNCTION public.addgeometrycolumn(character varying, character varying, character varying, integer, character varying, integer) OWNER TO postgres;

--
-- TOC entry 227 (class 1255 OID 17163)
-- Name: addgeometrycolumn(character varying, character varying, character varying, character varying, integer, character varying, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.addgeometrycolumn(character varying, character varying, character varying, character varying, integer, character varying, integer) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
	catalog_name alias for $1;
	schema_name alias for $2;
	table_name alias for $3;
	column_name alias for $4;
	new_srid alias for $5;
	new_type alias for $6;
	new_dim alias for $7;

	rec RECORD;
	schema_ok bool;
	real_schema name;

	fixgeomres text;

BEGIN

	IF ( not ( (new_type ='GEOMETRY') or
		   (new_type ='GEOMETRYCOLLECTION') or
		   (new_type ='POINT') or 
		   (new_type ='MULTIPOINT') or
		   (new_type ='POLYGON') or
		   (new_type ='MULTIPOLYGON') or
		   (new_type ='LINESTRING') or
		   (new_type ='MULTILINESTRING') or
		   (new_type ='GEOMETRYCOLLECTIONM') or
		   (new_type ='POINTM') or 
		   (new_type ='MULTIPOINTM') or
		   (new_type ='POLYGONM') or
		   (new_type ='MULTIPOLYGONM') or
		   (new_type ='LINESTRINGM') or
		   (new_type ='MULTILINESTRINGM')) )
	THEN
		RAISE EXCEPTION 'Invalid type name - valid ones are: 
			GEOMETRY, GEOMETRYCOLLECTION, POINT, 
			MULTIPOINT, POLYGON, MULTIPOLYGON, 
			LINESTRING, MULTILINESTRING,
			GEOMETRYCOLLECTIONM, POINTM, 
			MULTIPOINTM, POLYGONM, MULTIPOLYGONM, 
			LINESTRINGM, or MULTILINESTRINGM ';
		return 'fail';
	END IF;

	IF ( (new_dim >4) or (new_dim <0) ) THEN
		RAISE EXCEPTION 'invalid dimension';
		return 'fail';
	END IF;

	IF ( (new_type LIKE '%M') and (new_dim!=3) ) THEN

		RAISE EXCEPTION 'TypeM needs 3 dimensions';
		return 'fail';
	END IF;


	IF ( schema_name != '' ) THEN
		schema_ok = 'f';
		FOR rec IN SELECT nspname FROM pg_namespace WHERE text(nspname) = schema_name LOOP
			schema_ok := 't';
		END LOOP;

		if ( schema_ok <> 't' ) THEN
			RAISE NOTICE 'Invalid schema name - using current_schema()';
			SELECT current_schema() into real_schema;
		ELSE
			real_schema = schema_name;
		END IF;

	ELSE
		SELECT current_schema() into real_schema;
	END IF;



	-- Add geometry column

	EXECUTE 'ALTER TABLE ' ||

		quote_ident(real_schema) || '.' || quote_ident(table_name)



		|| ' ADD COLUMN ' || quote_ident(column_name) || 
		' geometry ';


	-- Delete stale record in geometry_column (if any)

	EXECUTE 'DELETE FROM geometry_columns WHERE
		f_table_catalog = ' || quote_literal('') || 
		' AND f_table_schema = ' ||

		quote_literal(real_schema) || 



		' AND f_table_name = ' || quote_literal(table_name) ||
		' AND f_geometry_column = ' || quote_literal(column_name);


	-- Add record in geometry_column 

	EXECUTE 'INSERT INTO geometry_columns VALUES (' ||
		quote_literal('') || ',' ||

		quote_literal(real_schema) || ',' ||



		quote_literal(table_name) || ',' ||
		quote_literal(column_name) || ',' ||
		new_dim || ',' || new_srid || ',' ||
		quote_literal(new_type) || ')';

	-- Add table checks

	EXECUTE 'ALTER TABLE ' || 

		quote_ident(real_schema) || '.' || quote_ident(table_name)



		|| ' ADD CONSTRAINT ' 
		|| quote_ident('enforce_srid_' || column_name)
		|| ' CHECK (SRID(' || quote_ident(column_name) ||
		') = ' || new_srid || ')' ;

	EXECUTE 'ALTER TABLE ' || 

		quote_ident(real_schema) || '.' || quote_ident(table_name)



		|| ' ADD CONSTRAINT '
		|| quote_ident('enforce_dims_' || column_name)
		|| ' CHECK (ndims(' || quote_ident(column_name) ||
		') = ' || new_dim || ')' ;

	IF (not(new_type = 'GEOMETRY')) THEN
		EXECUTE 'ALTER TABLE ' || 

		quote_ident(real_schema) || '.' || quote_ident(table_name)



		|| ' ADD CONSTRAINT '
		|| quote_ident('enforce_geotype_' || column_name)
		|| ' CHECK (geometrytype(' ||
		quote_ident(column_name) || ')=' ||
		quote_literal(new_type) || ' OR (' ||
		quote_ident(column_name) || ') is null)';
	END IF;

	SELECT fix_geometry_columns() INTO fixgeomres;

	return 

		real_schema || '.' || 

		table_name || '.' || column_name ||
		' SRID:' || new_srid ||
		' TYPE:' || new_type || 
		' DIMS:' || new_dim || '
 ' ||
		'geometry_column ' || fixgeomres;
END;
$_$;


ALTER FUNCTION public.addgeometrycolumn(character varying, character varying, character varying, character varying, integer, character varying, integer) OWNER TO postgres;

--
-- TOC entry 228 (class 1255 OID 17164)
-- Name: connectby(text, text, text, text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.connectby(text, text, text, text, integer) RETURNS SETOF record
    LANGUAGE c STABLE STRICT
    AS '$libdir/tablefunc', 'connectby_text';


ALTER FUNCTION public.connectby(text, text, text, text, integer) OWNER TO postgres;

--
-- TOC entry 229 (class 1255 OID 17165)
-- Name: connectby(text, text, text, text, integer, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.connectby(text, text, text, text, integer, text) RETURNS SETOF record
    LANGUAGE c STABLE STRICT
    AS '$libdir/tablefunc', 'connectby_text';


ALTER FUNCTION public.connectby(text, text, text, text, integer, text) OWNER TO postgres;

--
-- TOC entry 230 (class 1255 OID 17166)
-- Name: connectby(text, text, text, text, text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.connectby(text, text, text, text, text, integer) RETURNS SETOF record
    LANGUAGE c STABLE STRICT
    AS '$libdir/tablefunc', 'connectby_text_serial';


ALTER FUNCTION public.connectby(text, text, text, text, text, integer) OWNER TO postgres;

--
-- TOC entry 231 (class 1255 OID 17167)
-- Name: connectby(text, text, text, text, text, integer, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.connectby(text, text, text, text, text, integer, text) RETURNS SETOF record
    LANGUAGE c STABLE STRICT
    AS '$libdir/tablefunc', 'connectby_text_serial';


ALTER FUNCTION public.connectby(text, text, text, text, text, integer, text) OWNER TO postgres;

--
-- TOC entry 232 (class 1255 OID 17168)
-- Name: crosstab(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.crosstab(text) RETURNS SETOF record
    LANGUAGE c STABLE STRICT
    AS '$libdir/tablefunc', 'crosstab';


ALTER FUNCTION public.crosstab(text) OWNER TO postgres;

--
-- TOC entry 233 (class 1255 OID 17169)
-- Name: crosstab(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.crosstab(text, integer) RETURNS SETOF record
    LANGUAGE c STABLE STRICT
    AS '$libdir/tablefunc', 'crosstab';


ALTER FUNCTION public.crosstab(text, integer) OWNER TO postgres;

--
-- TOC entry 234 (class 1255 OID 17170)
-- Name: crosstab(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.crosstab(text, text) RETURNS SETOF record
    LANGUAGE c STABLE STRICT
    AS '$libdir/tablefunc', 'crosstab_hash';


ALTER FUNCTION public.crosstab(text, text) OWNER TO postgres;

--
-- TOC entry 235 (class 1255 OID 17171)
-- Name: crosstab2(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.crosstab2(text) RETURNS SETOF public.tablefunc_crosstab_2
    LANGUAGE c STABLE STRICT
    AS '$libdir/tablefunc', 'crosstab';


ALTER FUNCTION public.crosstab2(text) OWNER TO postgres;

--
-- TOC entry 236 (class 1255 OID 17172)
-- Name: crosstab3(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.crosstab3(text) RETURNS SETOF public.tablefunc_crosstab_3
    LANGUAGE c STABLE STRICT
    AS '$libdir/tablefunc', 'crosstab';


ALTER FUNCTION public.crosstab3(text) OWNER TO postgres;

--
-- TOC entry 237 (class 1255 OID 17173)
-- Name: crosstab4(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.crosstab4(text) RETURNS SETOF public.tablefunc_crosstab_4
    LANGUAGE c STABLE STRICT
    AS '$libdir/tablefunc', 'crosstab';


ALTER FUNCTION public.crosstab4(text) OWNER TO postgres;

--
-- TOC entry 238 (class 1255 OID 17174)
-- Name: cube(double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.cube(double precision) RETURNS public.cube
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_f8';


ALTER FUNCTION public.cube(double precision) OWNER TO postgres;

--
-- TOC entry 239 (class 1255 OID 17175)
-- Name: cube(double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.cube(double precision, double precision) RETURNS public.cube
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_f8_f8';


ALTER FUNCTION public.cube(double precision, double precision) OWNER TO postgres;

--
-- TOC entry 240 (class 1255 OID 17176)
-- Name: cube(public.cube, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.cube(public.cube, double precision) RETURNS public.cube
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_c_f8';


ALTER FUNCTION public.cube(public.cube, double precision) OWNER TO postgres;

--
-- TOC entry 241 (class 1255 OID 17177)
-- Name: cube(public.cube, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.cube(public.cube, double precision, double precision) RETURNS public.cube
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_c_f8_f8';


ALTER FUNCTION public.cube(public.cube, double precision, double precision) OWNER TO postgres;

--
-- TOC entry 242 (class 1255 OID 17178)
-- Name: cube_cmp(public.cube, public.cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.cube_cmp(public.cube, public.cube) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_cmp';


ALTER FUNCTION public.cube_cmp(public.cube, public.cube) OWNER TO postgres;

--
-- TOC entry 4969 (class 0 OID 0)
-- Dependencies: 242
-- Name: FUNCTION cube_cmp(public.cube, public.cube); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.cube_cmp(public.cube, public.cube) IS 'btree comparison function';


--
-- TOC entry 243 (class 1255 OID 17179)
-- Name: cube_contained(public.cube, public.cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.cube_contained(public.cube, public.cube) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_contained';


ALTER FUNCTION public.cube_contained(public.cube, public.cube) OWNER TO postgres;

--
-- TOC entry 4970 (class 0 OID 0)
-- Dependencies: 243
-- Name: FUNCTION cube_contained(public.cube, public.cube); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.cube_contained(public.cube, public.cube) IS 'contained in';


--
-- TOC entry 244 (class 1255 OID 17180)
-- Name: cube_contains(public.cube, public.cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.cube_contains(public.cube, public.cube) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_contains';


ALTER FUNCTION public.cube_contains(public.cube, public.cube) OWNER TO postgres;

--
-- TOC entry 4971 (class 0 OID 0)
-- Dependencies: 244
-- Name: FUNCTION cube_contains(public.cube, public.cube); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.cube_contains(public.cube, public.cube) IS 'contains';


--
-- TOC entry 245 (class 1255 OID 17181)
-- Name: cube_dim(public.cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.cube_dim(public.cube) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_dim';


ALTER FUNCTION public.cube_dim(public.cube) OWNER TO postgres;

--
-- TOC entry 246 (class 1255 OID 17182)
-- Name: cube_distance(public.cube, public.cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.cube_distance(public.cube, public.cube) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_distance';


ALTER FUNCTION public.cube_distance(public.cube, public.cube) OWNER TO postgres;

--
-- TOC entry 247 (class 1255 OID 17183)
-- Name: cube_enlarge(public.cube, double precision, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.cube_enlarge(public.cube, double precision, integer) RETURNS public.cube
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_enlarge';


ALTER FUNCTION public.cube_enlarge(public.cube, double precision, integer) OWNER TO postgres;

--
-- TOC entry 248 (class 1255 OID 17184)
-- Name: cube_eq(public.cube, public.cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.cube_eq(public.cube, public.cube) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_eq';


ALTER FUNCTION public.cube_eq(public.cube, public.cube) OWNER TO postgres;

--
-- TOC entry 4972 (class 0 OID 0)
-- Dependencies: 248
-- Name: FUNCTION cube_eq(public.cube, public.cube); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.cube_eq(public.cube, public.cube) IS 'same as';


--
-- TOC entry 249 (class 1255 OID 17185)
-- Name: cube_ge(public.cube, public.cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.cube_ge(public.cube, public.cube) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_ge';


ALTER FUNCTION public.cube_ge(public.cube, public.cube) OWNER TO postgres;

--
-- TOC entry 4973 (class 0 OID 0)
-- Dependencies: 249
-- Name: FUNCTION cube_ge(public.cube, public.cube); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.cube_ge(public.cube, public.cube) IS 'greater than or equal to';


--
-- TOC entry 250 (class 1255 OID 17186)
-- Name: cube_gt(public.cube, public.cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.cube_gt(public.cube, public.cube) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_gt';


ALTER FUNCTION public.cube_gt(public.cube, public.cube) OWNER TO postgres;

--
-- TOC entry 4974 (class 0 OID 0)
-- Dependencies: 250
-- Name: FUNCTION cube_gt(public.cube, public.cube); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.cube_gt(public.cube, public.cube) IS 'greater than';


--
-- TOC entry 251 (class 1255 OID 17187)
-- Name: cube_inter(public.cube, public.cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.cube_inter(public.cube, public.cube) RETURNS public.cube
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_inter';


ALTER FUNCTION public.cube_inter(public.cube, public.cube) OWNER TO postgres;

--
-- TOC entry 252 (class 1255 OID 17188)
-- Name: cube_is_point(public.cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.cube_is_point(public.cube) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_is_point';


ALTER FUNCTION public.cube_is_point(public.cube) OWNER TO postgres;

--
-- TOC entry 253 (class 1255 OID 17189)
-- Name: cube_le(public.cube, public.cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.cube_le(public.cube, public.cube) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_le';


ALTER FUNCTION public.cube_le(public.cube, public.cube) OWNER TO postgres;

--
-- TOC entry 4975 (class 0 OID 0)
-- Dependencies: 253
-- Name: FUNCTION cube_le(public.cube, public.cube); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.cube_le(public.cube, public.cube) IS 'lower than or equal to';


--
-- TOC entry 254 (class 1255 OID 17190)
-- Name: cube_ll_coord(public.cube, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.cube_ll_coord(public.cube, integer) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_ll_coord';


ALTER FUNCTION public.cube_ll_coord(public.cube, integer) OWNER TO postgres;

--
-- TOC entry 255 (class 1255 OID 17191)
-- Name: cube_lt(public.cube, public.cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.cube_lt(public.cube, public.cube) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_lt';


ALTER FUNCTION public.cube_lt(public.cube, public.cube) OWNER TO postgres;

--
-- TOC entry 4976 (class 0 OID 0)
-- Dependencies: 255
-- Name: FUNCTION cube_lt(public.cube, public.cube); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.cube_lt(public.cube, public.cube) IS 'lower than';


--
-- TOC entry 256 (class 1255 OID 17192)
-- Name: cube_ne(public.cube, public.cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.cube_ne(public.cube, public.cube) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_ne';


ALTER FUNCTION public.cube_ne(public.cube, public.cube) OWNER TO postgres;

--
-- TOC entry 4977 (class 0 OID 0)
-- Dependencies: 256
-- Name: FUNCTION cube_ne(public.cube, public.cube); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.cube_ne(public.cube, public.cube) IS 'different';


--
-- TOC entry 257 (class 1255 OID 17193)
-- Name: cube_overlap(public.cube, public.cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.cube_overlap(public.cube, public.cube) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_overlap';


ALTER FUNCTION public.cube_overlap(public.cube, public.cube) OWNER TO postgres;

--
-- TOC entry 4978 (class 0 OID 0)
-- Dependencies: 257
-- Name: FUNCTION cube_overlap(public.cube, public.cube); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.cube_overlap(public.cube, public.cube) IS 'overlaps';


--
-- TOC entry 258 (class 1255 OID 17194)
-- Name: cube_size(public.cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.cube_size(public.cube) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_size';


ALTER FUNCTION public.cube_size(public.cube) OWNER TO postgres;

--
-- TOC entry 259 (class 1255 OID 17195)
-- Name: cube_union(public.cube, public.cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.cube_union(public.cube, public.cube) RETURNS public.cube
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_union';


ALTER FUNCTION public.cube_union(public.cube, public.cube) OWNER TO postgres;

--
-- TOC entry 260 (class 1255 OID 17196)
-- Name: cube_ur_coord(public.cube, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.cube_ur_coord(public.cube, integer) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_ur_coord';


ALTER FUNCTION public.cube_ur_coord(public.cube, integer) OWNER TO postgres;

--
-- TOC entry 261 (class 1255 OID 17197)
-- Name: dropgeometrycolumn(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.dropgeometrycolumn(character varying, character varying) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
	ret text;
BEGIN
	SELECT DropGeometryColumn('','',$1,$2) into ret;
	RETURN ret;
END;
$_$;


ALTER FUNCTION public.dropgeometrycolumn(character varying, character varying) OWNER TO postgres;

--
-- TOC entry 262 (class 1255 OID 17198)
-- Name: dropgeometrycolumn(character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.dropgeometrycolumn(character varying, character varying, character varying) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
	ret text;
BEGIN
	SELECT DropGeometryColumn('',$1,$2,$3) into ret;
	RETURN ret;
END;
$_$;


ALTER FUNCTION public.dropgeometrycolumn(character varying, character varying, character varying) OWNER TO postgres;

--
-- TOC entry 287 (class 1255 OID 17199)
-- Name: dropgeometrycolumn(character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.dropgeometrycolumn(character varying, character varying, character varying, character varying) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
	catalog_name alias for $1; 
	schema_name alias for $2;
	table_name alias for $3;
	column_name alias for $4;
	myrec RECORD;
	okay boolean;
	real_schema name;

BEGIN



	-- Find, check or fix schema_name
	IF ( schema_name != '' ) THEN
		okay = 'f';

		FOR myrec IN SELECT nspname FROM pg_namespace WHERE text(nspname) = schema_name LOOP
			okay := 't';
		END LOOP;

		IF ( okay <> 't' ) THEN
			RAISE NOTICE 'Invalid schema name - using current_schema()';
			SELECT current_schema() into real_schema;
		ELSE
			real_schema = schema_name;
		END IF;
	ELSE
		SELECT current_schema() into real_schema;
	END IF;




 	-- Find out if the column is in the geometry_columns table
	okay = 'f';
	FOR myrec IN SELECT * from geometry_columns where f_table_schema = text(real_schema) and f_table_name = table_name and f_geometry_column = column_name LOOP
		okay := 't';
	END LOOP; 
	IF (okay <> 't') THEN 
		RAISE EXCEPTION 'column not found in geometry_columns table';
		RETURN 'f';
	END IF;

	-- Remove ref from geometry_columns table
	EXECUTE 'delete from geometry_columns where f_table_schema = ' ||
		quote_literal(real_schema) || ' and f_table_name = ' ||
		quote_literal(table_name)  || ' and f_geometry_column = ' ||
		quote_literal(column_name);
	
	-- Remove table column
	EXECUTE 'ALTER TABLE ' || quote_ident(real_schema) || '.' ||
		quote_ident(table_name) || ' DROP COLUMN ' ||
		quote_ident(column_name);



	RETURN real_schema || '.' || table_name || '.' || column_name ||' effectively removed.';
	
END;
$_$;


ALTER FUNCTION public.dropgeometrycolumn(character varying, character varying, character varying, character varying) OWNER TO postgres;

--
-- TOC entry 288 (class 1255 OID 17200)
-- Name: dropgeometrytable(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.dropgeometrytable(character varying) RETURNS text
    LANGUAGE sql STRICT
    AS $_$SELECT DropGeometryTable('','',$1)$_$;


ALTER FUNCTION public.dropgeometrytable(character varying) OWNER TO postgres;

--
-- TOC entry 289 (class 1255 OID 17201)
-- Name: dropgeometrytable(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.dropgeometrytable(character varying, character varying) RETURNS text
    LANGUAGE sql STRICT
    AS $_$SELECT DropGeometryTable('',$1,$2)$_$;


ALTER FUNCTION public.dropgeometrytable(character varying, character varying) OWNER TO postgres;

--
-- TOC entry 290 (class 1255 OID 17202)
-- Name: dropgeometrytable(character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.dropgeometrytable(character varying, character varying, character varying) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
	catalog_name alias for $1; 
	schema_name alias for $2;
	table_name alias for $3;
	real_schema name;

BEGIN


	IF ( schema_name = '' ) THEN
		SELECT current_schema() into real_schema;
	ELSE
		real_schema = schema_name;
	END IF;


	-- Remove refs from geometry_columns table
	EXECUTE 'DELETE FROM geometry_columns WHERE ' ||

		'f_table_schema = ' || quote_literal(real_schema) ||
		' AND ' ||

		' f_table_name = ' || quote_literal(table_name);
	
	-- Remove table 
	EXECUTE 'DROP TABLE '

		|| quote_ident(real_schema) || '.' ||

		quote_ident(table_name);

	RETURN

		real_schema || '.' ||

		table_name ||' dropped.';
	
END;
$_$;


ALTER FUNCTION public.dropgeometrytable(character varying, character varying, character varying) OWNER TO postgres;

--
-- TOC entry 291 (class 1255 OID 17203)
-- Name: find_srid(character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.find_srid(character varying, character varying, character varying) RETURNS integer
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$DECLARE
   schem text;
   tabl text;
   sr int4;
BEGIN
   IF $1 IS NULL THEN
      RAISE EXCEPTION 'find_srid() - schema is NULL!';
   END IF;
   IF $2 IS NULL THEN
      RAISE EXCEPTION 'find_srid() - table name is NULL!';
   END IF;
   IF $3 IS NULL THEN
      RAISE EXCEPTION 'find_srid() - column name is NULL!';
   END IF;
   schem = $1;
   tabl = $2;
-- if the table contains a . and the schema is empty
-- split the table into a schema and a table
-- otherwise drop through to default behavior
   IF ( schem = '' and tabl LIKE '%.%' ) THEN
     schem = substr(tabl,1,strpos(tabl,'.')-1);
     tabl = substr(tabl,length(schem)+2);
   ELSE
     schem = schem || '%';
   END IF;

   select SRID into sr from geometry_columns where f_table_schema like schem and f_table_name = tabl and f_geometry_column = $3;
   IF NOT FOUND THEN
       RAISE EXCEPTION 'find_srid() - couldnt find the corresponding SRID - is the geometry registered in the GEOMETRY_COLUMNS table?  Is there an uppercase/lowercase missmatch?';
   END IF;
  return sr;
END;
$_$;


ALTER FUNCTION public.find_srid(character varying, character varying, character varying) OWNER TO postgres;

--
-- TOC entry 292 (class 1255 OID 17204)
-- Name: fix_geometry_columns(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fix_geometry_columns() RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
	mislinked record;
	result text;
	linked integer;
	deleted integer;

	foundschema integer;

BEGIN


	-- Since 7.3 schema support has been added.
	-- Previous postgis versions used to put the database name in
	-- the schema column. This needs to be fixed, so we try to 
	-- set the correct schema for each geometry_colums record
	-- looking at table, column, type and srid.
	UPDATE geometry_columns SET f_table_schema = n.nspname
		FROM pg_namespace n, pg_class c, pg_attribute a,
			pg_constraint sridcheck, pg_constraint typecheck
                WHERE ( f_table_schema is NULL
		OR f_table_schema = ''
                OR f_table_schema NOT IN (
                        SELECT nspname::varchar
                        FROM pg_namespace nn, pg_class cc, pg_attribute aa
                        WHERE cc.relnamespace = nn.oid
                        AND cc.relname = f_table_name::name
                        AND aa.attrelid = cc.oid
                        AND aa.attname = f_geometry_column::name))
                AND f_table_name::name = c.relname
                AND c.oid = a.attrelid
                AND c.relnamespace = n.oid
                AND f_geometry_column::name = a.attname

                AND sridcheck.conrelid = c.oid
		AND sridcheck.consrc LIKE '(srid(% = %)'
                AND sridcheck.consrc ~ textcat(' = ', srid::text)

                AND typecheck.conrelid = c.oid
		AND typecheck.consrc LIKE
	'((geometrytype(%) = ''%''::text) OR (% IS NULL))'
                AND typecheck.consrc ~ textcat(' = ''', type::text)

                AND NOT EXISTS (
                        SELECT oid FROM geometry_columns gc
                        WHERE c.relname::varchar = gc.f_table_name
                        AND n.nspname::varchar = gc.f_table_schema
                        AND a.attname::varchar = gc.f_geometry_column
                );

	GET DIAGNOSTICS foundschema = ROW_COUNT;



	-- no linkage to system table needed
	return 'fixed:'||foundschema::text;


	-- fix linking to system tables
	SELECT 0 INTO linked;
	FOR mislinked in
		SELECT gc.oid as gcrec,
			a.attrelid as attrelid, a.attnum as attnum
                FROM geometry_columns gc, pg_class c,

		pg_namespace n, pg_attribute a



                WHERE ( gc.attrelid IS NULL OR gc.attrelid != a.attrelid 
			OR gc.varattnum IS NULL OR gc.varattnum != a.attnum)

                AND n.nspname = gc.f_table_schema::name
                AND c.relnamespace = n.oid

                AND c.relname = gc.f_table_name::name
                AND a.attname = f_geometry_column::name
                AND a.attrelid = c.oid
	LOOP
		UPDATE geometry_columns SET
			attrelid = mislinked.attrelid,
			varattnum = mislinked.attnum,
			stats = NULL
			WHERE geometry_columns.oid = mislinked.gcrec;
		SELECT linked+1 INTO linked;
	END LOOP; 

	-- remove stale records
	DELETE FROM geometry_columns WHERE attrelid IS NULL;

	GET DIAGNOSTICS deleted = ROW_COUNT;

	result = 

		'fixed:' || foundschema::text ||

		' linked:' || linked::text || 
		' deleted:' || deleted::text;

	return result;

END;
$$;


ALTER FUNCTION public.fix_geometry_columns() OWNER TO postgres;

--
-- TOC entry 293 (class 1255 OID 17205)
-- Name: g_cube_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.g_cube_compress(internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/cube', 'g_cube_compress';


ALTER FUNCTION public.g_cube_compress(internal) OWNER TO postgres;

--
-- TOC entry 294 (class 1255 OID 17206)
-- Name: g_cube_consistent(internal, public.cube, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.g_cube_consistent(internal, public.cube, integer) RETURNS boolean
    LANGUAGE c
    AS '$libdir/cube', 'g_cube_consistent';


ALTER FUNCTION public.g_cube_consistent(internal, public.cube, integer) OWNER TO postgres;

--
-- TOC entry 263 (class 1255 OID 17207)
-- Name: g_cube_decompress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.g_cube_decompress(internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/cube', 'g_cube_decompress';


ALTER FUNCTION public.g_cube_decompress(internal) OWNER TO postgres;

--
-- TOC entry 264 (class 1255 OID 17208)
-- Name: g_cube_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.g_cube_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c STRICT
    AS '$libdir/cube', 'g_cube_penalty';


ALTER FUNCTION public.g_cube_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 265 (class 1255 OID 17209)
-- Name: g_cube_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.g_cube_picksplit(internal, internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/cube', 'g_cube_picksplit';


ALTER FUNCTION public.g_cube_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 266 (class 1255 OID 17210)
-- Name: g_cube_same(public.cube, public.cube, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.g_cube_same(public.cube, public.cube, internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/cube', 'g_cube_same';


ALTER FUNCTION public.g_cube_same(public.cube, public.cube, internal) OWNER TO postgres;

--
-- TOC entry 267 (class 1255 OID 17211)
-- Name: g_cube_union(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.g_cube_union(internal, internal) RETURNS public.cube
    LANGUAGE c
    AS '$libdir/cube', 'g_cube_union';


ALTER FUNCTION public.g_cube_union(internal, internal) OWNER TO postgres;

--
-- TOC entry 268 (class 1255 OID 17212)
-- Name: get_proj4_from_srid(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_proj4_from_srid(integer) RETURNS text
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
BEGIN
	RETURN proj4text::text FROM spatial_ref_sys WHERE srid= $1;
END;
$_$;


ALTER FUNCTION public.get_proj4_from_srid(integer) OWNER TO postgres;

--
-- TOC entry 269 (class 1255 OID 17213)
-- Name: insert_username(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.insert_username() RETURNS trigger
    LANGUAGE c
    AS '$libdir/insert_username', 'insert_username';


ALTER FUNCTION public.insert_username() OWNER TO postgres;

--
-- TOC entry 270 (class 1255 OID 17214)
-- Name: moddatetime(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.moddatetime() RETURNS trigger
    LANGUAGE c
    AS '$libdir/moddatetime', 'moddatetime';


ALTER FUNCTION public.moddatetime() OWNER TO postgres;

--
-- TOC entry 271 (class 1255 OID 17215)
-- Name: normal_rand(integer, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.normal_rand(integer, double precision, double precision) RETURNS SETOF double precision
    LANGUAGE c STRICT
    AS '$libdir/tablefunc', 'normal_rand';


ALTER FUNCTION public.normal_rand(integer, double precision, double precision) OWNER TO postgres;

--
-- TOC entry 277 (class 1255 OID 17216)
-- Name: postgis_full_version(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.postgis_full_version() RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
	libver text;
	projver text;
	geosver text;
	usestats bool;
	dbproc text;
	relproc text;
	fullver text;
BEGIN
	SELECT postgis_lib_version() INTO libver;
	SELECT postgis_proj_version() INTO projver;
	SELECT postgis_geos_version() INTO geosver;
	SELECT postgis_uses_stats() INTO usestats;
	SELECT postgis_scripts_installed() INTO dbproc;
	SELECT postgis_scripts_released() INTO relproc;

	fullver = 'POSTGIS="' || libver || '"';

	IF  geosver IS NOT NULL THEN
		fullver = fullver || ' GEOS="' || geosver || '"';
	END IF;

	IF  projver IS NOT NULL THEN
		fullver = fullver || ' PROJ="' || projver || '"';
	END IF;

	IF usestats THEN
		fullver = fullver || ' USE_STATS';
	END IF;

	fullver = fullver || ' DBPROC="' || dbproc || '"';
	fullver = fullver || ' RELPROC="' || relproc || '"';

	IF dbproc != relproc THEN
		fullver = fullver || ' (needs proc upgrade)';
	END IF;

	RETURN fullver;
END
$$;


ALTER FUNCTION public.postgis_full_version() OWNER TO postgres;

--
-- TOC entry 284 (class 1255 OID 17217)
-- Name: postgis_scripts_build_date(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.postgis_scripts_build_date() RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $$SELECT '2005-12-13 16:20:51'::text AS version$$;


ALTER FUNCTION public.postgis_scripts_build_date() OWNER TO postgres;

--
-- TOC entry 285 (class 1255 OID 17218)
-- Name: postgis_scripts_installed(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.postgis_scripts_installed() RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $$SELECT '0.3.0'::text AS version$$;


ALTER FUNCTION public.postgis_scripts_installed() OWNER TO postgres;

--
-- TOC entry 272 (class 1255 OID 17219)
-- Name: postgis_version(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.postgis_version() RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $$SELECT '1.0 USE_GEOS=1 USE_PROJ=1 USE_STATS=1'::text AS version$$;


ALTER FUNCTION public.postgis_version() OWNER TO postgres;

--
-- TOC entry 295 (class 1255 OID 17220)
-- Name: probe_geometry_columns(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.probe_geometry_columns() RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
	inserted integer;
	oldcount integer;
	probed integer;
	stale integer;
BEGIN

	SELECT count(*) INTO oldcount FROM geometry_columns;

	SELECT count(*) INTO probed
		FROM pg_class c, pg_attribute a, pg_type t, 

			pg_namespace n,
			pg_constraint sridcheck, pg_constraint typecheck




		WHERE t.typname = 'geometry'
		AND a.atttypid = t.oid
		AND a.attrelid = c.oid

		AND c.relnamespace = n.oid
		AND sridcheck.connamespace = n.oid
		AND typecheck.connamespace = n.oid



		AND sridcheck.conrelid = c.oid
		AND sridcheck.consrc LIKE '(srid('||a.attname||') = %)'
		AND typecheck.conrelid = c.oid
		AND typecheck.consrc LIKE
	'((geometrytype('||a.attname||') = ''%''::text) OR (% IS NULL))'







		;

	INSERT INTO geometry_columns SELECT
		''::varchar as f_table_catalogue,

		n.nspname::varchar as f_table_schema,



		c.relname::varchar as f_table_name,
		a.attname::varchar as f_geometry_column,
		2 as coord_dimension,

		trim(both  ' =)' from substr(sridcheck.consrc,
			strpos(sridcheck.consrc, '=')))::integer as srid,
		trim(both ' =)''' from substr(typecheck.consrc, 
			strpos(typecheck.consrc, '='),
			strpos(typecheck.consrc, '::')-
			strpos(typecheck.consrc, '=')
			))::varchar as type






		FROM pg_class c, pg_attribute a, pg_type t, 

			pg_namespace n,
			pg_constraint sridcheck, pg_constraint typecheck



		WHERE t.typname = 'geometry'
		AND a.atttypid = t.oid
		AND a.attrelid = c.oid

		AND c.relnamespace = n.oid
		AND sridcheck.connamespace = n.oid
		AND typecheck.connamespace = n.oid
		AND sridcheck.conrelid = c.oid
		AND sridcheck.consrc LIKE '(srid('||a.attname||') = %)'
		AND typecheck.conrelid = c.oid
		AND typecheck.consrc LIKE
	'((geometrytype('||a.attname||') = ''%''::text) OR (% IS NULL))'








                AND NOT EXISTS (
                        SELECT oid FROM geometry_columns gc
                        WHERE c.relname::varchar = gc.f_table_name

                        AND n.nspname::varchar = gc.f_table_schema

                        AND a.attname::varchar = gc.f_geometry_column
                );

	GET DIAGNOSTICS inserted = ROW_COUNT;

	IF oldcount > probed THEN
		stale = oldcount-probed;
	ELSE
		stale = 0;
	END IF;

        RETURN 'probed:'||probed||
		' inserted:'||inserted||
		' conflicts:'||probed-inserted||
		' stale:'||stale;
END

$$;


ALTER FUNCTION public.probe_geometry_columns() OWNER TO postgres;

--
-- TOC entry 296 (class 1255 OID 17221)
-- Name: rename_geometry_table_constraints(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.rename_geometry_table_constraints() RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $$
SELECT 'rename_geometry_table_constraint() is obsoleted'::text
$$;


ALTER FUNCTION public.rename_geometry_table_constraints() OWNER TO postgres;

--
-- TOC entry 297 (class 1255 OID 17222)
-- Name: update_geometry_stats(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_geometry_stats() RETURNS text
    LANGUAGE sql
    AS $$ SELECT 'update_geometry_stats() has been obsoleted. Statistics are automatically built running the ANALYZE command'::text$$;


ALTER FUNCTION public.update_geometry_stats() OWNER TO postgres;

--
-- TOC entry 298 (class 1255 OID 17223)
-- Name: update_geometry_stats(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_geometry_stats(character varying, character varying) RETURNS text
    LANGUAGE sql
    AS $$SELECT update_geometry_stats();$$;


ALTER FUNCTION public.update_geometry_stats(character varying, character varying) OWNER TO postgres;

--
-- TOC entry 299 (class 1255 OID 17224)
-- Name: updategeometrysrid(character varying, character varying, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.updategeometrysrid(character varying, character varying, integer) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
	ret  text;
BEGIN
	SELECT UpdateGeometrySRID('','',$1,$2,$3) into ret;
	RETURN ret;
END;
$_$;


ALTER FUNCTION public.updategeometrysrid(character varying, character varying, integer) OWNER TO postgres;

--
-- TOC entry 300 (class 1255 OID 17225)
-- Name: updategeometrysrid(character varying, character varying, character varying, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.updategeometrysrid(character varying, character varying, character varying, integer) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
	ret  text;
BEGIN
	SELECT UpdateGeometrySRID('',$1,$2,$3,$4) into ret;
	RETURN ret;
END;
$_$;


ALTER FUNCTION public.updategeometrysrid(character varying, character varying, character varying, integer) OWNER TO postgres;

--
-- TOC entry 301 (class 1255 OID 17226)
-- Name: updategeometrysrid(character varying, character varying, character varying, character varying, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.updategeometrysrid(character varying, character varying, character varying, character varying, integer) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
	catalog_name alias for $1; 
	schema_name alias for $2;
	table_name alias for $3;
	column_name alias for $4;
	new_srid alias for $5;
	myrec RECORD;
	okay boolean;
	cname varchar;
	real_schema name;

BEGIN



	-- Find, check or fix schema_name
	IF ( schema_name != '' ) THEN
		okay = 'f';

		FOR myrec IN SELECT nspname FROM pg_namespace WHERE text(nspname) = schema_name LOOP
			okay := 't';
		END LOOP;

		IF ( okay <> 't' ) THEN
			RAISE EXCEPTION 'Invalid schema name';
		ELSE
			real_schema = schema_name;
		END IF;
	ELSE
		SELECT INTO real_schema current_schema()::text;
	END IF;


 	-- Find out if the column is in the geometry_columns table
	okay = 'f';
	FOR myrec IN SELECT * from geometry_columns where f_table_schema = text(real_schema) and f_table_name = table_name and f_geometry_column = column_name LOOP
		okay := 't';
	END LOOP; 
	IF (okay <> 't') THEN 
		RAISE EXCEPTION 'column not found in geometry_columns table';
		RETURN 'f';
	END IF;

	-- Update ref from geometry_columns table
	EXECUTE 'UPDATE geometry_columns SET SRID = ' || new_srid || 
		' where f_table_schema = ' ||
		quote_literal(real_schema) || ' and f_table_name = ' ||
		quote_literal(table_name)  || ' and f_geometry_column = ' ||
		quote_literal(column_name);
	
	-- Make up constraint name
	cname = 'enforce_srid_'  || column_name;

	-- Drop enforce_srid constraint



	EXECUTE 'ALTER TABLE ' || quote_ident(real_schema) ||
		'.' || quote_ident(table_name) ||

		' DROP constraint ' || quote_ident(cname);

	-- Update geometries SRID



	EXECUTE 'UPDATE ' || quote_ident(real_schema) ||
		'.' || quote_ident(table_name) ||

		' SET ' || quote_ident(column_name) ||
		' = setSRID(' || quote_ident(column_name) ||
		', ' || new_srid || ')';

	-- Reset enforce_srid constraint



	EXECUTE 'ALTER TABLE ' || quote_ident(real_schema) ||
		'.' || quote_ident(table_name) ||

		' ADD constraint ' || quote_ident(cname) ||
		' CHECK (srid(' || quote_ident(column_name) ||
		') = ' || new_srid || ')';

	RETURN real_schema || '.' || table_name || '.' || column_name ||' SRID changed to ' || new_srid;
	
END;
$_$;


ALTER FUNCTION public.updategeometrysrid(character varying, character varying, character varying, character varying, integer) OWNER TO postgres;

--
-- TOC entry 1743 (class 2617 OID 17227)
-- Name: &&; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR public.&& (
    FUNCTION = public.cube_overlap,
    LEFTARG = public.cube,
    RIGHTARG = public.cube,
    COMMUTATOR = OPERATOR(public.&&),
    RESTRICT = areasel,
    JOIN = areajoinsel
);


ALTER OPERATOR public.&& (public.cube, public.cube) OWNER TO postgres;

--
-- TOC entry 1744 (class 2617 OID 17230)
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR public.< (
    FUNCTION = public.cube_lt,
    LEFTARG = public.cube,
    RIGHTARG = public.cube,
    COMMUTATOR = OPERATOR(public.>),
    NEGATOR = OPERATOR(public.>=),
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (public.cube, public.cube) OWNER TO postgres;

--
-- TOC entry 1745 (class 2617 OID 17231)
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR public.<= (
    FUNCTION = public.cube_le,
    LEFTARG = public.cube,
    RIGHTARG = public.cube,
    COMMUTATOR = OPERATOR(public.>=),
    NEGATOR = OPERATOR(public.>),
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (public.cube, public.cube) OWNER TO postgres;

--
-- TOC entry 1747 (class 2617 OID 17233)
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR public.<> (
    FUNCTION = public.cube_ne,
    LEFTARG = public.cube,
    RIGHTARG = public.cube,
    COMMUTATOR = OPERATOR(public.<>),
    NEGATOR = OPERATOR(public.=),
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (public.cube, public.cube) OWNER TO postgres;

--
-- TOC entry 1749 (class 2617 OID 17232)
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR public.= (
    FUNCTION = public.cube_eq,
    LEFTARG = public.cube,
    RIGHTARG = public.cube,
    COMMUTATOR = OPERATOR(public.=),
    NEGATOR = OPERATOR(public.<>),
    MERGES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (public.cube, public.cube) OWNER TO postgres;

--
-- TOC entry 1748 (class 2617 OID 17228)
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR public.> (
    FUNCTION = public.cube_gt,
    LEFTARG = public.cube,
    RIGHTARG = public.cube,
    COMMUTATOR = OPERATOR(public.<),
    NEGATOR = OPERATOR(public.<=),
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (public.cube, public.cube) OWNER TO postgres;

--
-- TOC entry 1746 (class 2617 OID 17229)
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR public.>= (
    FUNCTION = public.cube_ge,
    LEFTARG = public.cube,
    RIGHTARG = public.cube,
    COMMUTATOR = OPERATOR(public.<=),
    NEGATOR = OPERATOR(public.<),
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (public.cube, public.cube) OWNER TO postgres;

--
-- TOC entry 1750 (class 2617 OID 17235)
-- Name: @; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR public.@ (
    FUNCTION = public.cube_contains,
    LEFTARG = public.cube,
    RIGHTARG = public.cube,
    COMMUTATOR = OPERATOR(public.~),
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@ (public.cube, public.cube) OWNER TO postgres;

--
-- TOC entry 1751 (class 2617 OID 17234)
-- Name: ~; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR public.~ (
    FUNCTION = public.cube_contained,
    LEFTARG = public.cube,
    RIGHTARG = public.cube,
    COMMUTATOR = OPERATOR(public.@),
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.~ (public.cube, public.cube) OWNER TO postgres;

--
-- TOC entry 2084 (class 2753 OID 17236)
-- Name: cube_ops; Type: OPERATOR FAMILY; Schema: public; Owner: postgres
--

CREATE OPERATOR FAMILY public.cube_ops USING btree;


ALTER OPERATOR FAMILY public.cube_ops USING btree OWNER TO postgres;

--
-- TOC entry 1936 (class 2616 OID 17237)
-- Name: cube_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS public.cube_ops
    DEFAULT FOR TYPE public.cube USING btree FAMILY public.cube_ops AS
    OPERATOR 1 public.<(public.cube,public.cube) ,
    OPERATOR 2 public.<=(public.cube,public.cube) ,
    OPERATOR 3 public.=(public.cube,public.cube) ,
    OPERATOR 4 public.>=(public.cube,public.cube) ,
    OPERATOR 5 public.>(public.cube,public.cube) ,
    FUNCTION 1 (public.cube, public.cube) public.cube_cmp(public.cube,public.cube);


ALTER OPERATOR CLASS public.cube_ops USING btree OWNER TO postgres;

--
-- TOC entry 2085 (class 2753 OID 17244)
-- Name: gist_cube_ops; Type: OPERATOR FAMILY; Schema: public; Owner: postgres
--

CREATE OPERATOR FAMILY public.gist_cube_ops USING gist;
ALTER OPERATOR FAMILY public.gist_cube_ops USING gist ADD
    OPERATOR 3 public.&&(public.cube,public.cube) ,
    OPERATOR 6 public.=(public.cube,public.cube) ,
    OPERATOR 7 public.@(public.cube,public.cube) ,
    OPERATOR 8 public.~(public.cube,public.cube) ,
    FUNCTION 3 (public.cube, public.cube) public.g_cube_compress(internal) ,
    FUNCTION 4 (public.cube, public.cube) public.g_cube_decompress(internal);


ALTER OPERATOR FAMILY public.gist_cube_ops USING gist OWNER TO postgres;

--
-- TOC entry 1937 (class 2616 OID 17245)
-- Name: gist_cube_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS public.gist_cube_ops
    DEFAULT FOR TYPE public.cube USING gist FAMILY public.gist_cube_ops AS
    FUNCTION 1 (public.cube, public.cube) public.g_cube_consistent(internal,public.cube,integer) ,
    FUNCTION 2 (public.cube, public.cube) public.g_cube_union(internal,internal) ,
    FUNCTION 5 (public.cube, public.cube) public.g_cube_penalty(internal,internal,internal) ,
    FUNCTION 6 (public.cube, public.cube) public.g_cube_picksplit(internal,internal) ,
    FUNCTION 7 (public.cube, public.cube) public.g_cube_same(public.cube,public.cube,internal);


ALTER OPERATOR CLASS public.gist_cube_ops USING gist OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 218 (class 1259 OID 17257)
-- Name: cargo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cargo (
    nom_cargo character varying(15) NOT NULL,
    valor_hora smallint NOT NULL
);


ALTER TABLE public.cargo OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17260)
-- Name: profesion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.profesion (
    nom_profesion character varying(20) NOT NULL,
    cd_profesion character varying(3) NOT NULL
);


ALTER TABLE public.profesion OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 17263)
-- Name: profesional; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.profesional (
    rut_prof character varying(10) NOT NULL,
    nom_prof character varying(30) NOT NULL,
    cd_profesion character varying(3) NOT NULL
);


ALTER TABLE public.profesional OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17266)
-- Name: profesional_proyecto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.profesional_proyecto (
    rut_prof character varying(10) NOT NULL,
    id_proyecto smallint NOT NULL,
    nom_cargo character varying(15) NOT NULL,
    nro_horas smallint NOT NULL
);


ALTER TABLE public.profesional_proyecto OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 17269)
-- Name: proyecto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.proyecto (
    id_proyecto smallint NOT NULL,
    fecha date NOT NULL,
    valor_total integer
);


ALTER TABLE public.proyecto OWNER TO postgres;

--
-- TOC entry 4958 (class 0 OID 17257)
-- Dependencies: 218
-- Data for Name: cargo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cargo (nom_cargo, valor_hora) FROM stdin;
Jefe	8000
Analista	5000
Evaluador	3000
Contador	2000
\.


--
-- TOC entry 4959 (class 0 OID 17260)
-- Dependencies: 219
-- Data for Name: profesion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.profesion (nom_profesion, cd_profesion) FROM stdin;
Informatico	001
Industrial	002
Contador	003
Comercial	004
\.


--
-- TOC entry 4960 (class 0 OID 17263)
-- Dependencies: 220
-- Data for Name: profesional; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.profesional (rut_prof, nom_prof, cd_profesion) FROM stdin;
11111	Pedro Pablo	001
22222	Luis gomez	002
33333	Sebastian Comas	001
44444	Maria Nova	003
55555	Silvia Pena	004
66666	Lorena Lillo	003
\.


--
-- TOC entry 4961 (class 0 OID 17266)
-- Dependencies: 221
-- Data for Name: profesional_proyecto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.profesional_proyecto (rut_prof, id_proyecto, nom_cargo, nro_horas) FROM stdin;
11111	1	Jefe	150
44444	2	Evaluador	20
33333	4	Analista	130
22222	1	Analista	100
22222	2	Jefe	300
66666	3	Contador	50
22222	4	Jefe	200
55555	3	Jefe	130
11111	6	Analista	40
44444	6	Jefe	80
33333	6	Analista	50
\.


--
-- TOC entry 4962 (class 0 OID 17269)
-- Dependencies: 222
-- Data for Name: proyecto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.proyecto (id_proyecto, fecha, valor_total) FROM stdin;
1	1999-10-01	\N
2	2000-12-15	\N
3	2004-07-02	\N
4	2006-08-08	\N
5	2008-10-10	\N
6	1997-12-01	\N
\.


--
-- TOC entry 4801 (class 2606 OID 17273)
-- Name: cargo cargo_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cargo
    ADD CONSTRAINT cargo_pk PRIMARY KEY (nom_cargo);


--
-- TOC entry 4808 (class 2606 OID 17275)
-- Name: profesional_proyecto prof_proy_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profesional_proyecto
    ADD CONSTRAINT prof_proy_pk PRIMARY KEY (rut_prof, id_proyecto);


--
-- TOC entry 4803 (class 2606 OID 17277)
-- Name: profesion profesion_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profesion
    ADD CONSTRAINT profesion_pk PRIMARY KEY (cd_profesion);


--
-- TOC entry 4805 (class 2606 OID 17279)
-- Name: profesional profesional_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profesional
    ADD CONSTRAINT profesional_pk PRIMARY KEY (rut_prof);


--
-- TOC entry 4810 (class 2606 OID 17281)
-- Name: proyecto proyecto_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proyecto
    ADD CONSTRAINT proyecto_pk PRIMARY KEY (id_proyecto);


--
-- TOC entry 4806 (class 1259 OID 17282)
-- Name: fki_prof_proy_cargo_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_prof_proy_cargo_fk ON public.profesional_proyecto USING btree (nom_cargo);


--
-- TOC entry 4811 (class 2606 OID 17283)
-- Name: profesional profesional_profesion_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profesional
    ADD CONSTRAINT profesional_profesion_fk FOREIGN KEY (cd_profesion) REFERENCES public.profesion(cd_profesion);


--
-- TOC entry 4812 (class 2606 OID 17288)
-- Name: profesional_proyecto profesional_proyecto_cargo_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profesional_proyecto
    ADD CONSTRAINT profesional_proyecto_cargo_fk FOREIGN KEY (nom_cargo) REFERENCES public.cargo(nom_cargo);


--
-- TOC entry 4813 (class 2606 OID 17293)
-- Name: profesional_proyecto profesional_proyecto_prof_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profesional_proyecto
    ADD CONSTRAINT profesional_proyecto_prof_fk FOREIGN KEY (rut_prof) REFERENCES public.profesional(rut_prof);


--
-- TOC entry 4814 (class 2606 OID 17298)
-- Name: profesional_proyecto profesional_proyecto_proy_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profesional_proyecto
    ADD CONSTRAINT profesional_proyecto_proy_fk FOREIGN KEY (id_proyecto) REFERENCES public.proyecto(id_proyecto);


-- Completed on 2024-10-12 18:17:57

--
-- PostgreSQL database dump complete
--

