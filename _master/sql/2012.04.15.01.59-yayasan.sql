--
-- PostgreSQL database dump
--

-- Started on 2012-04-15 01:59:10 WIT

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 5 (class 2615 OID 30435)
-- Name: akun; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA akun;


--
-- TOC entry 2299 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA akun; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA akun IS 'Skema untuk akuntansi.';


--
-- TOC entry 6 (class 2615 OID 30436)
-- Name: trans; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA trans;


--
-- TOC entry 2302 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA trans; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA trans IS 'Skema untuk transaksi.';


--
-- TOC entry 691 (class 2612 OID 30439)
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: -
--

CREATE PROCEDURAL LANGUAGE plpgsql;


SET search_path = akun, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 142 (class 1259 OID 30440)
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
-- TOC entry 2303 (class 0 OID 0)
-- Dependencies: 142
-- Name: TABLE akdd_arus_kas; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akdd_arus_kas IS 'Tabel yang berfungsi sebagai template laporan arus kas.';


--
-- TOC entry 143 (class 1259 OID 30448)
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
-- TOC entry 2304 (class 0 OID 0)
-- Dependencies: 143
-- Name: akdd_arus_kas_id_akdd_arus_kas_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akdd_arus_kas_id_akdd_arus_kas_seq OWNED BY akdd_arus_kas.id_akdd_arus_kas;


--
-- TOC entry 2305 (class 0 OID 0)
-- Dependencies: 143
-- Name: akdd_arus_kas_id_akdd_arus_kas_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akdd_arus_kas_id_akdd_arus_kas_seq', 1, false);


--
-- TOC entry 144 (class 1259 OID 30450)
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
-- TOC entry 2306 (class 0 OID 0)
-- Dependencies: 144
-- Name: TABLE akdd_detail_coa; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akdd_detail_coa IS 'Data-data detail COA.';


--
-- TOC entry 153 (class 1259 OID 30474)
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
-- TOC entry 2307 (class 0 OID 0)
-- Dependencies: 153
-- Name: TABLE akdd_level_coa; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akdd_level_coa IS 'Data level COA.';


--
-- TOC entry 222 (class 1259 OID 32677)
-- Dependencies: 1836 5
-- Name: akdd_coa_level_detail_v; Type: VIEW; Schema: akun; Owner: -
--

CREATE VIEW akdd_coa_level_detail_v AS
    SELECT a.id_akdd_detail_coa, a.id_akdd_main_coa, a.id_akdd_level_coa, a.id_akdd_detail_coa_ref, a.coa_number, a.uraian FROM (akdd_detail_coa a JOIN (SELECT akdd_level_coa.id_akdd_level_coa FROM akdd_level_coa ORDER BY akdd_level_coa.level_number DESC OFFSET 0 LIMIT 1) b ON ((a.id_akdd_level_coa = b.id_akdd_level_coa)));


--
-- TOC entry 145 (class 1259 OID 30453)
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
-- TOC entry 2308 (class 0 OID 0)
-- Dependencies: 145
-- Name: akdd_detail_coa_id_akdd_detail_coa_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akdd_detail_coa_id_akdd_detail_coa_seq OWNED BY akdd_detail_coa.id_akdd_detail_coa;


--
-- TOC entry 2309 (class 0 OID 0)
-- Dependencies: 145
-- Name: akdd_detail_coa_id_akdd_detail_coa_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akdd_detail_coa_id_akdd_detail_coa_seq', 113, true);


--
-- TOC entry 164 (class 1259 OID 30509)
-- Dependencies: 2043 5
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
-- TOC entry 2310 (class 0 OID 0)
-- Dependencies: 164
-- Name: TABLE akmt_jurnal_det; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akmt_jurnal_det IS 'Data jurnal detail.';


--
-- TOC entry 2311 (class 0 OID 0)
-- Dependencies: 164
-- Name: COLUMN akmt_jurnal_det.flag_position; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON COLUMN akmt_jurnal_det.flag_position IS '
d = Debet
k = Kredit';


--
-- TOC entry 202 (class 1259 OID 32421)
-- Dependencies: 1832 5
-- Name: akdd_detail_coa_jurnal_v; Type: VIEW; Schema: akun; Owner: -
--

CREATE VIEW akdd_detail_coa_jurnal_v AS
    SELECT DISTINCT akmt_jurnal_det.id_akdd_detail_coa FROM akmt_jurnal_det ORDER BY akmt_jurnal_det.id_akdd_detail_coa;


--
-- TOC entry 146 (class 1259 OID 30455)
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
-- TOC entry 2312 (class 0 OID 0)
-- Dependencies: 146
-- Name: TABLE akdd_detail_coa_lr; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akdd_detail_coa_lr IS 'Data-data klasifikasi modal (sistem jurnal penutup automatis).';


--
-- TOC entry 147 (class 1259 OID 30458)
-- Dependencies: 5 146
-- Name: akdd_detail_coa_lr_id_akdd_detail_coa_lr_seq; Type: SEQUENCE; Schema: akun; Owner: -
--

CREATE SEQUENCE akdd_detail_coa_lr_id_akdd_detail_coa_lr_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2313 (class 0 OID 0)
-- Dependencies: 147
-- Name: akdd_detail_coa_lr_id_akdd_detail_coa_lr_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akdd_detail_coa_lr_id_akdd_detail_coa_lr_seq OWNED BY akdd_detail_coa_lr.id_akdd_detail_coa_lr;


--
-- TOC entry 2314 (class 0 OID 0)
-- Dependencies: 147
-- Name: akdd_detail_coa_lr_id_akdd_detail_coa_lr_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akdd_detail_coa_lr_id_akdd_detail_coa_lr_seq', 4, true);


--
-- TOC entry 148 (class 1259 OID 30460)
-- Dependencies: 2033 5
-- Name: akdd_detail_coa_map; Type: TABLE; Schema: akun; Owner: -; Tablespace: 
--

CREATE TABLE akdd_detail_coa_map (
    id_akdd_detail_coa_map integer NOT NULL,
    id_akdd_detail_coa integer NOT NULL,
    flag smallint DEFAULT 0 NOT NULL
);


--
-- TOC entry 2315 (class 0 OID 0)
-- Dependencies: 148
-- Name: TABLE akdd_detail_coa_map; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akdd_detail_coa_map IS 'Tabel mapping coa yg masuk di pemasukan, pengeluaran, dan jurnal umum.';


--
-- TOC entry 2316 (class 0 OID 0)
-- Dependencies: 148
-- Name: COLUMN akdd_detail_coa_map.flag; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON COLUMN akdd_detail_coa_map.flag IS '0: JU
1: JU + JP
2: JU + JB
3: JU + JP + JB';


--
-- TOC entry 149 (class 1259 OID 30464)
-- Dependencies: 148 5
-- Name: akdd_detail_coa_map_id_akdd_detail_coa_map_seq; Type: SEQUENCE; Schema: akun; Owner: -
--

CREATE SEQUENCE akdd_detail_coa_map_id_akdd_detail_coa_map_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2317 (class 0 OID 0)
-- Dependencies: 149
-- Name: akdd_detail_coa_map_id_akdd_detail_coa_map_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akdd_detail_coa_map_id_akdd_detail_coa_map_seq OWNED BY akdd_detail_coa_map.id_akdd_detail_coa_map;


--
-- TOC entry 2318 (class 0 OID 0)
-- Dependencies: 149
-- Name: akdd_detail_coa_map_id_akdd_detail_coa_map_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akdd_detail_coa_map_id_akdd_detail_coa_map_seq', 85, true);


--
-- TOC entry 155 (class 1259 OID 30479)
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
-- TOC entry 2319 (class 0 OID 0)
-- Dependencies: 155
-- Name: TABLE akdd_main_coa; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akdd_main_coa IS 'Data kategori utama COA.';


--
-- TOC entry 201 (class 1259 OID 32416)
-- Dependencies: 1831 5
-- Name: akdd_detail_coa_v; Type: VIEW; Schema: akun; Owner: -
--

CREATE VIEW akdd_detail_coa_v AS
    SELECT a.id_akdd_detail_coa, a.id_akdd_main_coa, a.id_akdd_level_coa, a.id_akdd_detail_coa_ref AS id_akdd_detail_coa_parent, d.id_akdd_detail_coa_ref, a.coa_number, a.uraian, b.acc_type, b.uraian AS uraian_main_coa, c.level_number, c.level_length FROM (((akdd_detail_coa a JOIN akdd_main_coa b ON ((a.id_akdd_main_coa = b.id_akdd_main_coa))) JOIN akdd_level_coa c ON ((a.id_akdd_level_coa = c.id_akdd_level_coa))) LEFT JOIN (SELECT a.id_akdd_detail_coa_ref FROM (akdd_detail_coa a JOIN akdd_level_coa b ON ((a.id_akdd_level_coa = b.id_akdd_level_coa))) WHERE (b.level_number > 1) GROUP BY a.id_akdd_detail_coa_ref) d ON ((a.id_akdd_detail_coa = d.id_akdd_detail_coa_ref)));


--
-- TOC entry 150 (class 1259 OID 30466)
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
-- TOC entry 2320 (class 0 OID 0)
-- Dependencies: 150
-- Name: TABLE akdd_klasifikasi_modal; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akdd_klasifikasi_modal IS 'Data-data klasifikasi modal.';


--
-- TOC entry 151 (class 1259 OID 30469)
-- Dependencies: 5 150
-- Name: akdd_klasifikasi_modal_id_akdd_klasifikasi_modal_seq; Type: SEQUENCE; Schema: akun; Owner: -
--

CREATE SEQUENCE akdd_klasifikasi_modal_id_akdd_klasifikasi_modal_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2321 (class 0 OID 0)
-- Dependencies: 151
-- Name: akdd_klasifikasi_modal_id_akdd_klasifikasi_modal_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akdd_klasifikasi_modal_id_akdd_klasifikasi_modal_seq OWNED BY akdd_klasifikasi_modal.id_akdd_klasifikasi_modal;


--
-- TOC entry 2322 (class 0 OID 0)
-- Dependencies: 151
-- Name: akdd_klasifikasi_modal_id_akdd_klasifikasi_modal_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akdd_klasifikasi_modal_id_akdd_klasifikasi_modal_seq', 5, true);


--
-- TOC entry 152 (class 1259 OID 30471)
-- Dependencies: 5
-- Name: akdd_kodifikasi_jurnal; Type: TABLE; Schema: akun; Owner: -; Tablespace: 
--

CREATE TABLE akdd_kodifikasi_jurnal (
    id_akdd_kodifikasi_jurnal integer NOT NULL,
    kode character(2) NOT NULL,
    notes character varying(255)
);


--
-- TOC entry 2323 (class 0 OID 0)
-- Dependencies: 152
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
-- TOC entry 154 (class 1259 OID 30477)
-- Dependencies: 153 5
-- Name: akdd_level_coa_id_akdd_level_coa_seq; Type: SEQUENCE; Schema: akun; Owner: -
--

CREATE SEQUENCE akdd_level_coa_id_akdd_level_coa_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2324 (class 0 OID 0)
-- Dependencies: 154
-- Name: akdd_level_coa_id_akdd_level_coa_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akdd_level_coa_id_akdd_level_coa_seq OWNED BY akdd_level_coa.id_akdd_level_coa;


--
-- TOC entry 2325 (class 0 OID 0)
-- Dependencies: 154
-- Name: akdd_level_coa_id_akdd_level_coa_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akdd_level_coa_id_akdd_level_coa_seq', 4, true);


--
-- TOC entry 156 (class 1259 OID 30482)
-- Dependencies: 155 5
-- Name: akdd_main_coa_id_akdd_main_coa_seq; Type: SEQUENCE; Schema: akun; Owner: -
--

CREATE SEQUENCE akdd_main_coa_id_akdd_main_coa_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2326 (class 0 OID 0)
-- Dependencies: 156
-- Name: akdd_main_coa_id_akdd_main_coa_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akdd_main_coa_id_akdd_main_coa_seq OWNED BY akdd_main_coa.id_akdd_main_coa;


--
-- TOC entry 2327 (class 0 OID 0)
-- Dependencies: 156
-- Name: akdd_main_coa_id_akdd_main_coa_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akdd_main_coa_id_akdd_main_coa_seq', 5, true);


--
-- TOC entry 157 (class 1259 OID 30484)
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
-- TOC entry 2328 (class 0 OID 0)
-- Dependencies: 157
-- Name: TABLE akdd_perubahan_dana; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akdd_perubahan_dana IS 'Data template perubahan dana.';


--
-- TOC entry 158 (class 1259 OID 30490)
-- Dependencies: 5 157
-- Name: akdd_perubahan_dana_id_akdd_perubahan_dana_seq; Type: SEQUENCE; Schema: akun; Owner: -
--

CREATE SEQUENCE akdd_perubahan_dana_id_akdd_perubahan_dana_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2329 (class 0 OID 0)
-- Dependencies: 158
-- Name: akdd_perubahan_dana_id_akdd_perubahan_dana_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akdd_perubahan_dana_id_akdd_perubahan_dana_seq OWNED BY akdd_perubahan_dana.id_akdd_perubahan_dana;


--
-- TOC entry 2330 (class 0 OID 0)
-- Dependencies: 158
-- Name: akdd_perubahan_dana_id_akdd_perubahan_dana_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akdd_perubahan_dana_id_akdd_perubahan_dana_seq', 1, false);


--
-- TOC entry 159 (class 1259 OID 30492)
-- Dependencies: 2039 5
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
-- TOC entry 2331 (class 0 OID 0)
-- Dependencies: 159
-- Name: TABLE akdd_posisi_keuangan; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akdd_posisi_keuangan IS 'Tabel yang berfungsi sebagai template laporan posisi keuangan.';


--
-- TOC entry 160 (class 1259 OID 30499)
-- Dependencies: 5 159
-- Name: akdd_posisi_keuangan_id_akdd_posisi_keuangan_seq; Type: SEQUENCE; Schema: akun; Owner: -
--

CREATE SEQUENCE akdd_posisi_keuangan_id_akdd_posisi_keuangan_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2332 (class 0 OID 0)
-- Dependencies: 160
-- Name: akdd_posisi_keuangan_id_akdd_posisi_keuangan_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akdd_posisi_keuangan_id_akdd_posisi_keuangan_seq OWNED BY akdd_posisi_keuangan.id_akdd_posisi_keuangan;


--
-- TOC entry 2333 (class 0 OID 0)
-- Dependencies: 160
-- Name: akdd_posisi_keuangan_id_akdd_posisi_keuangan_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akdd_posisi_keuangan_id_akdd_posisi_keuangan_seq', 1, false);


--
-- TOC entry 161 (class 1259 OID 30501)
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
-- TOC entry 2334 (class 0 OID 0)
-- Dependencies: 161
-- Name: TABLE akmt_buku_besar; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akmt_buku_besar IS 'Data saldo-saldo COA.';


--
-- TOC entry 162 (class 1259 OID 30504)
-- Dependencies: 5 161
-- Name: akmt_buku_besar_id_akmt_buku_besar_seq; Type: SEQUENCE; Schema: akun; Owner: -
--

CREATE SEQUENCE akmt_buku_besar_id_akmt_buku_besar_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2335 (class 0 OID 0)
-- Dependencies: 162
-- Name: akmt_buku_besar_id_akmt_buku_besar_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akmt_buku_besar_id_akmt_buku_besar_seq OWNED BY akmt_buku_besar.id_akmt_buku_besar;


--
-- TOC entry 2336 (class 0 OID 0)
-- Dependencies: 162
-- Name: akmt_buku_besar_id_akmt_buku_besar_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akmt_buku_besar_id_akmt_buku_besar_seq', 28, true);


--
-- TOC entry 167 (class 1259 OID 30517)
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
-- TOC entry 2337 (class 0 OID 0)
-- Dependencies: 167
-- Name: TABLE akmt_periode; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akmt_periode IS 'Data periode keuangan.';


--
-- TOC entry 2338 (class 0 OID 0)
-- Dependencies: 167
-- Name: COLUMN akmt_periode.flag_temp; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON COLUMN akmt_periode.flag_temp IS '
0 = Temporary Dirty
1 = Temporary Clean
2 = Permanent';


--
-- TOC entry 203 (class 1259 OID 32425)
-- Dependencies: 1833 5
-- Name: akmt_buku_besar_periode_v; Type: VIEW; Schema: akun; Owner: -
--

CREATE VIEW akmt_buku_besar_periode_v AS
    SELECT c.id_akdd_main_coa, c.acc_type, c.id_akdd_detail_coa, c.coa_number, c.uraian AS coa_uraian, c.level_number, a.id_akmt_buku_besar, a.id_akmt_periode, a.no_bukti, a.tanggal, a.awal, a.mutasi_debet, a.mutasi_kredit, a.akhir, a.keterangan, b.tahun, b.bulan, b.uraian FROM ((akdd_detail_coa_v c LEFT JOIN akmt_buku_besar a ON ((a.id_akdd_detail_coa = c.id_akdd_detail_coa))) LEFT JOIN akmt_periode b ON ((a.id_akmt_periode = b.id_akmt_periode)));


--
-- TOC entry 163 (class 1259 OID 30506)
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
-- TOC entry 2339 (class 0 OID 0)
-- Dependencies: 163
-- Name: TABLE akmt_jurnal; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akmt_jurnal IS 'Data jurnal.';


--
-- TOC entry 2340 (class 0 OID 0)
-- Dependencies: 163
-- Name: COLUMN akmt_jurnal.flag_jurnal; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON COLUMN akmt_jurnal.flag_jurnal IS '
0 = Jurnal umum
1 = Jurnal mapping';


--
-- TOC entry 2341 (class 0 OID 0)
-- Dependencies: 163
-- Name: COLUMN akmt_jurnal.flag_temp; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON COLUMN akmt_jurnal.flag_temp IS '
0 = Belum selesai
1 = Sudah selesai
2 = Sudah disetujui';


--
-- TOC entry 2342 (class 0 OID 0)
-- Dependencies: 163
-- Name: COLUMN akmt_jurnal.flag_posting; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON COLUMN akmt_jurnal.flag_posting IS '
0 = Belum posting
1 = Sudah posting sementara
2 = Sudah posting permanen';


--
-- TOC entry 165 (class 1259 OID 30513)
-- Dependencies: 5 164
-- Name: akmt_jurnal_det_id_akmt_jurnal_det_seq; Type: SEQUENCE; Schema: akun; Owner: -
--

CREATE SEQUENCE akmt_jurnal_det_id_akmt_jurnal_det_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2343 (class 0 OID 0)
-- Dependencies: 165
-- Name: akmt_jurnal_det_id_akmt_jurnal_det_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akmt_jurnal_det_id_akmt_jurnal_det_seq OWNED BY akmt_jurnal_det.id_akmt_jurnal_det;


--
-- TOC entry 2344 (class 0 OID 0)
-- Dependencies: 165
-- Name: akmt_jurnal_det_id_akmt_jurnal_det_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akmt_jurnal_det_id_akmt_jurnal_det_seq', 26, true);


--
-- TOC entry 166 (class 1259 OID 30515)
-- Dependencies: 163 5
-- Name: akmt_jurnal_id_akmt_jurnal_seq; Type: SEQUENCE; Schema: akun; Owner: -
--

CREATE SEQUENCE akmt_jurnal_id_akmt_jurnal_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2345 (class 0 OID 0)
-- Dependencies: 166
-- Name: akmt_jurnal_id_akmt_jurnal_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akmt_jurnal_id_akmt_jurnal_seq OWNED BY akmt_jurnal.id_akmt_jurnal;


--
-- TOC entry 2346 (class 0 OID 0)
-- Dependencies: 166
-- Name: akmt_jurnal_id_akmt_jurnal_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akmt_jurnal_id_akmt_jurnal_seq', 15, true);


--
-- TOC entry 168 (class 1259 OID 30520)
-- Dependencies: 167 5
-- Name: akmt_periode_id_akmt_periode_seq; Type: SEQUENCE; Schema: akun; Owner: -
--

CREATE SEQUENCE akmt_periode_id_akmt_periode_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2347 (class 0 OID 0)
-- Dependencies: 168
-- Name: akmt_periode_id_akmt_periode_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akmt_periode_id_akmt_periode_seq OWNED BY akmt_periode.id_akmt_periode;


--
-- TOC entry 2348 (class 0 OID 0)
-- Dependencies: 168
-- Name: akmt_periode_id_akmt_periode_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akmt_periode_id_akmt_periode_seq', 2, true);


SET search_path = public, pg_catalog;

--
-- TOC entry 169 (class 1259 OID 30522)
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
-- TOC entry 2349 (class 0 OID 0)
-- Dependencies: 169
-- Name: TABLE dd_access; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dd_access IS 'Data hak akses';


--
-- TOC entry 170 (class 1259 OID 30525)
-- Dependencies: 169 8
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
-- TOC entry 2350 (class 0 OID 0)
-- Dependencies: 170
-- Name: dd_access_id_dd_access_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dd_access_id_dd_access_seq OWNED BY dd_access.id_dd_access;


--
-- TOC entry 2351 (class 0 OID 0)
-- Dependencies: 170
-- Name: dd_access_id_dd_access_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dd_access_id_dd_access_seq', 5, true);


--
-- TOC entry 171 (class 1259 OID 30527)
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
-- TOC entry 2352 (class 0 OID 0)
-- Dependencies: 171
-- Name: TABLE dd_groups; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dd_groups IS 'Data kelompok pengguna';


--
-- TOC entry 172 (class 1259 OID 30530)
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
-- TOC entry 2353 (class 0 OID 0)
-- Dependencies: 172
-- Name: TABLE dd_groups_detail; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dd_groups_detail IS 'Data kelompok detail';


--
-- TOC entry 173 (class 1259 OID 30533)
-- Dependencies: 172 8
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
-- TOC entry 2354 (class 0 OID 0)
-- Dependencies: 173
-- Name: dd_groups_detail_id_dd_groups_detail_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dd_groups_detail_id_dd_groups_detail_seq OWNED BY dd_groups_detail.id_dd_groups_detail;


--
-- TOC entry 2355 (class 0 OID 0)
-- Dependencies: 173
-- Name: dd_groups_detail_id_dd_groups_detail_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dd_groups_detail_id_dd_groups_detail_seq', 137, true);


--
-- TOC entry 174 (class 1259 OID 30535)
-- Dependencies: 171 8
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
-- TOC entry 2356 (class 0 OID 0)
-- Dependencies: 174
-- Name: dd_groups_id_dd_groups_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dd_groups_id_dd_groups_seq OWNED BY dd_groups.id_dd_groups;


--
-- TOC entry 2357 (class 0 OID 0)
-- Dependencies: 174
-- Name: dd_groups_id_dd_groups_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dd_groups_id_dd_groups_seq', 4, true);


--
-- TOC entry 175 (class 1259 OID 30537)
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
-- TOC entry 2358 (class 0 OID 0)
-- Dependencies: 175
-- Name: TABLE dd_menus; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dd_menus IS 'Data menu';


--
-- TOC entry 176 (class 1259 OID 30540)
-- Dependencies: 175 8
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
-- TOC entry 2359 (class 0 OID 0)
-- Dependencies: 176
-- Name: dd_menus_id_dd_menus_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dd_menus_id_dd_menus_seq OWNED BY dd_menus.id_dd_menus;


--
-- TOC entry 2360 (class 0 OID 0)
-- Dependencies: 176
-- Name: dd_menus_id_dd_menus_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dd_menus_id_dd_menus_seq', 8, true);


--
-- TOC entry 177 (class 1259 OID 30542)
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
-- TOC entry 2361 (class 0 OID 0)
-- Dependencies: 177
-- Name: TABLE dd_moduls; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dd_moduls IS 'Data modul-modul';


--
-- TOC entry 178 (class 1259 OID 30545)
-- Dependencies: 8 177
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
-- TOC entry 2362 (class 0 OID 0)
-- Dependencies: 178
-- Name: dd_moduls_id_dd_moduls_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dd_moduls_id_dd_moduls_seq OWNED BY dd_moduls.id_dd_moduls;


--
-- TOC entry 2363 (class 0 OID 0)
-- Dependencies: 178
-- Name: dd_moduls_id_dd_moduls_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dd_moduls_id_dd_moduls_seq', 14, true);


--
-- TOC entry 179 (class 1259 OID 30547)
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
-- TOC entry 2364 (class 0 OID 0)
-- Dependencies: 179
-- Name: TABLE dd_sub_menus; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dd_sub_menus IS 'Data sub menu';


--
-- TOC entry 180 (class 1259 OID 30550)
-- Dependencies: 8 179
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
-- TOC entry 2365 (class 0 OID 0)
-- Dependencies: 180
-- Name: dd_sub_menus_id_dd_sub_menus_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dd_sub_menus_id_dd_sub_menus_seq OWNED BY dd_sub_menus.id_dd_sub_menus;


--
-- TOC entry 2366 (class 0 OID 0)
-- Dependencies: 180
-- Name: dd_sub_menus_id_dd_sub_menus_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dd_sub_menus_id_dd_sub_menus_seq', 21, true);


--
-- TOC entry 181 (class 1259 OID 30552)
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
-- TOC entry 2367 (class 0 OID 0)
-- Dependencies: 181
-- Name: TABLE dd_tabs; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dd_tabs IS 'Data tab-tab';


--
-- TOC entry 182 (class 1259 OID 30555)
-- Dependencies: 181 8
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
-- TOC entry 2368 (class 0 OID 0)
-- Dependencies: 182
-- Name: dd_tabs_id_dd_tabs_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dd_tabs_id_dd_tabs_seq OWNED BY dd_tabs.id_dd_tabs;


--
-- TOC entry 2369 (class 0 OID 0)
-- Dependencies: 182
-- Name: dd_tabs_id_dd_tabs_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dd_tabs_id_dd_tabs_seq', 45, true);


--
-- TOC entry 183 (class 1259 OID 30557)
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
-- TOC entry 2370 (class 0 OID 0)
-- Dependencies: 183
-- Name: TABLE dd_users; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dd_users IS 'Data pengguna';


--
-- TOC entry 184 (class 1259 OID 30560)
-- Dependencies: 8 183
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
-- TOC entry 2371 (class 0 OID 0)
-- Dependencies: 184
-- Name: dd_users_id_dd_users_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dd_users_id_dd_users_seq OWNED BY dd_users.id_dd_users;


--
-- TOC entry 2372 (class 0 OID 0)
-- Dependencies: 184
-- Name: dd_users_id_dd_users_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dd_users_id_dd_users_seq', 4, true);


SET search_path = trans, pg_catalog;

--
-- TOC entry 185 (class 1259 OID 30562)
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
-- TOC entry 2373 (class 0 OID 0)
-- Dependencies: 185
-- Name: TABLE bank; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE bank IS 'Tabel data bank.';


--
-- TOC entry 186 (class 1259 OID 30565)
-- Dependencies: 6 185
-- Name: bank_id_bank_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE bank_id_bank_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2374 (class 0 OID 0)
-- Dependencies: 186
-- Name: bank_id_bank_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE bank_id_bank_seq OWNED BY bank.id_bank;


--
-- TOC entry 2375 (class 0 OID 0)
-- Dependencies: 186
-- Name: bank_id_bank_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('bank_id_bank_seq', 7, true);


--
-- TOC entry 207 (class 1259 OID 32492)
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
-- TOC entry 2376 (class 0 OID 0)
-- Dependencies: 207
-- Name: TABLE jenis_transaksi; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE jenis_transaksi IS 'Tabel jenis-jenis transaksi.';


--
-- TOC entry 206 (class 1259 OID 32490)
-- Dependencies: 207 6
-- Name: jenis_transaksi_id_jenis_transaksi_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE jenis_transaksi_id_jenis_transaksi_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2377 (class 0 OID 0)
-- Dependencies: 206
-- Name: jenis_transaksi_id_jenis_transaksi_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE jenis_transaksi_id_jenis_transaksi_seq OWNED BY jenis_transaksi.id_jenis_transaksi;


--
-- TOC entry 2378 (class 0 OID 0)
-- Dependencies: 206
-- Name: jenis_transaksi_id_jenis_transaksi_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('jenis_transaksi_id_jenis_transaksi_seq', 6, true);


--
-- TOC entry 209 (class 1259 OID 32513)
-- Dependencies: 2068 2069 6
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
-- TOC entry 2379 (class 0 OID 0)
-- Dependencies: 209
-- Name: TABLE mapping_kode_akun; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE mapping_kode_akun IS 'Tabel yang memetakan antara kode akun dengan jenis transaksi.';


--
-- TOC entry 2380 (class 0 OID 0)
-- Dependencies: 209
-- Name: COLUMN mapping_kode_akun.flag_debet_kredit; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON COLUMN mapping_kode_akun.flag_debet_kredit IS '1 = Debet
2 = Kredit';


--
-- TOC entry 2381 (class 0 OID 0)
-- Dependencies: 209
-- Name: COLUMN mapping_kode_akun.flag_pajak; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON COLUMN mapping_kode_akun.flag_pajak IS '1 = Bukan Pajak
2 = Pajak';


--
-- TOC entry 221 (class 1259 OID 32668)
-- Dependencies: 1835 6
-- Name: jenis_transaksi_mapping_v; Type: VIEW; Schema: trans; Owner: -
--

CREATE VIEW jenis_transaksi_mapping_v AS
    SELECT a.id_jenis_transaksi, a.id_sub_kode_kas, a.transaksi FROM (jenis_transaksi a JOIN mapping_kode_akun b ON ((a.id_jenis_transaksi = b.id_jenis_transaksi))) GROUP BY a.id_jenis_transaksi, a.id_sub_kode_kas, a.transaksi ORDER BY a.transaksi;


--
-- TOC entry 205 (class 1259 OID 32432)
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
-- TOC entry 2382 (class 0 OID 0)
-- Dependencies: 205
-- Name: TABLE klasifikasi_penerima; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE klasifikasi_penerima IS 'Tabel klasifikasi penerima.';


--
-- TOC entry 215 (class 1259 OID 32588)
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
-- TOC entry 2383 (class 0 OID 0)
-- Dependencies: 215
-- Name: TABLE mapping_transaksi_penerima; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE mapping_transaksi_penerima IS 'Tabel mapping antara jenis transaksi dan klasifikasi penerima (khusus transaksi biaya saja).';


--
-- TOC entry 217 (class 1259 OID 32611)
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
-- TOC entry 2384 (class 0 OID 0)
-- Dependencies: 217
-- Name: TABLE pihak_penerima; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE pihak_penerima IS 'Tabel pihak penerima dari pengeluaran Yayasan Astra.';


--
-- TOC entry 220 (class 1259 OID 32660)
-- Dependencies: 1834 6
-- Name: jenis_transaksi_pihak_penerima_v; Type: VIEW; Schema: trans; Owner: -
--

CREATE VIEW jenis_transaksi_pihak_penerima_v AS
    SELECT a.id_jenis_transaksi, c.id_pihak_penerima, ((((c.nama)::text || ' ('::text) || (b.klasifikasi)::text) || ')'::text) AS pihak_penerima FROM ((mapping_transaksi_penerima a JOIN klasifikasi_penerima b ON ((a.id_klasifikasi_penerima = b.id_klasifikasi_penerima))) JOIN pihak_penerima c ON ((b.id_klasifikasi_penerima = c.id_klasifikasi_penerima))) ORDER BY b.klasifikasi, c.nama;


--
-- TOC entry 204 (class 1259 OID 32430)
-- Dependencies: 205 6
-- Name: klasifikasi_penerima_id_klasifikasi_penerima_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE klasifikasi_penerima_id_klasifikasi_penerima_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2385 (class 0 OID 0)
-- Dependencies: 204
-- Name: klasifikasi_penerima_id_klasifikasi_penerima_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE klasifikasi_penerima_id_klasifikasi_penerima_seq OWNED BY klasifikasi_penerima.id_klasifikasi_penerima;


--
-- TOC entry 2386 (class 0 OID 0)
-- Dependencies: 204
-- Name: klasifikasi_penerima_id_klasifikasi_penerima_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('klasifikasi_penerima_id_klasifikasi_penerima_seq', 3, true);


--
-- TOC entry 192 (class 1259 OID 31785)
-- Dependencies: 2058 2059 6
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
-- TOC entry 2387 (class 0 OID 0)
-- Dependencies: 192
-- Name: TABLE kode_kas; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE kode_kas IS 'Tabel kode kas.';


--
-- TOC entry 2388 (class 0 OID 0)
-- Dependencies: 192
-- Name: COLUMN kode_kas.flag_in_out; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON COLUMN kode_kas.flag_in_out IS '''i'' = Input, ''o'' = Output.';


--
-- TOC entry 191 (class 1259 OID 31783)
-- Dependencies: 192 6
-- Name: kode_kas_id_kode_kas_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE kode_kas_id_kode_kas_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2389 (class 0 OID 0)
-- Dependencies: 191
-- Name: kode_kas_id_kode_kas_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE kode_kas_id_kode_kas_seq OWNED BY kode_kas.id_kode_kas;


--
-- TOC entry 2390 (class 0 OID 0)
-- Dependencies: 191
-- Name: kode_kas_id_kode_kas_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('kode_kas_id_kode_kas_seq', 4, true);


--
-- TOC entry 187 (class 1259 OID 30595)
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
-- TOC entry 2391 (class 0 OID 0)
-- Dependencies: 187
-- Name: TABLE kota; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE kota IS 'Tabel data-data kota.';


--
-- TOC entry 188 (class 1259 OID 30598)
-- Dependencies: 6 187
-- Name: kota_id_kota_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE kota_id_kota_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2392 (class 0 OID 0)
-- Dependencies: 188
-- Name: kota_id_kota_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE kota_id_kota_seq OWNED BY kota.id_kota;


--
-- TOC entry 2393 (class 0 OID 0)
-- Dependencies: 188
-- Name: kota_id_kota_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('kota_id_kota_seq', 7, true);


--
-- TOC entry 208 (class 1259 OID 32511)
-- Dependencies: 6 209
-- Name: mapping_kode_akun_id_mapping_kode_akun_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE mapping_kode_akun_id_mapping_kode_akun_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2394 (class 0 OID 0)
-- Dependencies: 208
-- Name: mapping_kode_akun_id_mapping_kode_akun_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE mapping_kode_akun_id_mapping_kode_akun_seq OWNED BY mapping_kode_akun.id_mapping_kode_akun;


--
-- TOC entry 2395 (class 0 OID 0)
-- Dependencies: 208
-- Name: mapping_kode_akun_id_mapping_kode_akun_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('mapping_kode_akun_id_mapping_kode_akun_seq', 12, true);


--
-- TOC entry 219 (class 1259 OID 32634)
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
-- TOC entry 2396 (class 0 OID 0)
-- Dependencies: 219
-- Name: TABLE mapping_penerima; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE mapping_penerima IS 'Tabel mapping antara pihak penerima dengan transaksi.';


--
-- TOC entry 218 (class 1259 OID 32632)
-- Dependencies: 219 6
-- Name: mapping_penerima_id_mapping_penerima_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE mapping_penerima_id_mapping_penerima_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2397 (class 0 OID 0)
-- Dependencies: 218
-- Name: mapping_penerima_id_mapping_penerima_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE mapping_penerima_id_mapping_penerima_seq OWNED BY mapping_penerima.id_mapping_penerima;


--
-- TOC entry 2398 (class 0 OID 0)
-- Dependencies: 218
-- Name: mapping_penerima_id_mapping_penerima_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('mapping_penerima_id_mapping_penerima_seq', 4, true);


--
-- TOC entry 211 (class 1259 OID 32542)
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
-- TOC entry 2399 (class 0 OID 0)
-- Dependencies: 211
-- Name: TABLE mapping_rekening; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE mapping_rekening IS 'Tabel mapping rekening.';


--
-- TOC entry 210 (class 1259 OID 32540)
-- Dependencies: 6 211
-- Name: mapping_rekening_id_mapping_rekening_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE mapping_rekening_id_mapping_rekening_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2400 (class 0 OID 0)
-- Dependencies: 210
-- Name: mapping_rekening_id_mapping_rekening_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE mapping_rekening_id_mapping_rekening_seq OWNED BY mapping_rekening.id_mapping_rekening;


--
-- TOC entry 2401 (class 0 OID 0)
-- Dependencies: 210
-- Name: mapping_rekening_id_mapping_rekening_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('mapping_rekening_id_mapping_rekening_seq', 1, false);


--
-- TOC entry 200 (class 1259 OID 32371)
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
-- TOC entry 2402 (class 0 OID 0)
-- Dependencies: 200
-- Name: TABLE mapping_transaksi_jurnal; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE mapping_transaksi_jurnal IS 'Tabel mapping antara transaksi dengan jurnal.';


--
-- TOC entry 199 (class 1259 OID 32369)
-- Dependencies: 200 6
-- Name: mapping_transaksi_jurnal_id_mapping_transaksi_jurnal_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE mapping_transaksi_jurnal_id_mapping_transaksi_jurnal_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2403 (class 0 OID 0)
-- Dependencies: 199
-- Name: mapping_transaksi_jurnal_id_mapping_transaksi_jurnal_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE mapping_transaksi_jurnal_id_mapping_transaksi_jurnal_seq OWNED BY mapping_transaksi_jurnal.id_mapping_transaksi_jurnal;


--
-- TOC entry 2404 (class 0 OID 0)
-- Dependencies: 199
-- Name: mapping_transaksi_jurnal_id_mapping_transaksi_jurnal_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('mapping_transaksi_jurnal_id_mapping_transaksi_jurnal_seq', 9, true);


--
-- TOC entry 214 (class 1259 OID 32586)
-- Dependencies: 215 6
-- Name: mapping_transaksi_penerima_id_mapping_transaksi_penerima_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE mapping_transaksi_penerima_id_mapping_transaksi_penerima_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2405 (class 0 OID 0)
-- Dependencies: 214
-- Name: mapping_transaksi_penerima_id_mapping_transaksi_penerima_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE mapping_transaksi_penerima_id_mapping_transaksi_penerima_seq OWNED BY mapping_transaksi_penerima.id_mapping_transaksi_penerima;


--
-- TOC entry 2406 (class 0 OID 0)
-- Dependencies: 214
-- Name: mapping_transaksi_penerima_id_mapping_transaksi_penerima_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('mapping_transaksi_penerima_id_mapping_transaksi_penerima_seq', 3, true);


--
-- TOC entry 216 (class 1259 OID 32609)
-- Dependencies: 217 6
-- Name: pihak_penerima_id_pihak_penerima_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE pihak_penerima_id_pihak_penerima_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2407 (class 0 OID 0)
-- Dependencies: 216
-- Name: pihak_penerima_id_pihak_penerima_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE pihak_penerima_id_pihak_penerima_seq OWNED BY pihak_penerima.id_pihak_penerima;


--
-- TOC entry 2408 (class 0 OID 0)
-- Dependencies: 216
-- Name: pihak_penerima_id_pihak_penerima_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('pihak_penerima_id_pihak_penerima_seq', 8, true);


--
-- TOC entry 189 (class 1259 OID 30607)
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
-- TOC entry 2409 (class 0 OID 0)
-- Dependencies: 189
-- Name: TABLE propinsi; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE propinsi IS 'Tabel data-data propinsi.';


--
-- TOC entry 190 (class 1259 OID 30610)
-- Dependencies: 6 189
-- Name: propinsi_id_propinsi_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE propinsi_id_propinsi_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2410 (class 0 OID 0)
-- Dependencies: 190
-- Name: propinsi_id_propinsi_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE propinsi_id_propinsi_seq OWNED BY propinsi.id_propinsi;


--
-- TOC entry 2411 (class 0 OID 0)
-- Dependencies: 190
-- Name: propinsi_id_propinsi_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('propinsi_id_propinsi_seq', 4, true);


--
-- TOC entry 198 (class 1259 OID 32094)
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
-- TOC entry 2412 (class 0 OID 0)
-- Dependencies: 198
-- Name: TABLE rekening_bank; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE rekening_bank IS 'Tabel rekening dari tiap-tiap bank.';


--
-- TOC entry 197 (class 1259 OID 32092)
-- Dependencies: 198 6
-- Name: rekening_bank_id_rekening_bank_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE rekening_bank_id_rekening_bank_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2413 (class 0 OID 0)
-- Dependencies: 197
-- Name: rekening_bank_id_rekening_bank_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE rekening_bank_id_rekening_bank_seq OWNED BY rekening_bank.id_rekening_bank;


--
-- TOC entry 2414 (class 0 OID 0)
-- Dependencies: 197
-- Name: rekening_bank_id_rekening_bank_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('rekening_bank_id_rekening_bank_seq', 3, true);


--
-- TOC entry 194 (class 1259 OID 31812)
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
-- TOC entry 2415 (class 0 OID 0)
-- Dependencies: 194
-- Name: TABLE sub_kode_kas; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE sub_kode_kas IS 'Tabel sub kode kas.';


--
-- TOC entry 193 (class 1259 OID 31810)
-- Dependencies: 194 6
-- Name: sub_kode_kas_id_sub_kode_kas_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE sub_kode_kas_id_sub_kode_kas_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2416 (class 0 OID 0)
-- Dependencies: 193
-- Name: sub_kode_kas_id_sub_kode_kas_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE sub_kode_kas_id_sub_kode_kas_seq OWNED BY sub_kode_kas.id_sub_kode_kas;


--
-- TOC entry 2417 (class 0 OID 0)
-- Dependencies: 193
-- Name: sub_kode_kas_id_sub_kode_kas_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('sub_kode_kas_id_sub_kode_kas_seq', 9, true);


--
-- TOC entry 213 (class 1259 OID 32565)
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
-- TOC entry 2418 (class 0 OID 0)
-- Dependencies: 213
-- Name: TABLE sub_transaksi; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE sub_transaksi IS 'Tabel berisikan data-data sub transaksi.';


--
-- TOC entry 212 (class 1259 OID 32563)
-- Dependencies: 6 213
-- Name: sub_transaksi_id_sub_transaksi_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE sub_transaksi_id_sub_transaksi_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2419 (class 0 OID 0)
-- Dependencies: 212
-- Name: sub_transaksi_id_sub_transaksi_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE sub_transaksi_id_sub_transaksi_seq OWNED BY sub_transaksi.id_sub_transaksi;


--
-- TOC entry 2420 (class 0 OID 0)
-- Dependencies: 212
-- Name: sub_transaksi_id_sub_transaksi_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('sub_transaksi_id_sub_transaksi_seq', 29, true);


--
-- TOC entry 196 (class 1259 OID 31930)
-- Dependencies: 2062 6
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
-- TOC entry 2421 (class 0 OID 0)
-- Dependencies: 196
-- Name: TABLE transaksi; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE transaksi IS 'Tabel transaksi-transaksi yang ada di yayasan.';


--
-- TOC entry 195 (class 1259 OID 31928)
-- Dependencies: 196 6
-- Name: transaksi_id_transaksi_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE transaksi_id_transaksi_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2422 (class 0 OID 0)
-- Dependencies: 195
-- Name: transaksi_id_transaksi_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE transaksi_id_transaksi_seq OWNED BY transaksi.id_transaksi;


--
-- TOC entry 2423 (class 0 OID 0)
-- Dependencies: 195
-- Name: transaksi_id_transaksi_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('transaksi_id_transaksi_seq', 14, true);


SET search_path = akun, pg_catalog;

--
-- TOC entry 2030 (class 2604 OID 30645)
-- Dependencies: 143 142
-- Name: id_akdd_arus_kas; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_arus_kas ALTER COLUMN id_akdd_arus_kas SET DEFAULT nextval('akdd_arus_kas_id_akdd_arus_kas_seq'::regclass);


--
-- TOC entry 2031 (class 2604 OID 30646)
-- Dependencies: 145 144
-- Name: id_akdd_detail_coa; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_detail_coa ALTER COLUMN id_akdd_detail_coa SET DEFAULT nextval('akdd_detail_coa_id_akdd_detail_coa_seq'::regclass);


--
-- TOC entry 2032 (class 2604 OID 30647)
-- Dependencies: 147 146
-- Name: id_akdd_detail_coa_lr; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_detail_coa_lr ALTER COLUMN id_akdd_detail_coa_lr SET DEFAULT nextval('akdd_detail_coa_lr_id_akdd_detail_coa_lr_seq'::regclass);


--
-- TOC entry 2034 (class 2604 OID 30648)
-- Dependencies: 149 148
-- Name: id_akdd_detail_coa_map; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_detail_coa_map ALTER COLUMN id_akdd_detail_coa_map SET DEFAULT nextval('akdd_detail_coa_map_id_akdd_detail_coa_map_seq'::regclass);


--
-- TOC entry 2035 (class 2604 OID 30649)
-- Dependencies: 151 150
-- Name: id_akdd_klasifikasi_modal; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_klasifikasi_modal ALTER COLUMN id_akdd_klasifikasi_modal SET DEFAULT nextval('akdd_klasifikasi_modal_id_akdd_klasifikasi_modal_seq'::regclass);


--
-- TOC entry 2036 (class 2604 OID 30650)
-- Dependencies: 154 153
-- Name: id_akdd_level_coa; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_level_coa ALTER COLUMN id_akdd_level_coa SET DEFAULT nextval('akdd_level_coa_id_akdd_level_coa_seq'::regclass);


--
-- TOC entry 2037 (class 2604 OID 30651)
-- Dependencies: 156 155
-- Name: id_akdd_main_coa; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_main_coa ALTER COLUMN id_akdd_main_coa SET DEFAULT nextval('akdd_main_coa_id_akdd_main_coa_seq'::regclass);


--
-- TOC entry 2038 (class 2604 OID 30652)
-- Dependencies: 158 157
-- Name: id_akdd_perubahan_dana; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_perubahan_dana ALTER COLUMN id_akdd_perubahan_dana SET DEFAULT nextval('akdd_perubahan_dana_id_akdd_perubahan_dana_seq'::regclass);


--
-- TOC entry 2040 (class 2604 OID 30653)
-- Dependencies: 160 159
-- Name: id_akdd_posisi_keuangan; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_posisi_keuangan ALTER COLUMN id_akdd_posisi_keuangan SET DEFAULT nextval('akdd_posisi_keuangan_id_akdd_posisi_keuangan_seq'::regclass);


--
-- TOC entry 2041 (class 2604 OID 30654)
-- Dependencies: 162 161
-- Name: id_akmt_buku_besar; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akmt_buku_besar ALTER COLUMN id_akmt_buku_besar SET DEFAULT nextval('akmt_buku_besar_id_akmt_buku_besar_seq'::regclass);


--
-- TOC entry 2042 (class 2604 OID 30655)
-- Dependencies: 166 163
-- Name: id_akmt_jurnal; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akmt_jurnal ALTER COLUMN id_akmt_jurnal SET DEFAULT nextval('akmt_jurnal_id_akmt_jurnal_seq'::regclass);


--
-- TOC entry 2044 (class 2604 OID 30656)
-- Dependencies: 165 164
-- Name: id_akmt_jurnal_det; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akmt_jurnal_det ALTER COLUMN id_akmt_jurnal_det SET DEFAULT nextval('akmt_jurnal_det_id_akmt_jurnal_det_seq'::regclass);


--
-- TOC entry 2045 (class 2604 OID 30657)
-- Dependencies: 168 167
-- Name: id_akmt_periode; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akmt_periode ALTER COLUMN id_akmt_periode SET DEFAULT nextval('akmt_periode_id_akmt_periode_seq'::regclass);


SET search_path = public, pg_catalog;

--
-- TOC entry 2046 (class 2604 OID 30658)
-- Dependencies: 170 169
-- Name: id_dd_access; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_access ALTER COLUMN id_dd_access SET DEFAULT nextval('dd_access_id_dd_access_seq'::regclass);


--
-- TOC entry 2047 (class 2604 OID 30659)
-- Dependencies: 174 171
-- Name: id_dd_groups; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_groups ALTER COLUMN id_dd_groups SET DEFAULT nextval('dd_groups_id_dd_groups_seq'::regclass);


--
-- TOC entry 2048 (class 2604 OID 30660)
-- Dependencies: 173 172
-- Name: id_dd_groups_detail; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_groups_detail ALTER COLUMN id_dd_groups_detail SET DEFAULT nextval('dd_groups_detail_id_dd_groups_detail_seq'::regclass);


--
-- TOC entry 2049 (class 2604 OID 30661)
-- Dependencies: 176 175
-- Name: id_dd_menus; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_menus ALTER COLUMN id_dd_menus SET DEFAULT nextval('dd_menus_id_dd_menus_seq'::regclass);


--
-- TOC entry 2050 (class 2604 OID 30662)
-- Dependencies: 178 177
-- Name: id_dd_moduls; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_moduls ALTER COLUMN id_dd_moduls SET DEFAULT nextval('dd_moduls_id_dd_moduls_seq'::regclass);


--
-- TOC entry 2051 (class 2604 OID 30663)
-- Dependencies: 180 179
-- Name: id_dd_sub_menus; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_sub_menus ALTER COLUMN id_dd_sub_menus SET DEFAULT nextval('dd_sub_menus_id_dd_sub_menus_seq'::regclass);


--
-- TOC entry 2052 (class 2604 OID 30664)
-- Dependencies: 182 181
-- Name: id_dd_tabs; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_tabs ALTER COLUMN id_dd_tabs SET DEFAULT nextval('dd_tabs_id_dd_tabs_seq'::regclass);


--
-- TOC entry 2053 (class 2604 OID 30665)
-- Dependencies: 184 183
-- Name: id_dd_users; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_users ALTER COLUMN id_dd_users SET DEFAULT nextval('dd_users_id_dd_users_seq'::regclass);


SET search_path = trans, pg_catalog;

--
-- TOC entry 2054 (class 2604 OID 30666)
-- Dependencies: 186 185
-- Name: id_bank; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY bank ALTER COLUMN id_bank SET DEFAULT nextval('bank_id_bank_seq'::regclass);


--
-- TOC entry 2066 (class 2604 OID 32495)
-- Dependencies: 206 207 207
-- Name: id_jenis_transaksi; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY jenis_transaksi ALTER COLUMN id_jenis_transaksi SET DEFAULT nextval('jenis_transaksi_id_jenis_transaksi_seq'::regclass);


--
-- TOC entry 2065 (class 2604 OID 32435)
-- Dependencies: 204 205 205
-- Name: id_klasifikasi_penerima; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY klasifikasi_penerima ALTER COLUMN id_klasifikasi_penerima SET DEFAULT nextval('klasifikasi_penerima_id_klasifikasi_penerima_seq'::regclass);


--
-- TOC entry 2057 (class 2604 OID 31788)
-- Dependencies: 192 191 192
-- Name: id_kode_kas; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY kode_kas ALTER COLUMN id_kode_kas SET DEFAULT nextval('kode_kas_id_kode_kas_seq'::regclass);


--
-- TOC entry 2055 (class 2604 OID 30671)
-- Dependencies: 188 187
-- Name: id_kota; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY kota ALTER COLUMN id_kota SET DEFAULT nextval('kota_id_kota_seq'::regclass);


--
-- TOC entry 2067 (class 2604 OID 32516)
-- Dependencies: 208 209 209
-- Name: id_mapping_kode_akun; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_kode_akun ALTER COLUMN id_mapping_kode_akun SET DEFAULT nextval('mapping_kode_akun_id_mapping_kode_akun_seq'::regclass);


--
-- TOC entry 2074 (class 2604 OID 32637)
-- Dependencies: 219 218 219
-- Name: id_mapping_penerima; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_penerima ALTER COLUMN id_mapping_penerima SET DEFAULT nextval('mapping_penerima_id_mapping_penerima_seq'::regclass);


--
-- TOC entry 2070 (class 2604 OID 32545)
-- Dependencies: 210 211 211
-- Name: id_mapping_rekening; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_rekening ALTER COLUMN id_mapping_rekening SET DEFAULT nextval('mapping_rekening_id_mapping_rekening_seq'::regclass);


--
-- TOC entry 2064 (class 2604 OID 32374)
-- Dependencies: 199 200 200
-- Name: id_mapping_transaksi_jurnal; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_transaksi_jurnal ALTER COLUMN id_mapping_transaksi_jurnal SET DEFAULT nextval('mapping_transaksi_jurnal_id_mapping_transaksi_jurnal_seq'::regclass);


--
-- TOC entry 2072 (class 2604 OID 32591)
-- Dependencies: 214 215 215
-- Name: id_mapping_transaksi_penerima; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_transaksi_penerima ALTER COLUMN id_mapping_transaksi_penerima SET DEFAULT nextval('mapping_transaksi_penerima_id_mapping_transaksi_penerima_seq'::regclass);


--
-- TOC entry 2073 (class 2604 OID 32614)
-- Dependencies: 217 216 217
-- Name: id_pihak_penerima; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY pihak_penerima ALTER COLUMN id_pihak_penerima SET DEFAULT nextval('pihak_penerima_id_pihak_penerima_seq'::regclass);


--
-- TOC entry 2056 (class 2604 OID 30673)
-- Dependencies: 190 189
-- Name: id_propinsi; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY propinsi ALTER COLUMN id_propinsi SET DEFAULT nextval('propinsi_id_propinsi_seq'::regclass);


--
-- TOC entry 2063 (class 2604 OID 32097)
-- Dependencies: 198 197 198
-- Name: id_rekening_bank; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY rekening_bank ALTER COLUMN id_rekening_bank SET DEFAULT nextval('rekening_bank_id_rekening_bank_seq'::regclass);


--
-- TOC entry 2060 (class 2604 OID 31815)
-- Dependencies: 194 193 194
-- Name: id_sub_kode_kas; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY sub_kode_kas ALTER COLUMN id_sub_kode_kas SET DEFAULT nextval('sub_kode_kas_id_sub_kode_kas_seq'::regclass);


--
-- TOC entry 2071 (class 2604 OID 32568)
-- Dependencies: 212 213 213
-- Name: id_sub_transaksi; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY sub_transaksi ALTER COLUMN id_sub_transaksi SET DEFAULT nextval('sub_transaksi_id_sub_transaksi_seq'::regclass);


--
-- TOC entry 2061 (class 2604 OID 31933)
-- Dependencies: 195 196 196
-- Name: id_transaksi; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ONLY transaksi ALTER COLUMN id_transaksi SET DEFAULT nextval('transaksi_id_transaksi_seq'::regclass);


SET search_path = akun, pg_catalog;

--
-- TOC entry 2258 (class 0 OID 30440)
-- Dependencies: 142
-- Data for Name: akdd_arus_kas; Type: TABLE DATA; Schema: akun; Owner: -
--

COPY akdd_arus_kas (id_akdd_arus_kas, id_akdd_arus_kas_ref, uraian, coa_range, order_number, kalkulasi, kalibrasi) FROM stdin;
\.


--
-- TOC entry 2259 (class 0 OID 30450)
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
57	4	4	26	40101001	40101001	Pendapatan Dari Yayasan
58	4	4	26	40101002	40101002	Terima Dari Bank Permata
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
\.


--
-- TOC entry 2260 (class 0 OID 30455)
-- Dependencies: 146
-- Data for Name: akdd_detail_coa_lr; Type: TABLE DATA; Schema: akun; Owner: -
--

COPY akdd_detail_coa_lr (id_akdd_detail_coa_lr, id_akdd_detail_coa, id_akdd_klasifikasi_modal, sub_coa) FROM stdin;
1	53	2	30101001
2	54	4	30101002
3	55	1	30102001
4	56	3	30102002
\.


--
-- TOC entry 2261 (class 0 OID 30460)
-- Dependencies: 148
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
29	57	1
30	58	1
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
\.


--
-- TOC entry 2262 (class 0 OID 30466)
-- Dependencies: 150
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
-- TOC entry 2263 (class 0 OID 30471)
-- Dependencies: 152
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
-- TOC entry 2264 (class 0 OID 30474)
-- Dependencies: 153
-- Data for Name: akdd_level_coa; Type: TABLE DATA; Schema: akun; Owner: -
--

COPY akdd_level_coa (id_akdd_level_coa, level_number, level_length, uraian) FROM stdin;
1	1	1	Level-1
2	2	2	Level-2
3	3	2	Level-3
4	4	3	Level-4
\.


--
-- TOC entry 2265 (class 0 OID 30479)
-- Dependencies: 155
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
-- TOC entry 2266 (class 0 OID 30484)
-- Dependencies: 157
-- Data for Name: akdd_perubahan_dana; Type: TABLE DATA; Schema: akun; Owner: -
--

COPY akdd_perubahan_dana (id_akdd_perubahan_dana, id_akdd_perubahan_dana_ref, uraian, coa_range, order_number) FROM stdin;
\.


--
-- TOC entry 2267 (class 0 OID 30492)
-- Dependencies: 159
-- Data for Name: akdd_posisi_keuangan; Type: TABLE DATA; Schema: akun; Owner: -
--

COPY akdd_posisi_keuangan (id_akdd_posisi_keuangan, id_akdd_posisi_keuangan_ref, uraian, coa_range, order_number, acc_type) FROM stdin;
\.


--
-- TOC entry 2268 (class 0 OID 30501)
-- Dependencies: 161
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
\.


--
-- TOC entry 2269 (class 0 OID 30506)
-- Dependencies: 163
-- Data for Name: akmt_jurnal; Type: TABLE DATA; Schema: akun; Owner: -
--

COPY akmt_jurnal (id_akmt_jurnal, flag_jurnal, flag_temp, flag_posting, no_bukti, tanggal, keterangan) FROM stdin;
8	0	2	0	JP20120400000003	2012-04-08	Terima duit lebih dari masjid (founded).
12	0	2	0	JU20120400000001	2012-04-14	Pindah bank  ke kas.
6	1	2	0	JP20120400000001	2012-04-08	Penerimaan kotak amal jum'at.
7	1	2	0	JP20120400000002	2012-04-08	Penerimaan kotak amal besar.
9	1	2	0	JB20120400000001	2012-04-14	Pembayaran tenaga pemasangan mic & mimbar.
11	1	2	0	JB20120400000003	2012-04-14	Bayar honor ustadz.
10	1	2	0	JB20120400000002	2012-04-14	Pembayaran kegiatan Jum'at.
15	1	2	0	JP20120300000001	2012-03-10	Penerimaan kotak amal jum'at.
14	1	2	0	JP20120200000001	2012-02-04	Penerimaan kotak amal besar.
13	1	2	0	JP20120100000001	2012-01-02	Penerimaan kotak amal jum'at.
\.


--
-- TOC entry 2270 (class 0 OID 30509)
-- Dependencies: 164
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
\.


--
-- TOC entry 2271 (class 0 OID 30517)
-- Dependencies: 167
-- Data for Name: akmt_periode; Type: TABLE DATA; Schema: akun; Owner: -
--

COPY akmt_periode (id_akmt_periode, flag_temp, tahun, bulan, uraian) FROM stdin;
1	2	2012	0	Saldo awal 2012
\.


SET search_path = public, pg_catalog;

--
-- TOC entry 2272 (class 0 OID 30522)
-- Dependencies: 169
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
-- TOC entry 2273 (class 0 OID 30527)
-- Dependencies: 171
-- Data for Name: dd_groups; Type: TABLE DATA; Schema: public; Owner: -
--

COPY dd_groups (id_dd_groups, flag_system, group_name, note) FROM stdin;
1	t	Super Administrator	Super Administrator sistem
2	f	Administrator	Administrator sistem di bawah Super Administrator
3	f	Manajer	Pengawas kegiatan Operator
4	f	Operator	Petugas yang menjalankan sehari-hari
\.


--
-- TOC entry 2274 (class 0 OID 30530)
-- Dependencies: 172
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
-- TOC entry 2275 (class 0 OID 30537)
-- Dependencies: 175
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
-- TOC entry 2276 (class 0 OID 30542)
-- Dependencies: 177
-- Data for Name: dd_moduls; Type: TABLE DATA; Schema: public; Owner: -
--

COPY dd_moduls (id_dd_moduls, order_number, modul, note) FROM stdin;
1	1	SETUP	Setup aplikasi
2	2	ADMIN	Administrasi aplikasi
13	3	TRANSAKSI	Transaksi Yayasan
14	4	SIE	Sistem Informasi Eksekutif
\.


--
-- TOC entry 2277 (class 0 OID 30547)
-- Dependencies: 179
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
-- TOC entry 2278 (class 0 OID 30552)
-- Dependencies: 181
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
-- TOC entry 2279 (class 0 OID 30557)
-- Dependencies: 183
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
-- TOC entry 2280 (class 0 OID 30562)
-- Dependencies: 185
-- Data for Name: bank; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY bank (id_bank, id_kota, id_dd_users, nama, keterangan) FROM stdin;
6	7	1	MANDIRI, PT	
7	7	1	BRI, PT	
\.


--
-- TOC entry 2289 (class 0 OID 32492)
-- Dependencies: 207
-- Data for Name: jenis_transaksi; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY jenis_transaksi (id_jenis_transaksi, id_sub_kode_kas, id_dd_users, transaksi, keterangan) FROM stdin;
2	9	1	Pembayaran Honor Kajian Tafsir & Hadits Ustadz	\N
1	3	1	Penerimaan Kotak Amal Besar	\N
5	5	1	Operasional Shalat Jum'at	\N
6	1	1	Penerimaan Kotak Amal Jum'at	\N
\.


--
-- TOC entry 2288 (class 0 OID 32432)
-- Dependencies: 205
-- Data for Name: klasifikasi_penerima; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY klasifikasi_penerima (id_klasifikasi_penerima, id_dd_users, klasifikasi, keterangan) FROM stdin;
1	1	Karyawan	Karyawan Yayasan
2	1	Ustadz	Ustadz
3	1	Guru TPA	\N
\.


--
-- TOC entry 2283 (class 0 OID 31785)
-- Dependencies: 192
-- Data for Name: kode_kas; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY kode_kas (id_kode_kas, id_dd_users, flag_in_out, kode, kas, keterangan) FROM stdin;
2	1	o	B	Shalat Jum'at	Biaya operasional pelaksanaan shalat jum'at.
1	1	i	A	Penerimaan Kas	\N
4	1	o	C	Kajian	\N
\.


--
-- TOC entry 2281 (class 0 OID 30595)
-- Dependencies: 187
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
-- TOC entry 2290 (class 0 OID 32513)
-- Dependencies: 209
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
\.


--
-- TOC entry 2295 (class 0 OID 32634)
-- Dependencies: 219
-- Data for Name: mapping_penerima; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY mapping_penerima (id_mapping_penerima, id_transaksi, id_pihak_penerima, id_dd_users) FROM stdin;
4	11	4	1
\.


--
-- TOC entry 2291 (class 0 OID 32542)
-- Dependencies: 211
-- Data for Name: mapping_rekening; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY mapping_rekening (id_mapping_rekening, id_mapping_kode_akun, id_rekening_bank, id_dd_users) FROM stdin;
\.


--
-- TOC entry 2287 (class 0 OID 32371)
-- Dependencies: 200
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
\.


--
-- TOC entry 2293 (class 0 OID 32588)
-- Dependencies: 215
-- Data for Name: mapping_transaksi_penerima; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY mapping_transaksi_penerima (id_mapping_transaksi_penerima, id_jenis_transaksi, id_klasifikasi_penerima, id_dd_users) FROM stdin;
1	2	2	1
\.


--
-- TOC entry 2294 (class 0 OID 32611)
-- Dependencies: 217
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
-- TOC entry 2282 (class 0 OID 30607)
-- Dependencies: 189
-- Data for Name: propinsi; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY propinsi (id_propinsi, id_dd_users, nama, keterangan) FROM stdin;
3	2	DKI Jakarta	
4	2	Jawa Barat	
\.


--
-- TOC entry 2286 (class 0 OID 32094)
-- Dependencies: 198
-- Data for Name: rekening_bank; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY rekening_bank (id_rekening_bank, id_bank, id_dd_users, no_rekening, keterangan) FROM stdin;
1	7	1	BRI.09 08 88 99 98 88 77 77	\N
2	6	1	MDR - 09 08 07 77 66 AA BB	\N
\.


--
-- TOC entry 2284 (class 0 OID 31812)
-- Dependencies: 194
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
-- TOC entry 2292 (class 0 OID 32565)
-- Dependencies: 213
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
\.


--
-- TOC entry 2285 (class 0 OID 31930)
-- Dependencies: 196
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
\.


SET search_path = akun, pg_catalog;

--
-- TOC entry 2087 (class 2606 OID 30679)
-- Dependencies: 148 148
-- Name: akdd_detail_coa_map_pkey; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_detail_coa_map
    ADD CONSTRAINT akdd_detail_coa_map_pkey PRIMARY KEY (id_akdd_detail_coa_map);


--
-- TOC entry 2076 (class 2606 OID 30681)
-- Dependencies: 142 142
-- Name: pk_akdd_arus_kas; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_arus_kas
    ADD CONSTRAINT pk_akdd_arus_kas PRIMARY KEY (id_akdd_arus_kas);


--
-- TOC entry 2079 (class 2606 OID 30684)
-- Dependencies: 144 144
-- Name: pk_akdd_detail_coa; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_detail_coa
    ADD CONSTRAINT pk_akdd_detail_coa PRIMARY KEY (id_akdd_detail_coa);


--
-- TOC entry 2081 (class 2606 OID 30686)
-- Dependencies: 146 146
-- Name: pk_akdd_detail_coa_lr; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_detail_coa_lr
    ADD CONSTRAINT pk_akdd_detail_coa_lr PRIMARY KEY (id_akdd_detail_coa_lr);


--
-- TOC entry 2089 (class 2606 OID 30688)
-- Dependencies: 150 150
-- Name: pk_akdd_klasifikasi_modal; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_klasifikasi_modal
    ADD CONSTRAINT pk_akdd_klasifikasi_modal PRIMARY KEY (id_akdd_klasifikasi_modal);


--
-- TOC entry 2091 (class 2606 OID 30690)
-- Dependencies: 152 152
-- Name: pk_akdd_kodifikasi_jurnal; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_kodifikasi_jurnal
    ADD CONSTRAINT pk_akdd_kodifikasi_jurnal PRIMARY KEY (id_akdd_kodifikasi_jurnal);


--
-- TOC entry 2095 (class 2606 OID 30692)
-- Dependencies: 153 153
-- Name: pk_akdd_level_coa; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_level_coa
    ADD CONSTRAINT pk_akdd_level_coa PRIMARY KEY (id_akdd_level_coa);


--
-- TOC entry 2097 (class 2606 OID 30694)
-- Dependencies: 155 155
-- Name: pk_akdd_main_coa; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_main_coa
    ADD CONSTRAINT pk_akdd_main_coa PRIMARY KEY (id_akdd_main_coa);


--
-- TOC entry 2099 (class 2606 OID 30696)
-- Dependencies: 157 157
-- Name: pk_akdd_perubahan_dana; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_perubahan_dana
    ADD CONSTRAINT pk_akdd_perubahan_dana PRIMARY KEY (id_akdd_perubahan_dana);


--
-- TOC entry 2101 (class 2606 OID 30698)
-- Dependencies: 159 159
-- Name: pk_akdd_posisi_keuangan; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_posisi_keuangan
    ADD CONSTRAINT pk_akdd_posisi_keuangan PRIMARY KEY (id_akdd_posisi_keuangan);


--
-- TOC entry 2103 (class 2606 OID 30700)
-- Dependencies: 161 161
-- Name: pk_akmt_buku_besar; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akmt_buku_besar
    ADD CONSTRAINT pk_akmt_buku_besar PRIMARY KEY (id_akmt_buku_besar);


--
-- TOC entry 2106 (class 2606 OID 30702)
-- Dependencies: 163 163
-- Name: pk_akmt_jurnal; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akmt_jurnal
    ADD CONSTRAINT pk_akmt_jurnal PRIMARY KEY (id_akmt_jurnal);


--
-- TOC entry 2108 (class 2606 OID 30704)
-- Dependencies: 164 164
-- Name: pk_akmt_jurnal_det; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akmt_jurnal_det
    ADD CONSTRAINT pk_akmt_jurnal_det PRIMARY KEY (id_akmt_jurnal_det);


--
-- TOC entry 2110 (class 2606 OID 30706)
-- Dependencies: 167 167
-- Name: pk_akmt_periode; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akmt_periode
    ADD CONSTRAINT pk_akmt_periode PRIMARY KEY (id_akmt_periode);


--
-- TOC entry 2112 (class 2606 OID 30708)
-- Dependencies: 167 167 167
-- Name: unique_akmt_periode; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akmt_periode
    ADD CONSTRAINT unique_akmt_periode UNIQUE (tahun, bulan);


--
-- TOC entry 2083 (class 2606 OID 30710)
-- Dependencies: 146 146
-- Name: unique_detail_coa; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_detail_coa_lr
    ADD CONSTRAINT unique_detail_coa UNIQUE (id_akdd_detail_coa);


--
-- TOC entry 2085 (class 2606 OID 30712)
-- Dependencies: 146 146
-- Name: unique_klasifikasi_modal; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_detail_coa_lr
    ADD CONSTRAINT unique_klasifikasi_modal UNIQUE (id_akdd_klasifikasi_modal);


--
-- TOC entry 2093 (class 2606 OID 30714)
-- Dependencies: 152 152
-- Name: unique_kodifikasi_jurnal; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_kodifikasi_jurnal
    ADD CONSTRAINT unique_kodifikasi_jurnal UNIQUE (kode);


SET search_path = public, pg_catalog;

--
-- TOC entry 2114 (class 2606 OID 30716)
-- Dependencies: 169 169
-- Name: pk_dd_access; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_access
    ADD CONSTRAINT pk_dd_access PRIMARY KEY (id_dd_access);


--
-- TOC entry 2120 (class 2606 OID 30718)
-- Dependencies: 171 171
-- Name: pk_dd_groups; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_groups
    ADD CONSTRAINT pk_dd_groups PRIMARY KEY (id_dd_groups);


--
-- TOC entry 2126 (class 2606 OID 30720)
-- Dependencies: 175 175
-- Name: pk_dd_menus; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_menus
    ADD CONSTRAINT pk_dd_menus PRIMARY KEY (id_dd_menus);


--
-- TOC entry 2132 (class 2606 OID 30722)
-- Dependencies: 177 177
-- Name: pk_dd_moduls; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_moduls
    ADD CONSTRAINT pk_dd_moduls PRIMARY KEY (id_dd_moduls);


--
-- TOC entry 2138 (class 2606 OID 30724)
-- Dependencies: 179 179
-- Name: pk_dd_sub_menus; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_sub_menus
    ADD CONSTRAINT pk_dd_sub_menus PRIMARY KEY (id_dd_sub_menus);


--
-- TOC entry 2144 (class 2606 OID 30726)
-- Dependencies: 181 181
-- Name: pk_dd_tabs; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_tabs
    ADD CONSTRAINT pk_dd_tabs PRIMARY KEY (id_dd_tabs);


--
-- TOC entry 2150 (class 2606 OID 30728)
-- Dependencies: 183 183
-- Name: pk_dd_users; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_users
    ADD CONSTRAINT pk_dd_users PRIMARY KEY (id_dd_users);


--
-- TOC entry 2124 (class 2606 OID 30730)
-- Dependencies: 172 172
-- Name: pk_groups_detail; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_groups_detail
    ADD CONSTRAINT pk_groups_detail PRIMARY KEY (id_dd_groups_detail);


--
-- TOC entry 2116 (class 2606 OID 30732)
-- Dependencies: 169 169
-- Name: unique2_access; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_access
    ADD CONSTRAINT unique2_access UNIQUE (access_code);


--
-- TOC entry 2128 (class 2606 OID 30734)
-- Dependencies: 175 175 175 175
-- Name: unique2_menus; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_menus
    ADD CONSTRAINT unique2_menus UNIQUE (id_dd_moduls, menu, order_number);


--
-- TOC entry 2134 (class 2606 OID 30736)
-- Dependencies: 177 177
-- Name: unique2_moduls; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_moduls
    ADD CONSTRAINT unique2_moduls UNIQUE (order_number);


--
-- TOC entry 2140 (class 2606 OID 30738)
-- Dependencies: 179 179 179 179
-- Name: unique2_sub_menus; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_sub_menus
    ADD CONSTRAINT unique2_sub_menus UNIQUE (id_dd_menus, sub_menu, order_number);


--
-- TOC entry 2146 (class 2606 OID 30740)
-- Dependencies: 181 181
-- Name: unique2_tabs; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_tabs
    ADD CONSTRAINT unique2_tabs UNIQUE (url);


--
-- TOC entry 2118 (class 2606 OID 30742)
-- Dependencies: 169 169
-- Name: unique_access; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_access
    ADD CONSTRAINT unique_access UNIQUE (access_name);


--
-- TOC entry 2152 (class 2606 OID 30744)
-- Dependencies: 183 183
-- Name: unique_dd_users; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_users
    ADD CONSTRAINT unique_dd_users UNIQUE (username);


--
-- TOC entry 2122 (class 2606 OID 30746)
-- Dependencies: 171 171
-- Name: unique_groups; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_groups
    ADD CONSTRAINT unique_groups UNIQUE (group_name);


--
-- TOC entry 2130 (class 2606 OID 30748)
-- Dependencies: 175 175 175
-- Name: unique_menus; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_menus
    ADD CONSTRAINT unique_menus UNIQUE (id_dd_moduls, menu);


--
-- TOC entry 2136 (class 2606 OID 30750)
-- Dependencies: 177 177
-- Name: unique_moduls; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_moduls
    ADD CONSTRAINT unique_moduls UNIQUE (modul);


--
-- TOC entry 2142 (class 2606 OID 30752)
-- Dependencies: 179 179 179
-- Name: unique_sub_menus; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_sub_menus
    ADD CONSTRAINT unique_sub_menus UNIQUE (id_dd_menus, sub_menu);


--
-- TOC entry 2148 (class 2606 OID 30754)
-- Dependencies: 181 181 181
-- Name: unique_tabs; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_tabs
    ADD CONSTRAINT unique_tabs UNIQUE (id_dd_sub_menus, tab);


SET search_path = trans, pg_catalog;

--
-- TOC entry 2154 (class 2606 OID 30756)
-- Dependencies: 185 185
-- Name: pk_bank; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY bank
    ADD CONSTRAINT pk_bank PRIMARY KEY (id_bank);


--
-- TOC entry 2190 (class 2606 OID 32497)
-- Dependencies: 207 207
-- Name: pk_jenis_transaksi; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY jenis_transaksi
    ADD CONSTRAINT pk_jenis_transaksi PRIMARY KEY (id_jenis_transaksi);


--
-- TOC entry 2186 (class 2606 OID 32437)
-- Dependencies: 205 205
-- Name: pk_klasifikasi_penerima; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY klasifikasi_penerima
    ADD CONSTRAINT pk_klasifikasi_penerima PRIMARY KEY (id_klasifikasi_penerima);


--
-- TOC entry 2166 (class 2606 OID 31791)
-- Dependencies: 192 192
-- Name: pk_kode_kas; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY kode_kas
    ADD CONSTRAINT pk_kode_kas PRIMARY KEY (id_kode_kas);


--
-- TOC entry 2158 (class 2606 OID 30766)
-- Dependencies: 187 187
-- Name: pk_kota; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY kota
    ADD CONSTRAINT pk_kota PRIMARY KEY (id_kota);


--
-- TOC entry 2194 (class 2606 OID 32520)
-- Dependencies: 209 209
-- Name: pk_mapping_kode_akun; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mapping_kode_akun
    ADD CONSTRAINT pk_mapping_kode_akun PRIMARY KEY (id_mapping_kode_akun);


--
-- TOC entry 2208 (class 2606 OID 32639)
-- Dependencies: 219 219
-- Name: pk_mapping_penerima; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mapping_penerima
    ADD CONSTRAINT pk_mapping_penerima PRIMARY KEY (id_mapping_penerima);


--
-- TOC entry 2198 (class 2606 OID 32547)
-- Dependencies: 211 211
-- Name: pk_mapping_rekening; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mapping_rekening
    ADD CONSTRAINT pk_mapping_rekening PRIMARY KEY (id_mapping_rekening);


--
-- TOC entry 2184 (class 2606 OID 32376)
-- Dependencies: 200 200
-- Name: pk_mapping_transaksi_jurnal; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mapping_transaksi_jurnal
    ADD CONSTRAINT pk_mapping_transaksi_jurnal PRIMARY KEY (id_mapping_transaksi_jurnal);


--
-- TOC entry 2202 (class 2606 OID 32593)
-- Dependencies: 215 215
-- Name: pk_mapping_transaksi_penerima; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mapping_transaksi_penerima
    ADD CONSTRAINT pk_mapping_transaksi_penerima PRIMARY KEY (id_mapping_transaksi_penerima);


--
-- TOC entry 2204 (class 2606 OID 32619)
-- Dependencies: 217 217
-- Name: pk_pihak_penerima; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pihak_penerima
    ADD CONSTRAINT pk_pihak_penerima PRIMARY KEY (id_pihak_penerima);


--
-- TOC entry 2162 (class 2606 OID 30770)
-- Dependencies: 189 189
-- Name: pk_propinsi; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY propinsi
    ADD CONSTRAINT pk_propinsi PRIMARY KEY (id_propinsi);


--
-- TOC entry 2180 (class 2606 OID 32099)
-- Dependencies: 198 198
-- Name: pk_rekening_bank; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY rekening_bank
    ADD CONSTRAINT pk_rekening_bank PRIMARY KEY (id_rekening_bank);


--
-- TOC entry 2172 (class 2606 OID 31817)
-- Dependencies: 194 194
-- Name: pk_sub_kode_kas; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sub_kode_kas
    ADD CONSTRAINT pk_sub_kode_kas PRIMARY KEY (id_sub_kode_kas);


--
-- TOC entry 2200 (class 2606 OID 32570)
-- Dependencies: 213 213
-- Name: pk_sub_transaksi; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sub_transaksi
    ADD CONSTRAINT pk_sub_transaksi PRIMARY KEY (id_sub_transaksi);


--
-- TOC entry 2178 (class 2606 OID 31936)
-- Dependencies: 196 196
-- Name: pk_transaksi; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY transaksi
    ADD CONSTRAINT pk_transaksi PRIMARY KEY (id_transaksi);


--
-- TOC entry 2196 (class 2606 OID 32522)
-- Dependencies: 209 209 209
-- Name: unique_akdd_detail_coa_jenis_transaksi_mapping_kode_akun; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mapping_kode_akun
    ADD CONSTRAINT unique_akdd_detail_coa_jenis_transaksi_mapping_kode_akun UNIQUE (id_jenis_transaksi, id_akdd_detail_coa);


--
-- TOC entry 2168 (class 2606 OID 31800)
-- Dependencies: 192 192
-- Name: unique_kas_kode_kas; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY kode_kas
    ADD CONSTRAINT unique_kas_kode_kas UNIQUE (kas);


--
-- TOC entry 2188 (class 2606 OID 32439)
-- Dependencies: 205 205
-- Name: unique_klasifikasi_klasifikasi_penerima; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY klasifikasi_penerima
    ADD CONSTRAINT unique_klasifikasi_klasifikasi_penerima UNIQUE (klasifikasi);


--
-- TOC entry 2170 (class 2606 OID 31798)
-- Dependencies: 192 192
-- Name: unique_kode_kode_kas; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY kode_kas
    ADD CONSTRAINT unique_kode_kode_kas UNIQUE (kode);


--
-- TOC entry 2206 (class 2606 OID 32621)
-- Dependencies: 217 217 217
-- Name: unique_nama_alamat_pihak_penerima; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pihak_penerima
    ADD CONSTRAINT unique_nama_alamat_pihak_penerima UNIQUE (nama, alamat);


--
-- TOC entry 2156 (class 2606 OID 30784)
-- Dependencies: 185 185
-- Name: unique_nama_bank; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY bank
    ADD CONSTRAINT unique_nama_bank UNIQUE (nama);


--
-- TOC entry 2160 (class 2606 OID 30794)
-- Dependencies: 187 187
-- Name: unique_nama_kota; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY kota
    ADD CONSTRAINT unique_nama_kota UNIQUE (nama);


--
-- TOC entry 2164 (class 2606 OID 30796)
-- Dependencies: 189 189
-- Name: unique_nama_propinsi; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY propinsi
    ADD CONSTRAINT unique_nama_propinsi UNIQUE (nama);


--
-- TOC entry 2182 (class 2606 OID 32101)
-- Dependencies: 198 198
-- Name: unique_no_rekening_rekening_bank; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY rekening_bank
    ADD CONSTRAINT unique_no_rekening_rekening_bank UNIQUE (no_rekening);


--
-- TOC entry 2174 (class 2606 OID 31819)
-- Dependencies: 194 194 194
-- Name: unique_sub_kas_kode_kas; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sub_kode_kas
    ADD CONSTRAINT unique_sub_kas_kode_kas UNIQUE (id_kode_kas, sub_kas);


--
-- TOC entry 2176 (class 2606 OID 31821)
-- Dependencies: 194 194 194
-- Name: unique_sub_kode_kode_kas; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sub_kode_kas
    ADD CONSTRAINT unique_sub_kode_kode_kas UNIQUE (id_kode_kas, kode);


--
-- TOC entry 2192 (class 2606 OID 32499)
-- Dependencies: 207 207
-- Name: unique_transaksi_jenis_transaksi; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY jenis_transaksi
    ADD CONSTRAINT unique_transaksi_jenis_transaksi UNIQUE (transaksi);


SET search_path = akun, pg_catalog;

--
-- TOC entry 2104 (class 1259 OID 30803)
-- Dependencies: 163
-- Name: index_akmt_jurnal_no_bukti; Type: INDEX; Schema: akun; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_akmt_jurnal_no_bukti ON akmt_jurnal USING btree (no_bukti);


--
-- TOC entry 2077 (class 1259 OID 30804)
-- Dependencies: 144
-- Name: index_coa_number_akdd_detail_coa; Type: INDEX; Schema: akun; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_coa_number_akdd_detail_coa ON akdd_detail_coa USING btree (coa_number);


--
-- TOC entry 2211 (class 2606 OID 30805)
-- Dependencies: 2078 144 146
-- Name: akdd_detail_coa_akdd_detail_coa_lr; Type: FK CONSTRAINT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_detail_coa_lr
    ADD CONSTRAINT akdd_detail_coa_akdd_detail_coa_lr FOREIGN KEY (id_akdd_detail_coa) REFERENCES akdd_detail_coa(id_akdd_detail_coa) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2214 (class 2606 OID 30810)
-- Dependencies: 2078 161 144
-- Name: akdd_detail_coa_akmt_buku_besar; Type: FK CONSTRAINT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akmt_buku_besar
    ADD CONSTRAINT akdd_detail_coa_akmt_buku_besar FOREIGN KEY (id_akdd_detail_coa) REFERENCES akdd_detail_coa(id_akdd_detail_coa) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2216 (class 2606 OID 30815)
-- Dependencies: 144 164 2078
-- Name: akdd_detail_coa_akmt_jurnal_det; Type: FK CONSTRAINT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akmt_jurnal_det
    ADD CONSTRAINT akdd_detail_coa_akmt_jurnal_det FOREIGN KEY (id_akdd_detail_coa) REFERENCES akdd_detail_coa(id_akdd_detail_coa) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2213 (class 2606 OID 30820)
-- Dependencies: 2078 144 148
-- Name: akdd_detail_coa_map_id_akdd_detail_coa_fkey; Type: FK CONSTRAINT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_detail_coa_map
    ADD CONSTRAINT akdd_detail_coa_map_id_akdd_detail_coa_fkey FOREIGN KEY (id_akdd_detail_coa) REFERENCES akdd_detail_coa(id_akdd_detail_coa);


--
-- TOC entry 2212 (class 2606 OID 30825)
-- Dependencies: 150 146 2088
-- Name: akdd_klasifikasi_modal_akdd_detail_coa_lr; Type: FK CONSTRAINT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_detail_coa_lr
    ADD CONSTRAINT akdd_klasifikasi_modal_akdd_detail_coa_lr FOREIGN KEY (id_akdd_klasifikasi_modal) REFERENCES akdd_klasifikasi_modal(id_akdd_klasifikasi_modal) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2209 (class 2606 OID 30830)
-- Dependencies: 2094 144 153
-- Name: akdd_level_coa_akdd_main_coa; Type: FK CONSTRAINT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_detail_coa
    ADD CONSTRAINT akdd_level_coa_akdd_main_coa FOREIGN KEY (id_akdd_level_coa) REFERENCES akdd_level_coa(id_akdd_level_coa) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2210 (class 2606 OID 30835)
-- Dependencies: 155 2096 144
-- Name: akdd_main_coa_akdd_detail_coa; Type: FK CONSTRAINT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_detail_coa
    ADD CONSTRAINT akdd_main_coa_akdd_detail_coa FOREIGN KEY (id_akdd_main_coa) REFERENCES akdd_main_coa(id_akdd_main_coa) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2217 (class 2606 OID 30840)
-- Dependencies: 164 2105 163
-- Name: akmt_jurnal_akmt_jurnal_det; Type: FK CONSTRAINT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akmt_jurnal_det
    ADD CONSTRAINT akmt_jurnal_akmt_jurnal_det FOREIGN KEY (id_akmt_jurnal) REFERENCES akmt_jurnal(id_akmt_jurnal) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2215 (class 2606 OID 30845)
-- Dependencies: 161 167 2109
-- Name: akmt_periode_akmt_buku_besar; Type: FK CONSTRAINT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akmt_buku_besar
    ADD CONSTRAINT akmt_periode_akmt_buku_besar FOREIGN KEY (id_akmt_periode) REFERENCES akmt_periode(id_akmt_periode) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE;


SET search_path = public, pg_catalog;

--
-- TOC entry 2223 (class 2606 OID 30850)
-- Dependencies: 183 171 2119
-- Name: fk_dd_groups; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_users
    ADD CONSTRAINT fk_dd_groups FOREIGN KEY (id_dd_groups) REFERENCES dd_groups(id_dd_groups) ON DELETE CASCADE DEFERRABLE;


--
-- TOC entry 2218 (class 2606 OID 30855)
-- Dependencies: 2119 171 172
-- Name: fk_dd_groups; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_groups_detail
    ADD CONSTRAINT fk_dd_groups FOREIGN KEY (id_dd_groups) REFERENCES dd_groups(id_dd_groups) ON DELETE CASCADE DEFERRABLE;


--
-- TOC entry 2221 (class 2606 OID 30860)
-- Dependencies: 2125 175 179
-- Name: fk_dd_menus; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_sub_menus
    ADD CONSTRAINT fk_dd_menus FOREIGN KEY (id_dd_menus) REFERENCES dd_menus(id_dd_menus) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE;


--
-- TOC entry 2220 (class 2606 OID 30865)
-- Dependencies: 177 2131 175
-- Name: fk_dd_moduls; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_menus
    ADD CONSTRAINT fk_dd_moduls FOREIGN KEY (id_dd_moduls) REFERENCES dd_moduls(id_dd_moduls) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE;


--
-- TOC entry 2222 (class 2606 OID 30870)
-- Dependencies: 2137 179 181
-- Name: fk_dd_sub_menus; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_tabs
    ADD CONSTRAINT fk_dd_sub_menus FOREIGN KEY (id_dd_sub_menus) REFERENCES dd_sub_menus(id_dd_sub_menus) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE;


--
-- TOC entry 2219 (class 2606 OID 30875)
-- Dependencies: 172 2143 181
-- Name: fk_dd_tabs; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_groups_detail
    ADD CONSTRAINT fk_dd_tabs FOREIGN KEY (id_dd_tabs) REFERENCES dd_tabs(id_dd_tabs) ON DELETE CASCADE DEFERRABLE;


SET search_path = trans, pg_catalog;

--
-- TOC entry 2224 (class 2606 OID 30880)
-- Dependencies: 183 185 2149
-- Name: fk_bank_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY bank
    ADD CONSTRAINT fk_bank_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2225 (class 2606 OID 30885)
-- Dependencies: 187 185 2157
-- Name: fk_bank_kota; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY bank
    ADD CONSTRAINT fk_bank_kota FOREIGN KEY (id_kota) REFERENCES kota(id_kota) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2239 (class 2606 OID 32500)
-- Dependencies: 207 183 2149
-- Name: fk_jenis_transaksi_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY jenis_transaksi
    ADD CONSTRAINT fk_jenis_transaksi_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2240 (class 2606 OID 32505)
-- Dependencies: 2171 194 207
-- Name: fk_jenis_transaksi_sub_kode_kas; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY jenis_transaksi
    ADD CONSTRAINT fk_jenis_transaksi_sub_kode_kas FOREIGN KEY (id_sub_kode_kas) REFERENCES sub_kode_kas(id_sub_kode_kas) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2238 (class 2606 OID 32440)
-- Dependencies: 2149 183 205
-- Name: fk_klasifikasi_penerima_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY klasifikasi_penerima
    ADD CONSTRAINT fk_klasifikasi_penerima_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2229 (class 2606 OID 31792)
-- Dependencies: 192 2149 183
-- Name: fk_kode_kas_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY kode_kas
    ADD CONSTRAINT fk_kode_kas_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2226 (class 2606 OID 30930)
-- Dependencies: 183 187 2149
-- Name: fk_kota_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY kota
    ADD CONSTRAINT fk_kota_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2227 (class 2606 OID 30935)
-- Dependencies: 189 187 2161
-- Name: fk_kota_propinsi; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY kota
    ADD CONSTRAINT fk_kota_propinsi FOREIGN KEY (id_propinsi) REFERENCES propinsi(id_propinsi) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2241 (class 2606 OID 32525)
-- Dependencies: 2078 209 144
-- Name: fk_mapping_kode_akun_akdd_detail_coa; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_kode_akun
    ADD CONSTRAINT fk_mapping_kode_akun_akdd_detail_coa FOREIGN KEY (id_akdd_detail_coa) REFERENCES akun.akdd_detail_coa(id_akdd_detail_coa) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2242 (class 2606 OID 32530)
-- Dependencies: 2149 209 183
-- Name: fk_mapping_kode_akun_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_kode_akun
    ADD CONSTRAINT fk_mapping_kode_akun_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2243 (class 2606 OID 32535)
-- Dependencies: 209 207 2189
-- Name: fk_mapping_kode_akun_jenis_transaksi; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_kode_akun
    ADD CONSTRAINT fk_mapping_kode_akun_jenis_transaksi FOREIGN KEY (id_jenis_transaksi) REFERENCES jenis_transaksi(id_jenis_transaksi) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2256 (class 2606 OID 32640)
-- Dependencies: 183 219 2149
-- Name: fk_mapping_penerima_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_penerima
    ADD CONSTRAINT fk_mapping_penerima_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2257 (class 2606 OID 32645)
-- Dependencies: 2203 217 219
-- Name: fk_mapping_penerima_pihak_penerima; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_penerima
    ADD CONSTRAINT fk_mapping_penerima_pihak_penerima FOREIGN KEY (id_pihak_penerima) REFERENCES pihak_penerima(id_pihak_penerima) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2255 (class 2606 OID 32672)
-- Dependencies: 219 196 2177
-- Name: fk_mapping_penerima_transaksi; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_penerima
    ADD CONSTRAINT fk_mapping_penerima_transaksi FOREIGN KEY (id_transaksi) REFERENCES transaksi(id_transaksi) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE;


--
-- TOC entry 2244 (class 2606 OID 32548)
-- Dependencies: 183 211 2149
-- Name: fk_mapping_rekening_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_rekening
    ADD CONSTRAINT fk_mapping_rekening_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2245 (class 2606 OID 32553)
-- Dependencies: 209 2193 211
-- Name: fk_mapping_rekening_mapping_kode_akun; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_rekening
    ADD CONSTRAINT fk_mapping_rekening_mapping_kode_akun FOREIGN KEY (id_mapping_kode_akun) REFERENCES mapping_kode_akun(id_mapping_kode_akun) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2246 (class 2606 OID 32558)
-- Dependencies: 2179 211 198
-- Name: fk_mapping_rekening_rekening_bank; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_rekening
    ADD CONSTRAINT fk_mapping_rekening_rekening_bank FOREIGN KEY (id_rekening_bank) REFERENCES rekening_bank(id_rekening_bank) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2235 (class 2606 OID 32655)
-- Dependencies: 2105 163 200
-- Name: fk_mapping_transaksi_jurnal_akmt_jurnal; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_transaksi_jurnal
    ADD CONSTRAINT fk_mapping_transaksi_jurnal_akmt_jurnal FOREIGN KEY (id_akmt_jurnal) REFERENCES akun.akmt_jurnal(id_akmt_jurnal) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE;


--
-- TOC entry 2237 (class 2606 OID 32387)
-- Dependencies: 2149 200 183
-- Name: fk_mapping_transaksi_jurnal_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_transaksi_jurnal
    ADD CONSTRAINT fk_mapping_transaksi_jurnal_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2236 (class 2606 OID 32377)
-- Dependencies: 2177 196 200
-- Name: fk_mapping_transaksi_jurnal_transaksi; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_transaksi_jurnal
    ADD CONSTRAINT fk_mapping_transaksi_jurnal_transaksi FOREIGN KEY (id_transaksi) REFERENCES transaksi(id_transaksi) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2250 (class 2606 OID 32594)
-- Dependencies: 2149 183 215
-- Name: fk_mapping_transaksi_penerima_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_transaksi_penerima
    ADD CONSTRAINT fk_mapping_transaksi_penerima_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2251 (class 2606 OID 32599)
-- Dependencies: 215 207 2189
-- Name: fk_mapping_transaksi_penerima_jenis_transaksi; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_transaksi_penerima
    ADD CONSTRAINT fk_mapping_transaksi_penerima_jenis_transaksi FOREIGN KEY (id_jenis_transaksi) REFERENCES jenis_transaksi(id_jenis_transaksi) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2252 (class 2606 OID 32604)
-- Dependencies: 205 2185 215
-- Name: fk_mapping_transaksi_penerima_klasifikasi_penerima; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY mapping_transaksi_penerima
    ADD CONSTRAINT fk_mapping_transaksi_penerima_klasifikasi_penerima FOREIGN KEY (id_klasifikasi_penerima) REFERENCES klasifikasi_penerima(id_klasifikasi_penerima) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2253 (class 2606 OID 32622)
-- Dependencies: 217 183 2149
-- Name: fk_pihak_penerima_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY pihak_penerima
    ADD CONSTRAINT fk_pihak_penerima_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2254 (class 2606 OID 32627)
-- Dependencies: 217 2185 205
-- Name: fk_pihak_penerima_klasifikasi_penerima; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY pihak_penerima
    ADD CONSTRAINT fk_pihak_penerima_klasifikasi_penerima FOREIGN KEY (id_klasifikasi_penerima) REFERENCES klasifikasi_penerima(id_klasifikasi_penerima) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2228 (class 2606 OID 30955)
-- Dependencies: 189 2149 183
-- Name: fk_propinsi_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY propinsi
    ADD CONSTRAINT fk_propinsi_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2233 (class 2606 OID 32102)
-- Dependencies: 185 2153 198
-- Name: fk_rekening_bank_bank; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY rekening_bank
    ADD CONSTRAINT fk_rekening_bank_bank FOREIGN KEY (id_bank) REFERENCES bank(id_bank) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2234 (class 2606 OID 32107)
-- Dependencies: 198 183 2149
-- Name: fk_rekening_bank_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY rekening_bank
    ADD CONSTRAINT fk_rekening_bank_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2230 (class 2606 OID 31822)
-- Dependencies: 2165 194 192
-- Name: fk_sub_kode_Kas_kode_kas; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY sub_kode_kas
    ADD CONSTRAINT "fk_sub_kode_Kas_kode_kas" FOREIGN KEY (id_kode_kas) REFERENCES kode_kas(id_kode_kas) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2231 (class 2606 OID 31827)
-- Dependencies: 2149 183 194
-- Name: fk_sub_kode_kas_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY sub_kode_kas
    ADD CONSTRAINT fk_sub_kode_kas_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2247 (class 2606 OID 32571)
-- Dependencies: 2149 213 183
-- Name: fk_sub_transaksi_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY sub_transaksi
    ADD CONSTRAINT fk_sub_transaksi_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2248 (class 2606 OID 32576)
-- Dependencies: 213 209 2193
-- Name: fk_sub_transaksi_mapping_kode_akun; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY sub_transaksi
    ADD CONSTRAINT fk_sub_transaksi_mapping_kode_akun FOREIGN KEY (id_mapping_kode_akun) REFERENCES mapping_kode_akun(id_mapping_kode_akun) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2249 (class 2606 OID 32581)
-- Dependencies: 2177 213 196
-- Name: fk_sub_transaksi_transaksi; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY sub_transaksi
    ADD CONSTRAINT fk_sub_transaksi_transaksi FOREIGN KEY (id_transaksi) REFERENCES transaksi(id_transaksi) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2232 (class 2606 OID 31937)
-- Dependencies: 2149 183 196
-- Name: fk_transaksi_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY transaksi
    ADD CONSTRAINT fk_transaksi_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2301 (class 0 OID 0)
-- Dependencies: 8
-- Name: public; Type: ACL; Schema: -; Owner: -
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO opensolutions;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2012-04-15 01:59:12 WIT

--
-- PostgreSQL database dump complete
--

