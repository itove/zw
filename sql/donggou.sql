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
-- Name: notify_messenger_messages(); Type: FUNCTION; Schema: public; Owner: sygen
--

CREATE FUNCTION public.notify_messenger_messages() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
            BEGIN
                PERFORM pg_notify('messenger_messages', NEW.queue_name::text);
                RETURN NEW;
            END;
        $$;


ALTER FUNCTION public.notify_messenger_messages() OWNER TO sygen;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: category; Type: TABLE; Schema: public; Owner: sygen
--

CREATE TABLE public.category (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    label character varying(255) NOT NULL
);


ALTER TABLE public.category OWNER TO sygen;

--
-- Name: category_id_seq; Type: SEQUENCE; Schema: public; Owner: sygen
--

CREATE SEQUENCE public.category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.category_id_seq OWNER TO sygen;

--
-- Name: conf; Type: TABLE; Schema: public; Owner: sygen
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
    updated_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone
);


ALTER TABLE public.conf OWNER TO sygen;

--
-- Name: COLUMN conf.keywords; Type: COMMENT; Schema: public; Owner: sygen
--

COMMENT ON COLUMN public.conf.keywords IS '(DC2Type:simple_array)';


--
-- Name: COLUMN conf.updated_at; Type: COMMENT; Schema: public; Owner: sygen
--

COMMENT ON COLUMN public.conf.updated_at IS '(DC2Type:datetime_immutable)';


--
-- Name: conf_id_seq; Type: SEQUENCE; Schema: public; Owner: sygen
--

CREATE SEQUENCE public.conf_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.conf_id_seq OWNER TO sygen;

--
-- Name: doctrine_migration_versions; Type: TABLE; Schema: public; Owner: sygen
--

CREATE TABLE public.doctrine_migration_versions (
    version character varying(191) NOT NULL,
    executed_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    execution_time integer
);


ALTER TABLE public.doctrine_migration_versions OWNER TO sygen;

--
-- Name: feedback; Type: TABLE; Schema: public; Owner: sygen
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


ALTER TABLE public.feedback OWNER TO sygen;

--
-- Name: feedback_id_seq; Type: SEQUENCE; Schema: public; Owner: sygen
--

CREATE SEQUENCE public.feedback_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.feedback_id_seq OWNER TO sygen;

--
-- Name: image; Type: TABLE; Schema: public; Owner: sygen
--

CREATE TABLE public.image (
    id integer NOT NULL,
    node_id integer NOT NULL,
    image character varying(255) NOT NULL
);


ALTER TABLE public.image OWNER TO sygen;

--
-- Name: image_id_seq; Type: SEQUENCE; Schema: public; Owner: sygen
--

CREATE SEQUENCE public.image_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.image_id_seq OWNER TO sygen;

--
-- Name: language; Type: TABLE; Schema: public; Owner: sygen
--

CREATE TABLE public.language (
    id integer NOT NULL,
    language character varying(30) NOT NULL,
    prefix character varying(15) NOT NULL,
    locale character varying(15) NOT NULL
);


ALTER TABLE public.language OWNER TO sygen;

--
-- Name: language_id_seq; Type: SEQUENCE; Schema: public; Owner: sygen
--

CREATE SEQUENCE public.language_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.language_id_seq OWNER TO sygen;

--
-- Name: messenger_messages; Type: TABLE; Schema: public; Owner: sygen
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


ALTER TABLE public.messenger_messages OWNER TO sygen;

--
-- Name: COLUMN messenger_messages.created_at; Type: COMMENT; Schema: public; Owner: sygen
--

COMMENT ON COLUMN public.messenger_messages.created_at IS '(DC2Type:datetime_immutable)';


--
-- Name: COLUMN messenger_messages.available_at; Type: COMMENT; Schema: public; Owner: sygen
--

COMMENT ON COLUMN public.messenger_messages.available_at IS '(DC2Type:datetime_immutable)';


--
-- Name: COLUMN messenger_messages.delivered_at; Type: COMMENT; Schema: public; Owner: sygen
--

COMMENT ON COLUMN public.messenger_messages.delivered_at IS '(DC2Type:datetime_immutable)';


--
-- Name: messenger_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: sygen
--

CREATE SEQUENCE public.messenger_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.messenger_messages_id_seq OWNER TO sygen;

--
-- Name: messenger_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sygen
--

ALTER SEQUENCE public.messenger_messages_id_seq OWNED BY public.messenger_messages.id;


--
-- Name: node; Type: TABLE; Schema: public; Owner: sygen
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
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.node OWNER TO sygen;

--
-- Name: COLUMN node.created_at; Type: COMMENT; Schema: public; Owner: sygen
--

COMMENT ON COLUMN public.node.created_at IS '(DC2Type:datetime_immutable)';


--
-- Name: COLUMN node.updated_at; Type: COMMENT; Schema: public; Owner: sygen
--

COMMENT ON COLUMN public.node.updated_at IS '(DC2Type:datetime_immutable)';


--
-- Name: node_id_seq; Type: SEQUENCE; Schema: public; Owner: sygen
--

CREATE SEQUENCE public.node_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.node_id_seq OWNER TO sygen;

--
-- Name: node_region; Type: TABLE; Schema: public; Owner: sygen
--

CREATE TABLE public.node_region (
    node_id integer NOT NULL,
    region_id integer NOT NULL
);


ALTER TABLE public.node_region OWNER TO sygen;

--
-- Name: node_tag; Type: TABLE; Schema: public; Owner: sygen
--

CREATE TABLE public.node_tag (
    node_id integer NOT NULL,
    tag_id integer NOT NULL
);


ALTER TABLE public.node_tag OWNER TO sygen;

--
-- Name: page; Type: TABLE; Schema: public; Owner: sygen
--

CREATE TABLE public.page (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    label character varying(255) DEFAULT 'test'::character varying NOT NULL
);


ALTER TABLE public.page OWNER TO sygen;

--
-- Name: page_id_seq; Type: SEQUENCE; Schema: public; Owner: sygen
--

CREATE SEQUENCE public.page_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.page_id_seq OWNER TO sygen;

--
-- Name: region; Type: TABLE; Schema: public; Owner: sygen
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


ALTER TABLE public.region OWNER TO sygen;

--
-- Name: COLUMN region.fields; Type: COMMENT; Schema: public; Owner: sygen
--

COMMENT ON COLUMN public.region.fields IS '(DC2Type:simple_array)';


--
-- Name: region_id_seq; Type: SEQUENCE; Schema: public; Owner: sygen
--

CREATE SEQUENCE public.region_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.region_id_seq OWNER TO sygen;

--
-- Name: spec; Type: TABLE; Schema: public; Owner: sygen
--

CREATE TABLE public.spec (
    id integer NOT NULL,
    node_id integer NOT NULL,
    name character varying(25) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.spec OWNER TO sygen;

--
-- Name: spec_id_seq; Type: SEQUENCE; Schema: public; Owner: sygen
--

CREATE SEQUENCE public.spec_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.spec_id_seq OWNER TO sygen;

--
-- Name: tag; Type: TABLE; Schema: public; Owner: sygen
--

CREATE TABLE public.tag (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    label character varying(255) NOT NULL
);


ALTER TABLE public.tag OWNER TO sygen;

--
-- Name: tag_id_seq; Type: SEQUENCE; Schema: public; Owner: sygen
--

CREATE SEQUENCE public.tag_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tag_id_seq OWNER TO sygen;

--
-- Name: user; Type: TABLE; Schema: public; Owner: sygen
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    username character varying(180) NOT NULL,
    roles json NOT NULL,
    password character varying(255) NOT NULL,
    plain_password character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public."user" OWNER TO sygen;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: sygen
--

CREATE SEQUENCE public.user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO sygen;

--
-- Name: messenger_messages id; Type: DEFAULT; Schema: public; Owner: sygen
--

ALTER TABLE ONLY public.messenger_messages ALTER COLUMN id SET DEFAULT nextval('public.messenger_messages_id_seq'::regclass);


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: sygen
--

COPY public.category (id, name, label) FROM stdin;
1	景区介绍	intro
2	文旅要闻	wenlv
3	通知公告	tongzhi
4	党建文明	dangjian
5	旅行游记	youji
\.


--
-- Data for Name: conf; Type: TABLE DATA; Schema: public; Owner: sygen
--

COPY public.conf (id, language_id, sitename, keywords, description, address, phone, email, logo, updated_at) FROM stdin;
1	\N	乐游东沟	\N	\N	湖北省十堰市茅箭区茅塔乡东沟村一组	0719-8457770	\N	logo-6641912db5458003532123.png	2024-05-13 04:03:57
\.


--
-- Data for Name: doctrine_migration_versions; Type: TABLE DATA; Schema: public; Owner: sygen
--

COPY public.doctrine_migration_versions (version, executed_at, execution_time) FROM stdin;
DoctrineMigrations\\Version20240110161309	2024-03-13 12:28:02	214
DoctrineMigrations\\Version20240513003319	2024-05-13 00:33:29	37
DoctrineMigrations\\Version20240513003519	2024-05-13 00:35:22	8
DoctrineMigrations\\Version20240513042532	2024-05-13 04:26:21	12
\.


--
-- Data for Name: feedback; Type: TABLE DATA; Schema: public; Owner: sygen
--

COPY public.feedback (id, node_id, firstname, lastname, email, phone, title, body, country) FROM stdin;
1	\N	jk	\N		jk	\N	jk	\N
\.


--
-- Data for Name: image; Type: TABLE DATA; Schema: public; Owner: sygen
--

COPY public.image (id, node_id, image) FROM stdin;
\.


--
-- Data for Name: language; Type: TABLE DATA; Schema: public; Owner: sygen
--

COPY public.language (id, language, prefix, locale) FROM stdin;
\.


--
-- Data for Name: messenger_messages; Type: TABLE DATA; Schema: public; Owner: sygen
--

COPY public.messenger_messages (id, body, headers, queue_name, created_at, available_at, delivered_at) FROM stdin;
\.


--
-- Data for Name: node; Type: TABLE DATA; Schema: public; Owner: sygen
--

COPY public.node (id, language_id, category_id, title, created_at, body, image, summary, updated_at) FROM stdin;
1	\N	\N	f1	2024-05-07 01:08:07	\N	\N	\N	2024-05-07 01:08:07
2	\N	\N	f2	2024-05-07 01:12:27	\N	\N	\N	2024-05-07 01:12:27
3	\N	\N	f3	2024-05-07 01:12:43	\N	\N	\N	2024-05-07 01:12:43
4	\N	\N	faq1	2024-05-12 11:18:17	\N	\N	\N	2024-05-12 11:18:17
5	\N	\N	产品方案1	2024-05-12 11:18:31	\N	\N	\N	2024-05-12 11:18:31
6	\N	1	桃源人家民宿	2024-05-13 00:56:40	\N	home-slider-1-66416549446fe115419225.jpg	TAOYUAN HOMESTAY	2024-05-13 00:56:41
7	\N	\N	依山傍水·风景如画	2024-05-13 00:58:11	\N	home-slider-1-664165a439a4d325249184.jpg	PICTURESQUE SCENERY	2024-05-13 00:58:12
8	\N	\N	自然质朴·土家文化	2024-05-13 00:59:02	\N	home-slider-1-664165d6b865e884574606.jpg	NATURAL AND SIMPLE ·TUJIA CULTURE	2024-05-13 00:59:02
9	\N	\N	景区介绍	2024-05-13 02:34:06	\N	home-jingqu-bg-66417caa39426232884525.jpg	选择您的出行方式，我们将给您做出推荐	2024-05-13 02:36:26
11	\N	\N	中原突围部西北历史纪念馆	2024-05-13 03:06:28	\N	jingqu-1-664183b46d959025508355.jpg	\N	2024-05-13 03:06:28
12	\N	\N	烈士陵园	2024-05-13 03:07:52	\N	jingqu-2-66418408a3912586135449.jpg	\N	2024-05-13 03:07:52
13	\N	\N	云上牡丹园	2024-05-13 03:08:38	\N	jingqu-3-6641843749354398759863.jpg	\N	2024-05-13 03:08:39
14	\N	\N	念情谷—猕猴园	2024-05-13 03:09:22	\N	jingqu-4-66418462a1751250179579.jpg	\N	2024-05-13 03:09:22
15	\N	\N	杜鹃岭	2024-05-13 03:09:52	\N	jingqu-5-66418480d6487561204136.jpg	\N	2024-05-13 03:09:52
16	\N	\N	花开四季 — 月季园	2024-05-13 03:10:26	\N	jingqu-6-664184a363d3b686847409.jpg	\N	2024-05-13 03:10:27
17	\N	\N	乐游东沟	2024-05-13 03:14:15	\N	leyou-bg-664185b77e4ff378757708.jpg	特色景区服务 · 给您贴心体验	2024-05-13 03:15:03
18	\N	\N	游在东沟	2024-05-13 03:20:47	\N	leyou-1-664187103139f326225825.jpg	东沟村地处于茅箭区茅塔乡，属北亚热带大 陆性季风气候，地势属中高山区类型...	2024-05-13 03:20:48
19	\N	\N	住在东沟	2024-05-13 03:22:13	\N	leyou-2-664187665a86a860794393.jpg	东沟村地处于茅箭区茅塔乡，属北亚热带大 陆性季风气候，地势属中高山区类型...	2024-05-13 03:22:14
20	\N	\N	吃在东沟	2024-05-13 03:22:32	\N	leyou-3-66418778ec1f2926274706.jpg	东沟村地处于茅箭区茅塔乡，属北亚热带大 陆性季风气候，地势属中高山区类型...	2024-05-13 03:22:32
21	\N	\N	购在东沟	2024-05-13 03:22:52	\N	leyou-4-6641878c99c53673730065.jpg	东沟村地处于茅箭区茅塔乡，属北亚热带大 陆性季风气候，地势属中高山区类型...	2024-05-13 03:22:52
22	\N	\N	追寻红色足迹 传承红色基因——丹江口市税务局开展青年干...	2024-05-13 03:39:49	\N	\N	为强化春训工作，提升春训效果，4月7日，丹江口市税务局组织青年干部...	2024-05-13 03:39:49
23	\N	\N	产投集团赴东沟红色廉政教育基地开展党纪学习教育	2024-05-13 03:40:11	\N	\N	为扎实推进党纪学习教育，进一步推进廉洁教育常态化长效化，4月18日，...	2024-05-13 03:40:11
24	\N	\N	茅箭区茅塔河流域农村生活污水治理见闻	2024-05-13 03:40:32	\N	\N	十堰是南水北调中线工程核心水源区。高标准治理好农村生活污水，对全...	2024-05-13 03:40:32
25	\N	\N	东风商用车·2024十堰马拉松圆满举行	2024-05-13 03:40:57	\N	\N	山水之城，向“绿”先行；汽车之城，向“新”出发。4月14日上午，东风商用车...	2024-05-13 03:40:57
26	\N	\N	产投集团赴东沟红色廉政教育基地开展党纪学习教育	2024-05-13 03:41:18	\N	\N	产投集团赴东沟红色廉政教育基地开展党纪学习教育	2024-05-13 03:41:18
27	\N	\N	茅箭区茅塔河流域农村生活污水治理见闻	2024-05-13 03:41:40	\N	\N	十堰是南水北调中线工程核心水源区。高标准治理好农村生活污水，对全面推进乡...	2024-05-13 03:41:40
28	\N	\N	关于十堰市景区型村庄评定名单的公示	2024-05-13 03:42:40	\N	news-1-66418c30ad6d8879748620.jpg	关于十堰市景区型村庄评定名单的公示	2024-05-13 03:42:40
29	\N	\N	春天的意思是：我们该见面了	2024-05-13 03:43:17	\N	news-2-66418c557a0b1820688374.jpg	乡村的朴实/本真的田园生活，如一股清流/足以让疲惫的身体短暂休憩， 给自己放个假，找个不太热闹的地方彻底躺平两天，春天进山是.	2024-05-13 03:43:17
30	\N	\N	我市发布《十堰市民绿色低碳生活行为规范》	2024-05-13 03:43:54	\N	news-3-66418c7b5c955402548006.jpg	7月7日，《十堰市民绿色低碳生活行为规范》（以下简称《规范》）新 闻发布会在市创文办举行。会上正式发布了《规范》，市创文办..	2024-05-13 03:43:55
31	\N	\N	湖北省公共文化服务保障条例	2024-05-13 03:44:39	\N	news-4-66418ca7d8df1388492707.jpg	第一条 为了加强公共文化服务体系建设，保障人民群众基本文化权益， 传承中华优秀传统文化，弘扬社会主义核心价值观，增强文化自..	2024-05-13 03:44:39
10	\N	\N	行程规划	2024-05-13 02:37:48	\N	xingcheng-66417cfcac045999996237.jpg	选择您的出行方式，我们将给您做出推荐	2024-05-13 02:37:48
\.


--
-- Data for Name: node_region; Type: TABLE DATA; Schema: public; Owner: sygen
--

COPY public.node_region (node_id, region_id) FROM stdin;
1	1
1	2
2	1
3	2
4	1
5	2
5	1
6	3
7	3
8	3
9	4
10	6
11	7
12	7
13	7
14	7
15	7
16	7
17	5
18	8
19	8
20	8
21	8
22	9
23	9
24	9
25	10
26	10
27	10
28	11
29	11
30	12
31	12
\.


--
-- Data for Name: node_tag; Type: TABLE DATA; Schema: public; Owner: sygen
--

COPY public.node_tag (node_id, tag_id) FROM stdin;
\.


--
-- Data for Name: page; Type: TABLE DATA; Schema: public; Owner: sygen
--

COPY public.page (id, name, label) FROM stdin;
1	首页	home
2	走进	zoujin
3	乐游	leyou
\.


--
-- Data for Name: region; Type: TABLE DATA; Schema: public; Owner: sygen
--

COPY public.region (id, name, label, count, icon, fields, description, page_id) FROM stdin;
1	常见问题	faq	0	\N	regions	\N	\N
2	产品方案	leyou	0	\N	\N	\N	\N
3	幻灯片1	slider1	3	\N	image,summary	\N	1
7	景区介绍	jingqu	6	\N	body,image,summary,tags	\N	1
4	景区介绍-文本	jingqutext	1	\N	image,summary	\N	1
6	行程规划-文本	xingchengtext	1	\N	image,summary	\N	1
5	乐游东沟-文本	leyoutext	1	\N	image,summary	\N	1
8	乐游东沟	leyou	4	\N	image,summary	\N	1
9	文旅要闻	wenlv	3	\N	body,image,summary	\N	1
10	通知公告	tongzhi	3	\N	body,image,summary	\N	1
11	党建文明	dangjian	2	\N	body,image,summary	\N	1
12	旅行游记	youji	2	\N	body,image,summary	\N	1
\.


--
-- Data for Name: spec; Type: TABLE DATA; Schema: public; Owner: sygen
--

COPY public.spec (id, node_id, name, value) FROM stdin;
1	21	goto	gouzai
2	20	goto	chizai
3	20	color	#ca6a50
4	21	color	#009b93
5	19	goto	zhuzai
6	19	color	#918078
7	18	goto	youzai
8	18	color	#a48045
\.


--
-- Data for Name: tag; Type: TABLE DATA; Schema: public; Owner: sygen
--

COPY public.tag (id, name, label) FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: sygen
--

COPY public."user" (id, username, roles, password, plain_password) FROM stdin;
2	al	["ROLE_SUPER_ADMIN"]	$2y$13$KpK7xAC8vlandkObN9kC4OAZVFw7SLtJvpf3PHICo4shV4haht9iK	\N
1	admin	["ROLE_ADMIN"]	$2y$13$J.jCWbJ8VupkmakxL8Wq/e6/vSTrvPII5M6/ME3lyWsMZ30ZZZabe	\N
\.


--
-- Name: category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sygen
--

SELECT pg_catalog.setval('public.category_id_seq', 5, true);


--
-- Name: conf_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sygen
--

SELECT pg_catalog.setval('public.conf_id_seq', 1, true);


--
-- Name: feedback_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sygen
--

SELECT pg_catalog.setval('public.feedback_id_seq', 1, true);


--
-- Name: image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sygen
--

SELECT pg_catalog.setval('public.image_id_seq', 1, false);


--
-- Name: language_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sygen
--

SELECT pg_catalog.setval('public.language_id_seq', 1, false);


--
-- Name: messenger_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sygen
--

SELECT pg_catalog.setval('public.messenger_messages_id_seq', 1, false);


--
-- Name: node_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sygen
--

SELECT pg_catalog.setval('public.node_id_seq', 31, true);


--
-- Name: page_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sygen
--

SELECT pg_catalog.setval('public.page_id_seq', 3, true);


--
-- Name: region_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sygen
--

SELECT pg_catalog.setval('public.region_id_seq', 12, true);


--
-- Name: spec_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sygen
--

SELECT pg_catalog.setval('public.spec_id_seq', 8, true);


--
-- Name: tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sygen
--

SELECT pg_catalog.setval('public.tag_id_seq', 1, false);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sygen
--

SELECT pg_catalog.setval('public.user_id_seq', 2, true);


--
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: sygen
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


--
-- Name: conf conf_pkey; Type: CONSTRAINT; Schema: public; Owner: sygen
--

ALTER TABLE ONLY public.conf
    ADD CONSTRAINT conf_pkey PRIMARY KEY (id);


--
-- Name: doctrine_migration_versions doctrine_migration_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: sygen
--

ALTER TABLE ONLY public.doctrine_migration_versions
    ADD CONSTRAINT doctrine_migration_versions_pkey PRIMARY KEY (version);


--
-- Name: feedback feedback_pkey; Type: CONSTRAINT; Schema: public; Owner: sygen
--

ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT feedback_pkey PRIMARY KEY (id);


--
-- Name: image image_pkey; Type: CONSTRAINT; Schema: public; Owner: sygen
--

ALTER TABLE ONLY public.image
    ADD CONSTRAINT image_pkey PRIMARY KEY (id);


--
-- Name: language language_pkey; Type: CONSTRAINT; Schema: public; Owner: sygen
--

ALTER TABLE ONLY public.language
    ADD CONSTRAINT language_pkey PRIMARY KEY (id);


--
-- Name: messenger_messages messenger_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: sygen
--

ALTER TABLE ONLY public.messenger_messages
    ADD CONSTRAINT messenger_messages_pkey PRIMARY KEY (id);


--
-- Name: node node_pkey; Type: CONSTRAINT; Schema: public; Owner: sygen
--

ALTER TABLE ONLY public.node
    ADD CONSTRAINT node_pkey PRIMARY KEY (id);


--
-- Name: node_region node_region_pkey; Type: CONSTRAINT; Schema: public; Owner: sygen
--

ALTER TABLE ONLY public.node_region
    ADD CONSTRAINT node_region_pkey PRIMARY KEY (node_id, region_id);


--
-- Name: node_tag node_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: sygen
--

ALTER TABLE ONLY public.node_tag
    ADD CONSTRAINT node_tag_pkey PRIMARY KEY (node_id, tag_id);


--
-- Name: page page_pkey; Type: CONSTRAINT; Schema: public; Owner: sygen
--

ALTER TABLE ONLY public.page
    ADD CONSTRAINT page_pkey PRIMARY KEY (id);


--
-- Name: region region_pkey; Type: CONSTRAINT; Schema: public; Owner: sygen
--

ALTER TABLE ONLY public.region
    ADD CONSTRAINT region_pkey PRIMARY KEY (id);


--
-- Name: spec spec_pkey; Type: CONSTRAINT; Schema: public; Owner: sygen
--

ALTER TABLE ONLY public.spec
    ADD CONSTRAINT spec_pkey PRIMARY KEY (id);


--
-- Name: tag tag_pkey; Type: CONSTRAINT; Schema: public; Owner: sygen
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tag_pkey PRIMARY KEY (id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: sygen
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: idx_14f389a882f1baf4; Type: INDEX; Schema: public; Owner: sygen
--

CREATE INDEX idx_14f389a882f1baf4 ON public.conf USING btree (language_id);


--
-- Name: idx_70ac95f8460d9fd7; Type: INDEX; Schema: public; Owner: sygen
--

CREATE INDEX idx_70ac95f8460d9fd7 ON public.node_tag USING btree (node_id);


--
-- Name: idx_70ac95f8bad26311; Type: INDEX; Schema: public; Owner: sygen
--

CREATE INDEX idx_70ac95f8bad26311 ON public.node_tag USING btree (tag_id);


--
-- Name: idx_75ea56e016ba31db; Type: INDEX; Schema: public; Owner: sygen
--

CREATE INDEX idx_75ea56e016ba31db ON public.messenger_messages USING btree (delivered_at);


--
-- Name: idx_75ea56e0e3bd61ce; Type: INDEX; Schema: public; Owner: sygen
--

CREATE INDEX idx_75ea56e0e3bd61ce ON public.messenger_messages USING btree (available_at);


--
-- Name: idx_75ea56e0fb7336f0; Type: INDEX; Schema: public; Owner: sygen
--

CREATE INDEX idx_75ea56e0fb7336f0 ON public.messenger_messages USING btree (queue_name);


--
-- Name: idx_857fe84512469de2; Type: INDEX; Schema: public; Owner: sygen
--

CREATE INDEX idx_857fe84512469de2 ON public.node USING btree (category_id);


--
-- Name: idx_857fe84582f1baf4; Type: INDEX; Schema: public; Owner: sygen
--

CREATE INDEX idx_857fe84582f1baf4 ON public.node USING btree (language_id);


--
-- Name: idx_bb70e4d3460d9fd7; Type: INDEX; Schema: public; Owner: sygen
--

CREATE INDEX idx_bb70e4d3460d9fd7 ON public.node_region USING btree (node_id);


--
-- Name: idx_bb70e4d398260155; Type: INDEX; Schema: public; Owner: sygen
--

CREATE INDEX idx_bb70e4d398260155 ON public.node_region USING btree (region_id);


--
-- Name: idx_c00e173e460d9fd7; Type: INDEX; Schema: public; Owner: sygen
--

CREATE INDEX idx_c00e173e460d9fd7 ON public.spec USING btree (node_id);


--
-- Name: idx_c53d045f460d9fd7; Type: INDEX; Schema: public; Owner: sygen
--

CREATE INDEX idx_c53d045f460d9fd7 ON public.image USING btree (node_id);


--
-- Name: idx_d2294458460d9fd7; Type: INDEX; Schema: public; Owner: sygen
--

CREATE INDEX idx_d2294458460d9fd7 ON public.feedback USING btree (node_id);


--
-- Name: idx_f62f176c4663e4; Type: INDEX; Schema: public; Owner: sygen
--

CREATE INDEX idx_f62f176c4663e4 ON public.region USING btree (page_id);


--
-- Name: uniq_8d93d649f85e0677; Type: INDEX; Schema: public; Owner: sygen
--

CREATE UNIQUE INDEX uniq_8d93d649f85e0677 ON public."user" USING btree (username);


--
-- Name: messenger_messages notify_trigger; Type: TRIGGER; Schema: public; Owner: sygen
--

CREATE TRIGGER notify_trigger AFTER INSERT OR UPDATE ON public.messenger_messages FOR EACH ROW EXECUTE FUNCTION public.notify_messenger_messages();


--
-- Name: conf fk_14f389a882f1baf4; Type: FK CONSTRAINT; Schema: public; Owner: sygen
--

ALTER TABLE ONLY public.conf
    ADD CONSTRAINT fk_14f389a882f1baf4 FOREIGN KEY (language_id) REFERENCES public.language(id);


--
-- Name: node_tag fk_70ac95f8460d9fd7; Type: FK CONSTRAINT; Schema: public; Owner: sygen
--

ALTER TABLE ONLY public.node_tag
    ADD CONSTRAINT fk_70ac95f8460d9fd7 FOREIGN KEY (node_id) REFERENCES public.node(id) ON DELETE CASCADE;


--
-- Name: node_tag fk_70ac95f8bad26311; Type: FK CONSTRAINT; Schema: public; Owner: sygen
--

ALTER TABLE ONLY public.node_tag
    ADD CONSTRAINT fk_70ac95f8bad26311 FOREIGN KEY (tag_id) REFERENCES public.tag(id) ON DELETE CASCADE;


--
-- Name: node fk_857fe84512469de2; Type: FK CONSTRAINT; Schema: public; Owner: sygen
--

ALTER TABLE ONLY public.node
    ADD CONSTRAINT fk_857fe84512469de2 FOREIGN KEY (category_id) REFERENCES public.category(id);


--
-- Name: node fk_857fe84582f1baf4; Type: FK CONSTRAINT; Schema: public; Owner: sygen
--

ALTER TABLE ONLY public.node
    ADD CONSTRAINT fk_857fe84582f1baf4 FOREIGN KEY (language_id) REFERENCES public.language(id);


--
-- Name: node_region fk_bb70e4d3460d9fd7; Type: FK CONSTRAINT; Schema: public; Owner: sygen
--

ALTER TABLE ONLY public.node_region
    ADD CONSTRAINT fk_bb70e4d3460d9fd7 FOREIGN KEY (node_id) REFERENCES public.node(id) ON DELETE CASCADE;


--
-- Name: node_region fk_bb70e4d398260155; Type: FK CONSTRAINT; Schema: public; Owner: sygen
--

ALTER TABLE ONLY public.node_region
    ADD CONSTRAINT fk_bb70e4d398260155 FOREIGN KEY (region_id) REFERENCES public.region(id) ON DELETE CASCADE;


--
-- Name: spec fk_c00e173e460d9fd7; Type: FK CONSTRAINT; Schema: public; Owner: sygen
--

ALTER TABLE ONLY public.spec
    ADD CONSTRAINT fk_c00e173e460d9fd7 FOREIGN KEY (node_id) REFERENCES public.node(id);


--
-- Name: image fk_c53d045f460d9fd7; Type: FK CONSTRAINT; Schema: public; Owner: sygen
--

ALTER TABLE ONLY public.image
    ADD CONSTRAINT fk_c53d045f460d9fd7 FOREIGN KEY (node_id) REFERENCES public.node(id);


--
-- Name: feedback fk_d2294458460d9fd7; Type: FK CONSTRAINT; Schema: public; Owner: sygen
--

ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT fk_d2294458460d9fd7 FOREIGN KEY (node_id) REFERENCES public.node(id);


--
-- Name: region fk_f62f176c4663e4; Type: FK CONSTRAINT; Schema: public; Owner: sygen
--

ALTER TABLE ONLY public.region
    ADD CONSTRAINT fk_f62f176c4663e4 FOREIGN KEY (page_id) REFERENCES public.page(id);


--
-- PostgreSQL database dump complete
--

