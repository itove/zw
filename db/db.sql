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
    country character varying(30) DEFAULT NULL::character varying
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
    image character varying(255) NOT NULL
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
    address character varying(255) DEFAULT NULL::character varying
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
-- Name: page; Type: TABLE; Schema: public; Owner: zw
--

CREATE TABLE public.page (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    label character varying(255) NOT NULL
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
    page_id integer
);


ALTER TABLE public.region OWNER TO zw;

--
-- Name: COLUMN region.fields; Type: COMMENT; Schema: public; Owner: zw
--

COMMENT ON COLUMN public.region.fields IS '(DC2Type:simple_array)';


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
    value character varying(255) NOT NULL
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
-- Name: user_node; Type: TABLE; Schema: public; Owner: zw
--

CREATE TABLE public.user_node (
    user_id integer NOT NULL,
    node_id integer NOT NULL
);


ALTER TABLE public.user_node OWNER TO zw;

--
-- Name: messenger_messages id; Type: DEFAULT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.messenger_messages ALTER COLUMN id SET DEFAULT nextval('public.messenger_messages_id_seq'::regclass);


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public.category (id, name, label) FROM stdin;
1	景区介绍	intro
\.


--
-- Data for Name: conf; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public.conf (id, language_id, sitename, keywords, description, address, phone, email, logo, updated_at, note) FROM stdin;
1	\N	乐游东沟_东沟文化旅游网	东沟,东沟文化旅游网,东沟中原突围鄂西北历史纪念馆,东沟烈士陵园,东沟念情谷猕猴园,杜鹃岭,桃源人家,蛙声十里,山顶美宿	东沟村位于十堰市茅箭区茅塔乡，属于湖北赛武当国家级自然保护区试验区和缓冲区范围，面积11.4平方公里，距十堰市城区13公里。东沟已形成集接受爱国教育、欣赏自然风光、体验农家风情，观摩新农村建设于一体的具有丰富内涵的红色旅游胜地。	湖北省十堰市茅箭区茅塔乡东沟村一组	0719-8457770	\N	logo-6641912db5458003532123.png	2024-05-13 04:03:57	鄂ICP备2023029037号-1
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
\.


--
-- Data for Name: feedback; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public.feedback (id, node_id, firstname, lastname, email, phone, title, body, country) FROM stdin;
7	\N	木子	\N	13636226368@163.com	18986882698	东沟WIFI全覆盖	建议东沟WIFI全覆盖，方便游客打卡。	\N
\.


--
-- Data for Name: image; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public.image (id, node_id, image) FROM stdin;
1	39	zoujin-slider-1-6641de859dc34583489789.jpg
4	39	qq-jie-tu20240515115625-664432e6eea1b079893567.jpg
5	39	qq-jie-tu20240515120005-6644336a2bc3f019044511.jpg
\.


--
-- Data for Name: language; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public.language (id, language, prefix, locale) FROM stdin;
\.


--
-- Data for Name: link; Type: TABLE DATA; Schema: public; Owner: zw
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
-- Data for Name: menu; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public.menu (id, name, label) FROM stdin;
1	页脚导航	footer
3	友情链接	friend
\.


--
-- Data for Name: messenger_messages; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public.messenger_messages (id, body, headers, queue_name, created_at, available_at, delivered_at) FROM stdin;
\.


--
-- Data for Name: node; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public.node (id, language_id, category_id, title, created_at, body, image, summary, updated_at, video, parent_id, audio, qr, phone, latitude, longitude, address) FROM stdin;
1	\N	\N	f1	2024-05-07 01:08:07	\N	\N	\N	2024-05-07 01:08:07	\N	\N	\N	\N	\N	\N	\N	\N
2	\N	\N	f2	2024-05-07 01:12:27	\N	\N	\N	2024-05-07 01:12:27	\N	\N	\N	\N	\N	\N	\N	\N
3	\N	\N	f3	2024-05-07 01:12:43	\N	\N	\N	2024-05-07 01:12:43	\N	\N	\N	\N	\N	\N	\N	\N
4	\N	\N	faq1	2024-05-12 11:18:17	\N	\N	\N	2024-05-12 11:18:17	\N	\N	\N	\N	\N	\N	\N	\N
5	\N	\N	产品方案1	2024-05-12 11:18:31	\N	\N	\N	2024-05-12 11:18:31	\N	\N	\N	\N	\N	\N	\N	\N
17	\N	\N	乐游东沟	2024-05-13 03:14:15	\N	leyou-bg-664185b77e4ff378757708.jpg	特色景区服务 · 给您贴心体验	2024-05-13 03:15:03	\N	\N	\N	\N	\N	\N	\N	\N
32	\N	\N	投诉建议	2024-05-13 08:07:54	\N	\N	如果您对东沟有任何建议或想与我们讨论的问题，请填写表单，我们将尽力为您处理。	2024-05-13 08:07:54	\N	\N	\N	\N	\N	\N	\N	\N
35	\N	\N	高铁出行	2024-05-13 09:28:13	\N	train-6641dd2dc2894166030166.png	\N	2024-05-13 09:28:13	\N	\N	\N	\N	\N	\N	\N	\N
36	\N	\N	客车出行	2024-05-13 09:28:38	\N	bus-6641dd4703e3b261786135.png	\N	2024-05-13 09:28:39	\N	\N	\N	\N	\N	\N	\N	\N
37	\N	\N	飞机出行	2024-05-13 09:29:00	\N	plane-6641dd5d44124102676172.png	\N	2024-05-13 09:29:01	\N	\N	\N	\N	\N	\N	\N	\N
38	\N	\N	自驾路线	2024-05-13 09:29:22	\N	car-6641dd72d77c0868742161.png	\N	2024-05-13 09:29:22	\N	\N	\N	\N	\N	\N	\N	\N
40	\N	\N	行程规划	2024-05-13 09:46:00	\N	zoujin-xingcheng-bg-6641e159690aa348240367.jpg	选择您的出行方式，我们将给您做出推荐	2024-05-13 09:46:01	\N	\N	\N	\N	\N	\N	\N	\N
6	\N	1	田园诗画 生态乡村	2024-05-13 00:56:40	\N	3sheng-tai-xiang-cun1920-x-1074-1-6644b1a9a914f506266192.jpg	Rural poetry, painting, ecological countryside	2024-05-15 12:59:21	\N	\N	\N	\N	\N	\N	\N	\N
9	\N	\N	景区介绍	2024-05-13 02:34:06	\N	home-jingqu-bg-66417caa39426232884525.jpg	秦巴古驿 文化传承	2024-05-13 02:36:26	\N	\N	\N	\N	\N	\N	\N	\N
19	\N	\N	住在东沟	2024-05-13 03:22:13	\N	leyou-2-664187665a86a860794393.jpg	以桃源人家为代表的特色民宿，将民宿综合体内的咖啡馆、民俗布染坊、陶艺...	2024-05-13 03:22:14	\N	\N	\N	\N	\N	\N	\N	\N
20	\N	\N	吃在东沟	2024-05-13 03:22:32	\N	leyou-3-66418778ec1f2926274706.jpg	在东沟，您可以品尝到地道的农家菜肴，每一口都散发着乡土的气息...	2024-05-13 03:22:32	\N	\N	\N	\N	\N	\N	\N	\N
21	\N	\N	购在东沟	2024-05-13 03:22:52	\N	leyou-4-6641878c99c53673730065.jpg	扎染、剪纸、古法榨油、刺绣等非遗文化创新商品与当地特色的农副产品...	2024-05-13 03:22:52	\N	\N	\N	\N	\N	\N	\N	\N
10	\N	\N	行程规划	2024-05-13 02:37:48	\N	xingcheng-66417cfcac045999996237.jpg	红色基地 革命记忆	2024-05-13 02:37:48	\N	\N	\N	\N	\N	\N	\N	\N
34	\N	\N	乐游东沟小程序	2024-05-13 08:40:05	\N	gh-23ef79be77ea-258-6646e99e20d6e205596278.jpg	\N	2024-05-17 05:22:38	\N	\N	\N	\N	\N	\N	\N	\N
23	\N	\N	茅箭区东沟村：生旅融合绘就“金山银山”	2024-05-13 03:40:11	<p>或欣赏山水风光，或拾得自然野趣，或感受田园生活，或体验传统民俗，又或寻迹红色历史……四季花开，处处皆景。在湖北省十堰市茅箭区茅塔乡东沟村，不论您什么季节来，不管您带着什么样的心情来，也无论您来过多少次，这里总不会让您失望，总会让您有不一样的体验，收获不一样的旅程。</p><p>东沟村是革命老区，红色历史文化厚重。其距十堰城区13公里，境内山清水秀、景色宜人，素有“十堰车城后花园”之称，是集红色、生态和乡村于一体的国家3A级旅游景区。近年来，东沟村聚焦休闲农业定位，依托红色文化旅游资源，集中整合资源品牌，做强做大做全农业休闲“文章”，激活发展“一池春水”。</p><p><strong>做足“山水文章” 风景这边独好</strong></p><p><img src="http://hbrbapp.hubeidaily.net/618a0537-5f0a-4da9-8903-656487e1b3ee"></p><p>初秋时节，进入山环水绕的茅塔乡东沟村，一路满目浓翠、鸟语花香，整齐别致的民房依山而建，掩映在浓浓的绿荫之中。沿路进入景区，农家乐、小商店、“熊孩子”蜂蜜博物馆等各处可见休闲游玩的游客身影。</p><p>很难想象，上世纪七八十年代，耕地面积不足0.3亩的东沟村村民曾一度靠砍伐树木为生。如今，这里“村庄变景区，村民变股东，风景变‘钱景’”，昔日的“穷山村”“落后村”摇身一变，成为远近闻名的“网红村”。</p><p>山水见证，美丽蝶变。近年来，乘着政策利好的东风，该村立足村情实际、精心谋划，按照“红色旅游带动乡村”的发展思路，挖掘红色资源禀赋，按照“把农村当成景区来建设，把农居当成旅馆来改造，把农田山水当作旅游基地来经营”的理念，趟出了一条以生态种植、生态观光、休闲度假融合发展的休闲农业旅游产业新路。</p><p>红色文化搭台，“休闲农业”唱戏，“人人都是建设者”。锁定新时期村集体产业发展定位，东沟村因地制宜，充分挖掘生态人文融和发展的特色优势，相继建成中原突围鄂西北历史纪念馆、花开四季——月季园、杜鹃花海——野生杜鹃岭、荷塘月色——荷花塘、念情谷水帘洞天——猕猴园等一批独具特色的景点，吸引了十堰城区乃至周边游客纷至沓来。仅东沟红色旅游景区每年旅游人数超过10万人次。</p><p>一花独放不是春。近几年，东沟村创新思路，采取“合作社+农户”模式，重点打造推出梅花茶园、樱花茶园、海棠茶园、月季园、云上牡丹园等五大景观园区。每年2月至5月，东沟村绿梅，樱花、海棠花、牡丹花、月季花杜鹃花依次竞相开放，景色宜人、游人如织，成为十堰近郊游一道亮丽的风景线。</p><p><strong>精耕生态产业 “乡愁远方”兼顾</strong></p><p><img src="http://hbrbapp.hubeidaily.net/9da66a00-1366-4c11-b82e-31ced675cf2e"></p><p>每逢周末，不少游客会带着孩子到东沟村的桃源人家民宿，体验手工陶艺、植物绘画、草木染。“游客们兴致很高，现场欢声笑语。”桃源人家民宿的创办人王启迪说。</p><p>桃源人家民宿是东沟村引进的旅游龙头项目，项目创办人扎根东沟后，又接连开办“蛙声十里”“休休堂”等亲子民宿，建起桃源货栈、草木染坊、陶艺作坊等扶贫项目，成功打造出集亲子民宿、民宿学院、桃源货栈、陶艺坊、子衿染坊等多种业态融合发展的民宿综合体。为进一步丰富旅游景区内涵，拓展景区空间，通过极力争取，今年2月，村上又在牡丹园内建造5栋微宿，微宿项目的进驻使得景区游客量大大增加。</p><p>以民宿为龙头带动，东沟村举行农家乐服务和经营培训，为村民进行专业的指导，引导村民利用自身房屋、土地优势开办农家乐，有力带动当地群众通过发展旅游业增收致富。目前，东沟村里村民开办的民宿有5家，农家乐有8家，90％以上的村民吃上了‘旅游饭’，还有不少外出打工青年返乡创业，既留得住“乡愁”，也兼顾“诗与远方”。</p><p>好山好水好风光，有诗有情有远方。东沟村凭借良好的生态环境资源，以休闲农业产业为龙头带动农民增收，先后被授予“市级文明风景旅游区”、十堰市“绿色幸福村”、十堰市“文明村”、“十堰市生态家园示范村”、湖北省“美丽乡村建设示范村”、“湖北省脱贫攻坚先进集体”、“全国生态文化村”、“中国美丽休闲乡村”等荣誉称号。（湖北日报客户端 通讯员韩苗 郭安富 张旭）</p>	\N	或欣赏山水风光，或拾得自然野趣，或感受田园生活，或体验传统民俗	2024-05-13 03:40:11	\N	\N	\N	\N	\N	\N	\N	\N
22	\N	\N	记者探访十堰茅塔乡东沟村：红色文化+绿色发展走出文旅扶贫路	2024-05-13 03:39:49	<p><img src="http://www.cnr.cn/newscenter/native/gd/20201028/W020201028741734423458.jpg" alt=""></p><p>东沟村（刘建维 摄）</p><p>走进湖北十堰市茅箭区茅塔乡东沟村，森林环抱、鸟语花香，精致的民宿依地势而建；这里也曾经烽火连天、枪林弹雨，996位革命前辈长眠于此，世代述说英雄故事。近年来，东沟村以红色文化为依托，充分发挥自然资源优势，将红色文化的传承与绿色生态发展融合到一起，走出了一条文旅脱贫之路。</p><p>巍巍武当西麓的茅塔乡东沟村是一片战火洗礼过的红色热土，它地处均郧房三县交界，曾先后设立了鄂西北第三军分区、均郧房县委县政府、县总队。上世纪七八十年代，砍伐树木一度成为人均耕地面积不足0.3亩的东沟村村民养家糊口的主要收入来源。沉痛的代价唤醒了红色基因，时任村干部多次商议，考虑东沟保留着不少历史遗址，又是革命先烈战斗过的地方，有发展红色旅游的基础，经过考察调研，最终敲定了红色旅游带动乡村发展思路。</p><p><img src="http://www.cnr.cn/newscenter/native/gd/20201028/W020201028741735001408.jpg" alt=""></p><p>均郧房县委县政府旧址（张沛 摄）</p><p>乘着三农政策、扶持革命老区建设、精准扶贫等国家政策的东风，东沟村向全面小康的目标不断迈进。</p><p>东沟村坚持保护修缮与开发并举，对2000平方米革命遗址进行腾退、修复，修通进村公路，陆续建起革命烈士陵园、革命文物陈列馆、戏楼、东沟学堂等，持续建设完善红色旅游文化资源。</p><p><img src="http://www.cnr.cn/newscenter/native/gd/20201028/W020201028741735072056.jpg" alt=""></p><p>东沟村特色民宿（刘建维 摄）</p><p>秉承“把农村当成景区来建设，把农居当成旅馆来改造，把农田山水当作旅游基地来经营”的理念，东沟村引导村民改造、新建特色民居，使整个村庄更加古朴、美丽，旅游服务更加完善、周到。打造以生态种植养殖、农家餐饮住宿为支撑的旅游配套全产业，采用“公司+基地+农户”模式，建成生态茶园400亩，武当道茶公司定期协议收购茶园鲜叶；依势就地铺设茶园观赏步游道，打造参与性高、体验感强的观光茶园主题景观园区，推动茶产业、茶文化发展。</p><p><img src="http://www.cnr.cn/newscenter/native/gd/20201028/W020201028741735210980.jpg" alt=""></p><p>特色民宿 （刘建维 摄）</p><p><img src="http://www.cnr.cn/newscenter/native/gd/20201028/W020201028741737415240.jpg" alt=""></p><p>特色民宿（刘建维 摄）</p><p><img src="http://www.cnr.cn/newscenter/native/gd/20201028/W020201028741737451581.jpg" alt=""></p><p>“桃源人家”民宿（陈明 摄）</p><p>在这样一个静谧的乡村里，几处特色民宿格外亮眼。</p><p>在上海工作13年的王启迪，偶然来到东沟村游览，便爱上这里留了下来，在村里租了一栋房屋院落，办起了别具特色的“桃源人家”民宿，成为“东沟人”之后，又接连开办“蛙声十里”“休休堂”等亲子民宿，建起蓝染、陶艺等扶贫作坊。据了解，2016年6月营业至今，已累计接待游客超过十万人次。</p><p><img src="http://www.cnr.cn/newscenter/native/gd/20201028/W020201028741737540431.jpg" alt=""></p><p>草木染工坊 （张沛 摄）</p><p><img src="http://www.cnr.cn/newscenter/native/gd/20201028/W020201028741737719629.jpg" alt=""></p><p>工人展示草木染（刘建维 摄）</p><p>“我们通过文化旅游来促脱贫。”王启迪介绍，民宿优先租赁东沟村贫困户田地，连续三年，按年支付土地租赁费用，帮助贫困户增收。桃源货栈利用其自身的民宿窗口和品牌优势，帮助村合作社销售产品；同时，吸纳贫困户到民宿或草木染工坊就业；还引进传承传统草木染技艺，打造乡村本土文创产品。</p><p>村民吴文琴就是民宿的受益者，以前家里的收入靠丈夫在外务工，她来到这里打工后，能在家门口就业，每月赚到两三千块钱，减轻了家里的负担。对于未来，她也充满了希望：“我想在十堰买房子。”</p><p><img src="http://www.cnr.cn/newscenter/native/gd/20201028/W020201028741737781981.jpg" alt=""></p><p>“桃源人家”民宿（陈明 摄）</p><p>以“桃源人家”民宿为龙头，东沟村举行农家乐服务和经营培训，为村民进行专业的指导，引导村民利用自身房屋、土地优势开办农家乐，成为当地乡村振兴和经济发展的新亮点。</p><p>“文旅扶贫已经取得了明显实效。”东沟村党支部书记张旭介绍，2019年全村实现经济总收入730余万元，旅游接待量达40余万人次，旅游综合收入450余万元，带动周边50余户村民就业创业，90%农村劳动力吃上了“旅游饭”，摘掉了“贫困帽”。</p>	\N	走进湖北十堰市茅箭区茅塔乡东沟村，森林环抱、鸟语花香，精致的民宿依地势而建；这里也曾经烽火连天	2024-05-13 03:39:49	\N	\N	\N	\N	\N	\N	\N	\N
16	\N	\N	花开四季 — 月季园	2024-05-13 03:10:26	<p>&nbsp;</p><p>　　月季园位于十堰市茅箭区茅塔乡东沟村红色革命教育基地入口小路旁。</p><p>　　种植面积约60余亩，是一个相对大规模的月季园。月季园内种植着大量的月季花，这些月季花热烈盛开，展现出浪漫唯美的景象。月季花的颜色丰富，形态各异，紧紧相连，摇曳在轻风之中，更显得风姿绰约。</p><p>　　每年初夏时节，月季园成为了一片花的海洋，装点着梯田式的园地，花香四溢。这里的月季花不仅美丽娇艳，还为东沟村增添了浓厚的浪漫气息，吸引了大批游客前来赏花留影。</p><p>　　“花开四季”月季园是一个集观赏、拍照、休闲为一体的花卉景区。游客可以在这里欣赏到美丽的月季花海，感受浓厚的浪漫气息，并留下美好的回忆。</p><p>&nbsp;</p><figure class="image"><img src="/images/6646bc9bb1e19-7c59824daeb912bf3b0f42395bc72279.jpg"></figure><p>&nbsp;</p><p>　　月季园栽植有大花月季、树桩月季、藤本月季20000余棵，共计10余个品种。</p><p>　　种植面积约60余亩，是一个相对大规模的月季园。月季园内种植着大量的月季花，这些月季花热烈盛开，展现出浪漫唯美的景象。月季花的颜色丰富，形态各异，紧紧相连，摇曳在轻风之中，更显得风姿绰约。</p><p>&nbsp;</p><figure class="image"><img src="/images/6646bc9fed98b-1891d48d9dd72651fd45be39c0232575.jpg"></figure><p>&nbsp;</p><p>　　每年4月中下旬首开第一茬花，花朵直径达15公分，一年四季花儿姹紫嫣红、竞相绽放，花香满园、浸人心肺，是一个观花摄影、踏青游玩的靓丽景点，月季园毗邻东沟爱国主义教育基地，茅箭区廉政学堂，观花赏景之余更可以近距离接收红色文化熏陶，提升自我修养。</p><p>&nbsp;</p><figure class="image"><img src="/images/6646bca41c9e0-bc4b785ceed8cc9094e061173c73e039.jpg"></figure><p>&nbsp;</p>	jingqu-6-664184a363d3b686847409.jpg	\N	2024-05-13 03:10:27	\N	\N	\N	\N	\N	\N	\N	\N
25	\N	\N	东风商用车·2024十堰马拉松圆满举行	2024-05-13 03:40:57	<p><img src="http://maojian.shiyan.gov.cn/xwzx/mjxw_1/202404/W020240415319535198573.jpg" alt=""></p><p>参加东风商用车·2024十堰马拉松的选手从起点十堰奥体中心出发。记者刘旻全正摄</p><p>山水之城，向“绿”先行；汽车之城，向“新”出发。4月14日上午，东风商用车·2024十堰马拉松在市奥体中心鸣枪开跑。市委副书记、市长王永辉，省体育局副局长郑李辉，东风商用车有限公司总经理张小帆，市领导汤红兵、刘学勤、朱云慧、沈明云等出席起跑仪式，为大赛鸣枪发令。</p><p>本次马拉松赛事经中国田径协会官方技术认证，由湖北省体育局、市人民政府主办，市体育局、茅箭区人民政府承办。设有全程马拉松（42.195公里）、半程马拉松（21.0975公里）、健康跑（4公里）三个项目，2万余人参赛，其中，全程马拉松2000余人、半程马拉松3000余人、健康跑15000余人。</p><p>7时30分，随着发令枪响，选手冲出起跑线，沿着紫霄大道、北京路一路向前，踏上了挑战自我的征程。赛道上，既有冲锋在前的专业选手，也有不甘落后的马拉松爱好者；既有年长的老人，也有活力四射的年轻人。大家迈开脚步、甩开臂膀，你追我赶、奋勇争先，用脚步感触十堰城区现代发展的脉络，共同领略城野乡间的自然之趣，共同享受运动带来的愉悦与健康。著名体育主持人、解说员韩乔生现场助力，并作为解说嘉宾现身直播间。</p><p>在起点旁、赛道旁、终点处，加油声、呼喊声不断，市民群众以最饱满的热情为跑友呐喊助威、加油鼓劲。现场指引、物资补给、秩序维护、医疗救护、交通疏导等各类志愿者和工作人员，用“微笑、点赞、加油”为参赛选手提供最有温度的服务，成为赛道上一抹亮丽的风景线。赛道沿线，舞龙、舞狮、音乐加油站、街舞、太极拳、健身操等表演为比赛营造了热烈、向上的赛事氛围。</p><p>一路逐风，拼搏向前。经过激烈角逐，埃塞俄比亚选手 FELATE MULETADEYISA以2小时23分55秒的成绩夺得全程马拉松男子组冠军，埃塞俄比亚选手REGASSA HAWI MEGERSSA以2小时47分32秒的成绩夺得全程马拉松女子组冠军。中国选手刘军、沈妮以1小时9分55秒、1小时18分15秒的成绩分别获得半程马拉松男子组、女子组冠军。</p><p>一步一景之间，马拉松赛成为城市最好的导游，也成为城市魅力与活力的最好注脚。此次赛事活动规模大、影响广、吸引力强，是一次宣传东风、走进十堰的文化体育盛事。近年来，十堰通过举办一场场精品赛事，纵深推进文体旅融合发展，为城市发展注入了更多新动能。（记者闵波刘旻）</p>	\N	山水之城，向“绿”先行；汽车之城，向“新”出发。4月14日上午，东风商用车...	2024-05-13 03:40:57	\N	\N	\N	\N	\N	\N	\N	\N
12	\N	\N	烈士陵园	2024-05-13 03:07:52	<p>&nbsp;</p><p>　　东沟村烈士陵园是为了缅怀在革命斗争中牺牲的先烈而建立的。特别是在1946年10月，王树声率部及均郧房县总队与国民党地方团进行激战，为掩护部队转移，均郧房县委书记朱正传及38名战士在此牺牲，他们中最大的31岁，最小的只有18岁，甚至还有很多人连名字都没来的及留下。</p><p>&nbsp;</p><figure class="image"><img src="/images/664437e4eb225-c851042925372b41add2be92e741e000.jpg"></figure><p>&nbsp;</p><p>　　陵园的建设历程</p><p>　　初始建设：1999年8月，为了集中安葬烈士，将5名分散安葬在山坡丛林中的烈士墓迁移至东沟村二组，新建了东沟革命烈士墓群，占地面积为500平方米。</p><p>　　道路改扩建：2005年，对通往东沟烈士陵园的道路进行了改扩建，提高了陵园的可达性。</p><p>　　全面修建：2011年，由十堰市政园林管理局捐资，对陵园进行了全面的修建。新建的陵园位于原东沟村革命烈士墓左侧，占地面积扩大至6000多平方米，总投资达到80余万元。陵园主要由纪念广场、烈士碑亭和浮雕墙组成。</p><p>　　烈士迁入：2022年9月22日，十堰市茅箭区在东沟烈士陵园纪念广场举行零散烈士墓集中迁葬入园仪式。155座零散烈士墓，迁葬至东沟烈士陵园。其中，可以确定姓名的有19位。</p><p>&nbsp;</p><figure class="image"><img src="/images/6644380914c83-03968a702214e9520058d80d345170ac.jpg"></figure><p>&nbsp;</p><p>　　浩气存天地，忠魂归陵园!</p><p>　　东沟烈士陵园不仅是对革命先烈的缅怀之地，也是进行红色教育和爱国主义教育的重要场所。每年清明节前后，前往东沟烈士陵园悼念烈士的游客络绎不绝。此外，十堰各组织、党支部等也会在此开展主题党日活动，激发党员的爱国热情。</p><p>　　朱正传是江苏常州人，毕业于天津南开附中。1943年，朱正传与妻子易齐荇结成革命伴侣，为党的事业，夫妻分隔两地战斗。直到1986年，湖北省十堰市在搜集整理地方党史时，易齐荇才知道朱正传牺牲在十堰。此后，她一有时间就会来十堰东沟纪念自己的丈夫。易齐荇在朱正传烈士牺牲后没有再嫁，他们也没有留下后代。两人的红色爱情故事感动着当地村民，后来，东沟人就把朱正传烈士为革命洒下热血牺牲的这片山谷命名为“念情谷”。</p><p>　　杜鹃花海象征革命烈士化身。在东沟村革命烈士战斗过的山岭有一片杜鹃花海，100余亩，均属野生，每年4至5月盛开，呈现出山花烂漫，宛如仙境的自然风光。其颜色鲜艳夺目，象征着革命烈士的滴滴鲜血，染红了东沟的山野。来此瞻仰的游客在享受自然风光的同时，被这里的红军遗物、红色故事、红色文化所熏陶教育，深受启迪，弘扬革命先烈的英雄精神，珍惜今天的幸福生活。</p>	jingqu-2-66418408a3912586135449.jpg	\N	2024-05-13 03:07:52	\N	\N	\N	\N	\N	\N	\N	\N
33	\N	\N	乐游东沟公众号	2024-05-13 08:39:42	\N	qrcode-for-gh-9509e715b92d-258-6646ea3dd2a0e756818313.jpg	\N	2024-05-17 05:25:17	\N	\N	\N	\N	\N	\N	\N	\N
27	\N	\N	茅箭区茅塔河流域农村生活污水治理见闻	2024-05-13 03:41:40	<p>&nbsp;</p><p>十堰是南水北调中线工程核心水源区。高标准治理好农村生活污水，对全面推进乡村振兴、加快建设绿色低碳发展示范区、确保一库碧水永续北送具有重大意义。近年来，茅箭区扎实做好乡村建设“六件事”，将农村污水治理作为小流域综合治理“关键工程”来抓，农村生活污水收集率达90%以上，位居全省前列，美丽乡村建设成效显著。</p><p><strong>污水处理站因地制宜建</strong></p><p>走进茅箭区茅塔乡坪子村，一处处人工湿地绿意盎然，就连环保公厕也自成一景。</p><p>该村村民夏桂荣去年将家中旱厕拆除，取而代之的是一个微型“污水处理站”。“以前，一到夏天，旱厕就臭得很，苍蝇满天飞。现在厕所干净了，空气清新了，环境也跟着变好了。”夏桂荣说。</p><p>“浇肥只需打开三格化粪池小盖板，浇水用小湿地里的水，非常方便！”在该村，市生态环境局茅箭分局局长胡华鹏指着一套小型污水处理设施介绍说，“这是我们正在推广的‘四件套’改厕模式。它不仅能有效解决旱厕污水排放难题，而且净化过的水可用于农业灌溉等。”</p><p>记者采访中了解到，茅箭区对分散居住的农户实行统一规划，推广“水冲式厕所+三格化粪池+沉淀池+小湿地”的“四件套”改厕模式。对10户以上集中居住区，采取“化粪池+沉淀池+微动力设施+人工湿地”改厕模式。目前，茅塔河小流域已实现10户以上集居区、分散农户污水处理设施全覆盖。</p><p>在工艺选择上，新建污水处理设施采用“AO一体化设备+人工湿地”微动力工艺。该设施具有占地面积小、运行成本低、管理维护简单、出水水质稳定等特点，适合在农村推广应用。</p><p>据悉，为妥善处理农村生活污水，茅箭区按“五统一”（统一设计、统一工艺、统一管理、统一考核、统一保障）要求，随湾就片建设微动力、无动力小型化农村污水处理设施，新建的28座一体式、202户分户式“四件套”污水治理设施基本完工。</p><p><strong>牲畜集中养肥水“减肥”排</strong><br>&nbsp;</p><p>走进茅塔乡廖家村集中安置小区，只见绿柳掩映民房，场院整洁干净。虽然不少村民养猪，但村里闻不到臭味、看不到污水。</p><p>该小区共安置村民42户。过去每家每户在房屋旁边建猪舍，平时家里的剩饭剩菜直接喂猪。因廖家村紧邻茅塔河，从猪舍外溢的污水，既污染村庄环境，又影响河流水质。</p><p>该村结合茅塔河小流域综合治理工作要求，以满足村民对美好生活的向往为落脚点，在小区一角配套建设畜禽散养“专区”，供村民集中养殖畜禽。同时，区政府筹措资金46万元，为“专区”配套建设了一座畜禽养殖废水处理站。</p><p>“通过干湿分离机，将干粪、湿粪分离。干粪经厌氧堆肥发酵，可作肥料。湿粪经畜禽养殖废水处理站处理后，流进下游生活污水处理设施，再次进行处理。”山鼎环保科技股份有限公司运营经理饶镇介绍，养殖废水经过两次处理后，可实现达标排放。</p><p>截污减污治污，茅塔乡实现“肥水不外流”。</p><p>记者在廖家村生态脱氮沟示范段看到，110余亩耕地靠近河渠一方，铺设有一条长260米、宽2米、深1.5米的脱氮沟。</p><p>茅箭区农业农村局局长庹文芳介绍，脱氮沟里的滤料由砾石、腐殖土等混合组成，能有效消减地下潜流硝酸盐，最大限度避免氮磷流入茅塔河流域，确保“水不乱流、肥不乱跑、泥不下山”。目前，茅塔河流域已经建成10个脱氮沟示范点。这些脱氮沟，对农业面源污染中的硝酸盐去除率达75%以上，靶向治污成效显著。</p><p>道路整洁，花草绕房；水清岸绿、鱼翔浅底；美丽乡村，生活和美……生态环境的改善，引来大批游客。今年清明节小长假期间，茅箭区油菜花节在廖家村举行，吸引游客纷至沓来，为乡村旅游发展注入了无限生机活力。</p>	\N	十堰是南水北调中线工程核心水源区。高标准治理好农村生活污水，对全面推进乡...	2024-05-13 03:41:40	\N	\N	\N	\N	\N	\N	\N	\N
26	\N	\N	茅箭区：“河长制”厚植“高颜值”生态底色	2024-05-13 03:41:18	<p>&nbsp;</p><p>“这里山水秀美，景色宜人，水清澈见底，真是舒心养眼！”初春时节，市民刘民富一早就沿着十堰市茅箭区南部山区马赛路骑行，途经营子村桃花湖时，对湖面旖旎风光赞叹不已。</p><p>一湖好水，既是对茅箭绿色生态的赞誉，也是当地“河长制”实施以来带来的显著变化。近年来，该区立足茅塔河小流域综合治理，围绕水资源保护、水污染防治、水环境改善、水生态修复等主要任务，全面开展“碧水保卫战”攻坚行动。明确区级河湖长13名、乡级河湖长44名、村级河湖长56名，三级河长体系全覆盖、全面履职，构建了横向到边、纵向到底的河湖管护网，“河长制”带来河长治，全区所有河流实现“水清、岸绿、河畅、景美”的“高颜值”，厚植了美丽茅箭生态底色。</p><p>汇聚合力，共同呵护源头活水。2月29日，一场春雨过后，茅箭区东城经济开发区鸳鸯村村民瞿天民沿着泗河自发开展灾害巡查，并对沿途发现的垃圾进行清理。在茅箭，像瞿天民这样自发开展河流管护志愿服务的热心群众不在少数。在当地茅塔河流域沿线，经常能看到他们的身影，他们中有老党员、有个体工商户、有中小学生，作为该区治水护水的巡查员、宣传员、示范员，同“官方河长”一起，共同构建了茅箭“河长+”队伍，带动吸引越来越多的群众当起河湖治理的“编外”管护员、监督员，常态化开展“清河净滩”志愿服务活动，共同呵护源头活水，共享美好河湖生态。同时，该区建立“河湖长+法院院长+检察长+警长”协作机制，充分发挥行政各方力量在辖区河湖保护中的监督作用，推动“河长+检察长”“河长+警长”等协作机制，共同守护碧水清流。</p><p>智慧治河，构建保护新格局。“报告指挥中心，无人机巡河发现山脚边有垃圾淤堵，请立即处理靠近。”日前，茅箭区水利和湖泊局工作人员正在采用无人机三维成像巡河模式，沿着茅塔河岸开展巡河，发现人工巡河死角，可立即同步在该区指挥中心通过大屏幕航拍画面进行研判，确保第一时间得到有效处理，巡河效率大大提升。</p><p>近年来，该区先后建成31座水雨情和4座水库动态检测站，借助无人机等智能新技术，快速推进数字孪生流域、数字孪生水网、数字孪生水利工程等建设，对全区8条河流、44条支沟、4座水库、67座塘堰、39处农村饮水工程进行专业化、立体化、常态化、高效化水域巡查，推动巡河、治河、护河由单一式向复合型转变，为流域安全提供科学的决策支持和技术保障。通过全方位的河道管护，做到了问题早发现早处理。去年以来，该区河湖长及联系部门累计巡河3000余次，发现并整改问题400余个；排查辖区44条重点支沟，累计清理沉沙池（井）399座，清淤2914立方米；支沟巡查6700余人次，发现并整改风险隐患126处，河湖生态得到有效保障。</p><p>水清河畅，绘就美丽乡村新画卷。“近几年，茅箭南部山区山体水域环境不断改善，吸引了很多市民群众以及摄影爱好者来这里采风游玩。”“河长制”全面推行以来给乡村带来的新变化，该区赛管局营子村常住村民王显华看在眼里。</p><p>该区先后投入资金约5亿多元，实施马家河、茅塔河、泗河等河道综合治理，修复治理河流70Km。投资350万元，实施茅塔清泉水厂管网延伸工程，提高该区南部山区900余人饮水保障率；争取资金266万元，实施农村小型水利设施维修养护项目，加大39名村级管水员培训，聘请第三方科学配送药剂、滤料，对机电设备进行日常维护；投资1000万元，实施彭家坡小流域、莫家沟小流域和梨花坡生态清洁小流域综合治理项目，治理水土流失面积31.51km2；实施河干流及马家河下游水生态修复工程、王家村游园文化提档升级及马家河水文化EPC项目等，确保山更绿、水更清。</p><p>一泓碧水，是风景线，更是致富线。该区立足绿水青山，赋能旅游促发展，打造了一批景色宜人、社会效益经济效益双赢的涉河滨水项目，重点对马赛路、桃花湖、东沟红色景区等进行提质升级改造，打造出的田园观光、特色民宿、休闲康养、星空露营、农家采摘等精品旅游线路深受市民群众欢迎，为茅箭乡村旅游的高质量发展注入了新动能。</p><p>水环境治理的根本目标是改善人居环境、助力乡村振兴。在该区南部山区，当地把水资源综合治理与改厨改厕、污水处理等相结合，整合生活污水处理、村庄绿化美化靓化等各项资金，统筹生态环保、住建、农业农村、乡村振兴等部门，确保清水长流，推动农村人居环境综合提升。</p><p>以水为景，以景兴业。茅箭区因地制宜发展特色绿色生态产业，东沟村荣获2022年中国美丽休闲乡村荣誉称号，全区建成省级省级乡村振兴示范村9个，现有休闲农业示范园13个、网红乡村民宿15家、生态景区20余个，山水田园农旅文融合发展，催生了“共享经济”，实现绿色发展、群众增收的双赢局面。(通讯员 陈宣霖、韩苗）</p>	\N	茅箭区：“河长制”厚植“高颜值”生态底色	2024-05-13 03:41:18	\N	\N	\N	\N	\N	\N	\N	\N
72	\N	\N	吃在东沟	2024-05-14 01:56:26	\N	\N	这里的食材都是自家种植、新鲜 采摘的，每一道菜都蕴含着农人 的辛勤与热情，让你感受到家的温暖。 你不仅能品尝到地道的农家菜	2024-05-14 01:56:26	\N	\N	\N	\N	\N	\N	\N	\N
18	\N	\N	游在东沟	2024-05-13 03:20:47	\N	leyou-1-664187103139f326225825.jpg	东沟已形成集接受爱国教育、欣赏自然风光、体验农家风情，观摩新农村建设...	2024-05-13 03:20:48	\N	\N	\N	\N	\N	\N	\N	\N
45	\N	\N	红色文化	2024-05-14 01:23:18	\N	\N	革命战争时期，贺龙、王树声等老一辈革命家曾在此处留下了战斗的足迹，东沟也见证了许多英勇的斗争和牺牲。	2024-05-14 01:23:18	\N	\N	\N	\N	\N	\N	\N	\N
11	\N	\N	云水方滩休闲度假区	2024-05-13 03:06:28	<p>云水方滩休闲度假区</p>	1-66e492db8e891308378902.png	\N	2024-09-13 19:30:35	\N	\N	\N	\N	\N	\N	\N	\N
93	\N	\N	黄龙壹号生态园	2024-05-15 05:43:29	<p>黄龙壹号生态园</p>	huang-long-yi-hao-sheng-tai-yuan-66e494b71e294498991394.jpg	黄龙壹号生态园	2024-09-13 19:38:31	\N	\N	\N	\N	\N	\N	\N	\N
41	\N	\N	飞机出行	2024-05-13 09:47:36	<p>乘坐飞机至十堰武当山机场，搭乘网约车至东沟景区游客服务中心或乘坐公共交通。&nbsp;</p><p>公交路线：搭乘机场公共快线2号线至东环路出口站，换乘97路至东风铸造厂站，换乘26路至东风铸造二厂站，换乘66路至茅塔念情谷站。</p>	plane-green-6641e1b8db9b3769167378.png	\N	2024-05-13 09:47:36	\N	\N	\N	\N	\N	\N	\N	\N
43	\N	\N	客车出行	2024-05-13 09:49:24	<p>乘坐客运大巴至十堰客运中心站，搭乘网约车至东沟景区游客服务中心或乘坐公共交通。 公交路线：搭乘9路/658路至至东风铸造二厂站，换乘66路至茅塔念情谷站。</p>	bus-green-6641e224e128b620672102.png	\N	2024-05-13 09:49:24	\N	\N	\N	\N	\N	\N	\N	\N
42	\N	\N	火车出行	2024-05-13 09:48:56	<p>乘坐高铁到达十堰东站或十堰站，搭乘网约车至东沟景区游客服务中心或乘坐公共交通。&nbsp;</p><p>公交路线：&nbsp;</p><p>1.从十堰东站乘坐96路至太和医院站，换乘9路至东风铸造二厂站，换乘66路至茅塔念情谷站。</p><p>&nbsp;2.从十堰站乘坐2路/202路/205路至东风铸造二厂站，换乘66路至茅塔念情谷站。</p>	train-green-6641e20966279692078075.png	\N	2024-05-13 09:48:57	\N	\N	\N	\N	\N	\N	\N	\N
101	\N	\N	中原突围鄂西北历史纪念馆	2024-05-15 05:51:33	<p>&nbsp;</p><p>　　中原突围鄂西北历史纪念馆，位于茅塔乡东沟村均郧房县委县政府旧址，该址建于明清时期，是开明乡绅周宗裔的祖宅。纪念馆内主要由党史陈列室、茅箭区国防教育展示厅、电教厅等展厅构成。这些展厅通过图片、文物和多媒体等形式，生动地展示了中原突围鄂西北革命斗争的历史。</p><p>&nbsp;</p><figure class="image"><img src="/images/664714aae1113-QQ截图20240517162409.png"></figure><p>&nbsp;</p><p>　　1931年6月，贺龙率红三军创建武当山革命根据地，并移师房县途经茅塔乡东沟村。在这里，他们打土豪、分田地，积极发展革命队伍，为新民主主义革命在鄂西北地区的发展做出了重要贡献。</p><p>　　1946年，王树声率中原突围南路部队在东沟村建立了鄂西北第三军分区、均郧房县委县政府、县大队革命政权。时任均郧房县委书记朱正传、县长胡恪恭等，率领突围官兵，依靠东沟群众，坚持武装斗争，牵制了数十倍于己的国民党军队。在同年底的战斗中，朱正传等100余名官兵英勇牺牲，胡恪恭也身负重伤，均郧房县委、县政府随之迁址。</p><p>　　1946年9月，王树声率部转战东沟，把鄂西北作战指挥中心设在泰山庙，开始了紧张而有序的工作，先后配合三地委、中心县委创建了官山区、白浪区、茅塔河区等。</p><p>&nbsp;</p><figure class="image"><img src="/images/664714bee4e1e-240514053743.jpg"></figure><p>&nbsp;</p><p>　　作为十堰市“青少年爱国主义教育基地”、茅箭区青少年“德育教育基地”，以及位于十堰城区唯一的未成年人思想道德教育基地，东沟爱国主义教育基地在推动青少年教育和乡村振兴方面发挥着重要作用。</p><p>　　东沟爱国主义教育基地充分利用这些红色资源，通过建设红色展馆、规划红色路线等方式，系统梳理、挖掘、提炼区域内的红色文化、知青文化、生态文化、移民文化和森工文化。在这里，游客可以参观到保存完好的明清古建筑，这些建筑不仅是历史的见证，也承载着丰富的红色文化内涵。同时，基地还收集了许多珍贵的革命历史文物，如大刀、长矛、枪支等，以及大量的图片展览和文字介绍，生动地再现了当年的烽火岁月和英雄故事。</p><p>&nbsp;</p><figure class="image"><img src="/images/664714d75d459-36d323e3cd2385fd374b7091636e210a.jpg"></figure><p>&nbsp;</p><figure class="image"><img src="/images/664714ea58eb3-53b1920757f6a93d13daaf57e2fe5be8.jpg"></figure><p>&nbsp;</p>	leyou-slider-1-6642c0f0e95ff915268162-66444d65600ef012849063-1-66448937469fb884675197-1-66455eca88e28337918555.jpg	\N	2024-05-16 01:18:02	\N	\N	\N	\N	\N	\N	\N	\N
66	\N	\N	土猪肉炖萝卜	2024-05-14 01:51:19	\N	chizai-7-6642c39816dee626604583.jpg	俗话说：“冬吃萝卜夏吃姜”。一到冬天就想起萝卜炖肉了，土猪肉的香浓，吸满肉汁萝卜的绵软，既美味又养生。一家人团坐在一起，温暖幸福萦绕心头。	2024-05-14 01:51:20	\N	\N	\N	\N	\N	\N	\N	\N
44	\N	\N	自驾出行	2024-05-13 09:49:48	<p>十堰——东沟景区游客服务中心</p><p>导航至“东沟景区游客服务中心”道路名：茅箭区-东沟路。</p>	car-green-6641e23d5adbc457346214.png	\N	2024-05-13 09:49:49	\N	\N	\N	\N	\N	\N	\N	\N
49	\N	\N	东沟历史	2024-05-14 01:28:14	\N	\N	东沟拥有悠久的农耕文明，《尚书.牧誓》记载，茅箭古称西土八国中的“髳国”，明代韩弼、清代贾洪诏均有《十堰春耕》的诗...	2024-05-14 01:28:14	\N	\N	\N	\N	\N	\N	\N	\N
69	\N	\N	东沟干货	2024-05-14 01:53:03	<p>　　东沟干货，来自于农户手工制作的干笋、红薯干、果干、干菜等，来自于淳朴的大地来自于淳朴的农民，虽然朴素却带着童年，带着乡土与思念。</p><figure class="image"><img src="/images/6646b4cfe46dd-63b03d8a93c7ab3c58539ee03407d480.jpg"></figure><p>&nbsp;</p><figure class="image"><img src="/images/6646b45cddd83-f612c37131946614714e24c4f402f20c.jpg"></figure>	leyou-slider4-2-6642c4005b0f9928350216.jpg	东沟干货，来自于农户手工制作的干笋、红薯干、果干、干菜等	2024-05-14 01:53:04	\N	\N	\N	\N	\N	\N	\N	\N
67	\N	\N	美食	2024-05-14 01:51:31	\N	chizai-8-6642c3a39ecf7018003760.jpg	\N	2024-05-14 01:51:31	\N	\N	\N	\N	\N	\N	\N	\N
53	\N	\N	湖北脱贫攻坚先进集体	2024-05-14 01:34:24	\N	honor-4-6642bfa0a33f6372870420.jpg	湖北脱贫攻坚先进集体	2024-05-14 01:34:24	\N	\N	\N	\N	\N	\N	\N	\N
52	\N	\N	湖北省廉政教育基地	2024-05-14 01:34:10	\N	honor-3-6642bf928d7cc515304617.jpg	湖北省廉政教育基地	2024-05-14 01:34:10	\N	\N	\N	\N	\N	\N	\N	\N
51	\N	\N	湖北省爱国主义教育基地	2024-05-14 01:33:55	\N	honor-2-6642bf83e3165911927641.jpg	\N	2024-05-14 01:33:55	\N	\N	\N	\N	\N	\N	\N	\N
50	\N	\N	全国生态文化村	2024-05-14 01:33:37	\N	honor-1-6642bf724480b871153665.jpg	\N	2024-05-14 01:33:38	\N	\N	\N	\N	\N	\N	\N	\N
61	\N	\N	野生猕猴桃	2024-05-14 01:50:06	\N	chizai-2-6642c34f513a6940761446.jpg	\N	2024-05-14 01:50:07	\N	\N	\N	\N	\N	\N	\N	\N
62	\N	\N	家常腊肉	2024-05-14 01:50:21	\N	chizai-3-6642c35e063d8153396802.jpg	腊肉是指肉经腌制后再经过烘烤(或日光下曝晒)的过程所成的加工品。防腐能力强，能延长保存时间，并增添特有的风味，这是与咸肉的主要区别。过去腊肉都是在农历腊月(12月)加工，故称腊肉。	2024-05-14 01:50:22	\N	\N	\N	\N	\N	\N	\N	\N
64	\N	\N	熏香肠腊肉	2024-05-14 01:50:53	\N	chizai-5-6642c37d91931360787532.jpg	东沟腊味，别具风情！腊味顾名思意为农历腊月腌制的肉制品。而东沟的熏香肠腊肉在湖北可谓一绝！	2024-05-14 01:50:53	\N	\N	\N	\N	\N	\N	\N	\N
65	\N	\N	土鸡火锅	2024-05-14 01:51:06	\N	chizai-6-6642c38a7ad9c957355598.jpg	冷冷的天让人特别想吃火锅，鲜烫香的滋味在嘴里不停打转。毫不夸张地说，东沟土鸡锅无论从外观、颜色，还是从味道、营养上来比较都是更胜一筹。	2024-05-14 01:51:06	\N	\N	\N	\N	\N	\N	\N	\N
8	\N	\N	红色基地 革命记忆	2024-05-13 00:59:02	\N	1ge-ming-ji-yi920-x-1074-1-6644b194ceed9343888971.jpg	Revolutionary Memory of the Red Base	2024-05-15 12:59:00	\N	\N	\N	\N	\N	\N	\N	\N
7	\N	\N	秦巴古驿 文化传承	2024-05-13 00:58:11	\N	2wen-hua-chuan-cheng1920-x-1074-1-6644b19e4375f301566418.jpg	Inheritance of Qinba Ancient Post Culture	2024-05-15 12:59:10	\N	\N	\N	\N	\N	\N	\N	\N
13	\N	\N	云上牡丹园	2024-05-13 03:08:38	<p>&nbsp;</p><p>　　云上牡丹园位于十堰市茅箭区茅塔乡东沟村二组，海拔600米。</p><p>　　因每逢小雨，满山云雾缭绕，故而得名“云上牡丹园”。</p><p>　　园区面积达100多亩，种植有各类牡丹共计6万余株。园内牡丹花色丰富，包括粉色、红色、白色和紫色等，争奇斗艳，为游客带来绝佳的视觉体验。</p><p>&nbsp;</p><figure class="image"><img src="/images/6646b88ca5cf5-65128fde684487954518d62109c525e3.jpg"></figure><p>&nbsp;</p><figure class="image"><img src="/images/6646b892b128b-2e168ed52873625e417c0a530cfd24a6.jpg"></figure><p>&nbsp;</p><p>　　逛完云上牡丹园，还可以去云上微民宿住上一晚。云上微民宿建在海拔600米的悬崖边，群山环抱，花海环绕，白天推窗可见美丽风景，夜晚抬头仰望璀璨星空。</p><p>　　云上牡丹园通常在每年的4月初至5月初开放，具体时间根据当年的气候和花期而定。</p><p><br><img src="/images/6646b897b28a8-faa1fa3e8c8b3b8bfd8e11de9de0ba26.jpg"></p><p>&nbsp;</p>	jingqu-3-6641843749354398759863.jpg	\N	2024-05-13 03:08:39	\N	\N	\N	\N	\N	\N	\N	\N
80	\N	\N	草木染水彩图	2024-05-15 03:37:36	<p>　　草木染以渐变、水彩图案为主，用中式写意的手法传达着古朴淡雅的意蕴，以蓝白二色为主调。扎染服饰，质地舒适健康，色泽清淡雅致，适合各种场合穿着。寓教于乐，亲手制作一件草木染作品，一定会让你成就感满满。 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</p>	qq-jie-tu20240515114416-6644302dbbdc7349333804.jpg	草木染以渐变、水彩图案为主，用中式写意的手法传达着古朴淡雅的意蕴，以蓝白二色为主调。	2024-05-15 03:46:53	\N	\N	\N	\N	\N	\N	\N	\N
87	\N	\N	丹荷聚农家乐	2024-05-15 05:21:53	\N	leyou-slider3-2-6642c2cb50f19892772311-66444a2c07129942647299.jpg	久在樊笼里，复得返自然，与山野的邂逅是一场美妙的旅行	2024-05-15 05:37:48	\N	\N	\N	\N	\N	\N	\N	\N
85	\N	\N	龙泉寺	2024-05-15 04:21:43	<p>龙泉寺</p>	long-quan-si1-66e494cf71440501191736.jpeg	龙泉寺	2024-09-13 19:38:55	\N	\N	\N	\N	\N	\N	\N	\N
14	\N	\N	念情谷—猕猴园	2024-05-13 03:09:22	<p>&nbsp;</p><p>　　念情谷猕猴园位于十堰市茅箭区茅塔乡东沟村。</p><p>　　念情谷的名字的由来，还有一段可歌可泣的爱情故事，1943年，朱正传与妻子易齐荇结成革命伴侣，为党的事业，夫妻分隔两地战斗。1946年时任均郧房县委书记的朱正传及38名战士，为掩护部队转移，在此牺牲。直到1986年，湖北省十堰市在搜集整理地方党史时，易齐荇才知道朱正传牺牲在十堰。此后，她一有时间就会来十堰东沟纪念自己的丈夫。易齐荇在朱正传烈士牺牲后没有再嫁，他们也没有留下后代。两人的红色爱情故事感动着当地村民，后来，东沟人就把朱正传烈士为革命洒下热血牺牲的这片山谷命名为“念情谷”。</p><p>&nbsp;</p><figure class="image"><img src="/images/6646b9931c6b1-4ca5a6b0f68ad7b92dbd68fb8e74f8f9.jpg"></figure><p>&nbsp;</p><figure class="image"><img src="/images/6646b998af6c1-5d32c5d90f4940f6a78707766e88fb43.jpg"></figure><p>&nbsp;</p><p>　　而如今的念情谷由于东沟生态环境的保护，吸引了大量游客前来休闲游玩，被一起吸引而来的还有来自深山的野生猕猴。如今猕猴园内现有野生猕猴近500只，在猴群管理上主要采取人工看护式管理模式，尽可能不干涉猴群发展，猕猴本就灵活聪慧，生活在自然山林内的猕猴则更加机敏，悬崖绝壁上下攀跃自如。</p><p>　　园内有登山游步道、猕猴互动平台、观景亭、景观桥等设施，自然风貌与人造景观交相辉映。</p><p>&nbsp;</p><figure class="image"><img src="/images/6646b99dbf983-57c7f2991bafddb276509818dc2d6ee8.jpg"></figure><p>&nbsp;</p><figure class="image"><img src="/images/6646b9a49034b-dd1cc15540b574c50d5f0125e65b7338.jpg"></figure><p><br>&nbsp;</p>	jingqu-4-66418462a1751250179579.jpg	\N	2024-05-13 03:09:22	\N	\N	\N	\N	\N	\N	\N	\N
75	\N	\N	东沟烈士陵园	2024-05-14 04:37:00	<p>&nbsp;</p><p>　　东沟村烈士陵园是为了缅怀在革命斗争中牺牲的先烈而建立的。特别是在1946年10月，王树声率部及均郧房县总队与国民党地方团进行激战，为掩护部队转移，均郧房县委书记朱正传及38名战士在此牺牲，他们中最大的31岁，最小的只有18岁，甚至还有很多人连名字都没来的及留下。</p><p>&nbsp;</p><figure class="image"><img src="/images/664437e4eb225-c851042925372b41add2be92e741e000.jpg"></figure><p>&nbsp;</p><p>　　陵园的建设历程</p><p>　　初始建设：1999年8月，为了集中安葬烈士，将5名分散安葬在山坡丛林中的烈士墓迁移至东沟村二组，新建了东沟革命烈士墓群，占地面积为500平方米。</p><p>　　道路改扩建：2005年，对通往东沟烈士陵园的道路进行了改扩建，提高了陵园的可达性。</p><p>　　全面修建：2011年，由十堰市政园林管理局捐资，对陵园进行了全面的修建。新建的陵园位于原东沟村革命烈士墓左侧，占地面积扩大至6000多平方米，总投资达到80余万元。陵园主要由纪念广场、烈士碑亭和浮雕墙组成。</p><p>　　烈士迁入：2022年9月22日，十堰市茅箭区在东沟烈士陵园纪念广场举行零散烈士墓集中迁葬入园仪式。155座零散烈士墓，迁葬至东沟烈士陵园。其中，可以确定姓名的有19位。</p><p>&nbsp;</p><figure class="image"><img src="/images/6644380914c83-03968a702214e9520058d80d345170ac.jpg"></figure><p>&nbsp;</p><p>　　浩气存天地，忠魂归陵园!</p><p>　　东沟烈士陵园不仅是对革命先烈的缅怀之地，也是进行红色教育和爱国主义教育的重要场所。每年清明节前后，前往东沟烈士陵园悼念烈士的游客络绎不绝。此外，十堰各组织、党支部等也会在此开展主题党日活动，激发党员的爱国热情。</p><p>　　朱正传是江苏常州人，毕业于天津南开附中。1943年，朱正传与妻子易齐荇结成革命伴侣，为党的事业，夫妻分隔两地战斗。直到1986年，湖北省十堰市在搜集整理地方党史时，易齐荇才知道朱正传牺牲在十堰。此后，她一有时间就会来十堰东沟纪念自己的丈夫。易齐荇在朱正传烈士牺牲后没有再嫁，他们也没有留下后代。两人的红色爱情故事感动着当地村民，后来，东沟人就把朱正传烈士为革命洒下热血牺牲的这片山谷命名为“念情谷”。</p><p>　　杜鹃花海象征革命烈士化身。在东沟村革命烈士战斗过的山岭有一片杜鹃花海，100余亩，均属野生，每年4至5月盛开，呈现出山花烂漫，宛如仙境的自然风光。其颜色鲜艳夺目，象征着革命烈士的滴滴鲜血，染红了东沟的山野。来此瞻仰的游客在享受自然风光的同时，被这里的红军遗物、红色故事、红色文化所熏陶教育，深受启迪，弘扬革命先烈的英雄精神，珍惜今天的幸福生活。</p>	fbbcc4a4bb56b3165c6f7a69029c1194-1-6644963b8e6d4890672557-66455ed225ece527495417.jpg	\N	2024-05-16 01:18:10	\N	\N	\N	\N	\N	\N	\N	\N
102	\N	\N	文明村	2024-05-15 06:27:51	\N	qq-jie-tu20240515142453-664455e77acbc319318084.jpg	\N	2024-05-15 06:27:51	\N	\N	\N	\N	\N	\N	\N	\N
73	\N	\N	鄂西北农耕博物园	2024-05-14 04:34:02	<p>　　茅箭系西周时期记载&nbsp;"西土八国”中的古髻国所在地，历史悠久、沉淀深厚，农耕文化源远流长。</p><p>　　苞茅缩酒、农桑茶乐 等与十堰地名文化、古人 描绘的鄂西北农耕文化融汇一体，有独特的鄂西北 地域文化研究价值。</p><p><br>&nbsp;</p>	wei-xin-tu-pian-20240517101845-6646d3e2e7015982377683.png	\N	2024-05-17 03:49:54	\N	\N	\N	\N	\N	\N	\N	\N
76	\N	\N	国字号荣誉！茅箭区东沟村获评2022年中国美丽休闲乡村	2024-05-14 06:42:10	<p><br>　　2022年11月14日，记者从十堰市文旅局获悉，农业农村部公布了中国美丽休闲乡村推介结果，推介北京市门头沟区妙峰山镇炭厂村等255个乡村为2022年中国美丽休闲乡村，湖北共有10地上榜。十堰市仅茅箭区茅塔乡东沟村上榜其中，成功获评2022年中国美丽休闲乡村。<br><img src="http://news.cjn.cn/hbpd_19912/sy_19931/202211/W020221116362984854574.png" alt="点击查看高清原图"><br><br>　　快来一起看看，东沟村有多美吧！<br>&nbsp;</p><figure class="image"><img src="http://news.cjn.cn/hbpd_19912/sy_19931/202211/W020221116362984869820.png" alt="点击查看高清原图"></figure><p><br><br>&nbsp;</p><figure class="image"><img src="http://news.cjn.cn/hbpd_19912/sy_19931/202211/W020221116362984911738.png" alt="点击查看高清原图"></figure><p><br><br>　　近年来，东沟村紧紧依托红色旅游资源和生态旅游资源优势，秉承“把农村当成景区来建设，把农居当成旅馆来改造，把农田山水当作旅游基地来经营”的理念，通过红色文化“搭台”、生态旅游“唱戏”，推进农文旅深度融合，走出了一条以生态农业为“基”、美丽田园为“韵”、特色民宿为“形”、红色文化为“魂”的发展新路子，成为远近闻名的“网红村”，先后荣获十堰市生态家园示范村、十堰市乡村振兴示范村、全国生态文化村等称号。<br>&nbsp;</p><figure class="image"><img src="http://news.cjn.cn/hbpd_19912/sy_19931/202211/W020221116362984976416.png" alt="点击查看高清原图"></figure><p><br><br>&nbsp;</p><figure class="image"><img src="http://news.cjn.cn/hbpd_19912/sy_19931/202211/W020221116362985020373.png" alt="点击查看高清原图"></figure><p><br><br>　　2021年，全村实现经济总收入800余万元，农民人均纯收入16234元，村集体经济收入达68万元，90％的村民吃上了“旅游饭”。（记者 周仑）<br><img src="http://news.cjn.cn/hbpd_19912/sy_19931/202211/W020221116362985049500.png" alt="点击查看高清原图"><br>&nbsp;</p>	\N	国字号荣誉！茅箭区东沟村获评2022年中国美丽休闲乡村	2024-05-14 06:42:10	\N	\N	\N	\N	\N	\N	\N	\N
24	\N	\N	【乡村振兴看湖北】十堰茅箭：农文旅融合打造中国美丽休闲乡村	2024-05-13 03:40:32	<p>央广网十堰11月18日消息（记者朱娜 通讯员万月 余文涛）农村变景区、农园变游园、农居变旅店、农产品变旅游商品……在湖北省十堰市茅箭区，初冬时节的东沟村静谧祥和，别有一番韵味，吸引了不少周边游客前来打卡参观。</p><figure class="image"><img src="http://inews.gtimg.com/newsapp_bt/0/15437315308/1000" alt="图片"></figure><p>东沟村（央广网发 王鹏 摄）</p><figure class="image"><img src="http://inews.gtimg.com/newsapp_bt/0/15437315313/1000" alt="图片"></figure><p>东沟猕猴园（央广网发 王鹏 摄）</p><figure class="image"><img src="http://inews.gtimg.com/newsapp_bt/0/15437315316/1000" alt="图片"></figure><p>东沟村建筑与周边环境融为一体（央广网发 王鹏 摄）</p><p>不久前，东沟村成功入选“2022年中国美丽休闲乡村”。近年来，茅箭区紧紧依托红色旅游资源和生态旅游资源优势，秉承“把农村当成景区来建设，把农居当成旅馆来改造，把农田山水当作旅游基地来经营”的理念，通过红色文化搭台、生态旅游唱戏，推进农文旅深度融合，走出了一条以生态农业为“基”、美丽田园为“韵”、特色民宿为“形”、红色文化为“魂”的发展新路子，茅箭区东沟村、营子村已成为远近闻名的“网红村”。</p><figure class="image"><img src="http://inews.gtimg.com/newsapp_bt/0/15437315318/1000" alt="图片"></figure><p>东沟村樱花茶园（央广网发 茅箭区融媒体中心供图）</p><figure class="image"><img src="http://inews.gtimg.com/newsapp_bt/0/15437315319/641" alt="图片"></figure><p>东沟桃源人家民宿（央广网发 王鹏 摄）</p>	\N	在湖北省十堰市茅箭区，初冬时节的东沟村静谧祥和，别有一番韵味，吸引了不少周边游客前来打卡参观	2024-05-13 03:40:32	\N	\N	\N	\N	\N	\N	\N	\N
103	\N	\N	荆楚最美乡村	2024-05-15 06:28:33	\N	qq-jie-tu20240515142523-6644561156af1077203298.jpg	\N	2024-05-15 06:28:33	\N	\N	\N	\N	\N	\N	\N	\N
77	\N	\N	东沟荣誉	2024-05-15 00:09:24	\N	wei-xin-tu-pian-20240515220613-6644c1eeab0b7804422608.png	\N	2024-05-15 14:08:46	\N	\N	\N	\N	\N	\N	\N	\N
78	\N	\N	陶艺	2024-05-15 03:34:39	<p>　　陶艺是一种承载着深厚文化底蕴的艺术形式，它的体验过程充满了创造性和挑战性，陶艺不仅仅是泥土和水的结合，更是文化和思想的交流，它不仅涉及到制作技术，还包含了对陶瓷文化的理解和感悟。</p><p>　　在体验过程中，参与者可以从基础的泥料制备开始，经过成型、上釉、烧制等一系列步骤，最终制作出属于自己的陶瓷作品。这一过程不仅可以提高动手能力，还能增强感知力、创造力和观察力。</p>	wei-xin-tu-pian-20240515215941-6644c2f69b030771910899.jpg	陶艺是一种承载着深厚文化底蕴的艺术形式	2024-05-15 14:13:10	\N	\N	\N	\N	\N	\N	\N	\N
89	\N	\N	山顶美宿	2024-05-15 05:26:58	<p>&nbsp;</p><p><strong>游览推荐&nbsp;</strong></p><p>山顶美宿位于东沟景区境内，</p><p>藏于一片山野之中，</p><p>附近有茶园，田野阡陌、依山傍水、离嚣绝尘，</p><p>有着闲云野鹤般的自在生活。</p><p>&nbsp;</p><figure class="image"><img src="/images/6646b31fce596-514e7b69e4fcadd738e33df2ee092e30.jpg"></figure><p>&nbsp;</p><p><strong>久在樊笼 复得返桃源</strong>&nbsp;</p><p>久在樊笼里，复得返自然，</p><p>与山野的邂逅是一场美妙的旅行，</p><p>山顶美宿四周密林层层，迎面便是茶山，</p><p>茶香幽幽、山色旖旎。</p><p>一杯茶，或一壶酒，</p><p>在山顶美宿各自取乐，轻松暇意。</p><p>青山绿水相迎，享乡野之趣</p><p>&nbsp;</p><p><strong>享闲暇之乐&nbsp;</strong></p><p>来山顶美宿享受栖于山林的闲暇之乐。</p><p>没有复杂的陈设与格局，四合小院随意又大方，清净又自在。</p><p>一本书、一壶茶是最好的消遣。</p><p>就在山上住上几日，打发些琐碎的时光。</p><p>&nbsp;</p><figure class="image"><img src="/images/6646b408b7598-d7257c177e2e45d06b75b40726d67038.jpg"></figure><p><br>&nbsp;</p>	leyou-slider3-3-6642c2ed1b85f272204344-664447a2e86cf179697173.jpg	山顶美宿位于东沟景区境内，藏于一片山野之中，附近有茶园，田野阡陌、依山傍水、离嚣绝尘有着闲云野鹤般的自在生活。	2024-05-15 05:26:58	\N	\N	\N	\N	\N	\N	\N	\N
88	\N	\N	张家小院农家乐	2024-05-15 05:22:47	\N	wei-xin-jie-tu-20240515224106-6644c9c624993226020582.png	久在樊笼里，复得返自然，与山野的邂逅是一场美妙的旅行	2024-05-15 14:42:14	\N	\N	\N	\N	\N	\N	\N	\N
83	\N	\N	东沟烈士陵园	2024-05-15 03:43:22	<p>　　东沟村烈士陵园是为了缅怀在革命斗争中牺牲的先烈而建立的。特别是在1946年10月，王树声率部及均郧房县总队与国民党地方团进行激战，为掩护部队转移，均郧房县委书记朱正传及38名战士在此牺牲，他们中最大的31岁，最小的只有18岁，甚至还有很多人连名字都没来的及留下。</p><p>&nbsp;</p><figure class="image"><img src="/images/664437e4eb225-c851042925372b41add2be92e741e000.jpg"></figure><p>&nbsp;</p><p>　　陵园的建设历程</p><p>　　初始建设：1999年8月，为了集中安葬烈士，将5名分散安葬在山坡丛林中的烈士墓迁移至东沟村二组，新建了东沟革命烈士墓群，占地面积为500平方米。</p><p>　　道路改扩建：2005年，对通往东沟烈士陵园的道路进行了改扩建，提高了陵园的可达性。</p><p>　　全面修建：2011年，由十堰市政园林管理局捐资，对陵园进行了全面的修建。新建的陵园位于原东沟村革命烈士墓左侧，占地面积扩大至6000多平方米，总投资达到80余万元。陵园主要由纪念广场、烈士碑亭和浮雕墙组成。</p><p>　　烈士迁入：2022年9月22日，十堰市茅箭区在东沟烈士陵园纪念广场举行零散烈士墓集中迁葬入园仪式。155座零散烈士墓，迁葬至东沟烈士陵园。其中，可以确定姓名的有19位。</p><p>&nbsp;</p><figure class="image"><img src="/images/6644380914c83-03968a702214e9520058d80d345170ac.jpg"></figure><p>&nbsp;</p><p>　　浩气存天地，忠魂归陵园!</p><p>　　东沟烈士陵园不仅是对革命先烈的缅怀之地，也是进行红色教育和爱国主义教育的重要场所。每年清明节前后，前往东沟烈士陵园悼念烈士的游客络绎不绝。此外，十堰各组织、党支部等也会在此开展主题党日活动，激发党员的爱国热情。</p><p>　　朱正传是江苏常州人，毕业于天津南开附中。1943年，朱正传与妻子易齐荇结成革命伴侣，为党的事业，夫妻分隔两地战斗。直到1986年，湖北省十堰市在搜集整理地方党史时，易齐荇才知道朱正传牺牲在十堰。此后，她一有时间就会来十堰东沟纪念自己的丈夫。易齐荇在朱正传烈士牺牲后没有再嫁，他们也没有留下后代。两人的红色爱情故事感动着当地村民，后来，东沟人就把朱正传烈士为革命洒下热血牺牲的这片山谷命名为“念情谷”。</p><p>　　杜鹃花海象征革命烈士化身。在东沟村革命烈士战斗过的山岭有一片杜鹃花海，100余亩，均属野生，每年4至5月盛开，呈现出山花烂漫，宛如仙境的自然风光。其颜色鲜艳夺目，象征着革命烈士的滴滴鲜血，染红了东沟的山野。来此瞻仰的游客在享受自然风光的同时，被这里的红军遗物、红色故事、红色文化所熏陶教育，深受启迪，弘扬革命先烈的英雄精神，珍惜今天的幸福生活。</p>	zoujin-slider2-2-6642bdaace339580569263-66442f5a6ce1e806618835.jpg	东沟烈士陵园不仅是对革命先烈的缅怀之地，也是进行红色教育和爱国主义教育的重要场所。	2024-05-15 03:43:22	\N	\N	\N	\N	\N	\N	\N	\N
82	\N	\N	爱莲说	2024-05-15 03:42:26	<p>　　东沟位于茅箭区茅塔乡境内，是一个有着优秀革命传统的历史圣地。1931年，贺龙率领红军曾转战于此，1946年，王树声率中原解放军南路突围部队在鄂西北创建革命根据地，在东沟先后设立了鄂西北第三军分区、均郧房县委、县政府革命政权。时任县委书记的朱正传、县长胡恪恭等率领100多名突围官兵依靠东沟群众坚持了近半年的武装斗争，牵制了数十倍于己的国民党军队，县委书记朱正传等数十名战士在战斗中壮烈牺牲。</p><p>&nbsp;</p><figure class="image"><img src="/images/6646b0baa741e-20b80a1a43646e42d0b084f4fb192155.jpg"></figure><p>&nbsp;</p><p>　　教育基地旧址现存完好的近2000平方米的明清时期房屋建筑，以及收集较为齐全的当年革命者使用的武器(大刀、长矛、枪支等)已成为十分珍贵的革命历史文物，是对十堰城区未成年人和市民进行革命传统教育的真实"教本”和主要阵地。茅塔乡东沟村先后被列为十堰市“青少年爱国主义教育基地”，茅箭区青少年“德育教育基地”，同时也是位于十堰城区唯一的未成年人思想道德教育基地。</p><p>&nbsp;</p><figure class="image"><img src="/images/6646b0cd92568-a4a50a1713204ee492248043fdda2a4b.jpg"></figure><p>&nbsp;</p><p>　　为告慰先烈，启迪后人，发扬老区人民的爱国精神、艰苦创业精神，近几年来，各级高度重视，并投入了大量物资，对基地进行恢复性建设加固，完善相关配套设施，该教育基地自建立以来，先后接纳十堰城区大中专院校、中小学师生和广大市民近3万人次，到茅塔乡接受革命传统教育，欣赏天然风光，体验农家风情，收到了经济效益、社会效益双丰收同提高的目的，促进了一方经济社会的健康快速发展。</p><p>&nbsp;</p><figure class="image"><img src="/images/6646b0dda1f76-cb5cda45d5d1b7d3c0cd22cd5681a6c6.jpg"></figure><p>&nbsp;</p><p>　　1994年，茅箭区教委将均郧房县委、县政府旧址定为全区中小学德育教育基地;</p><p>　　1997年10月，东沟旧址被十堰市委宣传部正式确定为全市十三个“爱国主义教育基地”之一，十堰城区仅此一家，市、区、乡对该基地建设高度重视，多方筹措物资对教育基地着手建设;</p><p>　　1998年7月，在时任市委副书记赵斌的亲切关怀和市、区有关单位的大力支持下，修通了通往基地的公路，后又经过几次改造升级，达到乡村四级公路标准;</p><p>　　1999年8月，在相关的支持下，在东沟村二组修建了朱正传等5位革命烈士墓碑;</p><p>　　2001年，组织专业人员对基地旧址部分房屋进行了保护性建设加固;</p><p>　　2002年投资25万元对基地旧址进行了修缮。</p><p>　　2005年3月15日，茅箭区档案局(馆)被列入“茅箭区爱国主义教育基地”，协助办好东沟爱国主义教育基地。</p><p>　　2010年8月1日，在市政园林管理局捐建下，“爱国主义教育基地”正式开工。</p><p>　　2015年被评为湖北省国防教育基地</p><p>　　2015年-2019年先后被省人民政府、省纪委挂牌湖北省爱国主义教育基地、湖北省廉政教育基地</p><p>　　2019年被评为“省级文物保护单位”</p><p>　　2021年对鄂西北革命历史纪念馆进行了修复，恢复了原有马房、并对展馆重新布展。</p><p>　　2022年对教育基地道路及周边环境进行整治提档升级，并对教育基地学堂进行修复性建设。</p>	wei-xin-tu-pian-20240515215934-6644c20c5ccd7848713229.jpg	中原突围鄂西北历史纪念馆除了展现老一辈革命家曾在此处留下的战斗足迹，廉洁教育也是纪念馆的一大亮点...	2024-05-15 14:09:16	\N	\N	\N	\N	\N	\N	\N	\N
81	\N	\N	纪念馆	2024-05-15 03:41:27	<p>&nbsp;</p><p>　中原突围鄂西北历史纪念馆，位于茅塔乡东沟村均郧房县委县政府旧址，该址建于明清时期，是开明乡绅周宗裔的祖宅。纪念馆内主要由党史陈列室、茅箭区国防教育展示厅、电教厅等展厅构成。这些展厅通过图片、文物和多媒体等形式，生动地展示了中原突围鄂西北革命斗争的历史。</p><p>&nbsp;</p><figure class="image"><img src="/images/664714aae1113-QQ截图20240517162409.png"></figure><p>&nbsp;</p><p>　　1931年6月，贺龙率红三军创建武当山革命根据地，并移师房县途经茅塔乡东沟村。在这里，他们打土豪、分田地，积极发展革命队伍，为新民主主义革命在鄂西北地区的发展做出了重要贡献。</p><p>　　1946年，王树声率中原突围南路部队在东沟村建立了鄂西北第三军分区、均郧房县委县政府、县大队革命政权。时任均郧房县委书记朱正传、县长胡恪恭等，率领突围官兵，依靠东沟群众，坚持武装斗争，牵制了数十倍于己的国民党军队。在同年底的战斗中，朱正传等100余名官兵英勇牺牲，胡恪恭也身负重伤，均郧房县委、县政府随之迁址。</p><p>　　1946年9月，王树声率部转战东沟，把鄂西北作战指挥中心设在泰山庙，开始了紧张而有序的工作，先后配合三地委、中心县委创建了官山区、白浪区、茅塔河区等。</p><p>&nbsp;</p><figure class="image"><img src="/images/664714bee4e1e-240514053743.jpg"></figure><p>&nbsp;</p><p>　　作为十堰市“青少年爱国主义教育基地”、茅箭区青少年“德育教育基地”，以及位于十堰城区唯一的未成年人思想道德教育基地，东沟爱国主义教育基地在推动青少年教育和乡村振兴方面发挥着重要作用。</p><p>　　东沟爱国主义教育基地充分利用这些红色资源，通过建设红色展馆、规划红色路线等方式，系统梳理、挖掘、提炼区域内的红色文化、知青文化、生态文化、移民文化和森工文化。在这里，游客可以参观到保存完好的明清古建筑，这些建筑不仅是历史的见证，也承载着丰富的红色文化内涵。同时，基地还收集了许多珍贵的革命历史文物，如大刀、长矛、枪支等，以及大量的图片展览和文字介绍，生动地再现了当年的烽火岁月和英雄故事。</p><p>&nbsp;</p><figure class="image"><img src="/images/664714d75d459-36d323e3cd2385fd374b7091636e210a.jpg"></figure><p>&nbsp;</p><figure class="image"><img src="/images/664714ea58eb3-53b1920757f6a93d13daaf57e2fe5be8.jpg"></figure>	zoujin-slider2-1-6642bd7a0e33c626902600-66442ee74274c434933944.jpg	中原突围鄂西北历史纪念馆，位于茅塔乡东沟村均郧房县委县政府旧址，该址建于明清时期，是开明乡绅周宗裔的祖宅	2024-05-15 03:41:27	\N	\N	\N	\N	\N	\N	\N	\N
79	\N	\N	草木染	2024-05-15 03:36:27	<p>　　草木染，又称植物染，是一种利用植物材料对织物进行染色的传统手工艺技术。它源自史前时期，至今已有数千年的历史。在新石器时代，祖先们就在采集过程中发现了许多花果植物的根、茎、皮、叶等可以提取汁液，用作染色。经过不断的实践与探索，古人掌握了运用植物汁液来染色的方法，创造了丰富多彩的染色技术，使得草木染成为中国古代主流的染色技法。</p>	wei-xin-tu-pian-20240515215948-6644c2e4017d9506662085.jpg	草木染，又称植物染，是一种利用植物材料对织物进行染色的传统手工艺技术	2024-05-15 14:12:52	\N	\N	\N	\N	\N	\N	\N	\N
91	\N	\N	桃源人家	2024-05-15 05:28:48	<p><strong>&nbsp;</strong></p><p><strong>&nbsp; 游览推荐&nbsp;</strong></p><p>&nbsp; &nbsp;桃源人家位于茅箭区茅塔乡东沟村，</p><p>&nbsp; &nbsp;提供餐饮及住宿。</p><p>&nbsp; &nbsp;可同时接纳120人用餐，房间干净整洁，配套设施齐全</p><p>&nbsp;</p><figure class="image"><img src="/images/6646ae771c85c-69ccc0d79c0abd7a21aef37354d9866e.jpg"></figure><p>&nbsp;</p><p><strong>&nbsp;住宿环境&nbsp;</strong></p><p>拥有多档次客房满足你的需求</p><p>房间舒适整洁，24小时热水、独立淋浴间等一应俱全。</p><p>&nbsp;</p><figure class="image"><img src="/images/6646ae8a95703-f9f14e78031e2d84a3bacf57af458261.jpg"></figure><p>&nbsp;</p><p><strong>&nbsp;地道美食&nbsp;</strong></p><p>这里的食材全部都是自家的出产之物，</p><p>自家菜园里新鲜的蔬菜水果、土鸡用最原始的食材，加以用心创意的</p><p>烹调方式，成就了别具特色的农家味道！</p><p>&nbsp;</p><figure class="image"><img src="/images/6646ae9dab6d5-637382292aeacff74e1ff00e75946766.jpg"></figure>	leyou-slider3-2-6642c2cb50f19892772311-66444a2c07129942647299-66455f60070e0061021328.jpg	桃源人家民宿自2016年6月18日建成运营以来，已累计接待游客超十万人...	2024-05-16 01:20:32	\N	\N	\N	\N	\N	\N	\N	\N
95	\N	\N	回龙村荷花盛开	2024-05-15 05:44:06	<p>回龙村荷花盛开</p>	hui-long-cun-he-hua-sheng-kai-66e4947140dcd574942165.jpg	回龙村荷花盛开	2024-09-13 19:37:21	\N	\N	\N	\N	\N	\N	\N	\N
100	\N	\N	云水方滩休闲度假区	2024-05-15 05:46:01	<p>云水方滩休闲度假区</p>	yun-shui-fang-tan-du-he-hua-lang-kang-yang-lu-you-du-jia-qu-jian-shan-cha-she-wai-guan-66e49391eb54c947037806.jpg	云水方滩休闲度假区	2024-09-13 19:33:37	\N	\N	\N	\N	\N	\N	\N	\N
97	\N	\N	人民公园	2024-05-15 05:45:02	<p>人民公园</p>	ren-min-gong-yuan1-66e4941b91b8c551356676.jpg	人民公园	2024-09-13 19:35:55	\N	\N	\N	\N	\N	\N	\N	\N
84	\N	\N	白马山	2024-05-15 04:11:47	<p>白马山</p>	bai-ma-shan-rui-zhi-min-1-66e494f327114653823154.jpg	白马山	2024-09-13 19:39:31	\N	\N	\N	\N	\N	\N	\N	\N
39	\N	\N	东沟简介	2024-05-13 09:33:56	\N	\N	东沟村位于十堰市茅箭区茅塔乡，属于湖北赛武当国家级自然保护区试验区和缓冲区范围，面积11.4平方公里，距十堰市城区13公里。东沟村地处山区，自然资源丰富，是全区公益林、用材林、茶叶种植基地的重要区域。森林覆盖率高达92%，在生态环境保护中具有重要战略地位。\r\n东沟村也是红色革命老区村，曾在革命战争时期设立过鄂西北第三军分区、均郧房县中心县委、县政府、县总队等重要机构。贺龙、王树声等老一辈革命家曾在这里战斗过，留下了丰富的红色历史遗迹。\r\n除了红色旅游资源外，东沟村依托其良好的生态资源，大力发展生态游。村庄内形成了“高山植松杉、低山种绿茶、旱地种林果、平坝蔬菜花”的立体生态格局。此外，景区内的念情谷景点内还引来了深山猕猴与游客零距离嬉戏玩耍，为游客提供了丰富的自然体验。以桃源人家为代表的特色民宿，正成为当下游客首选的旅行方式，民宿综合体内的咖啡馆、民俗布染坊、陶艺坊、国学堂等，为从城市而来的游客提供了更多的选择。\r\n经过20多年的持续打造，总投资近10亿元，东沟村正逐渐成为一个集革命历史、红色文化、民俗文化和自然风光于一体的综合性旅游景区。东沟村将持续加大景区建设力度，进一步加强旅游宣传推广力度，扩大东沟红色旅游的知名度和影响力，努力争创“4A”级景区和湖北旅游名村	2024-05-13 09:33:56	\N	\N	\N	\N	\N	\N	\N	\N
111	\N	\N	赓续红色血脉 弘扬革命精神	2024-05-16 01:52:03	<p>&nbsp; &nbsp; &nbsp; &nbsp;一个有希望的民族不能没有英雄，一个有前途的国家不能没有先锋。每当危难时刻总有英雄挺身而出，这正体现了中华民族以爱国主义为核心的团结统一、爱好和平、勤劳勇敢、自强不息的伟大民族精神。</p><p>&nbsp;</p><figure class="image"><img src="/images/6645669180b45-W020240401590807304842.png"></figure><p>&nbsp;</p><p>&nbsp;</p><p><strong>追寻红色记忆 感悟红色情怀</strong></p><p>&nbsp; &nbsp; &nbsp; &nbsp;3月29日，东方远志学校组织部分师生来到东沟爱国主义教育基地，开展十堰市东方远志中学“志教融合”爱国主义教育志愿服务实践活动。通过向革命先烈敬献鲜花、瞻仰革命烈士纪念馆、聆听英烈事迹、重温红色历史、体验农耕劳动等形式，表达对革命先烈的崇高敬意和深切哀思。宣传红色革命文化，激发同学们的爱国热情和家乡归属感。把家乡的红色革命文化引进校园、走进课堂、走进青少年心灵。</p><p>&nbsp;</p><p><img src="/images/664566988a880-W020240401590807640640.png"></p><p>&nbsp;</p><p>&nbsp; &nbsp; &nbsp; &nbsp;古朴小院斑驳外墙犹如被打上了深深的历史烙印，诉说着当年共产党人金戈铁马、运筹帷幄的战斗诗篇。师生们参观院内的展陈，重温历史，缅怀先烈，仿佛回到了那个战火纷飞的年代，感受到革命先烈在敌后战场上隐姓埋名、英勇奋战的铁骨豪情。</p><p>&nbsp;</p><p><img src="/images/6645669e33193-W020240401590807814405.png"></p><p>&nbsp;</p><p><strong>缅怀先烈 致敬英雄</strong></p><p>&nbsp; &nbsp; &nbsp; &nbsp;师生向为国捐躯的伟大革命英雄们献上花圈，并默哀鞠躬致敬，深切缅怀革命烈士。朱正传、王树声、刘子久、罗厚福、文敏生……这些鲜活的名字和他们伟大的事迹，我们始终铭记在心。我们致敬他们的牺牲与奉献，也感恩今天幸福安宁的生活。唯愿英雄不再离去，家国平安。</p><p>&nbsp; &nbsp; &nbsp; &nbsp;活动朴素庄严、肃然有序，是一堂生动深刻的爱国主义教育课，使同学们懂得了生命的意义和幸福生活的来之不易。此次活动分为线上线下两部分，除参与到实践活动中的部分师生外，该校高中部其余师生在校与活动现场连线直播，进行在线联学。</p><p>&nbsp;</p><p><img src="/images/664566a496b13-W020240401590808039700.png"></p><p>&nbsp;</p><p>&nbsp; &nbsp; &nbsp; &nbsp;东方远志中学将持续完善劳动教育的课程体系建设，让学生在公益劳动、志愿服务中树立劳动意识，实践服务技能，增强社会责任感，实现以劳树德、以劳增智、以劳强体、以劳育美的育人目标。以先辈革命历程为启示，传承红色基因，与革命烈士精神同频共振，珍惜当下美好生活，牢记使命担当，为实现中华民族伟大复兴的中国梦而奋斗。</p>	w020240401590807640640-1-664566c384f52592192237.png	——十堰市东方远志中学开展“志教融合”爱国主义教育志愿服务实践活动	2024-05-16 01:52:03	\N	\N	\N	\N	\N	\N	\N	\N
110	\N	\N	追寻红色足迹 传承红色基因——丹江口市税务局开展青年干部红色教育活动	2024-05-16 01:50:29	<p>&nbsp; &nbsp; &nbsp; &nbsp;为强化春训工作，提升春训效果，4月7日，丹江口市税务局组织青年干部来到东沟爱国主义教育基地开展红色主题教育活动，以“实景导学、军事演学、专题联学”等形式，开展“沉浸式”学习体验活动，以“红色精神”赓续奋进力量。</p><p><strong>革命圣地导学 赓续红色血脉</strong></p><p>&nbsp; &nbsp; &nbsp; &nbsp;在中原突围鄂西北历史纪念馆，跟随导游的讲解，干部职工思绪追溯到1946年。在茅塔乡东沟村建立的鄂西北第三军分区、均郧房县委县政府，经历武装斗争后，时任均郧房县委书记朱正传等100余名官兵英勇牺牲，中国新民主主义革命在这里留下了浓墨重彩的一笔。随后观看的纪录片《为国捐躯的县委书记——朱正传》，让青年干部无不为之动容，纷纷赞叹革命先驱为革命胜利流血牺牲的大无畏精神。</p><p>&nbsp;</p><figure class="image"><img src="/images/664565a68f3bb-3.jpg"></figure><p>&nbsp;</p><p>&nbsp; &nbsp; &nbsp; &nbsp;“如果信仰有颜色，那一定是中国红，长在红旗下，生在春风里，目光所至皆华夏……”在中原突围鄂西北历史纪念馆前，身着税务蓝的青年干部有序排成方阵队形，齐声朗诵红色诗歌《如果信仰有颜色》，铿锵有力、激情澎湃的朗诵响彻山谷，振奋心灵，激发了青年干部向英烈看齐，努力做共产主义接班人的决心和士气。</p><p>&nbsp;</p><figure class="image"><img src="/images/664565a6c69c4-4.jpg"></figure><p>&nbsp;</p><p><strong>户外军事演学 锻造税务铁军</strong></p><p>&nbsp; &nbsp; &nbsp; &nbsp;“敬礼！”在户外拓展场地，随着教官的一声令下，青年干部整齐划一地向左转、向右转、向后转、敬礼，步调整齐统一，眼神坚毅无比，动作规范到位，阳光下，五分钟的军姿站立训练，让青年干部内心更增添了一股军人般的韧性和刚毅。</p><p>&nbsp;</p><figure class="image"><img src="/images/664565a6e3b24-5.jpg"></figure><p>&nbsp; &nbsp;</p><p>&nbsp; &nbsp; “向国旗致敬”环节，青年干部面对面分成两纵队，将一面曾在天安门广场前升起过的5米*3.3米的五星红旗依次小心传递，并纷纷行最庄严的注目礼。“齐心写大字”环节，青年干部十人一组拉扯一根巨型毛笔，从四面八方用力，以均衡的力道在红纸上齐心写下“兴”“税”“强”“国”四字，以书写表达“为国聚财，为民收税”的初心使命，引导青年干部心往一处想、劲往一处使，全力推进税收事业发展。</p><p>&nbsp;</p><figure class="image"><img src="/images/664565a6a7dca-6.jpg"></figure><p>&nbsp;</p><p><br><strong>主题交流联学 坚定初心使命</strong></p><p>&nbsp; &nbsp; &nbsp; &nbsp;在东沟爱国主义教育基地的会议室内，五个青年理论学习小组共同学习了《习近平专题摘编》5-6章、习近平《论党的青年工作》、习近平总书记关于税收工作的重要论述及省税务局党委《关于在全省税务系统广泛开展向卢东同志学习活动的决定》等文件，3名分别来自政务岗、业务岗、分局岗的青年理论学习小组成员结合自身岗位实际，就参观学习内容、更好落实工作职责，推动丹江税务蓬勃发展谈个人体会和收获。</p><p>&nbsp;</p><figure class="image"><img src="/images/664565a7082bd-7.jpg"></figure><p>&nbsp; &nbsp;</p><p>&nbsp; &nbsp; “当五星红旗在我们手中传递的时候，我想到了革命先烈为了新中国的成立，抛头颅，洒热血的场景，这一刻，我深深地体会到了‘传承’两字的份量，它代表着一份责任感和使命感”。青年干部黄琰在学习交流中分享道。</p><p>&nbsp; &nbsp; &nbsp; &nbsp;通过本次活动，青年干部进一步坚定了理想信念，明确了初心使命，精神得到充分洗礼，思想得到再次升华。大家纷纷表示，将大力弘扬革命先烈不畏艰险、报效祖国的革命精神，担负传承红色基因的强大使命，以奋发有为的姿态展现税务铁军的担当作为，为丹江税务蓬勃发展贡献青春力量。</p>	4-1-66456665a9f42978511123.jpg	追寻红色足迹 传承红色基因——丹江口市税务局开展青年干部红色教育活动	2024-05-16 01:50:29	\N	\N	\N	\N	\N	\N	\N	\N
114	\N	\N	启迪思想 锤炼本领：十堰经开区消防参观红色爱国主义教育基地	2024-05-16 02:00:56	<p>&nbsp;</p><p>&nbsp; &nbsp; &nbsp; &nbsp;12月6日，十堰经开区消防救援大队深入东沟爱国主义教育基地参观学习，重温抗战历史、缅怀先烈功绩，继承革命传统、赓续红色血脉，教育引导全体消防救援人员感悟信仰之力、汲取奋进力量、坚守初心使命。</p><p>&nbsp; &nbsp; &nbsp; &nbsp;“豫鄂陕革命根据地的烈士永垂不朽”，陈列馆门口的15个大字，将全体消防救援人员的思绪带回了那个年代。在讲解员的引导下，展厅里的一幅幅图片，一件件物品无不诉说着一个又一个革命故事，历史的一幕好像在眼前浮现一般。</p><p>&nbsp; &nbsp; &nbsp; &nbsp;在展馆内，全体消防员重温入党誓词，面对鲜红的党旗，庄严地向党宣誓，一句句掷地有声的誓言，表达了党员们为共产主义奋斗终身、永葆党员先进性的坚定信念。</p><p>&nbsp; &nbsp; &nbsp; &nbsp;“正是革命先烈们的顽强拼搏、浴血奋战换来了我们如今安宁幸福的生活，我们始终铭记、倍加珍惜。我们要沿着革命先辈的足迹，自觉担负起新时代新征程的使命任务，为实现全面建成社会主义现代化强国的目标去拼搏、去奋斗，献出自己的全部力量”。一位消防员在分享感悟时说道。</p><p>&nbsp; &nbsp; &nbsp; &nbsp;参观结束后，全体消防救援人员纷纷表示，此次参观见学活动，进一步坚定了理想信念、加强了党性锻炼、提升了思想境界。在今后的工作中，要继承和发扬革命先烈舍小家、为大家的家国情怀，苦练救援本领，坚决扛起“新担当、新突破、新作为”重大责任使命，切实把学习实践成效转化为推动消防救援事业发展的能力和水平，为“平安经开”建设作出新贡献。</p><p>&nbsp;</p><figure class="image"><img src="/images/664568c598fbf-5.jpg"></figure><p><br>&nbsp;</p>	5-664568d83f8c3639348921.jpg	12月6日，十堰经开区消防救援大队深入东沟爱国主义教育基地参观学习，重温抗战历史、缅怀先烈功绩	2024-05-16 02:00:56	\N	\N	\N	\N	\N	\N	\N	\N
113	\N	\N	竹山县公检中心：参观红色教育基地 淬炼党性践初心	2024-05-16 01:59:54	<p>&nbsp;</p><p>&nbsp; &nbsp; &nbsp; &nbsp;在“三八”妇女节到来之际，竹山县公共检验检测中心妇委会结合实际，组织全体干部职工来到十堰市茅箭区茅塔乡东沟红色爱国主义教育基地，开展以“传承红色基因 永葆清廉本色”为主题教育活动，接受革命传统教育和爱国主义教育。</p><p>&nbsp; &nbsp; &nbsp; &nbsp;走进东沟红色革命老区，来到中原突围鄂西北历史纪念馆，在讲解员的细心讲述下，大家仔细聆听革命先烈的英雄事迹，深入了解东沟革命的光辉历史。一幅幅珍贵的照片，一件件陈旧的物件，仿佛在讲述着一个个动人的故事，大家频频驻足参观。在电教厅里，大家集体观看了《情映东沟红》教育片，深刻感悟了发生在七十多年前那个战火纷飞年代朱正传烈士与其忠诚伴侣易齐荇同志令人动容的红色爱情故事。</p><p>&nbsp; &nbsp; &nbsp; &nbsp;聆听了革命先烈的英雄事迹，大家纷纷表示，此次参观红色教育基地活动，深刻认识到革命胜利来之不易，是一次灵魂的洗礼、思想的提升、精神的补钙。在缅怀革命先烈丰功伟绩的同时，感悟学习革命先烈坚定的理想信念，进一步增强了自身的责任感和使命感，要铭记历史，继承先烈的革命精神，坚定共产主义理想信念，弘扬优良革命传统，锤炼过硬党性，担当作为，履职尽责，以更饱满的热情为推动全县质量检验检测工作高质量发展作出贡献。（刘波 陆平）</p><figure class="image"><img src="/images/6645688747806-3.png"></figure><figure class="image"><img src="/images/664568872e281-4.png"></figure><p><img src="http://jyjc.shiyan.gov.cn/xsqdt/202403/W020240313574222610628.png" alt=""> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;参观红色教育基地 淬炼党性践初心</p>	3-6645689a3ec6d110547480.png	参观红色教育基地 淬炼党性践初心	2024-05-16 01:59:54	\N	\N	\N	\N	\N	\N	\N	\N
109	\N	\N	强化党性教育 润养清风正气 | 产投集团赴东沟红色廉政教育基地开展党纪学习教育	2024-05-16 01:45:15	<p>&nbsp; &nbsp; &nbsp; &nbsp;为扎实推进党纪学习教育，进一步推进廉洁教育常态化长效化，4月18日，产投集团组织全体党员赴东沟红色廉政教育基地开展党性教育主题实践活动，通过参观学习，重温革命历史、缅怀革命先烈，感悟革命先辈初心，进一步严明纪律规矩，汲取奋进力量。</p><p>&nbsp; &nbsp; &nbsp; &nbsp;青山脚下埋忠骨，英烈精神代代传。在初晴的阳光中，东沟烈士陵园烈士纪念碑巍峨耸立，集团全体党员干部面向革命烈士纪念碑列队肃立，重温入党誓词，深切缅怀革命先烈英勇顽强、不怕牺牲、无私奉献的革命精神。</p><p>&nbsp; &nbsp; &nbsp; &nbsp;怀着崇高的敬意，大家走进东沟红色廉政教育基地，环顾墙上那些斑驳脱落的印记，通过一张张历史珍贵照片和文字资料，大家直观的了解到党在不同时期、不同阶段开展廉政建设的坚定决心和有力举措，对严守纪律、廉洁自律有了更加坚定的意志。</p><p>&nbsp; &nbsp; &nbsp; &nbsp;“英勇奋战的红色故事鼓舞人心，廉洁清正的纪律作风振奋人心”，下一步，产投集团将持之以恒综合运用党性教育、纪律教育、警示教育和廉洁文化教育等多种形式，切实将党纪学习教育延伸到“神经末梢”。</p><p>&nbsp;</p><figure class="image"><img src="/images/66456524e5105-1.png"></figure><figure class="image"><img src="/images/66456524ca9f4-2.png"></figure>	1-1-6645652b564d7332227522.png	产投集团赴东沟红色廉政教育基地开展党纪学习教育	2024-05-16 01:45:15	\N	\N	\N	\N	\N	\N	\N	\N
116	\N	\N	茅箭区发改局组织党员干部赴东沟开展党性教育活动	2024-05-16 02:20:07	<p>&nbsp;</p><p>&nbsp; &nbsp; &nbsp; 10月11日上午，茅箭区发改局组织党员干部赴东沟教育基地开展党性教育活动，感悟初心使命，汲取前行力量，进一步坚定信仰，永葆党的先进性。</p><p>&nbsp; &nbsp; &nbsp; 在东沟革命烈士陵园，茅箭区发改系统党员干部重温入党誓词，向革命先烈敬献花篮。通过缅怀革命英烈，大家仿佛回到了那段令人难忘的革命岁月，感受老一辈共产党人顽强拼搏、不怕牺牲的革命意志。在讲解员的引导下，大家又参观了东沟爱国主义教育基地，全面了解东沟村的红色历史以及军民鱼水情深的感人事迹。通过瞻仰革命前辈的照片、武器装备、生活用品等历史文物，全体党员干部再一次接受心灵的洗礼，进一步激发大家在新时代担当初心使命的思想自觉和政治自觉。随后，该局党员干部赴东沟流域治理项目现场参观学习。</p><p>&nbsp; &nbsp; &nbsp; 此次活动，旨在让全体党员干部深刻学习领会东沟革命烈士艰苦卓绝的奋斗精神和坚贞不渝的共产主义信仰，坚定立足岗位，担当作为的理想信念。大家纷纷表示，一定要牢记革命历史，大力弘扬“东沟精神”，勇挑重担、百折不挠、坚守初心，不断继承和发扬革命先烈顽强拼搏的革命精神和奋斗不息的革命意志。</p><p>&nbsp; &nbsp; &nbsp; 下一步，该局将继续把党性教育同能力作风建设结合起来，坚持学思用贯通、知信行统一，以敢于担当作为的良好精神风貌和感恩奋进、拼搏赶超的实际行动，全力推动茅箭经济高质量发展。（通讯员 张正华）</p><p>&nbsp;</p>	\N	10月11日上午，茅箭区发改局组织党员干部赴东沟教育基地开展党性教育活动，	2024-05-16 02:20:07	\N	\N	\N	\N	\N	\N	\N	\N
112	\N	\N	郧阳区科协开展“三八”妇女节红色教育活动	2024-05-16 01:58:35	<p>    为进一步弘扬党的优良传统，激励引导广大干部职工铭记党的奋斗历程，3月8日，在第114个“三八”国际妇女节来临之际，郧阳区科协组织全体干部职工奔赴东沟红色教育基地，开展参观学习活动。</p><p>&nbsp;</p><p><img src="/images/6645683797850-1.png"><img src="http://kx.shiyan.gov.cn/dwgk/gzdt/202403/W020240312627238672947.png" alt=""></p><p>    </p><p>&nbsp; &nbsp; &nbsp; &nbsp;沿着红色基地的石板路前行，历史纪念馆的全貌也逐渐显现，在讲解员的带领下，大家依次参观了烈士事迹、廉洁文化、家风文化以及南水北调工程等多个板块的内容，通过一篇篇详实的历史记载、一幅幅泛黄的老照片、一件件令人震撼的物件，大家近距离感受到了革命先烈们舍我其谁的拼搏精神、不怕牺牲的奋斗精神和求真务实的探索精神。</p><p>&nbsp;</p><figure class="image"><img src="/images/664568418a197-2.png"></figure><p><img src="http://kx.shiyan.gov.cn/dwgk/gzdt/202403/W020240312627254148229.png" alt="">   </p><p>&nbsp; &nbsp; &nbsp; 此次东沟红色教育基地之行，使党员干部们对党的性质和宗旨有了更深刻的认识，特别是聆听了女红军和女党员的英雄事迹，对当今妇女干部争做“巾帼”标兵、展现风采有了深刻的教育意义，进一步激发了党员干部立足岗位、甘于奉献的工作热情。</p>	1-6645684b97427651087592.png	为进一步弘扬党的优良传统，激励引导广大干部职工铭记党的奋斗历程，3月8日，	2024-05-16 01:58:35	\N	\N	\N	\N	\N	\N	\N	\N
118	\N	\N	茅箭区机关事务服务中心、茅箭区医疗保障局联合开展“重走红色之路，传承革命精神...	2024-05-16 02:31:59	<p>&nbsp;</p><p>&nbsp; &nbsp; &nbsp; 为庆祝建党102周年，引导党员干部增强党性观念，推动能力作风建设走深走实，6月28日上午，茅箭区机关事务服务中心机关党支部与茅箭区医疗保障局机关党支部前往东沟爱国主义教育基地、廉政教育基地参观研学，联合开展“重走红色之路，传承革命精神”“主题党日+”活动。</p><figure class="image"><img src="/images/664570096d530-1.jpg"></figure><p>&nbsp; &nbsp; &nbsp; 党员干部们先后来到廉政教育基地、革命文物陈列馆、党史学习教育展示厅等，参观历史文物，了解革命历史，接受心灵的洗礼。在东沟爱国主义教育基地，大家高举右手、紧握拳，面向鲜红的党旗，重温了入党誓词，重温入党时对党和人民作出的庄严承诺。</p><p>&nbsp; &nbsp; &nbsp; 通过此次“沉浸式”教育学习，党员干部接受了一次生动的爱国主义教育，大家纷纷表示，将进一步坚定理想信念，继承党的光荣传统和优良作风，知敬畏、存戒惧、守底线，持续转作风、提能力，为茅箭加快建设首善示范区添砖加瓦。</p><p><br>&nbsp;</p>	1-6645701fcb65c902468247.jpg	茅箭区机关事务服务中心、茅箭区医疗保障局联合开展“重走红色之路，传承革命精神...	2024-05-16 02:31:59	\N	\N	\N	\N	\N	\N	\N	\N
117	\N	\N	市科普教育基地开展社会主义核心价值观教育活动	2024-05-16 02:23:04	<p>&nbsp;</p><p>&nbsp; &nbsp; &nbsp; &nbsp; 6月28日，在“七一”即将到来之际，为弘扬社会主义核心价值观，进一步提升居民科学素质、文明素养和精神风貌，加强爱国主义教育，营造文明、和谐、团结、奋进的社区生活氛围，十堰市科协组织阳光社区党员群众一起走进十堰市科普教育基地——东沟爱国主义科普教育基地，开展社会主义核心价值观教育实践活动，接受革命传统教育和爱国主义教育。</p><p>&nbsp;</p><figure class="image"><img src="/images/66456e3b4523a-W020230630311043263610.png"></figure><figure class="image"><img src="/images/66456e41826fe-W020230629544753775213.png"></figure><p>&nbsp;</p><p>&nbsp; &nbsp; &nbsp; &nbsp;活动结束时，大家感慨良多，纷纷表示，现在的美好生活来之不易，是无数革命先烈用鲜血和生命换来的，要倍加珍惜。我们要继承和发扬革命先辈的光荣传统和优良作风，代代传承红色基因，努力在各自岗位中发光发热，为国家发展、社区建设贡献自己的一份力量。</p><p>&nbsp;</p>	w020230630311043263610-66456e089bc59254664265.png	市科普教育基地开展社会主义核心价值观教育活动	2024-05-16 02:23:04	\N	\N	\N	\N	\N	\N	\N	\N
120	\N	\N	初心永不忘，奋进正当时 ——市机关事务服务中心组织开展老干部春季参观学习	2024-05-16 02:34:45	<p>&nbsp;</p><p>&nbsp; &nbsp; &nbsp; 人间最美四月天。四月初的十堰，桃红柳绿，草长莺飞，处处洋溢着一派勃勃生机。为深入学习贯彻党的二十大精神，激励广大老同志传承红色基因、不忘初心使命，市机关事务服务中心组织机关十余名离退休老党员、老干部赴茅塔乡东沟村参观学习，瞻仰历史遗址，缅怀革命先烈，回顾光辉历程，接受了一次生动深刻的党性再教育。</p><p>&nbsp;</p><figure class="image"><img src="/images/664570b0ba0ae-5.jpg"></figure><p>图一：党组成员、副主任孙小玲同老干部们一起参观中原突围鄂西北历史纪念馆</p><p>&nbsp;</p><p>&nbsp; &nbsp; &nbsp; 4月7日上午，老干部们首先来到位于茅塔乡东沟村的中原突围鄂西北历史纪念馆参观，解放战争时期，这里曾是鄂西北第三军分区、均郧房县委县政府所在地。1946年6月，为粉碎蒋介石对中原解放军的围剿，第三军区司令员王树声率领中原突围南路部队建立了鄂西北根据地，东沟就是这块红色根据地的重要组成部分。在这块红色热土上，中原突围部队不屈不挠、浴血奋战，东沟人民用血肉之躯救护子弟兵、保护伤病员，军民团结一心、同仇敌忾，书写了一部荡气回肠、可歌可泣的革命英雄史。</p><p>&nbsp; &nbsp; &nbsp; 在纪念馆内，老同志们认真观看、仔细瞻仰烈士们的遗照、遗物、革命者当年使用过的武器，一幅幅生动的图片、一件件珍贵的革命历史文物，仿佛把大家带回到了那个烽火连天的斗争年代。退休老党员顾爱玲表示，自己曾多次来到东沟教育基地，每一次来都有新的感受。讲起当年的革命故事，她如数家珍，感慨不已“今天的幸福生活是烈士用生命换来的，来之不易，作为退休老党员，我们一定要倍加珍惜，离岗不离党、退休不褪色，感党恩、听党话，永远跟党走！”</p><p>&nbsp;</p><figure class="image"><img src="/images/664570b97d7e3-6.jpg"></figure><p>图二：老干部们参观东沟学堂廉洁文化教育基地</p><p>&nbsp;</p><p>&nbsp; &nbsp; &nbsp; 紧邻纪念馆的东沟学堂是茅箭区依托东沟红色资源，着力打造的新时代廉洁文化教育基地。学堂内展示的大量丰富翔实的图片和文字资料，从中国传统孝廉典故，到毛泽东等老一辈革命家的廉洁故事、家风家训，再到茅箭清廉家庭典型事迹、党员干部手写家书，浓缩了中国共产党一百年来从严治党的光辉历程，帮助老同志们全面了解党的反腐历史，在清廉文化的浓厚氛围中弘扬优良传统、筑牢理想信念。</p><p>&nbsp; &nbsp; &nbsp; 老同志们还参观了东沟桃源人家民宿，感受乡村民宿文化魅力，体验东沟产业发展、乡村振兴取得的丰硕成果。</p><p>&nbsp; &nbsp; &nbsp; 活动结束时，老干部们纷纷表示：这次实地参观学习是一场深刻的爱国主义思想洗礼。作为离退休老党员，尽管离开了工作岗位，但党员的身份没有变，要永远铭记党带领人民走过的光辉历程，继承和发扬革命光荣传统和优良作风，不忘初心使命，永葆党员本色，为新形势下机关事务高质量发展和十堰绿色低碳发展示范区建设发挥余热、贡献力量。（王静）<br>&nbsp;</p>	5-664570c55735a302354505.jpg	初心永不忘，奋进正当时 ——市机关事务服务中心组织开展老干部春季参观学习	2024-05-16 02:34:45	\N	\N	\N	\N	\N	\N	\N	\N
94	\N	\N	长河湾景区	2024-05-15 05:43:47	<p>长河湾景区</p>	zhang-he-wan-jing-qu-66e494957fe32510410356.jpg	长河湾景区	2024-09-13 19:37:57	\N	\N	\N	\N	\N	\N	\N	\N
96	\N	\N	四方山旅游区	2024-05-15 05:44:41	<p>四方山旅游区</p>	si-fang-shan1-66e49d887221d333921511.jpg	四方山旅游区	2024-09-13 20:16:08	\N	\N	\N	\N	\N	\N	\N	\N
29	\N	\N	产投集团赴东沟红色廉政教育基地开展党纪学习教育	2024-05-13 03:43:17	<p>为扎实推进党纪学习教育，进一步推进廉洁教育常态化长效化，2024年4月18日，产投集团组织全体党员赴东沟红色廉政教育基地开展党性教育主题实践活动，通过参观学习，重温革命历史、缅怀革命先烈，感悟革命先辈初心，进一步严明纪律规矩，汲取奋进力量。</p><p>青山脚下埋忠骨，英烈精神代代传。在初晴的阳光中，东沟烈士陵园烈士纪念碑巍峨耸立，集团全体党员干部面向革命烈士纪念碑列队肃立，重温入党誓词，深切缅怀革命先烈英勇顽强、不怕牺牲、无私奉献的革命精神。</p><p>怀着崇高的敬意，大家走进东沟红色廉政教育基地，环顾墙上那些斑驳脱落的印记，通过一张张历史珍贵照片和文字资料，大家直观的了解到党在不同时期、不同阶段开展廉政建设的坚定决心和有力举措，对严守纪律、廉洁自律有了更加坚定的意志。</p><p>“英勇奋战的红色故事鼓舞人心，廉洁清正的纪律作风振奋人心”，下一步，产投集团将持之以恒综合运用党性教育、纪律教育、警示教育和廉洁文化教育等多种形式，切实将党纪学习教育延伸到“神经末梢”。</p><p><img src="http://gzw.shiyan.gov.cn/djyd/dwgk/202404/W020240419617769129043.png" alt=""></p><p><img src="http://gzw.shiyan.gov.cn/djyd/dwgk/202404/W020240419617769539616.png" alt=""></p><p><br>&nbsp;</p>	news-2-66418c557a0b1820688374.jpg	为扎实推进党纪学习教育，进一步推进廉洁教育常态化长效化，	2024-05-13 03:43:17	\N	\N	\N	\N	\N	\N	\N	\N
71	\N	\N	陶艺体验及成品	2024-05-14 01:53:43	<p>　　东沟陶艺陶艺坊，是一个充满温馨和爱心的大家庭。我们的陶艺作品都是手工捏制，没有任何机器辅助。</p><figure class="image"><img src="/images/6646b29b0945b-0ac2a180e9a9ffddca03f62b7e9397d6.jpg"></figure><p>　　作品不仅是陶艺，更是一件件精美绝伦的艺术珍品!</p><p>　　艺海无涯，匠心致远，传承千年的陶瓷技艺与智慧，融入现代生活美学。感受泥巴的质感，释放创意的翅膀!</p><figure class="image"><img src="/images/6646b2a8a952c-167802191377007a8631c110c72b3e01.jpg"></figure><p>　　东沟陶艺陶艺坊为您提供一个不一样的创意空间。</p><p>　　在这里，你会看到不一样的自己。</p>	leyou-slider4-4-6642c43f4d3b1439814939.jpg	东沟陶艺陶艺坊，是一个充满温馨和爱心的大家庭	2024-05-14 01:54:07	\N	\N	\N	\N	\N	\N	\N	\N
115	\N	\N	市行政审批局：走进东沟学思想 坚定初心为人民	2024-05-16 02:19:16	<p>&nbsp;</p><p>&nbsp; &nbsp; &nbsp; 10月20日，市行政审批局组织机关干部在茅箭区东沟红色教育基地开展“踏寻红色足迹  坚定为民初心”主题书香机关创建活动。党员干部在庄严肃穆的烈士陵园重温入党誓词，缅怀革命先烈，学习英雄舍生忘死、无私奉献的事迹，实地开展习近平新时代中国特色社会主义思想学习，现场交流学习体会，以沉浸式阅读体验传承红色基因、学习革命精神，激发党员干部坚定理想信仰，砥砺初心使命。</p><p>&nbsp;</p><figure class="image"><img src="/images/66456d0e37a9b-W020231103379744783918.png"></figure><p><img src="http://zwfw.shiyan.gov.cn/ztzl/djwm/202311/W020231103379744783918.png" alt=""></p><p>&nbsp; &nbsp; &nbsp; 近年来，市行政审批局不断加强党员干部思想政治教育，坚持用习近平新时代中国特色社会主义思想武装头脑</p>	w020231103379744783918-66456d2448d10819133613.png	10月20日，市行政审批局组织机关干部在茅箭区东沟红色教育基地开展“踏寻红色足迹  坚定为	2024-05-16 02:19:16	\N	\N	\N	\N	\N	\N	\N	\N
90	\N	\N	蛙声十里	2024-05-15 05:28:10	<p><strong>&nbsp;</strong></p><p><strong>游览推荐</strong>&nbsp;</p><p>蛙声十里位于东沟村二组</p><p>对面则是荷塘月色，</p><p>这里远离喧嚣，泉水沏茶，推窗便望江南画。</p><p><img src="http://cyw-com.oss-cn-hangzhou.aliyuncs.com/shopx/156456270579/shopinfo/201908/2019080215351640.jpg" alt="">漫步蛙声十里，自然有移步异景的感受。</p><p>小桥流水，草木葱茏，<br>&nbsp;</p><p>庭前一张厚重的原木桌，几把精致的实木桌椅。</p><p>在此泡上一杯东沟茶，</p><p>芳香四溢，淡淡的木质香味混合着泥土的芬芳。</p><p>&nbsp;</p><figure class="image"><img src="/images/6646af8000f1b-4c6d6447c100efc7305f7ef3e2d9cc78.jpg"></figure><p>&nbsp;</p><p><strong>歇泊在蛙声十里</strong></p><p>这里有写意的山水、也有舒适的歇憩。</p><p>住惯了各种星级酒店，</p><p>住在蛙声十里感受田园生活也是一种新鲜的体验。</p><p>&nbsp;</p><figure class="image"><img src="/images/6646af987952b-a6d984f9d558075196a9b4f97a258c9c.jpg"></figure><p><strong>&nbsp;</strong></p><p><strong>雅致民宿，商务与休闲完美融合&nbsp;</strong></p><p>&nbsp; 在这里，我们为您打造了一个融合商务与休闲需求的会议室。</p><p>&nbsp; 宽敞的空间，舒适的布置，为您提供了一个完美的环境，</p><p>&nbsp; 无论是商务会议还是团队建设活动，</p><p>&nbsp; 都能满足您的需求。</p><p>&nbsp;</p><figure class="image"><img src="/images/6646afb9891ab-df0ee3d2afa6c8bcd1ebcbbdd2064367.jpg"></figure><p>&nbsp;</p><p>&nbsp;<strong>雪景如诗，让人心驰神往 </strong><img src="http://cyw-com.oss-cn-hangzhou.aliyuncs.com/shopx/156456270579/shopinfo/201908/2019080215425025.jpg" alt=""></p><p><img src="http://cyw-com.oss-cn-hangzhou.aliyuncs.com/shopx/156456270579/shopinfo/201908/2019080215445091.jpg" alt="">漫天飞舞的雪花，纷纷扬扬地铺满了大地，</p><p>仿佛一层厚厚的银色地毯。</p><p>枯树映衬下，雪景更显静谧、纯净，让人感受到冬日的浪漫与唯美。</p><p>雪天的寂静只为了更好地聆听内心的声音。</p><p>踩在厚厚的雪地上，感受到的是大自然的温暖拥抱。</p><p>目之所及，一片银装素裹，仿佛置身于一个纯净无暇的白色世界。</p>	leyou-slider3-1-6642c260394a7616312954-664447ea24287641645867.jpg	蛙声十里出自齐白石画作《蛙声十里出山泉》，是一家以青蛙为主题的亲子民宿综合体...	2024-05-15 05:28:10	\N	\N	\N	\N	\N	\N	\N	\N
63	\N	\N	东沟神仙叶凉粉	2024-05-14 01:50:36	<p>　　东沟神仙叶凉粉是用天然植物制作而成的凉粉，色泽呈绿色，口感润滑爽口，加入蒜末、花生碎、白糖、醋、辣椒油、酱油等一起搅拌均匀，酸辣开胃，让人神清气爽。</p><figure class="image"><img src="/images/6646a8a441a98-8f628c8b56f2cc4919631d0f06a08edc.jpg"></figure><p>　　神仙叶是分布在深山老林里的一种灌木，多长在背阴的山坡上，叶子像桑树叶，捏在手里粘粘的。也叫腐卑又称豆腐木、凉粉叶树、豆腐柴、豆腐叶、观音橘、神仙叶，神仙叶凉粉也有人叫神仙豆腐,分布：陕西、河南、湖北、湖南、四川、贵州、云南;野生，湖北分布在来凤,宣恩,咸丰,鹤峰,恩施,秭归,宜昌,兴山,神农架,房县,郧西。</p><figure class="image"><img src="/images/6646a8b21e278-c4f0eede0ae936916e362604bc6e618b.jpg"></figure><p>　　据《本草求原》《中国药植蓝图》记载，神仙叶有消暑、清热、凉血、解毒、降血压、减肥、消除关节疼痛等作用。在东沟，这种有着神仙叶之称的灌木非常多，清明一过，村民们将采回的新鲜叶子淘净、空干水。把新鲜的叶子放到盆中用开水烫匀(80度左右的水)。加几滴清油，掺凉水搅拌。双手反复揉搓，直使叶子和热水成为糊状。用纱布或细筛过滤盆中。放阴凉处，几小时后凝固。打成豆腐样的块状，放进清水里让漂着，即成凉粉。切成小条状，加入调料即可。</p><figure class="image"><img src="/images/6646a8be9062c-c93461f75d509474e972d9f1a09b13e0.jpg"></figure>	chizai-4-6642c36cbaf3f813874982.jpg	\N	2024-05-14 01:50:36	\N	\N	\N	\N	\N	\N	\N	\N
124	\N	\N	记者探访十堰茅塔乡东沟村：红色文化+绿色发展走出文旅扶贫路	2024-05-16 09:29:02	<p>&nbsp;</p><p>&nbsp; &nbsp; &nbsp; &nbsp;走进湖北十堰市茅箭区茅塔乡东沟村，森林环抱、鸟语花香，精致的民宿依地势而建；这里也曾经烽火连天、枪林弹雨，996位革命前辈长眠于此，世代述说英雄故事。近年来，东沟村以红色文化为依托，充分发挥自然资源优势，将红色文化的传承与绿色生态发展融合到一起，走出了一条文旅脱贫之路。</p><p>&nbsp; &nbsp; &nbsp; &nbsp;巍巍武当西麓的茅塔乡东沟村是一片战火洗礼过的红色热土，它地处均郧房三县交界，曾先后设立了鄂西北第三军分区、均郧房县委县政府、县总队。上世纪七八十年代，砍伐树木一度成为人均耕地面积不足0.3亩的东沟村村民养家糊口的主要收入来源。沉痛的代价唤醒了红色基因，时任村干部多次商议，考虑东沟保留着不少历史遗址，又是革命先烈战斗过的地方，有发展红色旅游的基础，经过考察调研，最终敲定了红色旅游带动乡村发展思路。</p><p><img src="/images/6645d1a8d756a-W020201028741735001408.jpg"></p><p>均郧房县委县政府旧址（张沛 摄）</p><p>&nbsp; &nbsp; &nbsp; &nbsp;乘着三农政策、扶持革命老区建设、精准扶贫等国家政策的东风，东沟村向全面小康的目标不断迈进。</p><p>&nbsp; &nbsp; &nbsp; &nbsp;东沟村坚持保护修缮与开发并举，对2000平方米革命遗址进行腾退、修复，修通进村公路，陆续建起革命烈士陵园、革命文物陈列馆、戏楼、东沟学堂等，持续建设完善红色旅游文化资源。</p><p><img src="/images/6645d1b0252fa-W020201028741735072056.jpg"></p><p>东沟村特色民宿（刘建维 摄）</p><p>&nbsp; &nbsp; &nbsp; &nbsp;秉承“把农村当成景区来建设，把农居当成旅馆来改造，把农田山水当作旅游基地来经营”的理念，东沟村引导村民改造、新建特色民居，使整个村庄更加古朴、美丽，旅游服务更加完善、周到。打造以生态种植养殖、农家餐饮住宿为支撑的旅游配套全产业，采用“公司+基地+农户”模式，建成生态茶园400亩，武当道茶公司定期协议收购茶园鲜叶；依势就地铺设茶园观赏步游道，打造参与性高、体验感强的观光茶园主题景观园区，推动茶产业、茶文化发展。</p><p><img src="/images/6645d1b4e7f5e-W020201028741735210980.jpg"></p><p>特色民宿 （刘建维 摄）</p><p><img src="/images/6645d1bf095a4-W020201028741737415240.jpg"></p><p>特色民宿（刘建维 摄）</p><p><img src="/images/6645d1c575672-W020201028741737451581.jpg"></p><p>“桃源人家”民宿（陈明 摄）</p><p>&nbsp; &nbsp; &nbsp; &nbsp;在这样一个静谧的乡村里，几处特色民宿格外亮眼。</p><p>&nbsp; &nbsp; &nbsp; &nbsp;在上海工作13年的王启迪，偶然来到东沟村游览，便爱上这里留了下来，在村里租了一栋房屋院落，办起了别具特色的“桃源人家”民宿，成为“东沟人”之后，又接连开办“蛙声十里”“休休堂”等亲子民宿，建起蓝染、陶艺等扶贫作坊。据了解，2016年6月营业至今，已累计接待游客超过十万人次。</p><p><img src="/images/6645d1cbaf8f0-W020201028741737540431.jpg"></p><p>草木染工坊 （张沛 摄）</p><p><img src="/images/6645d1d196f9b-W020201028741737719629.jpg"></p><p>工人展示草木染（刘建维 摄）</p><p>&nbsp; &nbsp; &nbsp; &nbsp;“我们通过文化旅游来促脱贫。”王启迪介绍，民宿优先租赁东沟村贫困户田地，连续三年，按年支付土地租赁费用，帮助贫困户增收。桃源货栈利用其自身的民宿窗口和品牌优势，帮助村合作社销售产品；同时，吸纳贫困户到民宿或草木染工坊就业；还引进传承传统草木染技艺，打造乡村本土文创产品。</p><p>&nbsp; &nbsp; &nbsp; &nbsp;村民吴文琴就是民宿的受益者，以前家里的收入靠丈夫在外务工，她来到这里打工后，能在家门口就业，每月赚到两三千块钱，减轻了家里的负担。对于未来，她也充满了希望：“我想在十堰买房子。”</p><p><img src="/images/6645d1d95a354-W020201028741737781981.jpg"></p><p>“桃源人家”民宿（陈明 摄）</p><p>&nbsp; &nbsp; &nbsp; &nbsp;以“桃源人家”民宿为龙头，东沟村举行农家乐服务和经营培训，为村民进行专业的指导，引导村民利用自身房屋、土地优势开办农家乐，成为当地乡村振兴和经济发展的新亮点。</p><p>&nbsp; &nbsp; &nbsp; &nbsp;“文旅扶贫已经取得了明显实效。”东沟村党支部书记张旭介绍，2019年全村实现经济总收入730余万元，旅游接待量达40余万人次，旅游综合收入450余万元，带动周边50余户村民就业创业，90%农村劳动力吃上了“旅游饭”，摘掉了“贫困帽”。</p><p><br>&nbsp;</p>	\N	走进湖北十堰市茅箭区茅塔乡东沟村，森林环抱、鸟语花香，精致的民宿依地势而建	2024-05-16 09:29:02	\N	\N	\N	\N	\N	\N	\N	\N
123	\N	\N	茅箭区东沟村：生旅融合绘就“金山银山”	2024-05-16 09:21:35	<p>&nbsp;</p><p>&nbsp; &nbsp; &nbsp; &nbsp;或欣赏山水风光，或拾得自然野趣，或感受田园生活，或体验传统民俗，又或寻迹红色历史……四季花开，处处皆景。在湖北省十堰市茅箭区茅塔乡东沟村，不论您什么季节来，不管您带着什么样的心情来，也无论您来过多少次，这里总不会让您失望，总会让您有不一样的体验，收获不一样的旅程。</p><p>&nbsp; &nbsp; &nbsp; &nbsp;东沟村是革命老区，红色历史文化厚重。其距十堰城区13公里，境内山清水秀、景色宜人，素有“十堰车城后花园”之称，是集红色、生态和乡村于一体的国家3A级旅游景区。近年来，东沟村聚焦休闲农业定位，依托红色文化旅游资源，集中整合资源品牌，做强做大做全农业休闲“文章”，激活发展“一池春水”。</p><p><strong>做足“山水文章” 风景这边独好</strong></p><p><img src="/images/6645d017c278a-618a0537-5f0a-4da9-8903-656487e1b3ee.jpg"></p><p>&nbsp; &nbsp; &nbsp; &nbsp;初秋时节，进入山环水绕的茅塔乡东沟村，一路满目浓翠、鸟语花香，整齐别致的民房依山而建，掩映在浓浓的绿荫之中。沿路进入景区，农家乐、小商店、“熊孩子”蜂蜜博物馆等各处可见休闲游玩的游客身影。</p><p>&nbsp; &nbsp; &nbsp; &nbsp;很难想象，上世纪七八十年代，耕地面积不足0.3亩的东沟村村民曾一度靠砍伐树木为生。如今，这里“村庄变景区，村民变股东，风景变‘钱景’”，昔日的“穷山村”“落后村”摇身一变，成为远近闻名的“网红村”。</p><p>&nbsp; &nbsp; &nbsp; &nbsp;山水见证，美丽蝶变。近年来，乘着政策利好的东风，该村立足村情实际、精心谋划，按照“红色旅游带动乡村”的发展思路，挖掘红色资源禀赋，按照“把农村当成景区来建设，把农居当成旅馆来改造，把农田山水当作旅游基地来经营”的理念，趟出了一条以生态种植、生态观光、休闲度假融合发展的休闲农业旅游产业新路。</p><p>&nbsp; &nbsp; &nbsp; &nbsp;红色文化搭台，“休闲农业”唱戏，“人人都是建设者”。锁定新时期村集体产业发展定位，东沟村因地制宜，充分挖掘生态人文融和发展的特色优势，相继建成中原突围鄂西北历史纪念馆、花开四季——月季园、杜鹃花海——野生杜鹃岭、荷塘月色——荷花塘、念情谷水帘洞天——猕猴园等一批独具特色的景点，吸引了十堰城区乃至周边游客纷至沓来。仅东沟红色旅游景区每年旅游人数超过10万人次。</p><p>&nbsp; &nbsp; &nbsp; &nbsp;一花独放不是春。近几年，东沟村创新思路，采取“合作社+农户”模式，重点打造推出梅花茶园、樱花茶园、海棠茶园、月季园、云上牡丹园等五大景观园区。每年2月至5月，东沟村绿梅，樱花、海棠花、牡丹花、月季花杜鹃花依次竞相开放，景色宜人、游人如织，成为十堰近郊游一道亮丽的风景线。</p><p><strong>精耕生态产业 “乡愁远方”兼顾</strong></p><p><img src="/images/6645d01c43da8-9da66a00-1366-4c11-b82e-31ced675cf2e.jpg"></p><p>&nbsp; &nbsp; &nbsp; &nbsp;每逢周末，不少游客会带着孩子到东沟村的桃源人家民宿，体验手工陶艺、植物绘画、草木染。“游客们兴致很高，现场欢声笑语。”桃源人家民宿的创办人王启迪说。</p><p>&nbsp; &nbsp; &nbsp; &nbsp;桃源人家民宿是东沟村引进的旅游龙头项目，项目创办人扎根东沟后，又接连开办“蛙声十里”“休休堂”等亲子民宿，建起桃源货栈、草木染坊、陶艺作坊等扶贫项目，成功打造出集亲子民宿、民宿学院、桃源货栈、陶艺坊、子衿染坊等多种业态融合发展的民宿综合体。为进一步丰富旅游景区内涵，拓展景区空间，通过极力争取，今年2月，村上又在牡丹园内建造5栋微宿，微宿项目的进驻使得景区游客量大大增加。</p><p>&nbsp; &nbsp; &nbsp; &nbsp;以民宿为龙头带动，东沟村举行农家乐服务和经营培训，为村民进行专业的指导，引导村民利用自身房屋、土地优势开办农家乐，有力带动当地群众通过发展旅游业增收致富。目前，东沟村里村民开办的民宿有5家，农家乐有8家，90％以上的村民吃上了‘旅游饭’，还有不少外出打工青年返乡创业，既留得住“乡愁”，也兼顾“诗与远方”。</p><p>&nbsp; &nbsp; &nbsp; &nbsp;好山好水好风光，有诗有情有远方。东沟村凭借良好的生态环境资源，以休闲农业产业为龙头带动农民增收，先后被授予“市级文明风景旅游区”、十堰市“绿色幸福村”、十堰市“文明村”、“十堰市生态家园示范村”、湖北省“美丽乡村建设示范村”、“湖北省脱贫攻坚先进集体”、“全国生态文化村”、“中国美丽休闲乡村”等荣誉称号。（湖北日报客户端 通讯员韩苗 郭安富 张旭）</p>	\N	茅箭区东沟村：生旅融合绘就“金山银山”	2024-05-16 09:21:35	\N	\N	\N	\N	\N	\N	\N	\N
125	\N	\N	红色东沟不了情	2024-05-16 09:29:59	<p>&nbsp;</p><p>&nbsp;　我是一名乡村退休教师，现年71岁，在三尺讲台上耕耘30多年后，于迟暮之年回到了家乡，在茅箭区东沟爱国主义教育基地担任了12年的讲解员，今年又被茅箭区委老干部局、区关工委聘为“五老”宣讲员。<br>　　茅箭区茅塔乡东沟村是我的家乡，在解放战争时期，贺龙、王树声等老一辈革命先烈先后率军转战于此，设立均郧房县委、县政府。我生在这片被烈士鲜血染红的土地上，从小就耳濡目染了发生在这里的革命故事，梦想把东沟的红色精神传承下来并发扬光大。</p><p>&nbsp;</p><p><img src="/images/6645d1a8d756a-W020201028741735001408.jpg"><br>　　</p><p><strong>&nbsp; &nbsp; &nbsp; &nbsp;搜集文物著史册</strong><br>　　在东沟爱国主义教育基地里，陈列着发黄的照片、生锈的钢刀铁矛、古老的电话、陈旧的枪支、破烂的军装和棉被……这一件件珍贵的文物背后，都有一段可歌可泣的历史往事。可在当时，文物无一件、资料无片纸、资金无分文，一穷二白。为了获得这些历史文物，近20年里，我利用假期和退休后的闲暇时光爬山涉水走遍了周边22个村寨，挨家挨户走访调查，查阅大量的历史资料，每个月微薄的工资大部分用在查访上面。<br>　　有人不理解，对我冷嘲热讽，说我是想出名想疯了；有人说我是搞文物走私；有人不肯说出当年事情的来由，怕连累自己；更有人说我不务正业...... 这些，我都默默忍受了，因为我坚信我做的事情是有意义的，最终会得到认可的。<br>　　因为常年外出寻访，家里农活都耽误了，妻子难免有怨气，说我是“败家子”，后来随着收集的史料越来越多，受到了当地党委政府的重视后，她逐渐理解了我对东沟红色文化的痴迷，妻子的支持让我更加心无旁鹜地投入到这项工作中。<br>　　我先后在十堰各地搜集到红军、新四军作战时用过的电话机、手榴弹、枪、刀、行军锅、马灯、条据等文物126件，有的还十分珍贵。曾经有一个老板来东沟爱国主义教育基地参观，相中了一件精制木桌，找到我说愿意出七万元买下，我说：“这是革命文物，你就是给十万元我也不会卖！”<br>　　虽然日子过得很清苦，但是我从没有后悔过，革命烈士为了人民的解放在这里浴血奋战，几十个春秋过去，它将成为历史。而我，作为东沟人，整理并重现这段历史是我的责任和荣耀。<br>　　<strong>传承史诗洒余热</strong><br>　　在我的执着追求和精心守护下，文物史料终于积少成多，渐成规模，并得到了市、区、乡各级党委政府的关心支持，艰辛的付出终于得到社会肯定。<br>　　2003年4月28日，东沟爱国主义教育基地在均郧房县委县政府旧址正式开馆，成为十堰城区唯一一个爱国主义教育基地。开馆那天，我长久地徘徊在展品前，思绪万千，这里，凝结着我毕生的心血。更令我高兴的是，考虑到我熟悉情况，热爱东沟历史，组织上决定让我担任东沟爱国主义教育基地的讲解员。2006年9月25日，李先念的孙女一行特地来到东沟村，寻找自己祖辈的足迹，与我亲切交谈。2007年5月22日，茅箭区档案馆将在东沟爱国主义教育基地收集的15件中原突围部队珍贵档案接收进馆。2012年5月22日，中国国际投资促进会副会长、深圳市国际投资促进会会长李清森，在得知其父亲新四军老战士李振卿当年曾经在东沟浴血奋战后，慕名前来寻访父辈足迹，对我们所做的工作表示感谢，并积极为茅箭区招商引资牵线搭桥。这一切，让我心里热乎乎的。<br>　　<strong>心里放不下这份事业</strong><br>　　渐渐地，慕名前来瞻仰接受革命传统教育的人越来越多了，看我一个人忙不过来，乡政府多次为我物色帮手。然而，东沟教育基地离市区近20公里，地处深山，交通不便，工作清苦，没有一个人坚持下去。<br>　　我是看在眼里，急在心里，情急之下，我做起了自己“90后”孙女周娇的工作。讲先烈、讲亲情、讲大局、讲发展……2010年，孙女终于答应了，我趁热打铁，再次当起了孙女的老师，每一幅图片、每一件文物、每句讲解词、每个手势……周娇成长得很快，在东沟教育基地，经常听到我们爷孙俩的声音错落有致，别有生趣。<br>　　近年来，在省、市、区各级党委政府的关心支持下，爱国主义教育基地建设取得快速发展，东沟均郧房县委县政府旧址先后被授予“十堰市爱国主义教育基地”、“湖北省第五批文物保护单位”、“湖北省廉政教育基地”、国家AAA级旅游景区等称号，是十堰市目前唯一的AAA级红色旅游景区，每年接待来自十堰城区及周边地区游客达30余万人次。随着知名度的提升和游客增多，也带动了当地农家乐和农副产业发展，为乡亲们开辟了增收致富的渠道，我的心里有说不出的快慰。<br><br>　　（作者系十堰市茅箭区茅塔乡退休教师、东沟爱国主义教育基地讲解员）</p>	\N	我是一名乡村退休教师，现年71岁，在三尺讲台上耕耘30多年后，于迟暮之年回到了家乡，	2024-05-16 09:29:59	\N	\N	\N	\N	\N	\N	\N	\N
70	\N	\N	贺大姐麻豆、腐乳	2024-05-14 01:53:19	<p>　　贺大姐麻豆、腐乳是东沟村的特产。它制作精细，具有细、黄、软特色，五味调和，滋味香酥。</p><figure class="image"><img src="/images/6646b3a903ae5-81c50f81bdfbc8a8f5520d7c66c86c03.jpg"></figure><p><strong>　　营养功效</strong></p><p>　　腐乳和豆豉以及其他豆制品一样，都是营养学家所大力推崇的健康食品。它的原料——豆腐干本来就是营养价值很高的豆制品，蛋白质含量5%～20%，与肉类相当，同时含有丰富的钙质。腐乳的制作过程中经过了霉菌的发酵，使蛋白质的消化吸收率更高，维生素含量更丰富。腐乳含盐和嘌呤量普遍较高，高血压、心血管病、痛风肾病患者及消化道溃疡患者，宜少吃或不吃。</p><figure class="image"><img src="/images/6646b3c176216-21bd317e247c5f0d271fac7aae7a2b40.jpg"></figure><p><strong>　　发展历史</strong></p><p>　　腐乳，又称白方。相关史料记载，早在清光绪年间，淅河镇有刘姓人家善制腐乳，工艺考究、味道独特。兼具香、酥、泡、甜、鲜等特色，被列为清廷贡品，享誉四方。</p>	leyou-slider4-3-6642c4100e961050543409.jpg	贺大姐麻豆、腐乳是东沟村的特产。它制作精细，具有细、黄、软特色，五味调和，滋味香酥。	2024-05-14 01:53:20	\N	\N	\N	\N	\N	\N	\N	\N
68	\N	\N	东沟子矜染坊草木蓝染	2024-05-14 01:52:45	<p>　　东沟子矜染坊草木蓝染采用纯天然植物提取染料，通过非遗传承的工艺，手工制作而成，带着植物清香的小布偶，极具生命力，或轻柔或厚重的织品蕴含着蓝染的传承千年的文化与韵味。</p><figure class="image"><img src="/images/6646b58ee3ad6-4ae04ac54d18ea1929461e056e4549f5.jpg"></figure><p>&nbsp;</p><figure class="image"><img src="/images/6646b5ad174fc-f4fdeff7d76cbe19c75f9879405a4082.jpg"></figure><p>&nbsp;</p><figure class="image"><img src="/images/6646b5bc9449e-db3790574cebf60f47a5eb367c4f7efe.jpg"></figure><p>&nbsp;</p>	leyou-slider4-1-6642c3ee0e6f0592438041.jpg	东沟子矜染坊草木蓝染采用纯天然植物提取染料，通过非遗传承的工艺，手工制作而成	2024-05-14 01:52:46	\N	\N	\N	\N	\N	\N	\N	\N
127	\N	\N	偷得浮生半日闲	2024-05-17 02:24:05	<p>&nbsp;</p><p>噼啪作响的炭火，缭绕蒸腾的茶香，汁水四溢的橘子，香甜软糯的板栗......</p><p>围坐在升起炭火的小木桌旁，这一切的组合都显得无比温馨与惬意。</p><p>在山中，家人好友围炉而坐，吃着瓜果点心，闲来煮茶，在阳光下打盹，像一场成年人的过家家。</p><p>&nbsp;</p><figure class="image"><img src="/images/6646bf698e003-640.webp (1).jpg"></figure><p>&nbsp;</p><p>依山而建得桃源人家，融入山间村落山水相依，人文古朴，烟火气中藏着诗意，一呼一吸间，皆是山野的气息，悠悠茶香与村落的秋日景致融为一体。</p><p>&nbsp;</p><figure class="image"><img src="/images/6646bf7122863-640.webp (2).jpg"></figure><p>&nbsp;</p><p>秋冬来桃源“围炉煮茶”，体验老宅的融融暖冬，谈笑间忘却烦恼，静思中享受放空</p><p>&nbsp;</p><figure class="image"><img src="/images/6646bf7a01d70-640.webp.jpg"></figure><p>&nbsp;</p><p>在这清浅时光里，一手烟火一手诗意，围炉煮茶，闲度浮生，清茶一壶，祝您安康！</p><p>&nbsp;</p><p><img src="/images/6646bf7fad011-640.webp (3).jpg"><br>&nbsp;</p>	640-webp-2-1-6646bfc55bc4c812002610.jpg	噼啪作响的炭火，缭绕蒸腾的茶香，汁水四溢的橘子，香甜软糯的板栗......	2024-05-17 02:24:05	\N	\N	\N	\N	\N	\N	\N	\N
129	\N	\N	初见倾心的百年古村，恰似一幅水墨丹青隐于世！	2024-05-17 02:28:48	<p>&nbsp;</p><p>平地沃壤远环山，聚气藏风不等闲;</p><p>秀脉遥盘千里外，清流合 泻两峰间。</p><p>无徽旧县基犹在，有益新城筑弗怪;</p><p>敷政更需贤令尹，成周治化可追攀。</p><p>&nbsp;</p><figure class="image"><img src="/images/6646c08f641bd-b5b5ad330bb5ab64ff5f9a754c67e040.jpg"></figure><p>&nbsp;</p><p>远离城市的喧嚣，守着一座房子，喂狗、劈柴、做饭，关心粮食和蔬菜，日出而作日落而息，其实这种宁静就在东沟村</p><p>&nbsp;</p><figure class="image"><img src="/images/6646c09a07f6b-662600dcf0d5a6ac6a3d7ba82649831f.jpg"></figure><p>&nbsp;</p><p>村落依山傍水，村边一条小河潺潺流淌，</p><p>村落房屋为清代建筑风格，坐北朝南，依山而建，渐次递升。</p><p>&nbsp;</p><figure class="image"><img src="/images/6646c09ec59c7-b5b5ad330bb5ab64ff5f9a754c67e040.jpg"></figure><p>&nbsp;</p><p>布谷声中水满溪，</p><p>南畴北陇把锄犁。</p><p>劝农不费田官力，</p><p>腰鼓一声人自齐。</p><p>&nbsp;</p><figure class="image"><img src="/images/6646c0a3536b6-271cf7dad7107d5af92c58b6a9bfd6c0.jpg"></figure>	e1819245b9a4a2e2df1c0c855b388a58-1-6646c0e0239f7884888275.jpg	初见倾心的百年古村，恰似一幅水墨丹青隐于世！	2024-05-17 02:28:48	\N	\N	\N	\N	\N	\N	\N	\N
60	\N	\N	茅塔百花蜜	2024-05-14 01:49:47	<p>　　东沟是蜜源植物较多的地区。春、夏、秋分别有油菜花、槐花、荆条花、芝麻花、桂花等。</p><figure class="image"><img src="/images/6646aa4bc7412-9cd3c04e210b53fb6bb902bccc76bfbe.jpg"></figure><p>　　<strong>生长环境</strong></p><p>　　新中国成立以前，本地多养“中蜂”，俗称“土蜂”，不群放，繁殖慢，产蜜少。上世纪50年代，意大利蜂传入随县，蜂种改良，开始人工放养，繁殖增快。</p><p>　　1979年，随县收购商品蜜达39万公斤。</p><p>　　1985年全市养蜂存笼14675群，收购商品蜜43万公斤。蜂蜜补中，润燥，止痛，解毒。</p><p>　　上世纪90年代上升150万公斤。蜂产品全是宝。</p><figure class="image"><img src="/images/66471703df5c2-0c215a3110788ab7620135c3ff8eb748.jpg"></figure><p>　　<strong>营养价值</strong></p><p>　　蜂蜜是一种营养丰富的天然滋养食品，也是最常用的滋补品之一。</p><p>　　据分析，含有与人体血清浓度相近的多种无机盐和维生素、铁等多种有机酸和有益人体健康的微量元素，以及果糖、葡萄糖等，具有滋养、润燥、解毒、美白养颜、润肠通便之功效。</p>	chizai-1-6642c33c3eff4329249987.jpg	\N	2024-05-14 01:49:48	\N	\N	\N	\N	\N	\N	\N	\N
128	\N	\N	桃源人家视频	2024-05-17 02:26:40	\N	\N	\N	2024-05-17 05:26:01	donggoumingsu-6646ea6911ce1137626150.mp4	\N	\N	\N	\N	\N	\N	\N
119	\N	\N	市城建档案馆：开展纪念活动 重温峥嵘岁月	2024-05-16 02:33:24	<p>&nbsp;</p><p>&nbsp; &nbsp; &nbsp; “1931年，贺龙率领红三军转战鄂西北，在这里壮大革命队伍，创建鄂西北革命根据地……”近日，市城建档案馆全体干部职工来到东沟爱国主义教育基地，聆听讲解员诉说曾经发生在这片热土上的革命事迹，近距离感受老一辈革命家舍生忘死、为理想信念奋斗终身的革命精神。<br>&nbsp;</p><figure class="image"><img src="/images/6645705b10cfa-2.jpg"></figure><p>&nbsp;</p><p>　　弘扬伟大建党精神，继承光荣革命传统。6月27日，市城建档案馆组织全体干部职工前往东沟爱国主义教育基地开展观摩学习教育和长征精神主题讲座活动，缅怀革命先烈，重温无私奉献、自力更生、艰苦奋斗的革命精神和不怕牺牲绝对忠诚，积极乐观不惧艰难的长征精神。</p><p><img src="http://zjj.shiyan.gov.cn/xwzx/cjda/202306/W020230629308764744298.jpg" alt=""></p><p>　　铮铮誓言，掷地有声。在东沟爱国主义教育基地电教厅，全体党员面向鲜红的中国共产党党旗，高举右拳，重温入党誓词。铿锵有力的誓词声响彻大厅，充分表达了大家对党的忠诚和为党的事业奋斗终身的决心。新入党党员和入党积极分子分享了入党的心路历程，并结合工作畅谈如何将革命精神践行到自己的实际工作中。</p><p><img src="http://zjj.shiyan.gov.cn/xwzx/cjda/202306/W020230629308764921815.jpg" alt=""></p><p>　　为进一步增强党员干部党性修养、坚定理想信念。市城建档案馆还邀请市委宣讲团成员、市委党校党史党建与统战教研室主任、副教授李永彩，以《忆峥嵘岁月 扬长征精神》为题作党史专题辅导报告，让干部职工接受思想教育和心灵洗礼。</p><p>　　参观学习后，大家纷纷表示，要以革命先烈为榜样，加强党性修养，时刻自警自省，筑牢拒腐防变的思想堤坝，不忘初心，勇担使命，砥砺前行，永葆共产党人的政治本色。</p><p>&nbsp;</p><figure class="image"><img src="/images/66457062a68b0-3.jpg"></figure><p>&nbsp;</p><figure class="image"><img src="/images/6645706b4ded9-4.jpg"></figure>	3-66457074860bc423956767.jpg	市城建档案馆：开展纪念活动 重温峥嵘岁月	2024-05-16 02:33:24	\N	\N	\N	\N	\N	\N	\N	\N
54	\N	\N	云上牡丹园海拔600米	2024-05-14 01:39:42	<p>&nbsp;</p><p>　　云上牡丹园位于十堰市茅箭区茅塔乡东沟村二组，海拔600米。</p><p>　　因每逢小雨，满山云雾缭绕，故而得名“云上牡丹园”。</p><p>　　园区面积达100多亩，种植有各类牡丹共计6万余株。园内牡丹花色丰富，包括粉色、红色、白色和紫色等，争奇斗艳，为游客带来绝佳的视觉体验。</p><p>&nbsp;</p><figure class="image"><img src="/images/6646b88ca5cf5-65128fde684487954518d62109c525e3.jpg"></figure><p>&nbsp;</p><figure class="image"><img src="/images/6646b892b128b-2e168ed52873625e417c0a530cfd24a6.jpg"></figure><p>&nbsp;</p><p>　　逛完云上牡丹园，还可以去云上微民宿住上一晚。云上微民宿建在海拔600米的悬崖边，群山环抱，花海环绕，白天推窗可见美丽风景，夜晚抬头仰望璀璨星空。</p><p>　　云上牡丹园通常在每年的4月初至5月初开放，具体时间根据当年的气候和花期而定。</p><p><br><img src="/images/6646b897b28a8-faa1fa3e8c8b3b8bfd8e11de9de0ba26.jpg"></p><p>&nbsp;</p>	65128fde684487954518d62109c525e3-6644970cd2cb9350276106-66455e2e35a14995772462.jpg	\N	2024-05-16 01:15:26	\N	\N	\N	\N	\N	\N	\N	\N
122	\N	\N	【乡村振兴看湖北】十堰茅箭：农文旅融合打造中国美丽休闲乡村	2024-05-16 09:20:28	<p>&nbsp;</p><p>&nbsp; &nbsp; &nbsp; 央广网十堰11月18日消息（记者朱娜 通讯员万月 余文涛）农村变景区、农园变游园、农居变旅店、农产品变旅游商品……在湖北省十堰市茅箭区，初冬时节的东沟村静谧祥和，别有一番韵味，吸引了不少周边游客前来打卡参观。</p><p>东沟村（央广网发 王鹏 摄）</p><figure class="image"><img src="/images/6645ccda7f159-9da66a00-1366-4c11-b82e-31ced675cf2e.jpg"></figure><p>东沟猕猴园（央广网发 王鹏 摄）</p><figure class="image"><img src="/images/6645cce293750-1000.webp (1).jpg"></figure><p>东沟村建筑与周边环境融为一体（央广网发 王鹏 摄）</p><figure class="image"><img src="/images/6645cf4c1f7f3-1000.webp (2).jpg"></figure><p>&nbsp; &nbsp; &nbsp; 不久前，东沟村成功入选“2022年中国美丽休闲乡村”。近年来，茅箭区紧紧依托红色旅游资源和生态旅游资源优势，秉承“把农村当成景区来建设，把农居当成旅馆来改造，把农田山水当作旅游基地来经营”的理念，通过红色文化搭台、生态旅游唱戏，推进农文旅深度融合，走出了一条以生态农业为“基”、美丽田园为“韵”、特色民宿为“形”、红色文化为“魂”的发展新路子，茅箭区东沟村、营子村已成为远近闻名的“网红村”。</p><figure class="image"><img src="/images/6645cf63b1c4b-1000.webp (3).jpg"></figure><p>东沟村樱花茶园（央广网发 茅箭区融媒体中心供图）</p><figure class="image"><img src="/images/6645cfc0a6b84-641.webp.jpg"></figure><p>东沟桃源人家民宿（央广网发 王鹏 摄）</p>	\N	央广网十堰11月18日消息（记者朱娜 通讯员万月 余文涛）农村变景区、农园变游园、农居变旅店、农产品变旅游商品……	2024-05-16 09:20:28	\N	\N	\N	\N	\N	\N	\N	\N
98	\N	\N	牛斗山顶	2024-05-15 05:45:19	<p>牛斗山顶</p>	niu-dou-shan-ding-66e493ff97e57782474599.jpg	牛斗山顶	2024-09-13 19:35:27	\N	\N	\N	\N	\N	\N	\N	\N
121	\N	\N	国字号荣誉！茅箭区东沟村获评2022年中国美丽休闲乡村	2024-05-16 09:06:32	<p>　<img src="/images/6645cbd89664e-W020221116362984843216.png"></p><p>&nbsp; &nbsp; &nbsp; 11月14日，记者从十堰市文旅局获悉，农业农村部公布了中国美丽休闲乡村推介结果，推介北京市门头沟区妙峰山镇炭厂村等255个乡村为2022年中国美丽休闲乡村，湖北共有10地上榜。十堰市仅茅箭区茅塔乡东沟村上榜其中，成功获评2022年中国美丽休闲乡村。</p><figure class="image"><img src="/images/6645cbe6e018f-W020221116362984854574.png"></figure><p><br>　　快来一起看看，东沟村有多美吧！</p><p><br>　　近年来，东沟村紧紧依托红色旅游资源和生态旅游资源优势，秉承“把农村当成景区来建设，把农居当成旅馆来改造，把农田山水当作旅游基地来经营”的理念，通过红色文化“搭台”、生态旅游“唱戏”，推进农文旅深度融合，走出了一条以生态农业为“基”、美丽田园为“韵”、特色民宿为“形”、红色文化为“魂”的发展新路子，成为远近闻名的“网红村”，先后荣获十堰市生态家园示范村、十堰市乡村振兴示范村、全国生态文化村等称号。</p><p><br>　　2021年，全村实现经济总收入800余万元，农民人均纯收入16234元，村集体经济收入达68万元，90％的村民吃上了“旅游饭”。（记者 周仑）</p><figure class="image"><img src="/images/6645cc1464ec3-618a0537-5f0a-4da9-8903-656487e1b3ee.jpg"></figure>	\N	11月14日，记者从十堰市文旅局获悉，农业农村部公布了中国美丽休闲乡村推介结果，	2024-05-16 09:06:32	\N	\N	\N	\N	\N	\N	\N	\N
15	\N	\N	杜鹃岭	2024-05-13 03:09:52	<p>&nbsp;</p><p>　　杜鹃岭是一个以杜鹃花为主题的自然景观，它位于东沟村境内，是该村的一大亮点。</p><p>　　杜鹃岭以其盛开的杜鹃花而闻名。每年春季，尤其是4月至5月期间，这里的野生杜鹃花进入盛放期，满山遍野的杜鹃花竞相绽放，形成一片绚丽多彩的花海。杜鹃花的颜色丰富多样，有粉红、粉白、紫红色等，花朵繁茂华丽，远望宛如云霞般灿烂。杜鹃岭与周围的青山绿树相互映衬，构成了一幅绝美的自然画卷。</p><p>　　游客来到杜鹃岭，可以沿着山间小径漫步，欣赏沿途盛开的杜鹃花。花朵散发出阵阵香气，让人陶醉其中。在这里，你可以感受到春天的气息，享受大自然的馈赠。同时，杜鹃岭还提供了观景台等设施，方便游客驻足观赏、拍照留念。</p><p>&nbsp;</p><figure class="image"><img src="/images/6646ba65a8516-28ce19ae50f92ba23658a9f7222cd904.jpg"></figure><p>&nbsp;</p><p>　　杜鹃岭也以其鲜红的颜色映衬着东沟爱国主义教育基地，怀念着逝去的革命先烈。</p><p>　　杜鹃岭上移栽的杜鹃与原生杜鹃、草甸、松柏、杉树相映成趣，构成一幅五彩斑斓的图案，形成“万壑树参天，千山响杜鹃”的美景，使之成为茅塔的“后花园”。</p><p>&nbsp;</p><figure class="image"><img src="/images/6646ba6c6fdb0-52e4aca120b2740fd0cfc881faa5c7f0.jpg"></figure><p>&nbsp;</p><figure class="image"><img src="/images/6646ba736672b-b923e09345023e74b98fac359f7bc569.jpg"></figure><p>&nbsp;</p>	jingqu-5-66418480d6487561204136.jpg	\N	2024-05-13 03:09:52	\N	\N	\N	\N	\N	\N	\N	\N
74	\N	\N	念情谷—猕猴园	2024-05-14 04:35:20	<p>&nbsp;</p><p>　　念情谷猕猴园位于十堰市茅箭区茅塔乡东沟村。</p><p>　　念情谷的名字的由来，还有一段可歌可泣的爱情故事，1943年，朱正传与妻子易齐荇结成革命伴侣，为党的事业，夫妻分隔两地战斗。1946年时任均郧房县委书记的朱正传及38名战士，为掩护部队转移，在此牺牲。直到1986年，湖北省十堰市在搜集整理地方党史时，易齐荇才知道朱正传牺牲在十堰。此后，她一有时间就会来十堰东沟纪念自己的丈夫。易齐荇在朱正传烈士牺牲后没有再嫁，他们也没有留下后代。两人的红色爱情故事感动着当地村民，后来，东沟人就把朱正传烈士为革命洒下热血牺牲的这片山谷命名为“念情谷”。</p><p>&nbsp;</p><figure class="image"><img src="/images/6646b9931c6b1-4ca5a6b0f68ad7b92dbd68fb8e74f8f9.jpg"></figure><p>&nbsp;</p><p>　　而如今的念情谷由于东沟生态环境的保护，吸引了大量游客前来休闲游玩，被一起吸引而来的还有来自深山的野生猕猴。如今猕猴园内现有野生猕猴近500只，在猴群管理上主要采取人工看护式管理模式，尽可能不干涉猴群发展，猕猴本就灵活聪慧，生活在自然山林内的猕猴则更加机敏，悬崖绝壁上下攀跃自如。</p><p>　　园内有登山游步道、猕猴互动平台、观景亭、景观桥等设施，自然风貌与人造景观交相辉映。</p><p>&nbsp;</p><figure class="image"><img src="/images/6646b998af6c1-5d32c5d90f4940f6a78707766e88fb43.jpg"></figure><p>&nbsp;</p><figure class="image"><img src="/images/6646b99dbf983-57c7f2991bafddb276509818dc2d6ee8.jpg"></figure><p>&nbsp;</p><figure class="image"><img src="/images/6646b9a49034b-dd1cc15540b574c50d5f0125e65b7338.jpg"></figure><p><br>&nbsp;</p>	qq-jie-tu20240515141138-6644524e6d6d0305121329-1-664489d85af12982470514-66455edc5a7dc143652744.jpg	\N	2024-05-16 01:18:20	\N	\N	\N	\N	\N	\N	\N	\N
126	\N	\N	桃源半山民宿	2024-05-17 01:43:21	<p><strong>游览推荐&nbsp;</strong></p><p>桃源半山民宿座落于茅箭区茅塔乡东沟村</p><p>远离都市喧嚣，淳朴农家小院</p><p>清幽凉爽的自然生态环境，特供绿色美食</p><p>是全家出游夏日纳凉的最佳选择。</p><p>&nbsp;</p><figure class="image"><img src="/images/6646b5b3bd168-003da3faaed05c077a78286d165c0f72.jpg"></figure><p>&nbsp;</p><p><strong>农家民宿&nbsp;</strong></p><p>山林隔绝城市纷扰，排排民宿整齐林立；</p><p>附近有云上牡丹园，月季园</p><p>满目皆景，独享小城的清净。</p><p>漫步山间小路，房屋小院分外亲近</p><p>&nbsp;</p><figure class="image"><img src="/images/6646b5bfd8863-aa54a973bb25d7bdd08aa11a2ff9d7df.jpg"></figure><p><strong>&nbsp;</strong></p><p><strong>散心度假</strong>&nbsp;</p><p>闲暇在这里的日子，可登山采摘茶叶，</p><p>品茗滋味；找个时间闲坐小憩，畅聊人生。</p><p>&nbsp;</p><figure class="image"><img src="/images/6646b5d73740f-af749ef6971ec63a8b70120935e7a165.jpg"></figure>	af749ef6971ec63a8b70120935e7a165-1-6646b639ab6a8148892124.jpg	桃源半山民宿座落于茅箭区茅塔乡东沟村，远离都市喧嚣，淳朴农家小院。清幽凉爽的自然生态环境，特供绿色美食是全家出游夏日纳凉的最佳选择。	2024-05-17 01:43:21	\N	\N	\N	\N	\N	\N	\N	\N
99	\N	\N	牛头山顶落日	2024-05-15 05:45:37	<p>牛头山顶落日</p>	niu-tou-shan-ding-luo-ri-66e493e09b87c704422640.jpg	牛头山顶落日	2024-09-13 19:34:56	\N	\N	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: node_region; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public.node_region (node_id, region_id) FROM stdin;
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
29	11
32	13
33	14
34	14
35	15
36	15
37	15
38	15
39	16
40	17
41	18
42	18
43	18
44	18
45	19
49	21
50	24
51	24
52	24
53	24
54	25
60	31
61	31
62	31
63	31
64	31
65	31
66	31
67	31
68	33
69	33
70	33
71	33
72	30
73	25
74	25
75	25
76	9
77	23
78	22
79	22
80	22
81	20
82	20
83	20
84	27
85	27
87	29
88	29
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
101	25
102	24
103	24
109	11
110	11
111	11
112	11
113	11
114	11
115	11
116	11
117	11
118	11
119	11
120	11
121	9
122	9
123	9
124	9
125	9
126	29
127	12
128	34
129	12
\.


--
-- Data for Name: node_tag; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public.node_tag (node_id, tag_id) FROM stdin;
126	1
91	1
90	1
89	1
88	2
87	2
\.


--
-- Data for Name: page; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public.page (id, name, label) FROM stdin;
1	首页	home
4	联系我们	contact
3	乐游东沟	leyou
2	走进东沟	zoujin
\.


--
-- Data for Name: region; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public.region (id, name, label, count, icon, fields, description, page_id) FROM stdin;
4	景区介绍-文本	jingqutext	1	list	image,summary	\N	1
5	乐游东沟-文本	leyoutext	1	list	image,summary	\N	1
8	乐游东沟	leyou	4	list	image,summary	\N	1
9	文旅要闻	wenlv	3	list	body,image,summary	\N	1
10	通知公告	tongzhi	3	list	body,image,summary	\N	1
11	党建文明	dangjian	2	list	body,image,summary	\N	1
12	旅行游记	youji	2	list	body,image,summary	\N	1
13	投诉建议	feedback	1	list	summary	\N	4
15	行程规划	xingcheng	4	list	image	\N	1
16	东沟简介	jianjie	1	list	summary,images	\N	2
17	行程规划-文本	xingchengtext	1	list	image,summary	\N	2
18	行程规划	xingcheng	4	list	body,image	\N	2
20	红色文化	hongse	3	list	summary,body,image	\N	2
19	红色文化-文本	hongsetext	1	list	summary	\N	2
21	东沟历史-文本	historytext	1	list	summary,body	\N	2
22	东沟历史	history	3	list	summary,body,image	\N	2
23	东沟荣誉-文本	honortext	1	list	image	\N	2
26	游在东沟-文本	youzaitext	1	list	summary	\N	3
28	住在东沟-文本	zhuzaitext	1	list	summary,image	\N	3
30	吃在东沟-文本	chizaitext	1	list	summary,image	\N	3
32	购在东沟-文本	gouzaitext	1	list	\N	\N	3
3	幻灯片	slider	3	list	image,summary	\N	1
14	页脚	footer	2	xmarks-lines	image	\N	\N
33	购在东沟	gouzai	8	list	summary,image,body	\N	3
31	吃在东沟	chizai	8	list	summary,image,body	\N	3
25	幻灯片1	slider1	5	list	image,body	\N	3
24	东沟荣誉	honor	8	list	image,summary	\N	2
6	行程规划-文本	xingchengtext	1	list	image,summary,specs	\N	1
34	视频	video	1	play-circle	video	\N	\N
29	住在东沟	zhuzai	6	list	summary,image,specs,body,tags	\N	3
7	景区介绍	jingqu	6	list	body,image,summary	\N	1
27	热门景点	youzai	10	list	summary,image,body	\N	3
\.


--
-- Data for Name: spec; Type: TABLE DATA; Schema: public; Owner: zw
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
13	88	TEL	农家乐电话：0719-8457770
12	87	TEL	农家乐电话：0719-8457770
15	90	TEL	民宿电话：0719-8310588
14	89	TEL	民宿电话：0719-8310588
16	91	TEL	民宿电话：0719-8457770
18	10	地图导航 >>	https://j.map.baidu.com/42/SVMi
\.


--
-- Data for Name: tag; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public.tag (id, name, label) FROM stdin;
1	民宿	minsu
2	农家乐	农家乐
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public."user" (id, username, roles, password, plain_password, openid, name, phone, avatar) FROM stdin;
2	al	["ROLE_SUPER_ADMIN"]	$2y$13$KpK7xAC8vlandkObN9kC4OAZVFw7SLtJvpf3PHICo4shV4haht9iK	\N	\N	\N	\N	\N
3	root	["ROLE_SUPER_ADMIN"]	$2y$13$vjcnglByWqC.GHCDZ3xIpuzHgPXtZ0mGvR5GPgXx7SBrGZRTTrmxi	\N	\N	\N	\N	\N
1	admin	["ROLE_ADMIN"]	$2y$13$Aru9xF850N6.KZ9cfzU67OlgYVVklRynqLXqkxeAiUcKWsbCMqqcS	\N	\N	\N	\N	\N
\.


--
-- Data for Name: user_node; Type: TABLE DATA; Schema: public; Owner: zw
--

COPY public.user_node (user_id, node_id) FROM stdin;
\.


--
-- Name: category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zw
--

SELECT pg_catalog.setval('public.category_id_seq', 5, true);


--
-- Name: conf_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zw
--

SELECT pg_catalog.setval('public.conf_id_seq', 1, true);


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

SELECT pg_catalog.setval('public.node_id_seq', 129, true);


--
-- Name: page_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zw
--

SELECT pg_catalog.setval('public.page_id_seq', 4, true);


--
-- Name: region_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zw
--

SELECT pg_catalog.setval('public.region_id_seq', 34, true);


--
-- Name: spec_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zw
--

SELECT pg_catalog.setval('public.spec_id_seq', 18, true);


--
-- Name: tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zw
--

SELECT pg_catalog.setval('public.tag_id_seq', 2, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zw
--

SELECT pg_catalog.setval('public.user_id_seq', 3, true);


--
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


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
-- Name: page page_pkey; Type: CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.page
    ADD CONSTRAINT page_pkey PRIMARY KEY (id);


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
-- Name: user_node user_node_pkey; Type: CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.user_node
    ADD CONSTRAINT user_node_pkey PRIMARY KEY (user_id, node_id);


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
-- Name: idx_36ac99f1ccd7e912; Type: INDEX; Schema: public; Owner: zw
--

CREATE INDEX idx_36ac99f1ccd7e912 ON public.link USING btree (menu_id);


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
-- Name: idx_f62f176c4663e4; Type: INDEX; Schema: public; Owner: zw
--

CREATE INDEX idx_f62f176c4663e4 ON public.region USING btree (page_id);


--
-- Name: idx_fffea48c460d9fd7; Type: INDEX; Schema: public; Owner: zw
--

CREATE INDEX idx_fffea48c460d9fd7 ON public.user_node USING btree (node_id);


--
-- Name: idx_fffea48ca76ed395; Type: INDEX; Schema: public; Owner: zw
--

CREATE INDEX idx_fffea48ca76ed395 ON public.user_node USING btree (user_id);


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
-- Name: link fk_36ac99f1ccd7e912; Type: FK CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.link
    ADD CONSTRAINT fk_36ac99f1ccd7e912 FOREIGN KEY (menu_id) REFERENCES public.menu(id);


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
-- Name: region fk_f62f176c4663e4; Type: FK CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.region
    ADD CONSTRAINT fk_f62f176c4663e4 FOREIGN KEY (page_id) REFERENCES public.page(id);


--
-- Name: user_node fk_fffea48c460d9fd7; Type: FK CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.user_node
    ADD CONSTRAINT fk_fffea48c460d9fd7 FOREIGN KEY (node_id) REFERENCES public.node(id) ON DELETE CASCADE;


--
-- Name: user_node fk_fffea48ca76ed395; Type: FK CONSTRAINT; Schema: public; Owner: zw
--

ALTER TABLE ONLY public.user_node
    ADD CONSTRAINT fk_fffea48ca76ed395 FOREIGN KEY (user_id) REFERENCES public."user"(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

