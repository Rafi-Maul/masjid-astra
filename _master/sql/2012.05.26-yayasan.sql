--
-- PostgreSQL database dump
--

-- Started on 2012-05-26 17:25:26 WIT

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 2302 (class 1262 OID 25331)
-- Dependencies: 2301
-- Name: yayasan; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON DATABASE yayasan IS 'Database Pengembangan u/ Yayasan ASTRA.';


--
-- TOC entry 5 (class 2615 OID 25332)
-- Name: akun; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA akun;


--
-- TOC entry 2303 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA akun; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA akun IS 'Skema untuk akuntansi.';


--
-- TOC entry 6 (class 2615 OID 25333)
-- Name: trans; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA trans;


--
-- TOC entry 2306 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA trans; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA trans IS 'Skema untuk transaksi.';


--
-- TOC entry 691 (class 2612 OID 25336)
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: -
--

CREATE PROCEDURAL LANGUAGE plpgsql;


SET search_path = akun, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 142 (class 1259 OID 25337)
-- Dependencies: 2028 2029 5
-- Name: akdd_arus_kas; Type: TABLE; Schema: akun; Owner: -; Tablespace: 
--

CREATE TABLE akdd_arus_kas (
    id_akdd_arus_kas integer NOT NULL,
    id_akdd_arus_kas_ref integer NOT NULL,
    uraian character varying(255) NOT NULL,
    coa_range character varying(255) NOT NULL,
    order_number smallint NOT NULL,
    kalkulasi character(1) DEFAULT 'd'::bpchar NOT NULL,
    kalibrasi smallint DEFAULT 1 NOT NULL
);


--
-- TOC entry 2307 (class 0 OID 0)
-- Dependencies: 142
-- Name: TABLE akdd_arus_kas; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akdd_arus_kas IS 'Tabel yang berfungsi sebagai template laporan arus kas.';


--
-- TOC entry 143 (class 1259 OID 25345)
-- Dependencies: 142 5
-- Name: akdd_arus_kas_id_akdd_arus_kas_seq; Type: SEQUENCE; Schema: akun; Owner: -
--

CREATE SEQUENCE akdd_arus_kas_id_akdd_arus_kas_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2308 (class 0 OID 0)
-- Dependencies: 143
-- Name: akdd_arus_kas_id_akdd_arus_kas_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akdd_arus_kas_id_akdd_arus_kas_seq OWNED BY akdd_arus_kas.id_akdd_arus_kas;


--
-- TOC entry 2309 (class 0 OID 0)
-- Dependencies: 143
-- Name: akdd_arus_kas_id_akdd_arus_kas_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akdd_arus_kas_id_akdd_arus_kas_seq', 1, false);


--
-- TOC entry 144 (class 1259 OID 25347)
-- Dependencies: 5
-- Name: akdd_detail_coa; Type: TABLE; Schema: akun; Owner: -; Tablespace: 
--

CREATE TABLE akdd_detail_coa (
    id_akdd_detail_coa integer NOT NULL,
    id_akdd_main_coa integer NOT NULL,
    id_akdd_level_coa integer NOT NULL,
    id_akdd_detail_coa_ref integer NOT NULL,
    coa_number character varying(50) NOT NULL,
    coa_number_num integer NOT NULL,
    uraian character varying(255) NOT NULL
);


--
-- TOC entry 2310 (class 0 OID 0)
-- Dependencies: 144
-- Name: TABLE akdd_detail_coa; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akdd_detail_coa IS 'Data-data detail COA.';


--
-- TOC entry 145 (class 1259 OID 25350)
-- Dependencies: 5
-- Name: akdd_level_coa; Type: TABLE; Schema: akun; Owner: -; Tablespace: 
--

CREATE TABLE akdd_level_coa (
    id_akdd_level_coa integer NOT NULL,
    level_number smallint NOT NULL,
    level_length smallint NOT NULL,
    uraian character varying(255)
);


--
-- TOC entry 2311 (class 0 OID 0)
-- Dependencies: 145
-- Name: TABLE akdd_level_coa; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akdd_level_coa IS 'Data level COA.';


--
-- TOC entry 146 (class 1259 OID 25353)
-- Dependencies: 1831 5
-- Name: akdd_coa_level_detail_v; Type: VIEW; Schema: akun; Owner: -
--

CREATE VIEW akdd_coa_level_detail_v AS
    SELECT a.id_akdd_detail_coa, a.id_akdd_main_coa, a.id_akdd_level_coa, a.id_akdd_detail_coa_ref, a.coa_number, a.uraian FROM (akdd_detail_coa a JOIN (SELECT akdd_level_coa.id_akdd_level_coa FROM akdd_level_coa ORDER BY akdd_level_coa.level_number DESC OFFSET 0 LIMIT 1) b ON ((a.id_akdd_level_coa = b.id_akdd_level_coa)));


--
-- TOC entry 147 (class 1259 OID 25357)
-- Dependencies: 5 144
-- Name: akdd_detail_coa_id_akdd_detail_coa_seq; Type: SEQUENCE; Schema: akun; Owner: -
--

CREATE SEQUENCE akdd_detail_coa_id_akdd_detail_coa_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2312 (class 0 OID 0)
-- Dependencies: 147
-- Name: akdd_detail_coa_id_akdd_detail_coa_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akdd_detail_coa_id_akdd_detail_coa_seq OWNED BY akdd_detail_coa.id_akdd_detail_coa;


--
-- TOC entry 2313 (class 0 OID 0)
-- Dependencies: 147
-- Name: akdd_detail_coa_id_akdd_detail_coa_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akdd_detail_coa_id_akdd_detail_coa_seq', 113, true);


--
-- TOC entry 148 (class 1259 OID 25359)
-- Dependencies: 2033 5
-- Name: akmt_jurnal_det; Type: TABLE; Schema: akun; Owner: -; Tablespace: 
--

CREATE TABLE akmt_jurnal_det (
    id_akmt_jurnal_det bigint NOT NULL,
    id_akmt_jurnal bigint NOT NULL,
    id_akdd_detail_coa integer NOT NULL,
    flag_position character(1) DEFAULT 'd'::bpchar NOT NULL,
    jumlah double precision NOT NULL
);


--
-- TOC entry 2314 (class 0 OID 0)
-- Dependencies: 148
-- Name: TABLE akmt_jurnal_det; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akmt_jurnal_det IS 'Data jurnal detail.';


--
-- TOC entry 2315 (class 0 OID 0)
-- Dependencies: 148
-- Name: COLUMN akmt_jurnal_det.flag_position; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON COLUMN akmt_jurnal_det.flag_position IS '
d = Debet
k = Kredit';


--
-- TOC entry 149 (class 1259 OID 25363)
-- Dependencies: 1832 5
-- Name: akdd_detail_coa_jurnal_v; Type: VIEW; Schema: akun; Owner: -
--

CREATE VIEW akdd_detail_coa_jurnal_v AS
    SELECT DISTINCT akmt_jurnal_det.id_akdd_detail_coa FROM akmt_jurnal_det ORDER BY akmt_jurnal_det.id_akdd_detail_coa;


--
-- TOC entry 150 (class 1259 OID 25367)
-- Dependencies: 5
-- Name: akdd_detail_coa_lr; Type: TABLE; Schema: akun; Owner: -; Tablespace: 
--

CREATE TABLE akdd_detail_coa_lr (
    id_akdd_detail_coa_lr integer NOT NULL,
    id_akdd_detail_coa integer NOT NULL,
    id_akdd_klasifikasi_modal integer NOT NULL,
    sub_coa character varying(255) NOT NULL
);


--
-- TOC entry 2316 (class 0 OID 0)
-- Dependencies: 150
-- Name: TABLE akdd_detail_coa_lr; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akdd_detail_coa_lr IS 'Data-data klasifikasi modal (sistem jurnal penutup automatis).';


--
-- TOC entry 151 (class 1259 OID 25370)
-- Dependencies: 5 150
-- Name: akdd_detail_coa_lr_id_akdd_detail_coa_lr_seq; Type: SEQUENCE; Schema: akun; Owner: -
--

CREATE SEQUENCE akdd_detail_coa_lr_id_akdd_detail_coa_lr_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2317 (class 0 OID 0)
-- Dependencies: 151
-- Name: akdd_detail_coa_lr_id_akdd_detail_coa_lr_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akdd_detail_coa_lr_id_akdd_detail_coa_lr_seq OWNED BY akdd_detail_coa_lr.id_akdd_detail_coa_lr;


--
-- TOC entry 2318 (class 0 OID 0)
-- Dependencies: 151
-- Name: akdd_detail_coa_lr_id_akdd_detail_coa_lr_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akdd_detail_coa_lr_id_akdd_detail_coa_lr_seq', 4, true);


--
-- TOC entry 152 (class 1259 OID 25372)
-- Dependencies: 2036 5
-- Name: akdd_detail_coa_map; Type: TABLE; Schema: akun; Owner: -; Tablespace: 
--

CREATE TABLE akdd_detail_coa_map (
    id_akdd_detail_coa_map integer NOT NULL,
    id_akdd_detail_coa integer NOT NULL,
    flag smallint DEFAULT 0 NOT NULL
);


--
-- TOC entry 2319 (class 0 OID 0)
-- Dependencies: 152
-- Name: TABLE akdd_detail_coa_map; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akdd_detail_coa_map IS 'Tabel mapping coa yg masuk di pemasukan, pengeluaran, dan jurnal umum.';


--
-- TOC entry 2320 (class 0 OID 0)
-- Dependencies: 152
-- Name: COLUMN akdd_detail_coa_map.flag; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON COLUMN akdd_detail_coa_map.flag IS '0: JU
1: JU + JP
2: JU + JB
3: JU + JP + JB';


--
-- TOC entry 153 (class 1259 OID 25376)
-- Dependencies: 5 152
-- Name: akdd_detail_coa_map_id_akdd_detail_coa_map_seq; Type: SEQUENCE; Schema: akun; Owner: -
--

CREATE SEQUENCE akdd_detail_coa_map_id_akdd_detail_coa_map_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2321 (class 0 OID 0)
-- Dependencies: 153
-- Name: akdd_detail_coa_map_id_akdd_detail_coa_map_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akdd_detail_coa_map_id_akdd_detail_coa_map_seq OWNED BY akdd_detail_coa_map.id_akdd_detail_coa_map;


--
-- TOC entry 2322 (class 0 OID 0)
-- Dependencies: 153
-- Name: akdd_detail_coa_map_id_akdd_detail_coa_map_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akdd_detail_coa_map_id_akdd_detail_coa_map_seq', 85, true);


--
-- TOC entry 154 (class 1259 OID 25378)
-- Dependencies: 5
-- Name: akdd_main_coa; Type: TABLE; Schema: akun; Owner: -; Tablespace: 
--

CREATE TABLE akdd_main_coa (
    id_akdd_main_coa integer NOT NULL,
    acc_type character(1) NOT NULL,
    binary_code smallint NOT NULL,
    uraian character varying(50) NOT NULL
);


--
-- TOC entry 2323 (class 0 OID 0)
-- Dependencies: 154
-- Name: TABLE akdd_main_coa; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akdd_main_coa IS 'Data kategori utama COA.';


--
-- TOC entry 155 (class 1259 OID 25381)
-- Dependencies: 1833 5
-- Name: akdd_detail_coa_v; Type: VIEW; Schema: akun; Owner: -
--

CREATE VIEW akdd_detail_coa_v AS
    SELECT a.id_akdd_detail_coa, a.id_akdd_main_coa, a.id_akdd_level_coa, a.id_akdd_detail_coa_ref AS id_akdd_detail_coa_parent, d.id_akdd_detail_coa_ref, a.coa_number, a.uraian, b.acc_type, b.uraian AS uraian_main_coa, c.level_number, c.level_length FROM (((akdd_detail_coa a JOIN akdd_main_coa b ON ((a.id_akdd_main_coa = b.id_akdd_main_coa))) JOIN akdd_level_coa c ON ((a.id_akdd_level_coa = c.id_akdd_level_coa))) LEFT JOIN (SELECT a.id_akdd_detail_coa_ref FROM (akdd_detail_coa a JOIN akdd_level_coa b ON ((a.id_akdd_level_coa = b.id_akdd_level_coa))) WHERE (b.level_number > 1) GROUP BY a.id_akdd_detail_coa_ref) d ON ((a.id_akdd_detail_coa = d.id_akdd_detail_coa_ref)));


--
-- TOC entry 156 (class 1259 OID 25386)
-- Dependencies: 5
-- Name: akdd_klasifikasi_modal; Type: TABLE; Schema: akun; Owner: -; Tablespace: 
--

CREATE TABLE akdd_klasifikasi_modal (
    id_akdd_klasifikasi_modal integer NOT NULL,
    binary_code smallint NOT NULL,
    klasifikasi character varying(50) NOT NULL,
    uraian character varying(255)
);


--
-- TOC entry 2324 (class 0 OID 0)
-- Dependencies: 156
-- Name: TABLE akdd_klasifikasi_modal; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akdd_klasifikasi_modal IS 'Data-data klasifikasi modal.';


--
-- TOC entry 157 (class 1259 OID 25389)
-- Dependencies: 5 156
-- Name: akdd_klasifikasi_modal_id_akdd_klasifikasi_modal_seq; Type: SEQUENCE; Schema: akun; Owner: -
--

CREATE SEQUENCE akdd_klasifikasi_modal_id_akdd_klasifikasi_modal_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2325 (class 0 OID 0)
-- Dependencies: 157
-- Name: akdd_klasifikasi_modal_id_akdd_klasifikasi_modal_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akdd_klasifikasi_modal_id_akdd_klasifikasi_modal_seq OWNED BY akdd_klasifikasi_modal.id_akdd_klasifikasi_modal;


--
-- TOC entry 2326 (class 0 OID 0)
-- Dependencies: 157
-- Name: akdd_klasifikasi_modal_id_akdd_klasifikasi_modal_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akdd_klasifikasi_modal_id_akdd_klasifikasi_modal_seq', 5, true);


--
-- TOC entry 158 (class 1259 OID 25391)
-- Dependencies: 5
-- Name: akdd_kodifikasi_jurnal; Type: TABLE; Schema: akun; Owner: -; Tablespace: 
--

CREATE TABLE akdd_kodifikasi_jurnal (
    id_akdd_kodifikasi_jurnal integer NOT NULL,
    kode character(2) NOT NULL,
    notes character varying(255)
);


--
-- TOC entry 2327 (class 0 OID 0)
-- Dependencies: 158
-- Name: TABLE akdd_kodifikasi_jurnal; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akdd_kodifikasi_jurnal IS 'Tabel yang berisikan kodifikasi jurnal.
Misal :
JP = Jurnal Penerimaan
JB = Jurnal Biaya
JP = Jurnal Penutup
JS = Jurnal Penyesuaian
JK = Jurnal Koreksi';


--
-- TOC entry 159 (class 1259 OID 25394)
-- Dependencies: 5 145
-- Name: akdd_level_coa_id_akdd_level_coa_seq; Type: SEQUENCE; Schema: akun; Owner: -
--

CREATE SEQUENCE akdd_level_coa_id_akdd_level_coa_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2328 (class 0 OID 0)
-- Dependencies: 159
-- Name: akdd_level_coa_id_akdd_level_coa_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akdd_level_coa_id_akdd_level_coa_seq OWNED BY akdd_level_coa.id_akdd_level_coa;


--
-- TOC entry 2329 (class 0 OID 0)
-- Dependencies: 159
-- Name: akdd_level_coa_id_akdd_level_coa_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akdd_level_coa_id_akdd_level_coa_seq', 4, true);


--
-- TOC entry 160 (class 1259 OID 25396)
-- Dependencies: 5 154
-- Name: akdd_main_coa_id_akdd_main_coa_seq; Type: SEQUENCE; Schema: akun; Owner: -
--

CREATE SEQUENCE akdd_main_coa_id_akdd_main_coa_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2330 (class 0 OID 0)
-- Dependencies: 160
-- Name: akdd_main_coa_id_akdd_main_coa_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akdd_main_coa_id_akdd_main_coa_seq OWNED BY akdd_main_coa.id_akdd_main_coa;


--
-- TOC entry 2331 (class 0 OID 0)
-- Dependencies: 160
-- Name: akdd_main_coa_id_akdd_main_coa_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akdd_main_coa_id_akdd_main_coa_seq', 5, true);


--
-- TOC entry 161 (class 1259 OID 25398)
-- Dependencies: 5
-- Name: akdd_perubahan_dana; Type: TABLE; Schema: akun; Owner: -; Tablespace: 
--

CREATE TABLE akdd_perubahan_dana (
    id_akdd_perubahan_dana integer NOT NULL,
    id_akdd_perubahan_dana_ref integer NOT NULL,
    uraian character varying(255) NOT NULL,
    coa_range character varying(255) NOT NULL,
    order_number smallint NOT NULL
);


--
-- TOC entry 2332 (class 0 OID 0)
-- Dependencies: 161
-- Name: TABLE akdd_perubahan_dana; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akdd_perubahan_dana IS 'Data template perubahan dana.';


--
-- TOC entry 162 (class 1259 OID 25404)
-- Dependencies: 161 5
-- Name: akdd_perubahan_dana_id_akdd_perubahan_dana_seq; Type: SEQUENCE; Schema: akun; Owner: -
--

CREATE SEQUENCE akdd_perubahan_dana_id_akdd_perubahan_dana_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2333 (class 0 OID 0)
-- Dependencies: 162
-- Name: akdd_perubahan_dana_id_akdd_perubahan_dana_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akdd_perubahan_dana_id_akdd_perubahan_dana_seq OWNED BY akdd_perubahan_dana.id_akdd_perubahan_dana;


--
-- TOC entry 2334 (class 0 OID 0)
-- Dependencies: 162
-- Name: akdd_perubahan_dana_id_akdd_perubahan_dana_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akdd_perubahan_dana_id_akdd_perubahan_dana_seq', 24, true);


--
-- TOC entry 163 (class 1259 OID 25406)
-- Dependencies: 2041 5
-- Name: akdd_posisi_keuangan; Type: TABLE; Schema: akun; Owner: -; Tablespace: 
--

CREATE TABLE akdd_posisi_keuangan (
    id_akdd_posisi_keuangan integer NOT NULL,
    id_akdd_posisi_keuangan_ref integer NOT NULL,
    uraian character varying(255) NOT NULL,
    coa_range character varying(255) NOT NULL,
    order_number smallint NOT NULL,
    acc_type character(1) DEFAULT 'd'::bpchar NOT NULL
);


--
-- TOC entry 2335 (class 0 OID 0)
-- Dependencies: 163
-- Name: TABLE akdd_posisi_keuangan; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akdd_posisi_keuangan IS 'Tabel yang berfungsi sebagai template laporan posisi keuangan.';


--
-- TOC entry 164 (class 1259 OID 25413)
-- Dependencies: 5 163
-- Name: akdd_posisi_keuangan_id_akdd_posisi_keuangan_seq; Type: SEQUENCE; Schema: akun; Owner: -
--

CREATE SEQUENCE akdd_posisi_keuangan_id_akdd_posisi_keuangan_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2336 (class 0 OID 0)
-- Dependencies: 164
-- Name: akdd_posisi_keuangan_id_akdd_posisi_keuangan_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akdd_posisi_keuangan_id_akdd_posisi_keuangan_seq OWNED BY akdd_posisi_keuangan.id_akdd_posisi_keuangan;


--
-- TOC entry 2337 (class 0 OID 0)
-- Dependencies: 164
-- Name: akdd_posisi_keuangan_id_akdd_posisi_keuangan_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akdd_posisi_keuangan_id_akdd_posisi_keuangan_seq', 17, true);


--
-- TOC entry 165 (class 1259 OID 25415)
-- Dependencies: 5
-- Name: akmt_buku_besar; Type: TABLE; Schema: akun; Owner: -; Tablespace: 
--

CREATE TABLE akmt_buku_besar (
    id_akmt_buku_besar bigint NOT NULL,
    id_akmt_periode integer NOT NULL,
    id_akdd_detail_coa integer NOT NULL,
    no_bukti character varying(100) NOT NULL,
    tanggal date NOT NULL,
    keterangan character varying(255),
    awal double precision NOT NULL,
    mutasi_debet double precision NOT NULL,
    mutasi_kredit double precision NOT NULL,
    akhir double precision NOT NULL
);


--
-- TOC entry 2338 (class 0 OID 0)
-- Dependencies: 165
-- Name: TABLE akmt_buku_besar; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akmt_buku_besar IS 'Data saldo-saldo COA.';


--
-- TOC entry 166 (class 1259 OID 25418)
-- Dependencies: 165 5
-- Name: akmt_buku_besar_id_akmt_buku_besar_seq; Type: SEQUENCE; Schema: akun; Owner: -
--

CREATE SEQUENCE akmt_buku_besar_id_akmt_buku_besar_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2339 (class 0 OID 0)
-- Dependencies: 166
-- Name: akmt_buku_besar_id_akmt_buku_besar_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akmt_buku_besar_id_akmt_buku_besar_seq OWNED BY akmt_buku_besar.id_akmt_buku_besar;


--
-- TOC entry 2340 (class 0 OID 0)
-- Dependencies: 166
-- Name: akmt_buku_besar_id_akmt_buku_besar_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akmt_buku_besar_id_akmt_buku_besar_seq', 1, false);


--
-- TOC entry 167 (class 1259 OID 25420)
-- Dependencies: 5
-- Name: akmt_periode; Type: TABLE; Schema: akun; Owner: -; Tablespace: 
--

CREATE TABLE akmt_periode (
    id_akmt_periode integer NOT NULL,
    flag_temp smallint NOT NULL,
    tahun smallint NOT NULL,
    bulan smallint NOT NULL,
    uraian character varying(255)
);


--
-- TOC entry 2341 (class 0 OID 0)
-- Dependencies: 167
-- Name: TABLE akmt_periode; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akmt_periode IS 'Data periode keuangan.';


--
-- TOC entry 2342 (class 0 OID 0)
-- Dependencies: 167
-- Name: COLUMN akmt_periode.flag_temp; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON COLUMN akmt_periode.flag_temp IS '
0 = Temporary Dirty
1 = Temporary Clean
2 = Permanent';


--
-- TOC entry 168 (class 1259 OID 25423)
-- Dependencies: 1834 5
-- Name: akmt_buku_besar_periode_v; Type: VIEW; Schema: akun; Owner: -
--

CREATE VIEW akmt_buku_besar_periode_v AS
    SELECT c.id_akdd_main_coa, c.acc_type, c.id_akdd_detail_coa, c.coa_number, c.uraian AS coa_uraian, c.level_number, a.id_akmt_buku_besar, a.id_akmt_periode, a.no_bukti, a.tanggal, a.awal, a.mutasi_debet, a.mutasi_kredit, a.akhir, a.keterangan, b.tahun, b.bulan, b.uraian FROM ((akdd_detail_coa_v c LEFT JOIN akmt_buku_besar a ON ((a.id_akdd_detail_coa = c.id_akdd_detail_coa))) LEFT JOIN akmt_periode b ON ((a.id_akmt_periode = b.id_akmt_periode)));


--
-- TOC entry 169 (class 1259 OID 25428)
-- Dependencies: 5
-- Name: akmt_jurnal; Type: TABLE; Schema: akun; Owner: -; Tablespace: 
--

CREATE TABLE akmt_jurnal (
    id_akmt_jurnal bigint NOT NULL,
    flag_jurnal smallint NOT NULL,
    flag_temp smallint NOT NULL,
    flag_posting smallint NOT NULL,
    no_bukti character varying(100) NOT NULL,
    tanggal date NOT NULL,
    keterangan character varying(255)
);


--
-- TOC entry 2343 (class 0 OID 0)
-- Dependencies: 169
-- Name: TABLE akmt_jurnal; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akmt_jurnal IS 'Data jurnal.';


--
-- TOC entry 2344 (class 0 OID 0)
-- Dependencies: 169
-- Name: COLUMN akmt_jurnal.flag_jurnal; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON COLUMN akmt_jurnal.flag_jurnal IS '
0 = Jurnal umum
1 = Jurnal mapping';


--
-- TOC entry 2345 (class 0 OID 0)
-- Dependencies: 169
-- Name: COLUMN akmt_jurnal.flag_temp; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON COLUMN akmt_jurnal.flag_temp IS '
0 = Belum selesai
1 = Sudah selesai
2 = Sudah disetujui';


--
-- TOC entry 2346 (class 0 OID 0)
-- Dependencies: 169
-- Name: COLUMN akmt_jurnal.flag_posting; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON COLUMN akmt_jurnal.flag_posting IS '
0 = Belum posting
1 = Sudah posting sementara
2 = Sudah posting permanen';


--
-- TOC entry 170 (class 1259 OID 25431)
-- Dependencies: 5 148
-- Name: akmt_jurnal_det_id_akmt_jurnal_det_seq; Type: SEQUENCE; Schema: akun; Owner: -
--

CREATE SEQUENCE akmt_jurnal_det_id_akmt_jurnal_det_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2347 (class 0 OID 0)
-- Dependencies: 170
-- Name: akmt_jurnal_det_id_akmt_jurnal_det_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akmt_jurnal_det_id_akmt_jurnal_det_seq OWNED BY akmt_jurnal_det.id_akmt_jurnal_det;


--
-- TOC entry 2348 (class 0 OID 0)
-- Dependencies: 170
-- Name: akmt_jurnal_det_id_akmt_jurnal_det_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akmt_jurnal_det_id_akmt_jurnal_det_seq', 1, false);


--
-- TOC entry 171 (class 1259 OID 25433)
-- Dependencies: 5 169
-- Name: akmt_jurnal_id_akmt_jurnal_seq; Type: SEQUENCE; Schema: akun; Owner: -
--

CREATE SEQUENCE akmt_jurnal_id_akmt_jurnal_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2349 (class 0 OID 0)
-- Dependencies: 171
-- Name: akmt_jurnal_id_akmt_jurnal_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akmt_jurnal_id_akmt_jurnal_seq OWNED BY akmt_jurnal.id_akmt_jurnal;


--
-- TOC entry 2350 (class 0 OID 0)
-- Dependencies: 171
-- Name: akmt_jurnal_id_akmt_jurnal_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akmt_jurnal_id_akmt_jurnal_seq', 1, false);


--
-- TOC entry 172 (class 1259 OID 25435)
-- Dependencies: 5 167
-- Name: akmt_periode_id_akmt_periode_seq; Type: SEQUENCE; Schema: akun; Owner: -
--

CREATE SEQUENCE akmt_periode_id_akmt_periode_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2351 (class 0 OID 0)
-- Dependencies: 172
-- Name: akmt_periode_id_akmt_periode_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akmt_periode_id_akmt_periode_seq OWNED BY akmt_periode.id_akmt_periode;


--
-- TOC entry 2352 (class 0 OID 0)
-- Dependencies: 172
-- Name: akmt_periode_id_akmt_periode_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akmt_periode_id_akmt_periode_seq', 1, false);


SET search_path = public, pg_catalog;

--
-- TOC entry 173 (class 1259 OID 25437)
-- Dependencies: 8
-- Name: dd_access; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dd_access (
    id_dd_access integer NOT NULL,
    access_name character varying(50) NOT NULL,
    access_code smallint NOT NULL,
    note character varying(100)
);


--
-- TOC entry 2353 (class 0 OID 0)
-- Dependencies: 173
-- Name: TABLE dd_access; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dd_access IS 'Data hak akses';


--
-- TOC entry 174 (class 1259 OID 25440)
-- Dependencies: 8 173
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
-- TOC entry 2354 (class 0 OID 0)
-- Dependencies: 174
-- Name: dd_access_id_dd_access_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dd_access_id_dd_access_seq OWNED BY dd_access.id_dd_access;


--
-- TOC entry 2355 (class 0 OID 0)
-- Dependencies: 174
-- Name: dd_access_id_dd_access_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dd_access_id_dd_access_seq', 5, true);


--
-- TOC entry 175 (class 1259 OID 25442)
-- Dependencies: 8
-- Name: dd_groups; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dd_groups (
    id_dd_groups integer NOT NULL,
    flag_system boolean NOT NULL,
    group_name character varying(50) NOT NULL,
    note character varying(100)
);


--
-- TOC entry 2356 (class 0 OID 0)
-- Dependencies: 175
-- Name: TABLE dd_groups; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dd_groups IS 'Data kelompok pengguna';


--
-- TOC entry 176 (class 1259 OID 25445)
-- Dependencies: 8
-- Name: dd_groups_detail; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dd_groups_detail (
    id_dd_groups_detail integer NOT NULL,
    id_dd_groups integer NOT NULL,
    id_dd_tabs integer NOT NULL,
    access_code smallint NOT NULL
);


--
-- TOC entry 2357 (class 0 OID 0)
-- Dependencies: 176
-- Name: TABLE dd_groups_detail; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dd_groups_detail IS 'Data kelompok detail';


--
-- TOC entry 177 (class 1259 OID 25448)
-- Dependencies: 8 176
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
-- TOC entry 2358 (class 0 OID 0)
-- Dependencies: 177
-- Name: dd_groups_detail_id_dd_groups_detail_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dd_groups_detail_id_dd_groups_detail_seq OWNED BY dd_groups_detail.id_dd_groups_detail;


--
-- TOC entry 2359 (class 0 OID 0)
-- Dependencies: 177
-- Name: dd_groups_detail_id_dd_groups_detail_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dd_groups_detail_id_dd_groups_detail_seq', 140, true);


--
-- TOC entry 178 (class 1259 OID 25450)
-- Dependencies: 8 175
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
-- TOC entry 2360 (class 0 OID 0)
-- Dependencies: 178
-- Name: dd_groups_id_dd_groups_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dd_groups_id_dd_groups_seq OWNED BY dd_groups.id_dd_groups;


--
-- TOC entry 2361 (class 0 OID 0)
-- Dependencies: 178
-- Name: dd_groups_id_dd_groups_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dd_groups_id_dd_groups_seq', 4, true);


--
-- TOC entry 179 (class 1259 OID 25452)
-- Dependencies: 8
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
-- TOC entry 2362 (class 0 OID 0)
-- Dependencies: 179
-- Name: TABLE dd_menus; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dd_menus IS 'Data menu';


--
-- TOC entry 180 (class 1259 OID 25455)
-- Dependencies: 8 179
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
-- TOC entry 2363 (class 0 OID 0)
-- Dependencies: 180
-- Name: dd_menus_id_dd_menus_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dd_menus_id_dd_menus_seq OWNED BY dd_menus.id_dd_menus;


--
-- TOC entry 2364 (class 0 OID 0)
-- Dependencies: 180
-- Name: dd_menus_id_dd_menus_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dd_menus_id_dd_menus_seq', 8, true);


--
-- TOC entry 181 (class 1259 OID 25457)
-- Dependencies: 8
-- Name: dd_moduls; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE dd_moduls (
    id_dd_moduls integer NOT NULL,
    order_number smallint NOT NULL,
    modul character varying(50) NOT NULL,
    note character varying(100)
);


--
-- TOC entry 2365 (class 0 OID 0)
-- Dependencies: 181
-- Name: TABLE dd_moduls; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dd_moduls IS 'Data modul-modul';


--
-- TOC entry 182 (class 1259 OID 25460)
-- Dependencies: 8 181
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
-- TOC entry 2366 (class 0 OID 0)
-- Dependencies: 182
-- Name: dd_moduls_id_dd_moduls_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dd_moduls_id_dd_moduls_seq OWNED BY dd_moduls.id_dd_moduls;


--
-- TOC entry 2367 (class 0 OID 0)
-- Dependencies: 182
-- Name: dd_moduls_id_dd_moduls_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dd_moduls_id_dd_moduls_seq', 14, true);


--
-- TOC entry 183 (class 1259 OID 25462)
-- Dependencies: 8
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
-- TOC entry 2368 (class 0 OID 0)
-- Dependencies: 183
-- Name: TABLE dd_sub_menus; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dd_sub_menus IS 'Data sub menu';


--
-- TOC entry 184 (class 1259 OID 25465)
-- Dependencies: 8 183
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
-- TOC entry 2369 (class 0 OID 0)
-- Dependencies: 184
-- Name: dd_sub_menus_id_dd_sub_menus_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dd_sub_menus_id_dd_sub_menus_seq OWNED BY dd_sub_menus.id_dd_sub_menus;


--
-- TOC entry 2370 (class 0 OID 0)
-- Dependencies: 184
-- Name: dd_sub_menus_id_dd_sub_menus_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dd_sub_menus_id_dd_sub_menus_seq', 21, true);


--
-- TOC entry 185 (class 1259 OID 25467)
-- Dependencies: 8
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
-- TOC entry 2371 (class 0 OID 0)
-- Dependencies: 185
-- Name: TABLE dd_tabs; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dd_tabs IS 'Data tab-tab';


--
-- TOC entry 186 (class 1259 OID 25470)
-- Dependencies: 8 185
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
-- TOC entry 2372 (class 0 OID 0)
-- Dependencies: 186
-- Name: dd_tabs_id_dd_tabs_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dd_tabs_id_dd_tabs_seq OWNED BY dd_tabs.id_dd_tabs;


--
-- TOC entry 2373 (class 0 OID 0)
-- Dependencies: 186
-- Name: dd_tabs_id_dd_tabs_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dd_tabs_id_dd_tabs_seq', 45, true);


--
-- TOC entry 187 (class 1259 OID 25472)
-- Dependencies: 8
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
-- TOC entry 2374 (class 0 OID 0)
-- Dependencies: 187
-- Name: TABLE dd_users; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dd_users IS 'Data pengguna';


--
-- TOC entry 188 (class 1259 OID 25475)
-- Dependencies: 8 187
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
-- TOC entry 2375 (class 0 OID 0)
-- Dependencies: 188
-- Name: dd_users_id_dd_users_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dd_users_id_dd_users_seq OWNED BY dd_users.id_dd_users;


--
-- TOC entry 2376 (class 0 OID 0)
-- Dependencies: 188
-- Name: dd_users_id_dd_users_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dd_users_id_dd_users_seq', 4, true);


SET search_path = trans, pg_catalog;

--
-- TOC entry 189 (class 1259 OID 25477)
-- Dependencies: 6
-- Name: bank; Type: TABLE; Schema: trans; Owner: -; Tablespace: 
--

CREATE TABLE bank (
    id_bank integer NOT NULL,
    id_kota integer NOT NULL,
    id_dd_users integer NOT NULL,
    nama character varying(100) NOT NULL,
    keterangan character varying(255)
);


--
-- TOC entry 2377 (class 0 OID 0)
-- Dependencies: 189
-- Name: TABLE bank; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE bank IS 'Tabel data bank.';


--
-- TOC entry 190 (class 1259 OID 25480)
-- Dependencies: 6 189
-- Name: bank_id_bank_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE bank_id_bank_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2378 (class 0 OID 0)
-- Dependencies: 190
-- Name: bank_id_bank_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE bank_id_bank_seq OWNED BY bank.id_bank;


--
-- TOC entry 2379 (class 0 OID 0)
-- Dependencies: 190
-- Name: bank_id_bank_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('bank_id_bank_seq', 1, false);


--
-- TOC entry 191 (class 1259 OID 25482)
-- Dependencies: 6
-- Name: jenis_transaksi; Type: TABLE; Schema: trans; Owner: -; Tablespace: 
--

CREATE TABLE jenis_transaksi (
    id_jenis_transaksi integer NOT NULL,
    id_sub_kode_kas integer NOT NULL,
    id_dd_users integer NOT NULL,
    transaksi character varying(100) NOT NULL,
    keterangan character varying(255)
);


--
-- TOC entry 2380 (class 0 OID 0)
-- Dependencies: 191
-- Name: TABLE jenis_transaksi; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE jenis_transaksi IS 'Tabel jenis-jenis transaksi.';


--
-- TOC entry 192 (class 1259 OID 25485)
-- Dependencies: 6 191
-- Name: jenis_transaksi_id_jenis_transaksi_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE jenis_transaksi_id_jenis_transaksi_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2381 (class 0 OID 0)
-- Dependencies: 192
-- Name: jenis_transaksi_id_jenis_transaksi_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE jenis_transaksi_id_jenis_transaksi_seq OWNED BY jenis_transaksi.id_jenis_transaksi;


--
-- TOC entry 2382 (class 0 OID 0)
-- Dependencies: 192
-- Name: jenis_transaksi_id_jenis_transaksi_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('jenis_transaksi_id_jenis_transaksi_seq', 1, false);


--
-- TOC entry 193 (class 1259 OID 25487)
-- Dependencies: 2057 2058 6
-- Name: mapping_kode_akun; Type: TABLE; Schema: trans; Owner: -; Tablespace: 
--

CREATE TABLE mapping_kode_akun (
    id_mapping_kode_akun integer NOT NULL,
    id_jenis_transaksi integer NOT NULL,
    id_akdd_detail_coa integer NOT NULL,
    id_dd_users integer NOT NULL,
    flag_debet_kredit smallint NOT NULL,
    flag_pajak smallint NOT NULL,
    CONSTRAINT check_flag_debet_kredit_mapping_kode_akun CHECK (((flag_debet_kredit >= 1) AND (flag_debet_kredit <= 2))),
    CONSTRAINT check_flag_pajak_mapping_kode_akun CHECK (((flag_pajak >= 1) AND (flag_pajak <= 2)))
);


--
-- TOC entry 2383 (class 0 OID 0)
-- Dependencies: 193
-- Name: TABLE mapping_kode_akun; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE mapping_kode_akun IS 'Tabel yang memetakan antara kode akun dengan jenis transaksi.';


--
-- TOC entry 2384 (class 0 OID 0)
-- Dependencies: 193
-- Name: COLUMN mapping_kode_akun.flag_debet_kredit; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON COLUMN mapping_kode_akun.flag_debet_kredit IS '1 = Debet
2 = Kredit';


--
-- TOC entry 2385 (class 0 OID 0)
-- Dependencies: 193
-- Name: COLUMN mapping_kode_akun.flag_pajak; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON COLUMN mapping_kode_akun.flag_pajak IS '1 = Bukan Pajak
2 = Pajak';


--
-- TOC entry 194 (class 1259 OID 25492)
-- Dependencies: 1835 6
-- Name: jenis_transaksi_mapping_v; Type: VIEW; Schema: trans; Owner: -
--

CREATE VIEW jenis_transaksi_mapping_v AS
    SELECT a.id_jenis_transaksi, a.id_sub_kode_kas, a.transaksi FROM (jenis_transaksi a JOIN mapping_kode_akun b ON ((a.id_jenis_transaksi = b.id_jenis_transaksi))) GROUP BY a.id_jenis_transaksi, a.id_sub_kode_kas, a.transaksi ORDER BY a.transaksi;


--
-- TOC entry 195 (class 1259 OID 25496)
-- Dependencies: 6
-- Name: klasifikasi_penerima; Type: TABLE; Schema: trans; Owner: -; Tablespace: 
--

CREATE TABLE klasifikasi_penerima (
    id_klasifikasi_penerima integer NOT NULL,
    id_dd_users integer NOT NULL,
    klasifikasi character varying(100) NOT NULL,
    keterangan character varying(255)
);


--
-- TOC entry 2386 (class 0 OID 0)
-- Dependencies: 195
-- Name: TABLE klasifikasi_penerima; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE klasifikasi_penerima IS 'Tabel klasifikasi penerima.';


--
-- TOC entry 196 (class 1259 OID 25499)
-- Dependencies: 6
-- Name: mapping_transaksi_penerima; Type: TABLE; Schema: trans; Owner: -; Tablespace: 
--

CREATE TABLE mapping_transaksi_penerima (
    id_mapping_transaksi_penerima integer NOT NULL,
    id_jenis_transaksi integer NOT NULL,
    id_klasifikasi_penerima integer NOT NULL,
    id_dd_users integer NOT NULL
);


--
-- TOC entry 2387 (class 0 OID 0)
-- Dependencies: 196
-- Name: TABLE mapping_transaksi_penerima; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE mapping_transaksi_penerima IS 'Tabel mapping antara jenis transaksi dan klasifikasi penerima (khusus transaksi biaya saja).';


--
-- TOC entry 197 (class 1259 OID 25502)
-- Dependencies: 6
-- Name: pihak_penerima; Type: TABLE; Schema: trans; Owner: -; Tablespace: 
--

CREATE TABLE pihak_penerima (
    id_pihak_penerima integer NOT NULL,
    id_dd_users integer NOT NULL,
    id_klasifikasi_penerima integer NOT NULL,
    nama character varying(100) NOT NULL,
    alamat character varying(200),
    keterangan character varying(200)
);


--
-- TOC entry 2388 (class 0 OID 0)
-- Dependencies: 197
-- Name: TABLE pihak_penerima; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE pihak_penerima IS 'Tabel pihak penerima dari pengeluaran Yayasan Astra.';


--
-- TOC entry 198 (class 1259 OID 25509)
-- Dependencies: 1836 6
-- Name: jenis_transaksi_pihak_penerima_v; Type: VIEW; Schema: trans; Owner: -
--

CREATE VIEW jenis_transaksi_pihak_penerima_v AS
    SELECT a.id_jenis_transaksi, c.id_pihak_penerima, ((((c.nama)::text || ' ('::text) || (b.klasifikasi)::text) || ')'::text) AS pihak_penerima FROM ((mapping_transaksi_penerima a JOIN klasifikasi_penerima b ON ((a.id_klasifikasi_penerima = b.id_klasifikasi_penerima))) JOIN pihak_penerima c ON ((b.id_klasifikasi_penerima = c.id_klasifikasi_penerima))) ORDER BY b.klasifikasi, c.nama;


--
-- TOC entry 199 (class 1259 OID 25513)
-- Dependencies: 195 6
-- Name: klasifikasi_penerima_id_klasifikasi_penerima_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE klasifikasi_penerima_id_klasifikasi_penerima_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2389 (class 0 OID 0)
-- Dependencies: 199
-- Name: klasifikasi_penerima_id_klasifikasi_penerima_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE klasifikasi_penerima_id_klasifikasi_penerima_seq OWNED BY klasifikasi_penerima.id_klasifikasi_penerima;


--
-- TOC entry 2390 (class 0 OID 0)
-- Dependencies: 199
-- Name: klasifikasi_penerima_id_klasifikasi_penerima_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('klasifikasi_penerima_id_klasifikasi_penerima_seq', 3, true);


--
-- TOC entry 200 (class 1259 OID 25515)
-- Dependencies: 2062 2064 6
-- Name: kode_kas; Type: TABLE; Schema: trans; Owner: -; Tablespace: 
--

CREATE TABLE kode_kas (
    id_kode_kas integer NOT NULL,
    id_dd_users integer NOT NULL,
    flag_in_out character(1) DEFAULT 'o'::bpchar NOT NULL,
    kode character(1) NOT NULL,
    kas character varying(100) NOT NULL,
    keterangan character varying(255),
    CONSTRAINT check_flag_in_out CHECK (((flag_in_out = 'i'::bpchar) OR (flag_in_out = 'o'::bpchar)))
);


--
-- TOC entry 2391 (class 0 OID 0)
-- Dependencies: 200
-- Name: TABLE kode_kas; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE kode_kas IS 'Tabel kode kas.';


--
-- TOC entry 2392 (class 0 OID 0)
-- Dependencies: 200
-- Name: COLUMN kode_kas.flag_in_out; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON COLUMN kode_kas.flag_in_out IS '''i'' = Input, ''o'' = Output.';


--
-- TOC entry 201 (class 1259 OID 25520)
-- Dependencies: 200 6
-- Name: kode_kas_id_kode_kas_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE kode_kas_id_kode_kas_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2393 (class 0 OID 0)
-- Dependencies: 201
-- Name: kode_kas_id_kode_kas_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE kode_kas_id_kode_kas_seq OWNED BY kode_kas.id_kode_kas;


--
-- TOC entry 2394 (class 0 OID 0)
-- Dependencies: 201
-- Name: kode_kas_id_kode_kas_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('kode_kas_id_kode_kas_seq', 1, false);


--
-- TOC entry 202 (class 1259 OID 25522)
-- Dependencies: 6
-- Name: kota; Type: TABLE; Schema: trans; Owner: -; Tablespace: 
--

CREATE TABLE kota (
    id_kota integer NOT NULL,
    id_propinsi integer NOT NULL,
    id_dd_users integer NOT NULL,
    nama character varying(100) NOT NULL,
    keterangan character varying(255)
);


--
-- TOC entry 2395 (class 0 OID 0)
-- Dependencies: 202
-- Name: TABLE kota; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE kota IS 'Tabel data-data kota.';


--
-- TOC entry 203 (class 1259 OID 25525)
-- Dependencies: 6 202
-- Name: kota_id_kota_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE kota_id_kota_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2396 (class 0 OID 0)
-- Dependencies: 203
-- Name: kota_id_kota_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE kota_id_kota_seq OWNED BY kota.id_kota;


--
-- TOC entry 2397 (class 0 OID 0)
-- Dependencies: 203
-- Name: kota_id_kota_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('kota_id_kota_seq', 1, false);


--
-- TOC entry 204 (class 1259 OID 25527)
-- Dependencies: 193 6
-- Name: mapping_kode_akun_id_mapping_kode_akun_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE mapping_kode_akun_id_mapping_kode_akun_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2398 (class 0 OID 0)
-- Dependencies: 204
-- Name: mapping_kode_akun_id_mapping_kode_akun_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE mapping_kode_akun_id_mapping_kode_akun_seq OWNED BY mapping_kode_akun.id_mapping_kode_akun;


--
-- TOC entry 2399 (class 0 OID 0)
-- Dependencies: 204
-- Name: mapping_kode_akun_id_mapping_kode_akun_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('mapping_kode_akun_id_mapping_kode_akun_seq', 1, false);


--
-- TOC entry 205 (class 1259 OID 25529)
-- Dependencies: 6
-- Name: mapping_penerima; Type: TABLE; Schema: trans; Owner: -; Tablespace: 
--

CREATE TABLE mapping_penerima (
    id_mapping_penerima integer NOT NULL,
    id_transaksi bigint NOT NULL,
    id_pihak_penerima integer NOT NULL,
    id_dd_users integer NOT NULL
);


--
-- TOC entry 2400 (class 0 OID 0)
-- Dependencies: 205
-- Name: TABLE mapping_penerima; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE mapping_penerima IS 'Tabel mapping antara pihak penerima dengan transaksi.';


--
-- TOC entry 206 (class 1259 OID 25532)
-- Dependencies: 6 205
-- Name: mapping_penerima_id_mapping_penerima_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE mapping_penerima_id_mapping_penerima_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2401 (class 0 OID 0)
-- Dependencies: 206
-- Name: mapping_penerima_id_mapping_penerima_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE mapping_penerima_id_mapping_penerima_seq OWNED BY mapping_penerima.id_mapping_penerima;


--
-- TOC entry 2402 (class 0 OID 0)
-- Dependencies: 206
-- Name: mapping_penerima_id_mapping_penerima_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('mapping_penerima_id_mapping_penerima_seq', 1, false);


--
-- TOC entry 207 (class 1259 OID 25534)
-- Dependencies: 6
-- Name: mapping_rekening; Type: TABLE; Schema: trans; Owner: -; Tablespace: 
--

CREATE TABLE mapping_rekening (
    id_mapping_rekening integer NOT NULL,
    id_mapping_kode_akun integer NOT NULL,
    id_rekening_bank integer NOT NULL,
    id_dd_users integer NOT NULL
);


--
-- TOC entry 2403 (class 0 OID 0)
-- Dependencies: 207
-- Name: TABLE mapping_rekening; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE mapping_rekening IS 'Tabel mapping rekening.';


--
-- TOC entry 208 (class 1259 OID 25537)
-- Dependencies: 207 6
-- Name: mapping_rekening_id_mapping_rekening_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE mapping_rekening_id_mapping_rekening_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2404 (class 0 OID 0)
-- Dependencies: 208
-- Name: mapping_rekening_id_mapping_rekening_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE mapping_rekening_id_mapping_rekening_seq OWNED BY mapping_rekening.id_mapping_rekening;


--
-- TOC entry 2405 (class 0 OID 0)
-- Dependencies: 208
-- Name: mapping_rekening_id_mapping_rekening_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('mapping_rekening_id_mapping_rekening_seq', 1, false);


--
-- TOC entry 209 (class 1259 OID 25539)
-- Dependencies: 6
-- Name: mapping_transaksi_jurnal; Type: TABLE; Schema: trans; Owner: -; Tablespace: 
--

CREATE TABLE mapping_transaksi_jurnal (
    id_mapping_transaksi_jurnal bigint NOT NULL,
    id_transaksi bigint NOT NULL,
    id_akmt_jurnal bigint NOT NULL,
    id_dd_users integer NOT NULL
);


--
-- TOC entry 2406 (class 0 OID 0)
-- Dependencies: 209
-- Name: TABLE mapping_transaksi_jurnal; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE mapping_transaksi_jurnal IS 'Tabel mapping antara transaksi dengan jurnal.';


--
-- TOC entry 210 (class 1259 OID 25542)
-- Dependencies: 209 6
-- Name: mapping_transaksi_jurnal_id_mapping_transaksi_jurnal_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE mapping_transaksi_jurnal_id_mapping_transaksi_jurnal_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2407 (class 0 OID 0)
-- Dependencies: 210
-- Name: mapping_transaksi_jurnal_id_mapping_transaksi_jurnal_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE mapping_transaksi_jurnal_id_mapping_transaksi_jurnal_seq OWNED BY mapping_transaksi_jurnal.id_mapping_transaksi_jurnal;


--
-- TOC entry 2408 (class 0 OID 0)
-- Dependencies: 210
-- Name: mapping_transaksi_jurnal_id_mapping_transaksi_jurnal_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('mapping_transaksi_jurnal_id_mapping_transaksi_jurnal_seq', 1, false);


--
-- TOC entry 211 (class 1259 OID 25544)
-- Dependencies: 196 6
-- Name: mapping_transaksi_penerima_id_mapping_transaksi_penerima_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE mapping_transaksi_penerima_id_mapping_transaksi_penerima_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2409 (class 0 OID 0)
-- Dependencies: 211
-- Name: mapping_transaksi_penerima_id_mapping_transaksi_penerima_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE mapping_transaksi_penerima_id_mapping_transaksi_penerima_seq OWNED BY mapping_transaksi_penerima.id_mapping_transaksi_penerima;


--
-- TOC entry 2410 (class 0 OID 0)
-- Dependencies: 211
-- Name: mapping_transaksi_penerima_id_mapping_transaksi_penerima_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('mapping_transaksi_penerima_id_mapping_transaksi_penerima_seq', 1, false);


--
-- TOC entry 212 (class 1259 OID 25546)
-- Dependencies: 197 6
-- Name: pihak_penerima_id_pihak_penerima_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE pihak_penerima_id_pihak_penerima_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2411 (class 0 OID 0)
-- Dependencies: 212
-- Name: pihak_penerima_id_pihak_penerima_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE pihak_penerima_id_pihak_penerima_seq OWNED BY pihak_penerima.id_pihak_penerima;


--
-- TOC entry 2412 (class 0 OID 0)
-- Dependencies: 212
-- Name: pihak_penerima_id_pihak_penerima_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('pihak_penerima_id_pihak_penerima_seq', 1, false);


--
-- TOC entry 213 (class 1259 OID 25548)
-- Dependencies: 6
-- Name: propinsi; Type: TABLE; Schema: trans; Owner: -; Tablespace: 
--

CREATE TABLE propinsi (
    id_propinsi integer NOT NULL,
    id_dd_users integer NOT NULL,
    nama character varying(100) NOT NULL,
    keterangan character varying(255)
);


--
-- TOC entry 2413 (class 0 OID 0)
-- Dependencies: 213
-- Name: TABLE propinsi; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE propinsi IS 'Tabel data-data propinsi.';


--
-- TOC entry 214 (class 1259 OID 25551)
-- Dependencies: 213 6
-- Name: propinsi_id_propinsi_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE propinsi_id_propinsi_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2414 (class 0 OID 0)
-- Dependencies: 214
-- Name: propinsi_id_propinsi_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE propinsi_id_propinsi_seq OWNED BY propinsi.id_propinsi;


--
-- TOC entry 2415 (class 0 OID 0)
-- Dependencies: 214
-- Name: propinsi_id_propinsi_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('propinsi_id_propinsi_seq', 1, false);


--
-- TOC entry 215 (class 1259 OID 25553)
-- Dependencies: 6
-- Name: rekening_bank; Type: TABLE; Schema: trans; Owner: -; Tablespace: 
--

CREATE TABLE rekening_bank (
    id_rekening_bank integer NOT NULL,
    id_bank integer NOT NULL,
    id_dd_users integer NOT NULL,
    no_rekening character varying(100) NOT NULL,
    keterangan character varying(200)
);


--
-- TOC entry 2416 (class 0 OID 0)
-- Dependencies: 215
-- Name: TABLE rekening_bank; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE rekening_bank IS 'Tabel rekening dari tiap-tiap bank.';


--
-- TOC entry 216 (class 1259 OID 25556)
-- Dependencies: 215 6
-- Name: rekening_bank_id_rekening_bank_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE rekening_bank_id_rekening_bank_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2417 (class 0 OID 0)
-- Dependencies: 216
-- Name: rekening_bank_id_rekening_bank_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE rekening_bank_id_rekening_bank_seq OWNED BY rekening_bank.id_rekening_bank;


--
-- TOC entry 2418 (class 0 OID 0)
-- Dependencies: 216
-- Name: rekening_bank_id_rekening_bank_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('rekening_bank_id_rekening_bank_seq', 1, false);


--
-- TOC entry 217 (class 1259 OID 25558)
-- Dependencies: 6
-- Name: sub_kode_kas; Type: TABLE; Schema: trans; Owner: -; Tablespace: 
--

CREATE TABLE sub_kode_kas (
    id_sub_kode_kas integer NOT NULL,
    id_kode_kas integer NOT NULL,
    id_dd_users integer NOT NULL,
    kode smallint NOT NULL,
    sub_kas character varying(100) NOT NULL,
    keterangan character varying(255)
);


--
-- TOC entry 2419 (class 0 OID 0)
-- Dependencies: 217
-- Name: TABLE sub_kode_kas; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE sub_kode_kas IS 'Tabel sub kode kas.';


--
-- TOC entry 218 (class 1259 OID 25561)
-- Dependencies: 217 6
-- Name: sub_kode_kas_id_sub_kode_kas_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE sub_kode_kas_id_sub_kode_kas_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2420 (class 0 OID 0)
-- Dependencies: 218
-- Name: sub_kode_kas_id_sub_kode_kas_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE sub_kode_kas_id_sub_kode_kas_seq OWNED BY sub_kode_kas.id_sub_kode_kas;


--
-- TOC entry 2421 (class 0 OID 0)
-- Dependencies: 218
-- Name: sub_kode_kas_id_sub_kode_kas_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('sub_kode_kas_id_sub_kode_kas_seq', 1, false);


--
-- TOC entry 219 (class 1259 OID 25563)
-- Dependencies: 6
-- Name: sub_transaksi; Type: TABLE; Schema: trans; Owner: -; Tablespace: 
--

CREATE TABLE sub_transaksi (
    id_sub_transaksi bigint NOT NULL,
    id_transaksi bigint NOT NULL,
    id_mapping_kode_akun integer NOT NULL,
    id_dd_users integer NOT NULL,
    nominal numeric(15,2) NOT NULL
);


--
-- TOC entry 2422 (class 0 OID 0)
-- Dependencies: 219
-- Name: TABLE sub_transaksi; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE sub_transaksi IS 'Tabel berisikan data-data sub transaksi.';


--
-- TOC entry 220 (class 1259 OID 25566)
-- Dependencies: 219 6
-- Name: sub_transaksi_id_sub_transaksi_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE sub_transaksi_id_sub_transaksi_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2423 (class 0 OID 0)
-- Dependencies: 220
-- Name: sub_transaksi_id_sub_transaksi_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE sub_transaksi_id_sub_transaksi_seq OWNED BY sub_transaksi.id_sub_transaksi;


--
-- TOC entry 2424 (class 0 OID 0)
-- Dependencies: 220
-- Name: sub_transaksi_id_sub_transaksi_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('sub_transaksi_id_sub_transaksi_seq', 1, false);


--
-- TOC entry 221 (class 1259 OID 25568)
-- Dependencies: 2073 2075 6
-- Name: transaksi; Type: TABLE; Schema: trans; Owner: -; Tablespace: 
--

CREATE TABLE transaksi (
    id_transaksi bigint NOT NULL,
    id_dd_users integer NOT NULL,
    tanggal date NOT NULL,
    no_bukti character varying(50) NOT NULL,
    petugas character varying(50) NOT NULL,
    keterangan character varying(255),
    pajak numeric(4,2) DEFAULT 0 NOT NULL,
    CONSTRAINT check_tanggal_transaksi CHECK ((tanggal <= now()))
);


--
-- TOC entry 2425 (class 0 OID 0)
-- Dependencies: 221
-- Name: TABLE transaksi; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE transaksi IS 'Tabel transaksi-transaksi yang ada di yayasan.';


--
-- TOC entry 222 (class 1259 OID 25573)
-- Dependencies: 6 221
-- Name: transaksi_id_transaksi_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE transaksi_id_transaksi_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2426 (class 0 OID 0)
-- Dependencies: 222
-- Name: transaksi_id_transaksi_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE transaksi_id_transaksi_seq OWNED BY transaksi.id_transaksi;


--
-- TOC entry 2427 (class 0 OID 0)
-- Dependencies: 222
-- Name: transaksi_id_transaksi_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('transaksi_id_transaksi_seq', 1, false);


SET search_path = akun, pg_catalog;

--
-- TOC entry 2030 (class 2604 OID 25575)
-- Dependencies: 143 142
-- Name: id_akdd_arus_kas; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_arus_kas ALTER COLUMN id_akdd_arus_kas SET DEFAULT nextval('akdd_arus_kas_id_akdd_arus_kas_seq'::regclass);


--
-- TOC entry 2031 (class 2604 OID 25576)
-- Dependencies: 147 144
-- Name: id_akdd_detail_coa; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_detail_coa ALTER COLUMN id_akdd_detail_coa SET DEFAULT nextval('akdd_detail_coa_id_akdd_detail_coa_seq'::regclass);


--
-- TOC entry 2035 (class 2604 OID 25577)
-- Dependencies: 151 150
-- Name: id_akdd_detail_coa_lr; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_detail_coa_lr ALTER COLUMN id_akdd_detail_coa_lr SET DEFAULT nextval('akdd_detail_coa_lr_id_akdd_detail_coa_lr_seq'::regclass);


--
-- TOC entry 2037 (class 2604 OID 25578)
-- Dependencies: 153 152
-- Name: id_akdd_detail_coa_map; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_detail_coa_map ALTER COLUMN id_akdd_detail_coa_map SET DEFAULT nextval('akdd_detail_coa_map_id_akdd_detail_coa_map_seq'::regclass);


--
-- TOC entry 2039 (class 2604 OID 25579)
-- Dependencies: 157 156
-- Name: id_akdd_klasifikasi_modal; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_klasifikasi_modal ALTER COLUMN id_akdd_klasifikasi_modal SET DEFAULT nextval('akdd_klasifikasi_modal_id_akdd_klasifikasi_modal_seq'::regclass);


--
-- TOC entry 2032 (class 2604 OID 25580)
-- Dependencies: 159 145
-- Name: id_akdd_level_coa; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_level_coa ALTER COLUMN id_akdd_level_coa SET DEFAULT nextval('akdd_level_coa_id_akdd_level_coa_seq'::regclass);


--
-- TOC entry 2038 (class 2604 OID 25581)
-- Dependencies: 160 154
-- Name: id_akdd_main_coa; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_main_coa ALTER COLUMN id_akdd_main_coa SET DEFAULT nextval('akdd_main_coa_id_akdd_main_coa_seq'::regclass);


--
-- TOC entry 2040 (class 2604 OID 25582)
-- Dependencies: 162 161
-- Name: id_akdd_perubahan_dana; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_perubahan_dana ALTER COLUMN id_akdd_perubahan_dana SET DEFAULT nextval('akdd_perubahan_dana_id_akdd_perubahan_dana_seq'::regclass);


--
-- TOC entry 2042 (class 2604 OID 25583)
-- Dependencies: 164 163
-- Name: id_akdd_posisi_keuangan; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_posisi_keuangan ALTER COLUMN id_akdd_posisi_keuangan SET DEFAULT nextval('akdd_posisi_keuangan_id_akdd_posisi_keuangan_seq'::regclass);


--
-- TOC entry 2043 (class 2604 OID 25584)
-- Dependencies: 166 165
-- Name: id_akmt_buku_besar; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akmt_buku_besar ALTER COLUMN id_akmt_buku_besar SET DEFAULT nextval('akmt_buku_besar_id_akmt_buku_besar_seq'::regclass);


--
-- TOC entry 2045 (class 2604 OID 25585)
-- Dependencies: 171 169
-- Name: id_akmt_jurnal; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akmt_jurnal ALTER COLUMN id_akmt_jurnal SET DEFAULT nextval('akmt_jurnal_id_akmt_jurnal_seq'::regclass);


--
-- TOC entry 2034 (class 2604 OID 25586)
-- Dependencies: 170 148
-- Name: id_akmt_jurnal_det; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akmt_jurnal_det ALTER COLUMN id_akmt_jurnal_det SET DEFAULT nextval('akmt_jurnal_det_id_akmt_jurnal_det_seq'::regclass);


--
-- TOC entry 2044 (class 2604 OID 25587)
-- Dependencies: 172 167
-- Name: id_akmt_periode; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akmt_periode ALTER COLUMN id_akmt_periode SET DEFAULT nextval('akmt_periode_id_akmt_periode_seq'::regclass);


SET search_path = public, pg_catalog;

--
-- TOC entry 2046 (class 2604 OID 25588)
-- Dependencies: 174 173
-- Name: id_dd_access; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_access ALTER COLUMN id_dd_access SET DEFAULT nextval('dd_access_id_dd_access_seq'::regclass);


--
-- TOC entry 2047 (class 2604 OID 25589)
-- Dependencies: 178 175
-- Name: id_dd_groups; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_groups ALTER COLUMN id_dd_groups SET DEFAULT nextval('dd_groups_id_dd_groups_seq'::regclass);


--
-- TOC entry 2048 (class 2604 OID 25590)
-- Dependencies: 177 176
-- Name: id_dd_groups_detail; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_groups_detail ALTER COLUMN id_dd_groups_detail SET DEFAULT nextval('dd_groups_detail_id_dd_groups_detail_seq'::regclass);


--
-- TOC entry 2049 (class 2604 OID 25591)
-- Dependencies: 180 179
-- Name: id_dd_menus; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_menus ALTER COLUMN id_dd_menus SET DEFAULT nextval('dd_menus_id_dd_menus_seq'::regclass);


--
-- TOC entry 2050 (class 2604 OID 25592)
-- Dependencies: 182 181
-- Name: id_dd_moduls; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_moduls ALTER COLUMN id_dd_moduls SET DEFAULT nextval('dd_moduls_id_dd_moduls_seq'::regclass);


--
-- TOC entry 2051 (class 2604 OID 25593)
-- Dependencies: 184 183
-- Name: id_dd_sub_menus; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_sub_menus ALTER COLUMN id_dd_sub_menus SET DEFAULT nextval('dd_sub_menus_id_dd_sub_menus_seq'::regclass);


--
-- TOC entry 2052 (class 2604 OID 25594)
-- Dependencies: 186 185
-- Name: id_dd_tabs; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_tabs ALTER COLUMN id_dd_tabs SET DEFAULT nextval('dd_tabs_id_dd_tabs_seq'::regclass);


--
-- TOC entry 2053 (class 2604 OID 25595)
-- Dependencies: 188 187
-- Name: id_dd_users; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_users ALTER COLUMN id_dd_users SET DEFAULT nextval('dd_users_id_dd_users_seq'::regclass);


SET search_path = trans, pg_catalog;

--
-- TOC entry 2054 (class 2604 OID 25596)
-- Dependencies: 190 189
-- Name: id_bank; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY bank ALTER COLUMN id_bank SET DEFAULT nextval('bank_id_bank_seq'::regclass);


--
-- TOC entry 2055 (class 2604 OID 25597)
-- Dependencies: 192 191
-- Name: id_jenis_transaksi; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY jenis_transaksi ALTER COLUMN id_jenis_transaksi SET DEFAULT nextval('jenis_transaksi_id_jenis_transaksi_seq'::regclass);


--
-- TOC entry 2059 (class 2604 OID 25598)
-- Dependencies: 199 195
-- Name: id_klasifikasi_penerima; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY klasifikasi_penerima ALTER COLUMN id_klasifikasi_penerima SET DEFAULT nextval('klasifikasi_penerima_id_klasifikasi_penerima_seq'::regclass);


--
-- TOC entry 2063 (class 2604 OID 25599)
-- Dependencies: 201 200
-- Name: id_kode_kas; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY kode_kas ALTER COLUMN id_kode_kas SET DEFAULT nextval('kode_kas_id_kode_kas_seq'::regclass);


--
-- TOC entry 2065 (class 2604 OID 25600)
-- Dependencies: 203 202
-- Name: id_kota; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY kota ALTER COLUMN id_kota SET DEFAULT nextval('kota_id_kota_seq'::regclass);


--
-- TOC entry 2056 (class 2604 OID 25601)
-- Dependencies: 204 193
-- Name: id_mapping_kode_akun; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_kode_akun ALTER COLUMN id_mapping_kode_akun SET DEFAULT nextval('mapping_kode_akun_id_mapping_kode_akun_seq'::regclass);


--
-- TOC entry 2066 (class 2604 OID 25602)
-- Dependencies: 206 205
-- Name: id_mapping_penerima; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_penerima ALTER COLUMN id_mapping_penerima SET DEFAULT nextval('mapping_penerima_id_mapping_penerima_seq'::regclass);


--
-- TOC entry 2067 (class 2604 OID 25603)
-- Dependencies: 208 207
-- Name: id_mapping_rekening; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_rekening ALTER COLUMN id_mapping_rekening SET DEFAULT nextval('mapping_rekening_id_mapping_rekening_seq'::regclass);


--
-- TOC entry 2068 (class 2604 OID 25604)
-- Dependencies: 210 209
-- Name: id_mapping_transaksi_jurnal; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_transaksi_jurnal ALTER COLUMN id_mapping_transaksi_jurnal SET DEFAULT nextval('mapping_transaksi_jurnal_id_mapping_transaksi_jurnal_seq'::regclass);


--
-- TOC entry 2060 (class 2604 OID 25605)
-- Dependencies: 211 196
-- Name: id_mapping_transaksi_penerima; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_transaksi_penerima ALTER COLUMN id_mapping_transaksi_penerima SET DEFAULT nextval('mapping_transaksi_penerima_id_mapping_transaksi_penerima_seq'::regclass);


--
-- TOC entry 2061 (class 2604 OID 25606)
-- Dependencies: 212 197
-- Name: id_pihak_penerima; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY pihak_penerima ALTER COLUMN id_pihak_penerima SET DEFAULT nextval('pihak_penerima_id_pihak_penerima_seq'::regclass);


--
-- TOC entry 2069 (class 2604 OID 25607)
-- Dependencies: 214 213
-- Name: id_propinsi; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY propinsi ALTER COLUMN id_propinsi SET DEFAULT nextval('propinsi_id_propinsi_seq'::regclass);


--
-- TOC entry 2070 (class 2604 OID 25608)
-- Dependencies: 216 215
-- Name: id_rekening_bank; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY rekening_bank ALTER COLUMN id_rekening_bank SET DEFAULT nextval('rekening_bank_id_rekening_bank_seq'::regclass);


--
-- TOC entry 2071 (class 2604 OID 25609)
-- Dependencies: 218 217
-- Name: id_sub_kode_kas; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY sub_kode_kas ALTER COLUMN id_sub_kode_kas SET DEFAULT nextval('sub_kode_kas_id_sub_kode_kas_seq'::regclass);


--
-- TOC entry 2072 (class 2604 OID 25610)
-- Dependencies: 220 219
-- Name: id_sub_transaksi; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY sub_transaksi ALTER COLUMN id_sub_transaksi SET DEFAULT nextval('sub_transaksi_id_sub_transaksi_seq'::regclass);


--
-- TOC entry 2074 (class 2604 OID 25611)
-- Dependencies: 222 221
-- Name: id_transaksi; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY transaksi ALTER COLUMN id_transaksi SET DEFAULT nextval('transaksi_id_transaksi_seq'::regclass);


SET search_path = akun, pg_catalog;

--
-- TOC entry 2261 (class 0 OID 25337)
-- Dependencies: 142
-- Data for Name: akdd_arus_kas; Type: TABLE DATA; Schema: akun; Owner: -
--

COPY akdd_arus_kas (id_akdd_arus_kas, id_akdd_arus_kas_ref, uraian, coa_range, order_number, kalkulasi, kalibrasi) FROM stdin;
\.


--
-- TOC entry 2262 (class 0 OID 25347)
-- Dependencies: 144
-- Data for Name: akdd_detail_coa; Type: TABLE DATA; Schema: akun; Owner: -
--

COPY akdd_detail_coa (id_akdd_detail_coa, id_akdd_main_coa, id_akdd_level_coa, id_akdd_detail_coa_ref, coa_number, coa_number_num, uraian) FROM stdin;
1	1	1	1	10000000	10000000	AKTIVA
85	5	4	28	50102005	50102005	Gaji dan Honor
3	3	1	3	30000000	30000000	AKTIVA BERSIH
4	4	1	4	40000000	40000000	PENDAPATAN
5	5	1	5	50000000	50000000	BIAYA
2	2	1	2	20000000	20000000	KEWAJIBAN
6	1	2	1	10100000	10100000	Aktiva Lancar
7	1	2	1	10200000	10200000	Aktiva Tetap
8	2	2	2	20100000	20100000	Kewajiban
9	3	2	3	30100000	30100000	Aktiva Bersih
10	4	2	4	40100000	40100000	Pendapatan
11	5	2	5	50100000	50100000	Biaya
12	1	3	6	10101000	10101000	Kas
13	1	3	6	10102000	10102000	Bank
14	1	3	6	10103000	10103000	Deposito
15	1	3	6	10104000	10104000	Piutang
16	1	3	6	10105000	10105000	Biaya dibayar dimuka
17	1	3	6	10106000	10106000	Pajak dibayar dimuka
18	1	3	7	10201000	10201000	Harga Perolehan
19	1	3	7	10202000	10202000	Akumulasi Penyusutan
20	2	3	8	20101000	20101000	Hutang Pembelian
21	2	3	8	20102000	20102000	Biaya yang masih harus dibayar
22	2	3	8	20103000	20103000	Hutang Pajak
23	2	3	8	20104000	20104000	Cadangan Imbalan Jasa
24	3	3	9	30101000	30101000	Aktiva Bersih Terikat
25	3	3	9	30102000	30102000	Aktiva Bersih Tidak Terikat
26	4	3	10	40101000	40101000	Pendapatan
27	5	3	11	50101000	50101000	Kegiatan Khusus
28	5	3	11	50102000	50102000	Administrasi & Umum
29	1	4	12	10101001	10101001	Kas Kecil Masjid
30	1	4	13	10102001	10102001	PT Bank Permata Tbk (Permata Syariah 0.971001.089)
31	1	4	13	10102002	10102002	PT Bank Permata Tbk (Permata Syariah 0.971001.097)
32	1	4	14	10103001	10103001	PT Bank Permata Tbk (Permata Syariah )
33	1	4	15	10104001	10104001	Piutang Lazis
36	1	4	16	10105001	10105001	Asuransi gempa bumi
34	1	4	15	10104002	10104002	Bagi Hasil Deposito
37	1	4	16	10105002	10105002	Asuransi kebakaran
38	1	4	17	10106001	10106001	PPh Pasal 23
39	1	4	18	10201001	10201001	Bangunan
40	1	4	18	10201002	10201002	Inventaris
41	1	4	19	10202001	10202001	Bangunan
42	1	4	19	10202002	10202002	Inventaris
43	2	4	20	20101001	20101001	Tenda
44	2	4	21	20102001	20102001	Profesional Fee
45	2	4	21	20102002	20102002	B. Utilitas
46	2	4	21	20102003	20102003	B. Komunikasi
47	2	4	21	20102004	20102004	B. Cleaning Sevice
48	2	4	21	20102005	20102005	B. Buletin
49	2	4	22	20103001	20103001	PPh Pasal 21
50	2	4	22	20103002	20103002	PPh Pasal 23 (witholding tax)
51	2	4	22	20103003	20103003	PPh Pasal 23 dan 4(2)
52	2	4	23	20104001	20104001	Cadangan Imbalan Jasa
53	3	4	24	30101001	30101001	Saldo ABT
54	3	4	24	30101002	30101002	Kenaikan/Penurunan ABT
55	3	4	25	30102001	30102001	Saldo ABTT
56	3	4	25	30102002	30102002	Kenaikan/Penurunan ABTT
59	4	4	26	40101003	40101003	Kotak Amal (Kotak Jumat)
60	4	4	26	40101004	40101004	Kotak Besar dan Ied
61	4	4	26	40101005	40101005	Infaq Pemakaian Masjid
62	4	4	26	40101006	40101006	Infaq Buka Puasa
63	4	4	26	40101007	40101007	Infaq Peserta Itikaf
64	4	4	26	40101008	40101008	Infaq Shodaqoh
65	4	4	26	40101009	40101009	Infaq Lain-Lain (Ramadhan)
66	4	4	26	40101010	40101010	Donatur Masjid
67	4	4	26	40101011	40101011	Bagi Hasil Deposito
68	4	4	26	40101012	40101012	Bagi Hasil Jasa Giro
69	4	4	26	40101999	40101999	Pendapatan Lain-lain
70	5	4	27	50101001	50101001	Astra Gema Islami
71	5	4	27	50101002	50101002	Ramadhan
72	5	4	27	50101003	50101003	Taman Pendidikan Al-Quran
73	5	4	27	50101004	50101004	Pesantren Liburan
74	5	4	27	50101005	50101005	Tahsinul Qur'an
75	5	4	27	50101006	50101006	Kegiatan Jum'at
76	5	4	27	50101007	50101007	Hari Besar Islam
77	5	4	27	50101008	50101008	Kajian Islam Ibu-ibu
78	5	4	27	50101009	50101009	Kajian Islam
79	5	4	27	50101010	50101010	Lailaturruhiyah
80	5	4	27	50101011	50101011	Mubaliqh Development Program
81	5	4	28	50102001	50102001	Sumbangan Untuk Lazis
82	5	4	28	50102002	50102002	B. Asuransi Masjid
83	5	4	28	50102003	50102003	Penyusutan Bangunan
84	5	4	28	50102004	50102004	Pengobatan & Perawatan
86	5	4	28	50102006	50102006	THR
87	5	4	28	50102007	50102007	Penyusutan Inventaris Masjid
88	5	4	28	50102008	50102008	Penyusutan Inventaris Yayasan
89	5	4	28	50102009	50102009	Utilitas
91	5	4	28	50102011	50102011	Jasa Kebersihan
92	5	4	28	50102012	50102012	Biaya Profesional
93	5	4	28	50102013	50102013	Barang Cetakan
94	5	4	28	50102014	50102014	Alat Tulis Kantor
95	5	4	28	50102015	50102015	Biaya PPh 21
96	5	4	28	50102016	50102016	Biaya PPh 23
97	5	4	28	50102017	50102017	Koran dan Majalah
98	5	4	28	50102018	50102018	Biaya Administrasi Bank
99	5	4	28	50102019	50102019	Pos & Meterai
100	5	4	28	50102020	50102020	Olah Raga & Rekreasi
101	5	4	28	50102021	50102021	Komunikasi
102	5	4	28	50102022	50102022	Entertain & Sumbangan
90	5	4	28	50102010	50102010	Perbaikan dan Perawatan
103	5	4	28	50102023	50102023	Perlengkapan  Rumah Tangga Masjid
104	5	4	28	50102024	50102024	Beban Imbalan Jasa (cadangan pesangon)
105	5	4	28	50102025	50102025	Seragam
106	5	4	28	50102026	50102026	Inventaris
107	5	4	28	50102027	50102027	Jamsostek
108	5	4	28	50102028	50102028	Perijinan
109	5	4	28	50102029	50102029	Rapat Yayasan
110	5	4	28	50102030	50102030	LAZIS
111	5	4	28	50102031	50102031	Promosi
112	5	4	28	50102032	50102032	Acara
113	5	4	28	50102033	50102033	Rapat & Pelatihan
35	1	4	15	10104999	10104999	Lain lain
57	4	4	26	40101001	40101001	Pendapatan Dari Yayasan
58	4	4	26	40101002	40101002	Terima Dari Bank Permata
\.


--
-- TOC entry 2265 (class 0 OID 25367)
-- Dependencies: 150
-- Data for Name: akdd_detail_coa_lr; Type: TABLE DATA; Schema: akun; Owner: -
--

COPY akdd_detail_coa_lr (id_akdd_detail_coa_lr, id_akdd_detail_coa, id_akdd_klasifikasi_modal, sub_coa) FROM stdin;
3	55	1	30102002~30102002
1	53	2	30101002~30101002
2	54	4	40201001~40201001,50201001~50201001
4	56	3	40101001~40101999,50101001~50102999
\.


--
-- TOC entry 2266 (class 0 OID 25372)
-- Dependencies: 152
-- Data for Name: akdd_detail_coa_map; Type: TABLE DATA; Schema: akun; Owner: -
--

COPY akdd_detail_coa_map (id_akdd_detail_coa_map, id_akdd_detail_coa, flag) FROM stdin;
1	29	3
2	30	3
3	31	3
4	32	0
5	33	0
6	34	0
8	36	0
9	37	0
10	38	0
11	39	0
12	40	0
13	41	0
14	42	0
15	43	2
16	44	2
17	45	2
18	46	2
19	47	2
20	48	2
21	49	1
22	50	1
23	51	1
24	52	0
25	53	3
26	54	3
27	55	3
28	56	3
31	59	1
32	60	1
33	61	1
34	62	1
35	63	1
36	64	1
37	65	1
38	66	1
39	67	1
40	68	1
41	69	1
42	70	2
43	71	2
44	72	2
45	73	2
46	74	2
47	75	2
48	76	2
49	77	2
50	78	2
51	79	2
52	80	2
53	81	2
54	82	2
55	83	2
56	84	2
57	85	2
58	86	2
59	87	2
60	88	2
61	89	2
62	90	2
63	91	2
64	92	2
65	93	2
66	94	2
67	95	2
68	96	2
69	97	2
70	98	2
71	99	2
72	100	2
73	101	2
74	102	2
75	103	2
76	104	2
77	105	2
78	106	2
79	107	2
80	108	2
81	109	2
82	110	2
83	111	2
84	112	2
85	113	2
7	35	0
29	57	1
30	58	1
\.


--
-- TOC entry 2268 (class 0 OID 25386)
-- Dependencies: 156
-- Data for Name: akdd_klasifikasi_modal; Type: TABLE DATA; Schema: akun; Owner: -
--

COPY akdd_klasifikasi_modal (id_akdd_klasifikasi_modal, binary_code, klasifikasi, uraian) FROM stdin;
1	1	AKTIVA BERSIH TIDAK TERIKAT	\N
2	2	AKTIVA BERSIH TERIKAT	\N
3	4	KENAIKAN/PENURUNAN ABTT	\N
4	8	KENAIKAN/PENURUNAN ABT	\N
5	16	SELAIN KENAIKAN/PENURUNAN, ABTT, ABT	\N
\.


--
-- TOC entry 2269 (class 0 OID 25391)
-- Dependencies: 158
-- Data for Name: akdd_kodifikasi_jurnal; Type: TABLE DATA; Schema: akun; Owner: -
--

COPY akdd_kodifikasi_jurnal (id_akdd_kodifikasi_jurnal, kode, notes) FROM stdin;
1	JP	Jurnal Penerimaan
2	JB	Jurnal Biaya & Pengeluaran
3	JT	Jurnal Penutup
4	JK	Jurnal Koreksi
5	JS	Jurnal Penyesuaian
6	JU	Jurnal Umum
7	JA	Jurnal Automatis
\.


--
-- TOC entry 2263 (class 0 OID 25350)
-- Dependencies: 145
-- Data for Name: akdd_level_coa; Type: TABLE DATA; Schema: akun; Owner: -
--

COPY akdd_level_coa (id_akdd_level_coa, level_number, level_length, uraian) FROM stdin;
1	1	1	Level-1
2	2	2	Level-2
3	3	2	Level-3
4	4	3	Level-4
\.


--
-- TOC entry 2267 (class 0 OID 25378)
-- Dependencies: 154
-- Data for Name: akdd_main_coa; Type: TABLE DATA; Schema: akun; Owner: -
--

COPY akdd_main_coa (id_akdd_main_coa, acc_type, binary_code, uraian) FROM stdin;
1	d	1	AKTIVA
2	k	2	KEWAJIBAN
3	k	3	AKTIVA BERSIH
4	k	4	PENERIMAAN
5	d	5	PENYALURAN & BEBAN
\.


--
-- TOC entry 2270 (class 0 OID 25398)
-- Dependencies: 161
-- Data for Name: akdd_perubahan_dana; Type: TABLE DATA; Schema: akun; Owner: -
--

COPY akdd_perubahan_dana (id_akdd_perubahan_dana, id_akdd_perubahan_dana_ref, uraian, coa_range, order_number) FROM stdin;
3	1	Pengeluaran	50201001~50201001	120
1	1	PERUBAHAN ASET BERSIH TERIKAT	40201001~40201001, 50201001~50201001	100
2	1	Penerimaan	40201001~40201001	110
6	5	Sumbangan donator masjid	40101010~40101010	211
7	5	Penerimaan kotak amal	40101003~40101004	212
8	5	Infaq buka puasa	40101006~40101006	213
9	5	Nisbah bagi hasil deposito	40101011~40101012	214
10	5	Infaq Lain-lain (Ramadhan)	40101009~40101009	215
11	5	Infaq peserta itikaf	40101007~40101007	216
12	5	Infaq pemakaian masjid	40101005~40101005	217
13	5	Infaq shodaqoh	40101008~40101008	218
14	5	Lain-lain	40101999~40101999	219
5	4	Penerimaan	40101001~40101999	210
4	4	PERUBAHAN ASET BERSIH TIDAK TERIKAT	40101001~40101999, 50101001~50103999	200
19	4	Jumlah Penerimaan Tidak Terikat	40101001~40101999	220
15	4	Beban	50101001~50103999	230
16	15	Kegiatan khusus	50101001~50101999	231
17	15	Administrasi dan Umum	50102001~50102999	232
18	15	Lain-lain	50103001~50103999	233
20	4	Jumlah Beban Tidak Terikat	50101001~50103999	240
21	21	Jumlah Aset Bersih Tidak Terikat	40101001~40101999, 50101001~50103999	250
22	22	Kenaikan (Penurunan) Aset Bersih	40201001~40201001, 50201001~50201001, 40101001~40101999, 50101001~50103999	260
23	23	ASET BERSIH AWAL TAHUN	30101001~30101001, 30102001~30102001	270
24	24	ASET BERSIH AKHIR TAHUN	30101001~30101001, 30102001~30102001, 40201001~40201001, 50201001~50201001, 40101001~40101999, 50101001~50103999	280
\.


--
-- TOC entry 2271 (class 0 OID 25406)
-- Dependencies: 163
-- Data for Name: akdd_posisi_keuangan; Type: TABLE DATA; Schema: akun; Owner: -
--

COPY akdd_posisi_keuangan (id_akdd_posisi_keuangan, id_akdd_posisi_keuangan_ref, uraian, coa_range, order_number, acc_type) FROM stdin;
5	2	Biaya dibayar di muka	10105001~10105999	113	d
3	2	Kas dan setara kas	10101001~10101999, 10102001~10102999, 10103001~10103999	111	d
4	2	Piutang lain-lain	10104001~10104999	112	d
7	6	Aset tetap	10201001~10299999	121	d
10	9	Hutang pembelian	20101001~20101999	211	k
11	9	Biaya yang masih harus dibayar	20102001~20102999	212	k
2	1	ASET LANCAR	10101001~10101999, 10102001~10102999, 10103001~10103999, 10104001~10104999, 10105001~10105999\n	110	d
6	1	ASET TIDAK LANCAR	10201001~10299999	120	d
1	1	ASET	10101001~10101999, 10102001~10102999, 10103001~10103999, 10104001~10104999, 10105001~10105999, 10201001~10299999	100	d
12	9	Hutang pajak	20103001~20103999	213	k
9	8	KEWAJIBAN LANCAR	20101001~20101999, 20102001~20102999, 20103001~20103999	210	k
14	13	Cadangan imbalan jasa	20104001~20104999	221	k
13	8	KEWAJIBAN TIDAK LANCAR	20104001~20104999	220	k
16	15	Terikat	30101001~30101999	231	k
17	15	Tidak terikat	30102001~30102999	232	k
15	8	ASET BERSIH	30101001~30101999, 30102001~30102999	230	k
8	8	KEWAJIBAN DAN ASET BERSIH	20101001~20101999, 20102001~20102999, 20103001~20103999, 20104001~20104999, 30101001~30101999, 30102001~30102999	200	k
\.


--
-- TOC entry 2272 (class 0 OID 25415)
-- Dependencies: 165
-- Data for Name: akmt_buku_besar; Type: TABLE DATA; Schema: akun; Owner: -
--

COPY akmt_buku_besar (id_akmt_buku_besar, id_akmt_periode, id_akdd_detail_coa, no_bukti, tanggal, keterangan, awal, mutasi_debet, mutasi_kredit, akhir) FROM stdin;
\.


--
-- TOC entry 2274 (class 0 OID 25428)
-- Dependencies: 169
-- Data for Name: akmt_jurnal; Type: TABLE DATA; Schema: akun; Owner: -
--

COPY akmt_jurnal (id_akmt_jurnal, flag_jurnal, flag_temp, flag_posting, no_bukti, tanggal, keterangan) FROM stdin;
\.


--
-- TOC entry 2264 (class 0 OID 25359)
-- Dependencies: 148
-- Data for Name: akmt_jurnal_det; Type: TABLE DATA; Schema: akun; Owner: -
--

COPY akmt_jurnal_det (id_akmt_jurnal_det, id_akmt_jurnal, id_akdd_detail_coa, flag_position, jumlah) FROM stdin;
\.


--
-- TOC entry 2273 (class 0 OID 25420)
-- Dependencies: 167
-- Data for Name: akmt_periode; Type: TABLE DATA; Schema: akun; Owner: -
--

COPY akmt_periode (id_akmt_periode, flag_temp, tahun, bulan, uraian) FROM stdin;
\.


SET search_path = public, pg_catalog;

--
-- TOC entry 2275 (class 0 OID 25437)
-- Dependencies: 173
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
-- TOC entry 2276 (class 0 OID 25442)
-- Dependencies: 175
-- Data for Name: dd_groups; Type: TABLE DATA; Schema: public; Owner: -
--

COPY dd_groups (id_dd_groups, flag_system, group_name, note) FROM stdin;
1	t	Super Administrator	Super Administrator sistem
2	f	Administrator	Administrator sistem di bawah Super Administrator
3	f	Manajer	Pengawas kegiatan Operator
4	f	Operator	Petugas yang menjalankan sehari-hari
\.


--
-- TOC entry 2277 (class 0 OID 25445)
-- Dependencies: 176
-- Data for Name: dd_groups_detail; Type: TABLE DATA; Schema: public; Owner: -
--

COPY dd_groups_detail (id_dd_groups_detail, id_dd_groups, id_dd_tabs, access_code) FROM stdin;
1	4	8	17
3	3	8	19
95	1	1	31
96	1	2	31
97	1	3	31
98	1	4	31
99	1	5	31
100	1	6	31
101	1	7	31
102	1	8	31
103	1	21	31
104	1	22	31
105	1	23	31
106	1	24	31
107	1	25	31
108	1	26	31
109	1	27	31
110	1	28	31
111	1	16	31
112	1	17	31
113	1	18	31
114	1	20	31
115	1	13	31
116	1	14	31
117	1	34	31
118	1	15	31
119	1	30	31
120	1	31	31
121	1	32	31
122	1	33	31
123	1	36	31
124	1	35	31
125	1	37	31
126	1	38	31
127	1	39	31
128	1	40	31
129	1	41	31
130	1	42	16
131	1	43	16
132	1	44	16
133	1	45	16
134	2	8	31
135	2	16	31
136	2	17	31
137	2	18	31
138	2	13	31
139	2	14	31
140	2	15	31
\.


--
-- TOC entry 2278 (class 0 OID 25452)
-- Dependencies: 179
-- Data for Name: dd_menus; Type: TABLE DATA; Schema: public; Owner: -
--

COPY dd_menus (id_dd_menus, id_dd_moduls, order_number, menu, note) FROM stdin;
1	1	1	APLIKASI	Setup aplikasi
3	1	2	PENGGUNA	Data-data pengguna
5	2	1	AKUNTANSI	Data dasar akuntansi
2	2	2	DATA DASAR	Data-data dasar
4	13	1	PENERIMAAN	Transaksi penerimaan
6	13	2	PENGELUARAN	Transaksi pengeluaran
7	13	3	AKUNTANSI	Transaksi-transaksi akuntansi
8	14	1	LAP. UTAMA	Laporan keuangan utama
\.


--
-- TOC entry 2279 (class 0 OID 25457)
-- Dependencies: 181
-- Data for Name: dd_moduls; Type: TABLE DATA; Schema: public; Owner: -
--

COPY dd_moduls (id_dd_moduls, order_number, modul, note) FROM stdin;
1	1	SETUP	Setup aplikasi
2	2	ADMIN	Administrasi aplikasi
13	3	TRANSAKSI	Transaksi Yayasan
14	4	SIE	Sistem Informasi Eksekutif
\.


--
-- TOC entry 2280 (class 0 OID 25462)
-- Dependencies: 183
-- Data for Name: dd_sub_menus; Type: TABLE DATA; Schema: public; Owner: -
--

COPY dd_sub_menus (id_dd_sub_menus, id_dd_menus, order_number, sub_menu, note) FROM stdin;
1	1	1	Modul, Menu, Sub, Tab	Setup konfigurasi aplikasi
2	1	2	Access Groups & Right	Manajemen kelompok dan hak akses
3	3	1	User	Daftar pengguna aplikasi
4	2	1	Umum	Data-data dasar umum
8	2	2	Transaksi	Data Dasar Transaksi
9	5	1	Kode Akun	Administrasi kode-kode akun
10	5	2	Saldo Awal	Saldo awal untuk akuntansi
11	5	3	Template	Template laporan
12	6	1	Pengeluaran	Transaksi mapping untuk pengeluaran
5	4	1	Penerimaan	Transaksi mapping untuk penerimaan
6	4	2	Penerimaan Umum	Transaksi penerimaan umum
7	4	3	Persetujuan	Persetujuan transaksi penerimaan
13	6	2	Pengeluaran Umum	Transaksi pengeluaran umum
14	6	3	Persetujuan	Persetujuan transaksi pengeluaran
15	7	1	Jurnal Umum	Input akuntansi jurnal umum
16	7	2	Persetujuan	Persetujuan jurnal umum
17	7	3	Tutup Buku	Proses tutup buku
18	8	1	Buku Besar	Laporan buku besar
19	8	2	Perubahan Dana	Laporan perubahan dana
20	8	3	Posisi Keuangan	Laporan posisi keuangan
21	8	4	Arus Kas	Laporan arus kas
\.


--
-- TOC entry 2281 (class 0 OID 25467)
-- Dependencies: 185
-- Data for Name: dd_tabs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY dd_tabs (id_dd_tabs, id_dd_sub_menus, flag_active, order_number, tab, url, note) FROM stdin;
5	2	t	1	Access Groups	/core/group	Data-data kelompok pengguna
7	2	f	3	Access Control List	/core/groupAccess	Kombinasi antara kelompok & hak akses
12	4	f	3	Bank	/basic/bank	Data Bank
10	4	t	1	Propinsi	/basic/propinsi	Data Propinsi
37	14	t	1	Persetujuan	/akun/persetujuan/pengeluaran	Persetujuan transaksi pengeluaran
11	4	f	2	Kota	/basic/kota	Data Kota
1	1	t	1	Modul	/core/modul	Daftar Modul
2	1	f	2	Menu	/core/menu	Daftar Menu
3	1	f	3	Sub Menu	/core/subMenu	Daftar Sub Menu
4	1	f	4	Tab	/core/tab	Daftar Tab
6	2	f	2	Access Right	/core/access	Hak Akses Halaman
8	3	t	1	User	/core/login	Daftar Pengguna Aplikasi
42	18	t	1	Buku Besar	/sie/bukuBesar	Laporan buku besar
43	19	t	1	Perubahan Dana	/sie/perubahanDana	Laporan perubahan dana
44	20	t	1	Posisi Keuangan	/sie/posisiKeuangan	Laporan posisi keuangan
45	21	t	1	Arus Kas	/sie/arusKas	Laporan arus kas
16	8	t	1	Kode Kas	/basic/kodeKas	Kode Kas Yayasan
17	8	f	2	Sub Kode Kas	/basic/subKodeKas	Sub Kode Kas Yayasan
19	4	f	4	Rekening Bank	/basic/rekeningBank	Data Rekening Bank
21	9	t	1	Klasifikasi	/akun/group	Klasifikasi kode akun
22	9	f	2	Aktiva Bersih	/akun/aktivitas	Klasifikasi aktivitas bersih
23	9	f	3	Level Akun	/akun/level	Level kode akuntansi
24	9	f	4	Kode Akun	/akun/coa	Kode-kode perkiraan akuntansi
25	10	t	1	Saldo Awal	/akun/saldo	Saldo awal akuntansi
26	11	t	1	Perubahan Dana	/akun/perubahanDana	Template laporan perubahan dana
27	11	f	2	Posisi Keuangan	/akun/posisiKeuangan	Template laporan posisi keuangan
28	11	f	3	Arus Kas	/akun/arusKas	Template laporan arus kas
20	8	f	4	Kode Akun Transaksi	/basic/mappingTransaksi	Mapping Kode Akun Transaksi
18	8	f	3	Jenis Transaksi	/basic/jenisTransaksi	Jenis Transaksi
30	12	f	1	Karyawan	/basic/karyawan	Data Karyawan
31	12	f	2	Ustadz	/basic/ustadz	Data Ustadz
32	12	f	3	Guru TPA	/basic/guruTpa	Data Guru TPA
33	12	t	4	Pengeluaran	/akun/transaksiPengeluaran	Transaksi pengeluaran yang telah dipetakan
13	5	t	1	Penerimaan	/akun/transaksiPenerimaan	Transaksi penerimaan yang telah dipetakan
38	15	t	1	Jurnal	/akun/jurnal	Akuntansi jurnal umum
39	15	f	2	Daftar	/akun/jurnal/daftar	Daftar jurnal umum
40	16	t	1	Persetujuan	/akun/persetujuan	Persetujuan jurnal
41	17	t	1	Tutup Buku	/akun/tutupBuku	Proses tutup buku
36	13	t	1	Pengeluaran Umum	/akun/jurnal/keluar	Transaksi pengeluaran umum
14	6	t	1	Penerimaan Umum	/akun/jurnal/terima	Transaksi penerimaan umum
34	6	f	2	Listing	/akun/jurnal/daftarTerima	Daftar transaksi penerimaan umum
35	13	f	2	Listing	/akun/jurnal/daftarKeluar	Daftar transaksi pengeluaran umum
15	7	t	1	Persetujuan	/akun/persetujuan/penerimaan	Persetujuan transaksi penerimaan
\.


--
-- TOC entry 2282 (class 0 OID 25472)
-- Dependencies: 187
-- Data for Name: dd_users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY dd_users (id_dd_users, id_dd_groups, flag_active, flag_system, username, passkeys, note) FROM stdin;
1	1	t	t	sadmin	bddce66cf8a4e9e556e4a58bc78744ed	Super Administrator
2	2	t	f	admin	bddce66cf8a4e9e556e4a58bc78744ed	Administrator
3	3	t	f	manajer	bddce66cf8a4e9e556e4a58bc78744ed	Manajer
4	4	t	f	operator	bddce66cf8a4e9e556e4a58bc78744ed	Operator
\.


SET search_path = trans, pg_catalog;

--
-- TOC entry 2283 (class 0 OID 25477)
-- Dependencies: 189
-- Data for Name: bank; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY bank (id_bank, id_kota, id_dd_users, nama, keterangan) FROM stdin;
\.


--
-- TOC entry 2284 (class 0 OID 25482)
-- Dependencies: 191
-- Data for Name: jenis_transaksi; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY jenis_transaksi (id_jenis_transaksi, id_sub_kode_kas, id_dd_users, transaksi, keterangan) FROM stdin;
\.


--
-- TOC entry 2286 (class 0 OID 25496)
-- Dependencies: 195
-- Data for Name: klasifikasi_penerima; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY klasifikasi_penerima (id_klasifikasi_penerima, id_dd_users, klasifikasi, keterangan) FROM stdin;
1	1	Karyawan	\N
2	1	Ustadz	\N
3	1	Guru TPA	\N
\.


--
-- TOC entry 2289 (class 0 OID 25515)
-- Dependencies: 200
-- Data for Name: kode_kas; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY kode_kas (id_kode_kas, id_dd_users, flag_in_out, kode, kas, keterangan) FROM stdin;
\.


--
-- TOC entry 2290 (class 0 OID 25522)
-- Dependencies: 202
-- Data for Name: kota; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY kota (id_kota, id_propinsi, id_dd_users, nama, keterangan) FROM stdin;
\.


--
-- TOC entry 2285 (class 0 OID 25487)
-- Dependencies: 193
-- Data for Name: mapping_kode_akun; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY mapping_kode_akun (id_mapping_kode_akun, id_jenis_transaksi, id_akdd_detail_coa, id_dd_users, flag_debet_kredit, flag_pajak) FROM stdin;
\.


--
-- TOC entry 2291 (class 0 OID 25529)
-- Dependencies: 205
-- Data for Name: mapping_penerima; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY mapping_penerima (id_mapping_penerima, id_transaksi, id_pihak_penerima, id_dd_users) FROM stdin;
\.


--
-- TOC entry 2292 (class 0 OID 25534)
-- Dependencies: 207
-- Data for Name: mapping_rekening; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY mapping_rekening (id_mapping_rekening, id_mapping_kode_akun, id_rekening_bank, id_dd_users) FROM stdin;
\.


--
-- TOC entry 2293 (class 0 OID 25539)
-- Dependencies: 209
-- Data for Name: mapping_transaksi_jurnal; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY mapping_transaksi_jurnal (id_mapping_transaksi_jurnal, id_transaksi, id_akmt_jurnal, id_dd_users) FROM stdin;
\.


--
-- TOC entry 2287 (class 0 OID 25499)
-- Dependencies: 196
-- Data for Name: mapping_transaksi_penerima; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY mapping_transaksi_penerima (id_mapping_transaksi_penerima, id_jenis_transaksi, id_klasifikasi_penerima, id_dd_users) FROM stdin;
\.


--
-- TOC entry 2288 (class 0 OID 25502)
-- Dependencies: 197
-- Data for Name: pihak_penerima; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY pihak_penerima (id_pihak_penerima, id_dd_users, id_klasifikasi_penerima, nama, alamat, keterangan) FROM stdin;
\.


--
-- TOC entry 2294 (class 0 OID 25548)
-- Dependencies: 213
-- Data for Name: propinsi; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY propinsi (id_propinsi, id_dd_users, nama, keterangan) FROM stdin;
\.


--
-- TOC entry 2295 (class 0 OID 25553)
-- Dependencies: 215
-- Data for Name: rekening_bank; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY rekening_bank (id_rekening_bank, id_bank, id_dd_users, no_rekening, keterangan) FROM stdin;
\.


--
-- TOC entry 2296 (class 0 OID 25558)
-- Dependencies: 217
-- Data for Name: sub_kode_kas; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY sub_kode_kas (id_sub_kode_kas, id_kode_kas, id_dd_users, kode, sub_kas, keterangan) FROM stdin;
\.


--
-- TOC entry 2297 (class 0 OID 25563)
-- Dependencies: 219
-- Data for Name: sub_transaksi; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY sub_transaksi (id_sub_transaksi, id_transaksi, id_mapping_kode_akun, id_dd_users, nominal) FROM stdin;
\.


--
-- TOC entry 2298 (class 0 OID 25568)
-- Dependencies: 221
-- Data for Name: transaksi; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY transaksi (id_transaksi, id_dd_users, tanggal, no_bukti, petugas, keterangan, pajak) FROM stdin;
\.


SET search_path = akun, pg_catalog;

--
-- TOC entry 2092 (class 2606 OID 25613)
-- Dependencies: 152 152
-- Name: akdd_detail_coa_map_pkey; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_detail_coa_map
    ADD CONSTRAINT akdd_detail_coa_map_pkey PRIMARY KEY (id_akdd_detail_coa_map);


--
-- TOC entry 2077 (class 2606 OID 25615)
-- Dependencies: 142 142
-- Name: pk_akdd_arus_kas; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_arus_kas
    ADD CONSTRAINT pk_akdd_arus_kas PRIMARY KEY (id_akdd_arus_kas);


--
-- TOC entry 2080 (class 2606 OID 25617)
-- Dependencies: 144 144
-- Name: pk_akdd_detail_coa; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_detail_coa
    ADD CONSTRAINT pk_akdd_detail_coa PRIMARY KEY (id_akdd_detail_coa);


--
-- TOC entry 2086 (class 2606 OID 25619)
-- Dependencies: 150 150
-- Name: pk_akdd_detail_coa_lr; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_detail_coa_lr
    ADD CONSTRAINT pk_akdd_detail_coa_lr PRIMARY KEY (id_akdd_detail_coa_lr);


--
-- TOC entry 2096 (class 2606 OID 25621)
-- Dependencies: 156 156
-- Name: pk_akdd_klasifikasi_modal; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_klasifikasi_modal
    ADD CONSTRAINT pk_akdd_klasifikasi_modal PRIMARY KEY (id_akdd_klasifikasi_modal);


--
-- TOC entry 2098 (class 2606 OID 25623)
-- Dependencies: 158 158
-- Name: pk_akdd_kodifikasi_jurnal; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_kodifikasi_jurnal
    ADD CONSTRAINT pk_akdd_kodifikasi_jurnal PRIMARY KEY (id_akdd_kodifikasi_jurnal);


--
-- TOC entry 2082 (class 2606 OID 25625)
-- Dependencies: 145 145
-- Name: pk_akdd_level_coa; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_level_coa
    ADD CONSTRAINT pk_akdd_level_coa PRIMARY KEY (id_akdd_level_coa);


--
-- TOC entry 2094 (class 2606 OID 25627)
-- Dependencies: 154 154
-- Name: pk_akdd_main_coa; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_main_coa
    ADD CONSTRAINT pk_akdd_main_coa PRIMARY KEY (id_akdd_main_coa);


--
-- TOC entry 2102 (class 2606 OID 25629)
-- Dependencies: 161 161
-- Name: pk_akdd_perubahan_dana; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_perubahan_dana
    ADD CONSTRAINT pk_akdd_perubahan_dana PRIMARY KEY (id_akdd_perubahan_dana);


--
-- TOC entry 2104 (class 2606 OID 25631)
-- Dependencies: 163 163
-- Name: pk_akdd_posisi_keuangan; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_posisi_keuangan
    ADD CONSTRAINT pk_akdd_posisi_keuangan PRIMARY KEY (id_akdd_posisi_keuangan);


--
-- TOC entry 2106 (class 2606 OID 25633)
-- Dependencies: 165 165
-- Name: pk_akmt_buku_besar; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akmt_buku_besar
    ADD CONSTRAINT pk_akmt_buku_besar PRIMARY KEY (id_akmt_buku_besar);


--
-- TOC entry 2113 (class 2606 OID 25635)
-- Dependencies: 169 169
-- Name: pk_akmt_jurnal; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akmt_jurnal
    ADD CONSTRAINT pk_akmt_jurnal PRIMARY KEY (id_akmt_jurnal);


--
-- TOC entry 2084 (class 2606 OID 25637)
-- Dependencies: 148 148
-- Name: pk_akmt_jurnal_det; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akmt_jurnal_det
    ADD CONSTRAINT pk_akmt_jurnal_det PRIMARY KEY (id_akmt_jurnal_det);


--
-- TOC entry 2108 (class 2606 OID 25639)
-- Dependencies: 167 167
-- Name: pk_akmt_periode; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akmt_periode
    ADD CONSTRAINT pk_akmt_periode PRIMARY KEY (id_akmt_periode);


--
-- TOC entry 2110 (class 2606 OID 25641)
-- Dependencies: 167 167 167
-- Name: unique_akmt_periode; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akmt_periode
    ADD CONSTRAINT unique_akmt_periode UNIQUE (tahun, bulan);


--
-- TOC entry 2088 (class 2606 OID 25643)
-- Dependencies: 150 150
-- Name: unique_detail_coa; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_detail_coa_lr
    ADD CONSTRAINT unique_detail_coa UNIQUE (id_akdd_detail_coa);


--
-- TOC entry 2090 (class 2606 OID 25645)
-- Dependencies: 150 150
-- Name: unique_klasifikasi_modal; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_detail_coa_lr
    ADD CONSTRAINT unique_klasifikasi_modal UNIQUE (id_akdd_klasifikasi_modal);


--
-- TOC entry 2100 (class 2606 OID 25647)
-- Dependencies: 158 158
-- Name: unique_kodifikasi_jurnal; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_kodifikasi_jurnal
    ADD CONSTRAINT unique_kodifikasi_jurnal UNIQUE (kode);


SET search_path = public, pg_catalog;

--
-- TOC entry 2115 (class 2606 OID 25649)
-- Dependencies: 173 173
-- Name: pk_dd_access; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_access
    ADD CONSTRAINT pk_dd_access PRIMARY KEY (id_dd_access);


--
-- TOC entry 2121 (class 2606 OID 25651)
-- Dependencies: 175 175
-- Name: pk_dd_groups; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_groups
    ADD CONSTRAINT pk_dd_groups PRIMARY KEY (id_dd_groups);


--
-- TOC entry 2127 (class 2606 OID 25653)
-- Dependencies: 179 179
-- Name: pk_dd_menus; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_menus
    ADD CONSTRAINT pk_dd_menus PRIMARY KEY (id_dd_menus);


--
-- TOC entry 2133 (class 2606 OID 25655)
-- Dependencies: 181 181
-- Name: pk_dd_moduls; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_moduls
    ADD CONSTRAINT pk_dd_moduls PRIMARY KEY (id_dd_moduls);


--
-- TOC entry 2139 (class 2606 OID 25657)
-- Dependencies: 183 183
-- Name: pk_dd_sub_menus; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_sub_menus
    ADD CONSTRAINT pk_dd_sub_menus PRIMARY KEY (id_dd_sub_menus);


--
-- TOC entry 2145 (class 2606 OID 25659)
-- Dependencies: 185 185
-- Name: pk_dd_tabs; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_tabs
    ADD CONSTRAINT pk_dd_tabs PRIMARY KEY (id_dd_tabs);


--
-- TOC entry 2151 (class 2606 OID 25661)
-- Dependencies: 187 187
-- Name: pk_dd_users; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_users
    ADD CONSTRAINT pk_dd_users PRIMARY KEY (id_dd_users);


--
-- TOC entry 2125 (class 2606 OID 25663)
-- Dependencies: 176 176
-- Name: pk_groups_detail; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_groups_detail
    ADD CONSTRAINT pk_groups_detail PRIMARY KEY (id_dd_groups_detail);


--
-- TOC entry 2117 (class 2606 OID 25665)
-- Dependencies: 173 173
-- Name: unique2_access; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_access
    ADD CONSTRAINT unique2_access UNIQUE (access_code);


--
-- TOC entry 2129 (class 2606 OID 25667)
-- Dependencies: 179 179 179 179
-- Name: unique2_menus; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_menus
    ADD CONSTRAINT unique2_menus UNIQUE (id_dd_moduls, menu, order_number);


--
-- TOC entry 2135 (class 2606 OID 25669)
-- Dependencies: 181 181
-- Name: unique2_moduls; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_moduls
    ADD CONSTRAINT unique2_moduls UNIQUE (order_number);


--
-- TOC entry 2141 (class 2606 OID 25671)
-- Dependencies: 183 183 183 183
-- Name: unique2_sub_menus; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_sub_menus
    ADD CONSTRAINT unique2_sub_menus UNIQUE (id_dd_menus, sub_menu, order_number);


--
-- TOC entry 2147 (class 2606 OID 25673)
-- Dependencies: 185 185
-- Name: unique2_tabs; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_tabs
    ADD CONSTRAINT unique2_tabs UNIQUE (url);


--
-- TOC entry 2119 (class 2606 OID 25675)
-- Dependencies: 173 173
-- Name: unique_access; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_access
    ADD CONSTRAINT unique_access UNIQUE (access_name);


--
-- TOC entry 2153 (class 2606 OID 25677)
-- Dependencies: 187 187
-- Name: unique_dd_users; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_users
    ADD CONSTRAINT unique_dd_users UNIQUE (username);


--
-- TOC entry 2123 (class 2606 OID 25679)
-- Dependencies: 175 175
-- Name: unique_groups; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_groups
    ADD CONSTRAINT unique_groups UNIQUE (group_name);


--
-- TOC entry 2131 (class 2606 OID 25681)
-- Dependencies: 179 179 179
-- Name: unique_menus; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_menus
    ADD CONSTRAINT unique_menus UNIQUE (id_dd_moduls, menu);


--
-- TOC entry 2137 (class 2606 OID 25683)
-- Dependencies: 181 181
-- Name: unique_moduls; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_moduls
    ADD CONSTRAINT unique_moduls UNIQUE (modul);


--
-- TOC entry 2143 (class 2606 OID 25685)
-- Dependencies: 183 183 183
-- Name: unique_sub_menus; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_sub_menus
    ADD CONSTRAINT unique_sub_menus UNIQUE (id_dd_menus, sub_menu);


--
-- TOC entry 2149 (class 2606 OID 25687)
-- Dependencies: 185 185 185
-- Name: unique_tabs; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_tabs
    ADD CONSTRAINT unique_tabs UNIQUE (id_dd_sub_menus, tab);


SET search_path = trans, pg_catalog;

--
-- TOC entry 2155 (class 2606 OID 25689)
-- Dependencies: 189 189
-- Name: pk_bank; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY bank
    ADD CONSTRAINT pk_bank PRIMARY KEY (id_bank);


--
-- TOC entry 2159 (class 2606 OID 25691)
-- Dependencies: 191 191
-- Name: pk_jenis_transaksi; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY jenis_transaksi
    ADD CONSTRAINT pk_jenis_transaksi PRIMARY KEY (id_jenis_transaksi);


--
-- TOC entry 2169 (class 2606 OID 25693)
-- Dependencies: 195 195
-- Name: pk_klasifikasi_penerima; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY klasifikasi_penerima
    ADD CONSTRAINT pk_klasifikasi_penerima PRIMARY KEY (id_klasifikasi_penerima);


--
-- TOC entry 2179 (class 2606 OID 25695)
-- Dependencies: 200 200
-- Name: pk_kode_kas; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY kode_kas
    ADD CONSTRAINT pk_kode_kas PRIMARY KEY (id_kode_kas);


--
-- TOC entry 2185 (class 2606 OID 25697)
-- Dependencies: 202 202
-- Name: pk_kota; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY kota
    ADD CONSTRAINT pk_kota PRIMARY KEY (id_kota);


--
-- TOC entry 2165 (class 2606 OID 25699)
-- Dependencies: 193 193
-- Name: pk_mapping_kode_akun; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mapping_kode_akun
    ADD CONSTRAINT pk_mapping_kode_akun PRIMARY KEY (id_mapping_kode_akun);


--
-- TOC entry 2189 (class 2606 OID 25701)
-- Dependencies: 205 205
-- Name: pk_mapping_penerima; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mapping_penerima
    ADD CONSTRAINT pk_mapping_penerima PRIMARY KEY (id_mapping_penerima);


--
-- TOC entry 2191 (class 2606 OID 25703)
-- Dependencies: 207 207
-- Name: pk_mapping_rekening; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mapping_rekening
    ADD CONSTRAINT pk_mapping_rekening PRIMARY KEY (id_mapping_rekening);


--
-- TOC entry 2193 (class 2606 OID 25705)
-- Dependencies: 209 209
-- Name: pk_mapping_transaksi_jurnal; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mapping_transaksi_jurnal
    ADD CONSTRAINT pk_mapping_transaksi_jurnal PRIMARY KEY (id_mapping_transaksi_jurnal);


--
-- TOC entry 2173 (class 2606 OID 25707)
-- Dependencies: 196 196
-- Name: pk_mapping_transaksi_penerima; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mapping_transaksi_penerima
    ADD CONSTRAINT pk_mapping_transaksi_penerima PRIMARY KEY (id_mapping_transaksi_penerima);


--
-- TOC entry 2175 (class 2606 OID 25709)
-- Dependencies: 197 197
-- Name: pk_pihak_penerima; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pihak_penerima
    ADD CONSTRAINT pk_pihak_penerima PRIMARY KEY (id_pihak_penerima);


--
-- TOC entry 2195 (class 2606 OID 25711)
-- Dependencies: 213 213
-- Name: pk_propinsi; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY propinsi
    ADD CONSTRAINT pk_propinsi PRIMARY KEY (id_propinsi);


--
-- TOC entry 2199 (class 2606 OID 25713)
-- Dependencies: 215 215
-- Name: pk_rekening_bank; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY rekening_bank
    ADD CONSTRAINT pk_rekening_bank PRIMARY KEY (id_rekening_bank);


--
-- TOC entry 2203 (class 2606 OID 25715)
-- Dependencies: 217 217
-- Name: pk_sub_kode_kas; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sub_kode_kas
    ADD CONSTRAINT pk_sub_kode_kas PRIMARY KEY (id_sub_kode_kas);


--
-- TOC entry 2209 (class 2606 OID 25717)
-- Dependencies: 219 219
-- Name: pk_sub_transaksi; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sub_transaksi
    ADD CONSTRAINT pk_sub_transaksi PRIMARY KEY (id_sub_transaksi);


--
-- TOC entry 2211 (class 2606 OID 25719)
-- Dependencies: 221 221
-- Name: pk_transaksi; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY transaksi
    ADD CONSTRAINT pk_transaksi PRIMARY KEY (id_transaksi);


--
-- TOC entry 2167 (class 2606 OID 25721)
-- Dependencies: 193 193 193
-- Name: unique_akdd_detail_coa_jenis_transaksi_mapping_kode_akun; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mapping_kode_akun
    ADD CONSTRAINT unique_akdd_detail_coa_jenis_transaksi_mapping_kode_akun UNIQUE (id_jenis_transaksi, id_akdd_detail_coa);


--
-- TOC entry 2181 (class 2606 OID 25723)
-- Dependencies: 200 200
-- Name: unique_kas_kode_kas; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY kode_kas
    ADD CONSTRAINT unique_kas_kode_kas UNIQUE (kas);


--
-- TOC entry 2171 (class 2606 OID 25725)
-- Dependencies: 195 195
-- Name: unique_klasifikasi_klasifikasi_penerima; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY klasifikasi_penerima
    ADD CONSTRAINT unique_klasifikasi_klasifikasi_penerima UNIQUE (klasifikasi);


--
-- TOC entry 2183 (class 2606 OID 25727)
-- Dependencies: 200 200
-- Name: unique_kode_kode_kas; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY kode_kas
    ADD CONSTRAINT unique_kode_kode_kas UNIQUE (kode);


--
-- TOC entry 2177 (class 2606 OID 25729)
-- Dependencies: 197 197 197
-- Name: unique_nama_alamat_pihak_penerima; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pihak_penerima
    ADD CONSTRAINT unique_nama_alamat_pihak_penerima UNIQUE (nama, alamat);


--
-- TOC entry 2157 (class 2606 OID 25731)
-- Dependencies: 189 189
-- Name: unique_nama_bank; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY bank
    ADD CONSTRAINT unique_nama_bank UNIQUE (nama);


--
-- TOC entry 2187 (class 2606 OID 25733)
-- Dependencies: 202 202
-- Name: unique_nama_kota; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY kota
    ADD CONSTRAINT unique_nama_kota UNIQUE (nama);


--
-- TOC entry 2197 (class 2606 OID 25735)
-- Dependencies: 213 213
-- Name: unique_nama_propinsi; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY propinsi
    ADD CONSTRAINT unique_nama_propinsi UNIQUE (nama);


--
-- TOC entry 2201 (class 2606 OID 25737)
-- Dependencies: 215 215
-- Name: unique_no_rekening_rekening_bank; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY rekening_bank
    ADD CONSTRAINT unique_no_rekening_rekening_bank UNIQUE (no_rekening);


--
-- TOC entry 2205 (class 2606 OID 25739)
-- Dependencies: 217 217 217
-- Name: unique_sub_kas_kode_kas; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sub_kode_kas
    ADD CONSTRAINT unique_sub_kas_kode_kas UNIQUE (id_kode_kas, sub_kas);


--
-- TOC entry 2161 (class 2606 OID 25741)
-- Dependencies: 191 191
-- Name: unique_sub_kode_kas; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY jenis_transaksi
    ADD CONSTRAINT unique_sub_kode_kas UNIQUE (id_sub_kode_kas);


--
-- TOC entry 2207 (class 2606 OID 25743)
-- Dependencies: 217 217 217
-- Name: unique_sub_kode_kode_kas; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sub_kode_kas
    ADD CONSTRAINT unique_sub_kode_kode_kas UNIQUE (id_kode_kas, kode);


--
-- TOC entry 2163 (class 2606 OID 25745)
-- Dependencies: 191 191
-- Name: unique_transaksi_jenis_transaksi; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY jenis_transaksi
    ADD CONSTRAINT unique_transaksi_jenis_transaksi UNIQUE (transaksi);


SET search_path = akun, pg_catalog;

--
-- TOC entry 2111 (class 1259 OID 25746)
-- Dependencies: 169
-- Name: index_akmt_jurnal_no_bukti; Type: INDEX; Schema: akun; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_akmt_jurnal_no_bukti ON akmt_jurnal USING btree (no_bukti);


--
-- TOC entry 2078 (class 1259 OID 25747)
-- Dependencies: 144
-- Name: index_coa_number_akdd_detail_coa; Type: INDEX; Schema: akun; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_coa_number_akdd_detail_coa ON akdd_detail_coa USING btree (coa_number);


--
-- TOC entry 2216 (class 2606 OID 25748)
-- Dependencies: 150 144 2079
-- Name: akdd_detail_coa_akdd_detail_coa_lr; Type: FK CONSTRAINT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_detail_coa_lr
    ADD CONSTRAINT akdd_detail_coa_akdd_detail_coa_lr FOREIGN KEY (id_akdd_detail_coa) REFERENCES akdd_detail_coa(id_akdd_detail_coa) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2219 (class 2606 OID 25753)
-- Dependencies: 144 2079 165
-- Name: akdd_detail_coa_akmt_buku_besar; Type: FK CONSTRAINT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akmt_buku_besar
    ADD CONSTRAINT akdd_detail_coa_akmt_buku_besar FOREIGN KEY (id_akdd_detail_coa) REFERENCES akdd_detail_coa(id_akdd_detail_coa) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2214 (class 2606 OID 25758)
-- Dependencies: 2079 148 144
-- Name: akdd_detail_coa_akmt_jurnal_det; Type: FK CONSTRAINT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akmt_jurnal_det
    ADD CONSTRAINT akdd_detail_coa_akmt_jurnal_det FOREIGN KEY (id_akdd_detail_coa) REFERENCES akdd_detail_coa(id_akdd_detail_coa) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2218 (class 2606 OID 25763)
-- Dependencies: 152 2079 144
-- Name: akdd_detail_coa_map_id_akdd_detail_coa_fkey; Type: FK CONSTRAINT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_detail_coa_map
    ADD CONSTRAINT akdd_detail_coa_map_id_akdd_detail_coa_fkey FOREIGN KEY (id_akdd_detail_coa) REFERENCES akdd_detail_coa(id_akdd_detail_coa);


--
-- TOC entry 2217 (class 2606 OID 25768)
-- Dependencies: 2095 156 150
-- Name: akdd_klasifikasi_modal_akdd_detail_coa_lr; Type: FK CONSTRAINT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_detail_coa_lr
    ADD CONSTRAINT akdd_klasifikasi_modal_akdd_detail_coa_lr FOREIGN KEY (id_akdd_klasifikasi_modal) REFERENCES akdd_klasifikasi_modal(id_akdd_klasifikasi_modal) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2212 (class 2606 OID 25773)
-- Dependencies: 2081 144 145
-- Name: akdd_level_coa_akdd_main_coa; Type: FK CONSTRAINT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_detail_coa
    ADD CONSTRAINT akdd_level_coa_akdd_main_coa FOREIGN KEY (id_akdd_level_coa) REFERENCES akdd_level_coa(id_akdd_level_coa) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2213 (class 2606 OID 25778)
-- Dependencies: 154 2093 144
-- Name: akdd_main_coa_akdd_detail_coa; Type: FK CONSTRAINT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_detail_coa
    ADD CONSTRAINT akdd_main_coa_akdd_detail_coa FOREIGN KEY (id_akdd_main_coa) REFERENCES akdd_main_coa(id_akdd_main_coa) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2215 (class 2606 OID 25783)
-- Dependencies: 2112 169 148
-- Name: akmt_jurnal_akmt_jurnal_det; Type: FK CONSTRAINT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akmt_jurnal_det
    ADD CONSTRAINT akmt_jurnal_akmt_jurnal_det FOREIGN KEY (id_akmt_jurnal) REFERENCES akmt_jurnal(id_akmt_jurnal) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2220 (class 2606 OID 25788)
-- Dependencies: 2107 165 167
-- Name: akmt_periode_akmt_buku_besar; Type: FK CONSTRAINT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akmt_buku_besar
    ADD CONSTRAINT akmt_periode_akmt_buku_besar FOREIGN KEY (id_akmt_periode) REFERENCES akmt_periode(id_akmt_periode) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE;


SET search_path = public, pg_catalog;

--
-- TOC entry 2226 (class 2606 OID 25793)
-- Dependencies: 187 175 2120
-- Name: fk_dd_groups; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_users
    ADD CONSTRAINT fk_dd_groups FOREIGN KEY (id_dd_groups) REFERENCES dd_groups(id_dd_groups) ON DELETE CASCADE DEFERRABLE;


--
-- TOC entry 2221 (class 2606 OID 25798)
-- Dependencies: 2120 176 175
-- Name: fk_dd_groups; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_groups_detail
    ADD CONSTRAINT fk_dd_groups FOREIGN KEY (id_dd_groups) REFERENCES dd_groups(id_dd_groups) ON DELETE CASCADE DEFERRABLE;


--
-- TOC entry 2224 (class 2606 OID 25803)
-- Dependencies: 183 2126 179
-- Name: fk_dd_menus; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_sub_menus
    ADD CONSTRAINT fk_dd_menus FOREIGN KEY (id_dd_menus) REFERENCES dd_menus(id_dd_menus) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE;


--
-- TOC entry 2223 (class 2606 OID 25808)
-- Dependencies: 179 2132 181
-- Name: fk_dd_moduls; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_menus
    ADD CONSTRAINT fk_dd_moduls FOREIGN KEY (id_dd_moduls) REFERENCES dd_moduls(id_dd_moduls) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE;


--
-- TOC entry 2225 (class 2606 OID 25813)
-- Dependencies: 183 185 2138
-- Name: fk_dd_sub_menus; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_tabs
    ADD CONSTRAINT fk_dd_sub_menus FOREIGN KEY (id_dd_sub_menus) REFERENCES dd_sub_menus(id_dd_sub_menus) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE;


--
-- TOC entry 2222 (class 2606 OID 25818)
-- Dependencies: 2144 185 176
-- Name: fk_dd_tabs; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_groups_detail
    ADD CONSTRAINT fk_dd_tabs FOREIGN KEY (id_dd_tabs) REFERENCES dd_tabs(id_dd_tabs) ON DELETE CASCADE DEFERRABLE;


SET search_path = trans, pg_catalog;

--
-- TOC entry 2227 (class 2606 OID 25823)
-- Dependencies: 2150 189 187
-- Name: fk_bank_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY bank
    ADD CONSTRAINT fk_bank_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2228 (class 2606 OID 25828)
-- Dependencies: 202 189 2184
-- Name: fk_bank_kota; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY bank
    ADD CONSTRAINT fk_bank_kota FOREIGN KEY (id_kota) REFERENCES kota(id_kota) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2229 (class 2606 OID 25833)
-- Dependencies: 191 187 2150
-- Name: fk_jenis_transaksi_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY jenis_transaksi
    ADD CONSTRAINT fk_jenis_transaksi_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2230 (class 2606 OID 25838)
-- Dependencies: 217 2202 191
-- Name: fk_jenis_transaksi_sub_kode_kas; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY jenis_transaksi
    ADD CONSTRAINT fk_jenis_transaksi_sub_kode_kas FOREIGN KEY (id_sub_kode_kas) REFERENCES sub_kode_kas(id_sub_kode_kas) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2234 (class 2606 OID 25843)
-- Dependencies: 187 195 2150
-- Name: fk_klasifikasi_penerima_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY klasifikasi_penerima
    ADD CONSTRAINT fk_klasifikasi_penerima_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2240 (class 2606 OID 25848)
-- Dependencies: 187 2150 200
-- Name: fk_kode_kas_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY kode_kas
    ADD CONSTRAINT fk_kode_kas_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2241 (class 2606 OID 25853)
-- Dependencies: 202 2150 187
-- Name: fk_kota_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY kota
    ADD CONSTRAINT fk_kota_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2242 (class 2606 OID 25858)
-- Dependencies: 202 2194 213
-- Name: fk_kota_propinsi; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY kota
    ADD CONSTRAINT fk_kota_propinsi FOREIGN KEY (id_propinsi) REFERENCES propinsi(id_propinsi) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2231 (class 2606 OID 25863)
-- Dependencies: 193 2079 144
-- Name: fk_mapping_kode_akun_akdd_detail_coa; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_kode_akun
    ADD CONSTRAINT fk_mapping_kode_akun_akdd_detail_coa FOREIGN KEY (id_akdd_detail_coa) REFERENCES akun.akdd_detail_coa(id_akdd_detail_coa) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2232 (class 2606 OID 25868)
-- Dependencies: 193 2150 187
-- Name: fk_mapping_kode_akun_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_kode_akun
    ADD CONSTRAINT fk_mapping_kode_akun_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2233 (class 2606 OID 25873)
-- Dependencies: 2158 191 193
-- Name: fk_mapping_kode_akun_jenis_transaksi; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_kode_akun
    ADD CONSTRAINT fk_mapping_kode_akun_jenis_transaksi FOREIGN KEY (id_jenis_transaksi) REFERENCES jenis_transaksi(id_jenis_transaksi) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2243 (class 2606 OID 25878)
-- Dependencies: 2150 187 205
-- Name: fk_mapping_penerima_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_penerima
    ADD CONSTRAINT fk_mapping_penerima_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2244 (class 2606 OID 25883)
-- Dependencies: 2174 197 205
-- Name: fk_mapping_penerima_pihak_penerima; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_penerima
    ADD CONSTRAINT fk_mapping_penerima_pihak_penerima FOREIGN KEY (id_pihak_penerima) REFERENCES pihak_penerima(id_pihak_penerima) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2245 (class 2606 OID 25888)
-- Dependencies: 2210 221 205
-- Name: fk_mapping_penerima_transaksi; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_penerima
    ADD CONSTRAINT fk_mapping_penerima_transaksi FOREIGN KEY (id_transaksi) REFERENCES transaksi(id_transaksi) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE;


--
-- TOC entry 2246 (class 2606 OID 25893)
-- Dependencies: 2150 207 187
-- Name: fk_mapping_rekening_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_rekening
    ADD CONSTRAINT fk_mapping_rekening_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2247 (class 2606 OID 25898)
-- Dependencies: 2164 193 207
-- Name: fk_mapping_rekening_mapping_kode_akun; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_rekening
    ADD CONSTRAINT fk_mapping_rekening_mapping_kode_akun FOREIGN KEY (id_mapping_kode_akun) REFERENCES mapping_kode_akun(id_mapping_kode_akun) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2248 (class 2606 OID 25903)
-- Dependencies: 207 2198 215
-- Name: fk_mapping_rekening_rekening_bank; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_rekening
    ADD CONSTRAINT fk_mapping_rekening_rekening_bank FOREIGN KEY (id_rekening_bank) REFERENCES rekening_bank(id_rekening_bank) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2249 (class 2606 OID 25908)
-- Dependencies: 209 169 2112
-- Name: fk_mapping_transaksi_jurnal_akmt_jurnal; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_transaksi_jurnal
    ADD CONSTRAINT fk_mapping_transaksi_jurnal_akmt_jurnal FOREIGN KEY (id_akmt_jurnal) REFERENCES akun.akmt_jurnal(id_akmt_jurnal) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE;


--
-- TOC entry 2250 (class 2606 OID 25913)
-- Dependencies: 2150 209 187
-- Name: fk_mapping_transaksi_jurnal_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_transaksi_jurnal
    ADD CONSTRAINT fk_mapping_transaksi_jurnal_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2251 (class 2606 OID 25918)
-- Dependencies: 209 2210 221
-- Name: fk_mapping_transaksi_jurnal_transaksi; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_transaksi_jurnal
    ADD CONSTRAINT fk_mapping_transaksi_jurnal_transaksi FOREIGN KEY (id_transaksi) REFERENCES transaksi(id_transaksi) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2235 (class 2606 OID 25923)
-- Dependencies: 187 196 2150
-- Name: fk_mapping_transaksi_penerima_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_transaksi_penerima
    ADD CONSTRAINT fk_mapping_transaksi_penerima_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2236 (class 2606 OID 25928)
-- Dependencies: 2158 191 196
-- Name: fk_mapping_transaksi_penerima_jenis_transaksi; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_transaksi_penerima
    ADD CONSTRAINT fk_mapping_transaksi_penerima_jenis_transaksi FOREIGN KEY (id_jenis_transaksi) REFERENCES jenis_transaksi(id_jenis_transaksi) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2237 (class 2606 OID 25933)
-- Dependencies: 195 196 2168
-- Name: fk_mapping_transaksi_penerima_klasifikasi_penerima; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_transaksi_penerima
    ADD CONSTRAINT fk_mapping_transaksi_penerima_klasifikasi_penerima FOREIGN KEY (id_klasifikasi_penerima) REFERENCES klasifikasi_penerima(id_klasifikasi_penerima) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2238 (class 2606 OID 25938)
-- Dependencies: 2150 187 197
-- Name: fk_pihak_penerima_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY pihak_penerima
    ADD CONSTRAINT fk_pihak_penerima_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2239 (class 2606 OID 25943)
-- Dependencies: 197 2168 195
-- Name: fk_pihak_penerima_klasifikasi_penerima; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY pihak_penerima
    ADD CONSTRAINT fk_pihak_penerima_klasifikasi_penerima FOREIGN KEY (id_klasifikasi_penerima) REFERENCES klasifikasi_penerima(id_klasifikasi_penerima) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2252 (class 2606 OID 25948)
-- Dependencies: 213 2150 187
-- Name: fk_propinsi_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY propinsi
    ADD CONSTRAINT fk_propinsi_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2253 (class 2606 OID 25953)
-- Dependencies: 215 2154 189
-- Name: fk_rekening_bank_bank; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY rekening_bank
    ADD CONSTRAINT fk_rekening_bank_bank FOREIGN KEY (id_bank) REFERENCES bank(id_bank) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2254 (class 2606 OID 25958)
-- Dependencies: 215 2150 187
-- Name: fk_rekening_bank_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY rekening_bank
    ADD CONSTRAINT fk_rekening_bank_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2255 (class 2606 OID 25963)
-- Dependencies: 217 2178 200
-- Name: fk_sub_kode_Kas_kode_kas; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY sub_kode_kas
    ADD CONSTRAINT "fk_sub_kode_Kas_kode_kas" FOREIGN KEY (id_kode_kas) REFERENCES kode_kas(id_kode_kas) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2256 (class 2606 OID 25968)
-- Dependencies: 2150 187 217
-- Name: fk_sub_kode_kas_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY sub_kode_kas
    ADD CONSTRAINT fk_sub_kode_kas_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2257 (class 2606 OID 25973)
-- Dependencies: 187 2150 219
-- Name: fk_sub_transaksi_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY sub_transaksi
    ADD CONSTRAINT fk_sub_transaksi_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2258 (class 2606 OID 25978)
-- Dependencies: 193 2164 219
-- Name: fk_sub_transaksi_mapping_kode_akun; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY sub_transaksi
    ADD CONSTRAINT fk_sub_transaksi_mapping_kode_akun FOREIGN KEY (id_mapping_kode_akun) REFERENCES mapping_kode_akun(id_mapping_kode_akun) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2259 (class 2606 OID 25983)
-- Dependencies: 221 2210 219
-- Name: fk_sub_transaksi_transaksi; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY sub_transaksi
    ADD CONSTRAINT fk_sub_transaksi_transaksi FOREIGN KEY (id_transaksi) REFERENCES transaksi(id_transaksi) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2260 (class 2606 OID 25988)
-- Dependencies: 187 2150 221
-- Name: fk_transaksi_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY transaksi
    ADD CONSTRAINT fk_transaksi_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2305 (class 0 OID 0)
-- Dependencies: 8
-- Name: public; Type: ACL; Schema: -; Owner: -
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2012-05-26 17:25:26 WIT

--
-- PostgreSQL database dump complete
--

