--
-- PostgreSQL database dump
--

-- Started on 2012-05-20 17:04:16 WIT

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 2299 (class 1262 OID 22377)
-- Dependencies: 2298
-- Name: yayasan; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON DATABASE yayasan IS 'Database Pengembangan u/ Yayasan ASTRA.';


--
-- TOC entry 5 (class 2615 OID 22378)
-- Name: akun; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA akun;


--
-- TOC entry 2300 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA akun; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA akun IS 'Skema untuk akuntansi.';


--
-- TOC entry 6 (class 2615 OID 22379)
-- Name: trans; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA trans;


--
-- TOC entry 2303 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA trans; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA trans IS 'Skema untuk transaksi.';


--
-- TOC entry 691 (class 2612 OID 22382)
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: -
--

CREATE PROCEDURAL LANGUAGE plpgsql;


SET search_path = akun, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 142 (class 1259 OID 22383)
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
-- TOC entry 2304 (class 0 OID 0)
-- Dependencies: 142
-- Name: TABLE akdd_arus_kas; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akdd_arus_kas IS 'Tabel yang berfungsi sebagai template laporan arus kas.';


--
-- TOC entry 143 (class 1259 OID 22391)
-- Dependencies: 5 142
-- Name: akdd_arus_kas_id_akdd_arus_kas_seq; Type: SEQUENCE; Schema: akun; Owner: -
--

CREATE SEQUENCE akdd_arus_kas_id_akdd_arus_kas_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2305 (class 0 OID 0)
-- Dependencies: 143
-- Name: akdd_arus_kas_id_akdd_arus_kas_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akdd_arus_kas_id_akdd_arus_kas_seq OWNED BY akdd_arus_kas.id_akdd_arus_kas;


--
-- TOC entry 2306 (class 0 OID 0)
-- Dependencies: 143
-- Name: akdd_arus_kas_id_akdd_arus_kas_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akdd_arus_kas_id_akdd_arus_kas_seq', 1, false);


--
-- TOC entry 144 (class 1259 OID 22393)
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
-- TOC entry 2307 (class 0 OID 0)
-- Dependencies: 144
-- Name: TABLE akdd_detail_coa; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akdd_detail_coa IS 'Data-data detail COA.';


--
-- TOC entry 145 (class 1259 OID 22396)
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
-- TOC entry 2308 (class 0 OID 0)
-- Dependencies: 145
-- Name: TABLE akdd_level_coa; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akdd_level_coa IS 'Data level COA.';


--
-- TOC entry 146 (class 1259 OID 22399)
-- Dependencies: 1831 5
-- Name: akdd_coa_level_detail_v; Type: VIEW; Schema: akun; Owner: -
--

CREATE VIEW akdd_coa_level_detail_v AS
    SELECT a.id_akdd_detail_coa, a.id_akdd_main_coa, a.id_akdd_level_coa, a.id_akdd_detail_coa_ref, a.coa_number, a.uraian FROM (akdd_detail_coa a JOIN (SELECT akdd_level_coa.id_akdd_level_coa FROM akdd_level_coa ORDER BY akdd_level_coa.level_number DESC OFFSET 0 LIMIT 1) b ON ((a.id_akdd_level_coa = b.id_akdd_level_coa)));


--
-- TOC entry 147 (class 1259 OID 22403)
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
-- TOC entry 2309 (class 0 OID 0)
-- Dependencies: 147
-- Name: akdd_detail_coa_id_akdd_detail_coa_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akdd_detail_coa_id_akdd_detail_coa_seq OWNED BY akdd_detail_coa.id_akdd_detail_coa;


--
-- TOC entry 2310 (class 0 OID 0)
-- Dependencies: 147
-- Name: akdd_detail_coa_id_akdd_detail_coa_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akdd_detail_coa_id_akdd_detail_coa_seq', 113, true);


--
-- TOC entry 148 (class 1259 OID 22405)
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
-- TOC entry 2311 (class 0 OID 0)
-- Dependencies: 148
-- Name: TABLE akmt_jurnal_det; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akmt_jurnal_det IS 'Data jurnal detail.';


--
-- TOC entry 2312 (class 0 OID 0)
-- Dependencies: 148
-- Name: COLUMN akmt_jurnal_det.flag_position; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON COLUMN akmt_jurnal_det.flag_position IS '
d = Debet
k = Kredit';


--
-- TOC entry 149 (class 1259 OID 22409)
-- Dependencies: 1832 5
-- Name: akdd_detail_coa_jurnal_v; Type: VIEW; Schema: akun; Owner: -
--

CREATE VIEW akdd_detail_coa_jurnal_v AS
    SELECT DISTINCT akmt_jurnal_det.id_akdd_detail_coa FROM akmt_jurnal_det ORDER BY akmt_jurnal_det.id_akdd_detail_coa;


--
-- TOC entry 150 (class 1259 OID 22413)
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
-- TOC entry 2313 (class 0 OID 0)
-- Dependencies: 150
-- Name: TABLE akdd_detail_coa_lr; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akdd_detail_coa_lr IS 'Data-data klasifikasi modal (sistem jurnal penutup automatis).';


--
-- TOC entry 151 (class 1259 OID 22416)
-- Dependencies: 150 5
-- Name: akdd_detail_coa_lr_id_akdd_detail_coa_lr_seq; Type: SEQUENCE; Schema: akun; Owner: -
--

CREATE SEQUENCE akdd_detail_coa_lr_id_akdd_detail_coa_lr_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2314 (class 0 OID 0)
-- Dependencies: 151
-- Name: akdd_detail_coa_lr_id_akdd_detail_coa_lr_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akdd_detail_coa_lr_id_akdd_detail_coa_lr_seq OWNED BY akdd_detail_coa_lr.id_akdd_detail_coa_lr;


--
-- TOC entry 2315 (class 0 OID 0)
-- Dependencies: 151
-- Name: akdd_detail_coa_lr_id_akdd_detail_coa_lr_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akdd_detail_coa_lr_id_akdd_detail_coa_lr_seq', 4, true);


--
-- TOC entry 152 (class 1259 OID 22418)
-- Dependencies: 2036 5
-- Name: akdd_detail_coa_map; Type: TABLE; Schema: akun; Owner: -; Tablespace: 
--

CREATE TABLE akdd_detail_coa_map (
    id_akdd_detail_coa_map integer NOT NULL,
    id_akdd_detail_coa integer NOT NULL,
    flag smallint DEFAULT 0 NOT NULL
);


--
-- TOC entry 2316 (class 0 OID 0)
-- Dependencies: 152
-- Name: TABLE akdd_detail_coa_map; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akdd_detail_coa_map IS 'Tabel mapping coa yg masuk di pemasukan, pengeluaran, dan jurnal umum.';


--
-- TOC entry 2317 (class 0 OID 0)
-- Dependencies: 152
-- Name: COLUMN akdd_detail_coa_map.flag; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON COLUMN akdd_detail_coa_map.flag IS '0: JU
1: JU + JP
2: JU + JB
3: JU + JP + JB';


--
-- TOC entry 153 (class 1259 OID 22422)
-- Dependencies: 152 5
-- Name: akdd_detail_coa_map_id_akdd_detail_coa_map_seq; Type: SEQUENCE; Schema: akun; Owner: -
--

CREATE SEQUENCE akdd_detail_coa_map_id_akdd_detail_coa_map_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2318 (class 0 OID 0)
-- Dependencies: 153
-- Name: akdd_detail_coa_map_id_akdd_detail_coa_map_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akdd_detail_coa_map_id_akdd_detail_coa_map_seq OWNED BY akdd_detail_coa_map.id_akdd_detail_coa_map;


--
-- TOC entry 2319 (class 0 OID 0)
-- Dependencies: 153
-- Name: akdd_detail_coa_map_id_akdd_detail_coa_map_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akdd_detail_coa_map_id_akdd_detail_coa_map_seq', 85, true);


--
-- TOC entry 154 (class 1259 OID 22424)
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
-- TOC entry 2320 (class 0 OID 0)
-- Dependencies: 154
-- Name: TABLE akdd_main_coa; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akdd_main_coa IS 'Data kategori utama COA.';


--
-- TOC entry 155 (class 1259 OID 22427)
-- Dependencies: 1833 5
-- Name: akdd_detail_coa_v; Type: VIEW; Schema: akun; Owner: -
--

CREATE VIEW akdd_detail_coa_v AS
    SELECT a.id_akdd_detail_coa, a.id_akdd_main_coa, a.id_akdd_level_coa, a.id_akdd_detail_coa_ref AS id_akdd_detail_coa_parent, d.id_akdd_detail_coa_ref, a.coa_number, a.uraian, b.acc_type, b.uraian AS uraian_main_coa, c.level_number, c.level_length FROM (((akdd_detail_coa a JOIN akdd_main_coa b ON ((a.id_akdd_main_coa = b.id_akdd_main_coa))) JOIN akdd_level_coa c ON ((a.id_akdd_level_coa = c.id_akdd_level_coa))) LEFT JOIN (SELECT a.id_akdd_detail_coa_ref FROM (akdd_detail_coa a JOIN akdd_level_coa b ON ((a.id_akdd_level_coa = b.id_akdd_level_coa))) WHERE (b.level_number > 1) GROUP BY a.id_akdd_detail_coa_ref) d ON ((a.id_akdd_detail_coa = d.id_akdd_detail_coa_ref)));


--
-- TOC entry 156 (class 1259 OID 22432)
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
-- TOC entry 2321 (class 0 OID 0)
-- Dependencies: 156
-- Name: TABLE akdd_klasifikasi_modal; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akdd_klasifikasi_modal IS 'Data-data klasifikasi modal.';


--
-- TOC entry 157 (class 1259 OID 22435)
-- Dependencies: 156 5
-- Name: akdd_klasifikasi_modal_id_akdd_klasifikasi_modal_seq; Type: SEQUENCE; Schema: akun; Owner: -
--

CREATE SEQUENCE akdd_klasifikasi_modal_id_akdd_klasifikasi_modal_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2322 (class 0 OID 0)
-- Dependencies: 157
-- Name: akdd_klasifikasi_modal_id_akdd_klasifikasi_modal_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akdd_klasifikasi_modal_id_akdd_klasifikasi_modal_seq OWNED BY akdd_klasifikasi_modal.id_akdd_klasifikasi_modal;


--
-- TOC entry 2323 (class 0 OID 0)
-- Dependencies: 157
-- Name: akdd_klasifikasi_modal_id_akdd_klasifikasi_modal_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akdd_klasifikasi_modal_id_akdd_klasifikasi_modal_seq', 5, true);


--
-- TOC entry 158 (class 1259 OID 22437)
-- Dependencies: 5
-- Name: akdd_kodifikasi_jurnal; Type: TABLE; Schema: akun; Owner: -; Tablespace: 
--

CREATE TABLE akdd_kodifikasi_jurnal (
    id_akdd_kodifikasi_jurnal integer NOT NULL,
    kode character(2) NOT NULL,
    notes character varying(255)
);


--
-- TOC entry 2324 (class 0 OID 0)
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
-- TOC entry 159 (class 1259 OID 22440)
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
-- TOC entry 2325 (class 0 OID 0)
-- Dependencies: 159
-- Name: akdd_level_coa_id_akdd_level_coa_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akdd_level_coa_id_akdd_level_coa_seq OWNED BY akdd_level_coa.id_akdd_level_coa;


--
-- TOC entry 2326 (class 0 OID 0)
-- Dependencies: 159
-- Name: akdd_level_coa_id_akdd_level_coa_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akdd_level_coa_id_akdd_level_coa_seq', 4, true);


--
-- TOC entry 160 (class 1259 OID 22442)
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
-- TOC entry 2327 (class 0 OID 0)
-- Dependencies: 160
-- Name: akdd_main_coa_id_akdd_main_coa_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akdd_main_coa_id_akdd_main_coa_seq OWNED BY akdd_main_coa.id_akdd_main_coa;


--
-- TOC entry 2328 (class 0 OID 0)
-- Dependencies: 160
-- Name: akdd_main_coa_id_akdd_main_coa_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akdd_main_coa_id_akdd_main_coa_seq', 5, true);


--
-- TOC entry 161 (class 1259 OID 22444)
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
-- TOC entry 2329 (class 0 OID 0)
-- Dependencies: 161
-- Name: TABLE akdd_perubahan_dana; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akdd_perubahan_dana IS 'Data template perubahan dana.';


--
-- TOC entry 162 (class 1259 OID 22450)
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
-- TOC entry 2330 (class 0 OID 0)
-- Dependencies: 162
-- Name: akdd_perubahan_dana_id_akdd_perubahan_dana_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akdd_perubahan_dana_id_akdd_perubahan_dana_seq OWNED BY akdd_perubahan_dana.id_akdd_perubahan_dana;


--
-- TOC entry 2331 (class 0 OID 0)
-- Dependencies: 162
-- Name: akdd_perubahan_dana_id_akdd_perubahan_dana_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akdd_perubahan_dana_id_akdd_perubahan_dana_seq', 24, true);


--
-- TOC entry 163 (class 1259 OID 22452)
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
-- TOC entry 2332 (class 0 OID 0)
-- Dependencies: 163
-- Name: TABLE akdd_posisi_keuangan; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akdd_posisi_keuangan IS 'Tabel yang berfungsi sebagai template laporan posisi keuangan.';


--
-- TOC entry 164 (class 1259 OID 22459)
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
-- TOC entry 2333 (class 0 OID 0)
-- Dependencies: 164
-- Name: akdd_posisi_keuangan_id_akdd_posisi_keuangan_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akdd_posisi_keuangan_id_akdd_posisi_keuangan_seq OWNED BY akdd_posisi_keuangan.id_akdd_posisi_keuangan;


--
-- TOC entry 2334 (class 0 OID 0)
-- Dependencies: 164
-- Name: akdd_posisi_keuangan_id_akdd_posisi_keuangan_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akdd_posisi_keuangan_id_akdd_posisi_keuangan_seq', 17, true);


--
-- TOC entry 165 (class 1259 OID 22461)
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
-- TOC entry 2335 (class 0 OID 0)
-- Dependencies: 165
-- Name: TABLE akmt_buku_besar; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akmt_buku_besar IS 'Data saldo-saldo COA.';


--
-- TOC entry 166 (class 1259 OID 22464)
-- Dependencies: 5 165
-- Name: akmt_buku_besar_id_akmt_buku_besar_seq; Type: SEQUENCE; Schema: akun; Owner: -
--

CREATE SEQUENCE akmt_buku_besar_id_akmt_buku_besar_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2336 (class 0 OID 0)
-- Dependencies: 166
-- Name: akmt_buku_besar_id_akmt_buku_besar_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akmt_buku_besar_id_akmt_buku_besar_seq OWNED BY akmt_buku_besar.id_akmt_buku_besar;


--
-- TOC entry 2337 (class 0 OID 0)
-- Dependencies: 166
-- Name: akmt_buku_besar_id_akmt_buku_besar_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akmt_buku_besar_id_akmt_buku_besar_seq', 485, true);


--
-- TOC entry 167 (class 1259 OID 22466)
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
-- TOC entry 2338 (class 0 OID 0)
-- Dependencies: 167
-- Name: TABLE akmt_periode; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akmt_periode IS 'Data periode keuangan.';


--
-- TOC entry 2339 (class 0 OID 0)
-- Dependencies: 167
-- Name: COLUMN akmt_periode.flag_temp; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON COLUMN akmt_periode.flag_temp IS '
0 = Temporary Dirty
1 = Temporary Clean
2 = Permanent';


--
-- TOC entry 168 (class 1259 OID 22469)
-- Dependencies: 1834 5
-- Name: akmt_buku_besar_periode_v; Type: VIEW; Schema: akun; Owner: -
--

CREATE VIEW akmt_buku_besar_periode_v AS
    SELECT c.id_akdd_main_coa, c.acc_type, c.id_akdd_detail_coa, c.coa_number, c.uraian AS coa_uraian, c.level_number, a.id_akmt_buku_besar, a.id_akmt_periode, a.no_bukti, a.tanggal, a.awal, a.mutasi_debet, a.mutasi_kredit, a.akhir, a.keterangan, b.tahun, b.bulan, b.uraian FROM ((akdd_detail_coa_v c LEFT JOIN akmt_buku_besar a ON ((a.id_akdd_detail_coa = c.id_akdd_detail_coa))) LEFT JOIN akmt_periode b ON ((a.id_akmt_periode = b.id_akmt_periode)));


--
-- TOC entry 169 (class 1259 OID 22474)
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
-- TOC entry 2340 (class 0 OID 0)
-- Dependencies: 169
-- Name: TABLE akmt_jurnal; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akmt_jurnal IS 'Data jurnal.';


--
-- TOC entry 2341 (class 0 OID 0)
-- Dependencies: 169
-- Name: COLUMN akmt_jurnal.flag_jurnal; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON COLUMN akmt_jurnal.flag_jurnal IS '
0 = Jurnal umum
1 = Jurnal mapping';


--
-- TOC entry 2342 (class 0 OID 0)
-- Dependencies: 169
-- Name: COLUMN akmt_jurnal.flag_temp; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON COLUMN akmt_jurnal.flag_temp IS '
0 = Belum selesai
1 = Sudah selesai
2 = Sudah disetujui';


--
-- TOC entry 2343 (class 0 OID 0)
-- Dependencies: 169
-- Name: COLUMN akmt_jurnal.flag_posting; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON COLUMN akmt_jurnal.flag_posting IS '
0 = Belum posting
1 = Sudah posting sementara
2 = Sudah posting permanen';


--
-- TOC entry 170 (class 1259 OID 22477)
-- Dependencies: 148 5
-- Name: akmt_jurnal_det_id_akmt_jurnal_det_seq; Type: SEQUENCE; Schema: akun; Owner: -
--

CREATE SEQUENCE akmt_jurnal_det_id_akmt_jurnal_det_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2344 (class 0 OID 0)
-- Dependencies: 170
-- Name: akmt_jurnal_det_id_akmt_jurnal_det_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akmt_jurnal_det_id_akmt_jurnal_det_seq OWNED BY akmt_jurnal_det.id_akmt_jurnal_det;


--
-- TOC entry 2345 (class 0 OID 0)
-- Dependencies: 170
-- Name: akmt_jurnal_det_id_akmt_jurnal_det_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akmt_jurnal_det_id_akmt_jurnal_det_seq', 32, true);


--
-- TOC entry 171 (class 1259 OID 22479)
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
-- TOC entry 2346 (class 0 OID 0)
-- Dependencies: 171
-- Name: akmt_jurnal_id_akmt_jurnal_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akmt_jurnal_id_akmt_jurnal_seq OWNED BY akmt_jurnal.id_akmt_jurnal;


--
-- TOC entry 2347 (class 0 OID 0)
-- Dependencies: 171
-- Name: akmt_jurnal_id_akmt_jurnal_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akmt_jurnal_id_akmt_jurnal_seq', 17, true);


--
-- TOC entry 172 (class 1259 OID 22481)
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
-- TOC entry 2348 (class 0 OID 0)
-- Dependencies: 172
-- Name: akmt_periode_id_akmt_periode_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akmt_periode_id_akmt_periode_seq OWNED BY akmt_periode.id_akmt_periode;


--
-- TOC entry 2349 (class 0 OID 0)
-- Dependencies: 172
-- Name: akmt_periode_id_akmt_periode_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akmt_periode_id_akmt_periode_seq', 6, true);


SET search_path = public, pg_catalog;

--
-- TOC entry 173 (class 1259 OID 22483)
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
-- TOC entry 2350 (class 0 OID 0)
-- Dependencies: 173
-- Name: TABLE dd_access; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dd_access IS 'Data hak akses';


--
-- TOC entry 174 (class 1259 OID 22486)
-- Dependencies: 173 8
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
-- TOC entry 2351 (class 0 OID 0)
-- Dependencies: 174
-- Name: dd_access_id_dd_access_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dd_access_id_dd_access_seq OWNED BY dd_access.id_dd_access;


--
-- TOC entry 2352 (class 0 OID 0)
-- Dependencies: 174
-- Name: dd_access_id_dd_access_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dd_access_id_dd_access_seq', 5, true);


--
-- TOC entry 175 (class 1259 OID 22488)
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
-- TOC entry 2353 (class 0 OID 0)
-- Dependencies: 175
-- Name: TABLE dd_groups; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dd_groups IS 'Data kelompok pengguna';


--
-- TOC entry 176 (class 1259 OID 22491)
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
-- TOC entry 2354 (class 0 OID 0)
-- Dependencies: 176
-- Name: TABLE dd_groups_detail; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dd_groups_detail IS 'Data kelompok detail';


--
-- TOC entry 177 (class 1259 OID 22494)
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
-- TOC entry 2355 (class 0 OID 0)
-- Dependencies: 177
-- Name: dd_groups_detail_id_dd_groups_detail_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dd_groups_detail_id_dd_groups_detail_seq OWNED BY dd_groups_detail.id_dd_groups_detail;


--
-- TOC entry 2356 (class 0 OID 0)
-- Dependencies: 177
-- Name: dd_groups_detail_id_dd_groups_detail_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dd_groups_detail_id_dd_groups_detail_seq', 137, true);


--
-- TOC entry 178 (class 1259 OID 22496)
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
-- TOC entry 2357 (class 0 OID 0)
-- Dependencies: 178
-- Name: dd_groups_id_dd_groups_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dd_groups_id_dd_groups_seq OWNED BY dd_groups.id_dd_groups;


--
-- TOC entry 2358 (class 0 OID 0)
-- Dependencies: 178
-- Name: dd_groups_id_dd_groups_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dd_groups_id_dd_groups_seq', 4, true);


--
-- TOC entry 179 (class 1259 OID 22498)
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
-- TOC entry 2359 (class 0 OID 0)
-- Dependencies: 179
-- Name: TABLE dd_menus; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dd_menus IS 'Data menu';


--
-- TOC entry 180 (class 1259 OID 22501)
-- Dependencies: 179 8
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
-- TOC entry 2360 (class 0 OID 0)
-- Dependencies: 180
-- Name: dd_menus_id_dd_menus_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dd_menus_id_dd_menus_seq OWNED BY dd_menus.id_dd_menus;


--
-- TOC entry 2361 (class 0 OID 0)
-- Dependencies: 180
-- Name: dd_menus_id_dd_menus_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dd_menus_id_dd_menus_seq', 8, true);


--
-- TOC entry 181 (class 1259 OID 22503)
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
-- TOC entry 2362 (class 0 OID 0)
-- Dependencies: 181
-- Name: TABLE dd_moduls; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dd_moduls IS 'Data modul-modul';


--
-- TOC entry 182 (class 1259 OID 22506)
-- Dependencies: 181 8
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
-- TOC entry 2363 (class 0 OID 0)
-- Dependencies: 182
-- Name: dd_moduls_id_dd_moduls_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dd_moduls_id_dd_moduls_seq OWNED BY dd_moduls.id_dd_moduls;


--
-- TOC entry 2364 (class 0 OID 0)
-- Dependencies: 182
-- Name: dd_moduls_id_dd_moduls_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dd_moduls_id_dd_moduls_seq', 14, true);


--
-- TOC entry 183 (class 1259 OID 22508)
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
-- TOC entry 2365 (class 0 OID 0)
-- Dependencies: 183
-- Name: TABLE dd_sub_menus; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dd_sub_menus IS 'Data sub menu';


--
-- TOC entry 184 (class 1259 OID 22511)
-- Dependencies: 183 8
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
-- TOC entry 2366 (class 0 OID 0)
-- Dependencies: 184
-- Name: dd_sub_menus_id_dd_sub_menus_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dd_sub_menus_id_dd_sub_menus_seq OWNED BY dd_sub_menus.id_dd_sub_menus;


--
-- TOC entry 2367 (class 0 OID 0)
-- Dependencies: 184
-- Name: dd_sub_menus_id_dd_sub_menus_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dd_sub_menus_id_dd_sub_menus_seq', 21, true);


--
-- TOC entry 185 (class 1259 OID 22513)
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
-- TOC entry 2368 (class 0 OID 0)
-- Dependencies: 185
-- Name: TABLE dd_tabs; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dd_tabs IS 'Data tab-tab';


--
-- TOC entry 186 (class 1259 OID 22516)
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
-- TOC entry 2369 (class 0 OID 0)
-- Dependencies: 186
-- Name: dd_tabs_id_dd_tabs_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dd_tabs_id_dd_tabs_seq OWNED BY dd_tabs.id_dd_tabs;


--
-- TOC entry 2370 (class 0 OID 0)
-- Dependencies: 186
-- Name: dd_tabs_id_dd_tabs_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dd_tabs_id_dd_tabs_seq', 45, true);


--
-- TOC entry 187 (class 1259 OID 22518)
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
-- TOC entry 2371 (class 0 OID 0)
-- Dependencies: 187
-- Name: TABLE dd_users; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dd_users IS 'Data pengguna';


--
-- TOC entry 188 (class 1259 OID 22521)
-- Dependencies: 187 8
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
-- TOC entry 2372 (class 0 OID 0)
-- Dependencies: 188
-- Name: dd_users_id_dd_users_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dd_users_id_dd_users_seq OWNED BY dd_users.id_dd_users;


--
-- TOC entry 2373 (class 0 OID 0)
-- Dependencies: 188
-- Name: dd_users_id_dd_users_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dd_users_id_dd_users_seq', 4, true);


SET search_path = trans, pg_catalog;

--
-- TOC entry 189 (class 1259 OID 22523)
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
-- TOC entry 2374 (class 0 OID 0)
-- Dependencies: 189
-- Name: TABLE bank; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE bank IS 'Tabel data bank.';


--
-- TOC entry 190 (class 1259 OID 22526)
-- Dependencies: 189 6
-- Name: bank_id_bank_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE bank_id_bank_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2375 (class 0 OID 0)
-- Dependencies: 190
-- Name: bank_id_bank_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE bank_id_bank_seq OWNED BY bank.id_bank;


--
-- TOC entry 2376 (class 0 OID 0)
-- Dependencies: 190
-- Name: bank_id_bank_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('bank_id_bank_seq', 7, true);


--
-- TOC entry 191 (class 1259 OID 22528)
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
-- TOC entry 2377 (class 0 OID 0)
-- Dependencies: 191
-- Name: TABLE jenis_transaksi; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE jenis_transaksi IS 'Tabel jenis-jenis transaksi.';


--
-- TOC entry 192 (class 1259 OID 22531)
-- Dependencies: 191 6
-- Name: jenis_transaksi_id_jenis_transaksi_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE jenis_transaksi_id_jenis_transaksi_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2378 (class 0 OID 0)
-- Dependencies: 192
-- Name: jenis_transaksi_id_jenis_transaksi_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE jenis_transaksi_id_jenis_transaksi_seq OWNED BY jenis_transaksi.id_jenis_transaksi;


--
-- TOC entry 2379 (class 0 OID 0)
-- Dependencies: 192
-- Name: jenis_transaksi_id_jenis_transaksi_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('jenis_transaksi_id_jenis_transaksi_seq', 7, true);


--
-- TOC entry 193 (class 1259 OID 22533)
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
-- TOC entry 2380 (class 0 OID 0)
-- Dependencies: 193
-- Name: TABLE mapping_kode_akun; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE mapping_kode_akun IS 'Tabel yang memetakan antara kode akun dengan jenis transaksi.';


--
-- TOC entry 2381 (class 0 OID 0)
-- Dependencies: 193
-- Name: COLUMN mapping_kode_akun.flag_debet_kredit; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON COLUMN mapping_kode_akun.flag_debet_kredit IS '1 = Debet
2 = Kredit';


--
-- TOC entry 2382 (class 0 OID 0)
-- Dependencies: 193
-- Name: COLUMN mapping_kode_akun.flag_pajak; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON COLUMN mapping_kode_akun.flag_pajak IS '1 = Bukan Pajak
2 = Pajak';


--
-- TOC entry 194 (class 1259 OID 22538)
-- Dependencies: 1835 6
-- Name: jenis_transaksi_mapping_v; Type: VIEW; Schema: trans; Owner: -
--

CREATE VIEW jenis_transaksi_mapping_v AS
    SELECT a.id_jenis_transaksi, a.id_sub_kode_kas, a.transaksi FROM (jenis_transaksi a JOIN mapping_kode_akun b ON ((a.id_jenis_transaksi = b.id_jenis_transaksi))) GROUP BY a.id_jenis_transaksi, a.id_sub_kode_kas, a.transaksi ORDER BY a.transaksi;


--
-- TOC entry 195 (class 1259 OID 22542)
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
-- TOC entry 2383 (class 0 OID 0)
-- Dependencies: 195
-- Name: TABLE klasifikasi_penerima; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE klasifikasi_penerima IS 'Tabel klasifikasi penerima.';


--
-- TOC entry 196 (class 1259 OID 22545)
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
-- TOC entry 2384 (class 0 OID 0)
-- Dependencies: 196
-- Name: TABLE mapping_transaksi_penerima; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE mapping_transaksi_penerima IS 'Tabel mapping antara jenis transaksi dan klasifikasi penerima (khusus transaksi biaya saja).';


--
-- TOC entry 197 (class 1259 OID 22548)
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
-- TOC entry 2385 (class 0 OID 0)
-- Dependencies: 197
-- Name: TABLE pihak_penerima; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE pihak_penerima IS 'Tabel pihak penerima dari pengeluaran Yayasan Astra.';


--
-- TOC entry 198 (class 1259 OID 22554)
-- Dependencies: 1836 6
-- Name: jenis_transaksi_pihak_penerima_v; Type: VIEW; Schema: trans; Owner: -
--

CREATE VIEW jenis_transaksi_pihak_penerima_v AS
    SELECT a.id_jenis_transaksi, c.id_pihak_penerima, ((((c.nama)::text || ' ('::text) || (b.klasifikasi)::text) || ')'::text) AS pihak_penerima FROM ((mapping_transaksi_penerima a JOIN klasifikasi_penerima b ON ((a.id_klasifikasi_penerima = b.id_klasifikasi_penerima))) JOIN pihak_penerima c ON ((b.id_klasifikasi_penerima = c.id_klasifikasi_penerima))) ORDER BY b.klasifikasi, c.nama;


--
-- TOC entry 199 (class 1259 OID 22558)
-- Dependencies: 6 195
-- Name: klasifikasi_penerima_id_klasifikasi_penerima_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE klasifikasi_penerima_id_klasifikasi_penerima_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2386 (class 0 OID 0)
-- Dependencies: 199
-- Name: klasifikasi_penerima_id_klasifikasi_penerima_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE klasifikasi_penerima_id_klasifikasi_penerima_seq OWNED BY klasifikasi_penerima.id_klasifikasi_penerima;


--
-- TOC entry 2387 (class 0 OID 0)
-- Dependencies: 199
-- Name: klasifikasi_penerima_id_klasifikasi_penerima_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('klasifikasi_penerima_id_klasifikasi_penerima_seq', 3, true);


--
-- TOC entry 200 (class 1259 OID 22560)
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
-- TOC entry 2388 (class 0 OID 0)
-- Dependencies: 200
-- Name: TABLE kode_kas; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE kode_kas IS 'Tabel kode kas.';


--
-- TOC entry 2389 (class 0 OID 0)
-- Dependencies: 200
-- Name: COLUMN kode_kas.flag_in_out; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON COLUMN kode_kas.flag_in_out IS '''i'' = Input, ''o'' = Output.';


--
-- TOC entry 201 (class 1259 OID 22565)
-- Dependencies: 6 200
-- Name: kode_kas_id_kode_kas_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE kode_kas_id_kode_kas_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2390 (class 0 OID 0)
-- Dependencies: 201
-- Name: kode_kas_id_kode_kas_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE kode_kas_id_kode_kas_seq OWNED BY kode_kas.id_kode_kas;


--
-- TOC entry 2391 (class 0 OID 0)
-- Dependencies: 201
-- Name: kode_kas_id_kode_kas_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('kode_kas_id_kode_kas_seq', 4, true);


--
-- TOC entry 202 (class 1259 OID 22567)
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
-- TOC entry 2392 (class 0 OID 0)
-- Dependencies: 202
-- Name: TABLE kota; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE kota IS 'Tabel data-data kota.';


--
-- TOC entry 203 (class 1259 OID 22570)
-- Dependencies: 202 6
-- Name: kota_id_kota_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE kota_id_kota_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2393 (class 0 OID 0)
-- Dependencies: 203
-- Name: kota_id_kota_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE kota_id_kota_seq OWNED BY kota.id_kota;


--
-- TOC entry 2394 (class 0 OID 0)
-- Dependencies: 203
-- Name: kota_id_kota_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('kota_id_kota_seq', 7, true);


--
-- TOC entry 204 (class 1259 OID 22572)
-- Dependencies: 6 193
-- Name: mapping_kode_akun_id_mapping_kode_akun_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE mapping_kode_akun_id_mapping_kode_akun_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2395 (class 0 OID 0)
-- Dependencies: 204
-- Name: mapping_kode_akun_id_mapping_kode_akun_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE mapping_kode_akun_id_mapping_kode_akun_seq OWNED BY mapping_kode_akun.id_mapping_kode_akun;


--
-- TOC entry 2396 (class 0 OID 0)
-- Dependencies: 204
-- Name: mapping_kode_akun_id_mapping_kode_akun_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('mapping_kode_akun_id_mapping_kode_akun_seq', 15, true);


--
-- TOC entry 205 (class 1259 OID 22574)
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
-- TOC entry 2397 (class 0 OID 0)
-- Dependencies: 205
-- Name: TABLE mapping_penerima; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE mapping_penerima IS 'Tabel mapping antara pihak penerima dengan transaksi.';


--
-- TOC entry 206 (class 1259 OID 22577)
-- Dependencies: 205 6
-- Name: mapping_penerima_id_mapping_penerima_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE mapping_penerima_id_mapping_penerima_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2398 (class 0 OID 0)
-- Dependencies: 206
-- Name: mapping_penerima_id_mapping_penerima_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE mapping_penerima_id_mapping_penerima_seq OWNED BY mapping_penerima.id_mapping_penerima;


--
-- TOC entry 2399 (class 0 OID 0)
-- Dependencies: 206
-- Name: mapping_penerima_id_mapping_penerima_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('mapping_penerima_id_mapping_penerima_seq', 6, true);


--
-- TOC entry 207 (class 1259 OID 22579)
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
-- TOC entry 2400 (class 0 OID 0)
-- Dependencies: 207
-- Name: TABLE mapping_rekening; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE mapping_rekening IS 'Tabel mapping rekening.';


--
-- TOC entry 208 (class 1259 OID 22582)
-- Dependencies: 6 207
-- Name: mapping_rekening_id_mapping_rekening_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE mapping_rekening_id_mapping_rekening_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2401 (class 0 OID 0)
-- Dependencies: 208
-- Name: mapping_rekening_id_mapping_rekening_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE mapping_rekening_id_mapping_rekening_seq OWNED BY mapping_rekening.id_mapping_rekening;


--
-- TOC entry 2402 (class 0 OID 0)
-- Dependencies: 208
-- Name: mapping_rekening_id_mapping_rekening_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('mapping_rekening_id_mapping_rekening_seq', 1, false);


--
-- TOC entry 209 (class 1259 OID 22584)
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
-- TOC entry 2403 (class 0 OID 0)
-- Dependencies: 209
-- Name: TABLE mapping_transaksi_jurnal; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE mapping_transaksi_jurnal IS 'Tabel mapping antara transaksi dengan jurnal.';


--
-- TOC entry 210 (class 1259 OID 22587)
-- Dependencies: 6 209
-- Name: mapping_transaksi_jurnal_id_mapping_transaksi_jurnal_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE mapping_transaksi_jurnal_id_mapping_transaksi_jurnal_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2404 (class 0 OID 0)
-- Dependencies: 210
-- Name: mapping_transaksi_jurnal_id_mapping_transaksi_jurnal_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE mapping_transaksi_jurnal_id_mapping_transaksi_jurnal_seq OWNED BY mapping_transaksi_jurnal.id_mapping_transaksi_jurnal;


--
-- TOC entry 2405 (class 0 OID 0)
-- Dependencies: 210
-- Name: mapping_transaksi_jurnal_id_mapping_transaksi_jurnal_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('mapping_transaksi_jurnal_id_mapping_transaksi_jurnal_seq', 11, true);


--
-- TOC entry 211 (class 1259 OID 22589)
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
-- TOC entry 2406 (class 0 OID 0)
-- Dependencies: 211
-- Name: mapping_transaksi_penerima_id_mapping_transaksi_penerima_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE mapping_transaksi_penerima_id_mapping_transaksi_penerima_seq OWNED BY mapping_transaksi_penerima.id_mapping_transaksi_penerima;


--
-- TOC entry 2407 (class 0 OID 0)
-- Dependencies: 211
-- Name: mapping_transaksi_penerima_id_mapping_transaksi_penerima_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('mapping_transaksi_penerima_id_mapping_transaksi_penerima_seq', 4, true);


--
-- TOC entry 212 (class 1259 OID 22591)
-- Dependencies: 6 197
-- Name: pihak_penerima_id_pihak_penerima_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE pihak_penerima_id_pihak_penerima_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2408 (class 0 OID 0)
-- Dependencies: 212
-- Name: pihak_penerima_id_pihak_penerima_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE pihak_penerima_id_pihak_penerima_seq OWNED BY pihak_penerima.id_pihak_penerima;


--
-- TOC entry 2409 (class 0 OID 0)
-- Dependencies: 212
-- Name: pihak_penerima_id_pihak_penerima_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('pihak_penerima_id_pihak_penerima_seq', 8, true);


--
-- TOC entry 213 (class 1259 OID 22593)
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
-- TOC entry 2410 (class 0 OID 0)
-- Dependencies: 213
-- Name: TABLE propinsi; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE propinsi IS 'Tabel data-data propinsi.';


--
-- TOC entry 214 (class 1259 OID 22596)
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
-- TOC entry 2411 (class 0 OID 0)
-- Dependencies: 214
-- Name: propinsi_id_propinsi_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE propinsi_id_propinsi_seq OWNED BY propinsi.id_propinsi;


--
-- TOC entry 2412 (class 0 OID 0)
-- Dependencies: 214
-- Name: propinsi_id_propinsi_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('propinsi_id_propinsi_seq', 4, true);


--
-- TOC entry 215 (class 1259 OID 22598)
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
-- TOC entry 2413 (class 0 OID 0)
-- Dependencies: 215
-- Name: TABLE rekening_bank; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE rekening_bank IS 'Tabel rekening dari tiap-tiap bank.';


--
-- TOC entry 216 (class 1259 OID 22601)
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
-- TOC entry 2414 (class 0 OID 0)
-- Dependencies: 216
-- Name: rekening_bank_id_rekening_bank_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE rekening_bank_id_rekening_bank_seq OWNED BY rekening_bank.id_rekening_bank;


--
-- TOC entry 2415 (class 0 OID 0)
-- Dependencies: 216
-- Name: rekening_bank_id_rekening_bank_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('rekening_bank_id_rekening_bank_seq', 3, true);


--
-- TOC entry 217 (class 1259 OID 22603)
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
-- TOC entry 2416 (class 0 OID 0)
-- Dependencies: 217
-- Name: TABLE sub_kode_kas; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE sub_kode_kas IS 'Tabel sub kode kas.';


--
-- TOC entry 218 (class 1259 OID 22606)
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
-- TOC entry 2417 (class 0 OID 0)
-- Dependencies: 218
-- Name: sub_kode_kas_id_sub_kode_kas_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE sub_kode_kas_id_sub_kode_kas_seq OWNED BY sub_kode_kas.id_sub_kode_kas;


--
-- TOC entry 2418 (class 0 OID 0)
-- Dependencies: 218
-- Name: sub_kode_kas_id_sub_kode_kas_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('sub_kode_kas_id_sub_kode_kas_seq', 9, true);


--
-- TOC entry 219 (class 1259 OID 22608)
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
-- TOC entry 2419 (class 0 OID 0)
-- Dependencies: 219
-- Name: TABLE sub_transaksi; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE sub_transaksi IS 'Tabel berisikan data-data sub transaksi.';


--
-- TOC entry 220 (class 1259 OID 22611)
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
-- TOC entry 2420 (class 0 OID 0)
-- Dependencies: 220
-- Name: sub_transaksi_id_sub_transaksi_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE sub_transaksi_id_sub_transaksi_seq OWNED BY sub_transaksi.id_sub_transaksi;


--
-- TOC entry 2421 (class 0 OID 0)
-- Dependencies: 220
-- Name: sub_transaksi_id_sub_transaksi_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('sub_transaksi_id_sub_transaksi_seq', 35, true);


--
-- TOC entry 221 (class 1259 OID 22613)
-- Dependencies: 2074 6
-- Name: transaksi; Type: TABLE; Schema: trans; Owner: -; Tablespace: 
--

CREATE TABLE transaksi (
    id_transaksi bigint NOT NULL,
    id_dd_users integer NOT NULL,
    tanggal date NOT NULL,
    no_bukti character varying(50) NOT NULL,
    petugas character varying(50) NOT NULL,
    keterangan character varying(255),
    CONSTRAINT check_tanggal_transaksi CHECK ((tanggal <= now()))
);


--
-- TOC entry 2422 (class 0 OID 0)
-- Dependencies: 221
-- Name: TABLE transaksi; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE transaksi IS 'Tabel transaksi-transaksi yang ada di yayasan.';


--
-- TOC entry 222 (class 1259 OID 22617)
-- Dependencies: 221 6
-- Name: transaksi_id_transaksi_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE transaksi_id_transaksi_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2423 (class 0 OID 0)
-- Dependencies: 222
-- Name: transaksi_id_transaksi_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE transaksi_id_transaksi_seq OWNED BY transaksi.id_transaksi;


--
-- TOC entry 2424 (class 0 OID 0)
-- Dependencies: 222
-- Name: transaksi_id_transaksi_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('transaksi_id_transaksi_seq', 16, true);


SET search_path = akun, pg_catalog;

--
-- TOC entry 2030 (class 2604 OID 22619)
-- Dependencies: 143 142
-- Name: id_akdd_arus_kas; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_arus_kas ALTER COLUMN id_akdd_arus_kas SET DEFAULT nextval('akdd_arus_kas_id_akdd_arus_kas_seq'::regclass);


--
-- TOC entry 2031 (class 2604 OID 22620)
-- Dependencies: 147 144
-- Name: id_akdd_detail_coa; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_detail_coa ALTER COLUMN id_akdd_detail_coa SET DEFAULT nextval('akdd_detail_coa_id_akdd_detail_coa_seq'::regclass);


--
-- TOC entry 2035 (class 2604 OID 22621)
-- Dependencies: 151 150
-- Name: id_akdd_detail_coa_lr; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_detail_coa_lr ALTER COLUMN id_akdd_detail_coa_lr SET DEFAULT nextval('akdd_detail_coa_lr_id_akdd_detail_coa_lr_seq'::regclass);


--
-- TOC entry 2037 (class 2604 OID 22622)
-- Dependencies: 153 152
-- Name: id_akdd_detail_coa_map; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_detail_coa_map ALTER COLUMN id_akdd_detail_coa_map SET DEFAULT nextval('akdd_detail_coa_map_id_akdd_detail_coa_map_seq'::regclass);


--
-- TOC entry 2039 (class 2604 OID 22623)
-- Dependencies: 157 156
-- Name: id_akdd_klasifikasi_modal; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_klasifikasi_modal ALTER COLUMN id_akdd_klasifikasi_modal SET DEFAULT nextval('akdd_klasifikasi_modal_id_akdd_klasifikasi_modal_seq'::regclass);


--
-- TOC entry 2032 (class 2604 OID 22624)
-- Dependencies: 159 145
-- Name: id_akdd_level_coa; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_level_coa ALTER COLUMN id_akdd_level_coa SET DEFAULT nextval('akdd_level_coa_id_akdd_level_coa_seq'::regclass);


--
-- TOC entry 2038 (class 2604 OID 22625)
-- Dependencies: 160 154
-- Name: id_akdd_main_coa; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_main_coa ALTER COLUMN id_akdd_main_coa SET DEFAULT nextval('akdd_main_coa_id_akdd_main_coa_seq'::regclass);


--
-- TOC entry 2040 (class 2604 OID 22626)
-- Dependencies: 162 161
-- Name: id_akdd_perubahan_dana; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_perubahan_dana ALTER COLUMN id_akdd_perubahan_dana SET DEFAULT nextval('akdd_perubahan_dana_id_akdd_perubahan_dana_seq'::regclass);


--
-- TOC entry 2042 (class 2604 OID 22627)
-- Dependencies: 164 163
-- Name: id_akdd_posisi_keuangan; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_posisi_keuangan ALTER COLUMN id_akdd_posisi_keuangan SET DEFAULT nextval('akdd_posisi_keuangan_id_akdd_posisi_keuangan_seq'::regclass);


--
-- TOC entry 2043 (class 2604 OID 22628)
-- Dependencies: 166 165
-- Name: id_akmt_buku_besar; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akmt_buku_besar ALTER COLUMN id_akmt_buku_besar SET DEFAULT nextval('akmt_buku_besar_id_akmt_buku_besar_seq'::regclass);


--
-- TOC entry 2045 (class 2604 OID 22629)
-- Dependencies: 171 169
-- Name: id_akmt_jurnal; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akmt_jurnal ALTER COLUMN id_akmt_jurnal SET DEFAULT nextval('akmt_jurnal_id_akmt_jurnal_seq'::regclass);


--
-- TOC entry 2034 (class 2604 OID 22630)
-- Dependencies: 170 148
-- Name: id_akmt_jurnal_det; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akmt_jurnal_det ALTER COLUMN id_akmt_jurnal_det SET DEFAULT nextval('akmt_jurnal_det_id_akmt_jurnal_det_seq'::regclass);


--
-- TOC entry 2044 (class 2604 OID 22631)
-- Dependencies: 172 167
-- Name: id_akmt_periode; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akmt_periode ALTER COLUMN id_akmt_periode SET DEFAULT nextval('akmt_periode_id_akmt_periode_seq'::regclass);


SET search_path = public, pg_catalog;

--
-- TOC entry 2046 (class 2604 OID 22632)
-- Dependencies: 174 173
-- Name: id_dd_access; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_access ALTER COLUMN id_dd_access SET DEFAULT nextval('dd_access_id_dd_access_seq'::regclass);


--
-- TOC entry 2047 (class 2604 OID 22633)
-- Dependencies: 178 175
-- Name: id_dd_groups; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_groups ALTER COLUMN id_dd_groups SET DEFAULT nextval('dd_groups_id_dd_groups_seq'::regclass);


--
-- TOC entry 2048 (class 2604 OID 22634)
-- Dependencies: 177 176
-- Name: id_dd_groups_detail; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_groups_detail ALTER COLUMN id_dd_groups_detail SET DEFAULT nextval('dd_groups_detail_id_dd_groups_detail_seq'::regclass);


--
-- TOC entry 2049 (class 2604 OID 22635)
-- Dependencies: 180 179
-- Name: id_dd_menus; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_menus ALTER COLUMN id_dd_menus SET DEFAULT nextval('dd_menus_id_dd_menus_seq'::regclass);


--
-- TOC entry 2050 (class 2604 OID 22636)
-- Dependencies: 182 181
-- Name: id_dd_moduls; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_moduls ALTER COLUMN id_dd_moduls SET DEFAULT nextval('dd_moduls_id_dd_moduls_seq'::regclass);


--
-- TOC entry 2051 (class 2604 OID 22637)
-- Dependencies: 184 183
-- Name: id_dd_sub_menus; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_sub_menus ALTER COLUMN id_dd_sub_menus SET DEFAULT nextval('dd_sub_menus_id_dd_sub_menus_seq'::regclass);


--
-- TOC entry 2052 (class 2604 OID 22638)
-- Dependencies: 186 185
-- Name: id_dd_tabs; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_tabs ALTER COLUMN id_dd_tabs SET DEFAULT nextval('dd_tabs_id_dd_tabs_seq'::regclass);


--
-- TOC entry 2053 (class 2604 OID 22639)
-- Dependencies: 188 187
-- Name: id_dd_users; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_users ALTER COLUMN id_dd_users SET DEFAULT nextval('dd_users_id_dd_users_seq'::regclass);


SET search_path = trans, pg_catalog;

--
-- TOC entry 2054 (class 2604 OID 22640)
-- Dependencies: 190 189
-- Name: id_bank; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY bank ALTER COLUMN id_bank SET DEFAULT nextval('bank_id_bank_seq'::regclass);


--
-- TOC entry 2055 (class 2604 OID 22641)
-- Dependencies: 192 191
-- Name: id_jenis_transaksi; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY jenis_transaksi ALTER COLUMN id_jenis_transaksi SET DEFAULT nextval('jenis_transaksi_id_jenis_transaksi_seq'::regclass);


--
-- TOC entry 2059 (class 2604 OID 22642)
-- Dependencies: 199 195
-- Name: id_klasifikasi_penerima; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY klasifikasi_penerima ALTER COLUMN id_klasifikasi_penerima SET DEFAULT nextval('klasifikasi_penerima_id_klasifikasi_penerima_seq'::regclass);


--
-- TOC entry 2063 (class 2604 OID 22643)
-- Dependencies: 201 200
-- Name: id_kode_kas; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY kode_kas ALTER COLUMN id_kode_kas SET DEFAULT nextval('kode_kas_id_kode_kas_seq'::regclass);


--
-- TOC entry 2065 (class 2604 OID 22644)
-- Dependencies: 203 202
-- Name: id_kota; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY kota ALTER COLUMN id_kota SET DEFAULT nextval('kota_id_kota_seq'::regclass);


--
-- TOC entry 2056 (class 2604 OID 22645)
-- Dependencies: 204 193
-- Name: id_mapping_kode_akun; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_kode_akun ALTER COLUMN id_mapping_kode_akun SET DEFAULT nextval('mapping_kode_akun_id_mapping_kode_akun_seq'::regclass);


--
-- TOC entry 2066 (class 2604 OID 22646)
-- Dependencies: 206 205
-- Name: id_mapping_penerima; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_penerima ALTER COLUMN id_mapping_penerima SET DEFAULT nextval('mapping_penerima_id_mapping_penerima_seq'::regclass);


--
-- TOC entry 2067 (class 2604 OID 22647)
-- Dependencies: 208 207
-- Name: id_mapping_rekening; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_rekening ALTER COLUMN id_mapping_rekening SET DEFAULT nextval('mapping_rekening_id_mapping_rekening_seq'::regclass);


--
-- TOC entry 2068 (class 2604 OID 22648)
-- Dependencies: 210 209
-- Name: id_mapping_transaksi_jurnal; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_transaksi_jurnal ALTER COLUMN id_mapping_transaksi_jurnal SET DEFAULT nextval('mapping_transaksi_jurnal_id_mapping_transaksi_jurnal_seq'::regclass);


--
-- TOC entry 2060 (class 2604 OID 22649)
-- Dependencies: 211 196
-- Name: id_mapping_transaksi_penerima; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_transaksi_penerima ALTER COLUMN id_mapping_transaksi_penerima SET DEFAULT nextval('mapping_transaksi_penerima_id_mapping_transaksi_penerima_seq'::regclass);


--
-- TOC entry 2061 (class 2604 OID 22650)
-- Dependencies: 212 197
-- Name: id_pihak_penerima; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY pihak_penerima ALTER COLUMN id_pihak_penerima SET DEFAULT nextval('pihak_penerima_id_pihak_penerima_seq'::regclass);


--
-- TOC entry 2069 (class 2604 OID 22651)
-- Dependencies: 214 213
-- Name: id_propinsi; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY propinsi ALTER COLUMN id_propinsi SET DEFAULT nextval('propinsi_id_propinsi_seq'::regclass);


--
-- TOC entry 2070 (class 2604 OID 22652)
-- Dependencies: 216 215
-- Name: id_rekening_bank; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY rekening_bank ALTER COLUMN id_rekening_bank SET DEFAULT nextval('rekening_bank_id_rekening_bank_seq'::regclass);


--
-- TOC entry 2071 (class 2604 OID 22653)
-- Dependencies: 218 217
-- Name: id_sub_kode_kas; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY sub_kode_kas ALTER COLUMN id_sub_kode_kas SET DEFAULT nextval('sub_kode_kas_id_sub_kode_kas_seq'::regclass);


--
-- TOC entry 2072 (class 2604 OID 22654)
-- Dependencies: 220 219
-- Name: id_sub_transaksi; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY sub_transaksi ALTER COLUMN id_sub_transaksi SET DEFAULT nextval('sub_transaksi_id_sub_transaksi_seq'::regclass);


--
-- TOC entry 2073 (class 2604 OID 22655)
-- Dependencies: 222 221
-- Name: id_transaksi; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY transaksi ALTER COLUMN id_transaksi SET DEFAULT nextval('transaksi_id_transaksi_seq'::regclass);


SET search_path = akun, pg_catalog;

--
-- TOC entry 2258 (class 0 OID 22383)
-- Dependencies: 142
-- Data for Name: akdd_arus_kas; Type: TABLE DATA; Schema: akun; Owner: -
--

COPY akdd_arus_kas (id_akdd_arus_kas, id_akdd_arus_kas_ref, uraian, coa_range, order_number, kalkulasi, kalibrasi) FROM stdin;
\.


--
-- TOC entry 2259 (class 0 OID 22393)
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
-- TOC entry 2262 (class 0 OID 22413)
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
-- TOC entry 2263 (class 0 OID 22418)
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
-- TOC entry 2265 (class 0 OID 22432)
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
-- TOC entry 2266 (class 0 OID 22437)
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
-- TOC entry 2260 (class 0 OID 22396)
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
-- TOC entry 2264 (class 0 OID 22424)
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
-- TOC entry 2267 (class 0 OID 22444)
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
-- TOC entry 2268 (class 0 OID 22452)
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
-- TOC entry 2269 (class 0 OID 22461)
-- Dependencies: 165
-- Data for Name: akmt_buku_besar; Type: TABLE DATA; Schema: akun; Owner: -
--

COPY akmt_buku_besar (id_akmt_buku_besar, id_akmt_periode, id_akdd_detail_coa, no_bukti, tanggal, keterangan, awal, mutasi_debet, mutasi_kredit, akhir) FROM stdin;
1	1	29	Saldo awal 2012	2012-01-01	Saldo awal 2012	5000000	0	0	5000000
2	1	30	Saldo awal 2012	2012-01-01	Saldo awal 2012	125000000	0	0	125000000
3	1	31	Saldo awal 2012	2012-01-01	Saldo awal 2012	500000000	0	0	500000000
4	1	32	Saldo awal 2012	2012-01-01	Saldo awal 2012	214000000	0	0	214000000
5	1	33	Saldo awal 2012	2012-01-01	Saldo awal 2012	0	0	0	0
6	1	34	Saldo awal 2012	2012-01-01	Saldo awal 2012	0	0	0	0
7	1	35	Saldo awal 2012	2012-01-01	Saldo awal 2012	0	0	0	0
8	1	36	Saldo awal 2012	2012-01-01	Saldo awal 2012	0	0	0	0
9	1	37	Saldo awal 2012	2012-01-01	Saldo awal 2012	0	0	0	0
10	1	38	Saldo awal 2012	2012-01-01	Saldo awal 2012	0	0	0	0
11	1	39	Saldo awal 2012	2012-01-01	Saldo awal 2012	0	0	0	0
12	1	40	Saldo awal 2012	2012-01-01	Saldo awal 2012	0	0	0	0
13	1	41	Saldo awal 2012	2012-01-01	Saldo awal 2012	0	0	0	0
14	1	42	Saldo awal 2012	2012-01-01	Saldo awal 2012	0	0	0	0
15	1	43	Saldo awal 2012	2012-01-01	Saldo awal 2012	0	0	0	0
16	1	44	Saldo awal 2012	2012-01-01	Saldo awal 2012	0	0	0	0
17	1	45	Saldo awal 2012	2012-01-01	Saldo awal 2012	0	0	0	0
18	1	46	Saldo awal 2012	2012-01-01	Saldo awal 2012	0	0	0	0
19	1	47	Saldo awal 2012	2012-01-01	Saldo awal 2012	0	0	0	0
20	1	48	Saldo awal 2012	2012-01-01	Saldo awal 2012	0	0	0	0
21	1	49	Saldo awal 2012	2012-01-01	Saldo awal 2012	0	0	0	0
22	1	50	Saldo awal 2012	2012-01-01	Saldo awal 2012	0	0	0	0
23	1	51	Saldo awal 2012	2012-01-01	Saldo awal 2012	0	0	0	0
24	1	52	Saldo awal 2012	2012-01-01	Saldo awal 2012	0	0	0	0
25	1	53	Saldo awal 2012	2012-01-01	Saldo awal 2012	-500000000	0	0	-500000000
26	1	54	Saldo awal 2012	2012-01-01	Saldo awal 2012	0	0	0	0
27	1	55	Saldo awal 2012	2012-01-01	Saldo awal 2012	-344000000	0	0	-344000000
28	1	56	Saldo awal 2012	2012-01-01	Saldo awal 2012	0	0	0	0
29	2	85	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
30	2	29	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	5000000	0	0	5000000
31	2	30	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	125000000	0	0	125000000
32	2	31	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	500000000	0	0	500000000
33	2	32	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	214000000	0	0	214000000
34	2	33	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
35	2	36	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
36	2	34	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
37	2	37	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
38	2	38	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
39	2	39	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
40	2	40	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
41	2	41	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
42	2	42	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
43	2	43	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
44	2	44	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
45	2	45	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
46	2	46	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
47	2	47	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
48	2	48	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
49	2	49	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
50	2	50	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
51	2	51	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
52	2	52	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
53	2	53	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	-500000000	0	0	-500000000
54	2	54	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
55	2	55	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	-344000000	0	0	-344000000
56	2	56	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
57	2	59	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
58	2	60	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
59	2	61	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
60	2	62	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
61	2	63	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
62	2	64	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
63	2	65	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
64	2	66	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
65	2	67	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
66	2	68	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
67	2	69	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
68	2	70	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
69	2	71	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
70	2	72	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
71	2	73	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
72	2	74	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
73	2	75	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
74	2	76	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
75	2	77	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
76	2	78	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
77	2	79	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
78	2	80	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
79	2	81	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
80	2	82	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
81	2	83	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
82	2	84	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
83	2	86	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
84	2	87	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
85	2	88	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
86	2	89	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
87	2	91	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
88	2	92	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
89	2	93	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
90	2	94	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
91	2	95	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
92	2	96	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
93	2	97	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
94	2	98	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
95	2	99	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
96	2	100	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
97	2	101	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
98	2	102	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
99	2	58	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
100	2	90	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
101	2	103	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
102	2	104	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
103	2	105	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
104	2	106	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
105	2	107	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
106	2	108	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
107	2	109	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
108	2	110	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
109	2	111	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
110	2	112	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
111	2	113	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
112	2	35	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
113	2	57	N/A	2012-01-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
114	2	29	JP20120100000001	2012-01-02	Penerimaan kotak amal jum'at.	5000000	125000	0	5125000
115	2	59	JP20120100000001	2012-01-02	Penerimaan kotak amal jum'at.	0	0	125000	-125000
116	2	54	JA20120100000001	2012-01-31	Perhitungan Laba/Rugi atau Kenaikan/Penurunan  - 1/2012	0	0	0	0
117	2	56	JA20120100000002	2012-01-31	Perhitungan Laba/Rugi atau Kenaikan/Penurunan  - 1/2012	0	0	125000	-125000
118	3	85	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
119	3	29	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	5125000	0	0	5125000
120	3	30	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	125000000	0	0	125000000
121	3	31	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	500000000	0	0	500000000
122	3	32	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	214000000	0	0	214000000
123	3	33	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
124	3	36	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
125	3	34	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
126	3	37	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
127	3	38	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
128	3	39	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
129	3	40	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
130	3	41	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
131	3	42	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
132	3	43	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
133	3	44	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
134	3	45	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
135	3	46	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
136	3	47	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
137	3	48	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
138	3	49	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
139	3	50	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
140	3	51	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
141	3	52	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
142	3	53	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	-500000000	0	0	-500000000
143	3	54	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
144	3	55	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	-344000000	0	0	-344000000
145	3	56	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	-125000	0	0	-125000
146	3	59	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	-125000	0	0	-125000
147	3	60	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
148	3	61	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
149	3	62	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
150	3	63	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
151	3	64	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
152	3	65	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
153	3	66	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
154	3	67	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
155	3	68	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
156	3	69	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
157	3	70	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
158	3	71	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
159	3	72	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
160	3	73	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
161	3	74	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
162	3	75	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
163	3	76	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
164	3	77	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
165	3	78	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
166	3	79	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
167	3	80	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
168	3	81	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
169	3	82	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
170	3	83	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
171	3	84	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
172	3	86	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
173	3	87	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
174	3	88	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
175	3	89	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
176	3	91	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
177	3	92	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
178	3	93	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
179	3	94	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
180	3	95	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
181	3	96	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
182	3	97	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
183	3	98	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
184	3	99	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
185	3	100	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
186	3	101	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
187	3	102	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
188	3	58	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
189	3	90	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
190	3	103	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
191	3	104	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
192	3	105	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
193	3	106	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
194	3	107	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
195	3	108	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
196	3	109	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
197	3	110	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
198	3	111	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
199	3	112	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
200	3	113	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
201	3	35	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
202	3	57	N/A	2012-02-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
203	3	29	JP20120200000001	2012-02-04	Penerimaan kotak amal besar.	5125000	3500000	0	8625000
204	3	60	JP20120200000001	2012-02-04	Penerimaan kotak amal besar.	0	0	3500000	-3500000
205	3	54	JA20120200000001	2012-02-29	Perhitungan Laba/Rugi atau Kenaikan/Penurunan  - 2/2012	0	0	0	0
206	3	56	JA20120200000002	2012-02-29	Perhitungan Laba/Rugi atau Kenaikan/Penurunan  - 2/2012	-125000	0	3500000	-3625000
207	4	85	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
208	4	29	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	8625000	0	0	8625000
209	4	30	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	125000000	0	0	125000000
210	4	31	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	500000000	0	0	500000000
211	4	32	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	214000000	0	0	214000000
212	4	33	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
213	4	36	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
214	4	34	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
215	4	37	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
216	4	38	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
217	4	39	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
218	4	40	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
219	4	41	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
220	4	42	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
221	4	43	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
222	4	44	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
223	4	45	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
224	4	46	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
225	4	47	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
226	4	48	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
227	4	49	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
228	4	50	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
229	4	51	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
230	4	52	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
231	4	53	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	-500000000	0	0	-500000000
232	4	54	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
233	4	55	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	-344000000	0	0	-344000000
234	4	56	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	-3625000	0	0	-3625000
235	4	59	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	-125000	0	0	-125000
236	4	60	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	-3500000	0	0	-3500000
237	4	61	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
238	4	62	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
239	4	63	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
240	4	64	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
241	4	65	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
242	4	66	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
243	4	67	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
244	4	68	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
245	4	69	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
246	4	70	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
247	4	71	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
248	4	72	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
249	4	73	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
250	4	74	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
251	4	75	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
252	4	76	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
253	4	77	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
254	4	78	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
255	4	79	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
256	4	80	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
257	4	81	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
258	4	82	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
259	4	83	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
260	4	84	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
261	4	86	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
262	4	87	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
263	4	88	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
264	4	89	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
265	4	91	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
266	4	92	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
267	4	93	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
268	4	94	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
269	4	95	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
270	4	96	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
271	4	97	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
272	4	98	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
273	4	99	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
274	4	100	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
275	4	101	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
276	4	102	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
277	4	58	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
278	4	90	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
279	4	103	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
280	4	104	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
281	4	105	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
282	4	106	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
283	4	107	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
284	4	108	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
285	4	109	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
286	4	110	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
287	4	111	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
288	4	112	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
289	4	113	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
290	4	35	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
291	4	57	N/A	2012-03-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
292	4	29	JP20120300000001	2012-03-10	Penerimaan kotak amal jum'at.	8625000	900000	0	9525000
293	4	59	JP20120300000001	2012-03-10	Penerimaan kotak amal jum'at.	-125000	0	900000	-1025000
294	4	54	JA20120300000001	2012-03-31	Perhitungan Laba/Rugi atau Kenaikan/Penurunan  - 3/2012	0	0	0	0
295	4	56	JA20120300000002	2012-03-31	Perhitungan Laba/Rugi atau Kenaikan/Penurunan  - 3/2012	-3625000	0	900000	-4525000
296	5	85	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
297	5	29	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	9525000	0	0	9525000
298	5	30	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	125000000	0	0	125000000
299	5	31	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	500000000	0	0	500000000
300	5	32	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	214000000	0	0	214000000
301	5	33	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
302	5	36	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
303	5	34	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
304	5	37	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
305	5	38	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
306	5	39	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
307	5	40	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
308	5	41	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
309	5	42	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
310	5	43	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
311	5	44	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
312	5	45	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
313	5	46	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
314	5	47	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
315	5	48	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
316	5	49	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
317	5	50	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
318	5	51	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
319	5	52	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
320	5	53	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	-500000000	0	0	-500000000
321	5	54	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
322	5	55	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	-344000000	0	0	-344000000
323	5	56	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	-4525000	0	0	-4525000
324	5	59	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	-1025000	0	0	-1025000
325	5	60	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	-3500000	0	0	-3500000
326	5	61	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
327	5	62	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
328	5	63	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
329	5	64	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
330	5	65	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
331	5	66	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
332	5	67	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
333	5	68	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
334	5	69	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
335	5	70	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
336	5	71	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
337	5	72	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
338	5	73	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
339	5	74	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
340	5	75	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
341	5	76	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
342	5	77	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
343	5	78	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
344	5	79	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
345	5	80	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
346	5	81	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
347	5	82	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
348	5	83	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
349	5	84	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
350	5	86	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
351	5	87	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
352	5	88	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
353	5	89	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
354	5	91	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
355	5	92	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
356	5	93	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
357	5	94	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
358	5	95	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
359	5	96	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
360	5	97	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
361	5	98	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
362	5	99	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
363	5	100	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
364	5	101	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
365	5	102	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
366	5	58	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
367	5	90	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
368	5	103	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
369	5	104	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
370	5	105	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
371	5	106	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
372	5	107	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
373	5	108	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
374	5	109	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
375	5	110	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
376	5	111	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
377	5	112	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
378	5	113	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
379	5	35	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
380	5	57	N/A	2012-04-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
381	5	29	JP20120400000001	2012-04-08	Penerimaan kotak amal jum'at.	9525000	3512000	0	13037000
382	5	29	JP20120400000002	2012-04-08	Penerimaan kotak amal besar.	13037000	3010050	0	16047050
383	5	29	JP20120400000003	2012-04-08	Terima duit lebih dari masjid (founded).	16047050	10000	0	16057050
384	5	29	JB20120400000001	2012-04-14	Pembayaran tenaga pemasangan mic & mimbar.	16057050	0	325000	15732050
385	5	29	JB20120400000002	2012-04-14	Pembayaran kegiatan Jum'at.	15732050	0	1250000	14482050
386	5	29	JB20120400000003	2012-04-14	Bayar honor ustadz.	14482050	0	415000	14067050
387	5	29	JU20120400000001	2012-04-14	Pindah bank  ke kas.	14067050	1250000	0	15317050
388	5	30	JU20120400000001	2012-04-14	Pindah bank  ke kas.	125000000	0	1250000	123750000
389	5	49	JB20120400000001	2012-04-14	Pembayaran tenaga pemasangan mic & mimbar.	0	0	25000	-25000
390	5	49	JB20120400000003	2012-04-14	Bayar honor ustadz.	-25000	0	35000	-60000
391	5	59	JP20120400000001	2012-04-08	Penerimaan kotak amal jum'at.	-1025000	0	3512000	-4537000
392	5	60	JP20120400000002	2012-04-08	Penerimaan kotak amal besar.	-3500000	0	3010050	-6510050
393	5	69	JP20120400000003	2012-04-08	Terima duit lebih dari masjid (founded).	0	0	10000	-10000
394	5	75	JB20120400000002	2012-04-14	Pembayaran kegiatan Jum'at.	0	1250000	0	1250000
395	5	78	JB20120400000001	2012-04-14	Pembayaran tenaga pemasangan mic & mimbar.	0	350000	0	350000
396	5	78	JB20120400000003	2012-04-14	Bayar honor ustadz.	350000	450000	0	800000
397	5	54	JA20120400000001	2012-04-30	Perhitungan Laba/Rugi atau Kenaikan/Penurunan  - 4/2012	0	0	0	0
398	5	56	JA20120400000002	2012-04-30	Perhitungan Laba/Rugi atau Kenaikan/Penurunan  - 4/2012	-4525000	0	4482050	-9007050
399	6	85	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
400	6	29	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	15317050	0	0	15317050
401	6	30	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	123750000	0	0	123750000
402	6	31	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	500000000	0	0	500000000
403	6	32	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	214000000	0	0	214000000
404	6	33	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
405	6	36	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
406	6	34	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
407	6	37	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
408	6	38	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
409	6	39	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
410	6	40	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
411	6	41	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
412	6	42	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
413	6	43	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
414	6	44	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
415	6	45	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
416	6	46	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
417	6	47	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
418	6	48	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
419	6	49	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	-60000	0	0	-60000
420	6	50	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
421	6	51	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
422	6	52	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
423	6	53	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	-500000000	0	0	-500000000
424	6	54	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
425	6	55	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	-344000000	0	0	-344000000
426	6	56	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	-9007050	0	0	-9007050
427	6	59	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	-4537000	0	0	-4537000
428	6	60	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	-6510050	0	0	-6510050
429	6	61	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
430	6	62	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
431	6	63	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
432	6	64	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
433	6	65	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
434	6	66	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
435	6	67	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
436	6	68	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
437	6	69	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	-10000	0	0	-10000
438	6	70	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
439	6	71	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
440	6	72	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
441	6	73	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
442	6	74	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
443	6	75	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	1250000	0	0	1250000
444	6	76	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
445	6	77	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
446	6	78	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	800000	0	0	800000
447	6	79	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
448	6	80	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
449	6	81	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
450	6	82	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
451	6	83	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
452	6	84	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
453	6	86	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
454	6	87	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
455	6	88	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
456	6	89	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
457	6	91	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
458	6	92	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
459	6	93	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
460	6	94	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
461	6	95	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
462	6	96	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
463	6	97	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
464	6	98	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
465	6	99	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
466	6	100	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
467	6	101	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
468	6	102	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
469	6	58	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
470	6	90	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
471	6	103	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
472	6	104	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
473	6	105	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
474	6	106	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
475	6	107	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
476	6	108	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
477	6	109	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
478	6	110	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
479	6	111	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
480	6	112	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
481	6	113	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
482	6	35	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
483	6	57	N/A	2012-05-01	Pindahan Saldo Dari Bulan Sebelumnya	0	0	0	0
484	6	54	JA20120500000001	2012-05-31	Perhitungan Laba/Rugi atau Kenaikan/Penurunan  - 5/2012	0	0	0	0
485	6	56	JA20120500000002	2012-05-31	Perhitungan Laba/Rugi atau Kenaikan/Penurunan  - 5/2012	-9007050	0	0	-9007050
\.


--
-- TOC entry 2271 (class 0 OID 22474)
-- Dependencies: 169
-- Data for Name: akmt_jurnal; Type: TABLE DATA; Schema: akun; Owner: -
--

COPY akmt_jurnal (id_akmt_jurnal, flag_jurnal, flag_temp, flag_posting, no_bukti, tanggal, keterangan) FROM stdin;
16	1	1	0	JB20120500000001	2012-05-12	Honor ustadz
17	1	1	0	JB20120500000002	2012-05-12	Honor ustadz 2
13	1	2	1	JP20120100000001	2012-01-02	Penerimaan kotak amal jum'at.
14	1	2	1	JP20120200000001	2012-02-04	Penerimaan kotak amal besar.
15	1	2	1	JP20120300000001	2012-03-10	Penerimaan kotak amal jum'at.
8	0	2	1	JP20120400000003	2012-04-08	Terima duit lebih dari masjid (founded).
12	0	2	1	JU20120400000001	2012-04-14	Pindah bank  ke kas.
6	1	2	1	JP20120400000001	2012-04-08	Penerimaan kotak amal jum'at.
7	1	2	1	JP20120400000002	2012-04-08	Penerimaan kotak amal besar.
9	1	2	1	JB20120400000001	2012-04-14	Pembayaran tenaga pemasangan mic & mimbar.
11	1	2	1	JB20120400000003	2012-04-14	Bayar honor ustadz.
10	1	2	1	JB20120400000002	2012-04-14	Pembayaran kegiatan Jum'at.
\.


--
-- TOC entry 2261 (class 0 OID 22405)
-- Dependencies: 148
-- Data for Name: akmt_jurnal_det; Type: TABLE DATA; Schema: akun; Owner: -
--

COPY akmt_jurnal_det (id_akmt_jurnal_det, id_akmt_jurnal, id_akdd_detail_coa, flag_position, jumlah) FROM stdin;
5	6	29	d	3512000
6	6	59	k	3512000
7	7	29	d	3010050
8	7	60	k	3010050
9	8	29	d	10000
10	8	69	k	10000
14	10	75	d	1250000
15	10	29	k	1250000
11	9	49	k	25000
12	9	78	d	350000
13	9	29	k	325000
16	11	49	k	35000
17	11	78	d	450000
18	11	29	k	415000
19	12	29	d	1250000
20	12	30	k	1250000
21	13	29	d	125000
22	13	59	k	125000
23	14	29	d	3500000
24	14	60	k	3500000
25	15	29	d	900000
26	15	59	k	900000
27	16	49	k	12000
28	16	78	d	400000
29	16	29	k	388000
30	17	49	k	12000
31	17	78	d	412000
32	17	29	k	400000
\.


--
-- TOC entry 2270 (class 0 OID 22466)
-- Dependencies: 167
-- Data for Name: akmt_periode; Type: TABLE DATA; Schema: akun; Owner: -
--

COPY akmt_periode (id_akmt_periode, flag_temp, tahun, bulan, uraian) FROM stdin;
1	2	2012	0	Saldo awal 2012
2	1	2012	1	Tutup Buku Periode 1/2012
3	1	2012	2	Tutup Buku Periode 2/2012
4	1	2012	3	Tutup Buku Periode 3/2012
5	1	2012	4	Tutup Buku Periode 4/2012
6	1	2012	5	Tutup Buku Periode 5/2012
\.


SET search_path = public, pg_catalog;

--
-- TOC entry 2272 (class 0 OID 22483)
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
-- TOC entry 2273 (class 0 OID 22488)
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
-- TOC entry 2274 (class 0 OID 22491)
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
111	1	10	31
112	1	11	31
113	1	12	31
114	1	19	31
115	1	16	31
116	1	17	31
117	1	18	31
118	1	20	31
119	1	13	31
120	1	14	31
121	1	34	31
122	1	15	31
123	1	30	31
124	1	31	31
125	1	32	31
126	1	33	31
127	1	36	31
128	1	35	31
129	1	37	31
130	1	38	31
131	1	39	31
132	1	40	31
133	1	41	31
134	1	42	16
135	1	43	16
136	1	44	16
137	1	45	16
84	2	8	31
85	2	10	31
86	2	11	31
87	2	12	31
88	2	19	31
89	2	16	31
90	2	17	31
91	2	18	31
92	2	13	31
93	2	14	31
94	2	15	31
\.


--
-- TOC entry 2275 (class 0 OID 22498)
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
-- TOC entry 2276 (class 0 OID 22503)
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
-- TOC entry 2277 (class 0 OID 22508)
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
-- TOC entry 2278 (class 0 OID 22513)
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
-- TOC entry 2279 (class 0 OID 22518)
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
-- TOC entry 2280 (class 0 OID 22523)
-- Dependencies: 189
-- Data for Name: bank; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY bank (id_bank, id_kota, id_dd_users, nama, keterangan) FROM stdin;
6	7	1	MANDIRI, PT	
7	7	1	BRI, PT	
\.


--
-- TOC entry 2281 (class 0 OID 22528)
-- Dependencies: 191
-- Data for Name: jenis_transaksi; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY jenis_transaksi (id_jenis_transaksi, id_sub_kode_kas, id_dd_users, transaksi, keterangan) FROM stdin;
2	9	1	Pembayaran Honor Kajian Tafsir & Hadits Ustadz	\N
1	3	1	Penerimaan Kotak Amal Besar	\N
5	5	1	Operasional Shalat Jum'at	\N
6	1	1	Penerimaan Kotak Amal Jum'at	\N
7	9	1	Pembayaran Honor 2	\N
\.


--
-- TOC entry 2283 (class 0 OID 22542)
-- Dependencies: 195
-- Data for Name: klasifikasi_penerima; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY klasifikasi_penerima (id_klasifikasi_penerima, id_dd_users, klasifikasi, keterangan) FROM stdin;
1	1	Karyawan	Karyawan Yayasan
2	1	Ustadz	Ustadz
3	1	Guru TPA	\N
\.


--
-- TOC entry 2286 (class 0 OID 22560)
-- Dependencies: 200
-- Data for Name: kode_kas; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY kode_kas (id_kode_kas, id_dd_users, flag_in_out, kode, kas, keterangan) FROM stdin;
2	1	o	B	Shalat Jum'at	Biaya operasional pelaksanaan shalat jum'at.
1	1	i	A	Penerimaan Kas	\N
4	1	o	C	Kajian	\N
\.


--
-- TOC entry 2287 (class 0 OID 22567)
-- Dependencies: 202
-- Data for Name: kota; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY kota (id_kota, id_propinsi, id_dd_users, nama, keterangan) FROM stdin;
2	3	2	Jakarta Selatan	
3	4	2	Bandung	
4	3	1	Jakarta Utara	
5	3	1	Jakarta Barat	
6	3	1	Jakarta Timur	
7	3	1	Jakarta Pusat	
\.


--
-- TOC entry 2282 (class 0 OID 22533)
-- Dependencies: 193
-- Data for Name: mapping_kode_akun; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY mapping_kode_akun (id_mapping_kode_akun, id_jenis_transaksi, id_akdd_detail_coa, id_dd_users, flag_debet_kredit, flag_pajak) FROM stdin;
1	1	29	1	1	1
2	1	60	1	2	1
3	2	78	1	1	1
4	2	29	1	2	1
5	2	49	1	2	2
9	6	29	1	1	1
10	6	59	1	2	1
11	5	75	1	1	1
12	5	29	1	2	1
13	7	78	1	1	1
14	7	29	1	2	1
15	7	49	1	2	2
\.


--
-- TOC entry 2288 (class 0 OID 22574)
-- Dependencies: 205
-- Data for Name: mapping_penerima; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY mapping_penerima (id_mapping_penerima, id_transaksi, id_pihak_penerima, id_dd_users) FROM stdin;
4	11	4	1
5	15	3	1
6	16	4	1
\.


--
-- TOC entry 2289 (class 0 OID 22579)
-- Dependencies: 207
-- Data for Name: mapping_rekening; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY mapping_rekening (id_mapping_rekening, id_mapping_kode_akun, id_rekening_bank, id_dd_users) FROM stdin;
\.


--
-- TOC entry 2290 (class 0 OID 22584)
-- Dependencies: 209
-- Data for Name: mapping_transaksi_jurnal; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY mapping_transaksi_jurnal (id_mapping_transaksi_jurnal, id_transaksi, id_akmt_jurnal, id_dd_users) FROM stdin;
2	7	6	1
3	8	7	1
4	9	9	1
5	10	10	1
6	11	11	1
7	12	13	1
8	13	14	1
9	14	15	1
10	15	16	1
11	16	17	1
\.


--
-- TOC entry 2284 (class 0 OID 22545)
-- Dependencies: 196
-- Data for Name: mapping_transaksi_penerima; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY mapping_transaksi_penerima (id_mapping_transaksi_penerima, id_jenis_transaksi, id_klasifikasi_penerima, id_dd_users) FROM stdin;
1	2	2	1
4	7	2	1
\.


--
-- TOC entry 2285 (class 0 OID 22548)
-- Dependencies: 197
-- Data for Name: pihak_penerima; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY pihak_penerima (id_pihak_penerima, id_dd_users, id_klasifikasi_penerima, nama, alamat, keterangan) FROM stdin;
3	1	2	Amir Samsudin	Jl. Petojo Selatan, Jakarta Barat.	\N
4	1	2	Rudy Kurniawan, Msc	Jl. Kuningan Utara, Jakarta Selatan.	\N
6	1	3	Donny Kumara	\N	\N
7	1	3	Deden Sihabuddin	\N	\N
1	1	1	Rahmat Hidayat	Jl. Pedongkelan II	Karyawan LAZIS.
\.


--
-- TOC entry 2291 (class 0 OID 22593)
-- Dependencies: 213
-- Data for Name: propinsi; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY propinsi (id_propinsi, id_dd_users, nama, keterangan) FROM stdin;
3	2	DKI Jakarta	
4	2	Jawa Barat	
\.


--
-- TOC entry 2292 (class 0 OID 22598)
-- Dependencies: 215
-- Data for Name: rekening_bank; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY rekening_bank (id_rekening_bank, id_bank, id_dd_users, no_rekening, keterangan) FROM stdin;
1	7	1	BRI.09 08 88 99 98 88 77 77	\N
2	6	1	MDR - 09 08 07 77 66 AA BB	\N
\.


--
-- TOC entry 2293 (class 0 OID 22603)
-- Dependencies: 217
-- Data for Name: sub_kode_kas; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY sub_kode_kas (id_sub_kode_kas, id_kode_kas, id_dd_users, kode, sub_kas, keterangan) FROM stdin;
1	1	1	1	Kotak Jum'at	\N
3	1	1	2	Kotak Amal Besar	\N
5	2	1	1	Pelaksanaan Shalat Jum'at	\N
6	4	1	1	Pesantren Liburan	\N
7	4	1	2	Kajian Ibu-ibu Sungai Bambu	\N
8	4	1	3	Kajian Syari'ah	Kajian Selasa Siang
9	4	1	4	Kajian Tafsir & Hadits	Rabu Siang
\.


--
-- TOC entry 2294 (class 0 OID 22608)
-- Dependencies: 219
-- Data for Name: sub_transaksi; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY sub_transaksi (id_sub_transaksi, id_transaksi, id_mapping_kode_akun, id_dd_users, nominal) FROM stdin;
12	7	9	1	3512000.00
13	7	10	1	3512000.00
14	8	1	1	3010050.00
15	8	2	1	3010050.00
19	10	11	1	1250000.00
20	10	12	1	1250000.00
16	9	5	1	25000.00
17	9	3	1	350000.00
18	9	4	1	325000.00
21	11	5	1	35000.00
22	11	3	1	450000.00
23	11	4	1	415000.00
24	12	9	1	125000.00
25	12	10	1	125000.00
26	13	1	1	3500000.00
27	13	2	1	3500000.00
28	14	9	1	900000.00
29	14	10	1	900000.00
30	15	5	1	12000.00
31	15	3	1	400000.00
32	15	4	1	388000.00
33	16	15	1	12000.00
34	16	13	1	412000.00
35	16	14	1	400000.00
\.


--
-- TOC entry 2295 (class 0 OID 22613)
-- Dependencies: 221
-- Data for Name: transaksi; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY transaksi (id_transaksi, id_dd_users, tanggal, no_bukti, petugas, keterangan) FROM stdin;
7	1	2012-04-08	JP20120400000001	Dodo	Penerimaan kotak amal jum'at.
8	1	2012-04-08	JP20120400000002	Doni	Penerimaan kotak amal besar.
10	1	2012-04-14	JB20120400000002	Dede	Pembayaran kegiatan Jum'at.
9	1	2012-04-14	JB20120400000001	Sandhi Widya	Pembayaran tenaga pemasangan mic & mimbar.
11	1	2012-04-14	JB20120400000003	Reno	Bayar honor ustadz.
12	1	2012-01-02	JP20120100000001	Dani	Penerimaan kotak amal jum'at.
13	1	2012-02-04	JP20120200000001	Santi	Penerimaan kotak amal besar.
14	1	2012-03-10	JP20120300000001	Santi	Penerimaan kotak amal jum'at.
15	1	2012-05-12	JB20120500000001	Hadi	Honor ustadz
16	1	2012-05-12	JB20120500000002	Heri	Honor ustadz 2
\.


SET search_path = akun, pg_catalog;

--
-- TOC entry 2091 (class 2606 OID 22657)
-- Dependencies: 152 152
-- Name: akdd_detail_coa_map_pkey; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_detail_coa_map
    ADD CONSTRAINT akdd_detail_coa_map_pkey PRIMARY KEY (id_akdd_detail_coa_map);


--
-- TOC entry 2076 (class 2606 OID 22659)
-- Dependencies: 142 142
-- Name: pk_akdd_arus_kas; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_arus_kas
    ADD CONSTRAINT pk_akdd_arus_kas PRIMARY KEY (id_akdd_arus_kas);


--
-- TOC entry 2079 (class 2606 OID 22661)
-- Dependencies: 144 144
-- Name: pk_akdd_detail_coa; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_detail_coa
    ADD CONSTRAINT pk_akdd_detail_coa PRIMARY KEY (id_akdd_detail_coa);


--
-- TOC entry 2085 (class 2606 OID 22663)
-- Dependencies: 150 150
-- Name: pk_akdd_detail_coa_lr; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_detail_coa_lr
    ADD CONSTRAINT pk_akdd_detail_coa_lr PRIMARY KEY (id_akdd_detail_coa_lr);


--
-- TOC entry 2095 (class 2606 OID 22665)
-- Dependencies: 156 156
-- Name: pk_akdd_klasifikasi_modal; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_klasifikasi_modal
    ADD CONSTRAINT pk_akdd_klasifikasi_modal PRIMARY KEY (id_akdd_klasifikasi_modal);


--
-- TOC entry 2097 (class 2606 OID 22667)
-- Dependencies: 158 158
-- Name: pk_akdd_kodifikasi_jurnal; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_kodifikasi_jurnal
    ADD CONSTRAINT pk_akdd_kodifikasi_jurnal PRIMARY KEY (id_akdd_kodifikasi_jurnal);


--
-- TOC entry 2081 (class 2606 OID 22669)
-- Dependencies: 145 145
-- Name: pk_akdd_level_coa; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_level_coa
    ADD CONSTRAINT pk_akdd_level_coa PRIMARY KEY (id_akdd_level_coa);


--
-- TOC entry 2093 (class 2606 OID 22671)
-- Dependencies: 154 154
-- Name: pk_akdd_main_coa; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_main_coa
    ADD CONSTRAINT pk_akdd_main_coa PRIMARY KEY (id_akdd_main_coa);


--
-- TOC entry 2101 (class 2606 OID 22673)
-- Dependencies: 161 161
-- Name: pk_akdd_perubahan_dana; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_perubahan_dana
    ADD CONSTRAINT pk_akdd_perubahan_dana PRIMARY KEY (id_akdd_perubahan_dana);


--
-- TOC entry 2103 (class 2606 OID 22675)
-- Dependencies: 163 163
-- Name: pk_akdd_posisi_keuangan; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_posisi_keuangan
    ADD CONSTRAINT pk_akdd_posisi_keuangan PRIMARY KEY (id_akdd_posisi_keuangan);


--
-- TOC entry 2105 (class 2606 OID 22677)
-- Dependencies: 165 165
-- Name: pk_akmt_buku_besar; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akmt_buku_besar
    ADD CONSTRAINT pk_akmt_buku_besar PRIMARY KEY (id_akmt_buku_besar);


--
-- TOC entry 2112 (class 2606 OID 22679)
-- Dependencies: 169 169
-- Name: pk_akmt_jurnal; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akmt_jurnal
    ADD CONSTRAINT pk_akmt_jurnal PRIMARY KEY (id_akmt_jurnal);


--
-- TOC entry 2083 (class 2606 OID 22681)
-- Dependencies: 148 148
-- Name: pk_akmt_jurnal_det; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akmt_jurnal_det
    ADD CONSTRAINT pk_akmt_jurnal_det PRIMARY KEY (id_akmt_jurnal_det);


--
-- TOC entry 2107 (class 2606 OID 22683)
-- Dependencies: 167 167
-- Name: pk_akmt_periode; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akmt_periode
    ADD CONSTRAINT pk_akmt_periode PRIMARY KEY (id_akmt_periode);


--
-- TOC entry 2109 (class 2606 OID 22685)
-- Dependencies: 167 167 167
-- Name: unique_akmt_periode; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akmt_periode
    ADD CONSTRAINT unique_akmt_periode UNIQUE (tahun, bulan);


--
-- TOC entry 2087 (class 2606 OID 22687)
-- Dependencies: 150 150
-- Name: unique_detail_coa; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_detail_coa_lr
    ADD CONSTRAINT unique_detail_coa UNIQUE (id_akdd_detail_coa);


--
-- TOC entry 2089 (class 2606 OID 22689)
-- Dependencies: 150 150
-- Name: unique_klasifikasi_modal; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_detail_coa_lr
    ADD CONSTRAINT unique_klasifikasi_modal UNIQUE (id_akdd_klasifikasi_modal);


--
-- TOC entry 2099 (class 2606 OID 22691)
-- Dependencies: 158 158
-- Name: unique_kodifikasi_jurnal; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_kodifikasi_jurnal
    ADD CONSTRAINT unique_kodifikasi_jurnal UNIQUE (kode);


SET search_path = public, pg_catalog;

--
-- TOC entry 2114 (class 2606 OID 22693)
-- Dependencies: 173 173
-- Name: pk_dd_access; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_access
    ADD CONSTRAINT pk_dd_access PRIMARY KEY (id_dd_access);


--
-- TOC entry 2120 (class 2606 OID 22695)
-- Dependencies: 175 175
-- Name: pk_dd_groups; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_groups
    ADD CONSTRAINT pk_dd_groups PRIMARY KEY (id_dd_groups);


--
-- TOC entry 2126 (class 2606 OID 22697)
-- Dependencies: 179 179
-- Name: pk_dd_menus; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_menus
    ADD CONSTRAINT pk_dd_menus PRIMARY KEY (id_dd_menus);


--
-- TOC entry 2132 (class 2606 OID 22699)
-- Dependencies: 181 181
-- Name: pk_dd_moduls; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_moduls
    ADD CONSTRAINT pk_dd_moduls PRIMARY KEY (id_dd_moduls);


--
-- TOC entry 2138 (class 2606 OID 22701)
-- Dependencies: 183 183
-- Name: pk_dd_sub_menus; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_sub_menus
    ADD CONSTRAINT pk_dd_sub_menus PRIMARY KEY (id_dd_sub_menus);


--
-- TOC entry 2144 (class 2606 OID 22703)
-- Dependencies: 185 185
-- Name: pk_dd_tabs; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_tabs
    ADD CONSTRAINT pk_dd_tabs PRIMARY KEY (id_dd_tabs);


--
-- TOC entry 2150 (class 2606 OID 22705)
-- Dependencies: 187 187
-- Name: pk_dd_users; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_users
    ADD CONSTRAINT pk_dd_users PRIMARY KEY (id_dd_users);


--
-- TOC entry 2124 (class 2606 OID 22707)
-- Dependencies: 176 176
-- Name: pk_groups_detail; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_groups_detail
    ADD CONSTRAINT pk_groups_detail PRIMARY KEY (id_dd_groups_detail);


--
-- TOC entry 2116 (class 2606 OID 22709)
-- Dependencies: 173 173
-- Name: unique2_access; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_access
    ADD CONSTRAINT unique2_access UNIQUE (access_code);


--
-- TOC entry 2128 (class 2606 OID 22711)
-- Dependencies: 179 179 179 179
-- Name: unique2_menus; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_menus
    ADD CONSTRAINT unique2_menus UNIQUE (id_dd_moduls, menu, order_number);


--
-- TOC entry 2134 (class 2606 OID 22713)
-- Dependencies: 181 181
-- Name: unique2_moduls; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_moduls
    ADD CONSTRAINT unique2_moduls UNIQUE (order_number);


--
-- TOC entry 2140 (class 2606 OID 22715)
-- Dependencies: 183 183 183 183
-- Name: unique2_sub_menus; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_sub_menus
    ADD CONSTRAINT unique2_sub_menus UNIQUE (id_dd_menus, sub_menu, order_number);


--
-- TOC entry 2146 (class 2606 OID 22717)
-- Dependencies: 185 185
-- Name: unique2_tabs; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_tabs
    ADD CONSTRAINT unique2_tabs UNIQUE (url);


--
-- TOC entry 2118 (class 2606 OID 22719)
-- Dependencies: 173 173
-- Name: unique_access; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_access
    ADD CONSTRAINT unique_access UNIQUE (access_name);


--
-- TOC entry 2152 (class 2606 OID 22721)
-- Dependencies: 187 187
-- Name: unique_dd_users; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_users
    ADD CONSTRAINT unique_dd_users UNIQUE (username);


--
-- TOC entry 2122 (class 2606 OID 22723)
-- Dependencies: 175 175
-- Name: unique_groups; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_groups
    ADD CONSTRAINT unique_groups UNIQUE (group_name);


--
-- TOC entry 2130 (class 2606 OID 22725)
-- Dependencies: 179 179 179
-- Name: unique_menus; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_menus
    ADD CONSTRAINT unique_menus UNIQUE (id_dd_moduls, menu);


--
-- TOC entry 2136 (class 2606 OID 22727)
-- Dependencies: 181 181
-- Name: unique_moduls; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_moduls
    ADD CONSTRAINT unique_moduls UNIQUE (modul);


--
-- TOC entry 2142 (class 2606 OID 22729)
-- Dependencies: 183 183 183
-- Name: unique_sub_menus; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_sub_menus
    ADD CONSTRAINT unique_sub_menus UNIQUE (id_dd_menus, sub_menu);


--
-- TOC entry 2148 (class 2606 OID 22731)
-- Dependencies: 185 185 185
-- Name: unique_tabs; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_tabs
    ADD CONSTRAINT unique_tabs UNIQUE (id_dd_sub_menus, tab);


SET search_path = trans, pg_catalog;

--
-- TOC entry 2154 (class 2606 OID 22733)
-- Dependencies: 189 189
-- Name: pk_bank; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY bank
    ADD CONSTRAINT pk_bank PRIMARY KEY (id_bank);


--
-- TOC entry 2158 (class 2606 OID 22735)
-- Dependencies: 191 191
-- Name: pk_jenis_transaksi; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY jenis_transaksi
    ADD CONSTRAINT pk_jenis_transaksi PRIMARY KEY (id_jenis_transaksi);


--
-- TOC entry 2166 (class 2606 OID 22737)
-- Dependencies: 195 195
-- Name: pk_klasifikasi_penerima; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY klasifikasi_penerima
    ADD CONSTRAINT pk_klasifikasi_penerima PRIMARY KEY (id_klasifikasi_penerima);


--
-- TOC entry 2176 (class 2606 OID 22739)
-- Dependencies: 200 200
-- Name: pk_kode_kas; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY kode_kas
    ADD CONSTRAINT pk_kode_kas PRIMARY KEY (id_kode_kas);


--
-- TOC entry 2182 (class 2606 OID 22741)
-- Dependencies: 202 202
-- Name: pk_kota; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY kota
    ADD CONSTRAINT pk_kota PRIMARY KEY (id_kota);


--
-- TOC entry 2162 (class 2606 OID 22743)
-- Dependencies: 193 193
-- Name: pk_mapping_kode_akun; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mapping_kode_akun
    ADD CONSTRAINT pk_mapping_kode_akun PRIMARY KEY (id_mapping_kode_akun);


--
-- TOC entry 2186 (class 2606 OID 22745)
-- Dependencies: 205 205
-- Name: pk_mapping_penerima; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mapping_penerima
    ADD CONSTRAINT pk_mapping_penerima PRIMARY KEY (id_mapping_penerima);


--
-- TOC entry 2188 (class 2606 OID 22747)
-- Dependencies: 207 207
-- Name: pk_mapping_rekening; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mapping_rekening
    ADD CONSTRAINT pk_mapping_rekening PRIMARY KEY (id_mapping_rekening);


--
-- TOC entry 2190 (class 2606 OID 22749)
-- Dependencies: 209 209
-- Name: pk_mapping_transaksi_jurnal; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mapping_transaksi_jurnal
    ADD CONSTRAINT pk_mapping_transaksi_jurnal PRIMARY KEY (id_mapping_transaksi_jurnal);


--
-- TOC entry 2170 (class 2606 OID 22751)
-- Dependencies: 196 196
-- Name: pk_mapping_transaksi_penerima; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mapping_transaksi_penerima
    ADD CONSTRAINT pk_mapping_transaksi_penerima PRIMARY KEY (id_mapping_transaksi_penerima);


--
-- TOC entry 2172 (class 2606 OID 22753)
-- Dependencies: 197 197
-- Name: pk_pihak_penerima; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pihak_penerima
    ADD CONSTRAINT pk_pihak_penerima PRIMARY KEY (id_pihak_penerima);


--
-- TOC entry 2192 (class 2606 OID 22755)
-- Dependencies: 213 213
-- Name: pk_propinsi; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY propinsi
    ADD CONSTRAINT pk_propinsi PRIMARY KEY (id_propinsi);


--
-- TOC entry 2196 (class 2606 OID 22757)
-- Dependencies: 215 215
-- Name: pk_rekening_bank; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY rekening_bank
    ADD CONSTRAINT pk_rekening_bank PRIMARY KEY (id_rekening_bank);


--
-- TOC entry 2200 (class 2606 OID 22759)
-- Dependencies: 217 217
-- Name: pk_sub_kode_kas; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sub_kode_kas
    ADD CONSTRAINT pk_sub_kode_kas PRIMARY KEY (id_sub_kode_kas);


--
-- TOC entry 2206 (class 2606 OID 22761)
-- Dependencies: 219 219
-- Name: pk_sub_transaksi; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sub_transaksi
    ADD CONSTRAINT pk_sub_transaksi PRIMARY KEY (id_sub_transaksi);


--
-- TOC entry 2208 (class 2606 OID 22763)
-- Dependencies: 221 221
-- Name: pk_transaksi; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY transaksi
    ADD CONSTRAINT pk_transaksi PRIMARY KEY (id_transaksi);


--
-- TOC entry 2164 (class 2606 OID 22765)
-- Dependencies: 193 193 193
-- Name: unique_akdd_detail_coa_jenis_transaksi_mapping_kode_akun; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mapping_kode_akun
    ADD CONSTRAINT unique_akdd_detail_coa_jenis_transaksi_mapping_kode_akun UNIQUE (id_jenis_transaksi, id_akdd_detail_coa);


--
-- TOC entry 2178 (class 2606 OID 22767)
-- Dependencies: 200 200
-- Name: unique_kas_kode_kas; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY kode_kas
    ADD CONSTRAINT unique_kas_kode_kas UNIQUE (kas);


--
-- TOC entry 2168 (class 2606 OID 22769)
-- Dependencies: 195 195
-- Name: unique_klasifikasi_klasifikasi_penerima; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY klasifikasi_penerima
    ADD CONSTRAINT unique_klasifikasi_klasifikasi_penerima UNIQUE (klasifikasi);


--
-- TOC entry 2180 (class 2606 OID 22771)
-- Dependencies: 200 200
-- Name: unique_kode_kode_kas; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY kode_kas
    ADD CONSTRAINT unique_kode_kode_kas UNIQUE (kode);


--
-- TOC entry 2174 (class 2606 OID 22773)
-- Dependencies: 197 197 197
-- Name: unique_nama_alamat_pihak_penerima; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pihak_penerima
    ADD CONSTRAINT unique_nama_alamat_pihak_penerima UNIQUE (nama, alamat);


--
-- TOC entry 2156 (class 2606 OID 22775)
-- Dependencies: 189 189
-- Name: unique_nama_bank; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY bank
    ADD CONSTRAINT unique_nama_bank UNIQUE (nama);


--
-- TOC entry 2184 (class 2606 OID 22778)
-- Dependencies: 202 202
-- Name: unique_nama_kota; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY kota
    ADD CONSTRAINT unique_nama_kota UNIQUE (nama);


--
-- TOC entry 2194 (class 2606 OID 22780)
-- Dependencies: 213 213
-- Name: unique_nama_propinsi; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY propinsi
    ADD CONSTRAINT unique_nama_propinsi UNIQUE (nama);


--
-- TOC entry 2198 (class 2606 OID 22782)
-- Dependencies: 215 215
-- Name: unique_no_rekening_rekening_bank; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY rekening_bank
    ADD CONSTRAINT unique_no_rekening_rekening_bank UNIQUE (no_rekening);


--
-- TOC entry 2202 (class 2606 OID 22784)
-- Dependencies: 217 217 217
-- Name: unique_sub_kas_kode_kas; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sub_kode_kas
    ADD CONSTRAINT unique_sub_kas_kode_kas UNIQUE (id_kode_kas, sub_kas);


--
-- TOC entry 2204 (class 2606 OID 22786)
-- Dependencies: 217 217 217
-- Name: unique_sub_kode_kode_kas; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sub_kode_kas
    ADD CONSTRAINT unique_sub_kode_kode_kas UNIQUE (id_kode_kas, kode);


--
-- TOC entry 2160 (class 2606 OID 22788)
-- Dependencies: 191 191
-- Name: unique_transaksi_jenis_transaksi; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY jenis_transaksi
    ADD CONSTRAINT unique_transaksi_jenis_transaksi UNIQUE (transaksi);


SET search_path = akun, pg_catalog;

--
-- TOC entry 2110 (class 1259 OID 22789)
-- Dependencies: 169
-- Name: index_akmt_jurnal_no_bukti; Type: INDEX; Schema: akun; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_akmt_jurnal_no_bukti ON akmt_jurnal USING btree (no_bukti);


--
-- TOC entry 2077 (class 1259 OID 22790)
-- Dependencies: 144
-- Name: index_coa_number_akdd_detail_coa; Type: INDEX; Schema: akun; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_coa_number_akdd_detail_coa ON akdd_detail_coa USING btree (coa_number);


--
-- TOC entry 2213 (class 2606 OID 22791)
-- Dependencies: 150 144 2078
-- Name: akdd_detail_coa_akdd_detail_coa_lr; Type: FK CONSTRAINT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_detail_coa_lr
    ADD CONSTRAINT akdd_detail_coa_akdd_detail_coa_lr FOREIGN KEY (id_akdd_detail_coa) REFERENCES akdd_detail_coa(id_akdd_detail_coa) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2216 (class 2606 OID 22796)
-- Dependencies: 165 144 2078
-- Name: akdd_detail_coa_akmt_buku_besar; Type: FK CONSTRAINT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akmt_buku_besar
    ADD CONSTRAINT akdd_detail_coa_akmt_buku_besar FOREIGN KEY (id_akdd_detail_coa) REFERENCES akdd_detail_coa(id_akdd_detail_coa) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2211 (class 2606 OID 22801)
-- Dependencies: 2078 148 144
-- Name: akdd_detail_coa_akmt_jurnal_det; Type: FK CONSTRAINT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akmt_jurnal_det
    ADD CONSTRAINT akdd_detail_coa_akmt_jurnal_det FOREIGN KEY (id_akdd_detail_coa) REFERENCES akdd_detail_coa(id_akdd_detail_coa) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2215 (class 2606 OID 22806)
-- Dependencies: 152 144 2078
-- Name: akdd_detail_coa_map_id_akdd_detail_coa_fkey; Type: FK CONSTRAINT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_detail_coa_map
    ADD CONSTRAINT akdd_detail_coa_map_id_akdd_detail_coa_fkey FOREIGN KEY (id_akdd_detail_coa) REFERENCES akdd_detail_coa(id_akdd_detail_coa);


--
-- TOC entry 2214 (class 2606 OID 22811)
-- Dependencies: 2094 156 150
-- Name: akdd_klasifikasi_modal_akdd_detail_coa_lr; Type: FK CONSTRAINT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_detail_coa_lr
    ADD CONSTRAINT akdd_klasifikasi_modal_akdd_detail_coa_lr FOREIGN KEY (id_akdd_klasifikasi_modal) REFERENCES akdd_klasifikasi_modal(id_akdd_klasifikasi_modal) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2209 (class 2606 OID 22816)
-- Dependencies: 144 145 2080
-- Name: akdd_level_coa_akdd_main_coa; Type: FK CONSTRAINT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_detail_coa
    ADD CONSTRAINT akdd_level_coa_akdd_main_coa FOREIGN KEY (id_akdd_level_coa) REFERENCES akdd_level_coa(id_akdd_level_coa) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2210 (class 2606 OID 22821)
-- Dependencies: 144 2092 154
-- Name: akdd_main_coa_akdd_detail_coa; Type: FK CONSTRAINT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_detail_coa
    ADD CONSTRAINT akdd_main_coa_akdd_detail_coa FOREIGN KEY (id_akdd_main_coa) REFERENCES akdd_main_coa(id_akdd_main_coa) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2212 (class 2606 OID 22826)
-- Dependencies: 169 2111 148
-- Name: akmt_jurnal_akmt_jurnal_det; Type: FK CONSTRAINT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akmt_jurnal_det
    ADD CONSTRAINT akmt_jurnal_akmt_jurnal_det FOREIGN KEY (id_akmt_jurnal) REFERENCES akmt_jurnal(id_akmt_jurnal) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2217 (class 2606 OID 22831)
-- Dependencies: 2106 165 167
-- Name: akmt_periode_akmt_buku_besar; Type: FK CONSTRAINT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akmt_buku_besar
    ADD CONSTRAINT akmt_periode_akmt_buku_besar FOREIGN KEY (id_akmt_periode) REFERENCES akmt_periode(id_akmt_periode) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE;


SET search_path = public, pg_catalog;

--
-- TOC entry 2223 (class 2606 OID 22836)
-- Dependencies: 2119 187 175
-- Name: fk_dd_groups; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_users
    ADD CONSTRAINT fk_dd_groups FOREIGN KEY (id_dd_groups) REFERENCES dd_groups(id_dd_groups) ON DELETE CASCADE DEFERRABLE;


--
-- TOC entry 2218 (class 2606 OID 22841)
-- Dependencies: 2119 176 175
-- Name: fk_dd_groups; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_groups_detail
    ADD CONSTRAINT fk_dd_groups FOREIGN KEY (id_dd_groups) REFERENCES dd_groups(id_dd_groups) ON DELETE CASCADE DEFERRABLE;


--
-- TOC entry 2221 (class 2606 OID 22846)
-- Dependencies: 2125 183 179
-- Name: fk_dd_menus; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_sub_menus
    ADD CONSTRAINT fk_dd_menus FOREIGN KEY (id_dd_menus) REFERENCES dd_menus(id_dd_menus) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE;


--
-- TOC entry 2220 (class 2606 OID 22851)
-- Dependencies: 2131 179 181
-- Name: fk_dd_moduls; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_menus
    ADD CONSTRAINT fk_dd_moduls FOREIGN KEY (id_dd_moduls) REFERENCES dd_moduls(id_dd_moduls) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE;


--
-- TOC entry 2222 (class 2606 OID 22856)
-- Dependencies: 185 183 2137
-- Name: fk_dd_sub_menus; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_tabs
    ADD CONSTRAINT fk_dd_sub_menus FOREIGN KEY (id_dd_sub_menus) REFERENCES dd_sub_menus(id_dd_sub_menus) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE;


--
-- TOC entry 2219 (class 2606 OID 22861)
-- Dependencies: 2143 176 185
-- Name: fk_dd_tabs; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_groups_detail
    ADD CONSTRAINT fk_dd_tabs FOREIGN KEY (id_dd_tabs) REFERENCES dd_tabs(id_dd_tabs) ON DELETE CASCADE DEFERRABLE;


SET search_path = trans, pg_catalog;

--
-- TOC entry 2224 (class 2606 OID 22866)
-- Dependencies: 189 2149 187
-- Name: fk_bank_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY bank
    ADD CONSTRAINT fk_bank_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2225 (class 2606 OID 22871)
-- Dependencies: 202 2181 189
-- Name: fk_bank_kota; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY bank
    ADD CONSTRAINT fk_bank_kota FOREIGN KEY (id_kota) REFERENCES kota(id_kota) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2226 (class 2606 OID 22876)
-- Dependencies: 2149 191 187
-- Name: fk_jenis_transaksi_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY jenis_transaksi
    ADD CONSTRAINT fk_jenis_transaksi_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2227 (class 2606 OID 22881)
-- Dependencies: 191 217 2199
-- Name: fk_jenis_transaksi_sub_kode_kas; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY jenis_transaksi
    ADD CONSTRAINT fk_jenis_transaksi_sub_kode_kas FOREIGN KEY (id_sub_kode_kas) REFERENCES sub_kode_kas(id_sub_kode_kas) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2231 (class 2606 OID 22886)
-- Dependencies: 195 187 2149
-- Name: fk_klasifikasi_penerima_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY klasifikasi_penerima
    ADD CONSTRAINT fk_klasifikasi_penerima_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2237 (class 2606 OID 22891)
-- Dependencies: 200 187 2149
-- Name: fk_kode_kas_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY kode_kas
    ADD CONSTRAINT fk_kode_kas_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2238 (class 2606 OID 22896)
-- Dependencies: 202 187 2149
-- Name: fk_kota_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY kota
    ADD CONSTRAINT fk_kota_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2239 (class 2606 OID 22901)
-- Dependencies: 213 202 2191
-- Name: fk_kota_propinsi; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY kota
    ADD CONSTRAINT fk_kota_propinsi FOREIGN KEY (id_propinsi) REFERENCES propinsi(id_propinsi) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2228 (class 2606 OID 22906)
-- Dependencies: 144 193 2078
-- Name: fk_mapping_kode_akun_akdd_detail_coa; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_kode_akun
    ADD CONSTRAINT fk_mapping_kode_akun_akdd_detail_coa FOREIGN KEY (id_akdd_detail_coa) REFERENCES akun.akdd_detail_coa(id_akdd_detail_coa) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2229 (class 2606 OID 22911)
-- Dependencies: 2149 193 187
-- Name: fk_mapping_kode_akun_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_kode_akun
    ADD CONSTRAINT fk_mapping_kode_akun_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2230 (class 2606 OID 22916)
-- Dependencies: 191 193 2157
-- Name: fk_mapping_kode_akun_jenis_transaksi; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_kode_akun
    ADD CONSTRAINT fk_mapping_kode_akun_jenis_transaksi FOREIGN KEY (id_jenis_transaksi) REFERENCES jenis_transaksi(id_jenis_transaksi) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2240 (class 2606 OID 22921)
-- Dependencies: 187 205 2149
-- Name: fk_mapping_penerima_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_penerima
    ADD CONSTRAINT fk_mapping_penerima_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2241 (class 2606 OID 22926)
-- Dependencies: 197 205 2171
-- Name: fk_mapping_penerima_pihak_penerima; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_penerima
    ADD CONSTRAINT fk_mapping_penerima_pihak_penerima FOREIGN KEY (id_pihak_penerima) REFERENCES pihak_penerima(id_pihak_penerima) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2242 (class 2606 OID 22931)
-- Dependencies: 221 205 2207
-- Name: fk_mapping_penerima_transaksi; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_penerima
    ADD CONSTRAINT fk_mapping_penerima_transaksi FOREIGN KEY (id_transaksi) REFERENCES transaksi(id_transaksi) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE;


--
-- TOC entry 2243 (class 2606 OID 22936)
-- Dependencies: 187 207 2149
-- Name: fk_mapping_rekening_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_rekening
    ADD CONSTRAINT fk_mapping_rekening_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2244 (class 2606 OID 22941)
-- Dependencies: 193 207 2161
-- Name: fk_mapping_rekening_mapping_kode_akun; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_rekening
    ADD CONSTRAINT fk_mapping_rekening_mapping_kode_akun FOREIGN KEY (id_mapping_kode_akun) REFERENCES mapping_kode_akun(id_mapping_kode_akun) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2245 (class 2606 OID 22946)
-- Dependencies: 2195 207 215
-- Name: fk_mapping_rekening_rekening_bank; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_rekening
    ADD CONSTRAINT fk_mapping_rekening_rekening_bank FOREIGN KEY (id_rekening_bank) REFERENCES rekening_bank(id_rekening_bank) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2246 (class 2606 OID 22951)
-- Dependencies: 169 2111 209
-- Name: fk_mapping_transaksi_jurnal_akmt_jurnal; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_transaksi_jurnal
    ADD CONSTRAINT fk_mapping_transaksi_jurnal_akmt_jurnal FOREIGN KEY (id_akmt_jurnal) REFERENCES akun.akmt_jurnal(id_akmt_jurnal) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE;


--
-- TOC entry 2247 (class 2606 OID 22956)
-- Dependencies: 209 2149 187
-- Name: fk_mapping_transaksi_jurnal_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_transaksi_jurnal
    ADD CONSTRAINT fk_mapping_transaksi_jurnal_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2248 (class 2606 OID 22961)
-- Dependencies: 221 209 2207
-- Name: fk_mapping_transaksi_jurnal_transaksi; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_transaksi_jurnal
    ADD CONSTRAINT fk_mapping_transaksi_jurnal_transaksi FOREIGN KEY (id_transaksi) REFERENCES transaksi(id_transaksi) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2232 (class 2606 OID 22966)
-- Dependencies: 196 187 2149
-- Name: fk_mapping_transaksi_penerima_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_transaksi_penerima
    ADD CONSTRAINT fk_mapping_transaksi_penerima_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2233 (class 2606 OID 22971)
-- Dependencies: 191 2157 196
-- Name: fk_mapping_transaksi_penerima_jenis_transaksi; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_transaksi_penerima
    ADD CONSTRAINT fk_mapping_transaksi_penerima_jenis_transaksi FOREIGN KEY (id_jenis_transaksi) REFERENCES jenis_transaksi(id_jenis_transaksi) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2234 (class 2606 OID 22976)
-- Dependencies: 2165 196 195
-- Name: fk_mapping_transaksi_penerima_klasifikasi_penerima; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_transaksi_penerima
    ADD CONSTRAINT fk_mapping_transaksi_penerima_klasifikasi_penerima FOREIGN KEY (id_klasifikasi_penerima) REFERENCES klasifikasi_penerima(id_klasifikasi_penerima) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2235 (class 2606 OID 22981)
-- Dependencies: 2149 187 197
-- Name: fk_pihak_penerima_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY pihak_penerima
    ADD CONSTRAINT fk_pihak_penerima_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2236 (class 2606 OID 22986)
-- Dependencies: 2165 195 197
-- Name: fk_pihak_penerima_klasifikasi_penerima; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY pihak_penerima
    ADD CONSTRAINT fk_pihak_penerima_klasifikasi_penerima FOREIGN KEY (id_klasifikasi_penerima) REFERENCES klasifikasi_penerima(id_klasifikasi_penerima) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2249 (class 2606 OID 22991)
-- Dependencies: 2149 213 187
-- Name: fk_propinsi_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY propinsi
    ADD CONSTRAINT fk_propinsi_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2250 (class 2606 OID 22996)
-- Dependencies: 215 2153 189
-- Name: fk_rekening_bank_bank; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY rekening_bank
    ADD CONSTRAINT fk_rekening_bank_bank FOREIGN KEY (id_bank) REFERENCES bank(id_bank) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2251 (class 2606 OID 23001)
-- Dependencies: 187 2149 215
-- Name: fk_rekening_bank_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY rekening_bank
    ADD CONSTRAINT fk_rekening_bank_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2252 (class 2606 OID 23006)
-- Dependencies: 217 200 2175
-- Name: fk_sub_kode_Kas_kode_kas; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY sub_kode_kas
    ADD CONSTRAINT "fk_sub_kode_Kas_kode_kas" FOREIGN KEY (id_kode_kas) REFERENCES kode_kas(id_kode_kas) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2253 (class 2606 OID 23011)
-- Dependencies: 217 2149 187
-- Name: fk_sub_kode_kas_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY sub_kode_kas
    ADD CONSTRAINT fk_sub_kode_kas_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2254 (class 2606 OID 23016)
-- Dependencies: 2149 187 219
-- Name: fk_sub_transaksi_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY sub_transaksi
    ADD CONSTRAINT fk_sub_transaksi_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2255 (class 2606 OID 23021)
-- Dependencies: 219 2161 193
-- Name: fk_sub_transaksi_mapping_kode_akun; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY sub_transaksi
    ADD CONSTRAINT fk_sub_transaksi_mapping_kode_akun FOREIGN KEY (id_mapping_kode_akun) REFERENCES mapping_kode_akun(id_mapping_kode_akun) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2256 (class 2606 OID 23026)
-- Dependencies: 2207 219 221
-- Name: fk_sub_transaksi_transaksi; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY sub_transaksi
    ADD CONSTRAINT fk_sub_transaksi_transaksi FOREIGN KEY (id_transaksi) REFERENCES transaksi(id_transaksi) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2257 (class 2606 OID 23031)
-- Dependencies: 187 2149 221
-- Name: fk_transaksi_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY transaksi
    ADD CONSTRAINT fk_transaksi_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2302 (class 0 OID 0)
-- Dependencies: 8
-- Name: public; Type: ACL; Schema: -; Owner: -
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2012-05-20 17:04:17 WIT

--
-- PostgreSQL database dump complete
--

