--
-- PostgreSQL database cluster dump
--

\restrict 6KpWW1Sf06g8wLyKxtyQKdZQHVgqdm6HpgsGx8ubAm8PIRxb9qKOFnkAa4jsevY

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE admin;
ALTER ROLE admin WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE admin1;
ALTER ROLE admin1 WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:JvP8CvbgmWzOMCHxQpSBAA==$VdadDKZNJ2v2Gm8NdZbsrKyityF1OJGRqM/V7fs19C0=:AeWwQOT9+6ui3sI3aIUnRk0M0aN4xRC10GO6gEmLrYc=';
CREATE ROLE common_user;
ALTER ROLE common_user WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:FMupDUYG2m9BNXrAc5KxnA==$H/pvomsOq6Df4V4RO7FOeyAKFC/Nrq52WTsrvcet65U=:MLGDNTj1D8HCL+fHjclqT3yL59PyHpzCqEiKSxxibMo=';
CREATE ROLE grupo_user;
ALTER ROLE grupo_user WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:qwlVG5cWhHP964uRUbO6AA==$cqJboFiM0aE/Q4NWj+ERkErK/t1p3EAFLhAljrkbqJA=:K+gTQSj3Jm/xiqMkG3b0uOHfMJnuYd3+Gl8LQPdktG8=';

--
-- User Configurations
--


--
-- Role memberships
--

GRANT admin TO admin1 WITH INHERIT TRUE GRANTED BY postgres;
GRANT grupo_user TO common_user WITH INHERIT TRUE GRANTED BY postgres;






\unrestrict 6KpWW1Sf06g8wLyKxtyQKdZQHVgqdm6HpgsGx8ubAm8PIRxb9qKOFnkAa4jsevY

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

\restrict E3clYeBfHW6jENbGqVNHAEYbhYjoyYGPRnz8ldfPJRal0Ok2CgO7cRTe2g5WR65

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

\unrestrict E3clYeBfHW6jENbGqVNHAEYbhYjoyYGPRnz8ldfPJRal0Ok2CgO7cRTe2g5WR65

--
-- Database "bibliojuegos" dump
--

--
-- PostgreSQL database dump
--

\restrict 2VxpdwKrtDKtR95yuUjhwM766g4qH6Nt8eoHtygBnrYiOws3Vv9Z1Y9Q3G347KR

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

\unrestrict 2VxpdwKrtDKtR95yuUjhwM766g4qH6Nt8eoHtygBnrYiOws3Vv9Z1Y9Q3G347KR
\connect bibliojuegos
\restrict 2VxpdwKrtDKtR95yuUjhwM766g4qH6Nt8eoHtygBnrYiOws3Vv9Z1Y9Q3G347KR

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
    plataform text NOT NULL,
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

CREATE FUNCTION public.getvideogames_completo()
RETURNS TABLE (
    id integer,
    name varchar(100),
    description varchar(250),
    genre varchar(50),
    developer varchar(100),
    image text,
    release_date date,
    price real,
    valoration integer,
    duration integer,
    plataform text
)
AS $$
BEGIN
    RETURN QUERY
    SELECT v.id, v.name, v.description, g.name, d.name, v.image, v.release_date, v.price, v.valoration, v.duration, v.plataform
    FROM videogame v
    JOIN genre g ON v.genre_id = g.id
    JOIN developer d ON v.developer_id = d.id;
END;
$$ LANGUAGE plpgsql;

--
-- Name: insert_videogame(character varying, character varying, integer, date, real, integer, integer, integer, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.insert_videogame(nombre character varying, descripcion character varying, duracion integer, fecha_salida date, precio real, id_genero integer, id_developer integer, valoracion integer, imagen text, plataform text) RETURNS void
    LANGUAGE plpgsql
    AS $$ BEGIN INSERT INTO videogame(name, description, duration, release_date, price, genre_id, developer_id, valoration, image, plataform) VALUES(nombre, descripcion, duracion, fecha_salida, precio, id_genero, id_developer, valoracion, imagen, plataform); END; $$;


ALTER FUNCTION public.insert_videogame(nombre character varying, descripcion character varying, duracion integer, fecha_salida date, precio real, id_genero integer, id_developer integer, valoracion integer, imagen text, plataform text) OWNER TO postgres;

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
11	CD Projekt RED	Estudio polaco conocido por sagas RPG como The Witcher y Cyberpunk 2077, enfocado en narrativa profunda y mundos abiertos.	1994	Polonia
12	Naughty Dog	Estudio estadounidense creador de The Last of Us y Uncharted, especializado en narrativa cinematogr┬áfica y alta calidad tÔÇÜcnica.	1984	EEUU
13	Sucker Punch Productions	Estudio estadounidense conocido por Ghost of Tsushima y Sly Cooper, enfocado en acci┬ón y mundos abiertos.	1997	EEUU
14	Supergiant Games	Estudio independiente estadounidense reconocido por Hades y Bastion, con fuerte enfoque art┬ístico y narrativo.	2009	EEUU
15	id Software	Estudio pionero en shooters en primera persona como DOOM, famoso por tecnolog┬ía gr┬áfica avanzada y acci┬ón r┬ápida.	1991	EEUU
16	Square Enix	Compa┬ñ┬ía japonesa l┬íder en RPGs como Final Fantasy y Dragon Quest, enfocada en narrativa y mundos fant┬ásticos.	2003	Japon
17	IO Interactive	Estudio danÔÇÜs creador de la saga Hitman, especializado en sigilo y dise┬ño de niveles sandbox.	1998	Dinamarca
18	Playground Games	Estudio brit┬ánico conocido por Forza Horizon, especializado en conducci┬ón en mundo abierto.	2010	Reino Unido
19	FromSoftware	Estudio japonÔÇÜs creador de Dark Souls y Elden Ring, conocido por dificultad alta y dise┬ño de combate exigente.	1986	Japon
20	Santa Monica Studio	Estudio estadounidense responsable de God of War, especializado en acci┬ón narrativa de alto nivel.	1999	EEUU
21	Guerrilla Games	Estudio neerlandÔÇÜs creador de Horizon Zero Dawn, especializado en mundos abiertos y gr┬áficos avanzados.	2000	Paises Bajos
22	BlueTwelve Studio	Peque┬ño estudio francÔÇÜs conocido por Stray, centrado en experiencias narrativas innovadoras.	2016	Francia
23	Sloclap	Estudio francÔÇÜs independiente creador de Sifu, especializado en combate cuerpo a cuerpo y animaci┬ón fluida.	2015	Francia
24	Asobo Studio	Estudio francÔÇÜs responsable de A Plague Tale, enfocado en narrativa y experiencias inmersivas.	2002	Francia
25	Game Freak	Estudio japonÔÇÜs creador de PokÔÇÜmon, especializado en RPGs accesibles y coleccionismo de criaturas.	1989	Japon
26	Polyphony Digital	Estudio japonÔÇÜs responsable de Gran Turismo, l┬íder en simulaci┬ón de conducci┬ón realista.	1998	Japon
27	Bethesda Game Studios	Estudio estadounidense creador de The Elder Scrolls y Starfield, especializado en RPG de mundo abierto.	2001	EEUU
28	Insomniac Games	Estudio estadounidense creador de Spider-Man y Ratchet & Clank, enfocado en acci┬ón din┬ámica.	1994	EEUU
29	Remedy Entertainment	Estudio finlandÔÇÜs creador de Alan Wake y Control, especializado en narrativa y acci┬ón psicol┬ógica.	1995	Finlandia
30	Bandai Namco	Compa┬ñ┬ía japonesa desarrolladora y editora de juegos como Tekken, enfocada en acci┬ón y lucha.	2006	Japon
31	Game Science	Estudio chino independiente creador de Black Myth: Wukong, especializado en acci┬ón inspirada en mitolog┬ía.	2014	China
32	GSC Game World	Estudio ucraniano creador de S.T.A.L.K.E.R., enfocado en supervivencia y ambientaci┬ón postapocal┬íptica.	1995	Ucrania
33	Atlus	Estudio japonÔÇÜs conocido por Persona y Shin Megami Tensei, especializado en JRPGs narrativos.	1986	Japon
34	NetEase Games	Compa┬ñ┬ía china de videojuegos centrada en desarrollo online y multijugador competitivo.	2001	China
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
22	Gestio
\.


--
-- Data for Name: videogame; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.videogame (id, name, description, duration, release_date, price, genre_id, developer_id, valoration, image, plataform, created_at) FROM stdin;
1	The Legend of Zelda: Breath of the Wild	Exploración de un vasto reino destruido con secretos, libertad y misterios antiguos por descubrir.	60	2017-03-03	59.99	2	1	10	https://media.rawg.io/media/resize/1280/-/games/cc1/cc196a5ad763955d6532cdba236f730c.jpg	Nintendo Switch	2026-04-29 15:41:58.363426
2	Super Mario Odyssey	Viaje por distintos mundos acompañando a Mario en una misión para rescatar a Peach.	12	2017-10-27	59.99	2	1	10	https://media.rawg.io/media/resize/1280/-/games/267/267bd0dbc496f52692487d07d014c061.jpg	Nintendo Switch	2026-04-29 15:41:58.363426
3	Mario Kart 8 Deluxe	Competiciones llenas de velocidad con personajes icónicos en circuitos llenos de sorpresas.	20	2017-04-28	49.99	15	1	9	https://media.rawg.io/media/resize/640/-/games/7df/7dfbdcb58a03fcddc68479454fc1f7de.jpg	Nintendo Switch	2026-04-29 15:41:58.363426
4	Grand Theft Auto V	Historia entrelazada de tres personajes en una ciudad llena de crimen y ambición.	50	2013-09-17	29.99	6	2	10	https://media.rawg.io/media/resize/640/-/games/734/7342a1cd82c8997ec620084ae4c2e7e4.jpg	PC / PS4 / Xbox One / PS3 / Xbox 360	2026-04-29 15:41:58.363426
5	Red Dead Redemption 2	Relato de forajidos en decadencia enfrentando cambios del viejo oeste americano.	70	2018-10-26	59.99	6	2	10	https://media.rawg.io/media/resize/1280/-/games/511/5118aff5091cb3efec399c808f8c598f.jpg	PC / PS4 / Xbox One	2026-04-29 15:41:58.363426
6	Bully	Vida de un estudiante en una escuela conflictiva llena de retos y situaciones sociales.	15	2006-10-17	14.99	2	2	9	https://media.rawg.io/media/resize/640/-/games/5bc/5bcfcafffbd3085c62cc712b5b5f4b88.jpg	PC / PS2 / Xbox 360 / Wii	2026-04-29 15:41:58.363426
7	Call of Duty: Modern Warfare	Operaciones militares modernas con conflictos globales y personajes en situaciones extremas.	8	2019-10-25	59.99	5	3	9	https://media.rawg.io/media/resize/640/-/games/509/509c81a5da92a8d0645d9e160d155017.jpg	PC / PS4 / Xbox One	2026-04-29 15:41:58.363426
8	Overwatch	Héroes diversos luchando juntos para restaurar la paz en un futuro conflictivo.	10	2016-05-24	39.99	5	3	9	https://media.rawg.io/media/resize/1280/-/games/4ea/4ea507ceebeabb43edbc09468f5aaac6.jpg	PC / PS4 / Xbox One / Nintendo Switch	2026-04-29 15:41:58.363426
9	Diablo III	Fuerzas demoníacas amenazan un mundo oscuro lleno de caos y desesperación constante.	40	2012-05-15	19.99	4	3	9	https://media.rawg.io/media/resize/640/-/games/b89/b898b8342f4f74deac820e469c9aee22.jpg	PC / PS4 / PS3 / Xbox One / Xbox 360 / Nintendo Switch	2026-04-29 15:41:58.363426
10	Resident Evil 4	Rescate en un pueblo remoto lleno de peligros y amenazas desconocidas constantes.	16	2005-01-11	19.99	3	4	10	https://media.rawg.io/media/resize/640/-/games/b89/b898b8342f4f74deac820e469c9aee22.jpg	PC / PS2 / GameCube / Xbox One / PS4 / Nintendo Switch	2026-04-29 15:41:58.363426
11	Monster Hunter: World	Caza de criaturas gigantes en entornos salvajes llenos de ecosistemas vivos.	100	2018-01-26	29.99	6	4	9	https://media.rawg.io/media/resize/1280/-/games/21c/21cc15d233117c6809ec86870559e105.jpg	PC / PS4 / Xbox One	2026-04-29 15:41:58.363426
12	Street Fighter V	Combates entre luchadores con estilos únicos en torneos globales intensos.	10	2016-02-16	19.99	21	4	8	https://media.rawg.io/media/resize/1280/-/games/a32/a32c9c299488ca99afc3fcea605a7718.jpg	PC / PS4	2026-04-29 15:41:58.363426
13	Assassins Creed II	Historia de venganza ambientada en ciudades históricas del Renacimiento italiano.	20	2009-11-17	9.99	2	5	9	https://media.rawg.io/media/resize/1280/-/games/1be/1bed7fae69d1004c09dfe1101d5a3a94.jpg	PC / PS3 / Xbox 360	2026-04-29 15:41:58.363426
14	Far Cry 5	Enfrentamiento contra una secta en una región rural con conflictos armados.	25	2018-03-27	59.99	6	5	9	https://media.rawg.io/media/resize/1280/-/games/bce/bce62fbc7cf74bf6a1a37340993ec148.jpg	PC / PS4 / Xbox One	2026-04-29 15:41:58.363426
15	Tom Clancys Rainbow Six Siege	Operaciones tácticas en escenarios cerrados con equipos especializados enfrentándose.	0	2015-12-01	19.99	5	5	9	https://media.rawg.io/media/resize/1280/-/games/b34/b3419c2706f8f8dbe40d08e23642ad06.jpg	PC / PS4 / Xbox One	2026-04-29 15:41:58.363426
16	Fortnite	Supervivencia masiva en una isla donde solo uno puede quedar victorioso.	0	2017-07-25	0	13	6	9	https://media.rawg.io/media/resize/1280/-/games/dcb/dcbb67f371a9a28ea38ffd73ee0f53f3.jpg	PC / PS4 / Xbox One / Nintendo Switch / Mobile	2026-04-29 15:41:58.363426
17	Gears of War	Humanidad luchando contra amenazas subterráneas en guerras desesperadas.	10	2006-11-07	19.99	5	6	9	https://media.rawg.io/media/resize/640/-/games/988/98834d39955e7f15d3717fac438128aa.jpg	Xbox 360 / PC	2026-04-29 15:41:58.363426
18	Infinity Blade	Guerreros enfrentan un destino marcado por batallas contra poderosos enemigos.	5	2010-12-09	2.99	4	6	8	https://media.rawg.io/media/resize/640/-/screenshots/113/113a889bef38fee1675c6b435da003e6.jpg	iOS	2026-04-29 15:41:58.363426
19	Fallout: New Vegas	Supervivencia en un desierto devastado tras una guerra nuclear global.	60	2010-10-19	9.99	4	7	9	https://media.rawg.io/media/resize/1280/-/games/995/9951d9d55323d08967640f7b9ab3e342.jpg	PC / PS3 / Xbox 360	2026-04-29 15:41:58.363426
20	The Outer Worlds	Colonias espaciales controladas por corporaciones en conflicto constante.	25	2019-10-25	29.99	4	7	9	https://media.rawg.io/media/resize/1280/-/games/704/704f831d2d132e9614931f1c4eab9e86.jpg	PC / PS4 / Xbox One / Nintendo Switch	2026-04-29 15:41:58.363426
21	Pillars of Eternity	Reinos antiguos marcados por magia, conflictos y almas perdidas.	70	2015-03-26	29.99	4	7	9	https://media.rawg.io/media/resize/1280/-/games/789/7896837ec22a83e4007018ddd55e8c9a.jpg	PC / PS4 / Xbox One / Nintendo Switch	2026-04-29 15:41:58.363426
22	Baldurs Gate 3	Destino de un grupo marcado por fuerzas oscuras y decisiones críticas.	100	2023-08-03	59.99	4	8	10	https://media.rawg.io/media/resize/1280/-/games/699/69907ecf13f172e9e144069769c3be73.jpg	PC / PS5	2026-04-29 15:41:58.363426
23	Divinity: Original Sin	Dos aventureros investigan misterios mágicos en un mundo cambiante.	80	2014-06-30	39.99	4	8	9	https://media.rawg.io/media/resize/1280/-/games/963/9639183ff27251b0b686acaa6aac0297.jpg	PC / PS4 / Xbox One / Nintendo Switch	2026-04-29 15:41:58.363426
24	Divinity II: Ego Draconis	Un guerrero descubre su vínculo con dragones en un mundo dividido.	40	2009-08-21	19.99	4	8	8	https://media.rawg.io/media/resize/640/-/games/334/3342ccbbdc6b705825d8fb8e3ca12c97.jpg	PC / Xbox 360	2026-04-29 15:41:58.363426
25	Sonic the Hedgehog	Un erizo azul enfrenta al Dr. Robotnik en múltiples escenarios coloridos.	6	1991-06-23	9.99	2	9	9	https://media.rawg.io/media/resize/640/-/games/373/373a9a1f664de6e4c31f08644729e2db.jpg	Sega Genesis	2026-04-29 15:41:58.363426
26	Yakuza 0	Historias criminales entre clanes en una ciudad japonesa vibrante.	50	2015-03-12	19.99	6	9	9	https://media.rawg.io/media/resize/1280/-/games/ca1/ca16da30f86d8f4d36261de45fb35430.jpg	PC / PS4	2026-04-29 15:41:58.363426
27	Phantasy Star Online 2	Exploración espacial con misiones en mundos futuristas llenos de tecnología.	0	2012-07-04	0	9	9	8	https://media.rawg.io/media/resize/420/-/screenshots/296/2960740723535b92b150d7c528b6c661.jpg	PC / Xbox One / Nintendo Switch	2026-04-29 15:41:58.363426
28	FIFA 23	Simulación de competiciones internacionales con equipos reales y jugadores famosos.	0	2022-09-30	59.99	10	10	9	https://media.rawg.io/media/resize/640/-/games/dbc/dbcb05bcdf104264db35de68d1e73909.jpg	PC / PS5 / Xbox Series X	2026-04-29 15:41:58.363426
29	Battlefield 1	Conflictos históricos a gran escala con batallas intensas entre ejércitos.	12	2016-10-21	19.99	5	10	9	https://media.rawg.io/media/resize/1280/-/games/998/9980c4296f311d8bcc5b451ca51e4fe1.jpg	PC / PS4 / Xbox One	2026-04-29 15:41:58.363426
30	The Sims 4	Simulación de vida cotidiana donde personajes desarrollan historias personales.	0	2014-09-02	19.99	11	10	9	https://media.rawg.io/media/resize/1280/-/games/e44/e445335e611b4ccf03af71fffcbd30a4.jpg	PC / PS4 / Xbox One	2026-04-29 15:41:58.363426
115	Cyberpunk 2077	RPG futurista de mundo abierto en Night City.	40	2020-12-10	59.99	3	5	8	https://media.rawg.io/media/resize/1280/-/games/26d/26d4437715bee60138dab4a7c8c59c92.jpg	PC / PS4 / PS5 / Xbox One / Xbox Series X	2026-04-29 15:41:58.363426
116	The Last of Us Part II	Aventura y supervivencia centrada en narrativa y emociones intensas.	25	2020-06-19	59.99	1	4	10	https://media.rawg.io/media/resize/1280/-/games/909/909974d1c7863c2027241e265fe7011f.jpg	PS4	2026-04-29 15:41:58.363426
117	Ghost of Tsushima	Acción samurái de mundo abierto ambientado en Japón feudal.	35	2020-07-17	59.99	1	4	9	https://media.rawg.io/media/resize/1280/-/games/f24/f2493ea338fe7bd3c7d73750a85a0959.jpeg	PS4 / PS5	2026-04-29 15:41:58.363426
118	Hades	Roguelike de acción basado en la mitología griega.	25	2020-09-17	24.99	6	11	10	https://media.rawg.io/media/resize/1280/-/games/1f4/1f47a270b8f241e4676b14d39ec620f7.jpg	PC / PS4 / PS5 / Xbox One / Xbox Series X / Nintendo Switch	2026-04-29 15:41:58.363426
119	Animal Crossing: New Horizons	Simulación social relajante en una isla desierta.	80	2020-03-20	59.99	7	10	9	https://media.rawg.io/media/resize/1280/-/games/42f/42fe1abd4d7c11ca92d93a0fb0f8662b.jpg	Nintendo Switch	2026-04-29 15:41:58.363426
120	Doom Eternal	FPS frenético con acción intensa contra demonios.	20	2020-03-20	59.99	5	8	9	https://media.rawg.io/media/resize/1280/-/games/3ea/3ea3c9bbd940b6cb7f2139e42d3d443f.jpg	PC / PS4 / PS5 / Xbox One / Xbox Series X / Nintendo Switch	2026-04-29 15:41:58.363426
121	Final Fantasy VII Remake	Reimaginación de un clásico RPG con gráficos modernos.	30	2020-04-10	59.99	3	2	9	https://media.rawg.io/media/resize/1280/-/games/d89/d89bd0cf4fcdc10820892980cbba0f49.jpg	PS4 / PS5	2026-04-29 15:41:58.363426
122	Resident Evil Village	Survival horror en un misterioso pueblo europeo.	12	2021-05-07	59.99	9	9	9	https://media.rawg.io/media/resize/1280/-/games/6cc/6cc23249972a427f697a3d10eb57a820.jpg	PC / PS4 / PS5 / Xbox One / Xbox Series X	2026-04-29 15:41:58.363426
123	Hitman 3	Infiltración y sigilo con misiones sandbox detalladas.	15	2021-01-20	59.99	8	14	9	https://media.rawg.io/media/resize/1280/-/games/126/126fbd5ceacddc6ad16fc96e50b1265b.jpg	PC / PS4 / PS5 / Xbox One / Xbox Series X	2026-04-29 15:41:58.363426
124	Forza Horizon 5	Carreras en mundo abierto ambientado en México.	40	2021-11-09	59.99	10	7	10	https://media.rawg.io/media/resize/1280/-/games/082/082365507ff04d456c700157072d35db.jpg	PC / Xbox One / Xbox Series X	2026-04-29 15:41:58.363426
125	Elden Ring	Mundo abierto de acción RPG creado junto con George R. R. Martin.	50	2022-02-25	59.99	3	3	10	https://media.rawg.io/media/resize/1280/-/games/b29/b294fdd866dcdb643e7bab370a552855.jpg	PC / PS4 / PS5 / Xbox One / Xbox Series X	2026-04-29 15:41:58.363426
126	God of War: Ragnarok	Acción épica en la mitología nórdica.	30	2022-11-09	69.99	1	4	10	https://media.rawg.io/media/resize/1280/-/games/1c3/1c305096502c475c00276c827f0fd697.jpg	PS4 / PS5	2026-04-29 15:41:58.363426
127	Horizon Forbidden West	Aventura postapocalíptica con criaturas mecánicas.	35	2022-02-18	69.99	1	4	9	https://media.rawg.io/media/resize/1280/-/games/bf7/bf73b105ccbba42107986bbcd96fcada.jpg	PS4 / PS5	2026-04-29 15:41:58.363426
128	Stray	Aventura narrativa protagonizada por un gato en una ciudad cyberpunk.	6	2022-07-19	29.99	1	18	9	https://media.rawg.io/media/resize/1280/-/games/cd3/cd3c9c7d3e95cb1608fd6250f1b90b7a.jpg	PC / PS4 / PS5	2026-04-29 15:41:58.363426
129	Sifu	Beat them up con progresión de artes marciales.	15	2022-02-08	39.99	6	16	9	https://media.rawg.io/media/resize/1280/-/games/3a9/3a9ea2db24f879e61fe7b824f5888d2a.jpg	PC / PS4 / PS5 / Nintendo Switch	2026-04-29 15:41:58.363426
130	A Plague Tale: Requiem	Aventura narrativa en una Europa medieval devastada.	20	2022-10-18	59.99	1	19	9	https://media.rawg.io/media/resize/1280/-/games/b4a/b4adf80c36e267b35acc3497ed2af19c.jpg	PC / PS5 / Xbox Series X	2026-04-29 15:41:58.363426
131	Call of Duty: Modern Warfare II	Shooter bélico con multijugador competitivo.	10	2022-10-28	69.99	5	12	8	https://media.rawg.io/media/resize/1280/-/games/9af/9af24c1886e2c7b52a4a2c65aa874638.jpg	PC / PS4 / PS5 / Xbox One / Xbox Series X	2026-04-29 15:41:58.363426
132	Gran Turismo 7	Simulador de conducción realista.	50	2022-03-04	69.99	10	4	9	https://media.rawg.io/media/resize/1280/-/games/3f6/3f6a04b856f23310d3c2f5be8c5963f7.jpg	PS4 / PS5	2026-04-29 15:41:58.363426
133	The Legend of Zelda: Tears of the Kingdom	Secuela de BOTW con nuevas mecánicas de construcción.	60	2023-05-12	69.99	2	1	10	https://media.rawg.io/media/resize/1280/-/games/556/55684bfd048706f4266d331d70050b37.jpg	Nintendo Switch	2026-04-29 15:41:58.363426
134	Starfield	RPG espacial con exploración de galaxias.	80	2023-09-06	69.99	3	8	8	https://media.rawg.io/media/resize/1280/-/games/ba8/ba82c971336adfd290e4c0eab6504fcf.jpg	PC / Xbox Series X	2026-04-29 15:41:58.363426
135	Spider-Man 2	Acción superheroica con dos protagonistas.	25	2023-10-20	69.99	1	4	9	https://media.rawg.io/media/resize/640/-/games/7ae/7ae5a14cdb4ab222a134c15f4629e430.jpg	PS5	2026-04-29 15:41:58.363426
136	Diablo IV	RPG de acción oscuro centrado en la lucha contra demonios.	40	2023-06-06	69.99	6	22	9	https://media.rawg.io/media/resize/1280/-/games/77d/77d51f8f4a07c3eecb0f8504027b1bf0.jpg	PC / PS4 / PS5 / Xbox One / Xbox Series X	2026-04-29 15:41:58.363426
137	Armored Core VI: Fires of Rubicon	Acción mecha de alta velocidad.	20	2023-08-25	59.99	5	3	9	https://media.rawg.io/media/resize/640/-/games/c97/c97aba78a97038867d4b32a81fe48567.jpg	PC / PS4 / PS5 / Xbox One / Xbox Series X	2026-04-29 15:41:58.363426
138	Dead Space Remake	Remake de horror espacial.	12	2023-01-27	59.99	9	13	9	https://media.rawg.io/media/resize/1280/-/games/ea6/ea6a1382b15d749e15fdfbf0aece7689.jpg	PC / PS5 / Xbox Series X	2026-04-29 15:41:58.363426
139	Alan Wake II	Horror psicológico con dos protagonistas.	20	2023-10-27	69.99	9	15	10	https://media.rawg.io/media/resize/640/-/games/5b9/5b963d7633cd640fa2dbc4069d1c6377.jpg	PC / PS5 / Xbox Series X	2026-04-29 15:41:58.363426
140	Final Fantasy VII Rebirth	Continuación del remake con nuevas zonas y narrativa ampliada.	45	2024-02-29	69.99	3	2	10	https://media.rawg.io/media/resize/640/-/games/511/511995d5dfcf18965dbb354d2ba9e176.jpg	PS5	2026-04-29 15:41:58.363426
141	Tekken 8	Lucha competitiva con motor nuevo.	20	2024-01-26	69.99	6	2	9	https://media.rawg.io/media/resize/640/-/games/ed3/ed3a5e9fab79022979de9ef420137f73.jpg	PC / PS5 / Xbox Series X	2026-04-29 15:41:58.363426
142	Star Wars Outlaws	Aventura espacial de mundo abierto.	35	2024-12-10	69.99	1	23	9	https://media.rawg.io/media/resize/640/-/games/853/853aa2b76ae85fcf2782ace58cf7479f.jpg	PC / PS5 / Xbox Series X	2026-04-29 15:41:58.363426
143	Black Myth: Wukong	Acción inspirada en mitología china.	25	2024-08-20	69.99	6	24	10	https://media.rawg.io/media/resize/640/-/games/779/77988e89f7862afeede524420aa251b0.jpg	PC / PS5 / Xbox Series X	2026-04-29 15:41:58.363426
144	S.T.A.L.K.E.R. 2: Heart of Chornobyl	FPS de supervivencia en mundo postapocalíptico.	30	2024-09-05	69.99	5	25	9	https://media.rawg.io/media/resize/1280/-/games/3e8/3e81585ecda204d4f4b80a041b069adb.jpg	PC / Xbox Series X	2026-04-29 15:41:58.363426
145	Avowed	RPG de fantasía de mundo compartido.	40	2024-11-12	69.99	3	8	9	https://media.rawg.io/media/resize/640/-/games/3d3/3d33abf32d9fb92b9f242917abe276ba.jpg	PC / Xbox Series X	2026-04-29 15:41:58.363426
146	Metaphor: ReFantazio	JRPG creado por el equipo de Persona.	50	2024-10-11	69.99	3	26	9	https://media.rawg.io/media/resize/640/-/games/2cd/2cd2467a32aaaed0bdeb192c2831cfe0.jpg	PC / PS5 / Xbox Series X	2026-04-29 15:41:58.363426
147	Marvel Rivals	Shooter competitivo por héroes.	10	2025-04-15	59.99	5	28	9	https://media.rawg.io/media/resize/640/-/screenshots/3f0/3f0fdfc7c71655366aa83ab80ecab9b8.jpg	PC / PS5 / Xbox Series X	2026-04-29 15:41:58.363426
148	XCOM 2	Estrategia táctica por turnos contra una invasión alienígena.	40	2016-02-05	39.99	8	5	9	https://media.rawg.io/media/resize/640/-/games/824/8244534a6db2180e177271cebb9c002f.jpg	PC / PS4 / Xbox One	2026-04-29 15:41:58.363426
149	Total War: Three Kingdoms	Estrategia en tiempo real ambientada en la antigua China.	60	2019-05-23	49.99	8	9	9	https://media.rawg.io/media/resize/1280/-/games/b4c/b4cd6c7a2712b88eec149536882d6c3b.jpg	PC	2026-04-29 15:41:58.363426
150	World of Warcraft	MMORPG clásico con un mundo fantástico persistente.	0	2004-11-23	14.99	9	3	9	https://media.rawg.io/media/resize/1280/-/games/1bf/1bff5a69755eaeef9d37b4e0a14e9bca.jpg	PC	2026-04-29 15:41:58.363426
151	World of Warcraft Classic	Versión original del MMORPG más famoso.	0	2019-08-27	14.99	9	3	9	https://media.rawg.io/media/resize/1280/-/games/c21/c21aa06fd66da98f2388965be78c8b89.jpg	PC	2026-04-29 15:41:58.363426
152	EA Sports FC 24	Simulación de fútbol realista.	0	2023-09-29	69.99	10	10	9	https://media.rawg.io/media/resize/640/-/games/104/10404407d458d90f4559a1f587c2650a.jpg	PC / PS5 / Xbox	2026-04-29 15:41:58.363426
153	Just Dance 2024	Juego de baile con coreografías musicales.	0	2023-10-24	49.99	12	5	8	https://media.rawg.io/media/resize/640/-/games/e4a/e4abca7866c6f9937ad5740079f02f0f.jpg	Switch / PS5 / Xbox	2026-04-29 15:41:58.363426
154	Just Dance 2023	Juego rítmico de baile.	0	2022-10-20	49.99	12	5	8	https://media.rawg.io/media/resize/640/-/games/605/605940cb2be92c8c483fd514165ea81e.jpg	Switch / PS5 / Xbox	2026-04-29 15:41:58.363426
155	Apex Legends	Battle royale de héroes con habilidades únicas.	0	2019-02-04	0	13	10	9	https://media.rawg.io/media/resize/1280/-/games/737/737ea5662211d2e0bbd6f5989189e4f1.jpg	PC / PS5 / Xbox	2026-04-29 15:41:58.363426
156	Anno 1800	Construcción y gestión de ciudades industriales.	0	2019-04-16	59.99	22	5	9	https://media.rawg.io/media/resize/640/-/games/8b3/8b3fb68e0140aa50da9dd07b561053c0.jpg	PC	2026-04-29 15:41:58.363426
157	Football Manager 2024	Gestión realista de equipos de fútbol.	0	2023-11-06	49.99	22	9	9	https://media.rawg.io/media/resize/640/-/screenshots/86f/86ff71c8b2fc1f9e5b067e5e8fc0438c.jpg	PC	2026-04-29 15:41:58.363426
158	Pokémon Scarlet	Aventura Pokémon en mundo abierto.	0	2022-11-18	59.99	19	1	9	https://media.rawg.io/media/resize/1280/-/games/5ab/5abb8e4af55eb8c867410c3a740355b9.jpg	Nintendo Switch	2026-04-29 15:41:58.363426
159	Pokémon Legends: Arceus	Exploración en el mundo Pokémon antiguo.	25	2022-01-28	59.99	19	1	9	https://media.rawg.io/media/resize/1280/-/games/80a/80a3e1060b49c02f901e781b263cd881.jpg	Nintendo Switch	2026-04-29 15:41:58.363426
160	Ace Attorney Investigations	Investigación de crímenes y juicios.	30	2009-09-03	19.99	20	4	9	https://media.rawg.io/media/resize/640/-/screenshots/b9f/b9f38e1f4b4aaa180675c28c13f6b50e.jpg	Nintendo DS / Switch	2026-04-29 15:41:58.363426
161	Ace Attorney Trilogy	Colección de casos judiciales clásicos.	30	2019-04-09	29.99	20	4	9	https://media.rawg.io/media/resize/1280/-/games/3e5/3e55a40ff233aacf63f96ea80fcc7234.jpg	PC / Switch / PS4	2026-04-29 15:41:58.363426
162	Snipperclips	Puzzle cooperativo creativo.	5	2017-03-03	19.99	14	1	9	https://media.rawg.io/media/resize/640/-/screenshots/706/7068196eb5089a05caecc45e5bdd36e5.jpg	Nintendo Switch	2026-04-29 15:41:58.363426
163	Cadence of Hyrule	Ritmo y aventura en el universo Zelda.	10	2019-06-13	24.99	14	1	9	https://media.rawg.io/media/resize/1280/-/games/f67/f678872fd89487324cf1267cd2adba96.jpg	Switch	2026-04-29 15:41:58.363426
164	Need for Speed Heat	Carreras callejeras ilegales.	20	2019-11-08	59.99	15	10	9	https://media.rawg.io/media/resize/1280/-/games/370/3703c683968a54f09630dcf03366ea35.jpg	PC / PS4 / Xbox	2026-04-29 15:41:58.363426
165	F1 23	Simulación oficial de Fórmula 1.	0	2023-06-16	69.99	15	10	9	https://media.rawg.io/media/resize/640/-/games/ef7/ef7cf3546df79efc52d99401afb36e7b.jpg	PC / PS5 / Xbox	2026-04-29 15:41:58.363426
166	Immortals Fenyx Rising	Aventura mitológica con elementos roguelike ligeros.	30	2020-12-03	59.99	16	5	9	https://media.rawg.io/media/resize/1280/-/games/d51/d51ada3b94bfd617bf91d4344ab81ce9.jpg	PC / PS5 / Xbox	2026-04-29 15:41:58.363426
167	Assassins Creed Valhalla	Exploración y combate vikingo con progresión de mundo abierto.	60	2020-11-10	59.99	16	5	9	https://media.rawg.io/media/resize/1280/-/games/934/9346092ae11bf7582c883869468171cc.jpg	PC / PS5 / Xbox	2026-04-29 15:41:58.363426
168	Street Fighter 6	Combates técnicos 1v1.	10	2023-06-02	59.99	21	4	9	https://media.rawg.io/media/resize/640/-/games/ce2/ce2463db40cec363f360c29ddcc56884.jpg	PC / PS5 / Xbox	2026-04-29 15:41:58.363426
169	Virtua Fighter 5	Lucha clásica 3D.	10	2021-06-01	19.99	21	9	9	https://media.rawg.io/media/resize/640/-/games/5cf/5cf4c17c8ac927985e3fc2f3c0f1eb58.jpg	PS4 / Xbox	2026-04-29 15:41:58.363426
170	Far Cry Primal	Supervivencia en la prehistoria.	25	2016-02-23	29.99	7	5	9	https://media.rawg.io/media/resize/640/-/games/119/119bb59e64c7956171a33df0d35aee6b.jpg	PC / PS4 / Xbox	2026-04-29 15:41:58.363426
\.


--
-- Name: developer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.developer_id_seq', 34, true);


--
-- Name: genre_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.genre_id_seq', 22, true);


--
-- Name: videogame_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.videogame_id_seq', 171, true);


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
-- Name: TABLE genre; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.genre TO grupo_user;
GRANT ALL ON TABLE public.genre TO admin;


--
-- Name: SEQUENCE genre_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.genre_id_seq TO admin;


--
-- PostgreSQL database dump complete
--

\unrestrict 2VxpdwKrtDKtR95yuUjhwM766g4qH6Nt8eoHtygBnrYiOws3Vv9Z1Y9Q3G347KR

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

\restrict cMFyEQgZb9BcpV4wqOOHOLmHaGfxQR3aX1GqZvSrrfN5guoDOoREyZUbr2QaBHS

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

\unrestrict cMFyEQgZb9BcpV4wqOOHOLmHaGfxQR3aX1GqZvSrrfN5guoDOoREyZUbr2QaBHS

--
-- PostgreSQL database cluster dump complete
--

