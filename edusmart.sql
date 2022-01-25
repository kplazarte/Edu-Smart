--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1
-- Dumped by pg_dump version 14.1

-- Started on 2022-01-22 17:09:17

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
-- TOC entry 209 (class 1259 OID 16395)
-- Name: datos_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datos_user (
    id_usuario integer NOT NULL,
    id_nivel integer NOT NULL,
    contestadas integer NOT NULL,
    aciertos integer NOT NULL,
    errores integer NOT NULL
);


ALTER TABLE public.datos_user OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16398)
-- Name: genero; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.genero (
    id_gen integer NOT NULL,
    nom_gen character varying(50) NOT NULL
);


ALTER TABLE public.genero OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16401)
-- Name: genero_id_gen_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.genero_id_gen_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.genero_id_gen_seq OWNER TO postgres;

--
-- TOC entry 3374 (class 0 OID 0)
-- Dependencies: 211
-- Name: genero_id_gen_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.genero_id_gen_seq OWNED BY public.genero.id_gen;


--
-- TOC entry 212 (class 1259 OID 16402)
-- Name: niveles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.niveles (
    id_nivel integer NOT NULL,
    nivel character varying(20) NOT NULL
);


ALTER TABLE public.niveles OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16405)
-- Name: niveles_id_nivel_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.niveles_id_nivel_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.niveles_id_nivel_seq OWNER TO postgres;

--
-- TOC entry 3375 (class 0 OID 0)
-- Dependencies: 213
-- Name: niveles_id_nivel_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.niveles_id_nivel_seq OWNED BY public.niveles.id_nivel;


--
-- TOC entry 214 (class 1259 OID 16406)
-- Name: q_comp; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.q_comp (
    id_pregunta integer NOT NULL,
    audio character varying(500) NOT NULL,
    op1 character varying(500) NOT NULL,
    op2 character varying(500) NOT NULL,
    op3 character varying(500) NOT NULL,
    op4 character varying(500) NOT NULL,
    answer character varying(100) NOT NULL,
    id_nivel integer NOT NULL,
    contestada boolean NOT NULL
);


ALTER TABLE public.q_comp OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16411)
-- Name: q_comp_id_pregunta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.q_comp_id_pregunta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.q_comp_id_pregunta_seq OWNER TO postgres;

--
-- TOC entry 3376 (class 0 OID 0)
-- Dependencies: 215
-- Name: q_comp_id_pregunta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.q_comp_id_pregunta_seq OWNED BY public.q_comp.id_pregunta;


--
-- TOC entry 216 (class 1259 OID 16412)
-- Name: q_escribir; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.q_escribir (
    id_pregunta integer NOT NULL,
    id_nivel integer NOT NULL,
    imagen character varying(500) NOT NULL,
    answer character varying(400) NOT NULL,
    answer2 character varying(100) NOT NULL,
    contestada boolean NOT NULL
);


ALTER TABLE public.q_escribir OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16417)
-- Name: q_escribir_id_pregunta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.q_escribir_id_pregunta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.q_escribir_id_pregunta_seq OWNER TO postgres;

--
-- TOC entry 3377 (class 0 OID 0)
-- Dependencies: 217
-- Name: q_escribir_id_pregunta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.q_escribir_id_pregunta_seq OWNED BY public.q_escribir.id_pregunta;


--
-- TOC entry 218 (class 1259 OID 16418)
-- Name: q_leer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.q_leer (
    id_pregunta integer NOT NULL,
    id_nivel integer NOT NULL,
    palabra character varying(500) NOT NULL,
    op1 character varying(500) NOT NULL,
    op2 character varying(500) NOT NULL,
    op3 character varying(500) NOT NULL,
    op4 character varying(500) NOT NULL,
    answer character varying(100) NOT NULL,
    contestada boolean NOT NULL
);


ALTER TABLE public.q_leer OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16423)
-- Name: q_leer_id_pregunta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.q_leer_id_pregunta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.q_leer_id_pregunta_seq OWNER TO postgres;

--
-- TOC entry 3378 (class 0 OID 0)
-- Dependencies: 219
-- Name: q_leer_id_pregunta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.q_leer_id_pregunta_seq OWNED BY public.q_leer.id_pregunta;


--
-- TOC entry 220 (class 1259 OID 16424)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario (
    id_usuario integer NOT NULL,
    nombre_padre character varying(200) NOT NULL,
    nombre_hijo character varying(200) NOT NULL,
    nacimiento date NOT NULL,
    id_gen integer NOT NULL,
    usuario character varying(50) NOT NULL,
    password character varying(100) NOT NULL
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16429)
-- Name: usuario_id_usuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuario_id_usuario_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usuario_id_usuario_seq OWNER TO postgres;

--
-- TOC entry 3379 (class 0 OID 0)
-- Dependencies: 221
-- Name: usuario_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuario_id_usuario_seq OWNED BY public.usuario.id_usuario;


--
-- TOC entry 3193 (class 2604 OID 16430)
-- Name: genero id_gen; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genero ALTER COLUMN id_gen SET DEFAULT nextval('public.genero_id_gen_seq'::regclass);


--
-- TOC entry 3194 (class 2604 OID 16431)
-- Name: niveles id_nivel; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.niveles ALTER COLUMN id_nivel SET DEFAULT nextval('public.niveles_id_nivel_seq'::regclass);


--
-- TOC entry 3195 (class 2604 OID 16432)
-- Name: q_comp id_pregunta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.q_comp ALTER COLUMN id_pregunta SET DEFAULT nextval('public.q_comp_id_pregunta_seq'::regclass);


--
-- TOC entry 3196 (class 2604 OID 16433)
-- Name: q_escribir id_pregunta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.q_escribir ALTER COLUMN id_pregunta SET DEFAULT nextval('public.q_escribir_id_pregunta_seq'::regclass);


--
-- TOC entry 3197 (class 2604 OID 16434)
-- Name: q_leer id_pregunta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.q_leer ALTER COLUMN id_pregunta SET DEFAULT nextval('public.q_leer_id_pregunta_seq'::regclass);


--
-- TOC entry 3198 (class 2604 OID 16435)
-- Name: usuario id_usuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario ALTER COLUMN id_usuario SET DEFAULT nextval('public.usuario_id_usuario_seq'::regclass);


--
-- TOC entry 3356 (class 0 OID 16395)
-- Dependencies: 209
-- Data for Name: datos_user; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3357 (class 0 OID 16398)
-- Dependencies: 210
-- Data for Name: genero; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.genero VALUES (1, 'Masculino');
INSERT INTO public.genero VALUES (2, 'Femenino');
INSERT INTO public.genero VALUES (3, 'Otro');


--
-- TOC entry 3359 (class 0 OID 16402)
-- Dependencies: 212
-- Data for Name: niveles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.niveles VALUES (1, 'Nivel 1');
INSERT INTO public.niveles VALUES (2, 'Nivel 2');
INSERT INTO public.niveles VALUES (3, 'Nivel 3');
INSERT INTO public.niveles VALUES (4, 'Nivel 4');
INSERT INTO public.niveles VALUES (5, 'Nivel 5');


--
-- TOC entry 3361 (class 0 OID 16406)
-- Dependencies: 214
-- Data for Name: q_comp; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3363 (class 0 OID 16412)
-- Dependencies: 216
-- Data for Name: q_escribir; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3365 (class 0 OID 16418)
-- Dependencies: 218
-- Data for Name: q_leer; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3367 (class 0 OID 16424)
-- Dependencies: 220
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.usuario VALUES (1, 'Daniel Ripalda', 'Alex', '2017-12-19', 1, 'alexrolo', 'daniedu0809');
INSERT INTO public.usuario VALUES (2, 'Juan Moya', 'Luis', '2015-10-14', 1, 'eduluis', 'juano123');
INSERT INTO public.usuario VALUES (3, 'Mishelle Flores', 'Amelia', '2015-05-25', 2, 'amyflores', 'mfl123');
INSERT INTO public.usuario VALUES (43, 'Jefry Navas', 'Isaac Live', '2017-12-28', 1, 'jefry6@outlook.com', '123');
INSERT INTO public.usuario VALUES (56, 'qwe', 'qwe', '2022-01-22', 2, 'asd@qwe.asdas', '123');


--
-- TOC entry 3380 (class 0 OID 0)
-- Dependencies: 211
-- Name: genero_id_gen_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.genero_id_gen_seq', 3, true);


--
-- TOC entry 3381 (class 0 OID 0)
-- Dependencies: 213
-- Name: niveles_id_nivel_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.niveles_id_nivel_seq', 5, true);


--
-- TOC entry 3382 (class 0 OID 0)
-- Dependencies: 215
-- Name: q_comp_id_pregunta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.q_comp_id_pregunta_seq', 1, false);


--
-- TOC entry 3383 (class 0 OID 0)
-- Dependencies: 217
-- Name: q_escribir_id_pregunta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.q_escribir_id_pregunta_seq', 1, false);


--
-- TOC entry 3384 (class 0 OID 0)
-- Dependencies: 219
-- Name: q_leer_id_pregunta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.q_leer_id_pregunta_seq', 1, false);


--
-- TOC entry 3385 (class 0 OID 0)
-- Dependencies: 221
-- Name: usuario_id_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuario_id_usuario_seq', 56, true);


--
-- TOC entry 3200 (class 2606 OID 16437)
-- Name: genero genero_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genero
    ADD CONSTRAINT genero_pk PRIMARY KEY (id_gen);


--
-- TOC entry 3202 (class 2606 OID 16439)
-- Name: niveles niveles_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.niveles
    ADD CONSTRAINT niveles_pk PRIMARY KEY (id_nivel);


--
-- TOC entry 3204 (class 2606 OID 16441)
-- Name: q_comp q_comp_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.q_comp
    ADD CONSTRAINT q_comp_pk PRIMARY KEY (id_pregunta);


--
-- TOC entry 3206 (class 2606 OID 16443)
-- Name: q_escribir q_escribir_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.q_escribir
    ADD CONSTRAINT q_escribir_pk PRIMARY KEY (id_pregunta);


--
-- TOC entry 3208 (class 2606 OID 16445)
-- Name: q_leer q_leer_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.q_leer
    ADD CONSTRAINT q_leer_pk PRIMARY KEY (id_pregunta);


--
-- TOC entry 3210 (class 2606 OID 16447)
-- Name: usuario usuario_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pk PRIMARY KEY (id_usuario);


--
-- TOC entry 3216 (class 2606 OID 16448)
-- Name: usuario genero_usuario_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT genero_usuario_fk FOREIGN KEY (id_gen) REFERENCES public.genero(id_gen);


--
-- TOC entry 3211 (class 2606 OID 16453)
-- Name: datos_user niveles_datos_user_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datos_user
    ADD CONSTRAINT niveles_datos_user_fk FOREIGN KEY (id_nivel) REFERENCES public.niveles(id_nivel);


--
-- TOC entry 3215 (class 2606 OID 16458)
-- Name: q_leer niveles_preguntas_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.q_leer
    ADD CONSTRAINT niveles_preguntas_fk FOREIGN KEY (id_nivel) REFERENCES public.niveles(id_nivel);


--
-- TOC entry 3213 (class 2606 OID 16463)
-- Name: q_comp niveles_q_comp_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.q_comp
    ADD CONSTRAINT niveles_q_comp_fk FOREIGN KEY (id_nivel) REFERENCES public.niveles(id_nivel);


--
-- TOC entry 3214 (class 2606 OID 16468)
-- Name: q_escribir niveles_q_escribir_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.q_escribir
    ADD CONSTRAINT niveles_q_escribir_fk FOREIGN KEY (id_nivel) REFERENCES public.niveles(id_nivel);


--
-- TOC entry 3212 (class 2606 OID 16473)
-- Name: datos_user usuario_datos_user_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datos_user
    ADD CONSTRAINT usuario_datos_user_fk FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);


-- Completed on 2022-01-22 17:09:17

--
-- PostgreSQL database dump complete
--

