--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1 (Debian 16.1-1.pgdg120+1)
-- Dumped by pg_dump version 16.1 (Debian 16.1-1.pgdg120+1)

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
-- Name: File; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."File" (
    id bigint NOT NULL,
    deleted boolean,
    created timestamp with time zone NOT NULL,
    name character varying(250) NOT NULL,
    img character varying(100) NOT NULL
);




--
-- Name: FileXUser; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."FileXUser" (
    id bigint NOT NULL,
    file bigint,
    "user" integer
);




--
-- Name: FileXUser_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."FileXUser" ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."FileXUser_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: File_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."File" ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."File_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);




--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_group ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);




--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_group_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);




--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_permission ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: postgres
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




--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_groups (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);




--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_user_groups ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_user ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_user_permissions (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);




--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_user_user_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
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




--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.django_admin_log ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);




--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.django_content_type ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);



--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.django_migrations ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);




--
-- Name: optionMenu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."optionMenu" (
    id bigint NOT NULL,
    option character varying(20) NOT NULL
);




--
-- Name: optionMenu_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."optionMenu" ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."optionMenu_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: File; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."File" (id, deleted, created, name, img) FROM stdin;
1	t	2023-11-22 05:29:46.08033+00	aaa	imgs/OIG_YWBHyFb.jfif
\.


--
-- Data for Name: FileXUser; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."FileXUser" (id, file, "user") FROM stdin;
1	1	1
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
25	Can add file	7	add_file
26	Can change file	7	change_file
27	Can delete file	7	delete_file
28	Can view file	7	view_file
29	Can add filexuser	8	add_filexuser
30	Can change filexuser	8	change_filexuser
31	Can delete filexuser	8	delete_filexuser
32	Can view filexuser	8	view_filexuser
33	Can add option menu	9	add_optionmenu
34	Can change option menu	9	change_optionmenu
35	Can delete option menu	9	delete_optionmenu
36	Can view option menu	9	view_optionmenu
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
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
2	pbkdf2_sha256$600000$8JuKZ9EHLVqFlcMkgkmA6i$AGzbbfq7gjk5iWPfcTeuva0ifF0aN+s8BJMZtuHHkM8=	\N	f	eladiocarrion	Eladio	Carrion		f	t	2023-11-22 05:59:36.034251+00
1	pbkdf2_sha256$600000$8L7WbhLNGmyhWHpSZq6wrO$LjaHXln30SdiNh+GAb8LN3xeApIArn31YAm1gRf9rJI=	2023-11-10 21:30:31.213+00	t	manager			va@va.co	t	t	2023-11-09 19:12:52.892+00
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2023-11-09 21:43:01.69+00	1	OptionMenu object (1)	1	[{"added": {}}]	9	1
2	2023-11-09 21:47:35.996+00	1	OptionMenu object (1)	3		9	1
3	2023-11-09 21:52:37.357+00	2	OptionMenu object (2)	1	[{"added": {}}]	9	1
4	2023-11-09 21:52:59.028+00	3	OptionMenu object (3)	1	[{"added": {}}]	9	1
5	2023-11-09 21:53:14.989+00	4	OptionMenu object (4)	1	[{"added": {}}]	9	1
6	2023-11-09 22:39:26.415+00	1	File object (1)	1	[{"added": {}}]	7	1
7	2023-11-09 22:39:54.578+00	2	File object (2)	1	[{"added": {}}]	7	1
8	2023-11-10 02:08:56.834+00	2	eladiocarrion	3		4	1
9	2023-11-10 02:11:19.178+00	3	eladiocarrion	3		4	1
10	2023-11-10 02:11:47.648+00	4	eladiocarrion	1	[{"added": {}}]	4	1
11	2023-11-10 02:12:39.082+00	4	eladiocarrion	3		4	1
12	2023-11-10 02:14:04.786+00	5	eladiocarrion	3		4	1
13	2023-11-10 02:15:26.785+00	6	eladiocarrion	3		4	1
14	2023-11-10 03:55:44.571+00	7	File object (7)	3		7	1
15	2023-11-10 03:55:44.573+00	6	File object (6)	3		7	1
16	2023-11-10 03:55:44.574+00	5	File object (5)	3		7	1
17	2023-11-10 03:55:44.575+00	4	File object (4)	3		7	1
18	2023-11-10 03:55:44.576+00	3	File object (3)	3		7	1
19	2023-11-10 03:55:44.576+00	2	File object (2)	3		7	1
20	2023-11-10 03:55:44.577+00	1	File object (1)	3		7	1
21	2023-11-10 03:55:58.625+00	5	Filexuser object (5)	3		8	1
22	2023-11-10 03:55:58.626+00	4	Filexuser object (4)	3		8	1
23	2023-11-10 03:55:58.627+00	3	Filexuser object (3)	3		8	1
24	2023-11-10 03:55:58.628+00	2	Filexuser object (2)	3		8	1
25	2023-11-10 03:55:58.63+00	1	Filexuser object (1)	3		8	1
26	2023-11-10 03:56:04.082+00	7	File object (7)	3		7	1
27	2023-11-10 03:56:04.084+00	6	File object (6)	3		7	1
28	2023-11-10 03:56:04.084+00	5	File object (5)	3		7	1
29	2023-11-10 03:56:04.085+00	4	File object (4)	3		7	1
30	2023-11-10 03:56:04.085+00	3	File object (3)	3		7	1
31	2023-11-10 03:56:04.087+00	2	File object (2)	3		7	1
32	2023-11-10 03:56:04.088+00	1	File object (1)	3		7	1
33	2023-11-10 04:14:04.426+00	9	File object (9)	1	[{"added": {}}]	7	1
34	2023-11-10 21:30:44.739+00	20	Filexuser object (20)	3		8	1
35	2023-11-10 21:30:44.745+00	19	Filexuser object (19)	3		8	1
36	2023-11-10 21:30:44.746+00	18	Filexuser object (18)	3		8	1
37	2023-11-10 21:30:44.746+00	17	Filexuser object (17)	3		8	1
38	2023-11-10 21:30:44.747+00	16	Filexuser object (16)	3		8	1
39	2023-11-10 21:30:44.749+00	15	Filexuser object (15)	3		8	1
40	2023-11-10 21:30:44.751+00	14	Filexuser object (14)	3		8	1
41	2023-11-10 21:30:44.752+00	13	Filexuser object (13)	3		8	1
42	2023-11-10 21:30:44.752+00	12	Filexuser object (12)	3		8	1
43	2023-11-10 21:30:44.753+00	11	Filexuser object (11)	3		8	1
44	2023-11-10 21:30:44.754+00	10	Filexuser object (10)	3		8	1
45	2023-11-10 21:30:44.755+00	9	Filexuser object (9)	3		8	1
46	2023-11-10 21:30:44.755+00	8	Filexuser object (8)	3		8	1
47	2023-11-10 21:30:44.756+00	7	Filexuser object (7)	3		8	1
48	2023-11-10 21:30:44.756+00	6	Filexuser object (6)	3		8	1
49	2023-11-10 21:30:52.029+00	23	File object (23)	3		7	1
50	2023-11-10 21:30:52.031+00	22	File object (22)	3		7	1
51	2023-11-10 21:30:52.032+00	21	File object (21)	3		7	1
52	2023-11-10 21:30:52.033+00	20	File object (20)	3		7	1
53	2023-11-10 21:30:52.034+00	19	File object (19)	3		7	1
54	2023-11-10 21:30:52.034+00	18	File object (18)	3		7	1
55	2023-11-10 21:30:52.035+00	17	File object (17)	3		7	1
56	2023-11-10 21:30:52.035+00	16	File object (16)	3		7	1
57	2023-11-10 21:30:52.036+00	15	File object (15)	3		7	1
58	2023-11-10 21:30:52.036+00	14	File object (14)	3		7	1
59	2023-11-10 21:30:52.037+00	13	File object (13)	3		7	1
60	2023-11-10 21:30:52.037+00	12	File object (12)	3		7	1
61	2023-11-10 21:30:52.038+00	11	File object (11)	3		7	1
62	2023-11-10 21:30:52.038+00	10	File object (10)	3		7	1
63	2023-11-10 21:30:52.039+00	9	File object (9)	3		7	1
64	2023-11-10 21:30:52.04+00	8	File object (8)	3		7	1
65	2023-11-10 21:30:58.163+00	7	eladiocarrion	3		4	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	filemanager	file
8	filemanager	filexuser
9	filemanager	optionmenu
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2023-11-22 05:29:13.341628+00
2	auth	0001_initial	2023-11-22 05:29:13.462943+00
3	admin	0001_initial	2023-11-22 05:29:13.500701+00
4	admin	0002_logentry_remove_auto_add	2023-11-22 05:29:13.511156+00
5	admin	0003_logentry_add_action_flag_choices	2023-11-22 05:29:13.521199+00
6	contenttypes	0002_remove_content_type_name	2023-11-22 05:29:13.541415+00
7	auth	0002_alter_permission_name_max_length	2023-11-22 05:29:13.55333+00
8	auth	0003_alter_user_email_max_length	2023-11-22 05:29:13.565847+00
9	auth	0004_alter_user_username_opts	2023-11-22 05:29:13.57674+00
10	auth	0005_alter_user_last_login_null	2023-11-22 05:29:13.587905+00
11	auth	0006_require_contenttypes_0002	2023-11-22 05:29:13.591242+00
12	auth	0007_alter_validators_add_error_messages	2023-11-22 05:29:13.601475+00
13	auth	0008_alter_user_username_max_length	2023-11-22 05:29:13.616694+00
14	auth	0009_alter_user_last_name_max_length	2023-11-22 05:29:13.627106+00
15	auth	0010_alter_group_name_max_length	2023-11-22 05:29:13.639761+00
16	auth	0011_update_proxy_permissions	2023-11-22 05:29:13.651619+00
17	auth	0012_alter_user_first_name_max_length	2023-11-22 05:29:13.663725+00
18	filemanager	0001_initial	2023-11-22 05:29:13.698576+00
19	filemanager	0002_optionmenu_alter_file_options_and_more	2023-11-22 05:29:13.715845+00
20	filemanager	0003_alter_file_options	2023-11-22 05:29:13.721413+00
21	filemanager	0004_file_created_file_name	2023-11-22 05:29:13.739283+00
22	filemanager	0005_alter_file_created	2023-11-22 05:29:13.744878+00
23	filemanager	0006_alter_file_created	2023-11-22 05:29:13.751609+00
24	filemanager	0007_alter_file_created	2023-11-22 05:29:13.757712+00
25	filemanager	0008_alter_file_created	2023-11-22 05:29:13.763306+00
26	filemanager	0009_alter_file_created	2023-11-22 05:29:13.769989+00
27	filemanager	0010_alter_file_deleted	2023-11-22 05:29:13.776507+00
28	filemanager	0011_remove_file_ubication_file_img	2023-11-22 05:29:13.784922+00
29	filemanager	0012_remove_file_img_file_ubication	2023-11-22 05:29:13.792407+00
30	filemanager	0013_remove_file_ubication_file_img	2023-11-22 05:29:13.801503+00
31	sessions	0001_initial	2023-11-22 05:29:13.827437+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
wf153r4yr0f3slaxjbrlhs4s76dkka2t	.eJxVjDsOwyAQRO-ydYSADWBcps8Z0C4LwUlkS_5UUe6eWHLjcua9mQ9sS5mhNxdItK0t7TENAj0YOHVM-VXGHciTxsek8jSu88BqV9RBF3WfpLxvh3s6aLS0_zqj9g7ZI_pItopULfoaWDsjzmYSF4tB5FqcDRgcI4uJwki5s2I7-P4AqVI6hw:1r5gOH:CFk54mrpOLpTB5dpERJ6gVGgvxif_s_A9sFmD56fArI	2023-12-06 06:07:13.740908+00
o2szl8n7z5fziy9283matar4u31bhgil	.eJxVjEEOwiAQRe_C2hBgBIpL9z0DmWFAqoYmpV0Z765NutDtf-_9l4i4rTVuPS9xYnERWpx-N8L0yG0HfMd2m2Wa27pMJHdFHrTLceb8vB7u30HFXr91AuUskANwAU1hLorV2ZOymq1JyDZkDUAlW-PBWwJiHZgA02DYDOL9Adw5N-0:1r1ASc:wBnGZg2geOZ-j_mpSjDUm8fxTo6dyrQL2ElishI_ToI	2023-11-23 19:13:02.07+00
oqyha1gwg82kwnnqwqtdnia7lqyvteh0	.eJxVjDsOwyAQBe9CHSFgAxiX6X0GtMtCcBLZkj9VlLvHSC6S9s28eYuI-1bjvuYljix6ocXldyNMzzw1wA-c7rNM87QtI8mmyJOucpg5v26n-xeouNbjnUA5C-QAXEBTmItidfWkrGZrErINWQNQydZ48JaAWAcmwNQZNt0RbTnR688X3y46hw:1r1XE8:eIc2jYMNQ_yv_IoveM4Yt8tBb4Abe7DdSVkH_zMtyM0	2023-11-24 19:31:36.437+00
wmoyidbo66g625ac4r1w1ms2ly30uaop	.eJxVjEEOwiAQRe_C2hBgBIpL9z0DmWFAqoYmpV0Z765NutDtf-_9l4i4rTVuPS9xYnERWpx-N8L0yG0HfMd2m2Wa27pMJHdFHrTLceb8vB7u30HFXr91AuUskANwAU1hLorV2ZOymq1JyDZkDUAlW-PBWwJiHZgA02DYDOL9Adw5N-0:1r1Z5D:4_xunDHXV_HYLQrlB6STe_cGjtlBctB8a5BdCDXQ4A0	2023-11-24 21:30:31.216+00
\.


--
-- Data for Name: optionMenu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."optionMenu" (id, option) FROM stdin;
3	Visualize metadata
2	Visualize image
4	Delete
\.


--
-- Name: FileXUser_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."FileXUser_id_seq"', 1, true);


--
-- Name: File_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."File_id_seq"', 1, true);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 36, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 2, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 65, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 9, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 31, true);


--
-- Name: optionMenu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."optionMenu_id_seq"', 4, true);


--
-- Name: FileXUser FileXUser_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FileXUser"
    ADD CONSTRAINT "FileXUser_pkey" PRIMARY KEY (id);


--
-- Name: File File_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."File"
    ADD CONSTRAINT "File_pkey" PRIMARY KEY (id);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: optionMenu optionMenu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."optionMenu"
    ADD CONSTRAINT "optionMenu_pkey" PRIMARY KEY (id);


--
-- Name: FileXUser_file_957c646e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "FileXUser_file_957c646e" ON public."FileXUser" USING btree (file);


--
-- Name: FileXUser_user_3d64ce25; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "FileXUser_user_3d64ce25" ON public."FileXUser" USING btree ("user");


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: FileXUser FileXUser_file_957c646e_fk_File_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FileXUser"
    ADD CONSTRAINT "FileXUser_file_957c646e_fk_File_id" FOREIGN KEY (file) REFERENCES public."File"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: FileXUser FileXUser_user_3d64ce25_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FileXUser"
    ADD CONSTRAINT "FileXUser_user_3d64ce25_fk_auth_user_id" FOREIGN KEY ("user") REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

