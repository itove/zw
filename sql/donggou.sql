--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Debian 16.2-1)
-- Dumped by pg_dump version 16.2 (Debian 16.2-1)

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
-- Name: notify_messenger_messages(); Type: FUNCTION; Schema: public; Owner: donggoudev
--

CREATE FUNCTION public.notify_messenger_messages() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
            BEGIN
                PERFORM pg_notify('messenger_messages', NEW.queue_name::text);
                RETURN NEW;
            END;
        $$;


ALTER FUNCTION public.notify_messenger_messages() OWNER TO donggoudev;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: category; Type: TABLE; Schema: public; Owner: donggoudev
--

CREATE TABLE public.category (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    label character varying(255) NOT NULL
);


ALTER TABLE public.category OWNER TO donggoudev;

--
-- Name: category_id_seq; Type: SEQUENCE; Schema: public; Owner: donggoudev
--

CREATE SEQUENCE public.category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.category_id_seq OWNER TO donggoudev;

--
-- Name: conf; Type: TABLE; Schema: public; Owner: donggoudev
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


ALTER TABLE public.conf OWNER TO donggoudev;

--
-- Name: COLUMN conf.keywords; Type: COMMENT; Schema: public; Owner: donggoudev
--

COMMENT ON COLUMN public.conf.keywords IS '(DC2Type:simple_array)';


--
-- Name: COLUMN conf.updated_at; Type: COMMENT; Schema: public; Owner: donggoudev
--

COMMENT ON COLUMN public.conf.updated_at IS '(DC2Type:datetime_immutable)';


--
-- Name: conf_id_seq; Type: SEQUENCE; Schema: public; Owner: donggoudev
--

CREATE SEQUENCE public.conf_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.conf_id_seq OWNER TO donggoudev;

--
-- Name: doctrine_migration_versions; Type: TABLE; Schema: public; Owner: donggoudev
--

CREATE TABLE public.doctrine_migration_versions (
    version character varying(191) NOT NULL,
    executed_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    execution_time integer
);


ALTER TABLE public.doctrine_migration_versions OWNER TO donggoudev;

--
-- Name: feedback; Type: TABLE; Schema: public; Owner: donggoudev
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


ALTER TABLE public.feedback OWNER TO donggoudev;

--
-- Name: feedback_id_seq; Type: SEQUENCE; Schema: public; Owner: donggoudev
--

CREATE SEQUENCE public.feedback_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.feedback_id_seq OWNER TO donggoudev;

--
-- Name: image; Type: TABLE; Schema: public; Owner: donggoudev
--

CREATE TABLE public.image (
    id integer NOT NULL,
    node_id integer NOT NULL,
    image character varying(255) NOT NULL
);


ALTER TABLE public.image OWNER TO donggoudev;

--
-- Name: image_id_seq; Type: SEQUENCE; Schema: public; Owner: donggoudev
--

CREATE SEQUENCE public.image_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.image_id_seq OWNER TO donggoudev;

--
-- Name: language; Type: TABLE; Schema: public; Owner: donggoudev
--

CREATE TABLE public.language (
    id integer NOT NULL,
    language character varying(30) NOT NULL,
    prefix character varying(15) NOT NULL,
    locale character varying(15) NOT NULL
);


ALTER TABLE public.language OWNER TO donggoudev;

--
-- Name: language_id_seq; Type: SEQUENCE; Schema: public; Owner: donggoudev
--

CREATE SEQUENCE public.language_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.language_id_seq OWNER TO donggoudev;

--
-- Name: messenger_messages; Type: TABLE; Schema: public; Owner: donggoudev
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


ALTER TABLE public.messenger_messages OWNER TO donggoudev;

--
-- Name: COLUMN messenger_messages.created_at; Type: COMMENT; Schema: public; Owner: donggoudev
--

COMMENT ON COLUMN public.messenger_messages.created_at IS '(DC2Type:datetime_immutable)';


--
-- Name: COLUMN messenger_messages.available_at; Type: COMMENT; Schema: public; Owner: donggoudev
--

COMMENT ON COLUMN public.messenger_messages.available_at IS '(DC2Type:datetime_immutable)';


--
-- Name: COLUMN messenger_messages.delivered_at; Type: COMMENT; Schema: public; Owner: donggoudev
--

COMMENT ON COLUMN public.messenger_messages.delivered_at IS '(DC2Type:datetime_immutable)';


--
-- Name: messenger_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: donggoudev
--

CREATE SEQUENCE public.messenger_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.messenger_messages_id_seq OWNER TO donggoudev;

--
-- Name: messenger_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: donggoudev
--

ALTER SEQUENCE public.messenger_messages_id_seq OWNED BY public.messenger_messages.id;


--
-- Name: node; Type: TABLE; Schema: public; Owner: donggoudev
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


ALTER TABLE public.node OWNER TO donggoudev;

--
-- Name: COLUMN node.created_at; Type: COMMENT; Schema: public; Owner: donggoudev
--

COMMENT ON COLUMN public.node.created_at IS '(DC2Type:datetime_immutable)';


--
-- Name: COLUMN node.updated_at; Type: COMMENT; Schema: public; Owner: donggoudev
--

COMMENT ON COLUMN public.node.updated_at IS '(DC2Type:datetime_immutable)';


--
-- Name: node_id_seq; Type: SEQUENCE; Schema: public; Owner: donggoudev
--

CREATE SEQUENCE public.node_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.node_id_seq OWNER TO donggoudev;

--
-- Name: node_region; Type: TABLE; Schema: public; Owner: donggoudev
--

CREATE TABLE public.node_region (
    node_id integer NOT NULL,
    region_id integer NOT NULL
);


ALTER TABLE public.node_region OWNER TO donggoudev;

--
-- Name: node_tag; Type: TABLE; Schema: public; Owner: donggoudev
--

CREATE TABLE public.node_tag (
    node_id integer NOT NULL,
    tag_id integer NOT NULL
);


ALTER TABLE public.node_tag OWNER TO donggoudev;

--
-- Name: page; Type: TABLE; Schema: public; Owner: donggoudev
--

CREATE TABLE public.page (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    label character varying(255) NOT NULL
);


ALTER TABLE public.page OWNER TO donggoudev;

--
-- Name: page_id_seq; Type: SEQUENCE; Schema: public; Owner: donggoudev
--

CREATE SEQUENCE public.page_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.page_id_seq OWNER TO donggoudev;

--
-- Name: region; Type: TABLE; Schema: public; Owner: donggoudev
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


ALTER TABLE public.region OWNER TO donggoudev;

--
-- Name: COLUMN region.fields; Type: COMMENT; Schema: public; Owner: donggoudev
--

COMMENT ON COLUMN public.region.fields IS '(DC2Type:simple_array)';


--
-- Name: region_id_seq; Type: SEQUENCE; Schema: public; Owner: donggoudev
--

CREATE SEQUENCE public.region_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.region_id_seq OWNER TO donggoudev;

--
-- Name: spec; Type: TABLE; Schema: public; Owner: donggoudev
--

CREATE TABLE public.spec (
    id integer NOT NULL,
    node_id integer NOT NULL,
    name character varying(25) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.spec OWNER TO donggoudev;

--
-- Name: spec_id_seq; Type: SEQUENCE; Schema: public; Owner: donggoudev
--

CREATE SEQUENCE public.spec_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.spec_id_seq OWNER TO donggoudev;

--
-- Name: tag; Type: TABLE; Schema: public; Owner: donggoudev
--

CREATE TABLE public.tag (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    label character varying(255) NOT NULL
);


ALTER TABLE public.tag OWNER TO donggoudev;

--
-- Name: tag_id_seq; Type: SEQUENCE; Schema: public; Owner: donggoudev
--

CREATE SEQUENCE public.tag_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tag_id_seq OWNER TO donggoudev;

--
-- Name: user; Type: TABLE; Schema: public; Owner: donggoudev
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    username character varying(180) NOT NULL,
    roles json NOT NULL,
    password character varying(255) NOT NULL,
    plain_password character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public."user" OWNER TO donggoudev;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: donggoudev
--

CREATE SEQUENCE public.user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_id_seq OWNER TO donggoudev;

--
-- Name: messenger_messages id; Type: DEFAULT; Schema: public; Owner: donggoudev
--

ALTER TABLE ONLY public.messenger_messages ALTER COLUMN id SET DEFAULT nextval('public.messenger_messages_id_seq'::regclass);


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: donggoudev
--

COPY public.category (id, name, label) FROM stdin;
1	景区介绍	intro
2	文旅要闻	wenlv
3	通知公告	tongzhi
4	党建文明	dangjian
5	旅行游记	youji
\.


--
-- Data for Name: conf; Type: TABLE DATA; Schema: public; Owner: donggoudev
--

COPY public.conf (id, language_id, sitename, keywords, description, address, phone, email, logo, updated_at, note) FROM stdin;
1	\N	乐游东沟_东沟文化旅游网	东沟,东沟文化旅游网,东沟中原突围鄂西北历史纪念馆,东沟烈士陵园,东沟念情谷猕猴园,杜鹃岭,桃源人家,蛙声十里,山顶美宿	东沟村位于十堰市茅箭区茅塔乡，属于湖北赛武当国家级自然保护区试验区和缓冲区范围，面积11.4平方公里，距十堰市城区13公里。东沟已形成集接受爱国教育、欣赏自然风光、体验农家风情，观摩新农村建设于一体的具有丰富内涵的红色旅游胜地。	湖北省十堰市茅箭区茅塔乡东沟村一组	0719-8457770	\N	logo-6641912db5458003532123.png	2024-05-13 04:03:57	鄂ICP备2023029037号-1
\.


--
-- Data for Name: doctrine_migration_versions; Type: TABLE DATA; Schema: public; Owner: donggoudev
--

COPY public.doctrine_migration_versions (version, executed_at, execution_time) FROM stdin;
DoctrineMigrations\\Version20240110161309	2024-03-13 12:28:02	214
DoctrineMigrations\\Version20240513003319	2024-05-13 00:33:29	37
DoctrineMigrations\\Version20240513003519	2024-05-13 00:35:22	8
DoctrineMigrations\\Version20240513042532	2024-05-13 04:26:21	12
DoctrineMigrations\\Version20240513082950	2024-05-13 08:29:54	13
DoctrineMigrations\\Version20240513110628	2024-05-13 11:06:34	36
DoctrineMigrations\\Version20240513143315	2024-05-13 14:34:24	15
\.


--
-- Data for Name: feedback; Type: TABLE DATA; Schema: public; Owner: donggoudev
--

COPY public.feedback (id, node_id, firstname, lastname, email, phone, title, body, country) FROM stdin;
1	\N	jk	\N		jk	\N	jk	\N
2	\N	sadf	\N	fdas@a.com	fdas	\N	fdas	\N
3	\N	sadf	\N	fdas@a.com	fdas	\N	fdas	\N
4	\N	jk	\N		jkj	\N	k	\N
5	\N	jk	\N		jk	\N	jk	\N
6	\N	木子	\N		测试	\N	东沟很好	\N
\.


--
-- Data for Name: image; Type: TABLE DATA; Schema: public; Owner: donggoudev
--

COPY public.image (id, node_id, image) FROM stdin;
1	39	zoujin-slider-1-6641de859dc34583489789.jpg
4	39	qq-jie-tu20240515115625-664432e6eea1b079893567.jpg
5	39	qq-jie-tu20240515120005-6644336a2bc3f019044511.jpg
\.


--
-- Data for Name: language; Type: TABLE DATA; Schema: public; Owner: donggoudev
--

COPY public.language (id, language, prefix, locale) FROM stdin;
\.


--
-- Data for Name: messenger_messages; Type: TABLE DATA; Schema: public; Owner: donggoudev
--

COPY public.messenger_messages (id, body, headers, queue_name, created_at, available_at, delivered_at) FROM stdin;
\.


--
-- Data for Name: node; Type: TABLE DATA; Schema: public; Owner: donggoudev
--

COPY public.node (id, language_id, category_id, title, created_at, body, image, summary, updated_at) FROM stdin;
1	\N	\N	f1	2024-05-07 01:08:07	\N	\N	\N	2024-05-07 01:08:07
2	\N	\N	f2	2024-05-07 01:12:27	\N	\N	\N	2024-05-07 01:12:27
3	\N	\N	f3	2024-05-07 01:12:43	\N	\N	\N	2024-05-07 01:12:43
4	\N	\N	faq1	2024-05-12 11:18:17	\N	\N	\N	2024-05-12 11:18:17
5	\N	\N	产品方案1	2024-05-12 11:18:31	\N	\N	\N	2024-05-12 11:18:31
17	\N	\N	乐游东沟	2024-05-13 03:14:15	\N	leyou-bg-664185b77e4ff378757708.jpg	特色景区服务 · 给您贴心体验	2024-05-13 03:15:03
30	\N	\N	我市发布《十堰市民绿色低碳生活行为规范》	2024-05-13 03:43:54	\N	news-3-66418c7b5c955402548006.jpg	7月7日，《十堰市民绿色低碳生活行为规范》（以下简称《规范》）新 闻发布会在市创文办举行。会上正式发布了《规范》，市创文办..	2024-05-13 03:43:55
31	\N	\N	湖北省公共文化服务保障条例	2024-05-13 03:44:39	\N	news-4-66418ca7d8df1388492707.jpg	第一条 为了加强公共文化服务体系建设，保障人民群众基本文化权益， 传承中华优秀传统文化，弘扬社会主义核心价值观，增强文化自..	2024-05-13 03:44:39
32	\N	\N	投诉建议	2024-05-13 08:07:54	\N	\N	如果您对东沟有任何建议或想与我们讨论的问题，请填写表单，我们将尽力为您处理。	2024-05-13 08:07:54
33	\N	\N	乐游东沟公众号	2024-05-13 08:39:42	\N	gongzhonghao-6641d1cf95590388723889.jpg	\N	2024-05-13 08:39:43
34	\N	\N	乐游东沟小程序	2024-05-13 08:40:05	\N	miniprog-6641d1e619827803888056.jpg	\N	2024-05-13 08:40:06
35	\N	\N	高铁出行	2024-05-13 09:28:13	\N	train-6641dd2dc2894166030166.png	\N	2024-05-13 09:28:13
36	\N	\N	客车出行	2024-05-13 09:28:38	\N	bus-6641dd4703e3b261786135.png	\N	2024-05-13 09:28:39
37	\N	\N	飞机出行	2024-05-13 09:29:00	\N	plane-6641dd5d44124102676172.png	\N	2024-05-13 09:29:01
38	\N	\N	自驾路线	2024-05-13 09:29:22	\N	car-6641dd72d77c0868742161.png	\N	2024-05-13 09:29:22
40	\N	\N	行程规划	2024-05-13 09:46:00	\N	zoujin-xingcheng-bg-6641e159690aa348240367.jpg	选择您的出行方式，我们将给您做出推荐	2024-05-13 09:46:01
9	\N	\N	景区介绍	2024-05-13 02:34:06	\N	home-jingqu-bg-66417caa39426232884525.jpg	秦巴古驿 文化传承	2024-05-13 02:36:26
19	\N	\N	住在东沟	2024-05-13 03:22:13	\N	leyou-2-664187665a86a860794393.jpg	以桃源人家为代表的特色民宿，将民宿综合体内的咖啡馆、民俗布染坊、陶艺...	2024-05-13 03:22:14
20	\N	\N	吃在东沟	2024-05-13 03:22:32	\N	leyou-3-66418778ec1f2926274706.jpg	在东沟，您可以品尝到地道的农家菜肴，每一口都散发着乡土的气息...	2024-05-13 03:22:32
21	\N	\N	购在东沟	2024-05-13 03:22:52	\N	leyou-4-6641878c99c53673730065.jpg	扎染、剪纸、古法榨油、刺绣等非遗文化创新商品与当地特色的农副产品...	2024-05-13 03:22:52
16	\N	\N	花开四季 — 月季园	2024-05-13 03:10:26	<p>　　月季园位于十堰市茅箭区茅塔乡东沟村红色革命教育基地入口小路旁。</p><p>　　种植面积约60余亩，是一个相对大规模的月季园。月季园内种植着大量的月季花，这些月季花热烈盛开，展现出浪漫唯美的景象。月季花的颜色丰富，形态各异，紧紧相连，摇曳在轻风之中，更显得风姿绰约。</p><p>　　每年初夏时节，月季园成为了一片花的海洋，装点着梯田式的园地，花香四溢。这里的月季花不仅美丽娇艳，还为东沟村增添了浓厚的浪漫气息，吸引了大批游客前来赏花留影。</p><p>　　“花开四季”月季园是一个集观赏、拍照、休闲为一体的花卉景区。游客可以在这里欣赏到美丽的月季花海，感受浓厚的浪漫气息，并留下美好的回忆。</p>	jingqu-6-664184a363d3b686847409.jpg	\N	2024-05-13 03:10:27
10	\N	\N	行程规划	2024-05-13 02:37:48	\N	xingcheng-66417cfcac045999996237.jpg	红色基地 革命记忆	2024-05-13 02:37:48
11	\N	\N	中原突围部西北历史纪念馆	2024-05-13 03:06:28	<p>　　中原突围鄂西北历史纪念馆，位于茅塔乡东沟村均郧房县委县政府旧址，该址建于明清时期，是开明乡绅周宗裔的祖宅。纪念馆内主要由党史陈列室、茅箭区国防教育展示厅、电教厅等展厅构成。这些展厅通过图片、文物和多媒体等形式，生动地展示了中原突围鄂西北革命斗争的历史。</p><p>　　1931年6月，贺龙率红三军创建武当山革命根据地，并移师房县途经茅塔乡东沟村。在这里，他们打土豪、分田地，积极发展革命队伍，为新民主主义革命在鄂西北地区的发展做出了重要贡献。</p><p>　　1946年，王树声率中原突围南路部队在东沟村建立了鄂西北第三军分区、均郧房县委县政府、县大队革命政权。时任均郧房县委书记朱正传、县长胡恪恭等，率领突围官兵，依靠东沟群众，坚持武装斗争，牵制了数十倍于己的国民党军队。在同年底的战斗中，朱正传等100余名官兵英勇牺牲，胡恪恭也身负重伤，均郧房县委、县政府随之迁址。</p><p>　　1946年9月，王树声率部转战东沟，把鄂西北作战指挥中心设在泰山庙，开始了紧张而有序的工作，先后配合三地委、中心县委创建了官山区、白浪区、茅塔河区等。</p><p>　　作为十堰市“青少年爱国主义教育基地”、茅箭区青少年“德育教育基地”，以及位于十堰城区唯一的未成年人思想道德教育基地，东沟爱国主义教育基地在推动青少年教育和乡村振兴方面发挥着重要作用。</p><p>　　东沟爱国主义教育基地充分利用这些红色资源，通过建设红色展馆、规划红色路线等方式，系统梳理、挖掘、提炼区域内的红色文化、知青文化、生态文化、移民文化和森工文化。在这里，游客可以参观到保存完好的明清古建筑，这些建筑不仅是历史的见证，也承载着丰富的红色文化内涵。同时，基地还收集了许多珍贵的革命历史文物，如大刀、长矛、枪支等，以及大量的图片展览和文字介绍，生动地再现了当年的烽火岁月和英雄故事。</p>	jingqu-1-664183b46d959025508355.jpg	\N	2024-05-13 03:06:28
23	\N	\N	茅箭区东沟村：生旅融合绘就“金山银山”	2024-05-13 03:40:11	<p>或欣赏山水风光，或拾得自然野趣，或感受田园生活，或体验传统民俗，又或寻迹红色历史……四季花开，处处皆景。在湖北省十堰市茅箭区茅塔乡东沟村，不论您什么季节来，不管您带着什么样的心情来，也无论您来过多少次，这里总不会让您失望，总会让您有不一样的体验，收获不一样的旅程。</p><p>东沟村是革命老区，红色历史文化厚重。其距十堰城区13公里，境内山清水秀、景色宜人，素有“十堰车城后花园”之称，是集红色、生态和乡村于一体的国家3A级旅游景区。近年来，东沟村聚焦休闲农业定位，依托红色文化旅游资源，集中整合资源品牌，做强做大做全农业休闲“文章”，激活发展“一池春水”。</p><p><strong>做足“山水文章” 风景这边独好</strong></p><p><img src="http://hbrbapp.hubeidaily.net/618a0537-5f0a-4da9-8903-656487e1b3ee"></p><p>初秋时节，进入山环水绕的茅塔乡东沟村，一路满目浓翠、鸟语花香，整齐别致的民房依山而建，掩映在浓浓的绿荫之中。沿路进入景区，农家乐、小商店、“熊孩子”蜂蜜博物馆等各处可见休闲游玩的游客身影。</p><p>很难想象，上世纪七八十年代，耕地面积不足0.3亩的东沟村村民曾一度靠砍伐树木为生。如今，这里“村庄变景区，村民变股东，风景变‘钱景’”，昔日的“穷山村”“落后村”摇身一变，成为远近闻名的“网红村”。</p><p>山水见证，美丽蝶变。近年来，乘着政策利好的东风，该村立足村情实际、精心谋划，按照“红色旅游带动乡村”的发展思路，挖掘红色资源禀赋，按照“把农村当成景区来建设，把农居当成旅馆来改造，把农田山水当作旅游基地来经营”的理念，趟出了一条以生态种植、生态观光、休闲度假融合发展的休闲农业旅游产业新路。</p><p>红色文化搭台，“休闲农业”唱戏，“人人都是建设者”。锁定新时期村集体产业发展定位，东沟村因地制宜，充分挖掘生态人文融和发展的特色优势，相继建成中原突围鄂西北历史纪念馆、花开四季——月季园、杜鹃花海——野生杜鹃岭、荷塘月色——荷花塘、念情谷水帘洞天——猕猴园等一批独具特色的景点，吸引了十堰城区乃至周边游客纷至沓来。仅东沟红色旅游景区每年旅游人数超过10万人次。</p><p>一花独放不是春。近几年，东沟村创新思路，采取“合作社+农户”模式，重点打造推出梅花茶园、樱花茶园、海棠茶园、月季园、云上牡丹园等五大景观园区。每年2月至5月，东沟村绿梅，樱花、海棠花、牡丹花、月季花杜鹃花依次竞相开放，景色宜人、游人如织，成为十堰近郊游一道亮丽的风景线。</p><p><strong>精耕生态产业 “乡愁远方”兼顾</strong></p><p><img src="http://hbrbapp.hubeidaily.net/9da66a00-1366-4c11-b82e-31ced675cf2e"></p><p>每逢周末，不少游客会带着孩子到东沟村的桃源人家民宿，体验手工陶艺、植物绘画、草木染。“游客们兴致很高，现场欢声笑语。”桃源人家民宿的创办人王启迪说。</p><p>桃源人家民宿是东沟村引进的旅游龙头项目，项目创办人扎根东沟后，又接连开办“蛙声十里”“休休堂”等亲子民宿，建起桃源货栈、草木染坊、陶艺作坊等扶贫项目，成功打造出集亲子民宿、民宿学院、桃源货栈、陶艺坊、子衿染坊等多种业态融合发展的民宿综合体。为进一步丰富旅游景区内涵，拓展景区空间，通过极力争取，今年2月，村上又在牡丹园内建造5栋微宿，微宿项目的进驻使得景区游客量大大增加。</p><p>以民宿为龙头带动，东沟村举行农家乐服务和经营培训，为村民进行专业的指导，引导村民利用自身房屋、土地优势开办农家乐，有力带动当地群众通过发展旅游业增收致富。目前，东沟村里村民开办的民宿有5家，农家乐有8家，90％以上的村民吃上了‘旅游饭’，还有不少外出打工青年返乡创业，既留得住“乡愁”，也兼顾“诗与远方”。</p><p>好山好水好风光，有诗有情有远方。东沟村凭借良好的生态环境资源，以休闲农业产业为龙头带动农民增收，先后被授予“市级文明风景旅游区”、十堰市“绿色幸福村”、十堰市“文明村”、“十堰市生态家园示范村”、湖北省“美丽乡村建设示范村”、“湖北省脱贫攻坚先进集体”、“全国生态文化村”、“中国美丽休闲乡村”等荣誉称号。（湖北日报客户端 通讯员韩苗 郭安富 张旭）</p>	\N	或欣赏山水风光，或拾得自然野趣，或感受田园生活，或体验传统民俗	2024-05-13 03:40:11
22	\N	\N	记者探访十堰茅塔乡东沟村：红色文化+绿色发展走出文旅扶贫路	2024-05-13 03:39:49	<p><img src="http://www.cnr.cn/newscenter/native/gd/20201028/W020201028741734423458.jpg" alt=""></p><p>东沟村（刘建维 摄）</p><p>走进湖北十堰市茅箭区茅塔乡东沟村，森林环抱、鸟语花香，精致的民宿依地势而建；这里也曾经烽火连天、枪林弹雨，996位革命前辈长眠于此，世代述说英雄故事。近年来，东沟村以红色文化为依托，充分发挥自然资源优势，将红色文化的传承与绿色生态发展融合到一起，走出了一条文旅脱贫之路。</p><p>巍巍武当西麓的茅塔乡东沟村是一片战火洗礼过的红色热土，它地处均郧房三县交界，曾先后设立了鄂西北第三军分区、均郧房县委县政府、县总队。上世纪七八十年代，砍伐树木一度成为人均耕地面积不足0.3亩的东沟村村民养家糊口的主要收入来源。沉痛的代价唤醒了红色基因，时任村干部多次商议，考虑东沟保留着不少历史遗址，又是革命先烈战斗过的地方，有发展红色旅游的基础，经过考察调研，最终敲定了红色旅游带动乡村发展思路。</p><p><img src="http://www.cnr.cn/newscenter/native/gd/20201028/W020201028741735001408.jpg" alt=""></p><p>均郧房县委县政府旧址（张沛 摄）</p><p>乘着三农政策、扶持革命老区建设、精准扶贫等国家政策的东风，东沟村向全面小康的目标不断迈进。</p><p>东沟村坚持保护修缮与开发并举，对2000平方米革命遗址进行腾退、修复，修通进村公路，陆续建起革命烈士陵园、革命文物陈列馆、戏楼、东沟学堂等，持续建设完善红色旅游文化资源。</p><p><img src="http://www.cnr.cn/newscenter/native/gd/20201028/W020201028741735072056.jpg" alt=""></p><p>东沟村特色民宿（刘建维 摄）</p><p>秉承“把农村当成景区来建设，把农居当成旅馆来改造，把农田山水当作旅游基地来经营”的理念，东沟村引导村民改造、新建特色民居，使整个村庄更加古朴、美丽，旅游服务更加完善、周到。打造以生态种植养殖、农家餐饮住宿为支撑的旅游配套全产业，采用“公司+基地+农户”模式，建成生态茶园400亩，武当道茶公司定期协议收购茶园鲜叶；依势就地铺设茶园观赏步游道，打造参与性高、体验感强的观光茶园主题景观园区，推动茶产业、茶文化发展。</p><p><img src="http://www.cnr.cn/newscenter/native/gd/20201028/W020201028741735210980.jpg" alt=""></p><p>特色民宿 （刘建维 摄）</p><p><img src="http://www.cnr.cn/newscenter/native/gd/20201028/W020201028741737415240.jpg" alt=""></p><p>特色民宿（刘建维 摄）</p><p><img src="http://www.cnr.cn/newscenter/native/gd/20201028/W020201028741737451581.jpg" alt=""></p><p>“桃源人家”民宿（陈明 摄）</p><p>在这样一个静谧的乡村里，几处特色民宿格外亮眼。</p><p>在上海工作13年的王启迪，偶然来到东沟村游览，便爱上这里留了下来，在村里租了一栋房屋院落，办起了别具特色的“桃源人家”民宿，成为“东沟人”之后，又接连开办“蛙声十里”“休休堂”等亲子民宿，建起蓝染、陶艺等扶贫作坊。据了解，2016年6月营业至今，已累计接待游客超过十万人次。</p><p><img src="http://www.cnr.cn/newscenter/native/gd/20201028/W020201028741737540431.jpg" alt=""></p><p>草木染工坊 （张沛 摄）</p><p><img src="http://www.cnr.cn/newscenter/native/gd/20201028/W020201028741737719629.jpg" alt=""></p><p>工人展示草木染（刘建维 摄）</p><p>“我们通过文化旅游来促脱贫。”王启迪介绍，民宿优先租赁东沟村贫困户田地，连续三年，按年支付土地租赁费用，帮助贫困户增收。桃源货栈利用其自身的民宿窗口和品牌优势，帮助村合作社销售产品；同时，吸纳贫困户到民宿或草木染工坊就业；还引进传承传统草木染技艺，打造乡村本土文创产品。</p><p>村民吴文琴就是民宿的受益者，以前家里的收入靠丈夫在外务工，她来到这里打工后，能在家门口就业，每月赚到两三千块钱，减轻了家里的负担。对于未来，她也充满了希望：“我想在十堰买房子。”</p><p><img src="http://www.cnr.cn/newscenter/native/gd/20201028/W020201028741737781981.jpg" alt=""></p><p>“桃源人家”民宿（陈明 摄）</p><p>以“桃源人家”民宿为龙头，东沟村举行农家乐服务和经营培训，为村民进行专业的指导，引导村民利用自身房屋、土地优势开办农家乐，成为当地乡村振兴和经济发展的新亮点。</p><p>“文旅扶贫已经取得了明显实效。”东沟村党支部书记张旭介绍，2019年全村实现经济总收入730余万元，旅游接待量达40余万人次，旅游综合收入450余万元，带动周边50余户村民就业创业，90%农村劳动力吃上了“旅游饭”，摘掉了“贫困帽”。</p>	\N	走进湖北十堰市茅箭区茅塔乡东沟村，森林环抱、鸟语花香，精致的民宿依地势而建；这里也曾经烽火连天	2024-05-13 03:39:49
28	\N	\N	追寻红色足迹 传承红色基因——丹江口市税务局开展青年干部红色教育活动	2024-05-13 03:42:40	<p>为强化春训工作，提升春训效果，4月7日，丹江口市税务局组织青年干部来到东沟爱国主义教育基地开展红色主题教育活动，以“实景导学、军事演学、专题联学”等形式，开展“沉浸式”学习体验活动，以“红色精神”赓续奋进力量。</p><p>  </p><p><strong>革命圣地导学 赓续红色血脉</strong></p><p>在中原突围鄂西北历史纪念馆，跟随导游的讲解，干部职工思绪追溯到1946年。在茅塔乡东沟村建立的鄂西北第三军分区、均郧房县委县政府，经历武装斗争后，时任均郧房县委书记朱正传等100余名官兵英勇牺牲，中国新民主主义革命在这里留下了浓墨重彩的一笔。随后观看的纪录片《为国捐躯的县委书记——朱正传》，让青年干部无不为之动容，纷纷赞叹革命先驱为革命胜利流血牺牲的大无畏精神。</p><p><img src="http://www.djkdj.com/yw/jcdj/202404/W020240410710783270159.jpg" alt=""></p><p>“如果信仰有颜色，那一定是中国红，长在红旗下，生在春风里，目光所至皆华夏……”在中原突围鄂西北历史纪念馆前，身着税务蓝的青年干部有序排成方阵队形，齐声朗诵红色诗歌《如果信仰有颜色》，铿锵有力、激情澎湃的朗诵响彻山谷，振奋心灵，激发了青年干部向英烈看齐，努力做共产主义接班人的决心和士气。</p><p><img src="http://www.djkdj.com/yw/jcdj/202404/W020240410710783546381.jpg" alt=""></p><p>  </p><p><strong>户外军事演学 锻造税务铁军</strong></p><p>“敬礼！”在户外拓展场地，随着教官的一声令下，青年干部整齐划一地向左转、向右转、向后转、敬礼，步调整齐统一，眼神坚毅无比，动作规范到位，阳光下，五分钟的军姿站立训练，让青年干部内心更增添了一股军人般的韧性和刚毅。</p><p><img src="http://www.djkdj.com/yw/jcdj/202404/W020240410710783669869.jpg" alt=""></p><p>“向国旗致敬”环节，青年干部面对面分成两纵队，将一面曾在天安门广场前升起过的5米*3.3米的五星红旗依次小心传递，并纷纷行最庄严的注目礼。“齐心写大字”环节，青年干部十人一组拉扯一根巨型毛笔，从四面八方用力，以均衡的力道在红纸上齐心写下“兴”“税”“强”“国”四字，以书写表达“为国聚财，为民收税”的初心使命，引导青年干部心往一处想、劲往一处使，全力推进税收事业发展。</p><p><img src="http://www.djkdj.com/yw/jcdj/202404/W020240410710783918686.jpg" alt=""></p><p><img src="http://www.djkdj.com/yw/jcdj/202404/W020240410710784160430.jpg" alt=""></p><p>  </p><p><strong>主题交流联学 坚定初心使命</strong></p><p>在东沟爱国主义教育基地的会议室内，五个青年理论学习小组共同学习了《习近平专题摘编》5-6章、习近平《论党的青年工作》、习近平总书记关于税收工作的重要论述及省税务局党委《关于在全省税务系统广泛开展向卢东同志学习活动的决定》等文件，3名分别来自政务岗、业务岗、分局岗的青年理论学习小组成员结合自身岗位实际，就参观学习内容、更好落实工作职责，推动丹江税务蓬勃发展谈个人体会和收获。</p><p><img src="http://www.djkdj.com/yw/jcdj/202404/W020240410710784264100.jpg" alt=""></p><p>“当五星红旗在我们手中传递的时候，我想到了革命先烈为了新中国的成立，抛头颅，洒热血的场景，这一刻，我深深地体会到了‘传承’两字的份量，它代表着一份责任感和使命感”。青年干部黄琰在学习交流中分享道。</p><p>通过本次活动，青年干部进一步坚定了理想信念，明确了初心使命，精神得到充分洗礼，思想得到再次升华。大家纷纷表示，将大力弘扬革命先烈不畏艰险、报效祖国的革命精神，担负传承红色基因的强大使命，以奋发有为的姿态展现税务铁军的担当作为，为丹江税务蓬勃发展贡献青春力量。</p>	news-1-66418c30ad6d8879748620.jpg	追寻红色足迹 传承红色基因——丹江口市税务局开展青年干部红色教育活动	2024-05-13 03:42:40
25	\N	\N	东风商用车·2024十堰马拉松圆满举行	2024-05-13 03:40:57	<p><img src="http://maojian.shiyan.gov.cn/xwzx/mjxw_1/202404/W020240415319535198573.jpg" alt=""></p><p>参加东风商用车·2024十堰马拉松的选手从起点十堰奥体中心出发。记者刘旻全正摄</p><p>山水之城，向“绿”先行；汽车之城，向“新”出发。4月14日上午，东风商用车·2024十堰马拉松在市奥体中心鸣枪开跑。市委副书记、市长王永辉，省体育局副局长郑李辉，东风商用车有限公司总经理张小帆，市领导汤红兵、刘学勤、朱云慧、沈明云等出席起跑仪式，为大赛鸣枪发令。</p><p>本次马拉松赛事经中国田径协会官方技术认证，由湖北省体育局、市人民政府主办，市体育局、茅箭区人民政府承办。设有全程马拉松（42.195公里）、半程马拉松（21.0975公里）、健康跑（4公里）三个项目，2万余人参赛，其中，全程马拉松2000余人、半程马拉松3000余人、健康跑15000余人。</p><p>7时30分，随着发令枪响，选手冲出起跑线，沿着紫霄大道、北京路一路向前，踏上了挑战自我的征程。赛道上，既有冲锋在前的专业选手，也有不甘落后的马拉松爱好者；既有年长的老人，也有活力四射的年轻人。大家迈开脚步、甩开臂膀，你追我赶、奋勇争先，用脚步感触十堰城区现代发展的脉络，共同领略城野乡间的自然之趣，共同享受运动带来的愉悦与健康。著名体育主持人、解说员韩乔生现场助力，并作为解说嘉宾现身直播间。</p><p>在起点旁、赛道旁、终点处，加油声、呼喊声不断，市民群众以最饱满的热情为跑友呐喊助威、加油鼓劲。现场指引、物资补给、秩序维护、医疗救护、交通疏导等各类志愿者和工作人员，用“微笑、点赞、加油”为参赛选手提供最有温度的服务，成为赛道上一抹亮丽的风景线。赛道沿线，舞龙、舞狮、音乐加油站、街舞、太极拳、健身操等表演为比赛营造了热烈、向上的赛事氛围。</p><p>一路逐风，拼搏向前。经过激烈角逐，埃塞俄比亚选手 FELATE MULETADEYISA以2小时23分55秒的成绩夺得全程马拉松男子组冠军，埃塞俄比亚选手REGASSA HAWI MEGERSSA以2小时47分32秒的成绩夺得全程马拉松女子组冠军。中国选手刘军、沈妮以1小时9分55秒、1小时18分15秒的成绩分别获得半程马拉松男子组、女子组冠军。</p><p>一步一景之间，马拉松赛成为城市最好的导游，也成为城市魅力与活力的最好注脚。此次赛事活动规模大、影响广、吸引力强，是一次宣传东风、走进十堰的文化体育盛事。近年来，十堰通过举办一场场精品赛事，纵深推进文体旅融合发展，为城市发展注入了更多新动能。（记者闵波刘旻）</p>	\N	山水之城，向“绿”先行；汽车之城，向“新”出发。4月14日上午，东风商用车...	2024-05-13 03:40:57
27	\N	\N	茅箭区茅塔河流域农村生活污水治理见闻	2024-05-13 03:41:40	<p>茅塔河流域生态良好、风景秀丽。特约记者刘沣摄</p><p>记者 纪枫波 刘旻</p><p>十堰是南水北调中线工程核心水源区。高标准治理好农村生活污水，对全面推进乡村振兴、加快建设绿色低碳发展示范区、确保一库碧水永续北送具有重大意义。近年来，茅箭区扎实做好乡村建设“六件事”，将农村污水治理作为小流域综合治理“关键工程”来抓，农村生活污水收集率达90%以上，位居全省前列，美丽乡村建设成效显著。</p><p><strong>污水处理站因地制宜建</strong></p><p>走进茅箭区茅塔乡坪子村，一处处人工湿地绿意盎然，就连环保公厕也自成一景。</p><p>该村村民夏桂荣去年将家中旱厕拆除，取而代之的是一个微型“污水处理站”。“以前，一到夏天，旱厕就臭得很，苍蝇满天飞。现在厕所干净了，空气清新了，环境也跟着变好了。”夏桂荣说。</p><p>“浇肥只需打开三格化粪池小盖板，浇水用小湿地里的水，非常方便！”在该村，市生态环境局茅箭分局局长胡华鹏指着一套小型污水处理设施介绍说，“这是我们正在推广的‘四件套’改厕模式。它不仅能有效解决旱厕污水排放难题，而且净化过的水可用于农业灌溉等。”</p><p>记者采访中了解到，茅箭区对分散居住的农户实行统一规划，推广“水冲式厕所+三格化粪池+沉淀池+小湿地”的“四件套”改厕模式。对10户以上集中居住区，采取“化粪池+沉淀池+微动力设施+人工湿地”改厕模式。目前，茅塔河小流域已实现10户以上集居区、分散农户污水处理设施全覆盖。</p><p>在工艺选择上，新建污水处理设施采用“AO一体化设备+人工湿地”微动力工艺。该设施具有占地面积小、运行成本低、管理维护简单、出水水质稳定等特点，适合在农村推广应用。</p><p>据悉，为妥善处理农村生活污水，茅箭区按“五统一”（统一设计、统一工艺、统一管理、统一考核、统一保障）要求，随湾就片建设微动力、无动力小型化农村污水处理设施，新建的28座一体式、202户分户式“四件套”污水治理设施基本完工。</p><p><strong>牲畜集中养肥水“减肥”排</strong><br>&nbsp;</p><p>走进茅塔乡廖家村集中安置小区，只见绿柳掩映民房，场院整洁干净。虽然不少村民养猪，但村里闻不到臭味、看不到污水。</p><p>该小区共安置村民42户。过去每家每户在房屋旁边建猪舍，平时家里的剩饭剩菜直接喂猪。因廖家村紧邻茅塔河，从猪舍外溢的污水，既污染村庄环境，又影响河流水质。</p><p>该村结合茅塔河小流域综合治理工作要求，以满足村民对美好生活的向往为落脚点，在小区一角配套建设畜禽散养“专区”，供村民集中养殖畜禽。同时，区政府筹措资金46万元，为“专区”配套建设了一座畜禽养殖废水处理站。</p><p>“通过干湿分离机，将干粪、湿粪分离。干粪经厌氧堆肥发酵，可作肥料。湿粪经畜禽养殖废水处理站处理后，流进下游生活污水处理设施，再次进行处理。”山鼎环保科技股份有限公司运营经理饶镇介绍，养殖废水经过两次处理后，可实现达标排放。</p><p>截污减污治污，茅塔乡实现“肥水不外流”。</p><p>记者在廖家村生态脱氮沟示范段看到，110余亩耕地靠近河渠一方，铺设有一条长260米、宽2米、深1.5米的脱氮沟。</p><p>茅箭区农业农村局局长庹文芳介绍，脱氮沟里的滤料由砾石、腐殖土等混合组成，能有效消减地下潜流硝酸盐，最大限度避免氮磷流入茅塔河流域，确保“水不乱流、肥不乱跑、泥不下山”。目前，茅塔河流域已经建成10个脱氮沟示范点。这些脱氮沟，对农业面源污染中的硝酸盐去除率达75%以上，靶向治污成效显著。</p><p>道路整洁，花草绕房；水清岸绿、鱼翔浅底；美丽乡村，生活和美……生态环境的改善，引来大批游客。今年清明节小长假期间，茅箭区油菜花节在廖家村举行，吸引游客纷至沓来，为乡村旅游发展注入了无限生机活力。</p>	\N	十堰是南水北调中线工程核心水源区。高标准治理好农村生活污水，对全面推进乡...	2024-05-13 03:41:40
26	\N	\N	茅箭区：“河长制”厚植“高颜值”生态底色	2024-05-13 03:41:18	<p>“这里山水秀美，景色宜人，水清澈见底，真是舒心养眼！”初春时节，市民刘民富一早就沿着十堰市茅箭区南部山区马赛路骑行，途经营子村桃花湖时，对湖面旖旎风光赞叹不已。</p><p>一湖好水，既是对茅箭绿色生态的赞誉，也是当地“河长制”实施以来带来的显著变化。近年来，该区立足茅塔河小流域综合治理，围绕水资源保护、水污染防治、水环境改善、水生态修复等主要任务，全面开展“碧水保卫战”攻坚行动。明确区级河湖长13名、乡级河湖长44名、村级河湖长56名，三级河长体系全覆盖、全面履职，构建了横向到边、纵向到底的河湖管护网，“河长制”带来河长治，全区所有河流实现“水清、岸绿、河畅、景美”的“高颜值”，厚植了美丽茅箭生态底色。</p><p>汇聚合力，共同呵护源头活水。2月29日，一场春雨过后，茅箭区东城经济开发区鸳鸯村村民瞿天民沿着泗河自发开展灾害巡查，并对沿途发现的垃圾进行清理。在茅箭，像瞿天民这样自发开展河流管护志愿服务的热心群众不在少数。在当地茅塔河流域沿线，经常能看到他们的身影，他们中有老党员、有个体工商户、有中小学生，作为该区治水护水的巡查员、宣传员、示范员，同“官方河长”一起，共同构建了茅箭“河长+”队伍，带动吸引越来越多的群众当起河湖治理的“编外”管护员、监督员，常态化开展“清河净滩”志愿服务活动，共同呵护源头活水，共享美好河湖生态。同时，该区建立“河湖长+法院院长+检察长+警长”协作机制，充分发挥行政各方力量在辖区河湖保护中的监督作用，推动“河长+检察长”“河长+警长”等协作机制，共同守护碧水清流。</p><p>智慧治河，构建保护新格局。“报告指挥中心，无人机巡河发现山脚边有垃圾淤堵，请立即处理靠近。”日前，茅箭区水利和湖泊局工作人员正在采用无人机三维成像巡河模式，沿着茅塔河岸开展巡河，发现人工巡河死角，可立即同步在该区指挥中心通过大屏幕航拍画面进行研判，确保第一时间得到有效处理，巡河效率大大提升。</p><p>近年来，该区先后建成31座水雨情和4座水库动态检测站，借助无人机等智能新技术，快速推进数字孪生流域、数字孪生水网、数字孪生水利工程等建设，对全区8条河流、44条支沟、4座水库、67座塘堰、39处农村饮水工程进行专业化、立体化、常态化、高效化水域巡查，推动巡河、治河、护河由单一式向复合型转变，为流域安全提供科学的决策支持和技术保障。通过全方位的河道管护，做到了问题早发现早处理。去年以来，该区河湖长及联系部门累计巡河3000余次，发现并整改问题400余个；排查辖区44条重点支沟，累计清理沉沙池（井）399座，清淤2914立方米；支沟巡查6700余人次，发现并整改风险隐患126处，河湖生态得到有效保障。</p><p>水清河畅，绘就美丽乡村新画卷。“近几年，茅箭南部山区山体水域环境不断改善，吸引了很多市民群众以及摄影爱好者来这里采风游玩。”“河长制”全面推行以来给乡村带来的新变化，该区赛管局营子村常住村民王显华看在眼里。</p><p>该区先后投入资金约5亿多元，实施马家河、茅塔河、泗河等河道综合治理，修复治理河流70Km。投资350万元，实施茅塔清泉水厂管网延伸工程，提高该区南部山区900余人饮水保障率；争取资金266万元，实施农村小型水利设施维修养护项目，加大39名村级管水员培训，聘请第三方科学配送药剂、滤料，对机电设备进行日常维护；投资1000万元，实施彭家坡小流域、莫家沟小流域和梨花坡生态清洁小流域综合治理项目，治理水土流失面积31.51km2；实施河干流及马家河下游水生态修复工程、王家村游园文化提档升级及马家河水文化EPC项目等，确保山更绿、水更清。</p><p>一泓碧水，是风景线，更是致富线。该区立足绿水青山，赋能旅游促发展，打造了一批景色宜人、社会效益经济效益双赢的涉河滨水项目，重点对马赛路、桃花湖、东沟红色景区等进行提质升级改造，打造出的田园观光、特色民宿、休闲康养、星空露营、农家采摘等精品旅游线路深受市民群众欢迎，为茅箭乡村旅游的高质量发展注入了新动能。</p><p>水环境治理的根本目标是改善人居环境、助力乡村振兴。在该区南部山区，当地把水资源综合治理与改厨改厕、污水处理等相结合，整合生活污水处理、村庄绿化美化靓化等各项资金，统筹生态环保、住建、农业农村、乡村振兴等部门，确保清水长流，推动农村人居环境综合提升。</p><p>以水为景，以景兴业。茅箭区因地制宜发展特色绿色生态产业，东沟村荣获2022年中国美丽休闲乡村荣誉称号，全区建成省级省级乡村振兴示范村9个，现有休闲农业示范园13个、网红乡村民宿15家、生态景区20余个，山水田园农旅文融合发展，催生了“共享经济”，实现绿色发展、群众增收的双赢局面。(通讯员 陈宣霖、韩苗）</p>	\N	茅箭区：“河长制”厚植“高颜值”生态底色	2024-05-13 03:41:18
12	\N	\N	烈士陵园	2024-05-13 03:07:52	<p>　　东沟村烈士陵园是为了缅怀在革命斗争中牺牲的先烈而建立的。特别是在1946年10月，王树声率部及均郧房县总队与国民党地方团进行激战，为掩护部队转移，均郧房县委书记朱正传及38名战士在此牺牲，他们中最大的31岁，最小的只有18岁，甚至还有很多人连名字都没来的及留下。</p><figure class="image"><img src="/images/664437e4eb225-c851042925372b41add2be92e741e000.jpg"></figure><p>　　陵园的建设历程</p><p>　　初始建设：1999年8月，为了集中安葬烈士，将5名分散安葬在山坡丛林中的烈士墓迁移至东沟村二组，新建了东沟革命烈士墓群，占地面积为500平方米。</p><p>　　道路改扩建：2005年，对通往东沟烈士陵园的道路进行了改扩建，提高了陵园的可达性。</p><p>　　全面修建：2011年，由十堰市政园林管理局捐资，对陵园进行了全面的修建。新建的陵园位于原东沟村革命烈士墓左侧，占地面积扩大至6000多平方米，总投资达到80余万元。陵园主要由纪念广场、烈士碑亭和浮雕墙组成。</p><p>　　烈士迁入：2022年9月22日，十堰市茅箭区在东沟烈士陵园纪念广场举行零散烈士墓集中迁葬入园仪式。155座零散烈士墓，迁葬至东沟烈士陵园。其中，可以确定姓名的有19位。</p><figure class="image"><img src="/images/6644380914c83-03968a702214e9520058d80d345170ac.jpg"></figure><p>　　浩气存天地，忠魂归陵园!</p><p>　　东沟烈士陵园不仅是对革命先烈的缅怀之地，也是进行红色教育和爱国主义教育的重要场所。每年清明节前后，前往东沟烈士陵园悼念烈士的游客络绎不绝。此外，十堰各组织、党支部等也会在此开展主题党日活动，激发党员的爱国热情。</p><p>　　朱正传是江苏常州人，毕业于天津南开附中。1943年，朱正传与妻子易齐荇结成革命伴侣，为党的事业，夫妻分隔两地战斗。直到1986年，湖北省十堰市在搜集整理地方党史时，易齐荇才知道朱正传牺牲在十堰。此后，她一有时间就会来十堰东沟纪念自己的丈夫。易齐荇在朱正传烈士牺牲后没有再嫁，他们也没有留下后代。两人的红色爱情故事感动着当地村民，后来，东沟人就把朱正传烈士为革命洒下热血牺牲的这片山谷命名为“念情谷”。</p><p>　　杜鹃花海象征革命烈士化身。在东沟村革命烈士战斗过的山岭有一片杜鹃花海，100余亩，均属野生，每年4至5月盛开，呈现出山花烂漫，宛如仙境的自然风光。其颜色鲜艳夺目，象征着革命烈士的滴滴鲜血，染红了东沟的山野。来此瞻仰的游客在享受自然风光的同时，被这里的红军遗物、红色故事、红色文化所熏陶教育，深受启迪，弘扬革命先烈的英雄精神，珍惜今天的幸福生活。</p>	jingqu-2-66418408a3912586135449.jpg	东沟村烈士陵园是为了缅怀在革命斗争中牺牲的先烈而建立的	2024-05-13 03:07:52
6	\N	1	田园诗画 生态乡村	2024-05-13 00:56:40	\N	index-banner3-1-66449480e0a78506346895.jpg	Rural poetry, painting, ecological countryside	2024-05-15 10:54:56
72	\N	\N	吃在东沟	2024-05-14 01:56:26	\N	\N	这里的食材都是自家种植、新鲜 采摘的，每一道菜都蕴含着农人 的辛勤与热情，让你感受到家的温暖。 你不仅能品尝到地道的农家菜	2024-05-14 01:56:26
7	\N	\N	秦巴古驿 文化传承	2024-05-13 00:58:11	\N	home-slider-1-664165a439a4d325249184.jpg	Inheritance of Qinba Ancient Post Culture	2024-05-13 00:58:12
18	\N	\N	游在东沟	2024-05-13 03:20:47	\N	leyou-1-664187103139f326225825.jpg	东沟已形成集接受爱国教育、欣赏自然风光、体验农家风情，观摩新农村建设...	2024-05-13 03:20:48
45	\N	\N	红色文化	2024-05-14 01:23:18	\N	\N	革命战争时期，贺龙、王树声等老一辈革命家曾在此处留下了战斗的足迹，东沟也见证了许多英勇的斗争和牺牲。	2024-05-14 01:23:18
41	\N	\N	飞机出行	2024-05-13 09:47:36	<p>乘坐飞机至十堰武当山机场，搭乘网约车至东沟景区游客服务中心或乘坐公共交通。&nbsp;</p><p>公交路线：搭乘机场公共快线2号线至东环路出口站，换乘97路至东风铸造厂站，换乘26路至东风铸造二厂站，换乘66路至茅塔念情谷站。</p>	plane-green-6641e1b8db9b3769167378.png	\N	2024-05-13 09:47:36
43	\N	\N	客车出行	2024-05-13 09:49:24	<p>乘坐客运大巴至十堰客运中心站，搭乘网约车至东沟景区游客服务中心或乘坐公共交通。 公交路线：搭乘9路/658路至至东风铸造二厂站，换乘66路至茅塔念情谷站。</p>	bus-green-6641e224e128b620672102.png	\N	2024-05-13 09:49:24
42	\N	\N	火车出行	2024-05-13 09:48:56	<p>乘坐高铁到达十堰东站或十堰站，搭乘网约车至东沟景区游客服务中心或乘坐公共交通。&nbsp;</p><p>公交路线：&nbsp;</p><p>1.从十堰东站乘坐96路至太和医院站，换乘9路至东风铸造二厂站，换乘66路至茅塔念情谷站。</p><p>&nbsp;2.从十堰站乘坐2路/202路/205路至东风铸造二厂站，换乘66路至茅塔念情谷站。</p>	train-green-6641e20966279692078075.png	\N	2024-05-13 09:48:57
69	\N	\N	东沟干货	2024-05-14 01:53:03	\N	leyou-slider4-2-6642c4005b0f9928350216.jpg	东沟干货，来自于农户手工制作的干笋、红薯干、果干、干菜等	2024-05-14 01:53:04
66	\N	\N	土猪肉炖萝卜	2024-05-14 01:51:19	\N	chizai-7-6642c39816dee626604583.jpg	俗话说：“冬吃萝卜夏吃姜”。一到冬天就想起萝卜炖肉了，土猪肉的香浓，吸满肉汁萝卜的绵软，既美味又养生。一家人团坐在一起，温暖幸福萦绕心头。	2024-05-14 01:51:20
44	\N	\N	自驾出行	2024-05-13 09:49:48	<p>十堰——东沟景区游客服务中心</p><p>导航至“东沟景区游客服务中心”道路名：茅箭区-东沟路。</p>	car-green-6641e23d5adbc457346214.png	\N	2024-05-13 09:49:49
49	\N	\N	东沟历史	2024-05-14 01:28:14	\N	\N	东沟拥有悠久的农耕文明，《尚书.牧誓》记载，茅箭古称西土八国中的“髳国”，明代韩弼、清代贾洪诏均有《十堰春耕》的诗...	2024-05-14 01:28:14
70	\N	\N	贺大姐麻豆、腐乳	2024-05-14 01:53:19	\N	leyou-slider4-3-6642c4100e961050543409.jpg	贺大姐麻豆、腐乳是东沟村的特产。它制作精细，具有细、黄、软特色，五味调和，滋味香酥。	2024-05-14 01:53:20
68	\N	\N	东沟子矜染坊草木蓝染	2024-05-14 01:52:45	\N	leyou-slider4-1-6642c3ee0e6f0592438041.jpg	东沟子矜染坊草木蓝染采用纯天然植物提取染料，通过非遗传承的工艺，手工制作而成	2024-05-14 01:52:46
67	\N	\N	美食	2024-05-14 01:51:31	\N	chizai-8-6642c3a39ecf7018003760.jpg	\N	2024-05-14 01:51:31
54	\N	\N	云上牡丹园海拔600米	2024-05-14 01:39:42	\N	65128fde684487954518d62109c525e3-6644970cd2cb9350276106.jpg	\N	2024-05-15 11:05:48
71	\N	\N	陶艺体验及成品	2024-05-14 01:53:43	\N	leyou-slider4-4-6642c43f4d3b1439814939.jpg	东沟陶艺陶艺坊，是一个充满温馨和爱心的大家庭	2024-05-14 01:54:07
53	\N	\N	湖北脱贫攻坚先进集体	2024-05-14 01:34:24	\N	honor-4-6642bfa0a33f6372870420.jpg	湖北脱贫攻坚先进集体	2024-05-14 01:34:24
52	\N	\N	湖北省廉政教育基地	2024-05-14 01:34:10	\N	honor-3-6642bf928d7cc515304617.jpg	湖北省廉政教育基地	2024-05-14 01:34:10
51	\N	\N	湖北省爱国主义教育基地	2024-05-14 01:33:55	\N	honor-2-6642bf83e3165911927641.jpg	\N	2024-05-14 01:33:55
50	\N	\N	全国生态文化村	2024-05-14 01:33:37	\N	honor-1-6642bf724480b871153665.jpg	\N	2024-05-14 01:33:38
60	\N	\N	茅塔百花蜜	2024-05-14 01:49:47	\N	chizai-1-6642c33c3eff4329249987.jpg	\N	2024-05-14 01:49:48
61	\N	\N	野生猕猴桃	2024-05-14 01:50:06	\N	chizai-2-6642c34f513a6940761446.jpg	\N	2024-05-14 01:50:07
62	\N	\N	家常腊肉	2024-05-14 01:50:21	\N	chizai-3-6642c35e063d8153396802.jpg	腊肉是指肉经腌制后再经过烘烤(或日光下曝晒)的过程所成的加工品。防腐能力强，能延长保存时间，并增添特有的风味，这是与咸肉的主要区别。过去腊肉都是在农历腊月(12月)加工，故称腊肉。	2024-05-14 01:50:22
63	\N	\N	东沟神仙叶凉粉	2024-05-14 01:50:36	\N	chizai-4-6642c36cbaf3f813874982.jpg	\N	2024-05-14 01:50:36
101	\N	\N	中原突围鄂西北历史纪念馆	2024-05-15 05:51:33	\N	leyou-slider-1-6642c0f0e95ff915268162-66444d65600ef012849063-1-66448937469fb884675197.jpg	\N	2024-05-15 10:06:47
64	\N	\N	熏香肠腊肉	2024-05-14 01:50:53	\N	chizai-5-6642c37d91931360787532.jpg	东沟腊味，别具风情！腊味顾名思意为农历腊月腌制的肉制品。而东沟的熏香肠腊肉在湖北可谓一绝！	2024-05-14 01:50:53
65	\N	\N	土鸡火锅	2024-05-14 01:51:06	\N	chizai-6-6642c38a7ad9c957355598.jpg	冷冷的天让人特别想吃火锅，鲜烫香的滋味在嘴里不停打转。毫不夸张地说，东沟土鸡锅无论从外观、颜色，还是从味道、营养上来比较都是更胜一筹。	2024-05-14 01:51:06
8	\N	\N	红色基地 革命记忆	2024-05-13 00:59:02	\N	index-banner1-1-6644943a49cca896509018.jpg	Revolutionary Memory of the Red Base	2024-05-15 10:53:46
56	\N	\N	杜鹃岭以其盛开的杜鹃花而闻名	2024-05-14 01:40:21	\N	82b36c46a75b33718f8a30444099c872-1-66449701edd81919522370.jpg	\N	2024-05-15 11:05:37
39	\N	\N	东沟简介	2024-05-13 09:33:56	\N	\N	东沟村位于十堰市茅箭区茅塔乡，属于湖北赛武当国家级自然保护区试验区和缓冲区范围，面积11.4平方公里，距十堰市城区13公里。东沟村地处山区，自然资源丰富自然资源丰富，是全区公益林、用材林、茶叶种植基地的重要区域。森林覆盖率高达92%，在生态环境保护中具有重要战略地位。\r\n东沟村也是红色革命老区村，曾在革命战争时期设立过鄂西北第三军分区、均郧房县中心县委、县政府、县总队等重要机构。贺龙、王树声等老一辈革命家曾在这里战斗过，留下了丰富的红色历史遗迹。\r\n除了红色旅游资源外，东沟村依托其良好的生态资源，大力发展生态游。村庄内形成了“高山植松杉、低山种绿茶、旱地种林果、平坝蔬菜花”的立体生态格局。此外，景区内的念情谷景点内还引来了深山猕猴与游客零距离嬉戏玩耍，为游客提供了丰富的自然体验。以桃源人家为代表的特色民宿，正成为当下游客首选的旅行方式，民宿综合体内的咖啡馆、民俗布染坊、陶艺坊、国学堂等，为从城市而来的游客提供了更多的选择。\r\n经过20多年的持续打造，总投资近10亿元，东沟村正逐渐成为一个集革命历史、红色文化、民俗文化和自然风光于一体的综合性旅游景区。东沟村将持续加大景区建设力度，进一步加强旅游宣传推广力度，扩大东沟红色旅游的知名度和影响力，努力争创“4A”级景区和湖北旅游名村。	2024-05-13 09:33:56
13	\N	\N	云上牡丹园	2024-05-13 03:08:38	<p>　　云上牡丹园位于十堰市茅箭区茅塔乡东沟村二组，海拔600米。</p><p>　　因每逢小雨，满山云雾缭绕，故而得名“云上牡丹园”。</p><p>　　园区面积达100多亩，种植有各类牡丹共计6万余株。园内牡丹花色丰富，包括粉色、红色、白色和紫色等，争奇斗艳，为游客带来绝佳的视觉体验。</p><p>　　逛完云上牡丹园，还可以去云上微民宿住上一晚。云上微民宿建在海拔600米的悬崖边，群山环抱，花海环绕，白天推窗可见美丽风景，夜晚抬头仰望璀璨星空。</p><p>　　云上牡丹园通常在每年的4月初至5月初开放，具体时间根据当年的气候和花期而定。</p>	jingqu-3-6641843749354398759863.jpg	\N	2024-05-13 03:08:39
14	\N	\N	念情谷—猕猴园	2024-05-13 03:09:22	<p>　　念情谷猕猴园位于十堰市茅箭区茅塔乡东沟村</p><p>　　念情谷的名字的由来，还有一段可歌可泣的爱情故事，1943年，朱正传与妻子易齐荇结成革命伴侣，为党的事业，夫妻分隔两地战斗。1946年时任均郧房县委书记的朱正传及38名战士，为掩护部队转移，在此牺牲。直到1986年，湖北省十堰市在搜集整理地方党史时，易齐荇才知道朱正传牺牲在十堰。此后，她一有时间就会来十堰东沟纪念自己的丈夫。易齐荇在朱正传烈士牺牲后没有再嫁，他们也没有留下后代。两人的红色爱情故事感动着当地村民，后来，东沟人就把朱正传烈士为革命洒下热血牺牲的这片山谷命名为“念情谷”。</p><p>　　而如今的念情谷由于东沟生态环境的保护，吸引了大量游客前来休闲游玩，被一起吸引而来的还有来自深山的野生猕猴。如今猕猴园内现有野生猕猴近500只，在猴群管理上主要采取人工看护式管理模式，尽可能不干涉猴群发展，猕猴本就灵活聪慧，生活在自然山林内的猕猴则更加机敏，悬崖绝壁上下攀跃自如。</p><p>　　园内有登山游步道、猕猴互动平台、观景亭、景观桥等设施，自然风貌与人造景观交相辉映。</p><p>&nbsp;</p>	jingqu-4-66418462a1751250179579.jpg	\N	2024-05-13 03:09:22
102	\N	\N	文明村	2024-05-15 06:27:51	\N	qq-jie-tu20240515142453-664455e77acbc319318084.jpg	\N	2024-05-15 06:27:51
73	\N	\N	鄂西北农耕博物园	2024-05-14 04:34:02	\N	\N	\N	2024-05-14 04:34:02
74	\N	\N	念情谷—猕猴园	2024-05-14 04:35:20	\N	qq-jie-tu20240515141138-6644524e6d6d0305121329-1-664489d85af12982470514.jpg	\N	2024-05-15 10:09:28
75	\N	\N	东沟烈士陵园	2024-05-14 04:37:00	\N	fbbcc4a4bb56b3165c6f7a69029c1194-1-6644963b8e6d4890672557.jpg	\N	2024-05-15 11:02:19
15	\N	\N	杜鹃岭	2024-05-13 03:09:52	<p>　　杜鹃岭是一个以杜鹃花为主题的自然景观，它位于东沟村境内，是该村的一大亮点。</p><p>　　杜鹃岭以其盛开的杜鹃花而闻名。每年春季，尤其是4月至5月期间，这里的野生杜鹃花进入盛放期，满山遍野的杜鹃花竞相绽放，形成一片绚丽多彩的花海。杜鹃花的颜色丰富多样，有粉红、粉白、紫红色等，花朵繁茂华丽，远望宛如云霞般灿烂。杜鹃岭与周围的青山绿树相互映衬，构成了一幅绝美的自然画卷。</p><p>　　游客来到杜鹃岭，可以沿着山间小径漫步，欣赏沿途盛开的杜鹃花。花朵散发出阵阵香气，让人陶醉其中。在这里，你可以感受到春天的气息，享受大自然的馈赠。同时，杜鹃岭还提供了观景台等设施，方便游客驻足观赏、拍照留念。</p>	jingqu-5-66418480d6487561204136.jpg	\N	2024-05-13 03:09:52
76	\N	\N	国字号荣誉！茅箭区东沟村获评2022年中国美丽休闲乡村	2024-05-14 06:42:10	<p><br>　　2022年11月14日，记者从十堰市文旅局获悉，农业农村部公布了中国美丽休闲乡村推介结果，推介北京市门头沟区妙峰山镇炭厂村等255个乡村为2022年中国美丽休闲乡村，湖北共有10地上榜。十堰市仅茅箭区茅塔乡东沟村上榜其中，成功获评2022年中国美丽休闲乡村。<br><img src="http://news.cjn.cn/hbpd_19912/sy_19931/202211/W020221116362984854574.png" alt="点击查看高清原图"><br><br>　　快来一起看看，东沟村有多美吧！<br>&nbsp;</p><figure class="image"><img src="http://news.cjn.cn/hbpd_19912/sy_19931/202211/W020221116362984869820.png" alt="点击查看高清原图"></figure><p><br><br>&nbsp;</p><figure class="image"><img src="http://news.cjn.cn/hbpd_19912/sy_19931/202211/W020221116362984911738.png" alt="点击查看高清原图"></figure><p><br><br>　　近年来，东沟村紧紧依托红色旅游资源和生态旅游资源优势，秉承“把农村当成景区来建设，把农居当成旅馆来改造，把农田山水当作旅游基地来经营”的理念，通过红色文化“搭台”、生态旅游“唱戏”，推进农文旅深度融合，走出了一条以生态农业为“基”、美丽田园为“韵”、特色民宿为“形”、红色文化为“魂”的发展新路子，成为远近闻名的“网红村”，先后荣获十堰市生态家园示范村、十堰市乡村振兴示范村、全国生态文化村等称号。<br>&nbsp;</p><figure class="image"><img src="http://news.cjn.cn/hbpd_19912/sy_19931/202211/W020221116362984976416.png" alt="点击查看高清原图"></figure><p><br><br>&nbsp;</p><figure class="image"><img src="http://news.cjn.cn/hbpd_19912/sy_19931/202211/W020221116362985020373.png" alt="点击查看高清原图"></figure><p><br><br>　　2021年，全村实现经济总收入800余万元，农民人均纯收入16234元，村集体经济收入达68万元，90％的村民吃上了“旅游饭”。（记者 周仑）<br><img src="http://news.cjn.cn/hbpd_19912/sy_19931/202211/W020221116362985049500.png" alt="点击查看高清原图"><br>&nbsp;</p>	\N	国字号荣誉！茅箭区东沟村获评2022年中国美丽休闲乡村	2024-05-14 06:42:10
24	\N	\N	【乡村振兴看湖北】十堰茅箭：农文旅融合打造中国美丽休闲乡村	2024-05-13 03:40:32	<p>央广网十堰11月18日消息（记者朱娜 通讯员万月 余文涛）农村变景区、农园变游园、农居变旅店、农产品变旅游商品……在湖北省十堰市茅箭区，初冬时节的东沟村静谧祥和，别有一番韵味，吸引了不少周边游客前来打卡参观。</p><figure class="image"><img src="http://inews.gtimg.com/newsapp_bt/0/15437315308/1000" alt="图片"></figure><p>东沟村（央广网发 王鹏 摄）</p><figure class="image"><img src="http://inews.gtimg.com/newsapp_bt/0/15437315313/1000" alt="图片"></figure><p>东沟猕猴园（央广网发 王鹏 摄）</p><figure class="image"><img src="http://inews.gtimg.com/newsapp_bt/0/15437315316/1000" alt="图片"></figure><p>东沟村建筑与周边环境融为一体（央广网发 王鹏 摄）</p><p>不久前，东沟村成功入选“2022年中国美丽休闲乡村”。近年来，茅箭区紧紧依托红色旅游资源和生态旅游资源优势，秉承“把农村当成景区来建设，把农居当成旅馆来改造，把农田山水当作旅游基地来经营”的理念，通过红色文化搭台、生态旅游唱戏，推进农文旅深度融合，走出了一条以生态农业为“基”、美丽田园为“韵”、特色民宿为“形”、红色文化为“魂”的发展新路子，茅箭区东沟村、营子村已成为远近闻名的“网红村”。</p><figure class="image"><img src="http://inews.gtimg.com/newsapp_bt/0/15437315318/1000" alt="图片"></figure><p>东沟村樱花茶园（央广网发 茅箭区融媒体中心供图）</p><figure class="image"><img src="http://inews.gtimg.com/newsapp_bt/0/15437315319/641" alt="图片"></figure><p>东沟桃源人家民宿（央广网发 王鹏 摄）</p>	\N	在湖北省十堰市茅箭区，初冬时节的东沟村静谧祥和，别有一番韵味，吸引了不少周边游客前来打卡参观	2024-05-13 03:40:32
29	\N	\N	产投集团赴东沟红色廉政教育基地开展党纪学习教育	2024-05-13 03:43:17	<p>为扎实推进党纪学习教育，进一步推进廉洁教育常态化长效化，2024年4月18日，产投集团组织全体党员赴东沟红色廉政教育基地开展党性教育主题实践活动，通过参观学习，重温革命历史、缅怀革命先烈，感悟革命先辈初心，进一步严明纪律规矩，汲取奋进力量。</p><p>青山脚下埋忠骨，英烈精神代代传。在初晴的阳光中，东沟烈士陵园烈士纪念碑巍峨耸立，集团全体党员干部面向革命烈士纪念碑列队肃立，重温入党誓词，深切缅怀革命先烈英勇顽强、不怕牺牲、无私奉献的革命精神。</p><p>怀着崇高的敬意，大家走进东沟红色廉政教育基地，环顾墙上那些斑驳脱落的印记，通过一张张历史珍贵照片和文字资料，大家直观的了解到党在不同时期、不同阶段开展廉政建设的坚定决心和有力举措，对严守纪律、廉洁自律有了更加坚定的意志。</p><p>“英勇奋战的红色故事鼓舞人心，廉洁清正的纪律作风振奋人心”，下一步，产投集团将持之以恒综合运用党性教育、纪律教育、警示教育和廉洁文化教育等多种形式，切实将党纪学习教育延伸到“神经末梢”。</p><p><img src="http://gzw.shiyan.gov.cn/djyd/dwgk/202404/W020240419617769129043.png" alt=""></p><p><img src="http://gzw.shiyan.gov.cn/djyd/dwgk/202404/W020240419617769539616.png" alt=""></p><p><br>&nbsp;</p>	news-2-66418c557a0b1820688374.jpg	为扎实推进党纪学习教育，进一步推进廉洁教育常态化长效化，2024年4月18日，产投集团组织全体党员赴东沟红色廉政教育基地开展党性教育主题实践活动，	2024-05-13 03:43:17
77	\N	\N	东沟荣誉	2024-05-15 00:09:24	\N	honor-6643fd34e1cd2894827618.png	\N	2024-05-15 00:09:24
78	\N	\N	陶艺	2024-05-15 03:34:39	<p>　　陶艺是一种承载着深厚文化底蕴的艺术形式，它的体验过程充满了创造性和挑战性，陶艺不仅仅是泥土和水的结合，更是文化和思想的交流，它不仅涉及到制作技术，还包含了对陶瓷文化的理解和感悟。</p><p>　　在体验过程中，参与者可以从基础的泥料制备开始，经过成型、上釉、烧制等一系列步骤，最终制作出属于自己的陶瓷作品。这一过程不仅可以提高动手能力，还能增强感知力、创造力和观察力。</p>	zoujin-slider2-2-6642bdaace339580569263-66442d4f5ab92838959589.jpg	陶艺是一种承载着深厚文化底蕴的艺术形式	2024-05-15 03:34:39
103	\N	\N	荆楚最美乡村	2024-05-15 06:28:33	\N	qq-jie-tu20240515142523-6644561156af1077203298.jpg	\N	2024-05-15 06:28:33
81	\N	\N	纪念馆	2024-05-15 03:41:27	<p>中原突围鄂西北历史纪念馆，位于茅塔乡东沟村均郧房县委县政府旧址，该址建于明清时期，是开明乡绅周宗裔的祖宅。纪念馆内主要由党史陈列室、茅箭区国防教育展示厅、电教厅等展厅构成。这些展厅通过图片、文物和多媒体等形式，生动地展示了中原突围鄂西北革命斗争的历史。 、</p><p>作为十堰市“青少年爱国主义教育基地”、茅箭区青少年“德育教育基地”，以及位于十堰城区唯一的未成年人思想道德教育基地，东沟爱国主义教育基地在推动青少年教育和乡村振兴方面发挥着重要作用。&nbsp;</p>	zoujin-slider2-1-6642bd7a0e33c626902600-66442ee74274c434933944.jpg	中原突围鄂西北历史纪念馆，位于茅塔乡东沟村均郧房县委县政府旧址，该址建于明清时期，是开明乡绅周宗裔的祖宅	2024-05-15 03:41:27
82	\N	\N	爱莲说	2024-05-15 03:42:26	<p>　　中原突围鄂西北历史纪念馆除了展现老一辈革命家曾在此处留下的战斗足迹，廉洁教育也是纪念馆的一大两点，位于景区内的东沟学堂展示了大量丰富翔实的图片和文字资料，从中国传统孝廉典故到毛泽东等老一辈革命家的廉洁故事、家风家训，再到茅箭清廉家庭典型事迹、党员干部手写家书，这些内容不仅帮助人们全面了解党的反腐历史，而且在清廉文化的浓厚氛围中与老一辈艰苦战斗的环境下弘扬优良传统、筑牢理想信念。</p>	\N	中原突围鄂西北历史纪念馆除了展现老一辈革命家曾在此处留下的战斗足迹，廉洁教育也是纪念馆的一大亮点...	2024-05-15 03:42:26
83	\N	\N	东沟烈士陵园	2024-05-15 03:43:22	<p>1946年10月，王树声率部及均郧房县总队与国民党地方团进行激战，为掩护部队转移，均郧房县委书记朱正传及38名战士在此牺牲，他们中最大的31岁，最小的只有18岁，甚至还有很多人连名字都没来的及留下。</p><p>&nbsp;浩气存天地，忠魂归陵园！&nbsp;</p><p>东沟烈士陵园不仅是对革命先烈的缅怀之地，也是进行红色教育和爱国主义教育的重要场所。每年清明节前后，前往东沟烈士陵园悼念烈士的游客络绎不绝。此外，十堰各组织、党支部等也会在此开展主题党日活动，激发党员的爱国热情。</p>	zoujin-slider2-2-6642bdaace339580569263-66442f5a6ce1e806618835.jpg	东沟烈士陵园不仅是对革命先烈的缅怀之地，也是进行红色教育和爱国主义教育的重要场所。	2024-05-15 03:43:22
90	\N	\N	蛙声十里	2024-05-15 05:28:10	\N	leyou-slider3-1-6642c260394a7616312954-664447ea24287641645867.jpg	蛙声十里位于东沟村二组对面则是荷塘月色，这里远离喧嚣...	2024-05-15 05:28:10
79	\N	\N	草木染	2024-05-15 03:36:27	<p>　　草木染，又称植物染，是一种利用植物材料对织物进行染色的传统手工艺技术。它源自史前时期，至今已有数千年的历史。在新石器时代，祖先们就在采集过程中发现了许多花果植物的根、茎、皮、叶等可以提取汁液，用作染色。经过不断的实践与探索，古人掌握了运用植物汁液来染色的方法，创造了丰富多彩的染色技术，使得草木染成为中国古代主流的染色技法。</p>	zoujin-slider2-1-6642bd7a0e33c626902600-66442dbb129e0321868930.jpg	草木染，又称植物染，是一种利用植物材料对织物进行染色的传统手工艺技术	2024-05-15 03:36:27
80	\N	\N	草木染水彩图	2024-05-15 03:37:36	<p>　　草木染以渐变、水彩图案为主，用中式写意的手法传达着古朴淡雅的意蕴，以蓝白二色为主调。扎染服饰，质地舒适健康，色泽清淡雅致，适合各种场合穿着。寓教于乐，亲手制作一件草木染作品，一定会让你成就感满满。 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</p>	qq-jie-tu20240515114416-6644302dbbdc7349333804.jpg	草木染以渐变、水彩图案为主，用中式写意的手法传达着古朴淡雅的意蕴，以蓝白二色为主调。	2024-05-15 03:46:53
91	\N	\N	桃源人家	2024-05-15 05:28:48	\N	leyou-slider3-2-6642c2cb50f19892772311-6644481016576242886021-1-6644a20c5ba6d674788756.jpg	桃源人家位于茅箭区茅塔乡东沟村，提供餐饮及住宿。可同时...	2024-05-15 11:52:44
89	\N	\N	山顶美宿	2024-05-15 05:26:58	\N	leyou-slider3-3-6642c2ed1b85f272204344-664447a2e86cf179697173.jpg	山顶美宿位于东沟景区境内，藏于一片山野之中，附近有茶园...	2024-05-15 05:26:58
88	\N	\N	张家小院农家乐	2024-05-15 05:22:47	\N	leyou-slider3-2-6642c2cb50f19892772311-66444a1df2908018114352.jpg	张家小院农家乐	2024-05-15 05:37:33
87	\N	\N	丹荷聚农家乐	2024-05-15 05:21:53	\N	leyou-slider3-2-6642c2cb50f19892772311-66444a2c07129942647299.jpg	丹荷聚农家乐丹荷聚农家乐丹荷聚农家乐	2024-05-15 05:37:48
99	\N	\N	烈士陵园	2024-05-15 05:45:37	<p>　东沟村烈士陵园是为了缅怀在革命斗争中牺牲的先烈而建立的。特别是在1946年10月，王树声率部及均郧房县总队与国民党地方团进行激战，为掩护部队转移，均郧房县委书记朱正传及38名战士在此牺牲，他们中最大的31岁，最小的只有18岁，甚至还有很多人连名字都没来的及留下。</p><figure class="image"><img src="/images/664437e4eb225-c851042925372b41add2be92e741e000.jpg"></figure><p>　　陵园的建设历程</p><p>　　初始建设：1999年8月，为了集中安葬烈士，将5名分散安葬在山坡丛林中的烈士墓迁移至东沟村二组，新建了东沟革命烈士墓群，占地面积为500平方米。</p><p>　　道路改扩建：2005年，对通往东沟烈士陵园的道路进行了改扩建，提高了陵园的可达性。</p><p>　　全面修建：2011年，由十堰市政园林管理局捐资，对陵园进行了全面的修建。新建的陵园位于原东沟村革命烈士墓左侧，占地面积扩大至6000多平方米，总投资达到80余万元。陵园主要由纪念广场、烈士碑亭和浮雕墙组成。</p><p>　　烈士迁入：2022年9月22日，十堰市茅箭区在东沟烈士陵园纪念广场举行零散烈士墓集中迁葬入园仪式。155座零散烈士墓，迁葬至东沟烈士陵园。其中，可以确定姓名的有19位。</p><figure class="image"><img src="/images/6644380914c83-03968a702214e9520058d80d345170ac.jpg"></figure><p>　　浩气存天地，忠魂归陵园!</p><p>　　东沟烈士陵园不仅是对革命先烈的缅怀之地，也是进行红色教育和爱国主义教育的重要场所。每年清明节前后，前往东沟烈士陵园悼念烈士的游客络绎不绝。此外，十堰各组织、党支部等也会在此开展主题党日活动，激发党员的爱国热情。</p><p>　　朱正传是江苏常州人，毕业于天津南开附中。1943年，朱正传与妻子易齐荇结成革命伴侣，为党的事业，夫妻分隔两地战斗。直到1986年，湖北省十堰市在搜集整理地方党史时，易齐荇才知道朱正传牺牲在十堰。此后，她一有时间就会来十堰东沟纪念自己的丈夫。易齐荇在朱正传烈士牺牲后没有再嫁，他们也没有留下后代。两人的红色爱情故事感动着当地村民，后来，东沟人就把朱正传烈士为革命洒下热血牺牲的这片山谷命名为“念情谷”。</p><p>　　杜鹃花海象征革命烈士化身。在东沟村革命烈士战斗过的山岭有一片杜鹃花海，100余亩，均属野生，每年4至5月盛开，呈现出山花烂漫，宛如仙境的自然风光。其颜色鲜艳夺目，象征着革命烈士的滴滴鲜血，染红了东沟的山野。来此瞻仰的游客在享受自然风光的同时，被这里的红军遗物、红色故事、红色文化所熏陶教育，深受启迪，弘扬革命先烈的英雄精神，珍惜今天的幸福生活。</p>	fbbcc4a4bb56b3165c6f7a69029c1194-1-66449e5b0d56d978333710.jpg	东沟村烈士陵园是为了缅怀在革命斗争中牺牲的先烈而建立的	2024-05-15 11:36:59
85	\N	\N	鄂西北农耕博物园	2024-05-15 04:21:43	<p>　鄂西北农耕博物园</p>	jingqu-2-66418408a3912586135449-6644385761f58544134230.jpg	鄂西北农耕博物园	2024-05-15 04:21:43
93	\N	\N	荷塘月色	2024-05-15 05:43:29	<p>荷塘月色</p>	a48e1f4883d1391aacb9a446c58b9b59-1-6644a0a5dff95484804402.jpg	荷塘月色	2024-05-15 11:46:45
98	\N	\N	云上牡丹园	2024-05-15 05:45:19	<p>云上牡丹园</p>	65128fde684487954518d62109c525e3-1-66449d7bc3e38381797625.jpg	云上牡丹园	2024-05-15 11:33:15
97	\N	\N	念情谷—猕猴园	2024-05-15 05:45:02	<p>念情谷—猕猴园</p>	qq-jie-tu20240515141138-6644524e6d6d0305121329-1-664489d85af12982470514-6644a0c8e39b1839503825.jpg	念情谷—猕猴园	2024-05-15 11:47:20
94	\N	\N	梅花茶园	2024-05-15 05:43:47	<p>梅花茶园</p>	f07a8139d20ec1b03a0418342a112612-1-6644a04cec66e324865133.jpg	梅花茶园	2024-05-15 11:45:16
96	\N	\N	杜鹃岭	2024-05-15 05:44:41	<p>杜鹃岭</p>	82b36c46a75b33718f8a30444099c872-1-6644a0b8474b3768998719.jpg	杜鹃岭	2024-05-15 11:47:04
104	\N	\N	国字号荣誉！茅箭区东沟村获评2022年中国美丽休闲乡村	2024-05-15 11:24:12	<p>&nbsp; &nbsp; &nbsp; 11月14日，记者从十堰市文旅局获悉，农业农村部公布了中国美丽休闲乡村推介结果，推介北京市门头沟区妙峰山镇炭厂村等255个乡村为2022年中国美丽休闲乡村，湖北共有10地上榜。十堰市仅茅箭区茅塔乡东沟村上榜其中，成功获评2022年中国美丽休闲乡村。</p><p>&nbsp; &nbsp; &nbsp; 快来一起看看，东沟村有多美吧！</p><figure class="image"><img src="http://news.cjn.cn/hbpd_19912/sy_19931/202211/W020221116362984869820.png"></figure><p>&nbsp; &nbsp; &nbsp; &nbsp;近年来，东沟村紧紧依托红色旅游资源和生态旅游资源优势，秉承“把农村当成景区来建设，把农居当成旅馆来改造，把农田山水当作旅游基地来经营”的理念，通过红色文化“搭台”、生态旅游“唱戏”，推进农文旅深度融合，走出了一条以生态农业为“基”、美丽田园为“韵”、特色民宿为“形”、红色文化为“魂”的发展新路子，成为远近闻名的“网红村”，先后荣获十堰市生态家园示范村、十堰市乡村振兴示范村、全国生态文化村等称号。</p><figure class="image"><img src="http://news.cjn.cn/hbpd_19912/sy_19931/202211/W020221116362984911738.png"></figure><p>&nbsp; &nbsp; &nbsp; &nbsp;2021年，全村实现经济总收入800余万元，农民人均纯收入16234元，村集体经济收入达68万元，90％的村民吃上了“旅游饭”。（记者 周仑）</p>	\N	国字号荣誉！茅箭区东沟村获评2022年中国美丽休闲乡村	2024-05-15 11:24:12
105	\N	\N	【乡村振兴看湖北】十堰茅箭：农文旅融合打造中国美丽休闲乡村	2024-05-15 11:30:03	<p>央广网十堰11月18日消息（记者朱娜 通讯员万月 余文涛）农村变景区、农园变游园、农居变旅店、农产品变旅游商品……在湖北省十堰市茅箭区，初冬时节的东沟村静谧祥和，别有一番韵味，吸引了不少周边游客前来打卡参观。</p><p><img src="http://inews.gtimg.com/newsapp_bt/0/15437315308/1000"><br>东沟村（央广网发 王鹏 摄）</p><p><img src="http://inews.gtimg.com/newsapp_bt/0/15437315313/1000"><br>东沟猕猴园（央广网发 王鹏 摄）</p><figure class="image"><img src="http://inews.gtimg.com/newsapp_bt/0/15437315316/1000"></figure><p>东沟村建筑与周边环境融为一体（央广网发 王鹏 摄）</p><p>不久前，东沟村成功入选“2022年中国美丽休闲乡村”。近年来，茅箭区紧紧依托红色旅游资源和生态旅游资源优势，秉承“把农村当成景区来建设，把农居当成旅馆来改造，把农田山水当作旅游基地来经营”的理念，通过红色文化搭台、生态旅游唱戏，推进农文旅深度融合，走出了一条以生态农业为“基”、美丽田园为“韵”、特色民宿为“形”、红色文化为“魂”的发展新路子，茅箭区东沟村、营子村已成为远近闻名的“网红村”。</p><p><img src="http://inews.gtimg.com/newsapp_bt/0/15437315318/1000"><br>东沟村樱花茶园（央广网发 茅箭区融媒体中心供图）</p><figure class="image"><img src="http://inews.gtimg.com/newsapp_bt/0/15437315319/641"></figure><p>东沟桃源人家民宿（央广网发 王鹏 摄）</p>	\N	【乡村振兴看湖北】十堰茅箭：农文旅融合打造中国美丽休闲乡村	2024-05-15 11:30:03
100	\N	\N	中原突围鄂西北历史纪念馆	2024-05-15 05:46:01	<p>　　中原突围鄂西北历史纪念馆，位于茅塔乡东沟村均郧房县委县政府旧址，该址建于明清时期，是开明乡绅周宗裔的祖宅。纪念馆内主要由党史陈列室、茅箭区国防教育展示厅、电教厅等展厅构成。这些展厅通过图片、文物和多媒体等形式，生动地展示了中原突围鄂西北革命斗争的历史。</p><p>　　1931年6月，贺龙率红三军创建武当山革命根据地，并移师房县途经茅塔乡东沟村。在这里，他们打土豪、分田地，积极发展革命队伍，为新民主主义革命在鄂西北地区的发展做出了重要贡献。</p><p>　　1946年，王树声率中原突围南路部队在东沟村建立了鄂西北第三军分区、均郧房县委县政府、县大队革命政权。时任均郧房县委书记朱正传、县长胡恪恭等，率领突围官兵，依靠东沟群众，坚持武装斗争，牵制了数十倍于己的国民党军队。在同年底的战斗中，朱正传等100余名官兵英勇牺牲，胡恪恭也身负重伤，均郧房县委、县政府随之迁址。</p><p>　　1946年9月，王树声率部转战东沟，把鄂西北作战指挥中心设在泰山庙，开始了紧张而有序的工作，先后配合三地委、中心县委创建了官山区、白浪区、茅塔河区等。</p><p>　　作为十堰市“青少年爱国主义教育基地”、茅箭区青少年“德育教育基地”，以及位于十堰城区唯一的未成年人思想道德教育基地，东沟爱国主义教育基地在推动青少年教育和乡村振兴方面发挥着重要作用。</p><p>　　东沟爱国主义教育基地充分利用这些红色资源，通过建设红色展馆、规划红色路线等方式，系统梳理、挖掘、提炼区域内的红色文化、知青文化、生态文化、移民文化和森工文化。在这里，游客可以参观到保存完好的明清古建筑，这些建筑不仅是历史的见证，也承载着丰富的红色文化内涵。同时，基地还收集了许多珍贵的革命历史文物，如大刀、长矛、枪支等，以及大量的图片展览和文字介绍，生动地再现了当年的烽火岁月和英雄故事。</p>	leyou-slider-1-6642c0f0e95ff915268162-66444d65600ef012849063-1-66449e4a10876395724861.jpg	中原突围鄂西北历史纪念馆，位于茅塔乡东沟村均郧房县委县政府旧址	2024-05-15 11:36:42
106	\N	\N	东风商用车，2024十堰马拉松圆满举行	2024-05-15 11:41:30	<p>参加东风商用车·2024十堰马拉松的选手从起点十堰奥体中心出发。记者刘旻全正摄</p><p>山水之城，向“绿”先行；汽车之城，向“新”出发。4月14日上午，东风商用车·2024十堰马拉松在市奥体中心鸣枪开跑。市委副书记、市长王永辉，省体育局副局长郑李辉，东风商用车有限公司总经理张小帆，市领导汤红兵、刘学勤、朱云慧、沈明云等出席起跑仪式，为大赛鸣枪发令。</p><p>本次马拉松赛事经中国田径协会官方技术认证，由湖北省体育局、市人民政府主办，市体育局、茅箭区人民政府承办。设有全程马拉松（42.195公里）、半程马拉松（21.0975公里）、健康跑（4公里）三个项目，2万余人参赛，其中，全程马拉松2000余人、半程马拉松3000余人、健康跑15000余人。</p><p>7时30分，随着发令枪响，选手冲出起跑线，沿着紫霄大道、北京路一路向前，踏上了挑战自我的征程。赛道上，既有冲锋在前的专业选手，也有不甘落后的马拉松爱好者；既有年长的老人，也有活力四射的年轻人。大家迈开脚步、甩开臂膀，你追我赶、奋勇争先，用脚步感触十堰城区现代发展的脉络，共同领略城野乡间的自然之趣，共同享受运动带来的愉悦与健康。著名体育主持人、解说员韩乔生现场助力，并作为解说嘉宾现身直播间。</p><p>在起点旁、赛道旁、终点处，加油声、呼喊声不断，市民群众以最饱满的热情为跑友呐喊助威、加油鼓劲。现场指引、物资补给、秩序维护、医疗救护、交通疏导等各类志愿者和工作人员，用“微笑、点赞、加油”为参赛选手提供最有温度的服务，成为赛道上一抹亮丽的风景线。赛道沿线，舞龙、舞狮、音乐加油站、街舞、太极拳、健身操等表演为比赛营造了热烈、向上的赛事氛围。</p><p>一路逐风，拼搏向前。经过激烈角逐，埃塞俄比亚选手 FELATE MULETADEYISA以2小时23分55秒的成绩夺得全程马拉松男子组冠军，埃塞俄比亚选手REGASSA HAWI MEGERSSA以2小时47分32秒的成绩夺得全程马拉松女子组冠军。中国选手刘军、沈妮以1小时9分55秒、1小时18分15秒的成绩分别获得半程马拉松男子组、女子组冠军。</p><p>一步一景之间，马拉松赛成为城市最好的导游，也成为城市魅力与活力的最好注脚。此次赛事活动规模大、影响广、吸引力强，是一次宣传东风、走进十堰的文化体育盛事。近年来，十堰通过举办一场场精品赛事，纵深推进文体旅融合发展，为城市发展注入了更多新动能。（记者闵波刘旻）</p>	\N	山水之城，向“绿”先行；汽车之城，向“新”出发。	2024-05-15 11:41:30
95	\N	\N	环山步游道	2024-05-15 05:44:06	<p>环山步游道</p>	3ff6c4a84fbb97ef98228c027ed1046f-1-6644a08a51d2d634364653.jpg	环山步游道	2024-05-15 11:46:18
84	\N	\N	四季花园	2024-05-15 04:11:47	<p>　　月季园位于十堰市茅箭区茅塔乡东沟村红色革命教育基地入口小路旁。</p><p>　　种植面积约60余亩，是一个相对大规模的月季园。月季园内种植着大量的月季花，这些月季花热烈盛开，展现出浪漫唯美的景象。月季花的颜色丰富，形态各异，紧紧相连，摇曳在轻风之中，更显得风姿绰约。</p><p>　　每年初夏时节，月季园成为了一片花的海洋，装点着梯田式的园地，花香四溢。这里的月季花不仅美丽娇艳，还为东沟村增添了浓厚的浪漫气息，吸引了大批游客前来赏花留影。</p><p>　　“花开四季”月季园是一个集观赏、拍照、休闲为一体的花卉景区。游客可以在这里欣赏到美丽的月季花海，感受浓厚的浪漫气息，并留下美好的回忆。</p>	088735f887752b8d421d567afcf6a4fe-1-6644a10ef26fd491133687.jpg	月季园位于十堰市茅箭区茅塔乡东沟村红色革命教育基地入口小路旁。	2024-05-15 11:48:30
\.


--
-- Data for Name: node_region; Type: TABLE DATA; Schema: public; Owner: donggoudev
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
56	25
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
104	9
105	9
106	9
\.


--
-- Data for Name: node_tag; Type: TABLE DATA; Schema: public; Owner: donggoudev
--

COPY public.node_tag (node_id, tag_id) FROM stdin;
\.


--
-- Data for Name: page; Type: TABLE DATA; Schema: public; Owner: donggoudev
--

COPY public.page (id, name, label) FROM stdin;
1	首页	home
4	联系我们	contact
3	乐游东沟	leyou
2	走进东沟	zoujin
\.


--
-- Data for Name: region; Type: TABLE DATA; Schema: public; Owner: donggoudev
--

COPY public.region (id, name, label, count, icon, fields, description, page_id) FROM stdin;
3	幻灯片	slider	3	list	image,summary	\N	1
24	东沟荣誉	honor	4	list	image,summary,body	\N	2
29	住在东沟	zhuzai	3	list	summary,image,specs	\N	3
1	常见问题	faq	0	list	regions	\N	\N
2	产品方案	leyou	0	list	\N	\N	\N
7	景区介绍	jingqu	6	list	body,image,summary,tags	\N	1
4	景区介绍-文本	jingqutext	1	list	image,summary	\N	1
6	行程规划-文本	xingchengtext	1	list	image,summary	\N	1
5	乐游东沟-文本	leyoutext	1	list	image,summary	\N	1
8	乐游东沟	leyou	4	list	image,summary	\N	1
9	文旅要闻	wenlv	3	list	body,image,summary	\N	1
10	通知公告	tongzhi	3	list	body,image,summary	\N	1
11	党建文明	dangjian	2	list	body,image,summary	\N	1
12	旅行游记	youji	2	list	body,image,summary	\N	1
13	投诉建议	feedback	1	list	summary	\N	4
14	页脚	footer	2	list	image	\N	\N
15	行程规划	xingcheng	4	list	image	\N	1
16	东沟简介	jianjie	1	list	summary,images	\N	2
17	行程规划-文本	xingchengtext	1	list	image,summary	\N	2
18	行程规划	xingcheng	4	list	body,image	\N	2
20	红色文化	hongse	3	list	summary,body,image	\N	2
19	红色文化-文本	hongsetext	1	list	summary	\N	2
21	东沟历史-文本	historytext	1	list	summary,body	\N	2
22	东沟历史	history	3	list	summary,body,image	\N	2
23	东沟荣誉-文本	honortext	1	list	image	\N	2
25	幻灯片1	slider1	3	list	image	\N	3
26	游在东沟-文本	youzaitext	1	list	summary	\N	3
28	住在东沟-文本	zhuzaitext	1	list	summary,image	\N	3
30	吃在东沟-文本	chizaitext	1	list	summary,image	\N	3
31	吃在东沟	chizai	8	list	summary,image	\N	3
33	购在东沟	gouzai	4	list	summary,image	\N	3
32	购在东沟-文本	gouzaitext	1	list	\N	\N	3
27	游在东沟	youzai	3	list	summary,image,body	\N	3
\.


--
-- Data for Name: spec; Type: TABLE DATA; Schema: public; Owner: donggoudev
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
16	91	TEL	民宿电话：0719-8457770
15	90	TEL	民宿电话：0719-8457770
14	89	TEL	民宿电话：0719-8457770
13	88	TEL	民宿电话：0719-8457770
12	87	TEL	民宿电话：0719-8457770
\.


--
-- Data for Name: tag; Type: TABLE DATA; Schema: public; Owner: donggoudev
--

COPY public.tag (id, name, label) FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: donggoudev
--

COPY public."user" (id, username, roles, password, plain_password) FROM stdin;
2	al	["ROLE_SUPER_ADMIN"]	$2y$13$KpK7xAC8vlandkObN9kC4OAZVFw7SLtJvpf3PHICo4shV4haht9iK	\N
1	admin	["ROLE_ADMIN"]	$2y$13$J.jCWbJ8VupkmakxL8Wq/e6/vSTrvPII5M6/ME3lyWsMZ30ZZZabe	\N
\.


--
-- Name: category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: donggoudev
--

SELECT pg_catalog.setval('public.category_id_seq', 5, true);


--
-- Name: conf_id_seq; Type: SEQUENCE SET; Schema: public; Owner: donggoudev
--

SELECT pg_catalog.setval('public.conf_id_seq', 1, true);


--
-- Name: feedback_id_seq; Type: SEQUENCE SET; Schema: public; Owner: donggoudev
--

SELECT pg_catalog.setval('public.feedback_id_seq', 6, true);


--
-- Name: image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: donggoudev
--

SELECT pg_catalog.setval('public.image_id_seq', 5, true);


--
-- Name: language_id_seq; Type: SEQUENCE SET; Schema: public; Owner: donggoudev
--

SELECT pg_catalog.setval('public.language_id_seq', 1, false);


--
-- Name: messenger_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: donggoudev
--

SELECT pg_catalog.setval('public.messenger_messages_id_seq', 1, false);


--
-- Name: node_id_seq; Type: SEQUENCE SET; Schema: public; Owner: donggoudev
--

SELECT pg_catalog.setval('public.node_id_seq', 106, true);


--
-- Name: page_id_seq; Type: SEQUENCE SET; Schema: public; Owner: donggoudev
--

SELECT pg_catalog.setval('public.page_id_seq', 4, true);


--
-- Name: region_id_seq; Type: SEQUENCE SET; Schema: public; Owner: donggoudev
--

SELECT pg_catalog.setval('public.region_id_seq', 33, true);


--
-- Name: spec_id_seq; Type: SEQUENCE SET; Schema: public; Owner: donggoudev
--

SELECT pg_catalog.setval('public.spec_id_seq', 17, true);


--
-- Name: tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: donggoudev
--

SELECT pg_catalog.setval('public.tag_id_seq', 1, false);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: donggoudev
--

SELECT pg_catalog.setval('public.user_id_seq', 2, true);


--
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: donggoudev
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


--
-- Name: conf conf_pkey; Type: CONSTRAINT; Schema: public; Owner: donggoudev
--

ALTER TABLE ONLY public.conf
    ADD CONSTRAINT conf_pkey PRIMARY KEY (id);


--
-- Name: doctrine_migration_versions doctrine_migration_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: donggoudev
--

ALTER TABLE ONLY public.doctrine_migration_versions
    ADD CONSTRAINT doctrine_migration_versions_pkey PRIMARY KEY (version);


--
-- Name: feedback feedback_pkey; Type: CONSTRAINT; Schema: public; Owner: donggoudev
--

ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT feedback_pkey PRIMARY KEY (id);


--
-- Name: image image_pkey; Type: CONSTRAINT; Schema: public; Owner: donggoudev
--

ALTER TABLE ONLY public.image
    ADD CONSTRAINT image_pkey PRIMARY KEY (id);


--
-- Name: language language_pkey; Type: CONSTRAINT; Schema: public; Owner: donggoudev
--

ALTER TABLE ONLY public.language
    ADD CONSTRAINT language_pkey PRIMARY KEY (id);


--
-- Name: messenger_messages messenger_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: donggoudev
--

ALTER TABLE ONLY public.messenger_messages
    ADD CONSTRAINT messenger_messages_pkey PRIMARY KEY (id);


--
-- Name: node node_pkey; Type: CONSTRAINT; Schema: public; Owner: donggoudev
--

ALTER TABLE ONLY public.node
    ADD CONSTRAINT node_pkey PRIMARY KEY (id);


--
-- Name: node_region node_region_pkey; Type: CONSTRAINT; Schema: public; Owner: donggoudev
--

ALTER TABLE ONLY public.node_region
    ADD CONSTRAINT node_region_pkey PRIMARY KEY (node_id, region_id);


--
-- Name: node_tag node_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: donggoudev
--

ALTER TABLE ONLY public.node_tag
    ADD CONSTRAINT node_tag_pkey PRIMARY KEY (node_id, tag_id);


--
-- Name: page page_pkey; Type: CONSTRAINT; Schema: public; Owner: donggoudev
--

ALTER TABLE ONLY public.page
    ADD CONSTRAINT page_pkey PRIMARY KEY (id);


--
-- Name: region region_pkey; Type: CONSTRAINT; Schema: public; Owner: donggoudev
--

ALTER TABLE ONLY public.region
    ADD CONSTRAINT region_pkey PRIMARY KEY (id);


--
-- Name: spec spec_pkey; Type: CONSTRAINT; Schema: public; Owner: donggoudev
--

ALTER TABLE ONLY public.spec
    ADD CONSTRAINT spec_pkey PRIMARY KEY (id);


--
-- Name: tag tag_pkey; Type: CONSTRAINT; Schema: public; Owner: donggoudev
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tag_pkey PRIMARY KEY (id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: donggoudev
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: idx_14f389a882f1baf4; Type: INDEX; Schema: public; Owner: donggoudev
--

CREATE INDEX idx_14f389a882f1baf4 ON public.conf USING btree (language_id);


--
-- Name: idx_70ac95f8460d9fd7; Type: INDEX; Schema: public; Owner: donggoudev
--

CREATE INDEX idx_70ac95f8460d9fd7 ON public.node_tag USING btree (node_id);


--
-- Name: idx_70ac95f8bad26311; Type: INDEX; Schema: public; Owner: donggoudev
--

CREATE INDEX idx_70ac95f8bad26311 ON public.node_tag USING btree (tag_id);


--
-- Name: idx_75ea56e016ba31db; Type: INDEX; Schema: public; Owner: donggoudev
--

CREATE INDEX idx_75ea56e016ba31db ON public.messenger_messages USING btree (delivered_at);


--
-- Name: idx_75ea56e0e3bd61ce; Type: INDEX; Schema: public; Owner: donggoudev
--

CREATE INDEX idx_75ea56e0e3bd61ce ON public.messenger_messages USING btree (available_at);


--
-- Name: idx_75ea56e0fb7336f0; Type: INDEX; Schema: public; Owner: donggoudev
--

CREATE INDEX idx_75ea56e0fb7336f0 ON public.messenger_messages USING btree (queue_name);


--
-- Name: idx_857fe84512469de2; Type: INDEX; Schema: public; Owner: donggoudev
--

CREATE INDEX idx_857fe84512469de2 ON public.node USING btree (category_id);


--
-- Name: idx_857fe84582f1baf4; Type: INDEX; Schema: public; Owner: donggoudev
--

CREATE INDEX idx_857fe84582f1baf4 ON public.node USING btree (language_id);


--
-- Name: idx_bb70e4d3460d9fd7; Type: INDEX; Schema: public; Owner: donggoudev
--

CREATE INDEX idx_bb70e4d3460d9fd7 ON public.node_region USING btree (node_id);


--
-- Name: idx_bb70e4d398260155; Type: INDEX; Schema: public; Owner: donggoudev
--

CREATE INDEX idx_bb70e4d398260155 ON public.node_region USING btree (region_id);


--
-- Name: idx_c00e173e460d9fd7; Type: INDEX; Schema: public; Owner: donggoudev
--

CREATE INDEX idx_c00e173e460d9fd7 ON public.spec USING btree (node_id);


--
-- Name: idx_c53d045f460d9fd7; Type: INDEX; Schema: public; Owner: donggoudev
--

CREATE INDEX idx_c53d045f460d9fd7 ON public.image USING btree (node_id);


--
-- Name: idx_d2294458460d9fd7; Type: INDEX; Schema: public; Owner: donggoudev
--

CREATE INDEX idx_d2294458460d9fd7 ON public.feedback USING btree (node_id);


--
-- Name: idx_f62f176c4663e4; Type: INDEX; Schema: public; Owner: donggoudev
--

CREATE INDEX idx_f62f176c4663e4 ON public.region USING btree (page_id);


--
-- Name: uniq_8d93d649f85e0677; Type: INDEX; Schema: public; Owner: donggoudev
--

CREATE UNIQUE INDEX uniq_8d93d649f85e0677 ON public."user" USING btree (username);


--
-- Name: messenger_messages notify_trigger; Type: TRIGGER; Schema: public; Owner: donggoudev
--

CREATE TRIGGER notify_trigger AFTER INSERT OR UPDATE ON public.messenger_messages FOR EACH ROW EXECUTE FUNCTION public.notify_messenger_messages();


--
-- Name: conf fk_14f389a882f1baf4; Type: FK CONSTRAINT; Schema: public; Owner: donggoudev
--

ALTER TABLE ONLY public.conf
    ADD CONSTRAINT fk_14f389a882f1baf4 FOREIGN KEY (language_id) REFERENCES public.language(id);


--
-- Name: node_tag fk_70ac95f8460d9fd7; Type: FK CONSTRAINT; Schema: public; Owner: donggoudev
--

ALTER TABLE ONLY public.node_tag
    ADD CONSTRAINT fk_70ac95f8460d9fd7 FOREIGN KEY (node_id) REFERENCES public.node(id) ON DELETE CASCADE;


--
-- Name: node_tag fk_70ac95f8bad26311; Type: FK CONSTRAINT; Schema: public; Owner: donggoudev
--

ALTER TABLE ONLY public.node_tag
    ADD CONSTRAINT fk_70ac95f8bad26311 FOREIGN KEY (tag_id) REFERENCES public.tag(id) ON DELETE CASCADE;


--
-- Name: node fk_857fe84512469de2; Type: FK CONSTRAINT; Schema: public; Owner: donggoudev
--

ALTER TABLE ONLY public.node
    ADD CONSTRAINT fk_857fe84512469de2 FOREIGN KEY (category_id) REFERENCES public.category(id);


--
-- Name: node fk_857fe84582f1baf4; Type: FK CONSTRAINT; Schema: public; Owner: donggoudev
--

ALTER TABLE ONLY public.node
    ADD CONSTRAINT fk_857fe84582f1baf4 FOREIGN KEY (language_id) REFERENCES public.language(id);


--
-- Name: node_region fk_bb70e4d3460d9fd7; Type: FK CONSTRAINT; Schema: public; Owner: donggoudev
--

ALTER TABLE ONLY public.node_region
    ADD CONSTRAINT fk_bb70e4d3460d9fd7 FOREIGN KEY (node_id) REFERENCES public.node(id) ON DELETE CASCADE;


--
-- Name: node_region fk_bb70e4d398260155; Type: FK CONSTRAINT; Schema: public; Owner: donggoudev
--

ALTER TABLE ONLY public.node_region
    ADD CONSTRAINT fk_bb70e4d398260155 FOREIGN KEY (region_id) REFERENCES public.region(id) ON DELETE CASCADE;


--
-- Name: spec fk_c00e173e460d9fd7; Type: FK CONSTRAINT; Schema: public; Owner: donggoudev
--

ALTER TABLE ONLY public.spec
    ADD CONSTRAINT fk_c00e173e460d9fd7 FOREIGN KEY (node_id) REFERENCES public.node(id);


--
-- Name: image fk_c53d045f460d9fd7; Type: FK CONSTRAINT; Schema: public; Owner: donggoudev
--

ALTER TABLE ONLY public.image
    ADD CONSTRAINT fk_c53d045f460d9fd7 FOREIGN KEY (node_id) REFERENCES public.node(id);


--
-- Name: feedback fk_d2294458460d9fd7; Type: FK CONSTRAINT; Schema: public; Owner: donggoudev
--

ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT fk_d2294458460d9fd7 FOREIGN KEY (node_id) REFERENCES public.node(id);


--
-- Name: region fk_f62f176c4663e4; Type: FK CONSTRAINT; Schema: public; Owner: donggoudev
--

ALTER TABLE ONLY public.region
    ADD CONSTRAINT fk_f62f176c4663e4 FOREIGN KEY (page_id) REFERENCES public.page(id);


--
-- PostgreSQL database dump complete
--

