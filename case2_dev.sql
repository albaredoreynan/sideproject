--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: assigned_lawyers; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE assigned_lawyers (
    id integer NOT NULL,
    lawyer_id integer,
    file_matter_id integer,
    client_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.assigned_lawyers OWNER TO postgres;

--
-- Name: assigned_lawyers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE assigned_lawyers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.assigned_lawyers_id_seq OWNER TO postgres;

--
-- Name: assigned_lawyers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE assigned_lawyers_id_seq OWNED BY assigned_lawyers.id;


--
-- Name: case_entries; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE case_entries (
    id integer NOT NULL,
    entry_date date,
    work_particulars text,
    client_id integer,
    file_matter_id character varying(255),
    time_spent_from character varying(255),
    time_spent_to character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    file_matter_case character varying(255),
    lawyer_id integer,
    case_title character varying(255),
    user_id integer
);


ALTER TABLE public.case_entries OWNER TO postgres;

--
-- Name: case_entries_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE case_entries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.case_entries_id_seq OWNER TO postgres;

--
-- Name: case_entries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE case_entries_id_seq OWNED BY case_entries.id;


--
-- Name: clients; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE clients (
    id integer NOT NULL,
    name character varying(255),
    email character varying(255),
    contact_number character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    "position" character varying(255),
    address text,
    contact_person character varying(255)
);


ALTER TABLE public.clients OWNER TO postgres;

--
-- Name: clients_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.clients_id_seq OWNER TO postgres;

--
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE clients_id_seq OWNED BY clients.id;


--
-- Name: file_matters; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE file_matters (
    id integer NOT NULL,
    year character varying(255),
    file_code character varying(255),
    volume character varying(255),
    client_id character varying(255),
    title character varying(255),
    case_number character varying(255),
    lawyer_id character varying(255),
    case_date character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.file_matters OWNER TO postgres;

--
-- Name: file_matters_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE file_matters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.file_matters_id_seq OWNER TO postgres;

--
-- Name: file_matters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE file_matters_id_seq OWNED BY file_matters.id;


--
-- Name: lawyers; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE lawyers (
    id integer NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    middle_name character varying(255),
    mobile_number character varying(255),
    "position" character varying(255),
    email character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    rate character varying(255),
    initials character varying(255)
);


ALTER TABLE public.lawyers OWNER TO postgres;

--
-- Name: lawyers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE lawyers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lawyers_id_seq OWNER TO postgres;

--
-- Name: lawyers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE lawyers_id_seq OWNED BY lawyers.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    username character varying(255),
    name character varying(255),
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    role character varying(255)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY assigned_lawyers ALTER COLUMN id SET DEFAULT nextval('assigned_lawyers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY case_entries ALTER COLUMN id SET DEFAULT nextval('case_entries_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY clients ALTER COLUMN id SET DEFAULT nextval('clients_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY file_matters ALTER COLUMN id SET DEFAULT nextval('file_matters_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lawyers ALTER COLUMN id SET DEFAULT nextval('lawyers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: assigned_lawyers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY assigned_lawyers (id, lawyer_id, file_matter_id, client_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: assigned_lawyers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('assigned_lawyers_id_seq', 1, false);


--
-- Data for Name: case_entries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY case_entries (id, entry_date, work_particulars, client_id, file_matter_id, time_spent_from, time_spent_to, created_at, updated_at, file_matter_case, lawyer_id, case_title, user_id) FROM stdin;
\.


--
-- Name: case_entries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('case_entries_id_seq', 1, false);


--
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY clients (id, name, email, contact_number, created_at, updated_at, "position", address, contact_person) FROM stdin;
1	A LITTLE MONEY PHILIPPINES, INC.			2013-06-05 09:54:19.745131	2013-06-05 09:54:19.745131			
2	A LITTLE WORLD			2013-06-05 09:54:19.75827	2013-06-05 09:54:19.75827			
3	AB GEVECO SIGURD WALLDALL			2013-06-05 09:54:19.766226	2013-06-05 09:54:19.766226			
4	ABAT, ZENAIDA C. MRS.			2013-06-05 09:54:19.77471	2013-06-05 09:54:19.77471			
5	ABCC ENVIRONMENTAL TECHNOLOGIES			2013-06-05 09:54:19.783119	2013-06-05 09:54:19.783119			
6	ABN AMRO  BANK, INC.  (NOW ROYAL BANK OF SCOTLAND)			2013-06-05 09:54:19.79142	2013-06-05 09:54:19.79142			
7	ABOITIZ, LUIS MIGUEL MR.			2013-06-05 09:54:19.799667	2013-06-05 09:54:19.799667			
8	ABOITIZ, MA. REGINA AFRICA			2013-06-05 09:54:19.808135	2013-06-05 09:54:19.808135			
9	ABRAC RESOURCES CORPORATION			2013-06-05 09:54:19.816395	2013-06-05 09:54:19.816395			
10	ACACIO, ALBERT, MR.			2013-06-05 09:54:19.82479	2013-06-05 09:54:19.82479			
11	ACM LAND HOLDINGS, INC.			2013-06-05 09:54:19.833091	2013-06-05 09:54:19.833091			
12	ACOSTA, ROWELA C. (REFERRED BY U.S. EMBASSY)			2013-06-05 09:54:19.841415	2013-06-05 09:54:19.841415			
13	ACOTEX INDUSTRIES CORPORATION			2013-06-05 09:54:19.849719	2013-06-05 09:54:19.849719			
14	ACTIVE GROUP, INC.			2013-06-05 09:54:19.858045	2013-06-05 09:54:19.858045			
15	ACTIVE REALTY  & DEVELOPMENT CORPORATION			2013-06-05 09:54:19.866367	2013-06-05 09:54:19.866367			
16	ADAMSON AND ADAMSON INC.			2013-06-05 09:54:19.874707	2013-06-05 09:54:19.874707			
17	ADAMS, MICHAEL MR. (MAA CONSULTANTS, INC.)			2013-06-05 09:54:19.883037	2013-06-05 09:54:19.883037			
18	ADANIEL, EPPIE			2013-06-05 09:54:19.891369	2013-06-05 09:54:19.891369			
19	ADELFA PROPERTIES & SENATE PRESIDENT MANUEL B. VILLAR			2013-06-05 09:54:19.899685	2013-06-05 09:54:19.899685			
20	ADIDAS PHILIPPINES, INC.			2013-06-05 09:54:19.908032	2013-06-05 09:54:19.908032			
21	ADRISTE PHILIPPINES, INC.			2013-06-05 09:54:19.916353	2013-06-05 09:54:19.916353			
22	ADVANCE RECOVERY SYSTEM, INC.			2013-06-05 09:54:19.924844	2013-06-05 09:54:19.924844			
23	ADVERTISING BOARD OF THE PHILIPPINES			2013-06-05 09:54:19.933118	2013-06-05 09:54:19.933118			
24	AFRICA, ROSARIO MRS.			2013-06-05 09:54:19.941465	2013-06-05 09:54:19.941465			
25	AGHITECH PHILIPPINES, INC.			2013-06-05 09:54:19.94976	2013-06-05 09:54:19.94976			
26	AGRI-REALTY COMPANY., INC. (FORMERLY PURIPHIL REALTY DEVELOPMENT, INC.)			2013-06-05 09:54:19.95808	2013-06-05 09:54:19.95808			
27	AGROTEX COMMODITIES, INC.			2013-06-05 09:54:19.966407	2013-06-05 09:54:19.966407			
28	AIG AVIATION			2013-06-05 09:54:19.974754	2013-06-05 09:54:19.974754			
29	AIR FRANCE			2013-06-05 09:54:19.983091	2013-06-05 09:54:19.983091			
30	AIR FRANCE CARGO			2013-06-05 09:54:19.991422	2013-06-05 09:54:19.991422			
31	AJMR PORT SERVICES CORPORATION			2013-06-05 09:54:19.999731	2013-06-05 09:54:19.999731			
32	AL AWAN SAMEER MR.			2013-06-05 09:54:20.008079	2013-06-05 09:54:20.008079			
33	ALANANO, ARNNIE MR			2013-06-05 09:54:20.01641	2013-06-05 09:54:20.01641			
34	ALBA, MARK MR.			2013-06-05 09:54:20.024741	2013-06-05 09:54:20.024741			
\.


--
-- Name: clients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('clients_id_seq', 34, true);


--
-- Data for Name: file_matters; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY file_matters (id, year, file_code, volume, client_id, title, case_number, lawyer_id, case_date, created_at, updated_at) FROM stdin;
\.


--
-- Name: file_matters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('file_matters_id_seq', 1, false);


--
-- Data for Name: lawyers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY lawyers (id, first_name, last_name, middle_name, mobile_number, "position", email, created_at, updated_at, rate, initials) FROM stdin;
1	JOSE	FLORES	PACIS	\N	PARTNER	jpflores@platonmartinez.com	2013-06-05 09:54:20.04787	2013-06-05 09:54:20.04787		JPF
2	SAKLOLO	LEANO	ALLOGUINES	\N	PARTNER	saleano@platonmartinez.com	2013-06-05 09:54:20.058285	2013-06-05 09:54:20.058285		SAL
3	AUGUSTO	SAN PEDRO	SANTOS	\N	PARTNER	asanpedro@platonmartinez.com	2013-06-05 09:54:20.066307	2013-06-05 09:54:20.066307		ASP
4	CARLOS	PLATON	GUTIERREZ	\N	PARTNER	cgplaton@platonmartinez.com	2013-06-05 09:54:20.074643	2013-06-05 09:54:20.074643		CGP
5	HECTOR	MARTINEZ	AGUILA	\N	PARTNER	hamartinez@platonmartinez.com	2013-06-05 09:54:20.082963	2013-06-05 09:54:20.082963		HAM
6	ENNESTINE	FERNANDO	VILLAREAL	\N	PARTNER	edvfernando@platonmartinez.com	2013-06-05 09:54:20.09129	2013-06-05 09:54:20.09129		EDVF
7	GRACE	PANAGSAGAN	PADILLA	\N	PARTNER	gpqpanagsagan@platonmartinez.com	2013-06-05 09:54:20.099632	2013-06-05 09:54:20.099632		GPQP
8	OVALITO PETER	BANTILAN	MANDAC	\N	PARTNER	pmbantilan@platonmartinez.com	2013-06-05 09:54:20.107925	2013-06-05 09:54:20.107925		PMB
9	ANTHONY BRETT	ABENIR	MANDE	\N	JUNIOR PARTNER	abmabenir@platonmartinez.com	2013-06-05 09:54:20.116269	2013-06-05 09:54:20.116269		ABMA
10	JORGE AMBROSIO	ABES	P	\N			2013-06-05 09:54:20.124594	2013-06-05 09:54:20.124594		JAPA
11	RYAN	ANDRES	DEL PRADO	\N	JUNIOR ASSOCIATE	rdandres@platonmartinez.com	2013-06-05 09:54:20.132962	2013-06-05 09:54:20.132962		RDA
12	LUCKY ANGELO	ARANAS	TEMPORAZA	\N	JUNIOR ASSOCIATE	ltaranas@platonmartinez.com	2013-06-05 09:54:20.141313	2013-06-05 09:54:20.141313		LTA
13	JOEY	ARCILLA	S	\N			2013-06-05 09:54:20.149615	2013-06-05 09:54:20.149615		JSA
14	PRESCILA	BARTOLOME	DY CHUA	\N			2013-06-05 09:54:20.157947	2013-06-05 09:54:20.157947		PDCB
15	JON	BELLO	O	\N			2013-06-05 09:54:20.166275	2013-06-05 09:54:20.166275		JOB
16	JEROME	BONSOL	C	\N			2013-06-05 09:54:20.174648	2013-06-05 09:54:20.174648		JCB
17	JOUSTINE FELIX	CAMPANA	F	\N			2013-06-05 09:54:20.182984	2013-06-05 09:54:20.182984		JFC
18	MARIA JOSELLA TERESA	CARDENAS	MADRONIO	\N	JUNIOR ASSOCIATE	jtcardenas@platonmartinez.com	2013-06-05 09:54:20.191349	2013-06-05 09:54:20.191349		JTC
19	PAUL CORNELIUS	CASTILLO	TANJUSAY	\N	JUNIOR ASSOCIATE	ptcastillo@platonmartinez.com	2013-06-05 09:54:20.199651	2013-06-05 09:54:20.199651		PTC
20	AILEEN GRACE	CERO	M	\N			2013-06-05 09:54:20.207992	2013-06-05 09:54:20.207992		AGMC
21	JOVIAN JUBERT	DUMLAO	SANTOS	\N	SENIOR ASSOCIATE	jsdumlao@platonmartinez.com	2013-06-05 09:54:20.216328	2013-06-05 09:54:20.216328		JSSD
22	WARREN	DY CHUA	Y	\N			2013-06-05 09:54:20.224656	2013-06-05 09:54:20.224656		WYDC
23	ISAGANI ELIAS	ELACIO	A	\N			2013-06-05 09:54:20.23297	2013-06-05 09:54:20.23297		IEAE
24	FULGENCIO	FACTORAN	M	\N			2013-06-05 09:54:20.241329	2013-06-05 09:54:20.241329		FMF
25	ISRAFEL	FAGELA	DATU	\N	JUNIOR PARTNER	idfagela@platonmartinez.com	2013-06-05 09:54:20.249623	2013-06-05 09:54:20.249623		IDF
26	MARY JOYCE	FLORENDO	G	\N			2013-06-05 09:54:20.25797	2013-06-05 09:54:20.25797		MUGF
27	ANNA JAZYVEN	GONGORA	VALENZUELA	\N			2013-06-05 09:54:20.266295	2013-06-05 09:54:20.266295		AJVG
28	ANTHONY RAYMOND	GOQUINGCO	A	\N			2013-06-05 09:54:20.274629	2013-06-05 09:54:20.274629		
29	ERWIN	HERRERA	SANTOS	\N			2013-06-05 09:54:20.282972	2013-06-05 09:54:20.282972		
30	JOAN CATHERINE	LIBAN	R	\N			2013-06-05 09:54:20.291299	2013-06-05 09:54:20.291299		
31	ELSON	MANAHAN	BAUTISTA	\N			2013-06-05 09:54:20.299633	2013-06-05 09:54:20.299633		
32	CORNELIUS VICTOR	MARIANO	L	\N			2013-06-05 09:54:20.307981	2013-06-05 09:54:20.307981		
33	MIA CARISSA	MARTIN	CELESTIAL	\N	JUNIOR PARTNER	mcmartin@platonmartinez.com	2013-06-05 09:54:20.316265	2013-06-05 09:54:20.316265		MCCM
34	NARCISA	MEDINA	TUMBAGAHON	\N	JUNIOR ASSOCIATE	ntmedina@platonmartinez.com	2013-06-05 09:54:20.324615	2013-06-05 09:54:20.324615		NTM
35	ETHEL	MERCADO	V	\N			2013-06-05 09:54:20.33294	2013-06-05 09:54:20.33294		
36	ARNALDO	MORALEJO	C	\N			2013-06-05 09:54:20.341293	2013-06-05 09:54:20.341293		
37	PETER PAUL	NATIVIDAD	TURINGAN	\N			2013-06-05 09:54:20.34961	2013-06-05 09:54:20.34961		
38	BRAN MATTHEW	NEPOMUCENO	C	\N			2013-06-05 09:54:20.357935	2013-06-05 09:54:20.357935		
39	FAYE CHRISTINE	PAREDES	M	\N			2013-06-05 09:54:20.366261	2013-06-05 09:54:20.366261		
40	DIONNE	PULMA	ECAP	\N	SENIOR ASSOCIATE	depulma@platonmartinez.com	2013-06-05 09:54:20.374594	2013-06-05 09:54:20.374594		DEP
41	FELIX CONRAD	REYES	BAES	\N	JUNIOR ASSOCIATE	fbreyes@platonmartinez.com	2013-06-05 09:54:20.382935	2013-06-05 09:54:20.382935		FBR
42	LILI-MAE	REYES	TEE	\N	JUNIOR ASSOCIATE	ltreyes@platonmartinez.com	2013-06-05 09:54:20.391228	2013-06-05 09:54:20.391228		LTR
43	JOAN KAREN	RIOLA	A	\N			2013-06-05 09:54:20.399583	2013-06-05 09:54:20.399583		JKAR
44	ALDWIN	SALUMBIDES	B	\N			2013-06-05 09:54:20.407931	2013-06-05 09:54:20.407931		
45	ENRICO	SANDOVAL	B	\N			2013-06-05 09:54:20.416282	2013-06-05 09:54:20.416282		
46	JENNY	SANTIAGO	ROBLES	\N	JUNIOR PARTNER	jrsantiago@platonmartinez.com	2013-06-05 09:54:20.42461	2013-06-05 09:54:20.42461		JRS
47	EDLYN MARGARET	SANTIAGO	CORDERO	\N	JUNIOR ASSOCIATE	ecsantiago@platonmartinez.com	2013-06-05 09:54:20.432937	2013-06-05 09:54:20.432937		ECS
48	RACHELLE AILEEN	SANTOS	SANTOS	\N	JUNIOR PARTNER	rssantos@platonmartinez.com	2013-06-05 09:54:20.44129	2013-06-05 09:54:20.44129		RSS
49	JASON KYLE	SARENAS	MANGROBANG	\N	JUNIOR ASSOCIATE	kmsarenas@platonmartinez.com	2013-06-05 09:54:20.449601	2013-06-05 09:54:20.449601		KMS
50	PATRICIA	SEE	G	\N			2013-06-05 09:54:20.457933	2013-06-05 09:54:20.457933		
51	ARTURO	SELIM	GARCIA	\N	JUNIOR PARTNER	agselim@platonmartinez.com	2013-06-05 09:54:20.466253	2013-06-05 09:54:20.466253		AGS
52	ALFONSO MIGUEL	SIASON	MARQUEZ-LIM	\N			2013-06-05 09:54:20.474574	2013-06-05 09:54:20.474574		
53	JUFIL	SIQUIAN	E	\N			2013-06-05 09:54:20.482929	2013-06-05 09:54:20.482929		
54	PORTIA SHIRLEY	VALENCIA	V	\N			2013-06-05 09:54:20.491284	2013-06-05 09:54:20.491284		
55	ENRIQUE UAN	VERA	C	\N			2013-06-05 09:54:20.499593	2013-06-05 09:54:20.499593		
56	ALPHEUS\tTIAMSON	VILLALUZ	TIAMSON	\N	JUNIOR ASSOCIATE	atvillaluz@platonmartinez.com	2013-06-05 09:54:20.507899	2013-06-05 09:54:20.507899		ATV
57	ARMIN NOEL	VILLAMONTE	B	\N			2013-06-05 09:54:20.516266	2013-06-05 09:54:20.516266		
58	VIMARI	VILLAMOR	DELGADO	\N			2013-06-05 09:54:20.524559	2013-06-05 09:54:20.524559		VDV
59	ANTHEA	VILLARUEL	REYES	\N			2013-06-05 09:54:20.532905	2013-06-05 09:54:20.532905		
\.


--
-- Name: lawyers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('lawyers_id_seq', 59, true);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY schema_migrations (version) FROM stdin;
20130430065318
20130418085139
20130418081750
20130418081735
20130430035730
20130418081742
20130418055340
20130422064221
20130605074804
20130604023654
20130531004509
20130531005240
20130610141413
20130611022858
20130612040101
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY users (id, email, encrypted_password, username, name, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, created_at, updated_at, role) FROM stdin;
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('users_id_seq', 1, false);


--
-- Name: assigned_lawyers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY assigned_lawyers
    ADD CONSTRAINT assigned_lawyers_pkey PRIMARY KEY (id);


--
-- Name: case_entries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY case_entries
    ADD CONSTRAINT case_entries_pkey PRIMARY KEY (id);


--
-- Name: clients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- Name: file_matters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY file_matters
    ADD CONSTRAINT file_matters_pkey PRIMARY KEY (id);


--
-- Name: lawyers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY lawyers
    ADD CONSTRAINT lawyers_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

