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
-- Name: notify_messenger_messages(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.notify_messenger_messages() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
            BEGIN
                PERFORM pg_notify('messenger_messages', NEW.queue_name::text);
                RETURN NEW;
            END;
        $$;


ALTER FUNCTION public.notify_messenger_messages() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.category (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    label character varying(255) NOT NULL
);


ALTER TABLE public.category OWNER TO postgres;

--
-- Name: category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.category_id_seq OWNER TO postgres;

--
-- Name: conf; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.conf OWNER TO postgres;

--
-- Name: COLUMN conf.keywords; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.conf.keywords IS '(DC2Type:simple_array)';


--
-- Name: COLUMN conf.updated_at; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.conf.updated_at IS '(DC2Type:datetime_immutable)';


--
-- Name: conf_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.conf_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.conf_id_seq OWNER TO postgres;

--
-- Name: doctrine_migration_versions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.doctrine_migration_versions (
    version character varying(191) NOT NULL,
    executed_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    execution_time integer
);


ALTER TABLE public.doctrine_migration_versions OWNER TO postgres;

--
-- Name: feedback; Type: TABLE; Schema: public; Owner: postgres
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
    country character varying(30) DEFAULT NULL::character varying
);


ALTER TABLE public.feedback OWNER TO postgres;

--
-- Name: feedback_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.feedback_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.feedback_id_seq OWNER TO postgres;

--
-- Name: image; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.image (
    id integer NOT NULL,
    node_id integer NOT NULL,
    image character varying(255) NOT NULL
);


ALTER TABLE public.image OWNER TO postgres;

--
-- Name: image_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.image_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.image_id_seq OWNER TO postgres;

--
-- Name: language; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.language (
    id integer NOT NULL,
    language character varying(30) NOT NULL,
    prefix character varying(15) NOT NULL,
    locale character varying(15) NOT NULL
);


ALTER TABLE public.language OWNER TO postgres;

--
-- Name: language_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.language_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.language_id_seq OWNER TO postgres;

--
-- Name: link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.link (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    link character varying(255) NOT NULL,
    weight smallint NOT NULL,
    menu_id integer NOT NULL
);


ALTER TABLE public.link OWNER TO postgres;

--
-- Name: link_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.link_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.link_id_seq OWNER TO postgres;

--
-- Name: menu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.menu (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    label character varying(255) NOT NULL
);


ALTER TABLE public.menu OWNER TO postgres;

--
-- Name: menu_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.menu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.menu_id_seq OWNER TO postgres;

--
-- Name: messenger_messages; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.messenger_messages OWNER TO postgres;

--
-- Name: COLUMN messenger_messages.created_at; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.messenger_messages.created_at IS '(DC2Type:datetime_immutable)';


--
-- Name: COLUMN messenger_messages.available_at; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.messenger_messages.available_at IS '(DC2Type:datetime_immutable)';


--
-- Name: COLUMN messenger_messages.delivered_at; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.messenger_messages.delivered_at IS '(DC2Type:datetime_immutable)';


--
-- Name: messenger_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.messenger_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.messenger_messages_id_seq OWNER TO postgres;

--
-- Name: messenger_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.messenger_messages_id_seq OWNED BY public.messenger_messages.id;


--
-- Name: node; Type: TABLE; Schema: public; Owner: postgres
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
    address character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.node OWNER TO postgres;

--
-- Name: COLUMN node.created_at; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.node.created_at IS '(DC2Type:datetime_immutable)';


--
-- Name: COLUMN node.updated_at; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.node.updated_at IS '(DC2Type:datetime_immutable)';


--
-- Name: node_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.node_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.node_id_seq OWNER TO postgres;

--
-- Name: node_region; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.node_region (
    node_id integer NOT NULL,
    region_id integer NOT NULL
);


ALTER TABLE public.node_region OWNER TO postgres;

--
-- Name: node_tag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.node_tag (
    node_id integer NOT NULL,
    tag_id integer NOT NULL
);


ALTER TABLE public.node_tag OWNER TO postgres;

--
-- Name: page; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.page (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    label character varying(255) NOT NULL
);


ALTER TABLE public.page OWNER TO postgres;

--
-- Name: page_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.page_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.page_id_seq OWNER TO postgres;

--
-- Name: region; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.region (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    label character varying(255) NOT NULL,
    count smallint NOT NULL,
    icon character varying(20) DEFAULT NULL::character varying,
    fields text,
    description character varying(255) DEFAULT NULL::character varying,
    page_id integer
);


ALTER TABLE public.region OWNER TO postgres;

--
-- Name: COLUMN region.fields; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.region.fields IS '(DC2Type:simple_array)';


--
-- Name: region_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.region_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.region_id_seq OWNER TO postgres;

--
-- Name: spec; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.spec (
    id integer NOT NULL,
    node_id integer NOT NULL,
    name character varying(25) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.spec OWNER TO postgres;

--
-- Name: spec_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.spec_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.spec_id_seq OWNER TO postgres;

--
-- Name: tag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tag (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    label character varying(255) NOT NULL
);


ALTER TABLE public.tag OWNER TO postgres;

--
-- Name: tag_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tag_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tag_id_seq OWNER TO postgres;

--
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public."user" OWNER TO postgres;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO postgres;

--
-- Name: user_node; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_node (
    user_id integer NOT NULL,
    node_id integer NOT NULL
);


ALTER TABLE public.user_node OWNER TO postgres;

--
-- Name: messenger_messages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messenger_messages ALTER COLUMN id SET DEFAULT nextval('public.messenger_messages_id_seq'::regclass);


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.category (id, name, label) FROM stdin;
1	景区介绍	intro
\.


--
-- Data for Name: conf; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conf (id, language_id, sitename, keywords, description, address, phone, email, logo, updated_at, note) FROM stdin;
1	\N	遇见张湾	\N	\N	\N	\N	\N	logo-6641912db5458003532123.png	2024-05-13 04:03:57	鄂ICP备2023029037号-1
\.


--
-- Data for Name: doctrine_migration_versions; Type: TABLE DATA; Schema: public; Owner: postgres
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
\.


--
-- Data for Name: feedback; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.feedback (id, node_id, firstname, lastname, email, phone, title, body, country) FROM stdin;
7	\N	木子	\N	13636226368@163.com	18986882698	东沟WIFI全覆盖	建议东沟WIFI全覆盖，方便游客打卡。	\N
\.


--
-- Data for Name: image; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.image (id, node_id, image) FROM stdin;
\.


--
-- Data for Name: language; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.language (id, language, prefix, locale) FROM stdin;
\.


--
-- Data for Name: link; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.link (id, title, link, weight, menu_id) FROM stdin;
1	首页	/	0	1
2	走进东沟	/zoujin	1	1
3	乐游东沟	/leyou	2	1
5	联系我们	/contact	4	1
4	新闻资讯	/news/wenlv	3	1
6	十堰市人民政府	https://www.shiyan.gov.cn/	0	3
7	茅箭区人民政府	http://maojian.shiyan.gov.cn/	1	3
\.


--
-- Data for Name: menu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.menu (id, name, label) FROM stdin;
1	页脚导航	footer
3	友情链接	friend
\.


--
-- Data for Name: messenger_messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.messenger_messages (id, body, headers, queue_name, created_at, available_at, delivered_at) FROM stdin;
\.


--
-- Data for Name: node; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.node (id, language_id, category_id, title, created_at, body, image, summary, updated_at, video, parent_id, audio, qr, phone, latitude, longitude, address) FROM stdin;
93	\N	\N	黄龙壹号生态园	2024-05-15 05:43:29	<p>黄龙壹号生态园</p>	huang-long-yi-hao-sheng-tai-yuan-66e494b71e294498991394.jpg	黄龙壹号生态园	2024-09-13 19:38:31	\N	\N	\N	\N	\N	\N	\N	\N
85	\N	\N	龙泉寺	2024-05-15 04:21:43	<p>龙泉寺</p>	long-quan-si1-66e494cf71440501191736.jpeg	龙泉寺	2024-09-13 19:38:55	\N	\N	\N	\N	\N	\N	\N	\N
89	\N	\N	十堰希尔顿逸林酒店	2024-05-15 05:26:58	<p><span style="background-color:rgb(255,255,255);color:rgb(15,41,77);"><strong>十堰希尔顿逸林酒店</strong></span></p>	20080c00000067b1i1473-w-1080-808-r5-d-66ea34f88b7e8776391708.jpg	十堰希尔顿逸林酒店	2024-09-18 02:03:36	\N	\N	\N	\N	\N	\N	\N	\N
138	\N	\N	花迹雨舍	2024-09-18 08:06:03	<p>花迹雨舍</p>	5-66ebbe9762dc3269802938.jpg	花迹雨舍	2024-09-19 06:03:03	\N	\N	\N	\N	\N	\N	\N	\N
95	\N	\N	回龙村荷花盛开	2024-05-15 05:44:06	<p>回龙村荷花盛开</p>	hui-long-cun-he-hua-sheng-kai-66e4947140dcd574942165.jpg	回龙村荷花盛开	2024-09-13 19:37:21	\N	\N	\N	\N	\N	\N	\N	\N
84	\N	\N	白马山	2024-05-15 04:11:47	<p>白马山</p>	bai-ma-shan-rui-zhi-min-1-66e494f327114653823154.jpg	白马山	2024-09-13 19:39:31	\N	\N	\N	\N	\N	\N	\N	\N
126	\N	\N	维也纳国际酒店	2024-05-17 01:43:21	<p><span style="background-color:rgb(255,255,255);color:rgb(15,41,77);"><strong>维也纳国际酒店</strong></span></p>	020581200093rrmx1a5e2-w-1080-808-r5-d-66ea341be7b8d373180662.jpg	维也纳国际酒店	2024-09-18 01:59:55	\N	\N	\N	\N	\N	\N	\N	\N
99	\N	\N	牛头山顶落日	2024-05-15 05:45:37	<p>牛头山顶落日</p>	1-66ebbce03c9ed662835048.jpg	牛头山顶落日	2024-09-19 05:55:44	\N	\N	\N	\N	\N	\N	\N	\N
131	\N	\N	健康步道	2024-09-18 02:51:55	<p>健康步道</p>	3-66ea404bc7ffb033854785.jpg	健康步道	2024-09-18 02:51:55	\N	\N	\N	\N	\N	\N	\N	\N
143	\N	\N	环球港	2024-09-19 04:41:03	<p><span style="background-color:rgb(255,255,255);color:rgb(51,51,51);"><strong>环球港</strong></span></p>	104f6e33-bd9f-4195-b4d8-aef107f47972-66ebab5f72ccc336852035.jpeg	环球港	2024-09-19 04:41:03	\N	\N	\N	\N	\N	\N	\N	\N
97	\N	\N	人民公园	2024-05-15 05:45:02	<p>人民公园</p>	3-66ebbd618fc73980175579.jpg	人民公园	2024-09-19 05:57:53	\N	\N	\N	\N	\N	\N	\N	\N
132	\N	\N	甜蜜来袭！张湾夏日水果采摘攻略来了	2024-09-18 03:02:00	<h2>甜蜜来袭！张湾夏日水果采摘攻略来了</h2>	640-66ea42a879918439629554.jpg	甜蜜来袭！张湾夏日水果采摘攻略来了	2024-09-18 03:02:00	\N	\N	\N	\N	\N	\N	\N	\N
144	\N	\N	华悦城	2024-09-19 04:42:41	<p>华悦城</p>	oip-c-66ebabc1a4e2a158836502.jpeg	华悦城	2024-09-19 04:42:41	\N	\N	\N	\N	\N	\N	\N	\N
133	\N	\N	25分钟！央视专题报道张湾汉江樱桃	2024-09-18 03:03:16	<h2>25分钟！央视专题报道张湾汉江樱桃</h2><p><br>&nbsp;</p>	2-66ea42f4c8ec8678216616.jpg	25分钟！央视专题报道张湾汉江樱桃	2024-09-18 03:03:16	\N	\N	\N	\N	\N	\N	\N	\N
100	\N	\N	云水方滩休闲度假区	2024-05-15 05:46:01	<h4><strong>关于</strong></h4><p>云水方滩休闲度假区青山环绕，峡谷幽美，堵河如画，碧水静流，仿佛置身于世外桃源；锦绣园、房车营地、堵河廊道、行人绿道、采摘园、天然草地广场等成为知名网红打卡点；富有水乡渔村文化特色的特色鱼宴产业园更是集商品销售、民俗体验、乡土美食于一体的新体验地。</p>	yun-shui-fang-tan-du-he-hua-lang-kang-yang-lu-you-du-jia-qu-jian-shan-cha-she-wai-guan-66e49391eb54c947037806.jpg	云水方滩休闲度假区	2024-09-13 19:33:37	\N	\N	\N	\N	\N	\N	\N	\N
139	\N	\N	知雨轩·庄园	2024-09-18 08:08:10	<p>知雨轩·庄园</p>	rn-image-picker-lib-temp-21887288-c450-4f08-8007-d8f7b7c3c85b-66ea8a6a093b6725920222.jpg	知雨轩·庄园	2024-09-18 08:08:10	\N	\N	\N	\N	\N	\N	\N	\N
94	\N	\N	长河湾景区	2024-05-15 05:43:47	<p>长河湾景区</p>	zhang-he-wan-jing-qu-66e494957fe32510410356.jpg	长河湾景区	2024-09-13 19:37:57	\N	\N	\N	\N	\N	\N	\N	\N
96	\N	\N	四方山旅游区	2024-05-15 05:44:41	<p>四方山旅游区</p>	si-fang-shan1-66e49d887221d333921511.jpg	四方山旅游区	2024-09-13 20:16:08	\N	\N	\N	\N	\N	\N	\N	\N
145	\N	\N	君王醉黄酒	2024-09-19 04:43:55	<p>君王醉黄酒</p>	jun-wang-zui-huang-jiu-66ebac0b8c220667500193.png	君王醉黄酒	2024-09-19 04:43:55	\N	\N	\N	\N	\N	\N	\N	\N
91	\N	\N	十堰大嘉国际酒店	2024-05-15 05:28:48	<p><span style="background-color:rgb(255,255,255);color:rgb(15,41,77);"><strong>十堰大嘉国际酒店</strong></span></p>	200g0t000000iibm29a98-w-1080-808-r5-d-66ea346289fc4367561533.jpg	十堰大嘉国际酒店	2024-09-18 02:01:06	\N	\N	\N	\N	\N	\N	\N	\N
140	\N	\N	十堰市图书馆	2024-09-18 08:08:42	<p>十堰市图书馆</p>	rn-image-picker-lib-temp-e40613be-b931-4a42-b7dd-0bc6480d28c9-66ea8a8b02fe6108496344.jpg	十堰市图书馆	2024-09-18 08:08:43	\N	\N	\N	\N	\N	\N	\N	\N
146	\N	\N	沙洲猕猴桃	2024-09-19 04:47:52	<p>沙洲猕猴桃</p>	3-66ebacf821973490085798.jpg	沙洲猕猴桃	2024-09-19 04:47:52	\N	\N	\N	\N	\N	\N	\N	\N
134	\N	\N	采茶正当时，赴张湾饮一段春光！	2024-09-18 03:04:38	<h2>采茶正当时，赴张湾饮一段春光！</h2>	22-66ebca4e51ef1017687844.jpg	采茶正当时，赴张湾饮一段春光！	2024-09-19 06:53:02	\N	\N	\N	\N	\N	\N	\N	\N
147	\N	\N	遇尝鸣子菜籽油	2024-09-19 04:48:41	<p>遇尝鸣子菜籽油</p>	yu-chang-ming-zi-cai-zi-you-66ebad29eebd8393198762.jpg	遇尝鸣子菜籽油	2024-09-19 04:48:41	\N	\N	\N	\N	\N	\N	\N	\N
135	\N	\N	甜蜜暴击.ᐟ‪.ᐟ十堰张湾「夏日水果采摘图鉴」来啦~	2024-09-18 03:05:46	<h2>甜蜜暴击.ᐟ‪.ᐟ十堰张湾「夏日水果采摘图鉴」来啦~</h2>	11-66ebca42ba159115919800.jpg	甜蜜暴击.ᐟ‪.ᐟ十堰张湾「夏日水果采摘图鉴」来啦~	2024-09-19 06:52:50	\N	\N	\N	\N	\N	\N	\N	\N
90	\N	\N	十堰邦辉国际大酒店	2024-05-15 05:28:10	<p><span style="background-color:rgb(255,255,255);color:rgb(15,41,77);"><strong>十堰邦辉国际大酒店</strong></span></p>	200g190000017c1el2fce-w-1080-808-r5-d-66ea349ca770f898829100.jpg	十堰邦辉国际大酒店	2024-09-18 02:02:04	\N	\N	\N	\N	\N	\N	\N	\N
141	\N	\N	十堰万达广场	2024-09-19 04:38:41	<p>十堰万达广场</p>	t01efd85ab60f62c9ed-66ebaad1d38a8610403805.jpg	十堰万达广场	2024-09-19 04:38:41	\N	\N	\N	\N	\N	\N	\N	\N
130	\N	\N	十堰市奥林匹克体育中心	2024-09-18 02:45:02	<p>十堰市奥林匹克体育中心</p>	ed11c3ca30f14f7289d48cb6f05aaae6-66ea3eae4f5b8417068920.jpeg	十堰市奥林匹克体育中心	2024-09-18 02:45:02	\N	\N	\N	\N	\N	\N	\N	\N
142	\N	\N	招商·兰溪谷	2024-09-19 04:39:34	<h2><strong>招商·兰溪谷</strong></h2>	r-c-66ebab063a3d7659405916.jpeg	招商·兰溪谷	2024-09-19 04:39:34	\N	\N	\N	\N	\N	\N	\N	\N
98	\N	\N	牛斗山顶	2024-05-15 05:45:19	<p>牛斗山顶</p>	2-66ebbcef47099673861484.jpg	牛斗山顶	2024-09-19 05:55:59	\N	\N	\N	\N	\N	\N	\N	\N
148	\N	\N	李声平即食风干鱼	2024-09-19 04:51:30	<p>李声平即食风干鱼</p>	2-66ebadd23d5fd771847389.jpg	李声平即食风干鱼	2024-09-19 04:51:30	\N	\N	\N	\N	\N	\N	\N	\N
136	\N	\N	云庐	2024-09-18 08:03:53	<p>云庐</p>	66-66ebbed1cd524323788471.jpg	云庐	2024-09-19 06:04:01	\N	\N	\N	\N	\N	\N	\N	\N
137	\N	\N	月亮边山庄	2024-09-18 08:04:44	<p>月亮边山庄</p>	rn-image-picker-lib-temp-f48d2475-22c4-49d1-93fb-feb56f877248-66ea899c8126f145628411.jpg	月亮边山庄	2024-09-18 08:04:44	\N	\N	\N	\N	\N	\N	\N	\N
149	\N	\N	四方山徒步	2024-10-13 20:54:04	<p>活动简介本次活动旨在加强人们的锻炼，由主办单位主办活动简介本次活动旨在加强人们的锻炼，由主办单位主办活动简介本次活动旨在加强人们的锻炼，由主办单位主办活动简介本次活动旨在加强人们的锻炼，由主办单位主办活动简介本次活动旨在加强人们。</p>	bai-ma-shan-rui-zhi-min-1-66e494f327114653823154-670c336dd418d625178905.jpg	活动简介本次活动旨在加强人们的锻炼，由主办单位主\r\n办活动简介本次活动旨在加强人们的锻炼，由主办单位\r\n主办活动简介本次活动旨在加强人们的锻炼，由主办单\r\n位主办活动简介本次活动旨在加强人们的锻炼，由主办\r\n单位主办活动简介本次活动旨在加强人们。	2024-10-13 20:54:05	\N	\N	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: node_region; Type: TABLE DATA; Schema: public; Owner: postgres
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
\.


--
-- Data for Name: node_tag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.node_tag (node_id, tag_id) FROM stdin;
91	1
90	1
89	1
\.


--
-- Data for Name: page; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.page (id, name, label) FROM stdin;
1	首页	home
4	联系我们	contact
2	走进	zoujin
3	遇见	leyou
\.


--
-- Data for Name: region; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.region (id, name, label, count, icon, fields, description, page_id) FROM stdin;
13	投诉建议	feedback	1	list	summary	\N	4
25	幻灯片1	slider1	5	list	image,body	\N	3
35	房间	rooms	1	\N	\N	\N	\N
41	玩法	wan	1	\N	body,image,summary,tags,createdAt	\N	3
40	活动	dong	1	\N	body,image,summary,tags,createdAt	\N	3
39	购物	gou	1	\N	id,body,image,summary	\N	3
36	文创	wen	1	\N	body,image,summary	\N	3
31	美食	shi	8	list	summary,image,body	\N	3
29	住宿	zhu	6	list	summary,image,specs,body,tags	\N	3
27	景点	jing	10	list	summary,image,body	\N	3
42	艺动	yi	1	\N	body,image,summary,tags,createdAt	\N	3
43	列表	shop	1	\N	body,image,summary,createdAt	\N	\N
\.


--
-- Data for Name: spec; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.spec (id, node_id, name, value) FROM stdin;
15	90	TEL	民宿电话：0719-8310588
14	89	TEL	民宿电话：0719-8310588
16	91	TEL	民宿电话：0719-8457770
\.


--
-- Data for Name: tag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tag (id, name, label) FROM stdin;
1	民宿	minsu
2	农家乐	农家乐
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, username, roles, password, plain_password, openid, name, phone, avatar) FROM stdin;
2	al	["ROLE_SUPER_ADMIN"]	$2y$13$KpK7xAC8vlandkObN9kC4OAZVFw7SLtJvpf3PHICo4shV4haht9iK	\N	\N	\N	\N	\N
3	root	["ROLE_SUPER_ADMIN"]	$2y$13$vjcnglByWqC.GHCDZ3xIpuzHgPXtZ0mGvR5GPgXx7SBrGZRTTrmxi	\N	\N	\N	\N	\N
1	admin	["ROLE_ADMIN"]	$2y$13$Aru9xF850N6.KZ9cfzU67OlgYVVklRynqLXqkxeAiUcKWsbCMqqcS	\N	\N	\N	\N	\N
\.


--
-- Data for Name: user_node; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_node (user_id, node_id) FROM stdin;
\.


--
-- Name: category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.category_id_seq', 5, true);


--
-- Name: conf_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.conf_id_seq', 1, true);


--
-- Name: feedback_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.feedback_id_seq', 7, true);


--
-- Name: image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.image_id_seq', 5, true);


--
-- Name: language_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.language_id_seq', 1, false);


--
-- Name: link_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.link_id_seq', 7, true);


--
-- Name: menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.menu_id_seq', 3, true);


--
-- Name: messenger_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.messenger_messages_id_seq', 1, false);


--
-- Name: node_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.node_id_seq', 149, true);


--
-- Name: page_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.page_id_seq', 4, true);


--
-- Name: region_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.region_id_seq', 43, true);


--
-- Name: spec_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.spec_id_seq', 18, true);


--
-- Name: tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tag_id_seq', 2, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id_seq', 3, true);


--
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


--
-- Name: conf conf_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conf
    ADD CONSTRAINT conf_pkey PRIMARY KEY (id);


--
-- Name: doctrine_migration_versions doctrine_migration_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctrine_migration_versions
    ADD CONSTRAINT doctrine_migration_versions_pkey PRIMARY KEY (version);


--
-- Name: feedback feedback_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT feedback_pkey PRIMARY KEY (id);


--
-- Name: image image_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.image
    ADD CONSTRAINT image_pkey PRIMARY KEY (id);


--
-- Name: language language_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.language
    ADD CONSTRAINT language_pkey PRIMARY KEY (id);


--
-- Name: link link_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.link
    ADD CONSTRAINT link_pkey PRIMARY KEY (id);


--
-- Name: menu menu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu
    ADD CONSTRAINT menu_pkey PRIMARY KEY (id);


--
-- Name: messenger_messages messenger_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messenger_messages
    ADD CONSTRAINT messenger_messages_pkey PRIMARY KEY (id);


--
-- Name: node node_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.node
    ADD CONSTRAINT node_pkey PRIMARY KEY (id);


--
-- Name: node_region node_region_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.node_region
    ADD CONSTRAINT node_region_pkey PRIMARY KEY (node_id, region_id);


--
-- Name: node_tag node_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.node_tag
    ADD CONSTRAINT node_tag_pkey PRIMARY KEY (node_id, tag_id);


--
-- Name: page page_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.page
    ADD CONSTRAINT page_pkey PRIMARY KEY (id);


--
-- Name: region region_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.region
    ADD CONSTRAINT region_pkey PRIMARY KEY (id);


--
-- Name: spec spec_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spec
    ADD CONSTRAINT spec_pkey PRIMARY KEY (id);


--
-- Name: tag tag_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tag_pkey PRIMARY KEY (id);


--
-- Name: user_node user_node_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_node
    ADD CONSTRAINT user_node_pkey PRIMARY KEY (user_id, node_id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: idx_14f389a882f1baf4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_14f389a882f1baf4 ON public.conf USING btree (language_id);


--
-- Name: idx_36ac99f1ccd7e912; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_36ac99f1ccd7e912 ON public.link USING btree (menu_id);


--
-- Name: idx_70ac95f8460d9fd7; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_70ac95f8460d9fd7 ON public.node_tag USING btree (node_id);


--
-- Name: idx_70ac95f8bad26311; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_70ac95f8bad26311 ON public.node_tag USING btree (tag_id);


--
-- Name: idx_75ea56e016ba31db; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_75ea56e016ba31db ON public.messenger_messages USING btree (delivered_at);


--
-- Name: idx_75ea56e0e3bd61ce; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_75ea56e0e3bd61ce ON public.messenger_messages USING btree (available_at);


--
-- Name: idx_75ea56e0fb7336f0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_75ea56e0fb7336f0 ON public.messenger_messages USING btree (queue_name);


--
-- Name: idx_857fe84512469de2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_857fe84512469de2 ON public.node USING btree (category_id);


--
-- Name: idx_857fe845727aca70; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_857fe845727aca70 ON public.node USING btree (parent_id);


--
-- Name: idx_857fe84582f1baf4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_857fe84582f1baf4 ON public.node USING btree (language_id);


--
-- Name: idx_bb70e4d3460d9fd7; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_bb70e4d3460d9fd7 ON public.node_region USING btree (node_id);


--
-- Name: idx_bb70e4d398260155; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_bb70e4d398260155 ON public.node_region USING btree (region_id);


--
-- Name: idx_c00e173e460d9fd7; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_c00e173e460d9fd7 ON public.spec USING btree (node_id);


--
-- Name: idx_c53d045f460d9fd7; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_c53d045f460d9fd7 ON public.image USING btree (node_id);


--
-- Name: idx_d2294458460d9fd7; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_d2294458460d9fd7 ON public.feedback USING btree (node_id);


--
-- Name: idx_f62f176c4663e4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_f62f176c4663e4 ON public.region USING btree (page_id);


--
-- Name: idx_fffea48c460d9fd7; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fffea48c460d9fd7 ON public.user_node USING btree (node_id);


--
-- Name: idx_fffea48ca76ed395; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fffea48ca76ed395 ON public.user_node USING btree (user_id);


--
-- Name: uniq_8d93d649f85e0677; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX uniq_8d93d649f85e0677 ON public."user" USING btree (username);


--
-- Name: messenger_messages notify_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER notify_trigger AFTER INSERT OR UPDATE ON public.messenger_messages FOR EACH ROW EXECUTE FUNCTION public.notify_messenger_messages();


--
-- Name: conf fk_14f389a882f1baf4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conf
    ADD CONSTRAINT fk_14f389a882f1baf4 FOREIGN KEY (language_id) REFERENCES public.language(id);


--
-- Name: link fk_36ac99f1ccd7e912; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.link
    ADD CONSTRAINT fk_36ac99f1ccd7e912 FOREIGN KEY (menu_id) REFERENCES public.menu(id);


--
-- Name: node_tag fk_70ac95f8460d9fd7; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.node_tag
    ADD CONSTRAINT fk_70ac95f8460d9fd7 FOREIGN KEY (node_id) REFERENCES public.node(id) ON DELETE CASCADE;


--
-- Name: node_tag fk_70ac95f8bad26311; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.node_tag
    ADD CONSTRAINT fk_70ac95f8bad26311 FOREIGN KEY (tag_id) REFERENCES public.tag(id) ON DELETE CASCADE;


--
-- Name: node fk_857fe84512469de2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.node
    ADD CONSTRAINT fk_857fe84512469de2 FOREIGN KEY (category_id) REFERENCES public.category(id);


--
-- Name: node fk_857fe845727aca70; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.node
    ADD CONSTRAINT fk_857fe845727aca70 FOREIGN KEY (parent_id) REFERENCES public.node(id);


--
-- Name: node fk_857fe84582f1baf4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.node
    ADD CONSTRAINT fk_857fe84582f1baf4 FOREIGN KEY (language_id) REFERENCES public.language(id);


--
-- Name: node_region fk_bb70e4d3460d9fd7; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.node_region
    ADD CONSTRAINT fk_bb70e4d3460d9fd7 FOREIGN KEY (node_id) REFERENCES public.node(id) ON DELETE CASCADE;


--
-- Name: node_region fk_bb70e4d398260155; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.node_region
    ADD CONSTRAINT fk_bb70e4d398260155 FOREIGN KEY (region_id) REFERENCES public.region(id) ON DELETE CASCADE;


--
-- Name: spec fk_c00e173e460d9fd7; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spec
    ADD CONSTRAINT fk_c00e173e460d9fd7 FOREIGN KEY (node_id) REFERENCES public.node(id);


--
-- Name: image fk_c53d045f460d9fd7; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.image
    ADD CONSTRAINT fk_c53d045f460d9fd7 FOREIGN KEY (node_id) REFERENCES public.node(id);


--
-- Name: feedback fk_d2294458460d9fd7; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT fk_d2294458460d9fd7 FOREIGN KEY (node_id) REFERENCES public.node(id);


--
-- Name: region fk_f62f176c4663e4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.region
    ADD CONSTRAINT fk_f62f176c4663e4 FOREIGN KEY (page_id) REFERENCES public.page(id);


--
-- Name: user_node fk_fffea48c460d9fd7; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_node
    ADD CONSTRAINT fk_fffea48c460d9fd7 FOREIGN KEY (node_id) REFERENCES public.node(id) ON DELETE CASCADE;


--
-- Name: user_node fk_fffea48ca76ed395; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_node
    ADD CONSTRAINT fk_fffea48ca76ed395 FOREIGN KEY (user_id) REFERENCES public."user"(id) ON DELETE CASCADE;


--
-- Name: TABLE category; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.category TO zw;


--
-- Name: SEQUENCE category_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.category_id_seq TO zw;


--
-- Name: TABLE conf; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.conf TO zw;


--
-- Name: SEQUENCE conf_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.conf_id_seq TO zw;


--
-- Name: TABLE doctrine_migration_versions; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.doctrine_migration_versions TO zw;


--
-- Name: TABLE feedback; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.feedback TO zw;


--
-- Name: SEQUENCE feedback_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.feedback_id_seq TO zw;


--
-- Name: TABLE image; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.image TO zw;


--
-- Name: SEQUENCE image_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.image_id_seq TO zw;


--
-- Name: TABLE language; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.language TO zw;


--
-- Name: SEQUENCE language_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.language_id_seq TO zw;


--
-- Name: TABLE link; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.link TO zw;


--
-- Name: SEQUENCE link_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.link_id_seq TO zw;


--
-- Name: TABLE menu; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.menu TO zw;


--
-- Name: SEQUENCE menu_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.menu_id_seq TO zw;


--
-- Name: TABLE messenger_messages; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.messenger_messages TO zw;


--
-- Name: SEQUENCE messenger_messages_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.messenger_messages_id_seq TO zw;


--
-- Name: TABLE node; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.node TO zw;


--
-- Name: SEQUENCE node_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.node_id_seq TO zw;


--
-- Name: TABLE node_region; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.node_region TO zw;


--
-- Name: TABLE node_tag; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.node_tag TO zw;


--
-- Name: TABLE page; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.page TO zw;


--
-- Name: SEQUENCE page_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.page_id_seq TO zw;


--
-- Name: TABLE region; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.region TO zw;


--
-- Name: SEQUENCE region_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.region_id_seq TO zw;


--
-- Name: TABLE spec; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.spec TO zw;


--
-- Name: SEQUENCE spec_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.spec_id_seq TO zw;


--
-- Name: TABLE tag; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.tag TO zw;


--
-- Name: SEQUENCE tag_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.tag_id_seq TO zw;


--
-- Name: TABLE "user"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."user" TO zw;


--
-- Name: SEQUENCE user_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.user_id_seq TO zw;


--
-- Name: TABLE user_node; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.user_node TO zw;


--
-- PostgreSQL database dump complete
--

