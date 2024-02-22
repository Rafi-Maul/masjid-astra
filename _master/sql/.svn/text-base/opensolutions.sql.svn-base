--
-- PostgreSQL database dump
--

-- Started on 2011-11-13 08:12:56

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 1871 (class 1262 OID 27201)
-- Dependencies: 1870
-- Name: opensolutions2; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON DATABASE opensolutions2 IS 'Database OpenSolutions.';


--
-- TOC entry 475 (class 2612 OID 27204)
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: -
--

CREATE PROCEDURAL LANGUAGE plpgsql;


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 140 (class 1259 OID 27205)
-- Dependencies: 6
-- Name: dd_access; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dd_access (
    id_dd_access integer NOT NULL,
    access_name character varying(50) NOT NULL,
    access_code smallint NOT NULL,
    note character varying(100)
);


--
-- TOC entry 1874 (class 0 OID 0)
-- Dependencies: 140
-- Name: TABLE dd_access; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dd_access IS 'Data hak akses';


--
-- TOC entry 141 (class 1259 OID 27208)
-- Dependencies: 6 140
-- Name: dd_access_id_dd_access_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dd_access_id_dd_access_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1
    CYCLE;


--
-- TOC entry 1875 (class 0 OID 0)
-- Dependencies: 141
-- Name: dd_access_id_dd_access_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dd_access_id_dd_access_seq OWNED BY dd_access.id_dd_access;


--
-- TOC entry 1876 (class 0 OID 0)
-- Dependencies: 141
-- Name: dd_access_id_dd_access_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dd_access_id_dd_access_seq', 5, true);


--
-- TOC entry 142 (class 1259 OID 27210)
-- Dependencies: 6
-- Name: dd_groups; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dd_groups (
    id_dd_groups integer NOT NULL,
    flag_system boolean NOT NULL,
    group_name character varying(50) NOT NULL,
    note character varying(100)
);


--
-- TOC entry 1877 (class 0 OID 0)
-- Dependencies: 142
-- Name: TABLE dd_groups; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dd_groups IS 'Data kelompok pengguna';


--
-- TOC entry 143 (class 1259 OID 27213)
-- Dependencies: 6
-- Name: dd_groups_detail; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dd_groups_detail (
    id_dd_groups_detail integer NOT NULL,
    id_dd_groups integer NOT NULL,
    id_dd_tabs integer NOT NULL,
    access_code smallint NOT NULL
);


--
-- TOC entry 1878 (class 0 OID 0)
-- Dependencies: 143
-- Name: TABLE dd_groups_detail; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dd_groups_detail IS 'Data kelompok detail';


--
-- TOC entry 144 (class 1259 OID 27216)
-- Dependencies: 6 143
-- Name: dd_groups_detail_id_dd_groups_detail_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dd_groups_detail_id_dd_groups_detail_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1
    CYCLE;


--
-- TOC entry 1879 (class 0 OID 0)
-- Dependencies: 144
-- Name: dd_groups_detail_id_dd_groups_detail_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dd_groups_detail_id_dd_groups_detail_seq OWNED BY dd_groups_detail.id_dd_groups_detail;


--
-- TOC entry 1880 (class 0 OID 0)
-- Dependencies: 144
-- Name: dd_groups_detail_id_dd_groups_detail_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dd_groups_detail_id_dd_groups_detail_seq', 11, true);


--
-- TOC entry 145 (class 1259 OID 27218)
-- Dependencies: 6 142
-- Name: dd_groups_id_dd_groups_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dd_groups_id_dd_groups_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1
    CYCLE;


--
-- TOC entry 1881 (class 0 OID 0)
-- Dependencies: 145
-- Name: dd_groups_id_dd_groups_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dd_groups_id_dd_groups_seq OWNED BY dd_groups.id_dd_groups;


--
-- TOC entry 1882 (class 0 OID 0)
-- Dependencies: 145
-- Name: dd_groups_id_dd_groups_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dd_groups_id_dd_groups_seq', 4, true);


--
-- TOC entry 146 (class 1259 OID 27220)
-- Dependencies: 6
-- Name: dd_menus; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dd_menus (
    id_dd_menus integer NOT NULL,
    id_dd_moduls integer NOT NULL,
    order_number smallint NOT NULL,
    menu character varying(50) NOT NULL,
    note character varying(100)
);


--
-- TOC entry 1883 (class 0 OID 0)
-- Dependencies: 146
-- Name: TABLE dd_menus; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dd_menus IS 'Data menu';


--
-- TOC entry 147 (class 1259 OID 27223)
-- Dependencies: 146 6
-- Name: dd_menus_id_dd_menus_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dd_menus_id_dd_menus_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1
    CYCLE;


--
-- TOC entry 1884 (class 0 OID 0)
-- Dependencies: 147
-- Name: dd_menus_id_dd_menus_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dd_menus_id_dd_menus_seq OWNED BY dd_menus.id_dd_menus;


--
-- TOC entry 1885 (class 0 OID 0)
-- Dependencies: 147
-- Name: dd_menus_id_dd_menus_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dd_menus_id_dd_menus_seq', 3, true);


--
-- TOC entry 148 (class 1259 OID 27225)
-- Dependencies: 6
-- Name: dd_moduls; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dd_moduls (
    id_dd_moduls integer NOT NULL,
    order_number smallint NOT NULL,
    modul character varying(50) NOT NULL,
    note character varying(100)
);


--
-- TOC entry 1886 (class 0 OID 0)
-- Dependencies: 148
-- Name: TABLE dd_moduls; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dd_moduls IS 'Data modul-modul';


--
-- TOC entry 149 (class 1259 OID 27228)
-- Dependencies: 6 148
-- Name: dd_moduls_id_dd_moduls_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dd_moduls_id_dd_moduls_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1
    CYCLE;


--
-- TOC entry 1887 (class 0 OID 0)
-- Dependencies: 149
-- Name: dd_moduls_id_dd_moduls_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dd_moduls_id_dd_moduls_seq OWNED BY dd_moduls.id_dd_moduls;


--
-- TOC entry 1888 (class 0 OID 0)
-- Dependencies: 149
-- Name: dd_moduls_id_dd_moduls_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dd_moduls_id_dd_moduls_seq', 12, true);


--
-- TOC entry 150 (class 1259 OID 27230)
-- Dependencies: 6
-- Name: dd_sub_menus; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dd_sub_menus (
    id_dd_sub_menus integer NOT NULL,
    id_dd_menus integer NOT NULL,
    order_number smallint NOT NULL,
    sub_menu character varying(50) NOT NULL,
    note character varying(100)
);


--
-- TOC entry 1889 (class 0 OID 0)
-- Dependencies: 150
-- Name: TABLE dd_sub_menus; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dd_sub_menus IS 'Data sub menu';


--
-- TOC entry 151 (class 1259 OID 27233)
-- Dependencies: 150 6
-- Name: dd_sub_menus_id_dd_sub_menus_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dd_sub_menus_id_dd_sub_menus_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1
    CYCLE;


--
-- TOC entry 1890 (class 0 OID 0)
-- Dependencies: 151
-- Name: dd_sub_menus_id_dd_sub_menus_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dd_sub_menus_id_dd_sub_menus_seq OWNED BY dd_sub_menus.id_dd_sub_menus;


--
-- TOC entry 1891 (class 0 OID 0)
-- Dependencies: 151
-- Name: dd_sub_menus_id_dd_sub_menus_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dd_sub_menus_id_dd_sub_menus_seq', 3, true);


--
-- TOC entry 152 (class 1259 OID 27235)
-- Dependencies: 6
-- Name: dd_tabs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dd_tabs (
    id_dd_tabs integer NOT NULL,
    id_dd_sub_menus integer NOT NULL,
    flag_active boolean NOT NULL,
    order_number smallint NOT NULL,
    tab character varying(50) NOT NULL,
    url character varying(255),
    note character varying(100)
);


--
-- TOC entry 1892 (class 0 OID 0)
-- Dependencies: 152
-- Name: TABLE dd_tabs; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dd_tabs IS 'Data tab-tab';


--
-- TOC entry 153 (class 1259 OID 27238)
-- Dependencies: 6 152
-- Name: dd_tabs_id_dd_tabs_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dd_tabs_id_dd_tabs_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1
    CYCLE;


--
-- TOC entry 1893 (class 0 OID 0)
-- Dependencies: 153
-- Name: dd_tabs_id_dd_tabs_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dd_tabs_id_dd_tabs_seq OWNED BY dd_tabs.id_dd_tabs;


--
-- TOC entry 1894 (class 0 OID 0)
-- Dependencies: 153
-- Name: dd_tabs_id_dd_tabs_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dd_tabs_id_dd_tabs_seq', 8, true);


--
-- TOC entry 154 (class 1259 OID 27240)
-- Dependencies: 6
-- Name: dd_users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dd_users (
    id_dd_users integer NOT NULL,
    id_dd_groups integer NOT NULL,
    flag_active boolean NOT NULL,
    flag_system boolean NOT NULL,
    username character varying(100) NOT NULL,
    passkeys character(32) NOT NULL,
    note character varying(255)
);


--
-- TOC entry 1895 (class 0 OID 0)
-- Dependencies: 154
-- Name: TABLE dd_users; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dd_users IS 'Data pengguna';


--
-- TOC entry 155 (class 1259 OID 27243)
-- Dependencies: 154 6
-- Name: dd_users_id_dd_users_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE dd_users_id_dd_users_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1
    CYCLE;


--
-- TOC entry 1896 (class 0 OID 0)
-- Dependencies: 155
-- Name: dd_users_id_dd_users_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dd_users_id_dd_users_seq OWNED BY dd_users.id_dd_users;


--
-- TOC entry 1897 (class 0 OID 0)
-- Dependencies: 155
-- Name: dd_users_id_dd_users_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dd_users_id_dd_users_seq', 4, true);


--
-- TOC entry 1806 (class 2604 OID 27245)
-- Dependencies: 141 140
-- Name: id_dd_access; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dd_access ALTER COLUMN id_dd_access SET DEFAULT nextval('dd_access_id_dd_access_seq'::regclass);


--
-- TOC entry 1807 (class 2604 OID 27246)
-- Dependencies: 145 142
-- Name: id_dd_groups; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dd_groups ALTER COLUMN id_dd_groups SET DEFAULT nextval('dd_groups_id_dd_groups_seq'::regclass);


--
-- TOC entry 1808 (class 2604 OID 27247)
-- Dependencies: 144 143
-- Name: id_dd_groups_detail; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dd_groups_detail ALTER COLUMN id_dd_groups_detail SET DEFAULT nextval('dd_groups_detail_id_dd_groups_detail_seq'::regclass);


--
-- TOC entry 1809 (class 2604 OID 27248)
-- Dependencies: 147 146
-- Name: id_dd_menus; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dd_menus ALTER COLUMN id_dd_menus SET DEFAULT nextval('dd_menus_id_dd_menus_seq'::regclass);


--
-- TOC entry 1810 (class 2604 OID 27249)
-- Dependencies: 149 148
-- Name: id_dd_moduls; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dd_moduls ALTER COLUMN id_dd_moduls SET DEFAULT nextval('dd_moduls_id_dd_moduls_seq'::regclass);


--
-- TOC entry 1811 (class 2604 OID 27250)
-- Dependencies: 151 150
-- Name: id_dd_sub_menus; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dd_sub_menus ALTER COLUMN id_dd_sub_menus SET DEFAULT nextval('dd_sub_menus_id_dd_sub_menus_seq'::regclass);


--
-- TOC entry 1812 (class 2604 OID 27251)
-- Dependencies: 153 152
-- Name: id_dd_tabs; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dd_tabs ALTER COLUMN id_dd_tabs SET DEFAULT nextval('dd_tabs_id_dd_tabs_seq'::regclass);


--
-- TOC entry 1813 (class 2604 OID 27252)
-- Dependencies: 155 154
-- Name: id_dd_users; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dd_users ALTER COLUMN id_dd_users SET DEFAULT nextval('dd_users_id_dd_users_seq'::regclass);


--
-- TOC entry 1860 (class 0 OID 27205)
-- Dependencies: 140
-- Data for Name: dd_access; Type: TABLE DATA; Schema: public; Owner: -
--

COPY dd_access (id_dd_access, access_name, access_code, note) FROM stdin;
1	tambah	1	Menambahkan data pada halaman tersebut
2	edit	2	Merubah data pada halaman tersebut
3	hapus	4	Menghapus data pada halaman tersebut
4	proses	8	Memproses data pada halaman tersebut
5	cetak	16	Mencetak data pada halaman tersebut
\.


--
-- TOC entry 1861 (class 0 OID 27210)
-- Dependencies: 142
-- Data for Name: dd_groups; Type: TABLE DATA; Schema: public; Owner: -
--

COPY dd_groups (id_dd_groups, flag_system, group_name, note) FROM stdin;
1	t	Super Administrator	Super Administrator sistem
2	f	Administrator	Administrator sistem di bawah Super Administrator
3	f	Manajer	Pengawas kegiatan Operator
4	f	Operator	Petugas yang menjalankan sehari-hari
\.


--
-- TOC entry 1862 (class 0 OID 27213)
-- Dependencies: 143
-- Data for Name: dd_groups_detail; Type: TABLE DATA; Schema: public; Owner: -
--

COPY dd_groups_detail (id_dd_groups_detail, id_dd_groups, id_dd_tabs, access_code) FROM stdin;
1	4	8	17
2	2	8	23
3	3	8	19
4	1	1	31
5	1	2	31
6	1	3	31
7	1	4	31
8	1	5	31
9	1	6	31
10	1	7	31
11	1	8	31
\.


--
-- TOC entry 1863 (class 0 OID 27220)
-- Dependencies: 146
-- Data for Name: dd_menus; Type: TABLE DATA; Schema: public; Owner: -
--

COPY dd_menus (id_dd_menus, id_dd_moduls, order_number, menu, note) FROM stdin;
1	1	1	APLIKASI	Setup aplikasi
2	2	1	DATA DASAR	Data-data dasar
3	1	2	PENGGUNA	Data-data pengguna
\.


--
-- TOC entry 1864 (class 0 OID 27225)
-- Dependencies: 148
-- Data for Name: dd_moduls; Type: TABLE DATA; Schema: public; Owner: -
--

COPY dd_moduls (id_dd_moduls, order_number, modul, note) FROM stdin;
1	1	SETUP	Setup aplikasi
2	2	ADMIN	Administrasi aplikasi
\.


--
-- TOC entry 1865 (class 0 OID 27230)
-- Dependencies: 150
-- Data for Name: dd_sub_menus; Type: TABLE DATA; Schema: public; Owner: -
--

COPY dd_sub_menus (id_dd_sub_menus, id_dd_menus, order_number, sub_menu, note) FROM stdin;
1	1	1	Modul, Menu, Sub, Tab	Setup konfigurasi aplikasi
2	1	2	Access Groups & Right	Manajemen kelompok dan hak akses
3	3	1	User	Daftar pengguna aplikasi
\.


--
-- TOC entry 1866 (class 0 OID 27235)
-- Dependencies: 152
-- Data for Name: dd_tabs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY dd_tabs (id_dd_tabs, id_dd_sub_menus, flag_active, order_number, tab, url, note) FROM stdin;
1	1	t	1	Modul	/core/modul	Daftar modul
2	1	f	2	Menu	/core/menu	Daftar menu
3	1	f	3	Sub Menu	/core/subMenu	Daftar sub menu
4	1	f	4	Tab	/core/tab	Daftar tab
5	2	t	1	Access Groups	/core/group	Data-data kelompok pengguna
6	2	f	2	Access Right	/core/access	Hak akses halaman
7	2	f	3	Access Control List	/core/groupAccess	Kombinasi antara kelompok & hak akses
8	3	t	1	User	/core/login	Daftar pengguna aplikasi
\.


--
-- TOC entry 1867 (class 0 OID 27240)
-- Dependencies: 154
-- Data for Name: dd_users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY dd_users (id_dd_users, id_dd_groups, flag_active, flag_system, username, passkeys, note) FROM stdin;
1	1	t	t	sadmin	bddce66cf8a4e9e556e4a58bc78744ed	Super Administrator
2	2	t	f	admin	bddce66cf8a4e9e556e4a58bc78744ed	Administrator
3	3	t	f	manajer	bddce66cf8a4e9e556e4a58bc78744ed	Manajer
4	4	t	f	operator	bddce66cf8a4e9e556e4a58bc78744ed	Operator
\.


--
-- TOC entry 1815 (class 2606 OID 27254)
-- Dependencies: 140 140
-- Name: pk_dd_access; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_access
    ADD CONSTRAINT pk_dd_access PRIMARY KEY (id_dd_access);


--
-- TOC entry 1821 (class 2606 OID 27256)
-- Dependencies: 142 142
-- Name: pk_dd_groups; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_groups
    ADD CONSTRAINT pk_dd_groups PRIMARY KEY (id_dd_groups);


--
-- TOC entry 1827 (class 2606 OID 27258)
-- Dependencies: 146 146
-- Name: pk_dd_menus; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_menus
    ADD CONSTRAINT pk_dd_menus PRIMARY KEY (id_dd_menus);


--
-- TOC entry 1833 (class 2606 OID 27260)
-- Dependencies: 148 148
-- Name: pk_dd_moduls; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_moduls
    ADD CONSTRAINT pk_dd_moduls PRIMARY KEY (id_dd_moduls);


--
-- TOC entry 1839 (class 2606 OID 27262)
-- Dependencies: 150 150
-- Name: pk_dd_sub_menus; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_sub_menus
    ADD CONSTRAINT pk_dd_sub_menus PRIMARY KEY (id_dd_sub_menus);


--
-- TOC entry 1845 (class 2606 OID 27264)
-- Dependencies: 152 152
-- Name: pk_dd_tabs; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_tabs
    ADD CONSTRAINT pk_dd_tabs PRIMARY KEY (id_dd_tabs);


--
-- TOC entry 1851 (class 2606 OID 27266)
-- Dependencies: 154 154
-- Name: pk_dd_users; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_users
    ADD CONSTRAINT pk_dd_users PRIMARY KEY (id_dd_users);


--
-- TOC entry 1825 (class 2606 OID 27268)
-- Dependencies: 143 143
-- Name: pk_groups_detail; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_groups_detail
    ADD CONSTRAINT pk_groups_detail PRIMARY KEY (id_dd_groups_detail);


--
-- TOC entry 1817 (class 2606 OID 27270)
-- Dependencies: 140 140
-- Name: unique2_access; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_access
    ADD CONSTRAINT unique2_access UNIQUE (access_code);


--
-- TOC entry 1829 (class 2606 OID 27272)
-- Dependencies: 146 146 146 146
-- Name: unique2_menus; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_menus
    ADD CONSTRAINT unique2_menus UNIQUE (id_dd_moduls, menu, order_number);


--
-- TOC entry 1835 (class 2606 OID 27274)
-- Dependencies: 148 148
-- Name: unique2_moduls; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_moduls
    ADD CONSTRAINT unique2_moduls UNIQUE (order_number);


--
-- TOC entry 1841 (class 2606 OID 27276)
-- Dependencies: 150 150 150 150
-- Name: unique2_sub_menus; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_sub_menus
    ADD CONSTRAINT unique2_sub_menus UNIQUE (id_dd_menus, sub_menu, order_number);


--
-- TOC entry 1847 (class 2606 OID 27278)
-- Dependencies: 152 152
-- Name: unique2_tabs; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_tabs
    ADD CONSTRAINT unique2_tabs UNIQUE (url);


--
-- TOC entry 1819 (class 2606 OID 27280)
-- Dependencies: 140 140
-- Name: unique_access; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_access
    ADD CONSTRAINT unique_access UNIQUE (access_name);


--
-- TOC entry 1853 (class 2606 OID 27282)
-- Dependencies: 154 154
-- Name: unique_dd_users; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_users
    ADD CONSTRAINT unique_dd_users UNIQUE (username);


--
-- TOC entry 1823 (class 2606 OID 27284)
-- Dependencies: 142 142
-- Name: unique_groups; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_groups
    ADD CONSTRAINT unique_groups UNIQUE (group_name);


--
-- TOC entry 1831 (class 2606 OID 27286)
-- Dependencies: 146 146 146
-- Name: unique_menus; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_menus
    ADD CONSTRAINT unique_menus UNIQUE (id_dd_moduls, menu);


--
-- TOC entry 1837 (class 2606 OID 27288)
-- Dependencies: 148 148
-- Name: unique_moduls; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_moduls
    ADD CONSTRAINT unique_moduls UNIQUE (modul);


--
-- TOC entry 1843 (class 2606 OID 27290)
-- Dependencies: 150 150 150
-- Name: unique_sub_menus; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_sub_menus
    ADD CONSTRAINT unique_sub_menus UNIQUE (id_dd_menus, sub_menu);


--
-- TOC entry 1849 (class 2606 OID 27292)
-- Dependencies: 152 152 152
-- Name: unique_tabs; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_tabs
    ADD CONSTRAINT unique_tabs UNIQUE (id_dd_sub_menus, tab);


--
-- TOC entry 1859 (class 2606 OID 27293)
-- Dependencies: 1820 154 142
-- Name: fk_dd_groups; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_users
    ADD CONSTRAINT fk_dd_groups FOREIGN KEY (id_dd_groups) REFERENCES dd_groups(id_dd_groups) ON DELETE CASCADE DEFERRABLE;


--
-- TOC entry 1854 (class 2606 OID 27298)
-- Dependencies: 1820 143 142
-- Name: fk_dd_groups; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_groups_detail
    ADD CONSTRAINT fk_dd_groups FOREIGN KEY (id_dd_groups) REFERENCES dd_groups(id_dd_groups) ON DELETE CASCADE DEFERRABLE;


--
-- TOC entry 1857 (class 2606 OID 27303)
-- Dependencies: 1826 150 146
-- Name: fk_dd_menus; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_sub_menus
    ADD CONSTRAINT fk_dd_menus FOREIGN KEY (id_dd_menus) REFERENCES dd_menus(id_dd_menus) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE;


--
-- TOC entry 1856 (class 2606 OID 27308)
-- Dependencies: 146 148 1832
-- Name: fk_dd_moduls; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_menus
    ADD CONSTRAINT fk_dd_moduls FOREIGN KEY (id_dd_moduls) REFERENCES dd_moduls(id_dd_moduls) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE;


--
-- TOC entry 1858 (class 2606 OID 27313)
-- Dependencies: 150 152 1838
-- Name: fk_dd_sub_menus; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_tabs
    ADD CONSTRAINT fk_dd_sub_menus FOREIGN KEY (id_dd_sub_menus) REFERENCES dd_sub_menus(id_dd_sub_menus) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE;


--
-- TOC entry 1855 (class 2606 OID 27318)
-- Dependencies: 143 152 1844
-- Name: fk_dd_tabs; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_groups_detail
    ADD CONSTRAINT fk_dd_tabs FOREIGN KEY (id_dd_tabs) REFERENCES dd_tabs(id_dd_tabs) ON DELETE CASCADE DEFERRABLE;


--
-- TOC entry 1873 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: -
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO opensolutions;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2011-11-13 08:12:56

--
-- PostgreSQL database dump complete
--

