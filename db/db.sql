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
-- Name: area; Type: TABLE; Schema: public; Owner: zw
--

CREATE TABLE public.area (
    id integer NOT NULL,
    label character varying(255) NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.area OWNER TO zw;

--
-- Name: area_id_seq; Type: SEQUENCE; Schema: public; Owner: zw
--

CREATE SEQUENCE public.area_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.area_id_seq OWNER TO zw;

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
    type smallint,
    status smallint NOT NULL,
    u_id integer,
    created_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.feedback OWNER TO zw;

--
-- Name: COLUMN feedback.created_at; Type: COMMENT; Schema: public; Owner: zw
--

COMMENT ON COLUMN public.feedback.created_at IS '(DC2Type:datetime_immutable)';


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
    node_id integer,
    image character varying(255) NOT NULL,
    title character varying(255) DEFAULT NULL::character varying,
    plan_id integer
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
    marker character varying(255) DEFAULT NULL::character varying,
    start_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    end_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    note character varying(255) DEFAULT NULL::character varying,
    area_id integer
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
-- Name: COLUMN node.start_at; Type: COMMENT; Schema: public; Owner: zw
--

COMMENT ON COLUMN public.node.start_at IS '(DC2Type:datetime_immutable)';


--
-- Name: COLUMN node.end_at; Type: COMMENT; Schema: public; Owner: zw
--

COMMENT ON COLUMN public.node.end_at IS '(DC2Type:datetime_immutable)';


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
-- Name: plan; Type: TABLE; Schema: public; Owner: zw
--

CREATE TABLE public.plan (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    month smallint,
    days smallint,
    cost integer,
    who character varying(255) DEFAULT NULL::character varying,
    body text,
    summary text,
    u_id integer NOT NULL,
    node_id integer
);


ALTER TABLE public.plan OWNER TO zw;

--
-- Name: plan_id_seq; Type: SEQUENCE; Schema: public; Owner: zw
--

CREATE SEQUENCE public.plan_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.plan_id_seq OWNER TO zw;

--
-- Name: rate; Type: TABLE; Schema: public; Owner: zw
--

CREATE TABLE public.rate (
    id integer NOT NULL,
    node_id integer NOT NULL,
    u_id integer NOT NULL,
    created_at timestamp(0) without time zone NOT NULL,
    rate double precision NOT NULL
);


ALTER TABLE public.rate OWNER TO zw;

--
-- Name: COLUMN rate.created_at; Type: COMMENT; Schema: public; Owner: zw
--

COMMENT ON COLUMN public.rate.created_at IS '(DC2Type:datetime_immutable)';


--
-- Name: rate_id_seq; Type: SEQUENCE; Schema: public; Owner: zw
--

CREATE SEQUENCE public.rate_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rate_id_seq OWNER TO zw;

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
-- Name: step; Type: TABLE; Schema: public; Owner: zw
--

CREATE TABLE public.step (
    id integer NOT NULL,
    plan_id integer NOT NULL,
    datetime timestamp(0) without time zone NOT NULL,
    body text
);


ALTER TABLE public.step OWNER TO zw;

--
-- Name: COLUMN step.datetime; Type: COMMENT; Schema: public; Owner: zw
--

COMMENT ON COLUMN public.step.datetime IS '(DC2Type:datetime_immutable)';


--
-- Name: step_id_seq; Type: SEQUENCE; Schema: public; Owner: zw
--

CREATE SEQUENCE public.step_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.step_id_seq OWNER TO zw;

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
-- Data for Name: area; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public.area (id, label, name) FROM stdin;
1	hongweijiedao	红卫街道
2	huaguojiedao	花果街道
3	huanglongzhen	黄龙镇
4	xigouxiang	西沟乡
5	fangtanxiang	方滩乡
\.


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public.category (id, name, label) FROM stdin;
6	星级	xingji
7	农家乐	nongjiale
10	烧烤	shaokao
11	海鲜	haixian
12	特色	tese
13	夜市	yeshi
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
36	149	5	test2	2024-10-23 13:36:43	0	0	f
37	191	5	test5	2024-10-23 14:13:15	0	0	f
38	159	5	test1	2024-10-23 22:32:48	0	0	f
39	181	5	111	2024-10-26 08:10:41	0	0	f
40	159	5	t2	2024-10-26 08:16:15	0	0	f
41	181	5	t3	2024-10-26 08:57:58	0	0	f
42	181	5	t4	2024-10-26 08:58:07	0	0	f
43	159	5	t5	2024-10-27 06:36:01	0	0	f
44	149	5	test5	2024-10-27 06:48:49	0	0	f
45	149	5	t6	2024-10-27 06:49:11	0	0	f
46	149	5	t7	2024-10-27 06:50:00	0	0	f
47	149	5	t666	2024-10-27 06:51:03	0	0	f
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
DoctrineMigrations\\Version20241023100637	2024-10-23 10:06:53	59
DoctrineMigrations\\Version20241023113227	2024-10-23 11:32:31	13
DoctrineMigrations\\Version20241023125604	2024-10-23 12:56:16	8
DoctrineMigrations\\Version20241026091811	2024-10-26 09:18:44	31
DoctrineMigrations\\Version20241026092532	2024-10-26 09:25:43	57
DoctrineMigrations\\Version20241026093431	2024-10-26 09:34:36	32
DoctrineMigrations\\Version20241026095048	2024-10-26 09:50:55	13
DoctrineMigrations\\Version20241026102520	2024-10-26 10:25:23	18
DoctrineMigrations\\Version20241026105319	2024-10-26 10:53:39	9
DoctrineMigrations\\Version20241027101206	2024-10-27 10:12:10	36
DoctrineMigrations\\Version20241027101303	2024-10-27 10:13:10	21
DoctrineMigrations\\Version20241027150646	2024-10-27 15:06:50	25
DoctrineMigrations\\Version20241027174934	2024-10-27 17:49:38	12
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
72	180	5	2024-10-26 08:10:32
73	149	5	2024-10-26 08:16:31
76	160	5	2024-10-27 07:05:31
78	159	5	2024-10-27 08:46:21
77	159	5	2024-10-27 08:46:21
\.


--
-- Data for Name: feedback; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public.feedback (id, node_id, firstname, lastname, email, phone, title, body, country, sex, province, city, note, name, type, status, u_id, created_at) FROM stdin;
14	\N	\N	\N	\N	\N	t1	t1	\N	\N	\N	\N	\N	\N	1	0	5	2024-10-27 18:45:42
15	\N	\N	\N	\N	\N	t4	t4	\N	\N	\N	\N	\N	\N	1	0	5	2024-10-27 18:46:06
\.


--
-- Data for Name: image; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public.image (id, node_id, image, title, plan_id) FROM stdin;
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
11	160	5	2024-10-26 05:27:50
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

COPY public.node (id, language_id, category_id, title, created_at, body, image, summary, updated_at, video, parent_id, audio, qr, phone, latitude, longitude, address, price, author_id, deleted, marker, start_at, end_at, note, area_id) FROM stdin;
158	\N	\N	青龙山文化旅游度假区	2024-10-23 06:45:29	<p>该项目位于花果街道花园村，占地面积约160亩，建设内容包括木屋改造、花雾人间景观农田改造、玉皇宫建筑外观及景观提升等内容。园区内部将进行道路新建改建，木屋酒店改造，管线综合改造，水流域综合治理，山野景观综合提升等内容。同时，打造入口景观、建设田野餐吧+农产品销售、户外用品商店+麦田咖啡+露天酒吧、帐篷营地及亲子设施。对于古龙泉寺遗址保留遗址原貌，轻介入打造考古研学户外课堂。</p>	2-67199abfb75e7812060586.jpg	青龙山文化旅游度假区	2024-10-24 00:54:23	\N	\N	\N	\N	\N	32.668637	110.672207	十堰市张湾区花果街道花园村	13800	2	f	\N	\N	\N	\N	\N
211	\N	\N	常隆水上乐园	2024-10-24 02:52:02	<p><strong>介绍</strong></p><p>十堰常隆水上乐园占地近百亩，是集娱乐、休闲、美食为一体的大型主题水上乐园。景区位于张湾区郧阳路双楼门村碾子沟（十堰西高速出口往凯旋大道方向200米处） 新的水上乐园，占地四万余平方米，是集娱乐，餐饮美食，商务休闲等一体化的大型主题水上乐园。</p><p>水上乐园共分4大区域，分别为儿童区(Kid's Pool Phase)、尖叫区(Splash Pool Phase)、冲浪区(Wave Pool Phase)和漂流区(Lazy River Phase)。每个区域都有不一样的玩法，不管是大人还是小朋友，都能在这里全方位地体验不同的乐趣。 尖叫区包含了冲天回旋滑梯、黑洞大喇叭等设施，以追求刺激为主，特别是黑洞大喇叭，4个人乘坐充气伐，从十几米高处滑下，那酸爽，简直无法用言语形容。</p><p>常隆水上乐园经过全面升级改造后拥有更大的停车场，设有1000+停车位解决你的停车问题。儿童水寨池新增1500平方米自动遮阳蓬标准游泳池新增1050平方米自动遮阳蓬，露天水上乐园拒绝紫外线的照射。色彩缤纷的地面让你置身于童话般的世界中。园区内新增多种特色小吃，全天吃喝玩乐，尽享畅快。</p><p><strong>开放时间</strong></p><p>全年 10:00-20:00开放</p><p><strong>优待政策</strong></p><p>补充说明：1、优待政策：身高1.4米（含）以下儿童可购优待票。2、以上信息仅供参考，具体信息请以景区当天披露为准。</p>	1-6719b6533e0b6138098146.jpg	十堰常隆水上乐园占地近百亩，是集娱乐、休闲、美食为一体的大型主题水上乐园。景区位于张湾区郧阳路双楼门村碾子沟（十堰西高速出口往凯旋大道方向200米处） 新的水上乐园，占地四万余平方米，是集娱乐，餐饮美食，商务休闲等一体化的大型主题水上乐园。	2024-10-24 02:52:03	\N	\N	\N	\N	\N	\N	\N	\N	17400	2	f	\N	\N	\N	\N	\N
149	\N	\N	四方山徒步	2024-10-13 20:54:04	<p>活动简介本次活动旨在加强人们的锻炼，由主办单位主办活动简介本次活动旨在加强人们的锻炼，由主办单位主办活动简介本次活动旨在加强人们的锻炼，由主办单位主办活动简介本次活动旨在加强人们的锻炼，由主办单位主办活动简介本次活动旨在加强人们。</p>	1-670c847cba7d5094122683.jpg	活动简介本次活动旨在加强人们的锻炼，由主办单位主\r\n办活动简介本次活动旨在加强人们的锻炼，由主办单位\r\n主办活动简介本次活动旨在加强人们的锻炼，由主办单\r\n位主办活动简介本次活动旨在加强人们的锻炼，由主办\r\n单位主办活动简介本次活动旨在加强人们。	2024-10-14 02:39:56	\N	\N	\N	\N	\N	\N	\N	四方山广场	13100	2	\N	\N	2024-10-07 00:00:00	2024-11-15 00:00:00	四方山管理中心	\N
156	\N	\N	方滩云水街	2024-10-23 06:44:54	<p>位于张湾区方滩乡，是张湾区倾心打造的以水乡文化、特色鱼宴为主题，集自然风光、民俗体验、餐饮住宿和休闲娱乐于一体的多功能综合性商业街区。青山绿水、白云悠悠，小溪流水、廊桥卧波，山长青、水碧绿，这里宛若仙境。每一个场景都是一幅画，每一个街角都能打卡，依托特有的山水景观优势，云水街目前已引入云隐·汉水驿、方滩院子、郧府三合汤等商家，植入特色业态为云水街“塑魂”，街区不仅保留了本地域原有的建筑风貌，更融入了传统与现代元素。走进云水街，穿过一条条小巷，这里亭台楼阁，池馆水榭，映在香樟翠柏之中。假山怪石，花坛盆景；藤萝翠竹，点缀其间；一步一景，千姿百态。站在云水街的楼阁上观景，置身其间，仿若云朵就在脚下。漫步在古色古香的街道上，欣赏各种传统艺术品，品尝特色美食。如今的方滩乡，面貌焕然一新，一条集艺术潮流、创意文化、古村乡愁等为一体的特色街区已初步形成。</p>	1-67199b3306f9d890674175.jpg	方滩云水街	2024-10-24 00:56:19	\N	\N	\N	\N	\N	32.737731	110.606084	十堰市张湾区方滩乡方滩村	6200	2	f	\N	\N	\N	\N	\N
212	\N	\N	白马山旅游区	2024-10-24 02:53:15	<p><strong>介绍</strong></p><p>白马山旅游区山行似马，山顶经常白云缭绕，有财神庙、五仙庙、龙头香等众多历史文化遗址。</p>	0106s12000b9ba5wn1ac9-c-1600-1200-6719b69c82e2b191877793.jpg	白马山旅游区山行似马，山顶经常白云缭绕，有财神庙、五仙庙、龙头香等众多历史文化遗址。	2024-10-24 02:53:16	\N	\N	\N	\N	\N	\N	\N	\N	14900	2	f	\N	\N	\N	\N	\N
94	\N	\N	长河湾景区	2024-05-15 05:43:47	<p>国家AAA级旅游区，位于十堰市张湾区西沟乡黄土村三组，距市中心20公里。上至鹰岩，下至黄土岭堰坝横线，左至瀑布周边，右至小鹰沟山梁，共 460亩。总投资4800万元，建筑占地约10亩，是一个集农业观光、水上游乐、民宿为一体的农业休闲光景区。可乘1路至西沟乡路口下车即可，14路公汽在西沟乡黄土村可到达。</p>	zhang-he-wan-jing-qu-66e494957fe32510410356.jpg	长河湾景区	2024-09-13 19:37:57	\N	\N	\N	\N	\N	32.631125	110.635083	十堰市张湾区西沟乡黄土村	14800	2	\N	\N	2024-10-29 00:00:00	2024-11-28 00:00:00	张湾区西沟乡黄土村	\N
155	\N	\N	鱼悦栖乡	2024-10-23 06:44:36	<p>渔悦栖乡生态园依托项目地生态基底，在“乡村振兴”“农业转型”的时代契机下，打造集餐饮民宿、农业观光、休闲旅游、科研教育等功能为一体的生态农旅综合体及特色的农业产业示范园生态休闲目的地。曲径通幽，峰峦如聚，大自然的鬼斧神工开辟出了一条幽深峡谷。渔悦栖乡生态园顺应这得天独厚的自然环境，成为了“小峡”深处的世外桃源。从钓鱼摘菜的野炊到品味农家菜，带你一站式体验原汁原味的田园生活。渔悦栖乡垂钓园为国标钓鱼池，品种包含：草鱼、鲫鱼鲤鱼、甲鱼、武昌鱼、桃花鱼等。垂钓园设有多个钓位，在钓鱼的同时又能体验休闲与舒适。渔悦栖乡以丰富的活动、休闲体验，融合自然生态环境，打造疗愈身心的“田园生活方式”。这里共设有精品客房12间，同时配有自助茶咖室、宴会包厢、多功能厅、书画创作基地等休闲娱乐设施。住宿、餐饮、娱乐一应俱全，除休闲度假外，还可满足亲子研学、特色婚礼、聚会party、交友团建等需求。</p>	1-67199b71193ee010458138.jpg	鱼悦栖乡	2024-10-24 00:57:21	\N	\N	\N	\N	\N	32.716035	110.516617	十堰市张湾区黄龙镇朱庄村	10700	2	f	\N	\N	\N	\N	\N
185	\N	\N	人民广场	2024-10-23 07:10:32	<p>十堰人民广场(又名六堰广场)，位于十堰市最繁华的六堰公园路地段，是十堰市的地标之一，广场周边高楼林立，商业经济发达。周边交通良好，朝阳路大道，公园路大道，文化路包围广场。十堰市图书馆，十堰市科技馆，十堰市工人文化宫，工商银行银都大厦，建设银行金城大厦，锦绣华庭双塔商住楼，十堰市商业贸易大厦，科器大厦，东风剧场(文贸乐园)，武商集团十堰人民商场，京华超市量贩店，原裕华商场，十堰特色餐饮一条街，是百二河、张湾河交会的地方。</p>	1-6719b1b95f60a585287712.jpg	人民广场	2024-10-24 02:32:25	\N	\N	\N	\N	\N	32.65496	110.78205	张湾区车城路街道朝阳北路3号	15800	2	f	\N	\N	\N	\N	\N
148	\N	\N	李声平即食风干鱼	2024-09-19 04:51:30	<p>李声平即食风干鱼</p>	2-66ebadd23d5fd771847389.jpg	李声平即食风干鱼	2024-09-19 04:51:30	\N	\N	\N	\N	\N	\N	\N	\N	14300	2	\N	\N	\N	\N	\N	\N
136	\N	\N	云庐	2024-09-18 08:03:53	<p>云庐</p>	66-66ebbed1cd524323788471.jpg	云庐	2024-09-19 06:04:01	\N	\N	\N	\N	\N	\N	\N	\N	15600	2	\N	\N	\N	\N	\N	\N
126	\N	\N	维也纳国际酒店	2024-05-17 01:43:21	<p><span style="background-color:rgb(255,255,255);color:rgb(15,41,77);"><strong>维也纳国际酒店</strong></span></p>	020581200093rrmx1a5e2-w-1080-808-r5-d-66ea341be7b8d373180662.jpg	维也纳国际酒店	2024-09-18 01:59:55	\N	\N	\N	\N	\N	\N	\N	\N	6900	2	\N	\N	\N	\N	\N	\N
143	\N	\N	环球港	2024-09-19 04:41:03	<p><span style="background-color:rgb(255,255,255);color:rgb(51,51,51);"><strong>环球港</strong></span></p>	104f6e33-bd9f-4195-b4d8-aef107f47972-66ebab5f72ccc336852035.jpeg	环球港	2024-09-19 04:41:03	\N	\N	\N	\N	\N	\N	\N	\N	15100	2	\N	\N	\N	\N	\N	\N
145	\N	\N	君王醉黄酒	2024-09-19 04:43:55	<p>君王醉黄酒</p>	jun-wang-zui-huang-jiu-66ebac0b8c220667500193.png	君王醉黄酒	2024-09-19 04:43:55	\N	\N	\N	\N	\N	\N	\N	\N	11700	2	\N	\N	\N	\N	\N	\N
151	\N	\N	百龙潭景区	2024-10-23 06:41:08	<p>国家AAA级旅游区，位于城区西部，辖区国土面积6.8平方公里，现有耕地160亩，呈带状、块状分布。距离城市主干道316国道5公里，属于15分钟城市交通圈以内，四面环山，东、南于国家3A级景区牛头山森林公园相连。百龙潭地形以山场、沟谷为主，风光灵秀，生态天然，民风淳朴。山高林密，松柏葱郁，有着大量的常绿植物和落叶植物。百年古树须髯若神，林下乔木俯仰生姿，植被密茂，风景宜人，是张湾区“一轴两翼”生态旅游核心区域。百龙潭旅游资源丰富，该景区因内有百余个水潭而得名，潭潭相连，形态各异，并且谷深林密、瀑飞泉流、古树众多、遮天蔽日。百龙潭位于桃子村东南方向，与牛头山森林公园相邻，山间树木繁茂，其中不乏国家重点保护树种，仅千年古树就有近千株。 景区内峰奇石秀，溪潭珠联，曲径通幽，小三峡、天然石人、松树王（四人合抱）、天然圆潭、天然古山洞等景点令人目不暇接。沿线有多处精致的小瀑布，如西施轻浣的素纱，轻柔飘渺，其声如风箫牧笛，伴和山间莺歌鸟语，令人陶醉。景区四季风景各异，大自然赋予她少女般万种风情，春季：春风送暖，山花烂漫，胜似世外桃源；夏季：绿树成阴，凉风习习，犹如人间仙境；秋季：赤橙黄绿，秋风送爽，令人心醉神怡；冬季：银装素裹，冰川玉瀑，万树“梨花”，更是赏心悦目。可乘50路、3路、21路、60路公汽方山路岔河村路口徒步</p>	1-67199cbd5a1f4506258090.jpg	百龙潭景区	2024-10-24 01:02:53	\N	\N	\N	\N	\N	32.601097	110.70651	十堰市张湾区花果街道桃子村	7000	2	f	\N	\N	\N	\N	\N
130	\N	\N	十堰市奥林匹克体育中心	2024-09-18 02:45:02	<p>十堰奥体中心项目包含综合体育馆、综合训练馆、游泳馆、青少年活动馆、奥林匹克广场和综合体育配套六大部分，建成后将是集“青少年体育训练中心、大型体育综合比赛场馆、市民的健身目的地、城区旅游景点”为一体的体育主题综合体，同时也是商业综合体、会展中心、文化产业园、城市公园。</p>	ed11c3ca30f14f7289d48cb6f05aaae6-66ea3eae4f5b8417068920.jpeg	十堰市奥林匹克体育中心	2024-09-18 02:45:02	\N	\N	\N	\N	\N	32.647686	110.806787	十堰市张湾区江苏路与紫霄大道交叉口西南370米	14900	2	\N	\N	\N	\N	\N	\N
137	\N	\N	月亮边山庄	2024-09-18 08:04:44	<p>月亮边山庄</p>	rn-image-picker-lib-temp-f48d2475-22c4-49d1-93fb-feb56f877248-66ea899c8126f145628411.jpg	月亮边山庄	2024-09-18 08:04:44	\N	\N	\N	\N	\N	\N	\N	\N	14100	2	\N	\N	\N	\N	\N	\N
192	\N	\N	湖北知雨轩农业科技有限公司（知雨轩非遗）	2024-10-23 07:14:47	<p>张湾区柏林镇非遗工匠坊整合非遗资源，通过实物展示、互动体验等方式，打造研学新业态，古法榨油、手工花馍、磨豆腐、弹棉花、扎染、中医、木匠等20多个非遗项目和15位非遗传承人齐聚于此，既实现非遗活态传承，又带动旅游业发展。近年来，张湾区不断探索“非遗+文旅”高质量发展之路，活化利用非遗技艺，支持鼓励龙头企业开展乡村非遗研学活动，擦亮了文旅融合新名片。</p>	1-6719afed7d7bf901949618.jpg	湖北知雨轩农业科技有限公司（知雨轩非遗）	2024-10-24 02:24:45	\N	\N	\N	\N	\N	32.654355	110.624747	十堰市张湾区柏林镇柏林村1组	11000	2	f	\N	\N	\N	\N	\N
96	\N	\N	四方山旅游区	2024-05-15 05:44:41	<p>国家AAA级旅游区，位于十堰市北郊，距市中心区6KM。这里山不高而秀，池不深而清，地不阔而平坦，林不大而茂盛。园内海拔最高处578M，登高环视，四周山峦起伏，车城风姿尽收眼底。四方山植物园始建于一九九二年，占地2800余亩。现已建成峭壁临风的“和风亭”；旱不沽、雨不盈的“天池神浴”；怪石横生的“醉石林”；晴日赏明月、风狂听松涛的“观松亭”；真武练功的“太极坛”；林寒涧啸、深邃莫测的“福寿谷”及具有江南园林建筑风格的“漱玉轩”和亭、台、廊、架等形态各异、意境深远的建筑景点20余处。明清石雕园内武当山外围寺、观明清时期的石雕、石像遗存30余宗。建成游览主干道路13公里，自来水已引到园内。园内有植物127科、370属、570种，其中国家一、二类保护植物20余种。建植物专类园四个，即：桂花园、巴山腊梅园、火棘园、石榴园，使观景、赏花融为一体，目前已达到三季有花，四季常青，百卉花香的景观效果，园内的两处宾馆装饰豪华，设施齐全，可同时接纳100余人就餐住宿。园内建有游乐、健身设施，可满足游客娱乐及健身需求。已成为十堰市民休闲娱乐、旅游观光的向往之处。现植物园属于四方山风景区的一部分。规划中的四方山风景区占地1.5万亩，划分为十一个景区，即：观光果园区、挹秀景区、观赏植物区、综合游乐区、水上活动区、鹿苑景区、野营游乐区、狩猎区、国防教育基地、引种驯化区、办公生活区。建成后的四方山风景区，不仅是一个寓科教学、旅游观光、渡假休闲多功能的娱乐场所，而且对市区生态环境将起到重要绿色屏障作用。到四方山可乘4路、21路、57路、63路公汽可到达。</p>	si-fang-shan1-66e49d887221d333921511.jpg	四方山旅游区	2024-09-13 20:16:08	\N	\N	\N	\N	\N	32.67099	110.77874	十堰市张湾区发展大道	7800	2	\N	\N	\N	\N	\N	\N
138	\N	\N	花迹雨舍	2024-09-18 08:06:03	<p>花迹雨舍</p>	5-66ebbe9762dc3269802938.jpg	花迹雨舍	2024-09-19 06:03:03	\N	\N	\N	\N	\N	\N	\N	\N	7900	2	\N	\N	\N	\N	\N	\N
177	\N	\N	凯旋门大酒店	2024-10-23 07:01:10	<p>二星级宾馆，位于张湾区车城路51号东岳路派出所旁，招商蛇口兰溪谷正对面；周边餐饮、娱乐、购物等生活配套齐全，交通便利。酒店周边环据着自然风光十分优美的长隆水上乐园、人民公园、十堰博物馆等旅游景点。酒店装饰典雅，拥有多种房型客房，房间结构合理、南北通透、光线充足；房内布置温馨舒适、整洁大方；设有中央空调，数字电视、WIFI全面覆盖、市内电话，停车场，冬天暖气开放。</p>	1-67199dc230678899768820.jpg	凯旋门大酒店	2024-10-24 01:07:14	\N	\N	\N	\N	0719-8625888	32.639644	110.765636	张湾区车城路51号东岳路派出所旁	14900	2	f	\N	\N	\N	\N	\N
188	\N	\N	招商花园城	2024-10-23 07:12:24	\N	1-67199f891f632393027985.jpg	招商花园城	2024-10-24 01:14:49	\N	\N	\N	\N	\N	32.638392	110.766207	张湾区车城路街道车城路64号	18800	2	f	\N	\N	\N	\N	\N
95	\N	\N	回龙生态文化旅游区	2024-05-15 05:44:06	<p>国家AAA级旅游区，位于在十堰市黄龙镇回龙村，地处张湾区城郊西部，距离城区30多公里，景区位于黄龙镇最西段，与郧阳区鲍峡镇接壤，襄渝铁路、316国道穿境而过，交通便利。景区面积是5.6平方公里。近年来，景区在各级领导的大力支持下，因地制宜、科学施策，成为十堰近郊旅游目的地、乡村自然研学体验地、乡宿村舍民宿聚集地。可乘1路公交车至终点站，徒步或租车即可到达。</p>	hui-long-cun-he-hua-sheng-kai-66e4947140dcd574942165.jpg	回龙村荷花盛开，赏花。	2024-09-13 19:37:21	\N	\N	\N	\N	\N	32.66859	110.6079	十堰市张湾区黄龙镇回龙村	6800	2	\N	\N	2024-10-30 00:00:00	2024-11-22 00:00:00	张湾区黄龙镇回龙村	\N
85	\N	\N	龙泉寺旅游区	2024-05-15 04:21:43	<p>国家AAA级旅游区，位于十堰市张湾区花果村原窑沟林场，离市中心约9公里。是一座集观光、休闲、养生、娱乐于一体的按国家AAA级标准兴建的旅游景区。景区占地面积600多亩，平均海拔300多米，山高林茂、云雾飘缈、清泉潺流、林木葱茏、花草馥郁、瓜果满园、景色宜人、气候冬暖夏凉。是距市区最近、规模最大的宗教文化、健身休闲、自然生态于一体的综合性景区。区内有佛教古寺――龙泉寺，寺院一侧因有一数百年龙井而得名；现存有天王殿、大雄宝殿、龙王殿、三圣殿、藏经阁、客堂、法堂、厢房、斋堂等佛教建筑。景区内森林覆盖率达90%，桃树、葡萄、梅子、核桃等各类果木丰富，四季花木繁茂，鸟类繁多；奇石、根雕、盆景随处可见，园林景观、文人石刻、大型雕塑、雅趣小品处处体现中华龙文化气息；因此龙泉寺景区成为十堰市又一重要人文景观。景区开设有勇者无惧，水上自行车，平衡木，秋千，勇攀高峰，大脚八，诸葛弓弩，4D电影，竹林迷宫，户外拓展训练，快乐向前冲，CS真人户外对抗,户外穿越，登山寻宝，烧烤露营等多种娱乐项目。可乘1路、3路、24路、60路公汽，中巴可到达。</p>	long-quan-si1-66e494cf71440501191736.jpeg	龙泉寺旅游区	2024-09-13 19:38:55	\N	\N	\N	\N	\N	32.635171	110.710187	十堰 市张湾区花果方山路68号	15100	2	\N	\N	\N	\N	\N	\N
131	\N	\N	健康步道	2024-09-18 02:51:55	<p>2023年10月18日，全长4.3公里的十堰主城区健康步道一期开放。市民又多了一处近山、亲山、赏山、乐山的休闲娱乐好去处。从十堰紫霄大道紫园出入口进入后，这里便是健康步道的口袋公园紫园。但见园内绿意盎然、花团锦簇，仿佛置身于生态公园。走在紫霄大道螺旋塔上，步道的坡度不超过15度，地面采用透水材料，两边护栏采用网状金属结构，整个步道色彩和谐，给人一种通透感。绕塔而上，回望步道九曲百转，似长龙、如彩带。站在步道上远眺，群山环绕下的车城十堰，高楼林立、车水马龙。顿时生出人在城中、城在山中的感慨。</p>	3-66ea404bc7ffb033854785.jpg	健康步道	2024-09-18 02:51:55	\N	\N	\N	\N	\N	32.648605	110.80184	奥体中心出入口	15100	2	\N	\N	\N	\N	\N	\N
165	\N	\N	方滩乡见山茶舍	2024-10-23 06:53:38	\N	1-6719ac125c362383256767.jpg	方滩乡见山茶舍	2024-10-24 02:08:18	\N	\N	\N	\N	\N	32.735589	110.61394	十堰市张湾区方滩乡方滩村8组	12600	2	f	\N	\N	\N	\N	\N
191	\N	\N	十堰市桃花潭旅游开发有限公司（桃气包）	2024-10-23 07:14:21	<p>东风故里 幸福张湾”，2023年6月21日上午，张湾区文旅推广暨百龙潭第三届消夏纳凉文化旅游节活动在百龙潭景区举行，活动现场，张湾区首批文旅代言人亮相，发布桃子村·百龙潭景区“桃气包”系列设计产品征集结果，启动“发现张湾之美”文旅采风。2023年4月10日至5月10日，张湾区面向全社会公开征集桃子村·百龙潭景区“桃气包”卡通形象设计方案和景区宣传口号。活动现场，“桃气包”系列设计征集结果公布，武汉胜意文化传播有限公司获得一等奖，获颁“张湾文旅特邀创意官”称号，奖励10000元；高晓斐等获得二等奖，获颁“张湾文旅创意伙伴”称号，各奖励3000元。在百龙潭景区宣传口号征集中，“百龙潭水清又清，相约氧吧好心情”，“恋恋桃花源 念念百龙潭”，充分体现百龙潭景区生态、人文、历史及文化底蕴，获得二等奖，奖励2000元。桃气包“龙娃、桃桃”的设计采用萌系风格，融合桃子村的桃子、百龙潭的龙元素，凸显“桃气包”的视觉辨识度。桃气包龙娃，搭配百龙潭的龙角，桃气包桃桃，配饰桃花，强化性别特征。男、女双角色在未来延展中可以拥有更多互动、场景演绎的可能性。同时桃子村采用桃气包“龙娃、桃桃形象，设计出了人偶、公仔、水杯、雨伞、T恤等多种多样文创产品供市民挑选。百龙潭文创形象－“桃气包”，采用两头身萌系风格设计，将“桃子”造型集中体现在玩偶头部装饰之上，更能凸显“桃气包”的视觉辨识度。同时以男女角色设计针对不同的消费受众进行沟通。男性“桃气包”－龙娃，选用符合桃子村乡风质朴实诚，表情憨厚可爱；女性“桃气包”－桃桃，以小桃心连衣裙作装饰，配合水亮大眼睛，让人心生怜爱。</p>	ezceva-6719b02264e4e946284657.jpg	十堰市桃花潭旅游开发有限公司（桃气包）	2024-10-24 02:25:38	\N	\N	\N	\N	\N	32.602102	110.706642	十堰市张湾区花果街道桃子村百龙潭景区内	8700	2	f	\N	\N	\N	\N	\N
200	\N	\N	湖北省十堰市东风越野车有限公司	2024-10-23 07:44:30	<p>东风越野车有限公司是东风汽车集团股份有限公司下属子公司，2002年8月15日在湖北省十堰市成立，它是独家生产具有东风完全自主知识产权的 ""东风猛士""系列高机动性军、民两用越野车的整车制造企业。公司主导产品---东风""猛士""融汇了当今世界先进技术，聚东风军品之大成，表现出良好的机动性、动力性、生存性、适应性、保障性、运输性、安全性、可靠性和耐用性;它是第一个第三代高机动性军车、第一个三代基型战术平台、第一个系统的与装备结合形成作战系统，开创了军车作战使命的提升，是现代化一体作战体系--信息和打击平台的重要载体，实现了部队装备跨越式的可持续发展。2009年1月，在中共中央、国务院召开的2008年度国家科学技术奖励大会上，东风""猛士"" 获得中国汽车行业22年来唯一一个国家科技进步一等奖;2009年10月1日，东风""猛士""参加新中国成立60周年国庆阅兵，取得圆满成功。东风越野车公司肩负着服务国防、弘扬东风自主品牌的神圣使命。长期以来，越野车公司坚持""造车育人""的经营理念，以为股东、客户、员工和社会创造价值，实现企业和谐发展为目标，不断导入国际先进的管理模式。目前，公司正为全力打造中国军车第一品牌、建设卓越高效的现代企业亮剑前行。</p>	1-67199ea70340f540977750.jpg	湖北省十堰市东风越野车有限公司	2024-10-24 01:11:03	\N	\N	\N	\N	\N	\N	\N	湖北 十堰市张湾区工业新区	12300	2	f	\N	\N	\N	\N	\N
197	\N	\N	湖北汽车工业学院	2024-10-23 07:19:04	\N	r-c-1-67199f0c91ad2972118370.jpg	湖北汽车工业学院	2024-10-24 01:12:44	\N	\N	\N	\N	\N	\N	\N	\N	15000	2	f	\N	\N	\N	\N	\N
195	\N	\N	东风总医院	2024-10-23 07:18:21	\N	abuiabacgaagry3-kgyo4q7-mwqw9qk4pwm-6719aec57b522940902421.jpg	东风总医院	2024-10-24 02:19:49	\N	\N	\N	\N	\N	\N	\N	\N	16900	2	f	\N	\N	\N	\N	\N
193	\N	\N	高铁站	2024-10-23 07:15:29	\N	1-6719af4f84d0c002815653.jpg	高铁站	2024-10-24 02:22:07	\N	\N	\N	\N	\N	\N	\N	\N	19000	2	f	\N	\N	\N	\N	\N
196	\N	\N	东风猛士	2024-10-23 07:18:40	\N	1-6719b27f1f7f8357742071.jpg	东风猛士	2024-10-24 02:35:43	\N	\N	\N	\N	\N	\N	\N	\N	7600	2	f	\N	\N	\N	\N	\N
178	\N	\N	美天酒店	2024-10-23 07:03:48	<p>二星级宾馆，位于张湾区红卫街道车城西路113号，毗邻湖北汽车工业学院、湖北东风汽车技师学院、东气汽车工业学院。美天酒店设计初衷秉持“温暖、熟睡、安全、智慧”这四点，为顾客带来更舒适便捷的私人空间。酒店房间配备大屏投影，4k电视，智能语音控制，千兆独立网剧，娱乐办公两不误。床垫选用顾家品牌乳胶枕头和鹅绒枕头，舒适的体验感让您快速入眠。温馨的服务也是美天酒店的一大特色，免费洗衣、阳光下凉晒，让风尘仆仆的您每天更多一份从容。美天酒店欢迎您的入驻，美天酒店，温馨舒适每一天。</p>	1-67199d598d3d6924023840.jpg	美天酒店	2024-10-24 01:05:29	\N	\N	\N	\N	\N	32.651874	110.74728	张湾区红卫街道车城西路113号	13100	2	f	\N	\N	\N	\N	\N
172	\N	\N	金色礼赞美食街	2024-10-23 06:58:06	\N	7c01b152828341218b30db63c34dd7ee-6719aa048f3c7904874477.jpg	金色礼赞美食街	2024-10-24 01:59:32	\N	\N	\N	\N	\N	32.656646	110.787189	张湾区汉江南路	6600	2	f	\N	\N	\N	\N	\N
170	\N	\N	汉江街道柳家河村樱桃沟	2024-10-23 06:55:15	\N	20230417152931-9182-6719aa7f24d4a220769001.jpg	汉江街道柳家河村樱桃沟	2024-10-24 02:01:35	\N	\N	\N	\N	\N	32.756394	110.779521	十堰市张湾区汉江街道柳家河村	15800	2	f	\N	\N	\N	\N	\N
169	\N	\N	花果街道放马坪古巷	2024-10-23 06:54:53	\N	r-c-6719aab624ddc120312691.png	花果街道放马坪古巷	2024-10-24 02:02:30	\N	\N	\N	\N	\N	32.648968	110.673286	十堰市张湾区花果街道放马坪路	15000	2	f	\N	\N	\N	\N	\N
168	\N	\N	红卫夜市	2024-10-23 06:54:31	\N	v2-311cc949de50dd5c3b89d7203b69ebad-r-6719aaea1eb30805787329.jpg	红卫夜市	2024-10-24 02:03:22	\N	\N	\N	\N	\N	32.644033	110.737981	十堰市张湾区红卫街道四川路1号	8200	2	f	\N	\N	\N	\N	\N
167	\N	\N	西沟乡小五家花乐园	2024-10-23 06:54:12	\N	1-6719ab525e365438024434.jpg	西沟乡小五家花乐园	2024-10-24 02:05:06	\N	\N	\N	\N	\N	32.627466	110.629652	十堰市张湾区西沟乡黄土村	5300	2	f	\N	\N	\N	\N	\N
166	\N	\N	西沟乡“山谷见”露营基地	2024-10-23 06:53:55	\N	1-6719abcb7b752967773492.jpg	西沟乡“山谷见”露营基地	2024-10-24 02:07:07	\N	\N	\N	\N	\N	32.605159	110.606812	十堰市张湾区西沟乡相公村036乡道	19400	2	f	\N	\N	\N	\N	\N
160	\N	\N	中国汽车博物馆	2024-10-23 06:50:59	<p>利用四一厂购置资产，建设东风汽车博物馆一期工程，包括展陈馆、历史文化精神主馆、体验装车馆、运动健身馆等等。</p>	1-6719ac52cdc3a768031447.jpg	利用四一厂购置资产，建设东风汽车博物馆一期工程，包括展陈馆、历史文化精神主馆、体验装车馆、运动健身馆等等。	2024-10-24 02:09:22	\N	\N	\N	\N	\N	32.656615	110.670304	十堰市张湾区原41厂区	7100	2	f	\N	\N	\N	\N	\N
154	\N	\N	黄龙半岛	2024-10-23 06:44:18	<p>张湾区黄龙半岛美丽乡村项目总投资1亿元，占地面积约15亩主要建设黄龙客栈、烟火乡宿、渔歌码头等。依托地处十白高速黄龙出口的区位优势，以及非遗美食黄龙鱼头，项目建成后吸引了更多城里人下乡消费，预计可实现年集体收入50万元，带动120余人就近就业。</p>	1-67199bff86dd7344533017.jpg	黄龙半岛	2024-10-24 00:59:43	\N	\N	\N	\N	\N	32.679015	110.576373	十堰市张湾区黄龙镇黄龙大桥旁、十白高速黄龙出口处	6600	2	f	\N	\N	\N	\N	\N
201	\N	\N	东风华神汽车有限公司	2024-10-23 07:45:04	<p>东风华神汽车有限公司是1998-03-19在湖北省十堰市注册成立的有限责任公司(自然人投资或控股的法人独资)，注册地址位于湖北省十堰市工业新区捷达路7号。东风华神汽车有限公司的经营范围是：汽车及底盘、专用车、汽车零部件的研发、制造、销售和技术咨询、技术服务；从事货物（不含应取得许可经营的商品及国家禁止或者限制进出口的货物）进出口、技术（不含国家禁止或者限制进出口的技术）进出口业务。</p>	1-67199e73a743f199005367.jpg	东风华神汽车有限公司	2024-10-24 01:10:11	\N	\N	\N	\N	\N	\N	\N	湖北省十堰市工业新区捷达路7号	10800	2	f	\N	\N	\N	\N	\N
175	\N	\N	长隆水上乐园长隆水上乐园长隆水上乐园长隆水上乐园	2024-10-23 06:59:22	<p>十堰常隆水上乐园，占地四万余平方米，是集娱乐，餐饮美食，商务休闲等一体化的大型主题水上乐园。经过全面升级改造后拥有更大的停车场，设有1000+停车位解决你的停车问题。儿童水寨池新增1500平方米自动遮阳蓬标准游泳池新增1050平方米自动遮阳蓬，露天水上乐园拒绝紫外线的照射。3米高的大浪席卷而来，人们在水中如浮萍随浪起伏，尽情释放心中的压力，让您置身车城，一样能体验夏威夷风情带给您不一样的刺激与体验。全家老少齐上阵，等待翻斗桶的巨大水花浇个透心凉，仿佛置身暴雨之中，解压又畅快。还有各式各样的滑道，错落有致如乐园般充满趣味。专为小朋友设定的游玩区域，贴心地把许多项目做了一个微缩版，适合孩子的体型和承受力，让潮玩打开孩子的异想世界~超大直径，紧张刺激，准备好大幅度的滑行摆动了吗?坐在同一个超大的滑板浮圈内，上演一场华丽的极速冒险吧!超大直径，紧张刺激，准备好大幅度的滑行摆动了吗?坐在同一个超大的滑板浮圈内，上演一场华丽的极速冒险吧!巨洪峡是在漂流河基础上，升级改造而成的一种新型漂流河。在高处打开闸口，形成滔天巨浪，似山洪暴发，游客可在跌宕起伏中，领略被抛向浪尖。1250平方米的国际标准竞技游泳池，有11条赛道，是供大家畅游的理想之处，邂逅腹肌、人鱼线的理想之地。</p>	1-6719a32591ec4847722806.jpg	长隆水上乐园	2024-10-24 01:30:13	\N	\N	\N	\N	\N	32.697139	110.773486	张湾区郧阳路8号（十堰西高速出口往凯旋大道方向200米处）	16900	2	f	\N	\N	\N	\N	\N
97	\N	\N	人民公园	2024-05-15 05:45:02	<p>国家AAAA级旅游区。人民公园景区位于十堰市城市中心繁华地段，建于1981年，土地使用面积490亩，其中绿化面积近470亩，绿化覆盖率96%。景区依山傍水而建，设游览休闲区、植物观赏区、动物观赏区、娱乐游艺区。有十堰市标志性景观建筑重阳塔、古长城、庸楚一台、仿古风景房、迎宾广场、寿山飞瀑等大小景点30余处；各种名木古树、花卉植物100余种；湖北省地市级一流动物园；还有山地滑道、激流勇进、碰碰车等惊险刺激游乐项目40余个。人民公园迎宾广场正对公园北门，是十堰举办各种大型公益活动、市民晨练散步的首选之地，广场开阔整洁，以一种包容的态度迎接八方游客。园林的艺术之美，美在楼台亭榭、美在清池涵虚、美在花木含情。春日之初，迎着暖暖的阳光，慢步徜徉在人民公园的林荫小道，细细品味，你会发现，山水，建筑，花木宛若一个整体，自然结合，别有一番古朴，典雅，自然，清幽的写意山水之美。庸楚一台位于广场的西端，为古戏台。戏台飞檐翘角，显得非常轻盈精美。和景区东侧的园林景观式办公楼风格统一协调，遥相呼应。十堰市人民公园动物园在2009年进行了升级改造，建有海狮表演场、海洋馆、狮虎生态园、鸟语林等现代化场馆；有狮、虎、金钱豹、长颈鹿、斑马、小熊猫、袋鼠、海狮等珍稀动物60多个品种400余头（只）；2013年10月动物园又耗资近200万元新建的海洋馆正式对外开放，可以观看到鲨鱼、海龟、鳐鱼、珊蝴等各类热带海洋生物；并经常组织杂技表演团体来园进行表演，是集陆地动物、海洋生物、动物观赏为一体的综合性的动物园，是目前湖北省地市级动物园中动物品种最多、场馆笼舍最先进的动物园。重阳塔也叫长寿塔，坐落在人民公园长寿山顶，八角形楼阁式塔，高72米，九层九檐，塔内台阶339级至顶，塔的外观是唐式风格，彩绘为明清格调，既显雄伟气派，又显美观大方。重阳塔古朴雄伟，是十堰市标志性景观建筑。缘梦廊灰瓦红柱，彩绘经典名著《红楼梦》故事，幽静雅致，是最佳谈情说爱之地，故取名缘梦廊，意寓缘定今生梦想成真，祝愿有情人终成眷属。古长城景点于1998年批准兴建，当年由于各方面条件制约仅修建了613米，2010年景区对古长城进行了续建、修复，现在的古长城东起映山湖，西与重阳塔相连，总长近1600米，宽3米，含10个烽火台和1个箭楼，将公园环抱，分别有东、南、西三个出入口，分别为紫阳关、耀阳关、守阳关。（主烽火台海拔高386米）。可乘5路、7路、8路、35路、59路、58路、21路、57路公汽</p>	3-66ebbd618fc73980175579.jpg	人民公园	2024-09-19 05:57:53	\N	\N	\N	\N	\N	32.65042	110.77722	十堰市张湾区公园路48号	7700	2	\N	\N	\N	\N	\N	\N
180	\N	6	花开嫁日酒店（万达广场店）	2024-10-23 07:06:24	<p>十堰花开嫁日酒店是一家坐落在湖北省十堰市，酒店位于市中心的发展大道，交通便捷，周边拥有完善的商业和休闲设施。花开嫁日酒店建筑风格独特，以高品质的装饰和细致入微的服务，为客人带来舒适的住宿体验。酒店拥有不同类型的客房，从豪华套房到经济型客房，各种需求都能得到满足。酒店的餐厅提供各种美食，从地道的湖北菜到国际化的西餐，应有尽有。</p>	1mc4w12000e6tf7v1f9c5-w-1080-808-r5-d-67199ce9dd5cf956011342.jpg	花开嫁日酒店（万达广场店）	2024-10-24 01:03:37	\N	\N	\N	\N	0719-8681888	32.666863	110.805236	张湾区发展大道中路16号国瑞中心A座1楼	11600	2	f	\N	\N	\N	\N	1
150	\N	\N	谭二拉面馆	2024-10-21 03:02:10	\N	017b0959157d60b5b3086ed4811ad2-6719ae83309d0372657496.jpg	车城小店经典美食	2024-10-24 02:18:43	\N	\N	\N	\N	\N	\N	\N	\N	13800	2	f	\N	\N	\N	\N	\N
203	\N	\N	悠悠山水间~寻迹神农，漫漫登顶路~问道武当	2024-10-24 02:39:21	\N	01040120008c7olvwaff4-w-1024-0-q90-6719b35a98971379741370.jpg	我们踏过高山湿地。我们赏过潋滟水色。我们拜谒过宫观殿祠。还有走过，那以万计数的阶梯......	2024-10-24 02:39:22	\N	\N	\N	\N	\N	\N	\N	\N	7900	2	f	\N	\N	\N	\N	\N
91	\N	\N	十堰大嘉国际酒店	2024-05-15 05:28:48	<p>大嘉国际酒店是一家极具现代感的高端商旅酒店，酒店地理位置优越，毗邻十堰人民广场，与人民公园仅一步之遥，入住宾客均可独享园林美景；酒店地处十堰城市中心，交通极为便利，距离武当山机场20公里、火车站7公里、高速路入口9公里，30分钟左右均可抵达。</p>	200g0t000000iibm29a98-w-1080-808-r5-d-66ea346289fc4367561533.jpg	十堰大嘉国际酒店	2024-09-18 02:01:06	\N	\N	\N	\N	0719-8625888	32.652829	110.775144	张湾区车城路街道公园路48号汇景园1号楼	7400	2	\N	\N	\N	\N	\N	\N
141	\N	\N	十堰万达广场	2024-09-19 04:38:41	<p>十堰万达广场</p>	t01efd85ab60f62c9ed-66ebaad1d38a8610403805.jpg	十堰万达广场	2024-09-19 04:38:41	\N	\N	\N	\N	\N	32.66204	110.808953	张湾区汉江路街道北京北路99号	5300	2	\N	\N	\N	\N	\N	\N
144	\N	\N	华悦城	2024-09-19 04:42:41	<p>华悦城</p>	oip-c-66ebabc1a4e2a158836502.jpeg	华悦城	2024-09-19 04:42:41	\N	\N	\N	\N	\N	30.34122	110.84034821231	\N	10400	2	\N	\N	\N	\N	\N	\N
186	\N	\N	青年广场	2024-10-23 07:11:06	<p>青年广场‌位于湖北省十堰市车城路街道公园路112号，青年广场不仅是一个交通便利的公共场所，其周边的设施和服务也十分完善，该广场周边交通便捷，多个公交站点的设置使得居民可以方便地换乘多条公交线路，从而轻松到达广场及其周边地区；包括机关小学、东风五中、东风供应处、东风零部件集团总部等，为居民和游客提供了便捷的公共服务。此外，购物、餐饮和医疗等生活配套设施，为居民的日常生活提供了极大的便利。</p>	1-6719b192b54b3356180847.jpg	青年广场	2024-10-24 02:31:46	\N	\N	\N	\N	\N	32.648361	110.769112	张湾区车城路街道公园路112号	14400	2	f	\N	\N	\N	\N	\N
98	\N	\N	牛斗山国家森林公园	2024-05-15 05:45:19	<p>国家AAA级景区，地处十堰市城区中部，距市中心仅5公里，是十堰市城区唯一的一家省级森林公园。公园下设牛头山管理处、艳湖管理处、美景园管理处，总面积18平方公里，森林覆盖率达到94.5%，植物种类达1100余种；境内山青水秀、峰峦叠嶂、植被繁茂、气候宜人，自然资源、旅游景观非常丰富。由于其独特的森林景观资源优势、区位优势，奠定了其城区型森林生态旅游胜地的地位。公园至今已初步开发开放了艳湖公园 (包括露天游泳场――作为2008年十堰市政府十件实事已完成)、美景园（市气象站）、牛头山大门主入口、岩屋沟、高峰寺等五大景区30多个景点，引进餐饮娱乐项目近10项,创相关收入突破1000万元。为策应实施“旅游城、生态城”发展战略, 十堰市人民政府于2007年12月顺利完成了十堰市牛头山森林公园、东风公司艳湖水上乐园、张湾区美景园 (林场) “三园”整合, 组建了新的牛头山森林公园。“三园”整合一年来, 市委、市政府高度重视牛头山森林公园的扩建工作, 把“建设艳湖露天游泳场,开放牛头山森林公园”作为2008年市政府为民所办十件实事之一来抓, 共投资600多万进行了艳湖露天游泳场的改造建设、牛头山水电路基础设施建设与美景园仿生态景观亭、垃圾处理设备、休闲桌凳等旅游服务设施建设。 2008年5月1日牛头山森林公园正式免门票向游客开放, 成为我国第一家免门票开放的森林公园、国家AAA级旅游景区, 受到广大媒体关注; 同年的8月1日, 艳湖露天游泳场建成并免费投入使用, 成为广大市民关注的焦点。据统计, 免门票开放牛头山森林公园至今, 共接待国内外游客突破了40万人次, 其中下水游泳人次近13万, 同比增长了5倍, 广大市民已经充分享受到了政府实事成果。“三园”整合扩建,为十堰市“三城”联创、为构建鄂西北生态文化旅游圈作出了重大贡献。可乘57路公汽可到达。</p>	2-66ebbcef47099673861484.jpg	牛斗山国家森林公园	2024-09-19 05:55:59	\N	\N	\N	\N	\N	32.597892	110.737022	十堰市张湾区贵州路34号	18400	2	\N	\N	\N	\N	\N	\N
153	\N	\N	黄龙古镇	2024-10-23 06:44:00	<p>位于堵河东岸的黄龙古镇，始建于明末清初。1926年12月，在此地成立的中共郧县第四党小组，是十堰历史上第一个中共党组织。古镇由前街、后街、上街、河街四个部分构成，目前保存相对完整的武昌会馆、江西会馆、黄州会馆、山陕会馆以及64号古民居等古建筑，于2014年列入省级文物保护单位。2018年，黄龙镇投资对武昌会馆、黄州会馆、老理发店等进行了抢救性修缮保护，对武昌会馆、黄州会馆实施开发性利用，分别建设红色主题生活馆和展览馆，赋予了古建筑新的功能和使命。</p>	1-67199c426a7dd941363758.jpg	黄龙古镇	2024-10-24 01:00:50	\N	\N	\N	\N	\N	32.679353	110.576532	十堰市张湾区黄龙镇黄龙滩村	5300	2	f	\N	\N	\N	\N	\N
189	\N	\N	阳光栖谷天街	2024-10-23 07:12:54	\N	1-67199f5b8ece0852024419.jpg	阳光栖谷天街	2024-10-24 01:14:03	\N	\N	\N	\N	\N	\N	\N	张湾区北京北路57号	20000	2	f	\N	\N	\N	\N	\N
164	\N	\N	知雨轩田园综合体	2024-10-23 06:53:16	\N	r-c-1-6719ada490232622284382.jpg	知雨轩田园综合体	2024-10-24 02:15:00	\N	\N	\N	\N	\N	32.655645	110.623046	十堰市张湾区柏林镇柏林村1组	9900	2	f	\N	\N	\N	\N	\N
204	\N	\N	武当山修道岩庙3天游	2024-10-24 02:41:12	\N	01036120008c7ozbt1b00-w-671-0-q90-6719b3c91aa31937106084.jpg	武当山自古就有36岩的记载，实际上有修道遗迹的岩洞至少上百个，精选3天的线路，也可以每天的线路单独徒步一天，3天线路是从金顶出发到五龙宫，尽量多走几个36岩和其它岩洞，可以让人感受武当山真正的修道文化。建议3～10人，沿途的食宿只有南岩、紫霄宫、五龙宫有，需要自带至少一天的食水，部分岩洞需要熟悉线路的向导。	2024-10-24 02:41:13	\N	\N	\N	\N	\N	\N	\N	\N	13600	2	f	\N	\N	\N	\N	\N
89	\N	\N	十堰希尔顿逸林酒店	2024-05-15 05:26:58	<p>作为希尔顿酒店集团旗下品牌，十堰希尔顿逸林酒店位于湖北省十堰市阳光·栖谷天街最佳地段，由重庆国瑞控股集团投资人民币4.1亿元兴建，建筑面积达3.5万平方米，拥有267间客房，配有容纳500人的宴会厅及大、中、小多功能会议室若干间，是一个集会议中心、宴会中心、健身中心等为一体的高端商务酒店。&nbsp;</p>	20080c00000067b1i1473-w-1080-808-r5-d-66ea34f88b7e8776391708.jpg	十堰希尔顿逸林酒店	2024-09-18 02:03:36	\N	\N	\N	\N	0719-8629999	32.653564	110.799016	张湾区汉江路街道北京北路57号	13500	2	\N	\N	\N	\N	\N	\N
162	\N	\N	姥爷的花果园民宿	2024-10-23 06:52:29	<p>三星级民宿，位于十堰市城郊区西南部，张湾区花果街道生态原始风光秀美的蔡家村李家湾，距市中心30公里左右，于2017年8月开始兴建，投资300余万元,历经两年精心打造，于2019年7月底建成。园内客厅、餐厅、茶厅及客房布局合理，共三层，二、三楼客房共五间，设施齐备。智能马桶、浴缸、淋浴一应俱全，每间客房和楼层都有足够和独立的户外露台。开放式厨房既可自己动手展示自己绝技，也可以安然享用当地原生态乡村风味美食。前后院落草坪如毯，或坐或躺，或观赏花草，或眺望远山；门前清清河水洗衣、戏水、摸小鱼别有情趣；夜色降临，品茗着茶饮，赏月听虫鸣，看繁星密布，十分惬意。 可乘1路至西沟乡路口下车徒步， 自驾蔡家村李家湾可到达。</p>	1-6719ae220943e166894548.jpg	姥爷的花果园民宿	2024-10-24 02:17:06	\N	\N	\N	\N	\N	32.586524	110.681464	十堰市张湾区花果街道蔡家村	14300	2	f	\N	\N	\N	\N	\N
187	\N	\N	百龙潭景区高山足球场	2024-10-23 07:11:30	\N	1-6719b1694f421918212147.jpg	百龙潭景区高山足球场	2024-10-24 02:31:05	\N	\N	\N	\N	\N	\N	\N	十堰市张湾区花果街道桃子村百龙潭景区内	18200	2	f	\N	\N	\N	\N	\N
184	\N	\N	全民健身中心	2024-10-23 07:10:13	\N	1-6719b1dddf4f9721031679.jpg	全民健身中心	2024-10-24 02:33:01	\N	\N	\N	\N	\N	\N	\N	\N	7100	2	f	\N	\N	\N	\N	\N
209	\N	\N	牛头山国家森林公园	2024-10-24 02:49:51	<p><strong>介绍</strong></p><p>牛头山森林公园位于湖北省十堰市张湾区，总面积为16平方公里，森林覆盖率达93%，2001年被评为国家AA级旅游景区。</p><p><strong>开放时间</strong></p><p>全年 07:30-18:30开放，因天气原因时间可能有所变化，具体以当天时间为准</p>	1-6719b5cfeb226788352488.jpg	牛头山森林公园位于湖北省十堰市张湾区，总面积为16平方公里，森林覆盖率达93%，2001年被评为国家AA级旅游景区。	2024-10-24 02:49:51	\N	\N	\N	\N	\N	\N	\N	\N	7200	2	f	\N	\N	\N	\N	\N
157	\N	\N	绿野仙踪童话小镇	2024-10-23 06:45:10	<p>绿野仙踪童话小镇位于十堰市西沟乡过风村。规划占地约118亩，建筑面积约为50000m²。距十堰城区、十堰高铁站、火车站、均在20公里以内，距武当山机场40公里以内，交通便利，区位优势明显。景区以保护原始自然生态为前提，遵循开发与保护相结合的原则，进行低密度的设计和建设，创造一个鄂西北较大以童话为主题的小镇。项目在构思上，致力于将自然、山水、文化、环境、建筑以及历史这六大要素有机地结合在一起。地理位置上接白石中小学生教育实践营地、支部书记学院，下接西沟花园、长河湾景区、该项目是打造西沟乡“全域旅游”的重要节点。绿野仙踪童话小镇建设内容有：主题民宿餐饮区；文化交流区（艺术馆、咖啡馆、图书馆、多功能运动休闲区）；生态农业区（含有机农场、农耕体验区、亲子乐园、花卉蔬菜种植区）；多功能商务中心，并配套建设人工湿地排污系统、消防设施、道路与停车场地、管网铺设，绿化工程、安防、通信、暖通工程等基础配套设施。结合西沟乡原生态旅游产业优势打造西沟乡特色民俗园林度假村项目为西沟乡增加人气，为游客运动休闲和交流提供更大便利，提升和丰富西沟乡整个旅游业的服务品质。有效促</p>	3-67199b023e2de637721887.jpg	绿野仙踪童话小镇	2024-10-24 00:55:30	\N	\N	\N	\N	\N	32.579517	110.613136	十堰市张湾区西沟乡过风村	11600	2	f	\N	\N	\N	\N	\N
205	\N	\N	摘草莓、赏美景、吃腊肉...这个春节，来十堰“老家”就够了~	2024-10-24 02:43:00	\N	0104012000aflkkna1494-w-671-0-q90-6719b435cc7bc928031325.jpg	大家都知道四川有九寨沟，却不知道咱“老家”十堰也有“九寨沟”吧，那便是张湾区花果街办桃子村的百龙潭景区。	2024-10-24 02:43:01	\N	\N	\N	\N	\N	\N	\N	\N	19400	2	f	\N	\N	\N	\N	\N
163	\N	\N	红岩寨民宿	2024-10-23 06:52:49	<p>优越的自然地理位置，交通便利，依山傍水、与弥胡桃采摘基近在咫尺间，集谷、崖、水、林、石等自然风光于一体，融雄、奇、秀、险、幽为主要特点的自然生态地，是张湾区西沟乡的一道亮丽的吃、喝、玩、乐首选地。2019年11月建设完成;红岩寨民宿住宿部客房共计29间，餐饮部共有包厢13间，另设立有大型多媒体会议室、茶室、篮球场，可举办中式婚礼、大型聚会、主题联谊等大型活动。以高品质的经济管理服务确保游客来到红岩寨修有其所、养有所得，吃得放心、住得安心、玩的舒心。同时带动当地经济发展，促进了当地农民增益。红岩寨把创建星级民宿打造与美丽乡村建设、乡村振兴、农村产业结构调整相结合，打造文、旅、农、三大板块，持续发展。</p>	1-6719added6646362500208.jpg	红岩寨民宿	2024-10-24 02:15:58	\N	\N	\N	\N	\N	32.556919	110.619302	十堰市张湾区西沟乡长坪塘村二组	12200	2	f	\N	\N	\N	\N	\N
161	\N	\N	溪乡里民宿	2024-10-23 06:52:07	<p>溪乡里民宿位于十堰市张湾区花果街道桃子村百龙潭3A级旅游景区，具有河流、山林、田园、原始乡村的完整自然生态资源，溪乡里民宿占地面积约2500平米，可同时接待450人就餐、6个家庭住宿。提供“休闲餐饮、品茶小憩、康乐乡宿、休闲聚会、生日派对、团建活动”等服务，享受田园生活的“城市休闲空间”。该民宿2022年5月1日正式营业。</p>	1-6719ae58f1198694289969.jpg	溪乡里民宿	2024-10-24 02:18:00	\N	\N	\N	\N	\N	32.600911	110.706543	十堰市张湾区花果街道桃子村百龙潭景区内	11200	2	f	\N	\N	\N	\N	\N
182	\N	\N	十堰体育馆	2024-10-23 07:09:15	<p>体育馆于1992年12月动工兴建，1998年10月开馆。该馆占地面积23000平米，主场木地板面积1700余平米，观众区座椅5100个。该馆为双层框架剪结构，是省唯一拥有全悬空地下室的体育场馆。设有篮球、羽毛球、乒乓球、台球、武术、棋牌等体育锻炼或培训项目，可以承接各级各类室内比赛。开馆以来，每年举办体育比赛20多场次，年接待锻炼人员30000余人，培训学员500余人。</p>	1-6719b23dcab01882070863.jpg	十堰体育馆	2024-10-24 02:34:37	\N	\N	\N	\N	\N	32.656354	110.782144	人民广场	14300	2	f	\N	\N	\N	\N	\N
210	\N	\N	龙泉寺	2024-10-24 02:50:57	<p><strong>介绍</strong></p><p>十堰龙泉寺旅游区位于湖北省十堰市花果方山龙泉洼，西距十堰市市区9公里处。旅游区占地面积600多亩，平均海拔300多米，山高林茂、云雾飘缈、清泉潺流、林木葱茏、花草馥郁、 瓜果满园、景色宜人、气候冬暖夏凉。是距市区近、规模大的宗教文化、健身休闲、自然生态于一体的综合性旅游区。区内有佛教古寺――龙泉寺，寺院一侧因有一数百年龙井而得名；现存有天王殿、大雄宝殿、龙王殿、三圣殿、藏经阁、客堂、法堂、厢房、斋堂等佛教建筑。&nbsp;&nbsp;</p><p>十堰龙泉寺旅游区内森林覆盖率达90%，桃树、葡萄、梅子、核桃等各类果木丰富，四季花木繁茂，鸟类繁多；奇石、根雕、盆景随处可见，园林景观、文人石刻、大型雕塑、雅趣小品处处体现中华龙文化气息；因此龙泉寺旅游区成为十堰市又一重要人文景观。&nbsp;&nbsp;&nbsp;</p><p>&nbsp;&nbsp; 据史料记载：自明代以来，龙泉洼的龙井就是当地百姓求神祈雨、求福的地方，已成为这一地区热闹、有影响力的祈雨场所，只要是遇上旱灾年头，四村八邻的村野之民就会到龙泉洼求雨，其场面十分壮观。至今龙井内的山泉水还四季充盈、清澈甘美，被当地人称为“圣泉”。</p><p>十堰龙泉寺旅游区是近年十堰市城郊重点新开发景点之一，它拥有完好的生态自然景观和神秘的宗教人文景观，旅游区里冬暖夏晾，各种配套设施齐全。</p><p>十堰龙泉寺主要景点有：龙泉寺大雄宝殿、天王殿、放生池、九龙圣泉井、观音瀑布、龙王殿、百鸟园、观景台、祈雨堂。娱乐项目有：儿童乐园、勇攀高峰、垂钓中心、丛林迷宫、跑马场、高尔夫球练习场（规划建设中）、拓展训练营、棋牌室、台球、乒乓球等。</p><p>十堰龙泉寺配套设施有：客服中心、龙泉客栈、龙泉美食苑、龙泉茶社、戏楼、旅游商业街、烧烤区、露营区组成了这里独特的宗教文化、生态旅游、娱乐健身休闲区。&nbsp;</p><p><span style="color:rgb(38,129,255);">全文<i></i></span></p><p><strong>开放时间</strong></p><p>全年 08:30-17:30开放</p><p><strong>优待政策</strong></p><p>补充说明：1、60至70岁老人、教师及学生凭有效证件半票；军官免票。2、儿童票：身高1.2米—1.4米半票，1.2米以下免票。 3、以上信息仅供参考，具体以湖北十堰龙泉寺景区当天披露为准。</p>	0103712000bbdrnxwe346-r-1600-10000-6719b6120249c081383476.jpg	十堰龙泉寺旅游区位于湖北省十堰市花果方山龙泉洼，西距十堰市市区9公里处。旅游区占地面积600多亩，平均海拔300多米，山高林茂、云雾飘缈、清泉潺流、林木葱茏、花草馥郁、 瓜果满园、景色宜人、气候冬暖夏凉。是距市区近、规模大的宗教文化、健身休闲、自然生态于一体的综合性旅游区。区内有佛教古寺――龙泉寺，寺院一侧因有一数百年龙井而得名；现存有天王殿、大雄宝殿、龙王殿、三圣殿、藏经阁、客堂、法堂、厢房、斋堂等佛教建筑。	2024-10-24 02:50:58	\N	\N	\N	\N	\N	\N	\N	\N	10700	2	f	\N	\N	\N	\N	\N
181	\N	6	维也纳酒店（十堰世纪山水店）	2024-10-23 07:07:55	<p>中国中铁·世纪山水的维也纳酒店世纪山水店共有11层，其中5-11层合计110余间客房，更配备豪华精装大堂、奢华餐厅及宴会厅等，不管是住宿、乔迁，还是家有喜事、商务宴请都可以在这里预约举办。</p>	11-67198189d85b6976459527.jpg	维也纳酒店（十堰世纪山水店）	2024-10-23 23:06:49	\N	\N	\N	\N	0719-8028895	32.650522	110.722263	张湾区发展大道和建设大道交会处中国中铁·世纪山水35号	6100	2	f	\N	\N	\N	\N	\N
206	\N	\N	夏天玩水才是正经事！那就从这儿开始吧→	2024-10-24 02:44:13	\N	1mf3212000b9v0ytzc0af-w-671-0-q90-6719b47e955e2767221424.jpg	武当山四季如春的景色和别致清幽的环境美不胜收,许多人只知道春秋两季是登武当山的好季节，因为此时气候温和，适宜外出。其实不然，夏季才是武当山的真正魅力所在，武当山可是享有“天下第一幽”、“全国十大避暑胜地”等美誉。	2024-10-24 02:44:14	\N	\N	\N	\N	\N	\N	\N	\N	17900	2	f	\N	\N	\N	\N	\N
207	\N	\N	在浪漫的春天里，将「踏青露营计划」提上日程，莫负春日好时光~	2024-10-24 02:45:22	\N	1mf5612000az19665812b-w-671-0-q90-6719b4c32f453273862034.jpg	春暖花开，清风徐来，感受微风暖阳间的美好，露营是春天的最佳打开方式之一。\r\n当你逃离城市的车水马龙，远离生活的忙碌奔波，在绽放着勃勃生机的草坪间畅快奔跑、露营野餐，听着春风吹拂树叶、草丛沙沙作响的声音，让身心完全沉浸在自然与绿意之中，惬意、宁静就缓缓淌入心里。	2024-10-24 02:45:23	\N	\N	\N	\N	\N	\N	\N	\N	6500	2	f	\N	\N	\N	\N	\N
140	\N	\N	十堰市图书馆	2024-09-18 08:08:42	<p>十堰市图书馆是政府举办的综合性公共图书馆，是十堰市文献收藏利用中心、信息咨询服务中心。该图书馆于1979年建馆。现馆舍大楼总面积11364平方米，藏书78万册，每年订购报刊1千多种。图书馆全年365天开馆。</p><p>2018年5月14日，第六次全国县级以上公共图书馆评估定级结果公布，十堰市图书馆被评为一级图书馆。</p>	rn-image-picker-lib-temp-e40613be-b931-4a42-b7dd-0bc6480d28c9-66ea8a8b02fe6108496344.jpg	十堰市图书馆	2024-09-18 08:08:43	\N	\N	\N	\N	\N	32.655685	110.781265	人民广场	6900	2	\N	\N	\N	\N	\N	\N
179	\N	6	希尔顿花园酒店	2024-10-23 07:06:00	<p>十堰希尔顿花园酒店是湖北省第一家希尔顿花园品牌酒店(Hilton Garden Inn)，位于十堰市新兴的凯旋大道。酒店地理位置优越，交通便利，距离十堰武当山机场仅20公里，驱车5分钟可到达四方山植物园和东风汽车产业园，20分钟便可到达中国道教文化发源地武当山，周边云集各类商务公司和高档住宅区，是商务和休闲人士下榻的理想之选。酒店拥有152间时尚优雅、设施齐全的花园客房，其中包含1间豪华套房。所有房间均配备43寸液晶电视、可调控灯光、舒适办公桌、免费高速网络覆盖全酒店，24小时客房内远程打印技术，让您的办公更加高效。</p>	1mc3b12000etvi4yx13e0-w-1080-808-r5-d-67199d2432d15331770165.jpg	希尔顿花园酒店	2024-10-24 01:04:36	\N	\N	\N	\N	0719-8628888	32.656515	110.760433	张湾区车城路街道凯旋大道9号	17500	2	f	\N	\N	\N	\N	\N
183	\N	\N	十堰体育中心	2024-10-23 07:09:49	<p>十堰市体育中心位于"百里车城"十堰市北京中路熊家湾，距市中心仅1公里，占地面积150亩，规划拥有体育场、游泳池、综合训练馆、网球场、室外健身苑、室内健身房等综合性设施。</p>	1-6719b21f96d13455878962.jpg	十堰体育中心	2024-10-24 02:34:07	\N	\N	\N	\N	\N	32.6483	110.800412	张湾区汉江路街道北京中路62号	12700	2	f	\N	\N	\N	\N	\N
208	\N	\N	黄龙壹号生态园	2024-10-24 02:48:39	<p><strong>介绍</strong></p><p>黄龙壹号生态是黄龙生态文化旅游区子项目之一，位于黄龙镇斤坪村，生态园内包括高新农业技术展示馆、绿色生活馆、热带风情馆、蔬菜花卉馆、生态餐厅等5个温室场馆和配套设施及园区环境营造。</p><p><strong>开放时间</strong></p><p>全年 周一-周五 09:00-17:30开放;全年 周六-周日 09:00-18:00开放</p><p><strong>优待政策</strong></p><p>儿童：身高1.2米（含）以上-1.4米（不含），半价；1.2米(不含）以下，免费</p><p>学生：大中小学生，凭学生证，半价</p><p>老人：年龄60周岁（不含）-70周岁（含）凭身份证，半价；70岁（不含）以上，免费</p><p>现役军人：凭军人证，免费</p><p>残疾人：凭残疾人证，免费</p>	1-6719b587e22c1156399274.jpg	黄龙壹号生态是黄龙生态文化旅游区子项目之一，位于黄龙镇斤坪村，生态园内包括高新农业技术展示馆、绿色生活馆、热带风情馆、蔬菜花卉馆、生态餐厅等5个温室场馆和配套设施及园区环境营造。	2024-10-24 02:48:39	\N	\N	\N	\N	\N	\N	\N	\N	19800	2	f	\N	\N	\N	\N	\N
176	\N	\N	水电宾馆	2024-10-23 07:00:41	<p>三星级宾馆，位于张湾黄龙镇小狭路1号。是一家集餐饮、住宿、培训、运动休闲为一体的国家星级宾馆。十堰水电宾馆由接待中心楼、宴宾楼、仿真培训楼、市内运动馆、拓展基地组成。可同时提供140人住宿、300人的就餐服务；同时配设规格齐全的会议室9个、培训教室4个，各类会议室可容纳20-300人就座、培训教室可一次接待60人上课。此外，宾馆内还设有运动中心，包括设备先进的室内运动场馆一座，可提供篮球、羽毛球、乒乓球等竞技比赛；室外网球场、篮球场、运动跑道、拓展基地等场地，是挥洒热情、休闲娱乐的好去处。</p>	oip-c-6719ad84cb613754545464.jpg	水电宾馆	2024-10-24 02:14:28	\N	\N	\N	\N	0719-8586247	32.679376	110.530227	张湾黄龙镇小狭路1号	11000	2	f	\N	\N	\N	\N	\N
152	\N	\N	黄龙滩电厂	2024-10-23 06:43:37	<p>黄龙滩工业生态旅游区是一座以黄龙滩水力发电厂为核心、集旅游、观光、娱乐、科普于一体的生态旅游区和工业旅游示范点。景点分布：黄龙电厂工业生态旅游区由黄龙滩水电站开发经营，分为园艺区和工业生产区，设有激光塔、观瀑台、光电广场、水电科普参观、乒乓球、羽毛球、网球等娱乐项目，旅游服务区内的假日旅馆、别墅、公共娱乐，则会让尽兴游玩的客人有种回家的舒适与惬意。水库周边山水秀美，奇峰怪石、岛屿洞穴等地文景观十分丰富，坝区的虎啸山、龙吟山、小峡沟、大峡沟，库区的二龙戏珠、岩屋洞等颇具观光价值。景区特色：休闲观光、工业观光、水利景观。</p>	6464f990e7029242213bebfde46829ce-67199c80e7681241360170.jpg	黄龙滩电厂	2024-10-24 01:01:52	\N	\N	\N	\N	\N	32.677533	110.524367	十堰市张湾区黄龙镇小峡路	5000	2	f	\N	\N	\N	\N	\N
199	\N	\N	东风商用车总部	2024-10-23 07:19:42	<p>东风商用车公司的前身是1969年开始建设，1975年正式投产的第二汽车制造厂(1992年更名为东风汽车公司)中重型商用车制造业务，2003年东风汽车公司与日本日产汽车公司合资组建中国汽车行业最大的合资公司--东风汽车有限公司后，东风汽车公司原中重型商用车资产及业务全部进入东风汽车有限公司，成为东风汽车有限公司中重型商用车事业部。2015年1月26日，由东风汽车集团股份有限公司和沃尔沃集团共同投资组建的东风商用车有限公司，在湖北十堰正式成立并运营。</p>	v2-f05a7a21976813c96b9699a5222e29f5-r-67199ec6015d5967003479.jpg	东风商用车总部	2024-10-24 01:11:34	\N	\N	\N	\N	\N	\N	\N	\N	5500	2	f	\N	\N	\N	\N	\N
190	\N	\N	湖北武当窑文化发展有限责任公司（武当窑）	2024-10-23 07:13:55	<p>600年前，为制造武当宏伟建筑的琉璃构件，在丹江修建专供武当的皇家琉璃窑场，经故宫博物院前院长单霁翔考察后确认，该窑址是迄今为止我国发现的第五座明代皇家官窑遗址。“北修故宫，南修武当”武当琉璃无声诉说着，故宫与武当之间的神秘关系，武当官窑是楚文化不可缺少的组成部分，而在我们十堰却面临失传和断代的危险。 湖北武当窑文化发展有限责任公司紧紧围绕武当官窑文化，深挖武当官窑工艺，制定产品工艺标准，努力打造武当官窑品牌，丰富楚陶文化内涵，作为武当陶瓷产业的传承和创新者，充分利用十堰本地丰富富硒富锶泥料资源，进行产品创新，以创业带动就业，辐射带动家门口农村剩余劳动力就业致富。武当官窑文化将成为楚文化陶瓷篇章的。有力组成部分，中国传统文化技艺也将得到传承和发扬。</p>	1-6719b11a17168570849901.jpg	湖北武当窑文化发展有限责任公司（武当窑）	2024-10-24 02:29:46	\N	\N	\N	\N	\N	32.60007	110.704979	十堰市张湾区花果街道桃子村百龙潭景区内	13000	2	f	\N	\N	\N	\N	\N
132	\N	\N	甜蜜来袭！张湾夏日水果采摘攻略来了	2024-09-18 03:02:00	<h2>甜蜜来袭！张湾夏日水果采摘攻略来了</h2>	640-66ea42a879918439629554.jpg	甜蜜来袭！张湾夏日水果采摘攻略来了	2024-09-18 03:02:00	\N	\N	\N	\N	\N	\N	\N	\N	11400	2	\N	\N	\N	\N	\N	\N
133	\N	\N	25分钟！央视专题报道张湾汉江樱桃	2024-09-18 03:03:16	<h2>25分钟！央视专题报道张湾汉江樱桃</h2><p><br>&nbsp;</p>	2-66ea42f4c8ec8678216616.jpg	25分钟！央视专题报道张湾汉江樱桃	2024-09-18 03:03:16	\N	\N	\N	\N	\N	\N	\N	\N	7100	2	\N	\N	\N	\N	\N	\N
146	\N	\N	沙洲猕猴桃	2024-09-19 04:47:52	<p>沙洲猕猴桃</p>	3-66ebacf821973490085798.jpg	沙洲猕猴桃	2024-09-19 04:47:52	\N	\N	\N	\N	\N	\N	\N	\N	8700	2	\N	\N	\N	\N	\N	\N
134	\N	\N	采茶正当时，赴张湾饮一段春光！	2024-09-18 03:04:38	<h2>采茶正当时，赴张湾饮一段春光！</h2>	22-66ebca4e51ef1017687844.jpg	采茶正当时，赴张湾饮一段春光！	2024-09-19 06:53:02	\N	\N	\N	\N	\N	\N	\N	\N	4900	2	\N	\N	\N	\N	\N	\N
147	\N	\N	遇尝鸣子菜籽油	2024-09-19 04:48:41	<p>遇尝鸣子菜籽油</p>	yu-chang-ming-zi-cai-zi-you-66ebad29eebd8393198762.jpg	遇尝鸣子菜籽油	2024-09-19 04:48:41	\N	\N	\N	\N	\N	\N	\N	\N	10300	2	\N	\N	\N	\N	\N	\N
135	\N	\N	甜蜜暴击.ᐟ‪.ᐟ十堰张湾「夏日水果采摘图鉴」来啦~	2024-09-18 03:05:46	<h2>甜蜜暴击.ᐟ‪.ᐟ十堰张湾「夏日水果采摘图鉴」来啦~</h2>	11-66ebca42ba159115919800.jpg	甜蜜暴击.ᐟ‪.ᐟ十堰张湾「夏日水果采摘图鉴」来啦~	2024-09-19 06:52:50	\N	\N	\N	\N	\N	\N	\N	\N	13700	2	\N	\N	\N	\N	\N	\N
139	\N	\N	知雨轩别院民宿	2024-09-18 08:08:10	<p>知雨轩·别院民宿项目，位于十堰市张湾区柏林镇柏林村境内，距离市区不足20公里，交通便利。建筑面积780㎡，经营面积500㎡，共有19间客间，房间均配备国际一线品牌的洁具，床品和智能化语音家电设备，装修环境低奢，生态,倡导了低奢旅居式的田园生活。知雨轩别院民宿通过对民房改造 “风貌古朴、功能现代、产业有机、文明复归”，挖掘当地特有的历史文化底蕴，依托特色自然景观，打造了以[隐陌][隐庐]为名的别院民宿，突出清风茶舍、清水休闲、依山傍水、农事农耕、文旅康养、采摘体验、山水一体的特色自然康养民宿项目。知雨轩别院民宿最大特点在于轻奢、康养、生态田园风格,建有千米农耕文化长廊、传统技艺体验中心、非遗文化展示馆、智慧农业体验馆、花园式原种种植采摘基地、食育文化科普馆、农业图书馆、大中小多规格数字会议厅、轩林树屋、轩茗茶社、轩墨书画社、轩昂乒乓、轩雨垂钓、轩越清吧、康养集群，是田园体验、休闲娱乐、康养颐居、聚会活动的绝佳选择；可让旅客在繁忙的城市于休闲中感受闲适的田园康养度假生活，体验“望得见山，看的见水，记得住乡愁“的全新生活实景。为了保证客人前来玩的开心、住的舒心、吃的放心，民宿特有的一对一管家式服务也为旅客提供了良好的保障。其中生活管家负责生活服务、服务管家负责旅客全程所有的交通出行及私人定制服务。同时为保证游客更多层次的需求，周边配套33个包厢，2个多功能厅，大中小5个会议室，可同时容纳2000人就餐、培训、团建，是亲朋好友聚会、商务接待、田园农事体验、旅游康养的绝佳选择。截至目前，知雨轩别院民宿已接待近万人次及过百政企单位的团队调研参观学习。CCTV央视农村农业频道、中央新影发现之旅[美丽家园]栏目、CCTV中文国际栏目、CCTV[智慧树]栏目相继报道知雨轩别院民宿;知雨轩别院民宿通过线上线下的引流和自身的品质资源，赢得了顾客的一致好评。</p>	rn-image-picker-lib-temp-21887288-c450-4f08-8007-d8f7b7c3c85b-66ea8a6a093b6725920222.jpg	知雨轩·庄园	2024-09-18 08:08:10	\N	\N	\N	\N	0719-8871188	32.654355	110.624747	张湾区柏林镇柏林村1组	15300	2	\N	\N	\N	\N	\N	\N
142	\N	\N	招商·兰溪谷	2024-09-19 04:39:34	<h2><strong>招商·兰溪谷</strong></h2>	r-c-66ebab063a3d7659405916.jpeg	招商·兰溪谷	2024-09-19 04:39:34	\N	\N	\N	\N	\N	\N	\N	\N	13700	2	\N	\N	\N	\N	\N	\N
84	\N	\N	白马山旅游区	2024-05-15 04:11:47	<p>国家AAA级旅游区，位于十堰市张湾区柏林镇和黄龙镇之间，距市中心26公里，处在武当山——十堰——古城西安旅游线上。因其山势酷似奔腾的骏马，加之相传真武大帝曾骑白马在此修炼，并留下栓马石、跑马道、回马洞、卧马崖等以马为名的十几处风景和传说，白马山因此而得名。其山势呈南北走向，总面积30平方公里，主峰海拔1088米，是武当山七十二峰之一。站在山顶，东望大岳武当金顶，西看黄龙库区风光，南眺赛武当，北览车城全景，是一处集谷、崖、洞、水、林、石等自然风光于一体，以“一山一水一谷五观九瀑十潭”为代表，融雄、奇、险、秀、幽和道教文化为主要特点的文化生态旅游胜地。1996年白马山被列为市级首批文物保护单位，2002年被列为湖北省自然生态保护区。白马山道教文化渊源流长。据史料记载，真武祖师最初在此龙凤宝地修炼，元末明初，又点化五位擅长占卜、武术、医药、音乐、茶道的举子在此得道成仙。道教的五路财神道场自宋朝开始，香火鼎盛，“请财神、送财神”民俗在全国独具特色。白马山自然资源十分丰富，有名贵中草药两百余种，珍稀保护动植物一百六十余种。同时，白马山人文资源丰富，有祖师殿、财神庙、五仙庙、金鞍台、太极洞、玄天洞、龙头香等历史文化遗址36处，“前山看凤、后山观龙、腹抱财神、金棺石瀑”形成白马山四大奇观。2007年1月，张湾区委、区政府成立了白马山旅游开发指挥部，同年3月正式启动了白马山旅游区开发建设工作。编制完成了《十堰武当白马山旅游区控制与修建性规划》。两年来，区政府投资两千多万元完成了白马山前后山旅游公路，前后山生态游道、停车场、聚仙谷旅游区基础设施建设，编制完成了“十堰武当白马山旅游区控制与修建性规划”，2008年3月31日，张湾区人民政府常务会议审查批准《十堰武当白马山旅游区控制与修建性规划》。白马山下一步开发需要加大政府投入和招商引资力度，重点挖掘道教文化、财神民俗文化，与黄龙古镇及堵河水系资源有机结合，形成白马山——黄龙古镇旅游区，努力把白马山——黄龙库区建设成为集生态观光、文化休闲、运动养生于一体国家AAA景区及十堰市“三区三线”旅游格局中的一条山水相连精品线路。可乘1路公汽、叶大乡中巴车在白马山村可到达。</p>	bai-ma-shan-rui-zhi-min-1-66e494f327114653823154.jpg	白马山旅游区	2024-09-13 19:39:31	\N	\N	\N	\N	\N	32.649293	110.574254	十堰市张湾区柏林镇白马山村	17900	2	\N	\N	\N	\N	\N	\N
202	\N	\N	东风汽车有限公司装备公司	2024-10-23 07:45:40	<p>东风汽车有限公司装备公司，于2003-06-26在湖北省注册成立。属于非金属矿物制品业，主营行业为非金属矿物制品业，服务领域为铸锻件、机电设备、刃具、模具、汽车零部件的制造、销售。</p>	1-67199e40100e4924231970.jpg	东风汽车有限公司装备公司	2024-10-24 01:09:20	\N	\N	\N	\N	\N	\N	\N	十堰市张湾区车城街办公园路116号W2幢	8300	2	f	\N	\N	\N	\N	\N
99	\N	\N	牛头山顶落日	2024-05-15 05:45:37	<p>牛头山顶落日</p>	1-66ebbce03c9ed662835048.jpg	牛头山顶落日	2024-09-19 05:55:44	\N	\N	\N	\N	\N	\N	\N	牛头山	10200	2	\N	\N	2024-10-24 00:00:00	2024-10-31 00:00:00	牛头山管理中心	\N
93	\N	\N	黄龙壹号生态园	2024-05-15 05:43:29	<p>国家AAA级旅游区，位于十堰市张湾区黄龙镇斤坪村，距市中心20公里。黄龙壹号生态园属黄龙生态文化旅游区子项目之一，规划占地面积为386亩，总投资2.2亿元，2012年始建，建设周期2年，由十堰帝龙旅游开发有限公司独资组建的益合农业科技公司兴建，是十堰市农业产业扶贫和农业转型升级的重点项目，该项目由中国农科院下属北京中环易达科技园艺设施有限公司和日本利根川规划设计，国内最大温室生产企业上海都市绿色工程有限公司承建。园区自2015年运营以来，年接待旅游人数30万人次；辐射带动农民脱贫作用突出，生态良好，环境优美，有效推动新农村建设和城乡一体化发展，示范带动效果好。是我市休闲观光生态农业示范基地。园区建有高科技农业展示馆、蔬菜花卉馆、都市生活馆、热带风情馆、生态餐厅等5个智能温室场馆和高品质的园林景观。可乘1路、52路公汽在斤坪村可到达。</p>	huang-long-yi-hao-sheng-tai-yuan-66e494b71e294498991394.jpg	黄龙壹号生态园	2024-09-13 19:38:31	\N	\N	\N	\N	\N	32.670731	110.605498	十堰市张湾区西城路181号	7800	2	\N	\N	\N	\N	\N	\N
198	\N	\N	青龙山度假区	2024-10-23 07:19:26	\N	oip-c-67199ee946ac4033152153.jpg	青龙山度假区	2024-10-24 01:12:09	\N	\N	\N	\N	\N	\N	\N	\N	13600	2	f	\N	\N	\N	\N	\N
174	\N	\N	黄龙滩电厂樱花大道	2024-10-23 06:59:07	\N	90-6719a3fcd387f217146867.jpg	黄龙滩电厂樱花大道	2024-10-24 01:33:48	\N	\N	\N	\N	\N	32.677533	110.524367	黄龙镇黄龙滩电厂	6300	2	f	\N	\N	\N	\N	\N
173	\N	\N	大岭路	2024-10-23 06:58:32	\N	1-6719a9e9da9cd970132615.jpg	大岭路	2024-10-24 01:59:05	\N	\N	\N	\N	\N	32.661352	110.765991	张湾区车城路街道大岭路	17600	2	f	\N	\N	\N	\N	\N
171	\N	\N	阳光栖谷天街	2024-10-23 06:57:46	\N	1-67199f5b8ece0852024419-6719aa28ba7b9982444211.jpg	阳光栖谷天街	2024-10-24 02:00:08	\N	\N	\N	\N	\N	32.655105	110.800962	张湾区北京北路57号	6200	2	f	\N	\N	\N	\N	\N
100	\N	\N	云水方滩休闲度假区	2024-05-15 05:46:01	<p>国家AAA级旅游区，占地面积约400亩，交通便利，距十堰城区25公里。旅游区青山环绕，峡谷幽美，堵河如画，碧水静流，仿佛至于世外桃源；锦绣园、房车营地、堵河廊道、行人绿道、采摘园、天然草地广场等成为知名网红打卡点；富有水乡渔村文化特色的特色鱼宴产业园更是集商品销售、民俗体验、乡土美食于一体的新体验地。旅游区设施完备，游客中心、停车场、警务室、医务室、农家乐、民宿区、旅游公厕等一应俱全。旅游区定期举办的“慢生活文化旅游节”“采摘节”有着很高的知名度，已成为张湾区一张靓丽的名片。可乘1路、52路公交车，1路公交车至黄龙镇大桥路口下车转乘52路公交车即可到达。</p>	yun-shui-fang-tan-du-he-hua-lang-kang-yang-lu-you-du-jia-qu-jian-shan-cha-she-wai-guan-66e49391eb54c947037806.jpg	云水方滩休闲度假区	2024-10-22 15:05:52	\N	\N	\N	\N	\N	32.737731	110.606084	十堰市张湾区方滩乡方滩村	20000	2	\N	zhu-su-3x-6717bf50483f2972649824.png	\N	\N	\N	\N
90	\N	\N	十堰邦辉国际大酒店	2024-05-15 05:28:10	<p>是一家商务型酒店，集餐饮、客房、会议、休闲、购物、娱乐为一体，坐落于湖北省十堰市繁华商业街公园路中段，地理位置优越，周边社区功能齐全:银行、车站、大型超市、购物步行街信步可达。是商务、旅游、休闲人士的理想居停之选。 十堰邦辉国际大酒店开业时间2005年9月，位于东风实业大厦10-23层，客房总数164间(套)。</p>	200g190000017c1el2fce-w-1080-808-r5-d-66ea349ca770f898829100.jpg	十堰邦辉国际大酒店	2024-09-18 02:02:04	\N	\N	\N	\N	0719-8269212	32.650608	110.768488	张湾区车城路街道公园路99号东风实业大厦	14600	2	\N	\N	\N	\N	\N	\N
159	\N	\N	东风故里历史文化街区	2024-10-23 06:45:45	<p>该项目位于花果街道放马坪，以“放马坪”文化古巷为中心，辐射至花果山古龙泉寺片区、东风6264片区、花果中大街片区。项目占地2平方公里，建筑面积约100万平方米。主要包括“东风故里”片区基础设施提档升级、管线综合改造，水流域综合治理、各类旧址及辅助用房综合改造等内容。同时建设“东风故里”文化场馆、人文纪念馆、创意文化场馆等项目，着力将花果街道“放马坪”文化古巷升级打造为十堰市“东风故里。</p>	1633090100709145-671979e80b5bf782249607.jpg	东风故里历史文化街区	2024-10-23 22:34:16	\N	\N	\N	\N	\N	32.656615	110.670304	十堰市张湾区花果街道花园新村	13400	2	f	\N	\N	\N	\N	\N
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
151	27
151	41
151	44
152	27
152	41
152	44
153	27
153	41
153	44
154	27
154	41
154	44
155	27
155	41
155	44
156	27
156	41
156	44
157	27
157	41
157	44
158	27
158	41
158	44
159	27
159	41
159	44
160	41
160	44
161	29
161	31
162	29
162	31
163	29
163	31
164	29
164	31
166	31
167	31
168	31
169	31
170	31
165	41
166	41
167	41
168	41
169	41
170	41
171	31
171	41
172	31
172	41
173	31
173	41
174	31
174	41
175	31
175	41
176	29
176	31
177	29
177	31
178	29
178	31
179	29
179	31
180	29
180	31
181	29
181	31
182	36
182	42
183	36
183	42
184	36
184	42
185	36
185	42
186	36
186	42
187	36
187	42
188	43
188	39
189	43
189	39
190	36
190	42
191	36
191	42
192	36
192	42
193	36
193	42
195	36
195	42
196	36
196	42
197	36
197	42
198	36
198	42
199	36
199	42
200	36
200	42
201	36
201	42
202	36
202	42
203	45
204	45
205	45
206	45
207	45
208	46
209	46
210	46
211	46
212	46
\.


--
-- Data for Name: node_tag; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public.node_tag (node_id, tag_id) FROM stdin;
192	11
201	9
154	14
154	15
89	3
186	21
186	4
97	7
97	15
96	18
96	12
138	16
99	10
143	13
132	17
133	9
133	6
145	9
145	10
146	3
147	5
147	4
135	7
135	16
139	4
139	9
139	18
142	8
142	18
142	19
148	18
136	11
137	21
91	9
91	7
91	17
131	20
150	21
84	5
84	19
149	9
202	22
158	17
160	5
160	13
164	12
164	11
165	16
167	22
167	4
168	13
169	4
169	6
171	8
172	19
174	11
178	21
180	13
180	4
188	22
184	18
184	7
184	14
189	18
193	5
196	21
197	12
197	8
197	20
198	8
198	3
98	11
98	10
153	10
162	12
156	20
156	11
157	17
161	11
161	18
161	13
130	17
90	4
90	6
181	8
182	14
182	6
140	16
140	10
183	22
185	4
190	14
200	20
199	11
85	3
85	17
151	5
151	8
151	17
152	8
155	14
155	17
155	8
175	7
179	11
191	19
191	13
158	6
158	19
158	22
158	13
211	16
211	12
211	18
211	13
211	5
149	13
149	8
149	3
149	22
156	6
156	17
156	19
212	19
212	22
212	18
212	13
212	10
94	15
94	7
94	13
94	10
94	17
155	11
155	15
185	9
185	21
185	15
185	14
148	15
148	3
148	10
148	16
136	22
136	13
136	5
136	4
126	16
126	22
126	8
126	6
126	4
143	20
143	12
143	9
143	18
145	3
145	19
145	7
151	16
151	13
130	6
130	7
130	21
130	14
137	8
137	18
137	11
137	3
192	16
192	8
192	4
192	9
96	15
96	13
96	22
138	7
138	3
138	5
138	17
177	10
177	4
177	19
177	12
177	9
188	5
188	19
188	17
188	13
95	17
95	7
95	22
95	15
95	6
85	10
85	12
85	20
131	18
131	13
131	3
131	14
165	21
165	11
165	18
165	7
191	6
191	18
191	8
200	14
200	16
200	10
200	4
197	7
197	18
195	10
195	21
195	9
195	4
195	20
193	20
193	11
193	18
193	17
196	7
196	19
196	18
196	6
178	8
178	16
178	9
178	7
172	5
172	4
172	9
172	16
170	15
170	13
170	18
170	9
170	19
169	12
169	13
169	22
168	12
168	19
168	4
168	14
167	21
167	18
167	5
166	8
166	4
166	14
166	15
166	22
160	7
160	10
160	18
154	5
154	13
154	19
201	5
201	22
201	20
201	14
175	17
175	21
175	14
175	13
97	14
97	17
97	19
150	5
150	15
150	17
150	8
203	22
203	21
203	12
203	5
203	20
91	22
91	4
141	21
141	15
141	14
141	11
141	13
144	6
144	5
144	17
144	14
144	11
186	12
186	19
186	20
98	6
98	20
98	17
153	18
153	13
153	3
153	4
180	5
180	9
180	18
189	3
189	22
189	10
189	15
164	7
164	16
164	10
204	17
204	11
204	12
204	20
204	16
89	17
89	19
89	8
89	20
162	21
162	19
162	14
162	8
187	17
187	13
187	6
187	8
187	14
184	4
184	16
209	3
209	21
209	7
209	8
209	11
157	12
157	14
157	3
157	4
205	19
205	13
205	11
205	12
205	10
163	19
163	6
163	5
163	18
163	16
161	15
161	3
182	22
182	7
182	19
210	6
210	19
210	22
210	12
210	20
181	3
181	14
181	16
181	17
206	16
206	6
206	10
206	20
206	3
207	14
207	15
207	11
207	19
207	7
140	18
140	21
140	20
183	15
183	11
183	8
183	16
208	10
208	3
208	4
208	22
208	18
179	19
179	17
179	7
179	18
176	13
176	20
176	14
176	8
176	17
152	15
152	20
152	7
152	17
199	3
199	7
199	4
199	19
190	22
190	8
190	19
190	9
132	10
132	20
132	11
132	6
133	10
133	7
133	8
146	16
146	13
146	22
146	21
134	3
134	21
134	14
134	11
134	19
147	19
147	12
147	3
135	19
135	20
135	10
139	3
139	6
142	15
142	3
84	11
84	13
84	10
202	8
202	17
202	10
202	9
99	16
99	19
99	8
99	14
93	20
93	16
93	9
93	17
93	11
198	12
198	10
198	11
174	22
174	12
174	19
174	7
173	17
173	11
173	13
173	7
173	3
171	14
171	19
171	11
171	13
100	22
100	19
100	14
100	9
100	12
90	20
90	9
90	3
159	22
159	19
159	4
159	3
159	7
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
5	游记	youji	0
3	版块	leyou	0
\.


--
-- Data for Name: plan; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public.plan (id, title, month, days, cost, who, body, summary, u_id, node_id) FROM stdin;
2	东风故里历史文化街区	\N	\N	\N	\N	\N	\N	5	\N
3	行程：东风故里历史文化街区	\N	\N	\N	\N	\N	\N	5	\N
4	东风故里历史文化街区	\N	\N	\N	\N	\N	\N	5	159
5	东风故里历史文化街区	\N	\N	\N	\N	\N	\N	5	\N
6	东风故里历史文化街区	\N	\N	\N	\N	\N	\N	5	\N
7	东风故里历史文化街区	\N	\N	\N	\N	\N	\N	5	\N
8	东风故里历史文化街区	\N	\N	\N	\N	\N	\N	5	\N
9	青龙山文化旅游度假区	\N	\N	\N	\N	\N	\N	5	158
\.


--
-- Data for Name: rate; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public.rate (id, node_id, u_id, created_at, rate) FROM stdin;
1	159	5	2024-10-23 10:26:00	4.5
2	159	6	2024-10-23 11:07:31	5
3	192	1	2024-10-23 12:31:43	5
4	201	1	2024-10-23 12:31:43	4.6
5	154	1	2024-10-23 12:31:43	4.6
6	97	1	2024-10-23 12:31:43	4.5
7	96	1	2024-10-23 12:31:43	4.7
8	138	1	2024-10-23 12:31:43	4.7
9	126	1	2024-10-23 12:31:43	4.8
10	143	1	2024-10-23 12:31:43	4.6
11	132	1	2024-10-23 12:31:43	4.6
12	133	1	2024-10-23 12:31:43	4.9
13	145	1	2024-10-23 12:31:43	4.5
14	146	1	2024-10-23 12:31:43	4.9
15	134	1	2024-10-23 12:31:43	5
16	165	1	2024-10-23 12:31:43	4.6
17	147	1	2024-10-23 12:31:43	4.8
18	135	1	2024-10-23 12:31:43	4.8
19	139	1	2024-10-23 12:31:43	4.6
20	142	1	2024-10-23 12:31:43	4.6
21	148	1	2024-10-23 12:31:43	4.9
22	136	1	2024-10-23 12:31:43	4.5
23	137	1	2024-10-23 12:31:43	4.7
24	91	1	2024-10-23 12:31:43	4.5
25	131	1	2024-10-23 12:31:43	5
26	141	1	2024-10-23 12:31:43	5
27	144	1	2024-10-23 12:31:43	5
28	99	1	2024-10-23 12:31:43	4.8
29	150	1	2024-10-23 12:31:43	4.6
30	84	1	2024-10-23 12:31:43	4.6
31	94	1	2024-10-23 12:31:43	4.6
32	202	1	2024-10-23 12:31:43	4.9
33	177	1	2024-10-23 12:31:43	4.9
34	130	1	2024-10-23 12:31:43	4.8
35	200	1	2024-10-23 12:31:43	5
36	158	1	2024-10-23 12:31:43	4.8
37	93	1	2024-10-23 12:31:43	5
38	89	1	2024-10-23 12:31:43	4.9
39	186	1	2024-10-23 12:31:43	4.9
40	160	1	2024-10-23 12:31:43	4.9
41	164	1	2024-10-23 12:31:43	4.8
42	166	1	2024-10-23 12:31:43	4.6
43	167	1	2024-10-23 12:31:43	4.5
44	168	1	2024-10-23 12:31:43	4.7
45	169	1	2024-10-23 12:31:43	4.5
46	170	1	2024-10-23 12:31:43	4.7
47	171	1	2024-10-23 12:31:43	4.8
48	172	1	2024-10-23 12:31:43	4.8
49	173	1	2024-10-23 12:31:43	4.5
50	174	1	2024-10-23 12:31:43	4.7
51	178	1	2024-10-23 12:31:43	4.7
52	180	1	2024-10-23 12:31:43	4.8
53	188	1	2024-10-23 12:31:43	4.9
54	184	1	2024-10-23 12:31:43	4.7
55	149	1	2024-10-23 12:31:43	4.5
56	187	1	2024-10-23 12:31:43	5
57	189	1	2024-10-23 12:31:43	4.8
58	193	1	2024-10-23 12:31:43	4.8
60	195	1	2024-10-23 12:31:43	5
61	196	1	2024-10-23 12:31:43	4.8
62	197	1	2024-10-23 12:31:43	4.7
63	198	1	2024-10-23 12:31:43	5
64	98	1	2024-10-23 12:31:43	4.6
65	100	1	2024-10-23 12:31:43	5
66	153	1	2024-10-23 12:31:43	4.8
67	162	1	2024-10-23 12:31:43	4.7
68	156	1	2024-10-23 12:31:43	4.5
69	157	1	2024-10-23 12:31:43	4.9
70	161	1	2024-10-23 12:31:43	5
71	163	1	2024-10-23 12:31:43	4.9
72	159	1	2024-10-23 12:31:43	4.8
73	90	1	2024-10-23 12:31:43	4.7
74	181	1	2024-10-23 12:31:43	4.7
75	182	1	2024-10-23 12:31:43	4.7
76	140	1	2024-10-23 12:31:43	4.6
77	183	1	2024-10-23 12:31:43	4.5
78	185	1	2024-10-23 12:31:43	4.8
79	190	1	2024-10-23 12:31:43	4.6
80	199	1	2024-10-23 12:31:43	4.8
81	85	1	2024-10-23 12:31:43	4.6
82	151	1	2024-10-23 12:31:43	4.8
83	95	1	2024-10-23 12:31:43	4.6
84	152	1	2024-10-23 12:31:43	4.9
85	155	1	2024-10-23 12:31:43	4.6
86	175	1	2024-10-23 12:31:43	4.7
87	176	1	2024-10-23 12:31:43	4.8
88	179	1	2024-10-23 12:31:43	5
89	191	1	2024-10-23 12:31:43	4.6
90	158	1	2024-10-24 03:00:47	4.8
91	211	1	2024-10-24 03:00:47	4.9
92	149	1	2024-10-24 03:00:47	4.7
93	156	1	2024-10-24 03:00:47	4.9
94	212	1	2024-10-24 03:00:47	4.7
95	94	1	2024-10-24 03:00:47	5
96	155	1	2024-10-24 03:00:47	4.7
97	185	1	2024-10-24 03:00:47	4.8
98	148	1	2024-10-24 03:00:47	4.6
99	136	1	2024-10-24 03:00:47	5
100	126	1	2024-10-24 03:00:47	4.5
101	143	1	2024-10-24 03:00:47	5
102	145	1	2024-10-24 03:00:47	4.6
103	151	1	2024-10-24 03:00:47	5
104	130	1	2024-10-24 03:00:47	4.6
105	137	1	2024-10-24 03:00:47	4.8
106	192	1	2024-10-24 03:00:47	5
107	96	1	2024-10-24 03:00:47	4.5
108	138	1	2024-10-24 03:00:47	4.8
109	177	1	2024-10-24 03:00:47	5
110	188	1	2024-10-24 03:00:47	4.9
111	95	1	2024-10-24 03:00:47	5
112	85	1	2024-10-24 03:00:47	4.8
113	131	1	2024-10-24 03:00:47	4.6
114	165	1	2024-10-24 03:00:47	5
115	191	1	2024-10-24 03:00:47	5
116	200	1	2024-10-24 03:00:47	4.6
117	197	1	2024-10-24 03:00:47	4.9
118	195	1	2024-10-24 03:00:47	5
119	193	1	2024-10-24 03:00:47	4.6
120	196	1	2024-10-24 03:00:47	4.9
121	178	1	2024-10-24 03:00:47	4.7
122	172	1	2024-10-24 03:00:47	4.9
123	170	1	2024-10-24 03:00:47	4.6
124	169	1	2024-10-24 03:00:47	4.5
125	168	1	2024-10-24 03:00:47	4.5
126	167	1	2024-10-24 03:00:47	4.6
127	166	1	2024-10-24 03:00:47	5
128	160	1	2024-10-24 03:00:47	4.8
129	154	1	2024-10-24 03:00:47	5
130	201	1	2024-10-24 03:00:47	5
131	175	1	2024-10-24 03:00:47	4.7
132	97	1	2024-10-24 03:00:47	4.6
133	150	1	2024-10-24 03:00:47	4.9
134	203	1	2024-10-24 03:00:47	4.9
135	91	1	2024-10-24 03:00:47	4.6
136	141	1	2024-10-24 03:00:47	4.7
137	144	1	2024-10-24 03:00:47	4.5
138	186	1	2024-10-24 03:00:47	4.6
139	98	1	2024-10-24 03:00:47	4.6
140	153	1	2024-10-24 03:00:47	4.6
141	180	1	2024-10-24 03:00:47	4.6
142	189	1	2024-10-24 03:00:47	4.7
143	164	1	2024-10-24 03:00:47	4.8
144	204	1	2024-10-24 03:00:47	4.5
145	89	1	2024-10-24 03:00:47	4.6
146	162	1	2024-10-24 03:00:47	4.6
147	187	1	2024-10-24 03:00:47	4.8
148	184	1	2024-10-24 03:00:47	4.9
149	209	1	2024-10-24 03:00:47	4.8
150	157	1	2024-10-24 03:00:47	4.7
151	205	1	2024-10-24 03:00:47	4.8
152	163	1	2024-10-24 03:00:47	4.6
153	161	1	2024-10-24 03:00:47	4.6
154	182	1	2024-10-24 03:00:47	4.7
155	210	1	2024-10-24 03:00:47	4.6
156	181	1	2024-10-24 03:00:47	4.8
157	206	1	2024-10-24 03:00:47	4.9
158	207	1	2024-10-24 03:00:47	4.7
159	140	1	2024-10-24 03:00:47	5
160	183	1	2024-10-24 03:00:47	4.6
161	208	1	2024-10-24 03:00:47	4.5
162	179	1	2024-10-24 03:00:47	4.5
163	176	1	2024-10-24 03:00:47	4.9
164	152	1	2024-10-24 03:00:47	4.5
165	199	1	2024-10-24 03:00:47	5
166	190	1	2024-10-24 03:00:47	4.7
167	132	1	2024-10-24 03:00:47	4.5
168	133	1	2024-10-24 03:00:47	4.7
169	146	1	2024-10-24 03:00:47	4.6
170	134	1	2024-10-24 03:00:47	4.5
171	147	1	2024-10-24 03:00:47	4.5
172	135	1	2024-10-24 03:00:47	4.7
173	139	1	2024-10-24 03:00:47	5
174	142	1	2024-10-24 03:00:47	4.6
175	84	1	2024-10-24 03:00:47	4.6
176	202	1	2024-10-24 03:00:47	4.7
177	99	1	2024-10-24 03:00:47	4.6
178	93	1	2024-10-24 03:00:47	4.6
179	198	1	2024-10-24 03:00:47	4.8
180	174	1	2024-10-24 03:00:47	4.7
181	173	1	2024-10-24 03:00:47	4.6
182	171	1	2024-10-24 03:00:47	4.5
183	100	1	2024-10-24 03:00:47	5
184	90	1	2024-10-24 03:00:47	4.5
185	159	1	2024-10-24 03:00:47	4.5
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
43	门店	shop	1	\N	body,image,summary,createdAt	\N	\N	\N	\N	\N	\N
44	热聊	talk	1	list	createdAt,body,image,summary,tags,phone,address,price,marker,coord,regions	\N	3	\N	mei-shi-3x-6717bbca4cf03510615090.png	\N	2024-10-22 14:50:50
42	艺动	yi	1	list	body,image,summary,tags,createdAt,coord,phone,address,price,marker,regions	\N	3	\N	\N	\N	\N
41	玩法	wan	1	list	body,image,summary,tags,createdAt,coord,address,phone,price,marker,regions	\N	3	\N	\N	\N	\N
39	购物	gou	1	list	body,image,summary,tags,coord,phone,address,price,marker,regions	\N	3	\N	gou-wu-3x-6718b6252407e928359782.png	\N	2024-10-23 08:39:01
36	文创	wen	1	list	body,image,summary,tags,coord,phone,address,price,marker,regions	\N	3	\N	\N	\N	\N
29	住宿	zhu	6	list	summary,image,specs,body,tags,coord,phone,address,price,marker,regions	\N	3	\N	zhu-su-3x-6718b5fd9aab7479996533.png	\N	2024-10-23 08:38:21
27	景点	jing	10	list	summary,image,body,coord,tags,marker,address,phone,price,regions	\N	3	\N	jiu-dian-3x-6717bf72e7d3f860786186.png	\N	2024-10-22 15:06:26
40	活动	dong	1	list	body,image,summary,tags,createdAt,coord,phone,address,price,marker,regions,startAt,endAt,note	\N	3	\N	\N	\N	\N
46	路线	lu	5	list	image,summary,body,tags,images,specs	\N	3	\N	\N	2024-10-23 14:38:21	\N
45	游记	you	5	list	image,summary,body,regions,tags,images	\N	5	\N	\N	2024-10-23 14:35:22	\N
31	美食	shi	8	list	summary,image,body,coord,specs,tags,phone,address,price,marker,regions,category,area	\N	3	\N	mei-shi-3x-6718b60adad42565481062.png	\N	2024-10-23 08:38:34
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
-- Data for Name: step; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public.step (id, plan_id, datetime, body) FROM stdin;
\.


--
-- Data for Name: tag; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public.tag (id, name, label) FROM stdin;
3	民宿	minsu
4	农家乐	nongjiale
5	免费入园	mianfeiruyuan
6	地标建筑	dibiaojianzhu
7	免费开放	mianfeikaifang
8	度假区	dujiaqu
9	3A景区	3Ajingqu
10	全天开放	quantiankaifang
11	森林公园	senlingongyuan
12	烤全羊	kaoquanyang
13	特色美食	tesemeishi
14	农家菜	nongjiacai
15	一日游	yiriyou
16	两日游	liangriyou
17	三日游	sanriyou
18	进行中	jinxingzhong
19	待开始	daikaishi
20	开放中	kaifangzhong
21	闭馆中	biguanzhong
22	营业中	yingyezhong
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
24	\N	5	2024-10-23 14:13:17	37
25	\N	5	2024-10-27 06:36:05	43
26	\N	5	2024-10-27 06:43:41	36
27	\N	5	2024-10-27 06:48:58	44
28	\N	5	2024-10-27 06:51:06	47
29	\N	5	2024-10-27 06:51:15	46
30	\N	5	2024-10-27 06:51:17	45
31	\N	5	2024-10-27 07:04:12	40
32	\N	5	2024-10-27 07:04:16	38
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public."user" (id, username, roles, password, plain_password, openid, name, phone, avatar) FROM stdin;
8	test	[]	$2y$13$.yKUmknIiD/xeNMPm0mhhuodGnQpDysxqH7ISVsg7L2vBY9eTnobm	\N	\N	test	\N	avatar.jpg
6	oZkmM7ZXwrSLOHxN0UuUsyOajzco	[]	$2y$13$N36HzEkD9vCMNBi56A1YDuNbd8dK1ZuMz3wUbKRNwyz/Zcy/e4aQq	\N	oZkmM7ZXwrSLOHxN0UuUsyOajzco	用户ajzco	\N	avatar.jpg
2	al	["ROLE_SUPER_ADMIN"]	$2y$13$KpK7xAC8vlandkObN9kC4OAZVFw7SLtJvpf3PHICo4shV4haht9iK	\N	\N	子安	\N	avatar.jpg
3	root	["ROLE_SUPER_ADMIN","ROLE_ADMIN"]	$2y$13$vjcnglByWqC.GHCDZ3xIpuzHgPXtZ0mGvR5GPgXx7SBrGZRTTrmxi	\N	\N	子瞻	\N	avatar.jpg
1	admin	["ROLE_ADMIN"]	$2y$13$vfGjflZWMSRJ2lay3y.2kOitiuI/C.ps9CVHc3WfF63fl/CvY3Cmi	\N	\N	子由	\N	avatar.jpg
5	oZkmM7Rbd8fp9fQN3_WLJxpju6K8	[]	$2y$13$XMS5jp0Eg1oy1sZiF.bn0e5BmlwYzmOJ6YtWwj6R0B36xGsGb541e	\N	oZkmM7Rbd8fp9fQN3_WLJxpju6K8	用户ju6K8	\N	671e71fb540af-6GWPuo5ZvbCBdfddd86d22ce5b5eb9bbbe8ffc4f577d.jpeg
\.


--
-- Name: area_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zw
--

SELECT pg_catalog.setval('public.area_id_seq', 5, true);


--
-- Name: category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zw
--

SELECT pg_catalog.setval('public.category_id_seq', 13, true);


--
-- Name: comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zw
--

SELECT pg_catalog.setval('public.comment_id_seq', 47, true);


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

SELECT pg_catalog.setval('public.fav_id_seq', 78, true);


--
-- Name: feedback_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zw
--

SELECT pg_catalog.setval('public.feedback_id_seq', 15, true);


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

SELECT pg_catalog.setval('public.like_id_seq', 11, true);


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

SELECT pg_catalog.setval('public.node_id_seq', 212, true);


--
-- Name: order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zw
--

SELECT pg_catalog.setval('public.order_id_seq', 1, false);


--
-- Name: page_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zw
--

SELECT pg_catalog.setval('public.page_id_seq', 5, true);


--
-- Name: plan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zw
--

SELECT pg_catalog.setval('public.plan_id_seq', 9, true);


--
-- Name: rate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zw
--

SELECT pg_catalog.setval('public.rate_id_seq', 185, true);


--
-- Name: refund_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zw
--

SELECT pg_catalog.setval('public.refund_id_seq', 1, false);


--
-- Name: region_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zw
--

SELECT pg_catalog.setval('public.region_id_seq', 46, true);


--
-- Name: spec_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zw
--

SELECT pg_catalog.setval('public.spec_id_seq', 18, true);


--
-- Name: step_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zw
--

SELECT pg_catalog.setval('public.step_id_seq', 1, false);


--
-- Name: tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zw
--

SELECT pg_catalog.setval('public.tag_id_seq', 22, true);


--
-- Name: up_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zw
--

SELECT pg_catalog.setval('public.up_id_seq', 32, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zw
--

SELECT pg_catalog.setval('public.user_id_seq', 8, true);


--
-- Name: area area_pkey; Type: CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.area
    ADD CONSTRAINT area_pkey PRIMARY KEY (id);


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
-- Name: plan plan_pkey; Type: CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.plan
    ADD CONSTRAINT plan_pkey PRIMARY KEY (id);


--
-- Name: rate rate_pkey; Type: CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.rate
    ADD CONSTRAINT rate_pkey PRIMARY KEY (id);


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
-- Name: step step_pkey; Type: CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.step
    ADD CONSTRAINT step_pkey PRIMARY KEY (id);


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
-- Name: idx_43b9fe3ce899029b; Type: INDEX; Schema: public; Owner: zw
--

CREATE INDEX idx_43b9fe3ce899029b ON public.step USING btree (plan_id);


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
-- Name: idx_857fe845bd0f409c; Type: INDEX; Schema: public; Owner: zw
--

CREATE INDEX idx_857fe845bd0f409c ON public.node USING btree (area_id);


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
-- Name: idx_c53d045fe899029b; Type: INDEX; Schema: public; Owner: zw
--

CREATE INDEX idx_c53d045fe899029b ON public.image USING btree (plan_id);


--
-- Name: idx_d2294458460d9fd7; Type: INDEX; Schema: public; Owner: zw
--

CREATE INDEX idx_d2294458460d9fd7 ON public.feedback USING btree (node_id);


--
-- Name: idx_d2294458e4a59390; Type: INDEX; Schema: public; Owner: zw
--

CREATE INDEX idx_d2294458e4a59390 ON public.feedback USING btree (u_id);


--
-- Name: idx_dd5a5b7d460d9fd7; Type: INDEX; Schema: public; Owner: zw
--

CREATE INDEX idx_dd5a5b7d460d9fd7 ON public.plan USING btree (node_id);


--
-- Name: idx_dd5a5b7de4a59390; Type: INDEX; Schema: public; Owner: zw
--

CREATE INDEX idx_dd5a5b7de4a59390 ON public.plan USING btree (u_id);


--
-- Name: idx_dfec3f39460d9fd7; Type: INDEX; Schema: public; Owner: zw
--

CREATE INDEX idx_dfec3f39460d9fd7 ON public.rate USING btree (node_id);


--
-- Name: idx_dfec3f39e4a59390; Type: INDEX; Schema: public; Owner: zw
--

CREATE INDEX idx_dfec3f39e4a59390 ON public.rate USING btree (u_id);


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
-- Name: step fk_43b9fe3ce899029b; Type: FK CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.step
    ADD CONSTRAINT fk_43b9fe3ce899029b FOREIGN KEY (plan_id) REFERENCES public.plan(id);


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
-- Name: node fk_857fe845bd0f409c; Type: FK CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.node
    ADD CONSTRAINT fk_857fe845bd0f409c FOREIGN KEY (area_id) REFERENCES public.area(id);


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
-- Name: image fk_c53d045fe899029b; Type: FK CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.image
    ADD CONSTRAINT fk_c53d045fe899029b FOREIGN KEY (plan_id) REFERENCES public.plan(id);


--
-- Name: feedback fk_d2294458460d9fd7; Type: FK CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT fk_d2294458460d9fd7 FOREIGN KEY (node_id) REFERENCES public.node(id);


--
-- Name: feedback fk_d2294458e4a59390; Type: FK CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT fk_d2294458e4a59390 FOREIGN KEY (u_id) REFERENCES public."user"(id);


--
-- Name: plan fk_dd5a5b7d460d9fd7; Type: FK CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.plan
    ADD CONSTRAINT fk_dd5a5b7d460d9fd7 FOREIGN KEY (node_id) REFERENCES public.node(id);


--
-- Name: plan fk_dd5a5b7de4a59390; Type: FK CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.plan
    ADD CONSTRAINT fk_dd5a5b7de4a59390 FOREIGN KEY (u_id) REFERENCES public."user"(id);


--
-- Name: rate fk_dfec3f39460d9fd7; Type: FK CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.rate
    ADD CONSTRAINT fk_dfec3f39460d9fd7 FOREIGN KEY (node_id) REFERENCES public.node(id);


--
-- Name: rate fk_dfec3f39e4a59390; Type: FK CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.rate
    ADD CONSTRAINT fk_dfec3f39e4a59390 FOREIGN KEY (u_id) REFERENCES public."user"(id);


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

