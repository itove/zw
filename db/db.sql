--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4
-- Dumped by pg_dump version 15.4

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
-- Name: notify_messenger_messages(); Type: FUNCTION; Schema: public; Owner: zw
--

CREATE FUNCTION public.notify_messenger_messages() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
            BEGIN
                PERFORM pg_notify('messenger_messages', NEW.queue_name::text);
                RETURN NEW;
            END;
        $$;


ALTER FUNCTION public.notify_messenger_messages() OWNER TO zw;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: category; Type: TABLE; Schema: public; Owner: zw
--

CREATE TABLE public.category (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    label character varying(255) NOT NULL
);


ALTER TABLE public.category OWNER TO zw;

--
-- Name: category_id_seq; Type: SEQUENCE; Schema: public; Owner: zw
--

CREATE SEQUENCE public.category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.category_id_seq OWNER TO zw;

--
-- Name: comment; Type: TABLE; Schema: public; Owner: zw
--

CREATE TABLE public.comment (
    id integer NOT NULL,
    node_id integer,
    author_id integer NOT NULL,
    body text NOT NULL,
    created_at timestamp(0) without time zone NOT NULL,
    up integer DEFAULT 0 NOT NULL,
    down integer DEFAULT 0 NOT NULL,
    deleted boolean NOT NULL
);


ALTER TABLE public.comment OWNER TO zw;

--
-- Name: COLUMN comment.created_at; Type: COMMENT; Schema: public; Owner: zw
--

COMMENT ON COLUMN public.comment.created_at IS '(DC2Type:datetime_immutable)';


--
-- Name: comment_id_seq; Type: SEQUENCE; Schema: public; Owner: zw
--

CREATE SEQUENCE public.comment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comment_id_seq OWNER TO zw;

--
-- Name: conf; Type: TABLE; Schema: public; Owner: zw
--

CREATE TABLE public.conf (
    id integer NOT NULL,
    language_id integer,
    sitename character varying(255) NOT NULL,
    keywords text,
    description character varying(255) DEFAULT NULL::character varying,
    address character varying(255) DEFAULT NULL::character varying,
    phone character varying(25) DEFAULT NULL::character varying,
    email character varying(55) DEFAULT NULL::character varying,
    logo character varying(255) DEFAULT NULL::character varying,
    updated_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    note character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.conf OWNER TO zw;

--
-- Name: COLUMN conf.keywords; Type: COMMENT; Schema: public; Owner: zw
--

COMMENT ON COLUMN public.conf.keywords IS '(DC2Type:simple_array)';


--
-- Name: COLUMN conf.updated_at; Type: COMMENT; Schema: public; Owner: zw
--

COMMENT ON COLUMN public.conf.updated_at IS '(DC2Type:datetime_immutable)';


--
-- Name: conf_id_seq; Type: SEQUENCE; Schema: public; Owner: zw
--

CREATE SEQUENCE public.conf_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.conf_id_seq OWNER TO zw;

--
-- Name: doctrine_migration_versions; Type: TABLE; Schema: public; Owner: zw
--

CREATE TABLE public.doctrine_migration_versions (
    version character varying(191) NOT NULL,
    executed_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    execution_time integer
);


ALTER TABLE public.doctrine_migration_versions OWNER TO zw;

--
-- Name: down; Type: TABLE; Schema: public; Owner: zw
--

CREATE TABLE public.down (
    id integer NOT NULL,
    node_id integer,
    u_id integer NOT NULL,
    created_at timestamp(0) without time zone NOT NULL,
    comment_id integer
);


ALTER TABLE public.down OWNER TO zw;

--
-- Name: COLUMN down.created_at; Type: COMMENT; Schema: public; Owner: zw
--

COMMENT ON COLUMN public.down.created_at IS '(DC2Type:datetime_immutable)';


--
-- Name: down_id_seq; Type: SEQUENCE; Schema: public; Owner: zw
--

CREATE SEQUENCE public.down_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.down_id_seq OWNER TO zw;

--
-- Name: fav; Type: TABLE; Schema: public; Owner: zw
--

CREATE TABLE public.fav (
    id integer NOT NULL,
    node_id integer NOT NULL,
    u_id integer NOT NULL,
    created_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.fav OWNER TO zw;

--
-- Name: COLUMN fav.created_at; Type: COMMENT; Schema: public; Owner: zw
--

COMMENT ON COLUMN public.fav.created_at IS '(DC2Type:datetime_immutable)';


--
-- Name: fav_id_seq; Type: SEQUENCE; Schema: public; Owner: zw
--

CREATE SEQUENCE public.fav_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fav_id_seq OWNER TO zw;

--
-- Name: feedback; Type: TABLE; Schema: public; Owner: zw
--

CREATE TABLE public.feedback (
    id integer NOT NULL,
    node_id integer,
    firstname character varying(15) DEFAULT NULL::character varying,
    lastname character varying(15) DEFAULT NULL::character varying,
    email character varying(35) DEFAULT NULL::character varying,
    phone character varying(20) DEFAULT NULL::character varying,
    title character varying(255) DEFAULT NULL::character varying,
    body text NOT NULL,
    country character varying(30) DEFAULT NULL::character varying,
    sex smallint,
    province character varying(255) DEFAULT NULL::character varying,
    city character varying(255) DEFAULT NULL::character varying,
    note character varying(255) DEFAULT NULL::character varying,
    name character varying(255) DEFAULT NULL::character varying,
    type smallint
);


ALTER TABLE public.feedback OWNER TO zw;

--
-- Name: feedback_id_seq; Type: SEQUENCE; Schema: public; Owner: zw
--

CREATE SEQUENCE public.feedback_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.feedback_id_seq OWNER TO zw;

--
-- Name: image; Type: TABLE; Schema: public; Owner: zw
--

CREATE TABLE public.image (
    id integer NOT NULL,
    node_id integer NOT NULL,
    image character varying(255) NOT NULL,
    title character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.image OWNER TO zw;

--
-- Name: image_id_seq; Type: SEQUENCE; Schema: public; Owner: zw
--

CREATE SEQUENCE public.image_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.image_id_seq OWNER TO zw;

--
-- Name: language; Type: TABLE; Schema: public; Owner: zw
--

CREATE TABLE public.language (
    id integer NOT NULL,
    language character varying(30) NOT NULL,
    prefix character varying(15) NOT NULL,
    locale character varying(15) NOT NULL
);


ALTER TABLE public.language OWNER TO zw;

--
-- Name: language_id_seq; Type: SEQUENCE; Schema: public; Owner: zw
--

CREATE SEQUENCE public.language_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.language_id_seq OWNER TO zw;

--
-- Name: like; Type: TABLE; Schema: public; Owner: zw
--

CREATE TABLE public."like" (
    id integer NOT NULL,
    node_id integer NOT NULL,
    u_id integer NOT NULL,
    created_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public."like" OWNER TO zw;

--
-- Name: COLUMN "like".created_at; Type: COMMENT; Schema: public; Owner: zw
--

COMMENT ON COLUMN public."like".created_at IS '(DC2Type:datetime_immutable)';


--
-- Name: like_id_seq; Type: SEQUENCE; Schema: public; Owner: zw
--

CREATE SEQUENCE public.like_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.like_id_seq OWNER TO zw;

--
-- Name: link; Type: TABLE; Schema: public; Owner: zw
--

CREATE TABLE public.link (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    link character varying(255) NOT NULL,
    weight smallint NOT NULL,
    menu_id integer NOT NULL
);


ALTER TABLE public.link OWNER TO zw;

--
-- Name: link_id_seq; Type: SEQUENCE; Schema: public; Owner: zw
--

CREATE SEQUENCE public.link_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.link_id_seq OWNER TO zw;

--
-- Name: menu; Type: TABLE; Schema: public; Owner: zw
--

CREATE TABLE public.menu (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    label character varying(255) NOT NULL
);


ALTER TABLE public.menu OWNER TO zw;

--
-- Name: menu_id_seq; Type: SEQUENCE; Schema: public; Owner: zw
--

CREATE SEQUENCE public.menu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.menu_id_seq OWNER TO zw;

--
-- Name: messenger_messages; Type: TABLE; Schema: public; Owner: zw
--

CREATE TABLE public.messenger_messages (
    id bigint NOT NULL,
    body text NOT NULL,
    headers text NOT NULL,
    queue_name character varying(190) NOT NULL,
    created_at timestamp(0) without time zone NOT NULL,
    available_at timestamp(0) without time zone NOT NULL,
    delivered_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone
);


ALTER TABLE public.messenger_messages OWNER TO zw;

--
-- Name: COLUMN messenger_messages.created_at; Type: COMMENT; Schema: public; Owner: zw
--

COMMENT ON COLUMN public.messenger_messages.created_at IS '(DC2Type:datetime_immutable)';


--
-- Name: COLUMN messenger_messages.available_at; Type: COMMENT; Schema: public; Owner: zw
--

COMMENT ON COLUMN public.messenger_messages.available_at IS '(DC2Type:datetime_immutable)';


--
-- Name: COLUMN messenger_messages.delivered_at; Type: COMMENT; Schema: public; Owner: zw
--

COMMENT ON COLUMN public.messenger_messages.delivered_at IS '(DC2Type:datetime_immutable)';


--
-- Name: messenger_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: zw
--

CREATE SEQUENCE public.messenger_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.messenger_messages_id_seq OWNER TO zw;

--
-- Name: messenger_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: zw
--

ALTER SEQUENCE public.messenger_messages_id_seq OWNED BY public.messenger_messages.id;


--
-- Name: node; Type: TABLE; Schema: public; Owner: zw
--

CREATE TABLE public.node (
    id integer NOT NULL,
    language_id integer,
    category_id integer,
    title character varying(255) NOT NULL,
    created_at timestamp(0) without time zone NOT NULL,
    body text,
    image character varying(255) DEFAULT NULL::character varying,
    summary text,
    updated_at timestamp(0) without time zone NOT NULL,
    video character varying(255) DEFAULT NULL::character varying,
    parent_id integer,
    audio character varying(255) DEFAULT NULL::character varying,
    qr character varying(255) DEFAULT NULL::character varying,
    phone character varying(255) DEFAULT NULL::character varying,
    latitude double precision,
    longitude double precision,
    address character varying(255) DEFAULT NULL::character varying,
    price integer,
    author_id integer,
    deleted boolean,
    marker character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.node OWNER TO zw;

--
-- Name: COLUMN node.created_at; Type: COMMENT; Schema: public; Owner: zw
--

COMMENT ON COLUMN public.node.created_at IS '(DC2Type:datetime_immutable)';


--
-- Name: COLUMN node.updated_at; Type: COMMENT; Schema: public; Owner: zw
--

COMMENT ON COLUMN public.node.updated_at IS '(DC2Type:datetime_immutable)';


--
-- Name: node_id_seq; Type: SEQUENCE; Schema: public; Owner: zw
--

CREATE SEQUENCE public.node_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.node_id_seq OWNER TO zw;

--
-- Name: node_region; Type: TABLE; Schema: public; Owner: zw
--

CREATE TABLE public.node_region (
    node_id integer NOT NULL,
    region_id integer NOT NULL
);


ALTER TABLE public.node_region OWNER TO zw;

--
-- Name: node_tag; Type: TABLE; Schema: public; Owner: zw
--

CREATE TABLE public.node_tag (
    node_id integer NOT NULL,
    tag_id integer NOT NULL
);


ALTER TABLE public.node_tag OWNER TO zw;

--
-- Name: order; Type: TABLE; Schema: public; Owner: zw
--

CREATE TABLE public."order" (
    id integer NOT NULL,
    node_id integer NOT NULL,
    consumer_id integer NOT NULL,
    quantity smallint NOT NULL,
    amount integer NOT NULL,
    created_at timestamp(0) without time zone NOT NULL,
    paid_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    used_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    status smallint NOT NULL,
    price integer NOT NULL,
    cancelled_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    refunded_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    deleted_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    sn character varying(255) NOT NULL,
    wx_trans_id character varying(255) DEFAULT NULL::character varying,
    bank_type character varying(255) DEFAULT NULL::character varying,
    wx_prepay_id character varying(255) DEFAULT NULL::character varying,
    deleted boolean NOT NULL
);


ALTER TABLE public."order" OWNER TO zw;

--
-- Name: COLUMN "order".created_at; Type: COMMENT; Schema: public; Owner: zw
--

COMMENT ON COLUMN public."order".created_at IS '(DC2Type:datetime_immutable)';


--
-- Name: COLUMN "order".paid_at; Type: COMMENT; Schema: public; Owner: zw
--

COMMENT ON COLUMN public."order".paid_at IS '(DC2Type:datetime_immutable)';


--
-- Name: COLUMN "order".used_at; Type: COMMENT; Schema: public; Owner: zw
--

COMMENT ON COLUMN public."order".used_at IS '(DC2Type:datetime_immutable)';


--
-- Name: COLUMN "order".cancelled_at; Type: COMMENT; Schema: public; Owner: zw
--

COMMENT ON COLUMN public."order".cancelled_at IS '(DC2Type:datetime_immutable)';


--
-- Name: COLUMN "order".refunded_at; Type: COMMENT; Schema: public; Owner: zw
--

COMMENT ON COLUMN public."order".refunded_at IS '(DC2Type:datetime_immutable)';


--
-- Name: COLUMN "order".deleted_at; Type: COMMENT; Schema: public; Owner: zw
--

COMMENT ON COLUMN public."order".deleted_at IS '(DC2Type:datetime_immutable)';


--
-- Name: order_id_seq; Type: SEQUENCE; Schema: public; Owner: zw
--

CREATE SEQUENCE public.order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_id_seq OWNER TO zw;

--
-- Name: page; Type: TABLE; Schema: public; Owner: zw
--

CREATE TABLE public.page (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    label character varying(255) NOT NULL,
    weight smallint
);


ALTER TABLE public.page OWNER TO zw;

--
-- Name: page_id_seq; Type: SEQUENCE; Schema: public; Owner: zw
--

CREATE SEQUENCE public.page_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.page_id_seq OWNER TO zw;

--
-- Name: refund; Type: TABLE; Schema: public; Owner: zw
--

CREATE TABLE public.refund (
    id integer NOT NULL,
    ord_id integer NOT NULL,
    created_at timestamp(0) without time zone NOT NULL,
    reason smallint NOT NULL,
    note character varying(255) DEFAULT NULL::character varying,
    sn character varying(255) NOT NULL,
    wx_refund_id character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.refund OWNER TO zw;

--
-- Name: COLUMN refund.created_at; Type: COMMENT; Schema: public; Owner: zw
--

COMMENT ON COLUMN public.refund.created_at IS '(DC2Type:datetime_immutable)';


--
-- Name: refund_id_seq; Type: SEQUENCE; Schema: public; Owner: zw
--

CREATE SEQUENCE public.refund_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.refund_id_seq OWNER TO zw;

--
-- Name: region; Type: TABLE; Schema: public; Owner: zw
--

CREATE TABLE public.region (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    label character varying(255) NOT NULL,
    count smallint NOT NULL,
    icon character varying(20) DEFAULT NULL::character varying,
    fields text,
    description character varying(255) DEFAULT NULL::character varying,
    page_id integer,
    weight smallint,
    marker character varying(255) DEFAULT NULL::character varying,
    created_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    updated_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone
);


ALTER TABLE public.region OWNER TO zw;

--
-- Name: COLUMN region.fields; Type: COMMENT; Schema: public; Owner: zw
--

COMMENT ON COLUMN public.region.fields IS '(DC2Type:simple_array)';


--
-- Name: COLUMN region.created_at; Type: COMMENT; Schema: public; Owner: zw
--

COMMENT ON COLUMN public.region.created_at IS '(DC2Type:datetime_immutable)';


--
-- Name: COLUMN region.updated_at; Type: COMMENT; Schema: public; Owner: zw
--

COMMENT ON COLUMN public.region.updated_at IS '(DC2Type:datetime_immutable)';


--
-- Name: region_id_seq; Type: SEQUENCE; Schema: public; Owner: zw
--

CREATE SEQUENCE public.region_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.region_id_seq OWNER TO zw;

--
-- Name: spec; Type: TABLE; Schema: public; Owner: zw
--

CREATE TABLE public.spec (
    id integer NOT NULL,
    node_id integer NOT NULL,
    name character varying(25) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.spec OWNER TO zw;

--
-- Name: spec_id_seq; Type: SEQUENCE; Schema: public; Owner: zw
--

CREATE SEQUENCE public.spec_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.spec_id_seq OWNER TO zw;

--
-- Name: tag; Type: TABLE; Schema: public; Owner: zw
--

CREATE TABLE public.tag (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    label character varying(255) NOT NULL
);


ALTER TABLE public.tag OWNER TO zw;

--
-- Name: tag_id_seq; Type: SEQUENCE; Schema: public; Owner: zw
--

CREATE SEQUENCE public.tag_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tag_id_seq OWNER TO zw;

--
-- Name: up; Type: TABLE; Schema: public; Owner: zw
--

CREATE TABLE public.up (
    id integer NOT NULL,
    node_id integer,
    u_id integer NOT NULL,
    created_at timestamp(0) without time zone NOT NULL,
    comment_id integer
);


ALTER TABLE public.up OWNER TO zw;

--
-- Name: COLUMN up.created_at; Type: COMMENT; Schema: public; Owner: zw
--

COMMENT ON COLUMN public.up.created_at IS '(DC2Type:datetime_immutable)';


--
-- Name: up_id_seq; Type: SEQUENCE; Schema: public; Owner: zw
--

CREATE SEQUENCE public.up_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.up_id_seq OWNER TO zw;

--
-- Name: user; Type: TABLE; Schema: public; Owner: zw
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    username character varying(180) NOT NULL,
    roles json NOT NULL,
    password character varying(255) NOT NULL,
    plain_password character varying(255) DEFAULT NULL::character varying,
    openid character varying(255) DEFAULT NULL::character varying,
    name character varying(255) DEFAULT NULL::character varying,
    phone character varying(255) DEFAULT NULL::character varying,
    avatar character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public."user" OWNER TO zw;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: zw
--

CREATE SEQUENCE public.user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO zw;

--
-- Name: messenger_messages id; Type: DEFAULT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.messenger_messages ALTER COLUMN id SET DEFAULT nextval('public.messenger_messages_id_seq'::regclass);


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public.category (id, name, label) FROM stdin;
1	介绍	intro
\.


--
-- Data for Name: comment; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public.comment (id, node_id, author_id, body, created_at, up, down, deleted) FROM stdin;
3	99	5	test	2024-10-22 07:36:27	0	0	f
4	99	5	test	2024-10-22 07:37:45	0	0	f
5	99	5	test	2024-10-22 07:38:16	0	0	f
6	99	5	test	2024-10-22 07:38:37	0	0	f
7	99	5	test	2024-10-22 07:39:28	0	0	f
8	99	5	test	2024-10-22 07:39:47	0	0	f
9	99	5	test	2024-10-22 07:41:47	0	0	f
10	99	5	test	2024-10-22 07:41:53	0	0	f
11	99	5	test	2024-10-22 07:42:01	0	0	f
12	99	5	test	2024-10-22 07:46:16	0	0	f
13	99	5	test	2024-10-22 07:47:39	0	0	f
14	99	5	test	2024-10-22 07:48:49	0	0	f
15	99	5	test22	2024-10-22 08:16:00	0	0	f
16	99	5	test5	2024-10-22 08:16:05	0	0	f
17	99	5	test6	2024-10-22 08:16:08	0	0	f
18	99	5	test7	2024-10-22 08:16:11	0	0	f
19	99	5	tet8	2024-10-22 08:16:14	0	0	f
20	99	5	test9	2024-10-22 11:11:05	0	0	f
21	99	5	test10	2024-10-22 11:15:09	0	0	f
22	99	5	test11	2024-10-22 11:17:31	0	0	f
23	99	5	test12	2024-10-22 11:18:28	0	0	f
24	100	5	test1	2024-10-22 11:35:29	0	0	f
25	98	5	test1	2024-10-22 11:37:00	0	0	f
26	98	5	test3	2024-10-22 11:37:51	0	0	f
27	98	5	tet4	2024-10-22 11:37:55	0	0	f
28	99	5	tet13	2024-10-22 11:41:34	0	0	f
29	99	5	test14	2024-10-22 11:41:42	0	0	f
30	99	5	tet15	2024-10-22 11:43:46	0	0	f
31	95	5	test1	2024-10-22 11:53:04	0	0	f
32	99	5	tet16	2024-10-22 11:59:48	0	0	f
33	99	5	tet7	2024-10-22 13:57:43	0	0	f
34	100	5	tset7	2024-10-22 13:58:45	0	0	f
35	149	5	test1	2024-10-22 14:00:04	0	0	f
\.


--
-- Data for Name: conf; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public.conf (id, language_id, sitename, keywords, description, address, phone, email, logo, updated_at, note) FROM stdin;
1	\N	遇见张湾	\N	\N	\N	\N	\N	meishi-bg-670dd8cbb4f25238085587.png	2024-10-15 02:51:55	\N
\.


--
-- Data for Name: doctrine_migration_versions; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public.doctrine_migration_versions (version, executed_at, execution_time) FROM stdin;
DoctrineMigrations\\Version20240110161309	2024-03-13 12:28:02	214
DoctrineMigrations\\Version20240513003319	2024-05-13 00:33:29	37
DoctrineMigrations\\Version20240513003519	2024-05-13 00:35:22	8
DoctrineMigrations\\Version20240513042532	2024-05-13 04:26:21	12
DoctrineMigrations\\Version20240513082950	2024-05-13 08:29:54	13
DoctrineMigrations\\Version20240513110628	2024-05-13 11:06:34	36
DoctrineMigrations\\Version20240513143315	2024-05-13 14:34:24	15
DoctrineMigrations\\Version20240515124401	2024-05-15 15:15:30	56
DoctrineMigrations\\Version20240515125105	2024-05-15 15:15:30	11
DoctrineMigrations\\Version20240517005044	2024-05-17 02:12:17	3
DoctrineMigrations\\Version20240609083412	2024-09-13 19:07:10	11
DoctrineMigrations\\Version20240609084241	2024-09-13 19:07:10	2
DoctrineMigrations\\Version20240609094106	2024-09-13 19:07:10	1
DoctrineMigrations\\Version20240609103109	2024-09-13 19:07:10	21
DoctrineMigrations\\Version20240609151737	2024-09-13 19:07:10	9
DoctrineMigrations\\Version20240610091811	2024-09-13 19:07:10	2
DoctrineMigrations\\Version20240613000954	2024-09-13 19:07:10	2
DoctrineMigrations\\Version20240613004808	2024-09-13 19:07:10	2
DoctrineMigrations\\Version20240614093505	2024-09-13 19:07:10	2
DoctrineMigrations\\Version20240615140501	2024-09-13 19:07:10	2
DoctrineMigrations\\Version20241017095256	2024-10-17 12:54:31	39
DoctrineMigrations\\Version20241019163246	2024-10-20 04:21:38	85
DoctrineMigrations\\Version20241019164609	2024-10-20 04:21:38	4
DoctrineMigrations\\Version20241019165043	2024-10-20 04:21:38	0
DoctrineMigrations\\Version20241019165213	2024-10-20 04:21:38	9
DoctrineMigrations\\Version20241019174204	2024-10-20 04:21:38	0
DoctrineMigrations\\Version20241019183422	2024-10-20 04:21:38	5
DoctrineMigrations\\Version20241020083039	2024-10-20 20:15:56	25
DoctrineMigrations\\Version20241022042308	2024-10-22 04:24:07	14
DoctrineMigrations\\Version20241022042613	2024-10-22 04:26:46	18
DoctrineMigrations\\Version20241022073604	2024-10-22 07:36:17	11
DoctrineMigrations\\Version20241022083646	2024-10-22 08:36:51	9
DoctrineMigrations\\Version20241022084059	2024-10-22 08:41:03	38
DoctrineMigrations\\Version20241022084529	2024-10-22 08:45:56	33
DoctrineMigrations\\Version20241022084812	2024-10-22 08:48:38	30
DoctrineMigrations\\Version20241022084919	2024-10-22 08:49:39	6
DoctrineMigrations\\Version20241022085051	2024-10-22 08:50:55	9
DoctrineMigrations\\Version20241022085250	2024-10-22 08:53:02	18
DoctrineMigrations\\Version20241022085348	2024-10-22 08:53:50	13
DoctrineMigrations\\Version20241022142840	2024-10-22 14:28:52	7
DoctrineMigrations\\Version20241022143106	2024-10-22 14:31:09	9
DoctrineMigrations\\Version20241022150040	2024-10-22 15:01:00	9
DoctrineMigrations\\Version20241022150417	2024-10-22 15:04:31	5
\.


--
-- Data for Name: down; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public.down (id, node_id, u_id, created_at, comment_id) FROM stdin;
\.


--
-- Data for Name: fav; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public.fav (id, node_id, u_id, created_at) FROM stdin;
2	99	5	2024-10-20 21:57:52
3	94	5	2024-10-20 21:58:03
8	98	5	2024-10-21 00:23:08
12	149	6	2024-10-21 03:05:07
14	96	5	2024-10-21 07:25:45
\.


--
-- Data for Name: feedback; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public.feedback (id, node_id, firstname, lastname, email, phone, title, body, country, sex, province, city, note, name, type) FROM stdin;
\.


--
-- Data for Name: image; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public.image (id, node_id, image, title) FROM stdin;
\.


--
-- Data for Name: language; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public.language (id, language, prefix, locale) FROM stdin;
\.


--
-- Data for Name: like; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public."like" (id, node_id, u_id, created_at) FROM stdin;
7	99	5	2024-10-22 09:41:06
8	100	5	2024-10-22 11:35:22
9	98	5	2024-10-22 14:04:48
10	97	5	2024-10-22 14:05:12
\.


--
-- Data for Name: link; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public.link (id, title, link, weight, menu_id) FROM stdin;
\.


--
-- Data for Name: menu; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public.menu (id, name, label) FROM stdin;
\.


--
-- Data for Name: messenger_messages; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public.messenger_messages (id, body, headers, queue_name, created_at, available_at, delivered_at) FROM stdin;
\.


--
-- Data for Name: node; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public.node (id, language_id, category_id, title, created_at, body, image, summary, updated_at, video, parent_id, audio, qr, phone, latitude, longitude, address, price, author_id, deleted, marker) FROM stdin;
93	\N	\N	黄龙壹号生态园	2024-05-15 05:43:29	<p>黄龙壹号生态园</p>	huang-long-yi-hao-sheng-tai-yuan-66e494b71e294498991394.jpg	黄龙壹号生态园	2024-09-13 19:38:31	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N
85	\N	\N	龙泉寺	2024-05-15 04:21:43	<p>龙泉寺</p>	long-quan-si1-66e494cf71440501191736.jpeg	龙泉寺	2024-09-13 19:38:55	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N
89	\N	\N	十堰希尔顿逸林酒店	2024-05-15 05:26:58	<p><span style="background-color:rgb(255,255,255);color:rgb(15,41,77);"><strong>十堰希尔顿逸林酒店</strong></span></p>	20080c00000067b1i1473-w-1080-808-r5-d-66ea34f88b7e8776391708.jpg	十堰希尔顿逸林酒店	2024-09-18 02:03:36	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N
138	\N	\N	花迹雨舍	2024-09-18 08:06:03	<p>花迹雨舍</p>	5-66ebbe9762dc3269802938.jpg	花迹雨舍	2024-09-19 06:03:03	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N
126	\N	\N	维也纳国际酒店	2024-05-17 01:43:21	<p><span style="background-color:rgb(255,255,255);color:rgb(15,41,77);"><strong>维也纳国际酒店</strong></span></p>	020581200093rrmx1a5e2-w-1080-808-r5-d-66ea341be7b8d373180662.jpg	维也纳国际酒店	2024-09-18 01:59:55	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N
99	\N	\N	牛头山顶落日	2024-05-15 05:45:37	<p>牛头山顶落日</p>	1-66ebbce03c9ed662835048.jpg	牛头山顶落日	2024-09-19 05:55:44	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N
131	\N	\N	健康步道	2024-09-18 02:51:55	<p>健康步道</p>	3-66ea404bc7ffb033854785.jpg	健康步道	2024-09-18 02:51:55	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N
143	\N	\N	环球港	2024-09-19 04:41:03	<p><span style="background-color:rgb(255,255,255);color:rgb(51,51,51);"><strong>环球港</strong></span></p>	104f6e33-bd9f-4195-b4d8-aef107f47972-66ebab5f72ccc336852035.jpeg	环球港	2024-09-19 04:41:03	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N
97	\N	\N	人民公园	2024-05-15 05:45:02	<p>人民公园</p>	3-66ebbd618fc73980175579.jpg	人民公园	2024-09-19 05:57:53	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N
132	\N	\N	甜蜜来袭！张湾夏日水果采摘攻略来了	2024-09-18 03:02:00	<h2>甜蜜来袭！张湾夏日水果采摘攻略来了</h2>	640-66ea42a879918439629554.jpg	甜蜜来袭！张湾夏日水果采摘攻略来了	2024-09-18 03:02:00	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N
133	\N	\N	25分钟！央视专题报道张湾汉江樱桃	2024-09-18 03:03:16	<h2>25分钟！央视专题报道张湾汉江樱桃</h2><p><br>&nbsp;</p>	2-66ea42f4c8ec8678216616.jpg	25分钟！央视专题报道张湾汉江樱桃	2024-09-18 03:03:16	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N
96	\N	\N	四方山旅游区	2024-05-15 05:44:41	<p>四方山旅游区</p>	si-fang-shan1-66e49d887221d333921511.jpg	四方山旅游区	2024-09-13 20:16:08	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N
145	\N	\N	君王醉黄酒	2024-09-19 04:43:55	<p>君王醉黄酒</p>	jun-wang-zui-huang-jiu-66ebac0b8c220667500193.png	君王醉黄酒	2024-09-19 04:43:55	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N
91	\N	\N	十堰大嘉国际酒店	2024-05-15 05:28:48	<p><span style="background-color:rgb(255,255,255);color:rgb(15,41,77);"><strong>十堰大嘉国际酒店</strong></span></p>	200g0t000000iibm29a98-w-1080-808-r5-d-66ea346289fc4367561533.jpg	十堰大嘉国际酒店	2024-09-18 02:01:06	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N
146	\N	\N	沙洲猕猴桃	2024-09-19 04:47:52	<p>沙洲猕猴桃</p>	3-66ebacf821973490085798.jpg	沙洲猕猴桃	2024-09-19 04:47:52	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N
134	\N	\N	采茶正当时，赴张湾饮一段春光！	2024-09-18 03:04:38	<h2>采茶正当时，赴张湾饮一段春光！</h2>	22-66ebca4e51ef1017687844.jpg	采茶正当时，赴张湾饮一段春光！	2024-09-19 06:53:02	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N
147	\N	\N	遇尝鸣子菜籽油	2024-09-19 04:48:41	<p>遇尝鸣子菜籽油</p>	yu-chang-ming-zi-cai-zi-you-66ebad29eebd8393198762.jpg	遇尝鸣子菜籽油	2024-09-19 04:48:41	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N
135	\N	\N	甜蜜暴击.ᐟ‪.ᐟ十堰张湾「夏日水果采摘图鉴」来啦~	2024-09-18 03:05:46	<h2>甜蜜暴击.ᐟ‪.ᐟ十堰张湾「夏日水果采摘图鉴」来啦~</h2>	11-66ebca42ba159115919800.jpg	甜蜜暴击.ᐟ‪.ᐟ十堰张湾「夏日水果采摘图鉴」来啦~	2024-09-19 06:52:50	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N
90	\N	\N	十堰邦辉国际大酒店	2024-05-15 05:28:10	<p><span style="background-color:rgb(255,255,255);color:rgb(15,41,77);"><strong>十堰邦辉国际大酒店</strong></span></p>	200g190000017c1el2fce-w-1080-808-r5-d-66ea349ca770f898829100.jpg	十堰邦辉国际大酒店	2024-09-18 02:02:04	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N
141	\N	\N	十堰万达广场	2024-09-19 04:38:41	<p>十堰万达广场</p>	t01efd85ab60f62c9ed-66ebaad1d38a8610403805.jpg	十堰万达广场	2024-09-19 04:38:41	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N
142	\N	\N	招商·兰溪谷	2024-09-19 04:39:34	<h2><strong>招商·兰溪谷</strong></h2>	r-c-66ebab063a3d7659405916.jpeg	招商·兰溪谷	2024-09-19 04:39:34	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N
148	\N	\N	李声平即食风干鱼	2024-09-19 04:51:30	<p>李声平即食风干鱼</p>	2-66ebadd23d5fd771847389.jpg	李声平即食风干鱼	2024-09-19 04:51:30	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N
136	\N	\N	云庐	2024-09-18 08:03:53	<p>云庐</p>	66-66ebbed1cd524323788471.jpg	云庐	2024-09-19 06:04:01	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N
137	\N	\N	月亮边山庄	2024-09-18 08:04:44	<p>月亮边山庄</p>	rn-image-picker-lib-temp-f48d2475-22c4-49d1-93fb-feb56f877248-66ea899c8126f145628411.jpg	月亮边山庄	2024-09-18 08:04:44	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N
94	\N	\N	长河湾景区	2024-05-15 05:43:47	<p>长河湾景区</p>	zhang-he-wan-jing-qu-66e494957fe32510410356.jpg	长河湾景区	2024-09-13 19:37:57	\N	\N	\N	\N	\N	32.631125	110.635083	\N	\N	2	\N	\N
139	\N	\N	知雨轩·庄园	2024-09-18 08:08:10	<p>知雨轩·庄园</p>	rn-image-picker-lib-temp-21887288-c450-4f08-8007-d8f7b7c3c85b-66ea8a6a093b6725920222.jpg	知雨轩·庄园	2024-09-18 08:08:10	\N	\N	\N	\N	\N	32.655645	110.623046	\N	\N	2	\N	\N
84	\N	\N	白马山	2024-05-15 04:11:47	<p>白马山</p>	bai-ma-shan-rui-zhi-min-1-66e494f327114653823154.jpg	白马山	2024-09-13 19:39:31	\N	\N	\N	\N	\N	32.649293	110.574254	\N	\N	2	\N	\N
98	\N	\N	牛斗山国家森林公园	2024-05-15 05:45:19	<p>牛斗山顶</p>	2-66ebbcef47099673861484.jpg	牛斗山顶	2024-09-19 05:55:59	\N	\N	\N	\N	\N	32.597892	110.737022	\N	\N	2	\N	\N
130	\N	\N	十堰市奥林匹克体育中心	2024-09-18 02:45:02	<p>十堰市奥林匹克体育中心</p>	ed11c3ca30f14f7289d48cb6f05aaae6-66ea3eae4f5b8417068920.jpeg	十堰市奥林匹克体育中心	2024-09-18 02:45:02	\N	\N	\N	\N	\N	32.647686	110.806787	\N	\N	2	\N	\N
144	\N	\N	华悦城	2024-09-19 04:42:41	<p>华悦城</p>	oip-c-66ebabc1a4e2a158836502.jpeg	华悦城	2024-09-19 04:42:41	\N	\N	\N	\N	\N	30.34122	110.84034821231	\N	\N	2	\N	\N
140	\N	\N	十堰市图书馆	2024-09-18 08:08:42	<p>十堰市图书馆</p>	rn-image-picker-lib-temp-e40613be-b931-4a42-b7dd-0bc6480d28c9-66ea8a8b02fe6108496344.jpg	十堰市图书馆	2024-09-18 08:08:43	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N
150	\N	\N	谭二拉面馆	2024-10-21 03:02:10	\N	\N	车城小店经典美食	2024-10-21 03:02:10	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	f	\N
100	\N	\N	云水方滩休闲度假区	2024-05-15 05:46:01	<h4><strong>关于</strong></h4><p>云水方滩休闲度假区青山环绕，峡谷幽美，堵河如画，碧水静流，仿佛置身于世外桃源；锦绣园、房车营地、堵河廊道、行人绿道、采摘园、天然草地广场等成为知名网红打卡点；富有水乡渔村文化特色的特色鱼宴产业园更是集商品销售、民俗体验、乡土美食于一体的新体验地。</p>	yun-shui-fang-tan-du-he-hua-lang-kang-yang-lu-you-du-jia-qu-jian-shan-cha-she-wai-guan-66e49391eb54c947037806.jpg	云水方滩休闲度假区	2024-10-22 15:05:52	\N	\N	\N	\N	\N	32.737731	110.606084	\N	\N	2	\N	zhu-su-3x-6717bf50483f2972649824.png
95	\N	\N	回龙村荷花盛开	2024-05-15 05:44:06	<p>回龙村荷花盛开</p>	hui-long-cun-he-hua-sheng-kai-66e4947140dcd574942165.jpg	回龙村荷花盛开，赏花。	2024-09-13 19:37:21	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N
149	\N	\N	四方山徒步	2024-10-13 20:54:04	<p>活动简介本次活动旨在加强人们的锻炼，由主办单位主办活动简介本次活动旨在加强人们的锻炼，由主办单位主办活动简介本次活动旨在加强人们的锻炼，由主办单位主办活动简介本次活动旨在加强人们的锻炼，由主办单位主办活动简介本次活动旨在加强人们。</p>	1-670c847cba7d5094122683.jpg	活动简介本次活动旨在加强人们的锻炼，由主办单位主\r\n办活动简介本次活动旨在加强人们的锻炼，由主办单位\r\n主办活动简介本次活动旨在加强人们的锻炼，由主办单\r\n位主办活动简介本次活动旨在加强人们的锻炼，由主办\r\n单位主办活动简介本次活动旨在加强人们。	2024-10-14 02:39:56	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	\N	\N
\.


--
-- Data for Name: node_region; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public.node_region (node_id, region_id) FROM stdin;
149	40
148	31
99	41
99	40
95	41
95	40
94	41
94	40
140	42
131	42
130	42
149	42
135	42
134	42
142	43
141	43
143	43
144	43
136	43
138	43
149	41
135	41
100	41
84	27
85	27
89	29
90	29
91	29
93	27
94	27
95	27
96	27
97	27
98	27
99	27
100	27
126	29
130	36
131	36
136	29
137	29
138	29
139	29
140	36
141	39
142	39
143	39
144	39
139	31
137	31
136	31
138	31
150	31
100	44
99	44
98	44
97	44
96	44
95	44
94	44
93	44
91	44
90	44
85	44
84	44
\.


--
-- Data for Name: node_tag; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public.node_tag (node_id, tag_id) FROM stdin;
\.


--
-- Data for Name: order; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public."order" (id, node_id, consumer_id, quantity, amount, created_at, paid_at, used_at, status, price, cancelled_at, refunded_at, deleted_at, sn, wx_trans_id, bank_type, wx_prepay_id, deleted) FROM stdin;
\.


--
-- Data for Name: page; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public.page (id, name, label, weight) FROM stdin;
1	首页	home	\N
4	联系我们	contact	\N
3	版块	leyou	\N
\.


--
-- Data for Name: refund; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public.refund (id, ord_id, created_at, reason, note, sn, wx_refund_id) FROM stdin;
\.


--
-- Data for Name: region; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public.region (id, name, label, count, icon, fields, description, page_id, weight, marker, created_at, updated_at) FROM stdin;
35	房间	rooms	1	list	\N	\N	\N	\N	\N	\N	\N
25	幻灯片1	slider1	5	list	image,body	\N	\N	\N	\N	\N	\N
13	投诉建议	feedback	1	list	summary	\N	\N	\N	\N	\N	\N
29	住宿	zhu	6	list	summary,image,specs,body,tags,coord	\N	3	\N	\N	\N	\N
31	美食	shi	8	list	summary,image,body,coord,specs	\N	3	\N	\N	\N	\N
36	文创	wen	1	list	body,image,summary,tags,coord	\N	3	\N	\N	\N	\N
39	购物	gou	1	list	body,image,summary,tags,coord	\N	3	\N	\N	\N	\N
40	活动	dong	1	list	body,image,summary,tags,createdAt,coord	\N	3	\N	\N	\N	\N
41	玩法	wan	1	list	body,image,summary,tags,createdAt,coord	\N	3	\N	\N	\N	\N
42	艺动	yi	1	list	body,image,summary,tags,createdAt,coord	\N	3	\N	\N	\N	\N
44	热聊	talk	1	list	createdAt,body,image,summary,tags	\N	3	\N	mei-shi-3x-6717bbca4cf03510615090.png	\N	2024-10-22 14:50:50
27	景点	jing	10	list	summary,image,body,coord,tags,marker	\N	3	\N	jiu-dian-3x-6717bf72e7d3f860786186.png	\N	2024-10-22 15:06:26
43	门店	shop	1	\N	body,image,summary,createdAt	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: spec; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public.spec (id, node_id, name, value) FROM stdin;
15	90	TEL	民宿电话：0719-8310588
14	89	TEL	民宿电话：0719-8310588
16	91	TEL	民宿电话：0719-8457770
\.


--
-- Data for Name: tag; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public.tag (id, name, label) FROM stdin;
\.


--
-- Data for Name: up; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public.up (id, node_id, u_id, created_at, comment_id) FROM stdin;
1	\N	5	2024-10-22 11:22:31	23
2	\N	5	2024-10-22 11:24:17	22
3	\N	5	2024-10-22 11:24:18	21
4	\N	5	2024-10-22 11:24:21	20
5	\N	5	2024-10-22 11:24:42	19
6	\N	5	2024-10-22 11:35:31	24
7	\N	5	2024-10-22 11:37:02	25
8	\N	5	2024-10-22 11:37:57	27
9	\N	5	2024-10-22 11:37:58	26
10	\N	5	2024-10-22 11:41:45	29
11	\N	5	2024-10-22 11:41:47	28
12	\N	5	2024-10-22 11:42:03	18
13	\N	5	2024-10-22 11:42:06	16
14	\N	5	2024-10-22 11:42:07	17
15	\N	5	2024-10-22 11:42:08	15
16	\N	5	2024-10-22 11:53:09	31
19	\N	5	2024-10-22 11:59:51	32
20	\N	5	2024-10-22 11:59:53	30
21	\N	5	2024-10-22 13:57:45	33
22	\N	5	2024-10-22 13:58:48	34
23	\N	5	2024-10-22 14:00:06	35
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public."user" (id, username, roles, password, plain_password, openid, name, phone, avatar) FROM stdin;
5	oZkmM7Rbd8fp9fQN3_WLJxpju6K8	[]	$2y$13$XMS5jp0Eg1oy1sZiF.bn0e5BmlwYzmOJ6YtWwj6R0B36xGsGb541e	\N	oZkmM7Rbd8fp9fQN3_WLJxpju6K8	用户ju6K8	\N	671719bb6c13f-IUVebl87xXAU405e9a1ec76a3dcc4ef448bae3bbb3e6.jpeg
8	test	[]	$2y$13$.yKUmknIiD/xeNMPm0mhhuodGnQpDysxqH7ISVsg7L2vBY9eTnobm	\N	\N	test	\N	avatar.jpg
6	oZkmM7ZXwrSLOHxN0UuUsyOajzco	[]	$2y$13$N36HzEkD9vCMNBi56A1YDuNbd8dK1ZuMz3wUbKRNwyz/Zcy/e4aQq	\N	oZkmM7ZXwrSLOHxN0UuUsyOajzco	用户ajzco	\N	avatar.jpg
2	al	["ROLE_SUPER_ADMIN"]	$2y$13$KpK7xAC8vlandkObN9kC4OAZVFw7SLtJvpf3PHICo4shV4haht9iK	\N	\N	子安	\N	avatar.jpg
3	root	["ROLE_SUPER_ADMIN","ROLE_ADMIN"]	$2y$13$vjcnglByWqC.GHCDZ3xIpuzHgPXtZ0mGvR5GPgXx7SBrGZRTTrmxi	\N	\N	子瞻	\N	avatar.jpg
1	admin	["ROLE_ADMIN"]	$2y$13$vfGjflZWMSRJ2lay3y.2kOitiuI/C.ps9CVHc3WfF63fl/CvY3Cmi	\N	\N	子由	\N	avatar.jpg
\.


--
-- Name: category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zw
--

SELECT pg_catalog.setval('public.category_id_seq', 5, true);


--
-- Name: comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zw
--

SELECT pg_catalog.setval('public.comment_id_seq', 35, true);


--
-- Name: conf_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zw
--

SELECT pg_catalog.setval('public.conf_id_seq', 1, true);


--
-- Name: down_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zw
--

SELECT pg_catalog.setval('public.down_id_seq', 1, false);


--
-- Name: fav_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zw
--

SELECT pg_catalog.setval('public.fav_id_seq', 14, true);


--
-- Name: feedback_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zw
--

SELECT pg_catalog.setval('public.feedback_id_seq', 7, true);


--
-- Name: image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zw
--

SELECT pg_catalog.setval('public.image_id_seq', 5, true);


--
-- Name: language_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zw
--

SELECT pg_catalog.setval('public.language_id_seq', 1, false);


--
-- Name: like_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zw
--

SELECT pg_catalog.setval('public.like_id_seq', 10, true);


--
-- Name: link_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zw
--

SELECT pg_catalog.setval('public.link_id_seq', 7, true);


--
-- Name: menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zw
--

SELECT pg_catalog.setval('public.menu_id_seq', 3, true);


--
-- Name: messenger_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zw
--

SELECT pg_catalog.setval('public.messenger_messages_id_seq', 1, false);


--
-- Name: node_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zw
--

SELECT pg_catalog.setval('public.node_id_seq', 150, true);


--
-- Name: order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zw
--

SELECT pg_catalog.setval('public.order_id_seq', 1, false);


--
-- Name: page_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zw
--

SELECT pg_catalog.setval('public.page_id_seq', 4, true);


--
-- Name: refund_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zw
--

SELECT pg_catalog.setval('public.refund_id_seq', 1, false);


--
-- Name: region_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zw
--

SELECT pg_catalog.setval('public.region_id_seq', 44, true);


--
-- Name: spec_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zw
--

SELECT pg_catalog.setval('public.spec_id_seq', 18, true);


--
-- Name: tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zw
--

SELECT pg_catalog.setval('public.tag_id_seq', 2, true);


--
-- Name: up_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zw
--

SELECT pg_catalog.setval('public.up_id_seq', 23, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zw
--

SELECT pg_catalog.setval('public.user_id_seq', 8, true);


--
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


--
-- Name: comment comment_pkey; Type: CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (id);


--
-- Name: conf conf_pkey; Type: CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.conf
    ADD CONSTRAINT conf_pkey PRIMARY KEY (id);


--
-- Name: doctrine_migration_versions doctrine_migration_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.doctrine_migration_versions
    ADD CONSTRAINT doctrine_migration_versions_pkey PRIMARY KEY (version);


--
-- Name: down down_pkey; Type: CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.down
    ADD CONSTRAINT down_pkey PRIMARY KEY (id);


--
-- Name: fav fav_pkey; Type: CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.fav
    ADD CONSTRAINT fav_pkey PRIMARY KEY (id);


--
-- Name: feedback feedback_pkey; Type: CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT feedback_pkey PRIMARY KEY (id);


--
-- Name: image image_pkey; Type: CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.image
    ADD CONSTRAINT image_pkey PRIMARY KEY (id);


--
-- Name: language language_pkey; Type: CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.language
    ADD CONSTRAINT language_pkey PRIMARY KEY (id);


--
-- Name: like like_pkey; Type: CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public."like"
    ADD CONSTRAINT like_pkey PRIMARY KEY (id);


--
-- Name: link link_pkey; Type: CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.link
    ADD CONSTRAINT link_pkey PRIMARY KEY (id);


--
-- Name: menu menu_pkey; Type: CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.menu
    ADD CONSTRAINT menu_pkey PRIMARY KEY (id);


--
-- Name: messenger_messages messenger_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.messenger_messages
    ADD CONSTRAINT messenger_messages_pkey PRIMARY KEY (id);


--
-- Name: node node_pkey; Type: CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.node
    ADD CONSTRAINT node_pkey PRIMARY KEY (id);


--
-- Name: node_region node_region_pkey; Type: CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.node_region
    ADD CONSTRAINT node_region_pkey PRIMARY KEY (node_id, region_id);


--
-- Name: node_tag node_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.node_tag
    ADD CONSTRAINT node_tag_pkey PRIMARY KEY (node_id, tag_id);


--
-- Name: order order_pkey; Type: CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_pkey PRIMARY KEY (id);


--
-- Name: page page_pkey; Type: CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.page
    ADD CONSTRAINT page_pkey PRIMARY KEY (id);


--
-- Name: refund refund_pkey; Type: CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.refund
    ADD CONSTRAINT refund_pkey PRIMARY KEY (id);


--
-- Name: region region_pkey; Type: CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.region
    ADD CONSTRAINT region_pkey PRIMARY KEY (id);


--
-- Name: spec spec_pkey; Type: CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.spec
    ADD CONSTRAINT spec_pkey PRIMARY KEY (id);


--
-- Name: tag tag_pkey; Type: CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tag_pkey PRIMARY KEY (id);


--
-- Name: up up_pkey; Type: CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.up
    ADD CONSTRAINT up_pkey PRIMARY KEY (id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: idx_14f389a882f1baf4; Type: INDEX; Schema: public; Owner: zw
--

CREATE INDEX idx_14f389a882f1baf4 ON public.conf USING btree (language_id);


--
-- Name: idx_1cff903b460d9fd7; Type: INDEX; Schema: public; Owner: zw
--

CREATE INDEX idx_1cff903b460d9fd7 ON public.down USING btree (node_id);


--
-- Name: idx_1cff903be4a59390; Type: INDEX; Schema: public; Owner: zw
--

CREATE INDEX idx_1cff903be4a59390 ON public.down USING btree (u_id);


--
-- Name: idx_1cff903bf8697d13; Type: INDEX; Schema: public; Owner: zw
--

CREATE INDEX idx_1cff903bf8697d13 ON public.down USING btree (comment_id);


--
-- Name: idx_36ac99f1ccd7e912; Type: INDEX; Schema: public; Owner: zw
--

CREATE INDEX idx_36ac99f1ccd7e912 ON public.link USING btree (menu_id);


--
-- Name: idx_4394ee70460d9fd7; Type: INDEX; Schema: public; Owner: zw
--

CREATE INDEX idx_4394ee70460d9fd7 ON public.up USING btree (node_id);


--
-- Name: idx_4394ee70e4a59390; Type: INDEX; Schema: public; Owner: zw
--

CREATE INDEX idx_4394ee70e4a59390 ON public.up USING btree (u_id);


--
-- Name: idx_4394ee70f8697d13; Type: INDEX; Schema: public; Owner: zw
--

CREATE INDEX idx_4394ee70f8697d13 ON public.up USING btree (comment_id);


--
-- Name: idx_70ac95f8460d9fd7; Type: INDEX; Schema: public; Owner: zw
--

CREATE INDEX idx_70ac95f8460d9fd7 ON public.node_tag USING btree (node_id);


--
-- Name: idx_70ac95f8bad26311; Type: INDEX; Schema: public; Owner: zw
--

CREATE INDEX idx_70ac95f8bad26311 ON public.node_tag USING btree (tag_id);


--
-- Name: idx_75ea56e016ba31db; Type: INDEX; Schema: public; Owner: zw
--

CREATE INDEX idx_75ea56e016ba31db ON public.messenger_messages USING btree (delivered_at);


--
-- Name: idx_75ea56e0e3bd61ce; Type: INDEX; Schema: public; Owner: zw
--

CREATE INDEX idx_75ea56e0e3bd61ce ON public.messenger_messages USING btree (available_at);


--
-- Name: idx_75ea56e0fb7336f0; Type: INDEX; Schema: public; Owner: zw
--

CREATE INDEX idx_75ea56e0fb7336f0 ON public.messenger_messages USING btree (queue_name);


--
-- Name: idx_769be06f460d9fd7; Type: INDEX; Schema: public; Owner: zw
--

CREATE INDEX idx_769be06f460d9fd7 ON public.fav USING btree (node_id);


--
-- Name: idx_769be06fe4a59390; Type: INDEX; Schema: public; Owner: zw
--

CREATE INDEX idx_769be06fe4a59390 ON public.fav USING btree (u_id);


--
-- Name: idx_857fe84512469de2; Type: INDEX; Schema: public; Owner: zw
--

CREATE INDEX idx_857fe84512469de2 ON public.node USING btree (category_id);


--
-- Name: idx_857fe845727aca70; Type: INDEX; Schema: public; Owner: zw
--

CREATE INDEX idx_857fe845727aca70 ON public.node USING btree (parent_id);


--
-- Name: idx_857fe84582f1baf4; Type: INDEX; Schema: public; Owner: zw
--

CREATE INDEX idx_857fe84582f1baf4 ON public.node USING btree (language_id);


--
-- Name: idx_857fe845f675f31b; Type: INDEX; Schema: public; Owner: zw
--

CREATE INDEX idx_857fe845f675f31b ON public.node USING btree (author_id);


--
-- Name: idx_9474526c460d9fd7; Type: INDEX; Schema: public; Owner: zw
--

CREATE INDEX idx_9474526c460d9fd7 ON public.comment USING btree (node_id);


--
-- Name: idx_9474526cf675f31b; Type: INDEX; Schema: public; Owner: zw
--

CREATE INDEX idx_9474526cf675f31b ON public.comment USING btree (author_id);


--
-- Name: idx_ac6340b3460d9fd7; Type: INDEX; Schema: public; Owner: zw
--

CREATE INDEX idx_ac6340b3460d9fd7 ON public."like" USING btree (node_id);


--
-- Name: idx_ac6340b3e4a59390; Type: INDEX; Schema: public; Owner: zw
--

CREATE INDEX idx_ac6340b3e4a59390 ON public."like" USING btree (u_id);


--
-- Name: idx_bb70e4d3460d9fd7; Type: INDEX; Schema: public; Owner: zw
--

CREATE INDEX idx_bb70e4d3460d9fd7 ON public.node_region USING btree (node_id);


--
-- Name: idx_bb70e4d398260155; Type: INDEX; Schema: public; Owner: zw
--

CREATE INDEX idx_bb70e4d398260155 ON public.node_region USING btree (region_id);


--
-- Name: idx_c00e173e460d9fd7; Type: INDEX; Schema: public; Owner: zw
--

CREATE INDEX idx_c00e173e460d9fd7 ON public.spec USING btree (node_id);


--
-- Name: idx_c53d045f460d9fd7; Type: INDEX; Schema: public; Owner: zw
--

CREATE INDEX idx_c53d045f460d9fd7 ON public.image USING btree (node_id);


--
-- Name: idx_d2294458460d9fd7; Type: INDEX; Schema: public; Owner: zw
--

CREATE INDEX idx_d2294458460d9fd7 ON public.feedback USING btree (node_id);


--
-- Name: idx_f529939837fdbd6d; Type: INDEX; Schema: public; Owner: zw
--

CREATE INDEX idx_f529939837fdbd6d ON public."order" USING btree (consumer_id);


--
-- Name: idx_f5299398460d9fd7; Type: INDEX; Schema: public; Owner: zw
--

CREATE INDEX idx_f5299398460d9fd7 ON public."order" USING btree (node_id);


--
-- Name: idx_f62f176c4663e4; Type: INDEX; Schema: public; Owner: zw
--

CREATE INDEX idx_f62f176c4663e4 ON public.region USING btree (page_id);


--
-- Name: uniq_5b2c1458e636d3f5; Type: INDEX; Schema: public; Owner: zw
--

CREATE UNIQUE INDEX uniq_5b2c1458e636d3f5 ON public.refund USING btree (ord_id);


--
-- Name: uniq_8d93d649f85e0677; Type: INDEX; Schema: public; Owner: zw
--

CREATE UNIQUE INDEX uniq_8d93d649f85e0677 ON public."user" USING btree (username);


--
-- Name: messenger_messages notify_trigger; Type: TRIGGER; Schema: public; Owner: zw
--

CREATE TRIGGER notify_trigger AFTER INSERT OR UPDATE ON public.messenger_messages FOR EACH ROW EXECUTE FUNCTION public.notify_messenger_messages();


--
-- Name: conf fk_14f389a882f1baf4; Type: FK CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.conf
    ADD CONSTRAINT fk_14f389a882f1baf4 FOREIGN KEY (language_id) REFERENCES public.language(id);


--
-- Name: down fk_1cff903b460d9fd7; Type: FK CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.down
    ADD CONSTRAINT fk_1cff903b460d9fd7 FOREIGN KEY (node_id) REFERENCES public.node(id);


--
-- Name: down fk_1cff903be4a59390; Type: FK CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.down
    ADD CONSTRAINT fk_1cff903be4a59390 FOREIGN KEY (u_id) REFERENCES public."user"(id);


--
-- Name: down fk_1cff903bf8697d13; Type: FK CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.down
    ADD CONSTRAINT fk_1cff903bf8697d13 FOREIGN KEY (comment_id) REFERENCES public.comment(id);


--
-- Name: link fk_36ac99f1ccd7e912; Type: FK CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.link
    ADD CONSTRAINT fk_36ac99f1ccd7e912 FOREIGN KEY (menu_id) REFERENCES public.menu(id);


--
-- Name: up fk_4394ee70460d9fd7; Type: FK CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.up
    ADD CONSTRAINT fk_4394ee70460d9fd7 FOREIGN KEY (node_id) REFERENCES public.node(id);


--
-- Name: up fk_4394ee70e4a59390; Type: FK CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.up
    ADD CONSTRAINT fk_4394ee70e4a59390 FOREIGN KEY (u_id) REFERENCES public."user"(id);


--
-- Name: up fk_4394ee70f8697d13; Type: FK CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.up
    ADD CONSTRAINT fk_4394ee70f8697d13 FOREIGN KEY (comment_id) REFERENCES public.comment(id);


--
-- Name: refund fk_5b2c1458e636d3f5; Type: FK CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.refund
    ADD CONSTRAINT fk_5b2c1458e636d3f5 FOREIGN KEY (ord_id) REFERENCES public."order"(id);


--
-- Name: node_tag fk_70ac95f8460d9fd7; Type: FK CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.node_tag
    ADD CONSTRAINT fk_70ac95f8460d9fd7 FOREIGN KEY (node_id) REFERENCES public.node(id) ON DELETE CASCADE;


--
-- Name: node_tag fk_70ac95f8bad26311; Type: FK CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.node_tag
    ADD CONSTRAINT fk_70ac95f8bad26311 FOREIGN KEY (tag_id) REFERENCES public.tag(id) ON DELETE CASCADE;


--
-- Name: fav fk_769be06f460d9fd7; Type: FK CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.fav
    ADD CONSTRAINT fk_769be06f460d9fd7 FOREIGN KEY (node_id) REFERENCES public.node(id);


--
-- Name: fav fk_769be06fe4a59390; Type: FK CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.fav
    ADD CONSTRAINT fk_769be06fe4a59390 FOREIGN KEY (u_id) REFERENCES public."user"(id);


--
-- Name: node fk_857fe84512469de2; Type: FK CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.node
    ADD CONSTRAINT fk_857fe84512469de2 FOREIGN KEY (category_id) REFERENCES public.category(id);


--
-- Name: node fk_857fe845727aca70; Type: FK CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.node
    ADD CONSTRAINT fk_857fe845727aca70 FOREIGN KEY (parent_id) REFERENCES public.node(id);


--
-- Name: node fk_857fe84582f1baf4; Type: FK CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.node
    ADD CONSTRAINT fk_857fe84582f1baf4 FOREIGN KEY (language_id) REFERENCES public.language(id);


--
-- Name: node fk_857fe845f675f31b; Type: FK CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.node
    ADD CONSTRAINT fk_857fe845f675f31b FOREIGN KEY (author_id) REFERENCES public."user"(id);


--
-- Name: comment fk_9474526c460d9fd7; Type: FK CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT fk_9474526c460d9fd7 FOREIGN KEY (node_id) REFERENCES public.node(id);


--
-- Name: comment fk_9474526cf675f31b; Type: FK CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT fk_9474526cf675f31b FOREIGN KEY (author_id) REFERENCES public."user"(id);


--
-- Name: like fk_ac6340b3460d9fd7; Type: FK CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public."like"
    ADD CONSTRAINT fk_ac6340b3460d9fd7 FOREIGN KEY (node_id) REFERENCES public.node(id);


--
-- Name: like fk_ac6340b3e4a59390; Type: FK CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public."like"
    ADD CONSTRAINT fk_ac6340b3e4a59390 FOREIGN KEY (u_id) REFERENCES public."user"(id);


--
-- Name: node_region fk_bb70e4d3460d9fd7; Type: FK CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.node_region
    ADD CONSTRAINT fk_bb70e4d3460d9fd7 FOREIGN KEY (node_id) REFERENCES public.node(id) ON DELETE CASCADE;


--
-- Name: node_region fk_bb70e4d398260155; Type: FK CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.node_region
    ADD CONSTRAINT fk_bb70e4d398260155 FOREIGN KEY (region_id) REFERENCES public.region(id) ON DELETE CASCADE;


--
-- Name: spec fk_c00e173e460d9fd7; Type: FK CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.spec
    ADD CONSTRAINT fk_c00e173e460d9fd7 FOREIGN KEY (node_id) REFERENCES public.node(id);


--
-- Name: image fk_c53d045f460d9fd7; Type: FK CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.image
    ADD CONSTRAINT fk_c53d045f460d9fd7 FOREIGN KEY (node_id) REFERENCES public.node(id);


--
-- Name: feedback fk_d2294458460d9fd7; Type: FK CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT fk_d2294458460d9fd7 FOREIGN KEY (node_id) REFERENCES public.node(id);


--
-- Name: order fk_f529939837fdbd6d; Type: FK CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT fk_f529939837fdbd6d FOREIGN KEY (consumer_id) REFERENCES public."user"(id);


--
-- Name: order fk_f5299398460d9fd7; Type: FK CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT fk_f5299398460d9fd7 FOREIGN KEY (node_id) REFERENCES public.node(id);


--
-- Name: region fk_f62f176c4663e4; Type: FK CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.region
    ADD CONSTRAINT fk_f62f176c4663e4 FOREIGN KEY (page_id) REFERENCES public.page(id);


--
-- PostgreSQL database dump complete
--

