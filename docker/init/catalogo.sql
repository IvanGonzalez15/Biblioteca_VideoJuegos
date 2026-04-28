--
-- PostgreSQL database cluster dump
--

\restrict KhzH5veIOBg4AGprGWhPb6wvcIBO0Th5LgpcoQrzFREOKtXPgb1i5qiPhdm3kcn

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

-- Bloque para admin
DO $$ 
BEGIN
  IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'admin') THEN
    CREATE ROLE admin;
  END IF;
END
$$;
ALTER ROLE admin WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;

-- Bloque para admin1
DO $$ 
BEGIN
  IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'admin1') THEN
    CREATE ROLE admin1;
  END IF;
END
$$;
ALTER ROLE admin1 WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:JvP8CvbgmWzOMCHxQpSBAA==$VdadDKZNJ2v2Gm8NdZbsrKyityF1OJGRqM/V7fs19C0=:AeWwQOT9+6ui3sI3aIUnRk0M0aN4xRC10GO6gEmLrYc=';

-- Bloque para common_user
DO $$ 
BEGIN
  IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'common_user') THEN
    CREATE ROLE common_user;
  END IF;
END
$$;
ALTER ROLE common_user WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:FMupDUYG2m9BNXrAc5KxnA==$H/pvomsOq6Df4V4RO7FOeyAKFC/Nrq52WTsrvcet65U=:MLGDNTj1D8HCL+fHjclqT3yL59PyHpzCqEiKSxxibMo=';

-- Bloque para grupo_user
DO $$ 
BEGIN
  IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'grupo_user') THEN
    CREATE ROLE grupo_user;
  END IF;
END
$$;
ALTER ROLE grupo_user WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;

-- Rol postgres ya existe en imagen oficial de Docker.

--
-- User Configurations
--


--
-- Role memberships
--

GRANT admin TO admin1 WITH INHERIT TRUE GRANTED BY postgres;
GRANT grupo_user TO common_user WITH INHERIT TRUE GRANTED BY postgres;






\unrestrict KhzH5veIOBg4AGprGWhPb6wvcIBO0Th5LgpcoQrzFREOKtXPgb1i5qiPhdm3kcn

--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

\restrict gua4oOJO8CnKsuou4f3nqi3vus3WIaG32buajFLiKreyB0D2NQQXVz3fqvolCsP

-- Dumped from database version 17.9
-- Dumped by pg_dump version 17.9

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- PostgreSQL database dump complete
--

\unrestrict gua4oOJO8CnKsuou4f3nqi3vus3WIaG32buajFLiKreyB0D2NQQXVz3fqvolCsP

--
-- Database "bibliojuegos" dump
--

--
-- PostgreSQL database dump
--

\restrict cdWfTq63dsmE1YN6cUFohy5Q1qmJhs3vuNdDOpifB6qUIhdc1QHlHKikPihcbrY

-- Dumped from database version 17.9
-- Dumped by pg_dump version 17.9

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: bibliojuegos; Type: DATABASE; Schema: -; Owner: postgres
--
DROP DATABASE IF EXISTS bibliojuegos;
CREATE DATABASE bibliojuegos WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'es_ES.UTF-8';


ALTER DATABASE bibliojuegos OWNER TO postgres;

\unrestrict cdWfTq63dsmE1YN6cUFohy5Q1qmJhs3vuNdDOpifB6qUIhdc1QHlHKikPihcbrY
\connect bibliojuegos
\restrict cdWfTq63dsmE1YN6cUFohy5Q1qmJhs3vuNdDOpifB6qUIhdc1QHlHKikPihcbrY

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- Name: developer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.developer (
    id integer NOT NULL,
    name character varying(100) NOT NULL UNIQUE,
    description character varying(250) NOT NULL,
    year_fundation integer NOT NULL,
    country character varying(100) NOT NULL
);


ALTER TABLE public.developer OWNER TO postgres;

--
-- Name: getdevelopers(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getdevelopers() RETURNS SETOF public.developer
    LANGUAGE plpgsql
    AS $$ BEGIN RETURN QUERY SELECT * FROM developer; END; $$;


ALTER FUNCTION public.getdevelopers() OWNER TO postgres;

--
-- Name: genre; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.genre (
    id integer NOT NULL,
    name character varying(100) NOT NULL UNIQUE
);


ALTER TABLE public.genre OWNER TO postgres;

--
-- Name: getgenres(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getgenres() RETURNS SETOF public.genre
    LANGUAGE plpgsql
    AS $$BEGIN RETURN QUERY SELECT * FROM genre; END; $$;


ALTER FUNCTION public.getgenres() OWNER TO postgres;

--
-- Name: videogame; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.videogame (
    id integer NOT NULL,
    name character varying(100) NOT NULL UNIQUE,
    description character varying(250) NOT NULL,
    duration integer NOT NULL,
    release_date date NOT NULL,
    price real NOT NULL,
    genre_id integer NOT NULL,
    developer_id integer NOT NULL,
    valoration integer NOT NULL,
    image text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.videogame OWNER TO postgres;

--
-- Name: getvideogames(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getvideogames() RETURNS SETOF public.videogame
    LANGUAGE plpgsql
    AS $$ BEGIN RETURN QUERY SELECT * FROM videogame; END; $$;


ALTER FUNCTION public.getvideogames() OWNER TO postgres;

-- Nueva función con JOIN para devolver datos completos sin necesidad de enriquecer en JS
CREATE FUNCTION public.getvideogames_completo()
RETURNS TABLE (
    id integer,
    name varchar(100),
    description varchar(250),
    genre varchar(50),
    developer varchar(100),
    image text,
    release_date date
)
AS $$
BEGIN
    RETURN QUERY
    SELECT v.id, v.name, v.description, g.name, d.name, v.image, v.release_date
    FROM videogame v
    JOIN genre g ON v.genre_id = g.id
    JOIN developer d ON v.developer_id = d.id;
END;
$$ LANGUAGE plpgsql;

--
-- Name: insert_videogame(character varying, character varying, integer, date, real, integer, integer, integer, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.insert_videogame(nombre character varying, descripcion character varying, duracion integer, fecha_salida date, precio real, id_genero integer, id_developer integer, valoracion integer, imagen text) RETURNS void
    LANGUAGE plpgsql
    AS $$ BEGIN INSERT INTO videogame(name, description, duration, release_date, price, genre_id, developer_id, valoration, image) VALUES(nombre, descripcion, duracion, fecha_salida, precio, id_genero, id_developer, valoracion, imagen); END; $$;


ALTER FUNCTION public.insert_videogame(nombre character varying, descripcion character varying, duracion integer, fecha_salida date, precio real, id_genero integer, id_developer integer, valoracion integer, imagen text) OWNER TO admin1;

--
-- Name: set_timestamp(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.set_timestamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ BEGIN
NEW.created_at = CURRENT_TIMESTAMP; RETURN NEW; END; $$;


ALTER FUNCTION public.set_timestamp() OWNER TO postgres;

--
-- Name: developer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.developer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.developer_id_seq OWNER TO postgres;

--
-- Name: developer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.developer_id_seq OWNED BY public.developer.id;


--
-- Name: genre_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.genre_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.genre_id_seq OWNER TO postgres;

--
-- Name: genre_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.genre_id_seq OWNED BY public.genre.id;


--
-- Name: videogame_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.videogame_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.videogame_id_seq OWNER TO postgres;

--
-- Name: videogame_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.videogame_id_seq OWNED BY public.videogame.id;


--
-- Name: developer id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.developer ALTER COLUMN id SET DEFAULT nextval('public.developer_id_seq'::regclass);


--
-- Name: genre id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genre ALTER COLUMN id SET DEFAULT nextval('public.genre_id_seq'::regclass);


--
-- Name: videogame id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.videogame ALTER COLUMN id SET DEFAULT nextval('public.videogame_id_seq'::regclass);


--
-- Data for Name: developer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.developer (id, name, description, year_fundation, country) FROM stdin;
1	Nintendo	Nintendo es una empresa japonesa de videojuegos, creadora de consolas innovadoras y franquicias iconicas que influyen en la industria global.	1889	Japon
2	Rockstar Games	Empresa desarrolladora de videojuegos conocida por mundos abiertos inmersivos, narrativa adulta, franquicias como Grand Theft Auto y Red Dead Redemption.	1998	EEUU
3	Activision Blizzard	Gigante del entretenimiento interactivo que publica y desarrolla exitosos globales como Call of Duty, Warcraft, Overwatch, con enfoque comercial masivo.	2008	EEUU
4	Capcom	Compania japonesa famosa por sagas iconicas como Resident Evil, Street Fighter y Monster Hunter, destacando jugabilidad pulida y diseno creativo.	1979	Japon
5	Ubisoft	Empresa francesa que crea experiencias de mundo abierto como Assassins Creed, Far Cry y Rainbow Six, combinando historia, accion y exploracion.	1986	Francia
6	Epic Games	Desarrollador estadounidense detras de Fortnite y Unreal Engine, influyente en distribucion digital, tecnologia grafica y modelos de negocio innovadores modernos.	1991	EEUU
7	Obsidian Entertainment	Estudio de videojuegos de rol como Fallout New Vegas y Pillars of Eternity, centrado en narrativa y decisiones del jugador.	2003	EEUU
8	Larian Studios	Estudio independiente belga aclamado por juegos de rol complejos como Divinity Original Sin y Baldurs Gate 3, destacando libertad y sistemas profundos.	1996	Belgica
9	Sega	Compania historica japonesa creadora de Sonic, con legado en consolas y recreativas, enfocada en software, franquicias variadas y mercados globales.	1960	Japon
10	Electronic Arts	Editora de videojuegos deportivos y de accion como FIFA, Madden y Battlefield, conocida por modelos de servicio y monetizacion continua.	1982	EEUU
\.


--
-- Data for Name: genre; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.genre (id, name) FROM stdin;
1	Accion
2	Aventura
3	Terror
4	RPG
5	Shooter
6	Mundo abierto
7	Supervivencia
8	Estrategia
9	MMORPG
10	Deportes
11	Simulacion
12	Musica
13	Battle Royale
14	Indie
15	Carreras
16	Roguelike
17	JRPG
18	Gestion
19	Anime
20	Visual novel
21	Pelea
\.


--
-- Data for Name: videogame; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.videogame (id, name, description, duration, release_date, price, genre_id, developer_id, valoration, image, created_at) FROM stdin;
61	The Legend of Zelda: Breath of the Wild	Exploracion de un vasto reino destruido con secretos, libertad y misterios antiguos por descubrir.	60	2017-03-03	59.99	2	1	10	https://media.rawg.io/media/resize/1280/-/games/cc1/cc196a5ad763955d6532cdba236f730c.jpg	2026-04-25 21:28:25.402012
62	Super Mario Odyssey	Viaje por distintos mundos acompaâ”¬Ã±ando a Mario en una mision para rescatar a Peach.	12	2017-10-27	59.99	2	1	10	https://media.rawg.io/media/resize/1280/-/games/267/267bd0dbc496f52692487d07d014c061.jpg	2026-04-25 21:28:25.402012
63	Mario Kart 8 Deluxe	Competiciones llenas de velocidad con personajes iconicos en circuitos llenos de sorpresas.	20	2017-04-28	49.99	15	1	9	https://media.rawg.io/media/resize/640/-/games/7df/7dfbdcb58a03fcddc68479454fc1f7de.jpg	2026-04-25 21:28:25.402012
64	Grand Theft Auto V	Historia entrelazada de tres personajes en una ciudad llena de crimen y ambicion.	50	2013-09-17	29.99	6	2	10	https://media.rawg.io/media/resize/640/-/games/734/7342a1cd82c8997ec620084ae4c2e7e4.jpg	2026-04-25 21:28:25.402012
65	Red Dead Redemption 2	Relato de forajidos en decadencia enfrentando cambios del viejo oeste americano.	70	2018-10-26	59.99	6	2	10	https://media.rawg.io/media/resize/1280/-/games/511/5118aff5091cb3efec399c808f8c598f.jpg	2026-04-25 21:28:25.402012
66	Bully	Vida de un estudiante en una escuela conflictiva llena de retos y situaciones sociales.	15	2006-10-17	14.99	2	2	9	https://media.rawg.io/media/resize/640/-/games/5bc/5bcfcafffbd3085c62cc712b5b5f4b88.jpg	2026-04-25 21:28:25.402012
67	Call of Duty: Modern Warfare	Operaciones militares modernas con conflictos globales y personajes en situaciones extremas.	8	2019-10-25	59.99	5	3	9	https://media.rawg.io/media/resize/640/-/games/509/509c81a5da92a8d0645d9e160d155017.jpg	2026-04-25 21:28:25.402012
68	Overwatch	Heroes diversos luchando juntos para restaurar la paz en un futuro conflictivo.	10	2016-05-24	39.99	5	3	9	https://media.rawg.io/media/resize/1280/-/games/4ea/4ea507ceebeabb43edbc09468f5aaac6.jpg	2026-04-25 21:28:25.402012
69	Diablo III	Fuerzas demoniacas amenazan un mundo oscuro lleno de caos y desesperacion constante.	40	2012-05-15	19.99	4	3	9	https://media.rawg.io/media/resize/640/-/games/b89/b898b8342f4f74deac820e469c9aee22.jpg	2026-04-25 21:28:25.402012
70	Resident Evil 4	Rescate en un pueblo remoto lleno de peligros y amenazas desconocidas constantes.	16	2005-01-11	19.99	3	4	10	https://media.rawg.io/media/resize/1280/-/games/fee/fee0100afd87b52bfbd33e26689fa26c.jpg	2026-04-25 21:28:25.402012
71	Monster Hunter: World	Caza de criaturas gigantes en entornos salvajes llenos de ecosistemas vivos.	100	2018-01-26	29.99	6	4	9	https://media.rawg.io/media/resize/1280/-/games/21c/21cc15d233117c6809ec86870559e105.jpg	2026-04-25 21:28:25.402012
72	Street Fighter V	Combates entre luchadores con estilos unicos en torneos globales intensos.	10	2016-02-16	19.99	21	4	8	https://media.rawg.io/media/resize/1280/-/games/a32/a32c9c299488ca99afc3fcea605a7718.jpg	2026-04-25 21:28:25.402012
73	Assassins Creed II	Historia de venganza ambientada en ciudades historicas del Renacimiento italiano.	20	2009-11-17	9.99	2	5	9	https://media.rawg.io/media/resize/1280/-/games/1be/1bed7fae69d1004c09dfe1101d5a3a94.jpg	2026-04-25 21:28:25.402012
74	Far Cry 5	Enfrentamiento contra una secta en una region rural con conflictos armados.	25	2018-03-27	59.99	6	5	9	https://media.rawg.io/media/resize/1280/-/games/bce/bce62fbc7cf74bf6a1a37340993ec148.jpg	2026-04-25 21:28:25.402012
75	Tom Clancys Rainbow Six Siege	Operaciones tacticas en escenarios cerrados con equipos especializados enfrentandose.	0	2015-12-01	19.99	5	5	9	https://media.rawg.io/media/resize/1280/-/games/b34/b3419c2706f8f8dbe40d08e23642ad06.jpg	2026-04-25 21:28:25.402012
76	Fortnite	Supervivencia masiva en una isla donde solo uno puede quedar victorioso.	0	2017-07-25	0	13	6	9	https://media.rawg.io/media/resize/1280/-/games/dcb/dcbb67f371a9a28ea38ffd73ee0f53f3.jpg	2026-04-25 21:28:25.402012
77	Gears of War	Humanidad luchando contra amenazas subterraneas en guerras desesperadas.	10	2006-11-07	19.99	5	6	9	https://media.rawg.io/media/resize/640/-/games/988/98834d39955e7f15d3717fac438128aa.jpg	2026-04-25 21:28:25.402012
78	Infinity Blade	Guerreros enfrentan un destino marcado por batallas contra poderosos enemigos.	5	2010-12-09	2.99	4	6	8	https://media.rawg.io/media/resize/640/-/screenshots/113/113a889bef38fee1675c6b435da003e6.jpg	2026-04-25 21:28:25.402012
79	Fallout: New Vegas	Supervivencia en un desierto devastado tras una guerra nuclear global.	60	2010-10-19	9.99	4	7	9	https://media.rawg.io/media/resize/1280/-/games/995/9951d9d55323d08967640f7b9ab3e342.jpg	2026-04-25 21:28:25.402012
80	The Outer Worlds	Colonias espaciales controladas por corporaciones en conflicto constante.	25	2019-10-25	29.99	4	7	9	https://media.rawg.io/media/resize/1280/-/games/704/704f831d2d132e9614931f1c4eab9e86.jpg	2026-04-25 21:28:25.402012
81	Pillars of Eternity	Reinos antiguos marcados por magia, conflictos y almas perdidas.	70	2015-03-26	29.99	4	7	9	https://media.rawg.io/media/resize/1280/-/games/789/7896837ec22a83e4007018ddd55e8c9a.jpg	2026-04-25 21:28:25.402012
82	Baldurs Gate 3	Destino de un grupo marcado por fuerzas oscuras y decisiones criticas.	100	2023-08-03	59.99	4	8	10	https://media.rawg.io/media/resize/1280/-/games/699/69907ecf13f172e9e144069769c3be73.jpg	2026-04-25 21:28:25.402012
83	Divinity: Original Sin	Dos aventureros investigan misterios magicos en un mundo cambiante.	80	2014-06-30	39.99	4	8	9	https://media.rawg.io/media/resize/1280/-/games/963/9639183ff27251b0b686acaa6aac0297.jpg	2026-04-25 21:28:25.402012
84	Divinity II: Ego Draconis	Un guerrero descubre su vinculo con dragones en un mundo dividido.	40	2009-08-21	19.99	4	8	8	https://media.rawg.io/media/resize/640/-/games/334/3342ccbbdc6b705825d8fb8e3ca12c97.jpg	2026-04-25 21:28:25.402012
85	Sonic the Hedgehog	Un erizo azul enfrenta al Dr Robotnik en multiples escenarios coloridos.	6	1991-06-23	9.99	2	9	9	https://media.rawg.io/media/resize/640/-/games/373/373a9a1f664de6e4c31f08644729e2db.jpg	2026-04-25 21:28:25.402012
86	Yakuza 0	Historias criminales entre clanes en una ciudad japonesa vibrante.	50	2015-03-12	19.99	6	9	9	https://media.rawg.io/media/resize/1280/-/games/ca1/ca16da30f86d8f4d36261de45fb35430.jpg	2026-04-25 21:28:25.402012
87	Phantasy Star Online 2	Exploracion espacial con misiones en mundos futuristas llenos de tecnologia.	0	2012-07-04	0	9	9	8	https://media.rawg.io/media/resize/420/-/screenshots/296/2960740723535b92b150d7c528b6c661.jpg	2026-04-25 21:28:25.402012
88	FIFA 23	Simulacion de competiciones internacionales con equipos reales y jugadores famosos.	0	2022-09-30	59.99	10	10	9	https://media.rawg.io/media/resize/640/-/games/dbc/dbcb05bcdf104264db35de68d1e73909.jpg	2026-04-25 21:28:25.402012
89	Battlefield 1	Conflictos historicos a gran escala con batallas intensas entre ejercitos.	12	2016-10-21	19.99	5	10	9	https://media.rawg.io/media/resize/1280/-/games/998/9980c4296f311d8bcc5b451ca51e4fe1.jpg	2026-04-25 21:28:25.402012
90	The Sims 4	Simulacion de vida cotidiana donde personajes desarrollan historias personales.	0	2014-09-02	19.99	11	10	9	https://media.rawg.io/media/resize/1280/-/games/e44/e445335e611b4ccf03af71fffcbd30a4.jpg	2026-04-25 21:28:25.402012
\.


--
-- Name: developer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.developer_id_seq', 10, true);


--
-- Name: genre_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.genre_id_seq', 21, true);


--
-- Name: videogame_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.videogame_id_seq', 90, true);


--
-- Name: developer developer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.developer
    ADD CONSTRAINT developer_pkey PRIMARY KEY (id);


--
-- Name: genre genre_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genre
    ADD CONSTRAINT genre_pkey PRIMARY KEY (id);


--
-- Name: videogame videogame_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.videogame
    ADD CONSTRAINT videogame_pkey PRIMARY KEY (id);


--
-- Name: videogame insert_videogame; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER insert_videogame BEFORE INSERT ON public.videogame FOR EACH ROW EXECUTE FUNCTION public.set_timestamp();


--
-- Name: videogame fk_developer_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.videogame
    ADD CONSTRAINT fk_developer_id FOREIGN KEY (developer_id) REFERENCES public.developer(id);


--
-- Name: videogame fk_genre_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.videogame
    ADD CONSTRAINT fk_genre_id FOREIGN KEY (genre_id) REFERENCES public.genre(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO grupo_user;


--
-- Name: TABLE developer; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.developer TO grupo_user;
GRANT ALL ON TABLE public.developer TO admin;


--
-- Name: TABLE genre; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.genre TO grupo_user;
GRANT ALL ON TABLE public.genre TO admin;


--
-- Name: TABLE videogame; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.videogame TO grupo_user;
GRANT ALL ON TABLE public.videogame TO admin;


--
-- Name: SEQUENCE developer_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.developer_id_seq TO admin;


--
-- Name: SEQUENCE genre_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.genre_id_seq TO admin;


--
-- Name: SEQUENCE videogame_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.videogame_id_seq TO admin;


--
-- PostgreSQL database dump complete
--

\unrestrict cdWfTq63dsmE1YN6cUFohy5Q1qmJhs3vuNdDOpifB6qUIhdc1QHlHKikPihcbrY

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

\restrict 0Wa4v1TWi3JAapoaWb3AElgkWiDueShaW1XkDHBs49PqiocJwO3KrMVJZSwXVLY

-- Dumped from database version 17.9
-- Dumped by pg_dump version 17.9

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- PostgreSQL database dump complete
--

\unrestrict 0Wa4v1TWi3JAapoaWb3AElgkWiDueShaW1XkDHBs49PqiocJwO3KrMVJZSwXVLY

--
-- PostgreSQL database cluster dump complete
--


