--
-- PostgreSQL database dump
--

-- Dumped from database version 10.5 (Debian 10.5-1)
-- Dumped by pg_dump version 13.2 (Debian 13.2-1)

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

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: progetto
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO progetto;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: progetto
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO progetto;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: progetto
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: progetto
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO progetto;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: progetto
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO progetto;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: progetto
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: progetto
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO progetto;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: progetto
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO progetto;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: progetto
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: progetto
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO progetto;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: progetto
--

CREATE TABLE public.auth_user_groups (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO progetto;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: progetto
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO progetto;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: progetto
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: progetto
--

CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO progetto;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: progetto
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: progetto
--

CREATE TABLE public.auth_user_user_permissions (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO progetto;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: progetto
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO progetto;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: progetto
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: progetto
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO progetto;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: progetto
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO progetto;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: progetto
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: progetto
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO progetto;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: progetto
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO progetto;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: progetto
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: progetto
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO progetto;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: progetto
--

CREATE SEQUENCE public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO progetto;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: progetto
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: progetto
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO progetto;

--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: progetto
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: progetto
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: progetto
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: progetto
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: progetto
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: progetto
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: progetto
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: progetto
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: progetto
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: progetto
--

COPY public.auth_group (id, name) FROM stdin;
2	agents
1	customers
3	managers
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: progetto
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
2	2	34
3	2	36
4	3	32
5	3	33
6	3	34
7	3	35
8	3	36
9	3	25
10	3	26
11	3	27
12	3	28
13	3	29
14	3	30
15	3	31
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: progetto
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add user	4	add_user
14	Can change user	4	change_user
15	Can delete user	4	delete_user
16	Can view user	4	view_user
17	Can add content type	5	add_contenttype
18	Can change content type	5	change_contenttype
19	Can delete content type	5	delete_contenttype
20	Can view content type	5	view_contenttype
21	Can add session	6	add_session
22	Can change session	6	change_session
23	Can delete session	6	delete_session
24	Can view session	6	view_session
25	Can add agents	7	add_agents
26	Can change agents	7	change_agents
27	Can delete agents	7	delete_agents
28	Can view agents	7	view_agents
29	Can add customer	8	add_customer
30	Can change customer	8	change_customer
31	Can delete customer	8	delete_customer
32	Can view customer	8	view_customer
33	Can add orders	9	add_orders
34	Can change orders	9	change_orders
35	Can delete orders	9	delete_orders
36	Can view orders	9	view_orders
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: progetto
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
19	pbkdf2_sha256$260000$snuffJDzu2eLWuZAafH4l6$bL+LTMMWmBwCYuvcgVGaj8mf/JZlVXhpWWGi1oPZzvc=	\N	f	C00015				f	t	2021-07-03 00:07:58+02
20	pbkdf2_sha256$260000$GPng4iB26P1nsPLMKSQDHL$ohHgWSgJ/Rfa3pwd3Yp+Gn/73z642yg06PlCd4gSWS4=	\N	f	C00016				f	t	2021-07-03 00:08:53+02
21	pbkdf2_sha256$260000$AvEV8ttkUkOYlDBxhqh7KW$C3Il6wSp3lWvfUOGQhUaHMvJ93o/ORGK7WbUaMwxmIg=	\N	f	C00017				f	t	2021-07-03 00:09:38+02
22	pbkdf2_sha256$260000$JBMOwrtjZrnXH9nomiDYhk$9zkaErO25/YPFonorL3dnDcGkL4BcorjkSANJeR3oN4=	\N	f	C00018				f	t	2021-07-03 00:10:43+02
23	pbkdf2_sha256$260000$HHugKwqBdJFfN5CLUzEkTj$GitA+idEUf85SnCz3AYxm5HSxpegJt63kLLUhIUy27w=	\N	f	C00019				f	t	2021-07-03 00:11:16+02
24	pbkdf2_sha256$260000$GdFqJH3n9DfBpUrRbpY7nq$8t3IzFVaDWLBXafq+w3NhCvzAmeZV7DaIQ774OnrSRI=	\N	f	C00020				f	t	2021-07-03 00:11:54+02
1	pbkdf2_sha256$260000$svyrIj6i5n38Ramai0yavr$LTZ+3J5LCKEzKl3Vry/fgrJaiovxVYeJxiteiPZLODA=	2021-07-02 23:56:47.339205+02	t	marcuzzo			marco.oliani@studenti.univr.it	t	t	2021-06-03 21:57:28.354869+02
5	pbkdf2_sha256$260000$odytbySUDDeASxh0T6slFt$WuG/h6yDa5Zu3Qz1jFimiRkHzno3djbBfKZf7Qefxz8=	\N	f	C00001				f	t	2021-07-03 00:00:11+02
6	pbkdf2_sha256$260000$ez2fRiTuWcSHEUiAilmTjH$2CC4beC+RDT22E9eY7Gf19NdS2Fgz1yacOB9RtPZC14=	\N	f	C00002				f	t	2021-07-03 00:00:46+02
7	pbkdf2_sha256$260000$V9slpUPihesP9S3YG90Sg0$QG6YIzGJRaBxEapiXtM2XwiYpVEQ2TyfDhV8jTFKRUU=	\N	f	C00003				f	t	2021-07-03 00:01:11+02
8	pbkdf2_sha256$260000$sHpKa87kFBVjUJE0BO8GBh$LNC97YM2okX89z02hyVOeNHaTUW+QGozuRzYHb3em7Y=	\N	f	C00004				f	t	2021-07-03 00:01:38+02
9	pbkdf2_sha256$260000$5i3upXJO0bAUz7edTCCrEZ$bvGThLOW/DRI3k98lXj872PYgS4PFjlSe3JhPykePo0=	\N	f	C00005				f	t	2021-07-03 00:02:07+02
10	pbkdf2_sha256$260000$TkgKm3rxcb5l25nckC4u02$fbQ2zIomW7P+YpNzY7aaFCuKh4IaY5XWXkK5GSlXwAI=	\N	f	C00006				f	t	2021-07-03 00:02:36+02
25	pbkdf2_sha256$260000$CKnP5vXFyq6y6ZRpAeK3lW$4WhWYUl9J7zKKMLbatUSiKxH6+0gbdRAYYLCNYZo0Q8=	\N	f	C00021				f	t	2021-07-03 00:12:48+02
11	pbkdf2_sha256$260000$Nddcm281AvTGkqjqm5Nevv$SKIi2A/vPfVsLblfGWfGqr7+xn+RlH6WGx3xhpU5ttg=	\N	f	C00007				f	t	2021-07-03 00:03:11+02
12	pbkdf2_sha256$260000$4G5XS0MAq3JrAau8Aprs4B$XVbxrqqPQJLMEtQXEtclgLiXjtdv2LxgSC4KKhHHtSA=	\N	f	C00008				f	t	2021-07-03 00:03:42+02
13	pbkdf2_sha256$260000$sQ1ZOa7FYanEqnwaZ8ZGwH$QoD6GIj4F6vaQj36H4HM2SVIyZ0jR1GP6p7QN+RVXUI=	\N	f	C00009				f	t	2021-07-03 00:04:17+02
14	pbkdf2_sha256$260000$jGjr7x4720SAsz6WB7OBi8$rFpejk7qWnak8/ti55mBYYLgakp5gaorEt0kzvHiTqo=	\N	f	C00010				f	t	2021-07-03 00:04:49+02
15	pbkdf2_sha256$260000$zCQkTSM1ofQ9DKFlmWolZm$cPGJMFGSQP3D7U+y+jypJ9pqLFJYeUEnRjHCRgZ9MJ4=	\N	f	C00011				f	t	2021-07-03 00:05:15+02
16	pbkdf2_sha256$260000$fiZBQiXJMt7wxIGlUUucU8$SctniLAsffU+hXll62K7aWBE9eBMhFFme6nPvBqgxNU=	\N	f	C00012				f	t	2021-07-03 00:05:42+02
33	pbkdf2_sha256$260000$FRWeCKH5lIobPWWHX30OOt$G2z9MAxTOjQyHD1vfhcMLecDEsttqzdZj2cJTXU5n3c=	2021-07-03 10:43:43.925453+02	f	A004				f	t	2021-07-03 00:17:07+02
17	pbkdf2_sha256$260000$AEcNkY8D5rvbQEwG4qRaMR$IlndfkkKhiKK0YhRE6hP7N4DCz0KUzpO1I4s40ECsHs=	\N	f	C00013				f	t	2021-07-03 00:06:21+02
18	pbkdf2_sha256$260000$Fu1hG30r1uzFoxxCPbsDxF$Abu+ZrMvYpbwCm1gkSJJGgWzKkP0x40lifIk1pEnRsU=	\N	f	C00014				f	t	2021-07-03 00:06:53+02
27	pbkdf2_sha256$260000$EVdKLprcxkfZ5Yor5wlK2d$05l21zCn0fpyfU+AiOeb3ijul0i2Mb39hXeU69ICudU=	\N	f	C00023				f	t	2021-07-03 00:13:42+02
28	pbkdf2_sha256$260000$PYlw0fA6GLp5gBE3BevF6L$RE/u9hOhb8XNB8irxvAgtxNOb8zRoH0AgNtLwdQviLg=	\N	f	C00024				f	t	2021-07-03 00:14:13+02
29	pbkdf2_sha256$260000$A0NNdd5WvEcZhWJeLQfs62$7MeM0EPE3qef7Cy3nm6pTymzbqhw/61l7Sc6dIjpcsA=	\N	f	C00025				f	t	2021-07-03 00:14:42+02
31	pbkdf2_sha256$260000$CWORd0CecIUI1b6x5bLCo8$9LA0O3tnvESqg53XSfQV46mZSYg5SDNjRpSUMaX5X/g=	\N	f	A002				f	t	2021-07-03 00:15:38+02
32	pbkdf2_sha256$260000$YqYLrQ9XoesRh6W6tCGgX0$TWbHv1DO/xt+GjVkgIkxlhCRWyx40TrXgT3w8+UkKS0=	\N	f	A003				f	t	2021-07-03 00:16:39+02
34	pbkdf2_sha256$260000$uF7VAvy4HNECHTQ8WFjA2L$SH254WuxUY3I4bqaYXr2WcVUrfgNt+mIdt3sGOZsqPU=	\N	f	A005				f	t	2021-07-03 00:18:11+02
35	pbkdf2_sha256$260000$Bh2oOwSlDSnuOAhZF404IN$ALAdOn1dyHKffw3SwJOuRHOvTJLKj5RagKh7LcMK+RU=	\N	f	A006				f	t	2021-07-03 00:18:43+02
36	pbkdf2_sha256$260000$nYM4wzvlTjv9fD7nOv6Z0C$9zWQnXNmPebOtEJg5Qku215YsSg+yc/ZCX0hZFs93a4=	\N	f	A007				f	t	2021-07-03 00:19:15+02
37	pbkdf2_sha256$260000$rNkCklWPddKtg9Mg7YvQhk$Ojs3uZlK3G5vrcq+AAwPWp4q476Xn5XdTRr4PLTN5Wo=	\N	f	A008				f	t	2021-07-03 00:19:43+02
38	pbkdf2_sha256$260000$6P0VnNsXeehmf1PkS8M9d9$Arqf9uo5rPEAvxf+E/1zA4kMxyi9hzHUAMh7UGIZ0lk=	\N	f	A009				f	t	2021-07-03 00:20:12+02
39	pbkdf2_sha256$260000$mjFyoVznCPPlIRNf1h9NSL$fLOCVyywGOLku7+Vwr3a0hoGBc2aWVRMkaCYDl+UeKA=	\N	f	A010				f	t	2021-07-03 00:20:36+02
40	pbkdf2_sha256$260000$pTg0R7gFEnI5Y0HrYvcjnB$zxG9CXMi+wX2RQP2bdtApc26E7BmJCTRaI3zKoL5aLU=	\N	f	A011				f	t	2021-07-03 00:21:02+02
41	pbkdf2_sha256$260000$8QpCfScx37nhvBvQ6xtyrM$pzgF1C8/BIV4d0FHqih9U0ZKoO7OirjrZ62tFmY4QwQ=	\N	f	A012				f	t	2021-07-03 00:21:29+02
42	pbkdf2_sha256$260000$RRUBdsXCr7J1nOi7XwkXTx$dtVKTLFDGf/pMXDmv/ZUiup4qqJBzI4525PUmNCMio4=	\N	f	M001				f	t	2021-07-03 00:24:04+02
43	pbkdf2_sha256$260000$zUDYJaTFIenHpy1vZ1gpVa$CodIVS1g5DCswSrgpJibK4X7PA5LsOkrm/kvJgcG720=	\N	f	M002				f	t	2021-07-03 00:24:32+02
44	pbkdf2_sha256$260000$ldm9OkP4lJzdzS1lGPv8dL$+l8gGa0xqstXvKuDFONOHRFklb95pklCzDGbqOhU3lQ=	\N	f	M003				f	t	2021-07-03 00:25:03+02
30	pbkdf2_sha256$260000$i5wsVqFkvzirhU8ghJTJcb$HSEQUPIBvhfFQnt3t66Fk+TDu+FFnyzo7tmbJohSQl4=	2021-07-03 00:39:21.955765+02	f	A001				f	t	2021-07-03 00:15:16+02
26	pbkdf2_sha256$260000$vCNycUavZNeQJWS9nVoBck$tHR1hdOTDG97HVORrYToBffwYDbNdYlANcPsQlTH2+s=	2021-07-03 10:29:38.507894+02	f	C00022				f	t	2021-07-03 00:13:14+02
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: progetto
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
5	5	1
6	6	1
7	7	1
8	8	1
9	9	1
10	10	1
11	11	1
12	12	1
13	13	1
14	14	1
15	15	1
16	16	1
17	17	1
18	18	1
19	19	1
20	20	1
21	21	1
22	22	1
23	23	1
24	24	1
25	25	1
26	26	1
27	27	1
28	28	1
29	29	1
30	30	2
31	31	2
32	32	2
33	33	2
34	34	2
35	35	2
36	36	2
37	37	2
38	38	2
39	39	2
40	40	2
41	41	2
42	42	3
43	43	3
44	44	3
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: progetto
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: progetto
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2021-06-05 00:29:48.447456+02	2	C00013	1	[{"added": {}}]	4	1
2	2021-06-05 00:31:11.081749+02	1	customers	1	[{"added": {}}]	3	1
3	2021-06-05 00:31:47.37417+02	2	agents	1	[{"added": {}}]	3	1
4	2021-06-05 00:33:09.437382+02	2	C00013	2	[{"changed": {"fields": ["Groups"]}}]	4	1
5	2021-06-05 12:08:06.640211+02	1	customers	2	[{"changed": {"fields": ["Permissions"]}}]	3	1
6	2021-06-05 12:10:24.267987+02	2	C00013	2	[{"changed": {"fields": ["Groups"]}}]	4	1
7	2021-06-05 12:22:45.894166+02	2	C00013	2	[{"changed": {"fields": ["Groups"]}}]	4	1
8	2021-06-05 21:38:52.250941+02	3	A004	1	[{"added": {}}]	4	1
9	2021-06-05 21:39:17.431354+02	3	A004	2	[{"changed": {"fields": ["First name", "Last name", "Groups"]}}]	4	1
10	2021-06-14 14:36:53.060015+02	4	diegocatellani	1	[{"added": {}}]	4	1
11	2021-06-14 14:37:58.081159+02	3	managers	1	[{"added": {}}]	3	1
12	2021-06-14 14:38:41.040772+02	4	diegocatellani	2	[{"changed": {"fields": ["Groups", "User permissions"]}}]	4	1
13	2021-07-02 23:59:05.738915+02	4	diegocatellani	3		4	1
14	2021-07-02 23:59:36.651683+02	3	A004	3		4	1
15	2021-07-02 23:59:36.673884+02	2	C00013	3		4	1
16	2021-07-03 00:00:11.656481+02	5	C00001	1	[{"added": {}}]	4	1
17	2021-07-03 00:00:21.065004+02	5	C00001	2	[{"changed": {"fields": ["Groups"]}}]	4	1
18	2021-07-03 00:00:46.472877+02	6	C00002	1	[{"added": {}}]	4	1
19	2021-07-03 00:00:54.333507+02	6	C00002	2	[{"changed": {"fields": ["Groups"]}}]	4	1
20	2021-07-03 00:01:11.784307+02	7	C00003	1	[{"added": {}}]	4	1
21	2021-07-03 00:01:19.829553+02	7	C00003	2	[{"changed": {"fields": ["Groups"]}}]	4	1
22	2021-07-03 00:01:38.693661+02	8	C00004	1	[{"added": {}}]	4	1
23	2021-07-03 00:01:47.733385+02	8	C00004	2	[{"changed": {"fields": ["Groups"]}}]	4	1
24	2021-07-03 00:02:07.815507+02	9	C00005	1	[{"added": {}}]	4	1
25	2021-07-03 00:02:14.595067+02	9	C00005	2	[{"changed": {"fields": ["Groups"]}}]	4	1
26	2021-07-03 00:02:36.641353+02	10	C00006	1	[{"added": {}}]	4	1
27	2021-07-03 00:02:43.416482+02	10	C00006	2	[{"changed": {"fields": ["Groups"]}}]	4	1
28	2021-07-03 00:03:11.75292+02	11	C00007	1	[{"added": {}}]	4	1
29	2021-07-03 00:03:20.859817+02	11	C00007	2	[{"changed": {"fields": ["Groups"]}}]	4	1
30	2021-07-03 00:03:42.746207+02	12	C00008	1	[{"added": {}}]	4	1
31	2021-07-03 00:03:53.719256+02	12	C00008	2	[{"changed": {"fields": ["Groups"]}}]	4	1
32	2021-07-03 00:04:17.90077+02	13	C00009	1	[{"added": {}}]	4	1
33	2021-07-03 00:04:24.037408+02	13	C00009	2	[{"changed": {"fields": ["Groups"]}}]	4	1
34	2021-07-03 00:04:49.88259+02	14	C00010	1	[{"added": {}}]	4	1
35	2021-07-03 00:04:57.529748+02	14	C00010	2	[{"changed": {"fields": ["Groups"]}}]	4	1
36	2021-07-03 00:05:16.082991+02	15	C00011	1	[{"added": {}}]	4	1
37	2021-07-03 00:05:21.956952+02	15	C00011	2	[{"changed": {"fields": ["Groups"]}}]	4	1
38	2021-07-03 00:05:43.039922+02	16	C00012	1	[{"added": {}}]	4	1
39	2021-07-03 00:05:50.428265+02	16	C00012	2	[{"changed": {"fields": ["Groups"]}}]	4	1
40	2021-07-03 00:06:22.201978+02	17	C00013	1	[{"added": {}}]	4	1
41	2021-07-03 00:06:31.913315+02	17	C00013	2	[{"changed": {"fields": ["Groups"]}}]	4	1
42	2021-07-03 00:06:53.493898+02	18	C00014	1	[{"added": {}}]	4	1
43	2021-07-03 00:07:01.91716+02	18	C00014	2	[{"changed": {"fields": ["Groups"]}}]	4	1
44	2021-07-03 00:07:58.269878+02	19	C00015	1	[{"added": {}}]	4	1
45	2021-07-03 00:08:05.090616+02	19	C00015	2	[{"changed": {"fields": ["Groups"]}}]	4	1
46	2021-07-03 00:08:53.453386+02	20	C00016	1	[{"added": {}}]	4	1
47	2021-07-03 00:09:11.224634+02	20	C00016	2	[{"changed": {"fields": ["Groups"]}}]	4	1
48	2021-07-03 00:09:38.286399+02	21	C00017	1	[{"added": {}}]	4	1
49	2021-07-03 00:09:49.409891+02	21	C00017	2	[{"changed": {"fields": ["Groups"]}}]	4	1
50	2021-07-03 00:10:43.952213+02	22	C00018	1	[{"added": {}}]	4	1
51	2021-07-03 00:10:50.12009+02	22	C00018	2	[{"changed": {"fields": ["Groups"]}}]	4	1
52	2021-07-03 00:11:17.084706+02	23	C00019	1	[{"added": {}}]	4	1
53	2021-07-03 00:11:24.766763+02	23	C00019	2	[{"changed": {"fields": ["Groups"]}}]	4	1
54	2021-07-03 00:11:54.607979+02	24	C00020	1	[{"added": {}}]	4	1
55	2021-07-03 00:12:00.878487+02	24	C00020	2	[{"changed": {"fields": ["Groups"]}}]	4	1
56	2021-07-03 00:12:48.331136+02	25	C00021	1	[{"added": {}}]	4	1
57	2021-07-03 00:12:55.079779+02	25	C00021	2	[{"changed": {"fields": ["Groups"]}}]	4	1
58	2021-07-03 00:13:14.293178+02	26	C00022	1	[{"added": {}}]	4	1
59	2021-07-03 00:13:22.304938+02	26	C00022	2	[{"changed": {"fields": ["Groups"]}}]	4	1
60	2021-07-03 00:13:42.613797+02	27	C00023	1	[{"added": {}}]	4	1
61	2021-07-03 00:13:50.25534+02	27	C00023	2	[{"changed": {"fields": ["Groups"]}}]	4	1
62	2021-07-03 00:14:13.618309+02	28	C00024	1	[{"added": {}}]	4	1
63	2021-07-03 00:14:19.656088+02	28	C00024	2	[{"changed": {"fields": ["Groups"]}}]	4	1
64	2021-07-03 00:14:42.376532+02	29	C00025	1	[{"added": {}}]	4	1
65	2021-07-03 00:14:52.338675+02	29	C00025	2	[{"changed": {"fields": ["Groups"]}}]	4	1
66	2021-07-03 00:15:16.272624+02	30	A001	1	[{"added": {}}]	4	1
67	2021-07-03 00:15:23.361254+02	30	A001	2	[{"changed": {"fields": ["Groups"]}}]	4	1
68	2021-07-03 00:15:39.18555+02	31	A002	1	[{"added": {}}]	4	1
69	2021-07-03 00:15:45.987977+02	31	A002	2	[{"changed": {"fields": ["Groups"]}}]	4	1
70	2021-07-03 00:16:39.981807+02	32	A003	1	[{"added": {}}]	4	1
71	2021-07-03 00:16:49.264028+02	32	A003	2	[{"changed": {"fields": ["Groups"]}}]	4	1
72	2021-07-03 00:17:07.310706+02	33	A004	1	[{"added": {}}]	4	1
73	2021-07-03 00:17:15.919113+02	33	A004	2	[{"changed": {"fields": ["Groups"]}}]	4	1
74	2021-07-03 00:18:11.239967+02	34	A005	1	[{"added": {}}]	4	1
75	2021-07-03 00:18:19.878594+02	34	A005	2	[{"changed": {"fields": ["Groups"]}}]	4	1
76	2021-07-03 00:18:43.267265+02	35	A006	1	[{"added": {}}]	4	1
77	2021-07-03 00:18:50.792068+02	35	A006	2	[{"changed": {"fields": ["Groups"]}}]	4	1
78	2021-07-03 00:19:15.712807+02	36	A007	1	[{"added": {}}]	4	1
79	2021-07-03 00:19:26.950153+02	36	A007	2	[{"changed": {"fields": ["Groups"]}}]	4	1
80	2021-07-03 00:19:43.577368+02	37	A008	1	[{"added": {}}]	4	1
81	2021-07-03 00:19:50.550635+02	37	A008	2	[{"changed": {"fields": ["Groups"]}}]	4	1
82	2021-07-03 00:20:12.219677+02	38	A009	1	[{"added": {}}]	4	1
83	2021-07-03 00:20:20.041016+02	38	A009	2	[{"changed": {"fields": ["Groups"]}}]	4	1
84	2021-07-03 00:20:36.630296+02	39	A010	1	[{"added": {}}]	4	1
85	2021-07-03 00:20:45.454712+02	39	A010	2	[{"changed": {"fields": ["Groups"]}}]	4	1
86	2021-07-03 00:21:02.634663+02	40	A011	1	[{"added": {}}]	4	1
87	2021-07-03 00:21:09.558719+02	40	A011	2	[{"changed": {"fields": ["Groups"]}}]	4	1
88	2021-07-03 00:21:29.235949+02	41	A012	1	[{"added": {}}]	4	1
89	2021-07-03 00:21:37.550459+02	41	A012	2	[{"changed": {"fields": ["Groups"]}}]	4	1
90	2021-07-03 00:24:04.414881+02	42	M001	1	[{"added": {}}]	4	1
91	2021-07-03 00:24:13.024897+02	42	M001	2	[{"changed": {"fields": ["Groups"]}}]	4	1
92	2021-07-03 00:24:33.198535+02	43	M002	1	[{"added": {}}]	4	1
93	2021-07-03 00:24:40.18789+02	43	M002	2	[{"changed": {"fields": ["Groups"]}}]	4	1
94	2021-07-03 00:25:03.825701+02	44	M003	1	[{"added": {}}]	4	1
95	2021-07-03 00:25:09.478773+02	44	M003	2	[{"changed": {"fields": ["Groups"]}}]	4	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: progetto
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	api	agents
8	api	customer
9	api	orders
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: progetto
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2021-06-03 21:56:55.166741+02
2	auth	0001_initial	2021-06-03 21:56:55.977733+02
3	admin	0001_initial	2021-06-03 21:56:56.169582+02
4	admin	0002_logentry_remove_auto_add	2021-06-03 21:56:56.18928+02
5	admin	0003_logentry_add_action_flag_choices	2021-06-03 21:56:56.205152+02
6	contenttypes	0002_remove_content_type_name	2021-06-03 21:56:56.236125+02
7	auth	0002_alter_permission_name_max_length	2021-06-03 21:56:56.256184+02
8	auth	0003_alter_user_email_max_length	2021-06-03 21:56:56.273014+02
9	auth	0004_alter_user_username_opts	2021-06-03 21:56:56.290798+02
10	auth	0005_alter_user_last_login_null	2021-06-03 21:56:56.314291+02
11	auth	0006_require_contenttypes_0002	2021-06-03 21:56:56.319579+02
12	auth	0007_alter_validators_add_error_messages	2021-06-03 21:56:56.33877+02
13	auth	0008_alter_user_username_max_length	2021-06-03 21:56:56.388781+02
14	auth	0009_alter_user_last_name_max_length	2021-06-03 21:56:56.414087+02
15	auth	0010_alter_group_name_max_length	2021-06-03 21:56:56.43301+02
16	auth	0011_update_proxy_permissions	2021-06-03 21:56:56.454313+02
17	auth	0012_alter_user_first_name_max_length	2021-06-03 21:56:56.473694+02
18	sessions	0001_initial	2021-06-03 21:56:56.636447+02
19	api	0001_initial	2021-06-04 21:19:46.823583+02
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: progetto
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
458idbm03xr8d8u6s2x3w49snzypecoq	eyJfY3NyZnRva2VuIjoiOE1pM09tTE9wYVpIbUpXZjNoU01DOVY1MlFxZUtxSkZFMHNJTVlDQ25qYXhQQ2J0UWZmODAyUjRQQ2tCc2twQyJ9:1ltac1:MOw0p1J0nfJ-EYW0f--Ky4Br1VihKiG5GWkqowdwC64	2021-06-30 20:50:05.919893+02
u3qgltfk5xwjjijbnur08kbhzlw3esan	eyJfY3NyZnRva2VuIjoiRVFDRVFUMm9SenltcmZMR09DTndBM2YyZW5DcnZTRUFoNmtNT0FjeFhOZDdlRmRMaW9IUXgwem53ZkZMTkRabyJ9:1ltagd:RtJZ2g6g3Cnt3IX010vvPzyXoDTsmWr-eukBX3i2dIE	2021-06-30 20:54:51.717767+02
hjh04e3hig2kn7xjpizzegad9ipxbofd	.eJyNjclOwzAQhl8F-YwiJ95qbikSUNQipREgTpH3OAW7ipP2gHh3HKmX3jqn-Zf55hd0Ko12igcTwAPwsN9uB7oq612NGt3W6wY3rfIOn5_5C9n7lpM0nN7Pj4arzQcZnvTr29ch6M-9sQI7cA86MU99Nyczdl5nJELXphQq_1oSPYjgYqFimEYvi6VSXNJU7KI23-tL9wrQi9Qv1yuONCeEVLiUlFvCLYOQM4RKy8qKWYWogJRii7nQAlUKVkxrJqGVkkKToW6cj8eYWcKZMKXszFNeTHZqCHHWIf4sanMS4e6GAX__ox9kRA:1lzbFY:9LWBBbHQoGfl3tR7fNR0v6dwwQ0B7ZxTZDJaUNhSdxQ	2021-07-17 10:43:44.014837+02
4xeyikz0s9vv7t00owqj36d99q1v5b23	eyJfY3NyZnRva2VuIjoibEx4MTdBNU5mTEhwcUtKWWx4WHRiU2lTdnYxR1BPbHZFQlJma2dUTVFXOWxrTlZQTllucENUNGQ2RjdkQXRXVCJ9:1lzRp0:nYveo4HIdZYTKtbI-QP2extk90e7UVHZ0siZ9bwzZ0Y	2021-07-17 00:39:42.884668+02
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: progetto
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 3, true);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: progetto
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 15, true);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: progetto
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 36, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: progetto
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 44, true);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: progetto
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 44, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: progetto
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 12, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: progetto
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 95, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: progetto
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 9, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: progetto
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 19, true);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: progetto
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: progetto
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: progetto
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: progetto
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: progetto
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: progetto
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: progetto
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: progetto
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: progetto
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: progetto
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: progetto
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: progetto
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: progetto
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: progetto
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: progetto
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: progetto
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: progetto
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: progetto
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: progetto
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: progetto
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: progetto
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: progetto
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: progetto
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: progetto
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: progetto
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: progetto
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: progetto
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: progetto
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: progetto
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: progetto
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: progetto
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: progetto
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: progetto
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: progetto
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: progetto
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: progetto
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: progetto
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: progetto
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: progetto
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

