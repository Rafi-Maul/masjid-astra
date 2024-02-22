--
-- PostgreSQL database dump
--

-- Started on 2011-11-29 05:01:24

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 8 (class 2615 OID 30809)
-- Name: akun; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA akun;


--
-- TOC entry 2213 (class 0 OID 0)
-- Dependencies: 8
-- Name: SCHEMA akun; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA akun IS 'Skema untuk akuntansi.';


--
-- TOC entry 7 (class 2615 OID 30303)
-- Name: trans; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA trans;


--
-- TOC entry 2216 (class 0 OID 0)
-- Dependencies: 7
-- Name: SCHEMA trans; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA trans IS 'Skema untuk transaksi.';


--
-- TOC entry 608 (class 2612 OID 30183)
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: -
--

CREATE PROCEDURAL LANGUAGE plpgsql;


SET search_path = akun, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 189 (class 1259 OID 30847)
-- Dependencies: 1996 1997 8
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
-- TOC entry 2217 (class 0 OID 0)
-- Dependencies: 189
-- Name: TABLE akdd_arus_kas; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akdd_arus_kas IS 'Tabel yang berfungsi sebagai template laporan arus kas.';


--
-- TOC entry 188 (class 1259 OID 30845)
-- Dependencies: 8 189
-- Name: akdd_arus_kas_id_akdd_arus_kas_seq; Type: SEQUENCE; Schema: akun; Owner: -
--

CREATE SEQUENCE akdd_arus_kas_id_akdd_arus_kas_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2218 (class 0 OID 0)
-- Dependencies: 188
-- Name: akdd_arus_kas_id_akdd_arus_kas_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akdd_arus_kas_id_akdd_arus_kas_seq OWNED BY akdd_arus_kas.id_akdd_arus_kas;


--
-- TOC entry 2219 (class 0 OID 0)
-- Dependencies: 188
-- Name: akdd_arus_kas_id_akdd_arus_kas_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akdd_arus_kas_id_akdd_arus_kas_seq', 1, false);


--
-- TOC entry 187 (class 1259 OID 30828)
-- Dependencies: 8
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
-- TOC entry 2220 (class 0 OID 0)
-- Dependencies: 187
-- Name: TABLE akdd_detail_coa; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akdd_detail_coa IS 'Data-data detail COA.';


--
-- TOC entry 186 (class 1259 OID 30826)
-- Dependencies: 8 187
-- Name: akdd_detail_coa_id_akdd_detail_coa_seq; Type: SEQUENCE; Schema: akun; Owner: -
--

CREATE SEQUENCE akdd_detail_coa_id_akdd_detail_coa_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2221 (class 0 OID 0)
-- Dependencies: 186
-- Name: akdd_detail_coa_id_akdd_detail_coa_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akdd_detail_coa_id_akdd_detail_coa_seq OWNED BY akdd_detail_coa.id_akdd_detail_coa;


--
-- TOC entry 2222 (class 0 OID 0)
-- Dependencies: 186
-- Name: akdd_detail_coa_id_akdd_detail_coa_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akdd_detail_coa_id_akdd_detail_coa_seq', 1, false);


--
-- TOC entry 193 (class 1259 OID 30868)
-- Dependencies: 8
-- Name: akdd_detail_coa_lr; Type: TABLE; Schema: akun; Owner: -; Tablespace: 
--

CREATE TABLE akdd_detail_coa_lr (
    id_akdd_detail_coa_lr integer NOT NULL,
    id_akdd_detail_coa integer NOT NULL,
    id_akdd_klasifikasi_modal integer NOT NULL,
    sub_coa character varying(255) NOT NULL
);


--
-- TOC entry 2223 (class 0 OID 0)
-- Dependencies: 193
-- Name: TABLE akdd_detail_coa_lr; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akdd_detail_coa_lr IS 'Data-data klasifikasi modal (sistem jurnal penutup automatis).';


--
-- TOC entry 192 (class 1259 OID 30866)
-- Dependencies: 193 8
-- Name: akdd_detail_coa_lr_id_akdd_detail_coa_lr_seq; Type: SEQUENCE; Schema: akun; Owner: -
--

CREATE SEQUENCE akdd_detail_coa_lr_id_akdd_detail_coa_lr_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2224 (class 0 OID 0)
-- Dependencies: 192
-- Name: akdd_detail_coa_lr_id_akdd_detail_coa_lr_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akdd_detail_coa_lr_id_akdd_detail_coa_lr_seq OWNED BY akdd_detail_coa_lr.id_akdd_detail_coa_lr;


--
-- TOC entry 2225 (class 0 OID 0)
-- Dependencies: 192
-- Name: akdd_detail_coa_lr_id_akdd_detail_coa_lr_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akdd_detail_coa_lr_id_akdd_detail_coa_lr_seq', 1, false);


--
-- TOC entry 195 (class 1259 OID 30904)
-- Dependencies: 2001 8
-- Name: akdd_detail_coa_map; Type: TABLE; Schema: akun; Owner: -; Tablespace: 
--

CREATE TABLE akdd_detail_coa_map (
    id_akdd_detail_coa_map integer NOT NULL,
    id_akdd_detail_coa integer NOT NULL,
    flag smallint DEFAULT 0 NOT NULL
);


--
-- TOC entry 2226 (class 0 OID 0)
-- Dependencies: 195
-- Name: TABLE akdd_detail_coa_map; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akdd_detail_coa_map IS 'Tabel mapping coa yg masuk di pemasukan, pengeluaran, dan jurnal umum.';


--
-- TOC entry 2227 (class 0 OID 0)
-- Dependencies: 195
-- Name: COLUMN akdd_detail_coa_map.flag; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON COLUMN akdd_detail_coa_map.flag IS '0: JU
1: JU + JP
2: JU + JB
3: JU + JP + JB';


--
-- TOC entry 194 (class 1259 OID 30902)
-- Dependencies: 8 195
-- Name: akdd_detail_coa_map_id_akdd_detail_coa_map_seq; Type: SEQUENCE; Schema: akun; Owner: -
--

CREATE SEQUENCE akdd_detail_coa_map_id_akdd_detail_coa_map_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2228 (class 0 OID 0)
-- Dependencies: 194
-- Name: akdd_detail_coa_map_id_akdd_detail_coa_map_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akdd_detail_coa_map_id_akdd_detail_coa_map_seq OWNED BY akdd_detail_coa_map.id_akdd_detail_coa_map;


--
-- TOC entry 2229 (class 0 OID 0)
-- Dependencies: 194
-- Name: akdd_detail_coa_map_id_akdd_detail_coa_map_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akdd_detail_coa_map_id_akdd_detail_coa_map_seq', 1, false);


--
-- TOC entry 191 (class 1259 OID 30860)
-- Dependencies: 8
-- Name: akdd_klasifikasi_modal; Type: TABLE; Schema: akun; Owner: -; Tablespace: 
--

CREATE TABLE akdd_klasifikasi_modal (
    id_akdd_klasifikasi_modal integer NOT NULL,
    binary_code smallint NOT NULL,
    klasifikasi character varying(50) NOT NULL,
    uraian character varying(255)
);


--
-- TOC entry 2230 (class 0 OID 0)
-- Dependencies: 191
-- Name: TABLE akdd_klasifikasi_modal; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akdd_klasifikasi_modal IS 'Data-data klasifikasi modal.';


--
-- TOC entry 190 (class 1259 OID 30858)
-- Dependencies: 8 191
-- Name: akdd_klasifikasi_modal_id_akdd_klasifikasi_modal_seq; Type: SEQUENCE; Schema: akun; Owner: -
--

CREATE SEQUENCE akdd_klasifikasi_modal_id_akdd_klasifikasi_modal_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2231 (class 0 OID 0)
-- Dependencies: 190
-- Name: akdd_klasifikasi_modal_id_akdd_klasifikasi_modal_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akdd_klasifikasi_modal_id_akdd_klasifikasi_modal_seq OWNED BY akdd_klasifikasi_modal.id_akdd_klasifikasi_modal;


--
-- TOC entry 2232 (class 0 OID 0)
-- Dependencies: 190
-- Name: akdd_klasifikasi_modal_id_akdd_klasifikasi_modal_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akdd_klasifikasi_modal_id_akdd_klasifikasi_modal_seq', 1, false);


--
-- TOC entry 196 (class 1259 OID 30923)
-- Dependencies: 8
-- Name: akdd_kodifikasi_jurnal; Type: TABLE; Schema: akun; Owner: -; Tablespace: 
--

CREATE TABLE akdd_kodifikasi_jurnal (
    id_akdd_kodifikasi_jurnal integer NOT NULL,
    kode character(2) NOT NULL,
    notes character varying(255)
);


--
-- TOC entry 2233 (class 0 OID 0)
-- Dependencies: 196
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
-- TOC entry 185 (class 1259 OID 30820)
-- Dependencies: 8
-- Name: akdd_level_coa; Type: TABLE; Schema: akun; Owner: -; Tablespace: 
--

CREATE TABLE akdd_level_coa (
    id_akdd_level_coa integer NOT NULL,
    level_number smallint NOT NULL,
    level_length smallint NOT NULL,
    uraian character varying(255)
);


--
-- TOC entry 2234 (class 0 OID 0)
-- Dependencies: 185
-- Name: TABLE akdd_level_coa; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akdd_level_coa IS 'Data level COA.';


--
-- TOC entry 184 (class 1259 OID 30818)
-- Dependencies: 185 8
-- Name: akdd_level_coa_id_akdd_level_coa_seq; Type: SEQUENCE; Schema: akun; Owner: -
--

CREATE SEQUENCE akdd_level_coa_id_akdd_level_coa_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2235 (class 0 OID 0)
-- Dependencies: 184
-- Name: akdd_level_coa_id_akdd_level_coa_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akdd_level_coa_id_akdd_level_coa_seq OWNED BY akdd_level_coa.id_akdd_level_coa;


--
-- TOC entry 2236 (class 0 OID 0)
-- Dependencies: 184
-- Name: akdd_level_coa_id_akdd_level_coa_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akdd_level_coa_id_akdd_level_coa_seq', 1, false);


--
-- TOC entry 183 (class 1259 OID 30812)
-- Dependencies: 8
-- Name: akdd_main_coa; Type: TABLE; Schema: akun; Owner: -; Tablespace: 
--

CREATE TABLE akdd_main_coa (
    id_akdd_main_coa integer NOT NULL,
    acc_type character(1) NOT NULL,
    binary_code smallint NOT NULL,
    uraian character varying(50) NOT NULL
);


--
-- TOC entry 2237 (class 0 OID 0)
-- Dependencies: 183
-- Name: TABLE akdd_main_coa; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akdd_main_coa IS 'Data kategori utama COA.';


--
-- TOC entry 182 (class 1259 OID 30810)
-- Dependencies: 183 8
-- Name: akdd_main_coa_id_akdd_main_coa_seq; Type: SEQUENCE; Schema: akun; Owner: -
--

CREATE SEQUENCE akdd_main_coa_id_akdd_main_coa_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2238 (class 0 OID 0)
-- Dependencies: 182
-- Name: akdd_main_coa_id_akdd_main_coa_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akdd_main_coa_id_akdd_main_coa_seq OWNED BY akdd_main_coa.id_akdd_main_coa;


--
-- TOC entry 2239 (class 0 OID 0)
-- Dependencies: 182
-- Name: akdd_main_coa_id_akdd_main_coa_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akdd_main_coa_id_akdd_main_coa_seq', 1, false);


--
-- TOC entry 198 (class 1259 OID 30932)
-- Dependencies: 8
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
-- TOC entry 2240 (class 0 OID 0)
-- Dependencies: 198
-- Name: TABLE akdd_perubahan_dana; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akdd_perubahan_dana IS 'Data template perubahan dana.';


--
-- TOC entry 197 (class 1259 OID 30930)
-- Dependencies: 8 198
-- Name: akdd_perubahan_dana_id_akdd_perubahan_dana_seq; Type: SEQUENCE; Schema: akun; Owner: -
--

CREATE SEQUENCE akdd_perubahan_dana_id_akdd_perubahan_dana_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2241 (class 0 OID 0)
-- Dependencies: 197
-- Name: akdd_perubahan_dana_id_akdd_perubahan_dana_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akdd_perubahan_dana_id_akdd_perubahan_dana_seq OWNED BY akdd_perubahan_dana.id_akdd_perubahan_dana;


--
-- TOC entry 2242 (class 0 OID 0)
-- Dependencies: 197
-- Name: akdd_perubahan_dana_id_akdd_perubahan_dana_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akdd_perubahan_dana_id_akdd_perubahan_dana_seq', 1, false);


--
-- TOC entry 200 (class 1259 OID 30944)
-- Dependencies: 2004 8
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
-- TOC entry 2243 (class 0 OID 0)
-- Dependencies: 200
-- Name: TABLE akdd_posisi_keuangan; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akdd_posisi_keuangan IS 'Tabel yang berfungsi sebagai template laporan posisi keuangan.';


--
-- TOC entry 199 (class 1259 OID 30942)
-- Dependencies: 8 200
-- Name: akdd_posisi_keuangan_id_akdd_posisi_keuangan_seq; Type: SEQUENCE; Schema: akun; Owner: -
--

CREATE SEQUENCE akdd_posisi_keuangan_id_akdd_posisi_keuangan_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2244 (class 0 OID 0)
-- Dependencies: 199
-- Name: akdd_posisi_keuangan_id_akdd_posisi_keuangan_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akdd_posisi_keuangan_id_akdd_posisi_keuangan_seq OWNED BY akdd_posisi_keuangan.id_akdd_posisi_keuangan;


--
-- TOC entry 2245 (class 0 OID 0)
-- Dependencies: 199
-- Name: akdd_posisi_keuangan_id_akdd_posisi_keuangan_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akdd_posisi_keuangan_id_akdd_posisi_keuangan_seq', 1, false);


--
-- TOC entry 204 (class 1259 OID 30966)
-- Dependencies: 8
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
-- TOC entry 2246 (class 0 OID 0)
-- Dependencies: 204
-- Name: TABLE akmt_buku_besar; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akmt_buku_besar IS 'Data saldo-saldo COA.';


--
-- TOC entry 203 (class 1259 OID 30964)
-- Dependencies: 8 204
-- Name: akmt_buku_besar_id_akmt_buku_besar_seq; Type: SEQUENCE; Schema: akun; Owner: -
--

CREATE SEQUENCE akmt_buku_besar_id_akmt_buku_besar_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2247 (class 0 OID 0)
-- Dependencies: 203
-- Name: akmt_buku_besar_id_akmt_buku_besar_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akmt_buku_besar_id_akmt_buku_besar_seq OWNED BY akmt_buku_besar.id_akmt_buku_besar;


--
-- TOC entry 2248 (class 0 OID 0)
-- Dependencies: 203
-- Name: akmt_buku_besar_id_akmt_buku_besar_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akmt_buku_besar_id_akmt_buku_besar_seq', 1, false);


--
-- TOC entry 206 (class 1259 OID 30984)
-- Dependencies: 8
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
-- TOC entry 2249 (class 0 OID 0)
-- Dependencies: 206
-- Name: TABLE akmt_jurnal; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akmt_jurnal IS 'Data jurnal.';


--
-- TOC entry 2250 (class 0 OID 0)
-- Dependencies: 206
-- Name: COLUMN akmt_jurnal.flag_jurnal; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON COLUMN akmt_jurnal.flag_jurnal IS '
0 = Jurnal umum
1 = Jurnal mapping';


--
-- TOC entry 2251 (class 0 OID 0)
-- Dependencies: 206
-- Name: COLUMN akmt_jurnal.flag_temp; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON COLUMN akmt_jurnal.flag_temp IS '
0 = Belum selesai
1 = Sudah selesai
2 = Sudah disetujui';


--
-- TOC entry 2252 (class 0 OID 0)
-- Dependencies: 206
-- Name: COLUMN akmt_jurnal.flag_posting; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON COLUMN akmt_jurnal.flag_posting IS '
0 = Belum posting
1 = Sudah posting sementara
2 = Sudah posting permanen';


--
-- TOC entry 208 (class 1259 OID 30993)
-- Dependencies: 2009 8
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
-- TOC entry 2253 (class 0 OID 0)
-- Dependencies: 208
-- Name: TABLE akmt_jurnal_det; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akmt_jurnal_det IS 'Data jurnal detail.';


--
-- TOC entry 2254 (class 0 OID 0)
-- Dependencies: 208
-- Name: COLUMN akmt_jurnal_det.flag_position; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON COLUMN akmt_jurnal_det.flag_position IS '
d = Debet
k = Kredit';


--
-- TOC entry 207 (class 1259 OID 30991)
-- Dependencies: 8 208
-- Name: akmt_jurnal_det_id_akmt_jurnal_det_seq; Type: SEQUENCE; Schema: akun; Owner: -
--

CREATE SEQUENCE akmt_jurnal_det_id_akmt_jurnal_det_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2255 (class 0 OID 0)
-- Dependencies: 207
-- Name: akmt_jurnal_det_id_akmt_jurnal_det_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akmt_jurnal_det_id_akmt_jurnal_det_seq OWNED BY akmt_jurnal_det.id_akmt_jurnal_det;


--
-- TOC entry 2256 (class 0 OID 0)
-- Dependencies: 207
-- Name: akmt_jurnal_det_id_akmt_jurnal_det_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akmt_jurnal_det_id_akmt_jurnal_det_seq', 1, false);


--
-- TOC entry 205 (class 1259 OID 30982)
-- Dependencies: 206 8
-- Name: akmt_jurnal_id_akmt_jurnal_seq; Type: SEQUENCE; Schema: akun; Owner: -
--

CREATE SEQUENCE akmt_jurnal_id_akmt_jurnal_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2257 (class 0 OID 0)
-- Dependencies: 205
-- Name: akmt_jurnal_id_akmt_jurnal_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akmt_jurnal_id_akmt_jurnal_seq OWNED BY akmt_jurnal.id_akmt_jurnal;


--
-- TOC entry 2258 (class 0 OID 0)
-- Dependencies: 205
-- Name: akmt_jurnal_id_akmt_jurnal_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akmt_jurnal_id_akmt_jurnal_seq', 1, false);


--
-- TOC entry 202 (class 1259 OID 30956)
-- Dependencies: 8
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
-- TOC entry 2259 (class 0 OID 0)
-- Dependencies: 202
-- Name: TABLE akmt_periode; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON TABLE akmt_periode IS 'Data periode keuangan.';


--
-- TOC entry 2260 (class 0 OID 0)
-- Dependencies: 202
-- Name: COLUMN akmt_periode.flag_temp; Type: COMMENT; Schema: akun; Owner: -
--

COMMENT ON COLUMN akmt_periode.flag_temp IS '
0 = Temporary Dirty
1 = Temporary Clean
2 = Permanent';


--
-- TOC entry 201 (class 1259 OID 30954)
-- Dependencies: 202 8
-- Name: akmt_periode_id_akmt_periode_seq; Type: SEQUENCE; Schema: akun; Owner: -
--

CREATE SEQUENCE akmt_periode_id_akmt_periode_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2261 (class 0 OID 0)
-- Dependencies: 201
-- Name: akmt_periode_id_akmt_periode_seq; Type: SEQUENCE OWNED BY; Schema: akun; Owner: -
--

ALTER SEQUENCE akmt_periode_id_akmt_periode_seq OWNED BY akmt_periode.id_akmt_periode;


--
-- TOC entry 2262 (class 0 OID 0)
-- Dependencies: 201
-- Name: akmt_periode_id_akmt_periode_seq; Type: SEQUENCE SET; Schema: akun; Owner: -
--

SELECT pg_catalog.setval('akmt_periode_id_akmt_periode_seq', 1, false);


SET search_path = public, pg_catalog;

--
-- TOC entry 142 (class 1259 OID 30184)
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
-- TOC entry 2263 (class 0 OID 0)
-- Dependencies: 142
-- Name: TABLE dd_access; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dd_access IS 'Data hak akses';


--
-- TOC entry 143 (class 1259 OID 30187)
-- Dependencies: 6 142
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
-- TOC entry 2264 (class 0 OID 0)
-- Dependencies: 143
-- Name: dd_access_id_dd_access_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dd_access_id_dd_access_seq OWNED BY dd_access.id_dd_access;


--
-- TOC entry 2265 (class 0 OID 0)
-- Dependencies: 143
-- Name: dd_access_id_dd_access_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dd_access_id_dd_access_seq', 5, true);


--
-- TOC entry 144 (class 1259 OID 30189)
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
-- TOC entry 2266 (class 0 OID 0)
-- Dependencies: 144
-- Name: TABLE dd_groups; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dd_groups IS 'Data kelompok pengguna';


--
-- TOC entry 145 (class 1259 OID 30192)
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
-- TOC entry 2267 (class 0 OID 0)
-- Dependencies: 145
-- Name: TABLE dd_groups_detail; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dd_groups_detail IS 'Data kelompok detail';


--
-- TOC entry 146 (class 1259 OID 30195)
-- Dependencies: 6 145
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
-- TOC entry 2268 (class 0 OID 0)
-- Dependencies: 146
-- Name: dd_groups_detail_id_dd_groups_detail_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dd_groups_detail_id_dd_groups_detail_seq OWNED BY dd_groups_detail.id_dd_groups_detail;


--
-- TOC entry 2269 (class 0 OID 0)
-- Dependencies: 146
-- Name: dd_groups_detail_id_dd_groups_detail_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dd_groups_detail_id_dd_groups_detail_seq', 11, true);


--
-- TOC entry 147 (class 1259 OID 30197)
-- Dependencies: 6 144
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
-- TOC entry 2270 (class 0 OID 0)
-- Dependencies: 147
-- Name: dd_groups_id_dd_groups_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dd_groups_id_dd_groups_seq OWNED BY dd_groups.id_dd_groups;


--
-- TOC entry 2271 (class 0 OID 0)
-- Dependencies: 147
-- Name: dd_groups_id_dd_groups_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dd_groups_id_dd_groups_seq', 4, true);


--
-- TOC entry 148 (class 1259 OID 30199)
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
-- TOC entry 2272 (class 0 OID 0)
-- Dependencies: 148
-- Name: TABLE dd_menus; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dd_menus IS 'Data menu';


--
-- TOC entry 149 (class 1259 OID 30202)
-- Dependencies: 148 6
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
-- TOC entry 2273 (class 0 OID 0)
-- Dependencies: 149
-- Name: dd_menus_id_dd_menus_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dd_menus_id_dd_menus_seq OWNED BY dd_menus.id_dd_menus;


--
-- TOC entry 2274 (class 0 OID 0)
-- Dependencies: 149
-- Name: dd_menus_id_dd_menus_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dd_menus_id_dd_menus_seq', 3, true);


--
-- TOC entry 150 (class 1259 OID 30204)
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
-- TOC entry 2275 (class 0 OID 0)
-- Dependencies: 150
-- Name: TABLE dd_moduls; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dd_moduls IS 'Data modul-modul';


--
-- TOC entry 151 (class 1259 OID 30207)
-- Dependencies: 6 150
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
-- TOC entry 2276 (class 0 OID 0)
-- Dependencies: 151
-- Name: dd_moduls_id_dd_moduls_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dd_moduls_id_dd_moduls_seq OWNED BY dd_moduls.id_dd_moduls;


--
-- TOC entry 2277 (class 0 OID 0)
-- Dependencies: 151
-- Name: dd_moduls_id_dd_moduls_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dd_moduls_id_dd_moduls_seq', 12, true);


--
-- TOC entry 152 (class 1259 OID 30209)
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
-- TOC entry 2278 (class 0 OID 0)
-- Dependencies: 152
-- Name: TABLE dd_sub_menus; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dd_sub_menus IS 'Data sub menu';


--
-- TOC entry 153 (class 1259 OID 30212)
-- Dependencies: 152 6
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
-- TOC entry 2279 (class 0 OID 0)
-- Dependencies: 153
-- Name: dd_sub_menus_id_dd_sub_menus_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dd_sub_menus_id_dd_sub_menus_seq OWNED BY dd_sub_menus.id_dd_sub_menus;


--
-- TOC entry 2280 (class 0 OID 0)
-- Dependencies: 153
-- Name: dd_sub_menus_id_dd_sub_menus_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dd_sub_menus_id_dd_sub_menus_seq', 3, true);


--
-- TOC entry 154 (class 1259 OID 30214)
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
-- TOC entry 2281 (class 0 OID 0)
-- Dependencies: 154
-- Name: TABLE dd_tabs; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dd_tabs IS 'Data tab-tab';


--
-- TOC entry 155 (class 1259 OID 30217)
-- Dependencies: 6 154
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
-- TOC entry 2282 (class 0 OID 0)
-- Dependencies: 155
-- Name: dd_tabs_id_dd_tabs_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dd_tabs_id_dd_tabs_seq OWNED BY dd_tabs.id_dd_tabs;


--
-- TOC entry 2283 (class 0 OID 0)
-- Dependencies: 155
-- Name: dd_tabs_id_dd_tabs_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dd_tabs_id_dd_tabs_seq', 8, true);


--
-- TOC entry 156 (class 1259 OID 30219)
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
-- TOC entry 2284 (class 0 OID 0)
-- Dependencies: 156
-- Name: TABLE dd_users; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE dd_users IS 'Data pengguna';


--
-- TOC entry 157 (class 1259 OID 30222)
-- Dependencies: 6 156
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
-- TOC entry 2285 (class 0 OID 0)
-- Dependencies: 157
-- Name: dd_users_id_dd_users_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE dd_users_id_dd_users_seq OWNED BY dd_users.id_dd_users;


--
-- TOC entry 2286 (class 0 OID 0)
-- Dependencies: 157
-- Name: dd_users_id_dd_users_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('dd_users_id_dd_users_seq', 4, true);


SET search_path = trans, pg_catalog;

--
-- TOC entry 175 (class 1259 OID 30687)
-- Dependencies: 1975 1976 7
-- Name: bank; Type: TABLE; Schema: trans; Owner: -; Tablespace: 
--

CREATE TABLE bank (
    id_bank integer NOT NULL,
    id_kota integer NOT NULL,
    id_dd_users integer NOT NULL,
    flag_history smallint DEFAULT 0 NOT NULL,
    flag_delete smallint DEFAULT 0 NOT NULL,
    nama character varying(100) NOT NULL,
    keterangan character varying(255)
);


--
-- TOC entry 2287 (class 0 OID 0)
-- Dependencies: 175
-- Name: TABLE bank; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE bank IS 'Tabel data bank.';


--
-- TOC entry 174 (class 1259 OID 30685)
-- Dependencies: 175 7
-- Name: bank_id_bank_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE bank_id_bank_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2288 (class 0 OID 0)
-- Dependencies: 174
-- Name: bank_id_bank_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE bank_id_bank_seq OWNED BY bank.id_bank;


--
-- TOC entry 2289 (class 0 OID 0)
-- Dependencies: 174
-- Name: bank_id_bank_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('bank_id_bank_seq', 1, false);


--
-- TOC entry 177 (class 1259 OID 30714)
-- Dependencies: 1978 1979 1980 1981 7
-- Name: guru_tpa; Type: TABLE; Schema: trans; Owner: -; Tablespace: 
--

CREATE TABLE guru_tpa (
    id_guru_tpa bigint NOT NULL,
    id_kategori_pengeluaran integer NOT NULL,
    id_kota integer NOT NULL,
    id_dd_users integer NOT NULL,
    flag_history smallint DEFAULT 0 NOT NULL,
    flag_delete smallint DEFAULT 0 NOT NULL,
    flag_npwp smallint DEFAULT 0 NOT NULL,
    nama character varying(100) NOT NULL,
    keterangan character varying(255),
    CONSTRAINT check_flag_npwp_guru_tpa CHECK (((flag_npwp >= 0) AND (flag_npwp <= 1)))
);


--
-- TOC entry 2290 (class 0 OID 0)
-- Dependencies: 177
-- Name: TABLE guru_tpa; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE guru_tpa IS 'Tabel guru-guru TPA.';


--
-- TOC entry 176 (class 1259 OID 30712)
-- Dependencies: 7 177
-- Name: guru_tpa_id_guru_tpa_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE guru_tpa_id_guru_tpa_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2291 (class 0 OID 0)
-- Dependencies: 176
-- Name: guru_tpa_id_guru_tpa_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE guru_tpa_id_guru_tpa_seq OWNED BY guru_tpa.id_guru_tpa;


--
-- TOC entry 2292 (class 0 OID 0)
-- Dependencies: 176
-- Name: guru_tpa_id_guru_tpa_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('guru_tpa_id_guru_tpa_seq', 1, false);


--
-- TOC entry 179 (class 1259 OID 30748)
-- Dependencies: 1983 1984 1985 1986 7
-- Name: karyawan; Type: TABLE; Schema: trans; Owner: -; Tablespace: 
--

CREATE TABLE karyawan (
    id_karyawan bigint NOT NULL,
    id_kategori_pengeluaran integer NOT NULL,
    id_kota integer NOT NULL,
    id_dd_users integer NOT NULL,
    flag_history smallint DEFAULT 0 NOT NULL,
    flag_delete smallint DEFAULT 0 NOT NULL,
    flag_npwp smallint DEFAULT 0 NOT NULL,
    nama character varying(100) NOT NULL,
    keterangan character varying(255),
    CONSTRAINT check_flag_npwp_karyawan CHECK (((flag_npwp >= 0) AND (flag_npwp <= 1)))
);


--
-- TOC entry 2293 (class 0 OID 0)
-- Dependencies: 179
-- Name: TABLE karyawan; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE karyawan IS 'Tabel karyawan.';


--
-- TOC entry 178 (class 1259 OID 30746)
-- Dependencies: 7 179
-- Name: karyawan_id_karyawan_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE karyawan_id_karyawan_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2294 (class 0 OID 0)
-- Dependencies: 178
-- Name: karyawan_id_karyawan_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE karyawan_id_karyawan_seq OWNED BY karyawan.id_karyawan;


--
-- TOC entry 2295 (class 0 OID 0)
-- Dependencies: 178
-- Name: karyawan_id_karyawan_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('karyawan_id_karyawan_seq', 1, false);


--
-- TOC entry 167 (class 1259 OID 30441)
-- Dependencies: 1963 1964 7
-- Name: kategori_pengeluaran; Type: TABLE; Schema: trans; Owner: -; Tablespace: 
--

CREATE TABLE kategori_pengeluaran (
    id_kategori_pengeluaran integer NOT NULL,
    id_dd_users integer NOT NULL,
    flag_history smallint DEFAULT 0 NOT NULL,
    flag_delete smallint DEFAULT 0 NOT NULL,
    nama character varying(100) NOT NULL,
    keterangan character varying(255)
);


--
-- TOC entry 2296 (class 0 OID 0)
-- Dependencies: 167
-- Name: TABLE kategori_pengeluaran; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE kategori_pengeluaran IS 'Tabel kategori pengeluaran.';


--
-- TOC entry 166 (class 1259 OID 30439)
-- Dependencies: 167 7
-- Name: kategori_pengeluaran_id_kategori_pengeluaran_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE kategori_pengeluaran_id_kategori_pengeluaran_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2297 (class 0 OID 0)
-- Dependencies: 166
-- Name: kategori_pengeluaran_id_kategori_pengeluaran_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE kategori_pengeluaran_id_kategori_pengeluaran_seq OWNED BY kategori_pengeluaran.id_kategori_pengeluaran;


--
-- TOC entry 2298 (class 0 OID 0)
-- Dependencies: 166
-- Name: kategori_pengeluaran_id_kategori_pengeluaran_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('kategori_pengeluaran_id_kategori_pengeluaran_seq', 1, false);


--
-- TOC entry 159 (class 1259 OID 30321)
-- Dependencies: 1948 1949 7
-- Name: klasifikasi_transaksi; Type: TABLE; Schema: trans; Owner: -; Tablespace: 
--

CREATE TABLE klasifikasi_transaksi (
    id_klasifikasi_transaksi integer NOT NULL,
    id_dd_users integer NOT NULL,
    flag_history smallint DEFAULT 0 NOT NULL,
    flag_delete smallint DEFAULT 0 NOT NULL,
    kodifikasi character(1) NOT NULL,
    nama character varying(100) NOT NULL,
    keterangan character varying(255)
);


--
-- TOC entry 2299 (class 0 OID 0)
-- Dependencies: 159
-- Name: TABLE klasifikasi_transaksi; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE klasifikasi_transaksi IS 'Tabel klasifikasi utama untuk transaksi.';


--
-- TOC entry 158 (class 1259 OID 30319)
-- Dependencies: 7 159
-- Name: klasifikasi_transaksi_id_klasifikasi_transaksi_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE klasifikasi_transaksi_id_klasifikasi_transaksi_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2300 (class 0 OID 0)
-- Dependencies: 158
-- Name: klasifikasi_transaksi_id_klasifikasi_transaksi_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE klasifikasi_transaksi_id_klasifikasi_transaksi_seq OWNED BY klasifikasi_transaksi.id_klasifikasi_transaksi;


--
-- TOC entry 2301 (class 0 OID 0)
-- Dependencies: 158
-- Name: klasifikasi_transaksi_id_klasifikasi_transaksi_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('klasifikasi_transaksi_id_klasifikasi_transaksi_seq', 1, false);


--
-- TOC entry 173 (class 1259 OID 30660)
-- Dependencies: 1972 1973 7
-- Name: kota; Type: TABLE; Schema: trans; Owner: -; Tablespace: 
--

CREATE TABLE kota (
    id_kota integer NOT NULL,
    id_propinsi integer NOT NULL,
    id_dd_users integer NOT NULL,
    flag_history smallint DEFAULT 0 NOT NULL,
    flag_delete smallint DEFAULT 0 NOT NULL,
    nama character varying(100) NOT NULL,
    keterangan character varying(255)
);


--
-- TOC entry 2302 (class 0 OID 0)
-- Dependencies: 173
-- Name: TABLE kota; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE kota IS 'Tabel data-data kota.';


--
-- TOC entry 172 (class 1259 OID 30658)
-- Dependencies: 173 7
-- Name: kota_id_kota_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE kota_id_kota_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2303 (class 0 OID 0)
-- Dependencies: 172
-- Name: kota_id_kota_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE kota_id_kota_seq OWNED BY kota.id_kota;


--
-- TOC entry 2304 (class 0 OID 0)
-- Dependencies: 172
-- Name: kota_id_kota_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('kota_id_kota_seq', 1, false);


--
-- TOC entry 169 (class 1259 OID 30483)
-- Dependencies: 1966 1967 7
-- Name: map_kategori; Type: TABLE; Schema: trans; Owner: -; Tablespace: 
--

CREATE TABLE map_kategori (
    id_map_kategori integer NOT NULL,
    id_sub_klasifikasi_transaksi integer NOT NULL,
    id_kategori_pengeluaran integer NOT NULL,
    id_dd_users integer NOT NULL,
    flag_history smallint DEFAULT 0 NOT NULL,
    flag_delete smallint DEFAULT 0 NOT NULL
);


--
-- TOC entry 2305 (class 0 OID 0)
-- Dependencies: 169
-- Name: TABLE map_kategori; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE map_kategori IS 'Peta antara kategori_pengeluaran dan sub_klasifikasi_transaksi.';


--
-- TOC entry 168 (class 1259 OID 30481)
-- Dependencies: 169 7
-- Name: map_kategori_id_map_kategori_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE map_kategori_id_map_kategori_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2306 (class 0 OID 0)
-- Dependencies: 168
-- Name: map_kategori_id_map_kategori_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE map_kategori_id_map_kategori_seq OWNED BY map_kategori.id_map_kategori;


--
-- TOC entry 2307 (class 0 OID 0)
-- Dependencies: 168
-- Name: map_kategori_id_map_kategori_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('map_kategori_id_map_kategori_seq', 1, false);


--
-- TOC entry 171 (class 1259 OID 30630)
-- Dependencies: 1969 1970 7
-- Name: propinsi; Type: TABLE; Schema: trans; Owner: -; Tablespace: 
--

CREATE TABLE propinsi (
    id_propinsi integer NOT NULL,
    id_dd_users integer NOT NULL,
    flag_history smallint DEFAULT 0 NOT NULL,
    flag_delete smallint DEFAULT 0 NOT NULL,
    nama character varying(100) NOT NULL,
    keterangan character varying(255)
);


--
-- TOC entry 2308 (class 0 OID 0)
-- Dependencies: 171
-- Name: TABLE propinsi; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE propinsi IS 'Tabel data-data propinsi.';


--
-- TOC entry 170 (class 1259 OID 30628)
-- Dependencies: 7 171
-- Name: propinsi_id_propinsi_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE propinsi_id_propinsi_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2309 (class 0 OID 0)
-- Dependencies: 170
-- Name: propinsi_id_propinsi_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE propinsi_id_propinsi_seq OWNED BY propinsi.id_propinsi;


--
-- TOC entry 2310 (class 0 OID 0)
-- Dependencies: 170
-- Name: propinsi_id_propinsi_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('propinsi_id_propinsi_seq', 1, false);


--
-- TOC entry 161 (class 1259 OID 30372)
-- Dependencies: 1951 1952 1953 1954 7
-- Name: sub_klasifikasi_transaksi; Type: TABLE; Schema: trans; Owner: -; Tablespace: 
--

CREATE TABLE sub_klasifikasi_transaksi (
    id_sub_klasifikasi_transaksi integer NOT NULL,
    id_klasifikasi_transaksi integer NOT NULL,
    id_dd_users integer NOT NULL,
    flag_history smallint DEFAULT 0 NOT NULL,
    flag_delete smallint DEFAULT 0 NOT NULL,
    flag_in_out smallint DEFAULT 1 NOT NULL,
    kodifikasi numeric(2,0) NOT NULL,
    nama character varying(100) NOT NULL,
    keterangan character varying(255),
    CONSTRAINT check_flag_in_out_sub_klasifikasi_transaksi CHECK (((flag_in_out >= 1) AND (flag_in_out <= 2)))
);


--
-- TOC entry 2311 (class 0 OID 0)
-- Dependencies: 161
-- Name: TABLE sub_klasifikasi_transaksi; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE sub_klasifikasi_transaksi IS 'Tabel sub klasifikasi transaksi.';


--
-- TOC entry 160 (class 1259 OID 30370)
-- Dependencies: 161 7
-- Name: sub_klasifikasi_transaksi_id_sub_klasifikasi_transaksi_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE sub_klasifikasi_transaksi_id_sub_klasifikasi_transaksi_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2312 (class 0 OID 0)
-- Dependencies: 160
-- Name: sub_klasifikasi_transaksi_id_sub_klasifikasi_transaksi_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE sub_klasifikasi_transaksi_id_sub_klasifikasi_transaksi_seq OWNED BY sub_klasifikasi_transaksi.id_sub_klasifikasi_transaksi;


--
-- TOC entry 2313 (class 0 OID 0)
-- Dependencies: 160
-- Name: sub_klasifikasi_transaksi_id_sub_klasifikasi_transaksi_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('sub_klasifikasi_transaksi_id_sub_klasifikasi_transaksi_seq', 1, false);


--
-- TOC entry 165 (class 1259 OID 30415)
-- Dependencies: 1959 1960 1961 7
-- Name: sub_transaksi; Type: TABLE; Schema: trans; Owner: -; Tablespace: 
--

CREATE TABLE sub_transaksi (
    id_sub_transaksi bigint NOT NULL,
    id_transaksi bigint NOT NULL,
    id_sub_klasifikasi_transaksi integer NOT NULL,
    id_dd_users integer NOT NULL,
    flag_history smallint DEFAULT 0 NOT NULL,
    flag_delete smallint DEFAULT 0 NOT NULL,
    jumlah numeric(15,2) NOT NULL,
    CONSTRAINT check_jumlah_sub_transaksi CHECK ((jumlah >= (0)::numeric))
);


--
-- TOC entry 2314 (class 0 OID 0)
-- Dependencies: 165
-- Name: TABLE sub_transaksi; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE sub_transaksi IS 'Tabel sub transaksi.';


--
-- TOC entry 164 (class 1259 OID 30413)
-- Dependencies: 7 165
-- Name: sub_transaksi_id_sub_transaksi_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE sub_transaksi_id_sub_transaksi_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2315 (class 0 OID 0)
-- Dependencies: 164
-- Name: sub_transaksi_id_sub_transaksi_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE sub_transaksi_id_sub_transaksi_seq OWNED BY sub_transaksi.id_sub_transaksi;


--
-- TOC entry 2316 (class 0 OID 0)
-- Dependencies: 164
-- Name: sub_transaksi_id_sub_transaksi_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('sub_transaksi_id_sub_transaksi_seq', 1, false);


--
-- TOC entry 163 (class 1259 OID 30398)
-- Dependencies: 1956 1957 7
-- Name: transaksi; Type: TABLE; Schema: trans; Owner: -; Tablespace: 
--

CREATE TABLE transaksi (
    id_transaksi bigint NOT NULL,
    id_dd_users integer NOT NULL,
    flag_history smallint DEFAULT 0 NOT NULL,
    flag_delete smallint DEFAULT 0 NOT NULL,
    no_bukti character varying(100) NOT NULL,
    tanggal date NOT NULL
);


--
-- TOC entry 2317 (class 0 OID 0)
-- Dependencies: 163
-- Name: TABLE transaksi; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE transaksi IS 'Tabel transaksi.';


--
-- TOC entry 162 (class 1259 OID 30396)
-- Dependencies: 7 163
-- Name: transaksi_id_transaksi_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE transaksi_id_transaksi_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2318 (class 0 OID 0)
-- Dependencies: 162
-- Name: transaksi_id_transaksi_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE transaksi_id_transaksi_seq OWNED BY transaksi.id_transaksi;


--
-- TOC entry 2319 (class 0 OID 0)
-- Dependencies: 162
-- Name: transaksi_id_transaksi_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('transaksi_id_transaksi_seq', 1, false);


--
-- TOC entry 181 (class 1259 OID 30782)
-- Dependencies: 1988 1989 1990 1991 7
-- Name: ustadz; Type: TABLE; Schema: trans; Owner: -; Tablespace: 
--

CREATE TABLE ustadz (
    id_ustadz bigint NOT NULL,
    id_kategori_pengeluaran integer NOT NULL,
    id_kota integer NOT NULL,
    id_dd_users integer NOT NULL,
    flag_history smallint DEFAULT 0 NOT NULL,
    flag_delete smallint DEFAULT 0 NOT NULL,
    flag_npwp smallint DEFAULT 0 NOT NULL,
    nama character varying(100) NOT NULL,
    keterangan character varying(255),
    CONSTRAINT check_flag_npwp_ustadz CHECK (((flag_npwp >= 0) AND (flag_npwp <= 1)))
);


--
-- TOC entry 2320 (class 0 OID 0)
-- Dependencies: 181
-- Name: TABLE ustadz; Type: COMMENT; Schema: trans; Owner: -
--

COMMENT ON TABLE ustadz IS 'Tabel ustadz.';


--
-- TOC entry 180 (class 1259 OID 30780)
-- Dependencies: 181 7
-- Name: ustadz_id_ustadz_seq; Type: SEQUENCE; Schema: trans; Owner: -
--

CREATE SEQUENCE ustadz_id_ustadz_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 2321 (class 0 OID 0)
-- Dependencies: 180
-- Name: ustadz_id_ustadz_seq; Type: SEQUENCE OWNED BY; Schema: trans; Owner: -
--

ALTER SEQUENCE ustadz_id_ustadz_seq OWNED BY ustadz.id_ustadz;


--
-- TOC entry 2322 (class 0 OID 0)
-- Dependencies: 180
-- Name: ustadz_id_ustadz_seq; Type: SEQUENCE SET; Schema: trans; Owner: -
--

SELECT pg_catalog.setval('ustadz_id_ustadz_seq', 1, false);


SET search_path = akun, pg_catalog;

--
-- TOC entry 1995 (class 2604 OID 30850)
-- Dependencies: 189 188 189
-- Name: id_akdd_arus_kas; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE akdd_arus_kas ALTER COLUMN id_akdd_arus_kas SET DEFAULT nextval('akdd_arus_kas_id_akdd_arus_kas_seq'::regclass);


--
-- TOC entry 1994 (class 2604 OID 30831)
-- Dependencies: 187 186 187
-- Name: id_akdd_detail_coa; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE akdd_detail_coa ALTER COLUMN id_akdd_detail_coa SET DEFAULT nextval('akdd_detail_coa_id_akdd_detail_coa_seq'::regclass);


--
-- TOC entry 1999 (class 2604 OID 30871)
-- Dependencies: 193 192 193
-- Name: id_akdd_detail_coa_lr; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE akdd_detail_coa_lr ALTER COLUMN id_akdd_detail_coa_lr SET DEFAULT nextval('akdd_detail_coa_lr_id_akdd_detail_coa_lr_seq'::regclass);


--
-- TOC entry 2000 (class 2604 OID 30907)
-- Dependencies: 194 195 195
-- Name: id_akdd_detail_coa_map; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE akdd_detail_coa_map ALTER COLUMN id_akdd_detail_coa_map SET DEFAULT nextval('akdd_detail_coa_map_id_akdd_detail_coa_map_seq'::regclass);


--
-- TOC entry 1998 (class 2604 OID 30863)
-- Dependencies: 190 191 191
-- Name: id_akdd_klasifikasi_modal; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE akdd_klasifikasi_modal ALTER COLUMN id_akdd_klasifikasi_modal SET DEFAULT nextval('akdd_klasifikasi_modal_id_akdd_klasifikasi_modal_seq'::regclass);


--
-- TOC entry 1993 (class 2604 OID 30823)
-- Dependencies: 185 184 185
-- Name: id_akdd_level_coa; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE akdd_level_coa ALTER COLUMN id_akdd_level_coa SET DEFAULT nextval('akdd_level_coa_id_akdd_level_coa_seq'::regclass);


--
-- TOC entry 1992 (class 2604 OID 30815)
-- Dependencies: 183 182 183
-- Name: id_akdd_main_coa; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE akdd_main_coa ALTER COLUMN id_akdd_main_coa SET DEFAULT nextval('akdd_main_coa_id_akdd_main_coa_seq'::regclass);


--
-- TOC entry 2002 (class 2604 OID 30935)
-- Dependencies: 198 197 198
-- Name: id_akdd_perubahan_dana; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE akdd_perubahan_dana ALTER COLUMN id_akdd_perubahan_dana SET DEFAULT nextval('akdd_perubahan_dana_id_akdd_perubahan_dana_seq'::regclass);


--
-- TOC entry 2003 (class 2604 OID 30947)
-- Dependencies: 200 199 200
-- Name: id_akdd_posisi_keuangan; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE akdd_posisi_keuangan ALTER COLUMN id_akdd_posisi_keuangan SET DEFAULT nextval('akdd_posisi_keuangan_id_akdd_posisi_keuangan_seq'::regclass);


--
-- TOC entry 2006 (class 2604 OID 30969)
-- Dependencies: 203 204 204
-- Name: id_akmt_buku_besar; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE akmt_buku_besar ALTER COLUMN id_akmt_buku_besar SET DEFAULT nextval('akmt_buku_besar_id_akmt_buku_besar_seq'::regclass);


--
-- TOC entry 2007 (class 2604 OID 30987)
-- Dependencies: 206 205 206
-- Name: id_akmt_jurnal; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE akmt_jurnal ALTER COLUMN id_akmt_jurnal SET DEFAULT nextval('akmt_jurnal_id_akmt_jurnal_seq'::regclass);


--
-- TOC entry 2008 (class 2604 OID 30996)
-- Dependencies: 208 207 208
-- Name: id_akmt_jurnal_det; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE akmt_jurnal_det ALTER COLUMN id_akmt_jurnal_det SET DEFAULT nextval('akmt_jurnal_det_id_akmt_jurnal_det_seq'::regclass);


--
-- TOC entry 2005 (class 2604 OID 30959)
-- Dependencies: 201 202 202
-- Name: id_akmt_periode; Type: DEFAULT; Schema: akun; Owner: -
--

ALTER TABLE akmt_periode ALTER COLUMN id_akmt_periode SET DEFAULT nextval('akmt_periode_id_akmt_periode_seq'::regclass);


SET search_path = public, pg_catalog;

--
-- TOC entry 1939 (class 2604 OID 30224)
-- Dependencies: 143 142
-- Name: id_dd_access; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dd_access ALTER COLUMN id_dd_access SET DEFAULT nextval('dd_access_id_dd_access_seq'::regclass);


--
-- TOC entry 1940 (class 2604 OID 30225)
-- Dependencies: 147 144
-- Name: id_dd_groups; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dd_groups ALTER COLUMN id_dd_groups SET DEFAULT nextval('dd_groups_id_dd_groups_seq'::regclass);


--
-- TOC entry 1941 (class 2604 OID 30226)
-- Dependencies: 146 145
-- Name: id_dd_groups_detail; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dd_groups_detail ALTER COLUMN id_dd_groups_detail SET DEFAULT nextval('dd_groups_detail_id_dd_groups_detail_seq'::regclass);


--
-- TOC entry 1942 (class 2604 OID 30227)
-- Dependencies: 149 148
-- Name: id_dd_menus; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dd_menus ALTER COLUMN id_dd_menus SET DEFAULT nextval('dd_menus_id_dd_menus_seq'::regclass);


--
-- TOC entry 1943 (class 2604 OID 30228)
-- Dependencies: 151 150
-- Name: id_dd_moduls; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dd_moduls ALTER COLUMN id_dd_moduls SET DEFAULT nextval('dd_moduls_id_dd_moduls_seq'::regclass);


--
-- TOC entry 1944 (class 2604 OID 30229)
-- Dependencies: 153 152
-- Name: id_dd_sub_menus; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dd_sub_menus ALTER COLUMN id_dd_sub_menus SET DEFAULT nextval('dd_sub_menus_id_dd_sub_menus_seq'::regclass);


--
-- TOC entry 1945 (class 2604 OID 30230)
-- Dependencies: 155 154
-- Name: id_dd_tabs; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dd_tabs ALTER COLUMN id_dd_tabs SET DEFAULT nextval('dd_tabs_id_dd_tabs_seq'::regclass);


--
-- TOC entry 1946 (class 2604 OID 30231)
-- Dependencies: 157 156
-- Name: id_dd_users; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE dd_users ALTER COLUMN id_dd_users SET DEFAULT nextval('dd_users_id_dd_users_seq'::regclass);


SET search_path = trans, pg_catalog;

--
-- TOC entry 1974 (class 2604 OID 30690)
-- Dependencies: 174 175 175
-- Name: id_bank; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE bank ALTER COLUMN id_bank SET DEFAULT nextval('bank_id_bank_seq'::regclass);


--
-- TOC entry 1977 (class 2604 OID 30717)
-- Dependencies: 177 176 177
-- Name: id_guru_tpa; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE guru_tpa ALTER COLUMN id_guru_tpa SET DEFAULT nextval('guru_tpa_id_guru_tpa_seq'::regclass);


--
-- TOC entry 1982 (class 2604 OID 30751)
-- Dependencies: 178 179 179
-- Name: id_karyawan; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE karyawan ALTER COLUMN id_karyawan SET DEFAULT nextval('karyawan_id_karyawan_seq'::regclass);


--
-- TOC entry 1962 (class 2604 OID 30444)
-- Dependencies: 166 167 167
-- Name: id_kategori_pengeluaran; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE kategori_pengeluaran ALTER COLUMN id_kategori_pengeluaran SET DEFAULT nextval('kategori_pengeluaran_id_kategori_pengeluaran_seq'::regclass);


--
-- TOC entry 1947 (class 2604 OID 30324)
-- Dependencies: 159 158 159
-- Name: id_klasifikasi_transaksi; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE klasifikasi_transaksi ALTER COLUMN id_klasifikasi_transaksi SET DEFAULT nextval('klasifikasi_transaksi_id_klasifikasi_transaksi_seq'::regclass);


--
-- TOC entry 1971 (class 2604 OID 30663)
-- Dependencies: 172 173 173
-- Name: id_kota; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE kota ALTER COLUMN id_kota SET DEFAULT nextval('kota_id_kota_seq'::regclass);


--
-- TOC entry 1965 (class 2604 OID 30486)
-- Dependencies: 169 168 169
-- Name: id_map_kategori; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE map_kategori ALTER COLUMN id_map_kategori SET DEFAULT nextval('map_kategori_id_map_kategori_seq'::regclass);


--
-- TOC entry 1968 (class 2604 OID 30633)
-- Dependencies: 171 170 171
-- Name: id_propinsi; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE propinsi ALTER COLUMN id_propinsi SET DEFAULT nextval('propinsi_id_propinsi_seq'::regclass);


--
-- TOC entry 1950 (class 2604 OID 30375)
-- Dependencies: 161 160 161
-- Name: id_sub_klasifikasi_transaksi; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE sub_klasifikasi_transaksi ALTER COLUMN id_sub_klasifikasi_transaksi SET DEFAULT nextval('sub_klasifikasi_transaksi_id_sub_klasifikasi_transaksi_seq'::regclass);


--
-- TOC entry 1958 (class 2604 OID 30418)
-- Dependencies: 165 164 165
-- Name: id_sub_transaksi; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE sub_transaksi ALTER COLUMN id_sub_transaksi SET DEFAULT nextval('sub_transaksi_id_sub_transaksi_seq'::regclass);


--
-- TOC entry 1955 (class 2604 OID 30401)
-- Dependencies: 163 162 163
-- Name: id_transaksi; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE transaksi ALTER COLUMN id_transaksi SET DEFAULT nextval('transaksi_id_transaksi_seq'::regclass);


--
-- TOC entry 1987 (class 2604 OID 30785)
-- Dependencies: 180 181 181
-- Name: id_ustadz; Type: DEFAULT; Schema: trans; Owner: -
--

ALTER TABLE ustadz ALTER COLUMN id_ustadz SET DEFAULT nextval('ustadz_id_ustadz_seq'::regclass);


SET search_path = akun, pg_catalog;

--
-- TOC entry 2199 (class 0 OID 30847)
-- Dependencies: 189
-- Data for Name: akdd_arus_kas; Type: TABLE DATA; Schema: akun; Owner: -
--

COPY akdd_arus_kas (id_akdd_arus_kas, id_akdd_arus_kas_ref, uraian, coa_range, order_number, kalkulasi, kalibrasi) FROM stdin;
\.


--
-- TOC entry 2198 (class 0 OID 30828)
-- Dependencies: 187
-- Data for Name: akdd_detail_coa; Type: TABLE DATA; Schema: akun; Owner: -
--

COPY akdd_detail_coa (id_akdd_detail_coa, id_akdd_main_coa, id_akdd_level_coa, id_akdd_detail_coa_ref, coa_number, coa_number_num, uraian) FROM stdin;
\.


--
-- TOC entry 2201 (class 0 OID 30868)
-- Dependencies: 193
-- Data for Name: akdd_detail_coa_lr; Type: TABLE DATA; Schema: akun; Owner: -
--

COPY akdd_detail_coa_lr (id_akdd_detail_coa_lr, id_akdd_detail_coa, id_akdd_klasifikasi_modal, sub_coa) FROM stdin;
\.


--
-- TOC entry 2202 (class 0 OID 30904)
-- Dependencies: 195
-- Data for Name: akdd_detail_coa_map; Type: TABLE DATA; Schema: akun; Owner: -
--

COPY akdd_detail_coa_map (id_akdd_detail_coa_map, id_akdd_detail_coa, flag) FROM stdin;
\.


--
-- TOC entry 2200 (class 0 OID 30860)
-- Dependencies: 191
-- Data for Name: akdd_klasifikasi_modal; Type: TABLE DATA; Schema: akun; Owner: -
--

COPY akdd_klasifikasi_modal (id_akdd_klasifikasi_modal, binary_code, klasifikasi, uraian) FROM stdin;
\.


--
-- TOC entry 2203 (class 0 OID 30923)
-- Dependencies: 196
-- Data for Name: akdd_kodifikasi_jurnal; Type: TABLE DATA; Schema: akun; Owner: -
--

COPY akdd_kodifikasi_jurnal (id_akdd_kodifikasi_jurnal, kode, notes) FROM stdin;
\.


--
-- TOC entry 2197 (class 0 OID 30820)
-- Dependencies: 185
-- Data for Name: akdd_level_coa; Type: TABLE DATA; Schema: akun; Owner: -
--

COPY akdd_level_coa (id_akdd_level_coa, level_number, level_length, uraian) FROM stdin;
\.


--
-- TOC entry 2196 (class 0 OID 30812)
-- Dependencies: 183
-- Data for Name: akdd_main_coa; Type: TABLE DATA; Schema: akun; Owner: -
--

COPY akdd_main_coa (id_akdd_main_coa, acc_type, binary_code, uraian) FROM stdin;
\.


--
-- TOC entry 2204 (class 0 OID 30932)
-- Dependencies: 198
-- Data for Name: akdd_perubahan_dana; Type: TABLE DATA; Schema: akun; Owner: -
--

COPY akdd_perubahan_dana (id_akdd_perubahan_dana, id_akdd_perubahan_dana_ref, uraian, coa_range, order_number) FROM stdin;
\.


--
-- TOC entry 2205 (class 0 OID 30944)
-- Dependencies: 200
-- Data for Name: akdd_posisi_keuangan; Type: TABLE DATA; Schema: akun; Owner: -
--

COPY akdd_posisi_keuangan (id_akdd_posisi_keuangan, id_akdd_posisi_keuangan_ref, uraian, coa_range, order_number, acc_type) FROM stdin;
\.


--
-- TOC entry 2207 (class 0 OID 30966)
-- Dependencies: 204
-- Data for Name: akmt_buku_besar; Type: TABLE DATA; Schema: akun; Owner: -
--

COPY akmt_buku_besar (id_akmt_buku_besar, id_akmt_periode, id_akdd_detail_coa, no_bukti, tanggal, keterangan, awal, mutasi_debet, mutasi_kredit, akhir) FROM stdin;
\.


--
-- TOC entry 2208 (class 0 OID 30984)
-- Dependencies: 206
-- Data for Name: akmt_jurnal; Type: TABLE DATA; Schema: akun; Owner: -
--

COPY akmt_jurnal (id_akmt_jurnal, flag_jurnal, flag_temp, flag_posting, no_bukti, tanggal, keterangan) FROM stdin;
\.


--
-- TOC entry 2209 (class 0 OID 30993)
-- Dependencies: 208
-- Data for Name: akmt_jurnal_det; Type: TABLE DATA; Schema: akun; Owner: -
--

COPY akmt_jurnal_det (id_akmt_jurnal_det, id_akmt_jurnal, id_akdd_detail_coa, flag_position, jumlah) FROM stdin;
\.


--
-- TOC entry 2206 (class 0 OID 30956)
-- Dependencies: 202
-- Data for Name: akmt_periode; Type: TABLE DATA; Schema: akun; Owner: -
--

COPY akmt_periode (id_akmt_periode, flag_temp, tahun, bulan, uraian) FROM stdin;
\.


SET search_path = public, pg_catalog;

--
-- TOC entry 2176 (class 0 OID 30184)
-- Dependencies: 142
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
-- TOC entry 2177 (class 0 OID 30189)
-- Dependencies: 144
-- Data for Name: dd_groups; Type: TABLE DATA; Schema: public; Owner: -
--

COPY dd_groups (id_dd_groups, flag_system, group_name, note) FROM stdin;
1	t	Super Administrator	Super Administrator sistem
2	f	Administrator	Administrator sistem di bawah Super Administrator
3	f	Manajer	Pengawas kegiatan Operator
4	f	Operator	Petugas yang menjalankan sehari-hari
\.


--
-- TOC entry 2178 (class 0 OID 30192)
-- Dependencies: 145
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
-- TOC entry 2179 (class 0 OID 30199)
-- Dependencies: 148
-- Data for Name: dd_menus; Type: TABLE DATA; Schema: public; Owner: -
--

COPY dd_menus (id_dd_menus, id_dd_moduls, order_number, menu, note) FROM stdin;
1	1	1	APLIKASI	Setup aplikasi
2	2	1	DATA DASAR	Data-data dasar
3	1	2	PENGGUNA	Data-data pengguna
\.


--
-- TOC entry 2180 (class 0 OID 30204)
-- Dependencies: 150
-- Data for Name: dd_moduls; Type: TABLE DATA; Schema: public; Owner: -
--

COPY dd_moduls (id_dd_moduls, order_number, modul, note) FROM stdin;
1	1	SETUP	Setup aplikasi
2	2	ADMIN	Administrasi aplikasi
\.


--
-- TOC entry 2181 (class 0 OID 30209)
-- Dependencies: 152
-- Data for Name: dd_sub_menus; Type: TABLE DATA; Schema: public; Owner: -
--

COPY dd_sub_menus (id_dd_sub_menus, id_dd_menus, order_number, sub_menu, note) FROM stdin;
1	1	1	Modul, Menu, Sub, Tab	Setup konfigurasi aplikasi
2	1	2	Access Groups & Right	Manajemen kelompok dan hak akses
3	3	1	User	Daftar pengguna aplikasi
\.


--
-- TOC entry 2182 (class 0 OID 30214)
-- Dependencies: 154
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
-- TOC entry 2183 (class 0 OID 30219)
-- Dependencies: 156
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
-- TOC entry 2192 (class 0 OID 30687)
-- Dependencies: 175
-- Data for Name: bank; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY bank (id_bank, id_kota, id_dd_users, flag_history, flag_delete, nama, keterangan) FROM stdin;
\.


--
-- TOC entry 2193 (class 0 OID 30714)
-- Dependencies: 177
-- Data for Name: guru_tpa; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY guru_tpa (id_guru_tpa, id_kategori_pengeluaran, id_kota, id_dd_users, flag_history, flag_delete, flag_npwp, nama, keterangan) FROM stdin;
\.


--
-- TOC entry 2194 (class 0 OID 30748)
-- Dependencies: 179
-- Data for Name: karyawan; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY karyawan (id_karyawan, id_kategori_pengeluaran, id_kota, id_dd_users, flag_history, flag_delete, flag_npwp, nama, keterangan) FROM stdin;
\.


--
-- TOC entry 2188 (class 0 OID 30441)
-- Dependencies: 167
-- Data for Name: kategori_pengeluaran; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY kategori_pengeluaran (id_kategori_pengeluaran, id_dd_users, flag_history, flag_delete, nama, keterangan) FROM stdin;
\.


--
-- TOC entry 2184 (class 0 OID 30321)
-- Dependencies: 159
-- Data for Name: klasifikasi_transaksi; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY klasifikasi_transaksi (id_klasifikasi_transaksi, id_dd_users, flag_history, flag_delete, kodifikasi, nama, keterangan) FROM stdin;
\.


--
-- TOC entry 2191 (class 0 OID 30660)
-- Dependencies: 173
-- Data for Name: kota; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY kota (id_kota, id_propinsi, id_dd_users, flag_history, flag_delete, nama, keterangan) FROM stdin;
\.


--
-- TOC entry 2189 (class 0 OID 30483)
-- Dependencies: 169
-- Data for Name: map_kategori; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY map_kategori (id_map_kategori, id_sub_klasifikasi_transaksi, id_kategori_pengeluaran, id_dd_users, flag_history, flag_delete) FROM stdin;
\.


--
-- TOC entry 2190 (class 0 OID 30630)
-- Dependencies: 171
-- Data for Name: propinsi; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY propinsi (id_propinsi, id_dd_users, flag_history, flag_delete, nama, keterangan) FROM stdin;
\.


--
-- TOC entry 2185 (class 0 OID 30372)
-- Dependencies: 161
-- Data for Name: sub_klasifikasi_transaksi; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY sub_klasifikasi_transaksi (id_sub_klasifikasi_transaksi, id_klasifikasi_transaksi, id_dd_users, flag_history, flag_delete, flag_in_out, kodifikasi, nama, keterangan) FROM stdin;
\.


--
-- TOC entry 2187 (class 0 OID 30415)
-- Dependencies: 165
-- Data for Name: sub_transaksi; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY sub_transaksi (id_sub_transaksi, id_transaksi, id_sub_klasifikasi_transaksi, id_dd_users, flag_history, flag_delete, jumlah) FROM stdin;
\.


--
-- TOC entry 2186 (class 0 OID 30398)
-- Dependencies: 163
-- Data for Name: transaksi; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY transaksi (id_transaksi, id_dd_users, flag_history, flag_delete, no_bukti, tanggal) FROM stdin;
\.


--
-- TOC entry 2195 (class 0 OID 30782)
-- Dependencies: 181
-- Data for Name: ustadz; Type: TABLE DATA; Schema: trans; Owner: -
--

COPY ustadz (id_ustadz, id_kategori_pengeluaran, id_kota, id_dd_users, flag_history, flag_delete, flag_npwp, nama, keterangan) FROM stdin;
\.


SET search_path = akun, pg_catalog;

--
-- TOC entry 2116 (class 2606 OID 30910)
-- Dependencies: 195 195
-- Name: akdd_detail_coa_map_pkey; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_detail_coa_map
    ADD CONSTRAINT akdd_detail_coa_map_pkey PRIMARY KEY (id_akdd_detail_coa_map);


--
-- TOC entry 2106 (class 2606 OID 30857)
-- Dependencies: 189 189
-- Name: pk_akdd_arus_kas; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_arus_kas
    ADD CONSTRAINT pk_akdd_arus_kas PRIMARY KEY (id_akdd_arus_kas);


--
-- TOC entry 2104 (class 2606 OID 30833)
-- Dependencies: 187 187
-- Name: pk_akdd_detail_coa; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_detail_coa
    ADD CONSTRAINT pk_akdd_detail_coa PRIMARY KEY (id_akdd_detail_coa);


--
-- TOC entry 2110 (class 2606 OID 30873)
-- Dependencies: 193 193
-- Name: pk_akdd_detail_coa_lr; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_detail_coa_lr
    ADD CONSTRAINT pk_akdd_detail_coa_lr PRIMARY KEY (id_akdd_detail_coa_lr);


--
-- TOC entry 2108 (class 2606 OID 30865)
-- Dependencies: 191 191
-- Name: pk_akdd_klasifikasi_modal; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_klasifikasi_modal
    ADD CONSTRAINT pk_akdd_klasifikasi_modal PRIMARY KEY (id_akdd_klasifikasi_modal);


--
-- TOC entry 2118 (class 2606 OID 30927)
-- Dependencies: 196 196
-- Name: pk_akdd_kodifikasi_jurnal; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_kodifikasi_jurnal
    ADD CONSTRAINT pk_akdd_kodifikasi_jurnal PRIMARY KEY (id_akdd_kodifikasi_jurnal);


--
-- TOC entry 2101 (class 2606 OID 30825)
-- Dependencies: 185 185
-- Name: pk_akdd_level_coa; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_level_coa
    ADD CONSTRAINT pk_akdd_level_coa PRIMARY KEY (id_akdd_level_coa);


--
-- TOC entry 2099 (class 2606 OID 30817)
-- Dependencies: 183 183
-- Name: pk_akdd_main_coa; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_main_coa
    ADD CONSTRAINT pk_akdd_main_coa PRIMARY KEY (id_akdd_main_coa);


--
-- TOC entry 2122 (class 2606 OID 30940)
-- Dependencies: 198 198
-- Name: pk_akdd_perubahan_dana; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_perubahan_dana
    ADD CONSTRAINT pk_akdd_perubahan_dana PRIMARY KEY (id_akdd_perubahan_dana);


--
-- TOC entry 2124 (class 2606 OID 30953)
-- Dependencies: 200 200
-- Name: pk_akdd_posisi_keuangan; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_posisi_keuangan
    ADD CONSTRAINT pk_akdd_posisi_keuangan PRIMARY KEY (id_akdd_posisi_keuangan);


--
-- TOC entry 2130 (class 2606 OID 30971)
-- Dependencies: 204 204
-- Name: pk_akmt_buku_besar; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akmt_buku_besar
    ADD CONSTRAINT pk_akmt_buku_besar PRIMARY KEY (id_akmt_buku_besar);


--
-- TOC entry 2133 (class 2606 OID 30989)
-- Dependencies: 206 206
-- Name: pk_akmt_jurnal; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akmt_jurnal
    ADD CONSTRAINT pk_akmt_jurnal PRIMARY KEY (id_akmt_jurnal);


--
-- TOC entry 2135 (class 2606 OID 30999)
-- Dependencies: 208 208
-- Name: pk_akmt_jurnal_det; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akmt_jurnal_det
    ADD CONSTRAINT pk_akmt_jurnal_det PRIMARY KEY (id_akmt_jurnal_det);


--
-- TOC entry 2126 (class 2606 OID 30961)
-- Dependencies: 202 202
-- Name: pk_akmt_periode; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akmt_periode
    ADD CONSTRAINT pk_akmt_periode PRIMARY KEY (id_akmt_periode);


--
-- TOC entry 2128 (class 2606 OID 30963)
-- Dependencies: 202 202 202
-- Name: unique_akmt_periode; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akmt_periode
    ADD CONSTRAINT unique_akmt_periode UNIQUE (tahun, bulan);


--
-- TOC entry 2112 (class 2606 OID 30875)
-- Dependencies: 193 193
-- Name: unique_detail_coa; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_detail_coa_lr
    ADD CONSTRAINT unique_detail_coa UNIQUE (id_akdd_detail_coa);


--
-- TOC entry 2114 (class 2606 OID 30877)
-- Dependencies: 193 193
-- Name: unique_klasifikasi_modal; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_detail_coa_lr
    ADD CONSTRAINT unique_klasifikasi_modal UNIQUE (id_akdd_klasifikasi_modal);


--
-- TOC entry 2120 (class 2606 OID 30929)
-- Dependencies: 196 196
-- Name: unique_kodifikasi_jurnal; Type: CONSTRAINT; Schema: akun; Owner: -; Tablespace: 
--

ALTER TABLE ONLY akdd_kodifikasi_jurnal
    ADD CONSTRAINT unique_kodifikasi_jurnal UNIQUE (kode);


SET search_path = public, pg_catalog;

--
-- TOC entry 2011 (class 2606 OID 30233)
-- Dependencies: 142 142
-- Name: pk_dd_access; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_access
    ADD CONSTRAINT pk_dd_access PRIMARY KEY (id_dd_access);


--
-- TOC entry 2017 (class 2606 OID 30235)
-- Dependencies: 144 144
-- Name: pk_dd_groups; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_groups
    ADD CONSTRAINT pk_dd_groups PRIMARY KEY (id_dd_groups);


--
-- TOC entry 2023 (class 2606 OID 30237)
-- Dependencies: 148 148
-- Name: pk_dd_menus; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_menus
    ADD CONSTRAINT pk_dd_menus PRIMARY KEY (id_dd_menus);


--
-- TOC entry 2029 (class 2606 OID 30239)
-- Dependencies: 150 150
-- Name: pk_dd_moduls; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_moduls
    ADD CONSTRAINT pk_dd_moduls PRIMARY KEY (id_dd_moduls);


--
-- TOC entry 2035 (class 2606 OID 30241)
-- Dependencies: 152 152
-- Name: pk_dd_sub_menus; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_sub_menus
    ADD CONSTRAINT pk_dd_sub_menus PRIMARY KEY (id_dd_sub_menus);


--
-- TOC entry 2041 (class 2606 OID 30243)
-- Dependencies: 154 154
-- Name: pk_dd_tabs; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_tabs
    ADD CONSTRAINT pk_dd_tabs PRIMARY KEY (id_dd_tabs);


--
-- TOC entry 2047 (class 2606 OID 30245)
-- Dependencies: 156 156
-- Name: pk_dd_users; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_users
    ADD CONSTRAINT pk_dd_users PRIMARY KEY (id_dd_users);


--
-- TOC entry 2021 (class 2606 OID 30247)
-- Dependencies: 145 145
-- Name: pk_groups_detail; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_groups_detail
    ADD CONSTRAINT pk_groups_detail PRIMARY KEY (id_dd_groups_detail);


--
-- TOC entry 2013 (class 2606 OID 30249)
-- Dependencies: 142 142
-- Name: unique2_access; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_access
    ADD CONSTRAINT unique2_access UNIQUE (access_code);


--
-- TOC entry 2025 (class 2606 OID 30251)
-- Dependencies: 148 148 148 148
-- Name: unique2_menus; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_menus
    ADD CONSTRAINT unique2_menus UNIQUE (id_dd_moduls, menu, order_number);


--
-- TOC entry 2031 (class 2606 OID 30253)
-- Dependencies: 150 150
-- Name: unique2_moduls; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_moduls
    ADD CONSTRAINT unique2_moduls UNIQUE (order_number);


--
-- TOC entry 2037 (class 2606 OID 30255)
-- Dependencies: 152 152 152 152
-- Name: unique2_sub_menus; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_sub_menus
    ADD CONSTRAINT unique2_sub_menus UNIQUE (id_dd_menus, sub_menu, order_number);


--
-- TOC entry 2043 (class 2606 OID 30257)
-- Dependencies: 154 154
-- Name: unique2_tabs; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_tabs
    ADD CONSTRAINT unique2_tabs UNIQUE (url);


--
-- TOC entry 2015 (class 2606 OID 30259)
-- Dependencies: 142 142
-- Name: unique_access; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_access
    ADD CONSTRAINT unique_access UNIQUE (access_name);


--
-- TOC entry 2049 (class 2606 OID 30261)
-- Dependencies: 156 156
-- Name: unique_dd_users; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_users
    ADD CONSTRAINT unique_dd_users UNIQUE (username);


--
-- TOC entry 2019 (class 2606 OID 30263)
-- Dependencies: 144 144
-- Name: unique_groups; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_groups
    ADD CONSTRAINT unique_groups UNIQUE (group_name);


--
-- TOC entry 2027 (class 2606 OID 30265)
-- Dependencies: 148 148 148
-- Name: unique_menus; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_menus
    ADD CONSTRAINT unique_menus UNIQUE (id_dd_moduls, menu);


--
-- TOC entry 2033 (class 2606 OID 30267)
-- Dependencies: 150 150
-- Name: unique_moduls; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_moduls
    ADD CONSTRAINT unique_moduls UNIQUE (modul);


--
-- TOC entry 2039 (class 2606 OID 30269)
-- Dependencies: 152 152 152
-- Name: unique_sub_menus; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_sub_menus
    ADD CONSTRAINT unique_sub_menus UNIQUE (id_dd_menus, sub_menu);


--
-- TOC entry 2045 (class 2606 OID 30271)
-- Dependencies: 154 154 154
-- Name: unique_tabs; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY dd_tabs
    ADD CONSTRAINT unique_tabs UNIQUE (id_dd_sub_menus, tab);


SET search_path = trans, pg_catalog;

--
-- TOC entry 2083 (class 2606 OID 30694)
-- Dependencies: 175 175
-- Name: pk_bank; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY bank
    ADD CONSTRAINT pk_bank PRIMARY KEY (id_bank);


--
-- TOC entry 2087 (class 2606 OID 30723)
-- Dependencies: 177 177
-- Name: pk_guru_tpa; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY guru_tpa
    ADD CONSTRAINT pk_guru_tpa PRIMARY KEY (id_guru_tpa);


--
-- TOC entry 2091 (class 2606 OID 30757)
-- Dependencies: 179 179
-- Name: pk_karyawan; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY karyawan
    ADD CONSTRAINT pk_karyawan PRIMARY KEY (id_karyawan);


--
-- TOC entry 2069 (class 2606 OID 30448)
-- Dependencies: 167 167
-- Name: pk_kategori_pengeluaran; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY kategori_pengeluaran
    ADD CONSTRAINT pk_kategori_pengeluaran PRIMARY KEY (id_kategori_pengeluaran);


--
-- TOC entry 2051 (class 2606 OID 30328)
-- Dependencies: 159 159
-- Name: pk_klasifikasi_transaksi; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY klasifikasi_transaksi
    ADD CONSTRAINT pk_klasifikasi_transaksi PRIMARY KEY (id_klasifikasi_transaksi);


--
-- TOC entry 2079 (class 2606 OID 30667)
-- Dependencies: 173 173
-- Name: pk_kota; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY kota
    ADD CONSTRAINT pk_kota PRIMARY KEY (id_kota);


--
-- TOC entry 2073 (class 2606 OID 30490)
-- Dependencies: 169 169
-- Name: pk_map_kategori; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY map_kategori
    ADD CONSTRAINT pk_map_kategori PRIMARY KEY (id_map_kategori);


--
-- TOC entry 2075 (class 2606 OID 30637)
-- Dependencies: 171 171
-- Name: pk_propinsi; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY propinsi
    ADD CONSTRAINT pk_propinsi PRIMARY KEY (id_propinsi);


--
-- TOC entry 2057 (class 2606 OID 30381)
-- Dependencies: 161 161
-- Name: pk_sub_klasifikasi_transaksi; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sub_klasifikasi_transaksi
    ADD CONSTRAINT pk_sub_klasifikasi_transaksi PRIMARY KEY (id_sub_klasifikasi_transaksi);


--
-- TOC entry 2067 (class 2606 OID 30423)
-- Dependencies: 165 165
-- Name: pk_sub_transaksi; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sub_transaksi
    ADD CONSTRAINT pk_sub_transaksi PRIMARY KEY (id_sub_transaksi);


--
-- TOC entry 2063 (class 2606 OID 30405)
-- Dependencies: 163 163
-- Name: pk_transaksi; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY transaksi
    ADD CONSTRAINT pk_transaksi PRIMARY KEY (id_transaksi);


--
-- TOC entry 2095 (class 2606 OID 30791)
-- Dependencies: 181 181
-- Name: pk_ustadz; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ustadz
    ADD CONSTRAINT pk_ustadz PRIMARY KEY (id_ustadz);


--
-- TOC entry 2053 (class 2606 OID 30330)
-- Dependencies: 159 159
-- Name: unique_kodifikasi_klasifikasi_transaksi; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY klasifikasi_transaksi
    ADD CONSTRAINT unique_kodifikasi_klasifikasi_transaksi UNIQUE (kodifikasi);


--
-- TOC entry 2059 (class 2606 OID 30383)
-- Dependencies: 161 161 161
-- Name: unique_kodifikasi_sub_klasifikasi_transaksi; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sub_klasifikasi_transaksi
    ADD CONSTRAINT unique_kodifikasi_sub_klasifikasi_transaksi UNIQUE (id_klasifikasi_transaksi, kodifikasi);


--
-- TOC entry 2085 (class 2606 OID 30696)
-- Dependencies: 175 175
-- Name: unique_nama_bank; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY bank
    ADD CONSTRAINT unique_nama_bank UNIQUE (nama);


--
-- TOC entry 2089 (class 2606 OID 30725)
-- Dependencies: 177 177
-- Name: unique_nama_guru_tpa; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY guru_tpa
    ADD CONSTRAINT unique_nama_guru_tpa UNIQUE (nama);


--
-- TOC entry 2093 (class 2606 OID 30759)
-- Dependencies: 179 179
-- Name: unique_nama_karyawan; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY karyawan
    ADD CONSTRAINT unique_nama_karyawan UNIQUE (nama);


--
-- TOC entry 2071 (class 2606 OID 30450)
-- Dependencies: 167 167
-- Name: unique_nama_kategori_pengeluaran; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY kategori_pengeluaran
    ADD CONSTRAINT unique_nama_kategori_pengeluaran UNIQUE (nama);


--
-- TOC entry 2055 (class 2606 OID 30332)
-- Dependencies: 159 159
-- Name: unique_nama_klasifikasi_transaksi; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY klasifikasi_transaksi
    ADD CONSTRAINT unique_nama_klasifikasi_transaksi UNIQUE (nama);


--
-- TOC entry 2081 (class 2606 OID 30669)
-- Dependencies: 173 173
-- Name: unique_nama_kota; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY kota
    ADD CONSTRAINT unique_nama_kota UNIQUE (nama);


--
-- TOC entry 2077 (class 2606 OID 30639)
-- Dependencies: 171 171
-- Name: unique_nama_propinsi; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY propinsi
    ADD CONSTRAINT unique_nama_propinsi UNIQUE (nama);


--
-- TOC entry 2061 (class 2606 OID 30385)
-- Dependencies: 161 161 161
-- Name: unique_nama_sub_klasifikasi_transaksi; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sub_klasifikasi_transaksi
    ADD CONSTRAINT unique_nama_sub_klasifikasi_transaksi UNIQUE (id_klasifikasi_transaksi, nama);


--
-- TOC entry 2097 (class 2606 OID 30793)
-- Dependencies: 181 181
-- Name: unique_nama_ustadz; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ustadz
    ADD CONSTRAINT unique_nama_ustadz UNIQUE (nama);


--
-- TOC entry 2065 (class 2606 OID 30412)
-- Dependencies: 163 163
-- Name: unique_no_bukti_transaksi; Type: CONSTRAINT; Schema: trans; Owner: -; Tablespace: 
--

ALTER TABLE ONLY transaksi
    ADD CONSTRAINT unique_no_bukti_transaksi UNIQUE (no_bukti);


SET search_path = akun, pg_catalog;

--
-- TOC entry 2131 (class 1259 OID 30990)
-- Dependencies: 206
-- Name: index_akmt_jurnal_no_bukti; Type: INDEX; Schema: akun; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_akmt_jurnal_no_bukti ON akmt_jurnal USING btree (no_bukti);


--
-- TOC entry 2102 (class 1259 OID 30844)
-- Dependencies: 187
-- Name: index_coa_number_akdd_detail_coa; Type: INDEX; Schema: akun; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_coa_number_akdd_detail_coa ON akdd_detail_coa USING btree (coa_number);


--
-- TOC entry 2169 (class 2606 OID 30878)
-- Dependencies: 193 187 2103
-- Name: akdd_detail_coa_akdd_detail_coa_lr; Type: FK CONSTRAINT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_detail_coa_lr
    ADD CONSTRAINT akdd_detail_coa_akdd_detail_coa_lr FOREIGN KEY (id_akdd_detail_coa) REFERENCES akdd_detail_coa(id_akdd_detail_coa) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2172 (class 2606 OID 30972)
-- Dependencies: 2103 187 204
-- Name: akdd_detail_coa_akmt_buku_besar; Type: FK CONSTRAINT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akmt_buku_besar
    ADD CONSTRAINT akdd_detail_coa_akmt_buku_besar FOREIGN KEY (id_akdd_detail_coa) REFERENCES akdd_detail_coa(id_akdd_detail_coa) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2174 (class 2606 OID 31000)
-- Dependencies: 187 2103 208
-- Name: akdd_detail_coa_akmt_jurnal_det; Type: FK CONSTRAINT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akmt_jurnal_det
    ADD CONSTRAINT akdd_detail_coa_akmt_jurnal_det FOREIGN KEY (id_akdd_detail_coa) REFERENCES akdd_detail_coa(id_akdd_detail_coa) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2171 (class 2606 OID 30911)
-- Dependencies: 195 187 2103
-- Name: akdd_detail_coa_map_id_akdd_detail_coa_fkey; Type: FK CONSTRAINT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_detail_coa_map
    ADD CONSTRAINT akdd_detail_coa_map_id_akdd_detail_coa_fkey FOREIGN KEY (id_akdd_detail_coa) REFERENCES akdd_detail_coa(id_akdd_detail_coa);


--
-- TOC entry 2170 (class 2606 OID 30883)
-- Dependencies: 193 2107 191
-- Name: akdd_klasifikasi_modal_akdd_detail_coa_lr; Type: FK CONSTRAINT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_detail_coa_lr
    ADD CONSTRAINT akdd_klasifikasi_modal_akdd_detail_coa_lr FOREIGN KEY (id_akdd_klasifikasi_modal) REFERENCES akdd_klasifikasi_modal(id_akdd_klasifikasi_modal) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2167 (class 2606 OID 30834)
-- Dependencies: 185 2100 187
-- Name: akdd_level_coa_akdd_main_coa; Type: FK CONSTRAINT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_detail_coa
    ADD CONSTRAINT akdd_level_coa_akdd_main_coa FOREIGN KEY (id_akdd_level_coa) REFERENCES akdd_level_coa(id_akdd_level_coa) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2168 (class 2606 OID 30839)
-- Dependencies: 2098 187 183
-- Name: akdd_main_coa_akdd_detail_coa; Type: FK CONSTRAINT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akdd_detail_coa
    ADD CONSTRAINT akdd_main_coa_akdd_detail_coa FOREIGN KEY (id_akdd_main_coa) REFERENCES akdd_main_coa(id_akdd_main_coa) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2175 (class 2606 OID 31005)
-- Dependencies: 2132 206 208
-- Name: akmt_jurnal_akmt_jurnal_det; Type: FK CONSTRAINT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akmt_jurnal_det
    ADD CONSTRAINT akmt_jurnal_akmt_jurnal_det FOREIGN KEY (id_akmt_jurnal) REFERENCES akmt_jurnal(id_akmt_jurnal) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2173 (class 2606 OID 30977)
-- Dependencies: 2125 204 202
-- Name: akmt_periode_akmt_buku_besar; Type: FK CONSTRAINT; Schema: akun; Owner: -
--

ALTER TABLE ONLY akmt_buku_besar
    ADD CONSTRAINT akmt_periode_akmt_buku_besar FOREIGN KEY (id_akmt_periode) REFERENCES akmt_periode(id_akmt_periode) ON UPDATE CASCADE ON DELETE RESTRICT DEFERRABLE;


SET search_path = public, pg_catalog;

--
-- TOC entry 2141 (class 2606 OID 30272)
-- Dependencies: 144 2016 156
-- Name: fk_dd_groups; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_users
    ADD CONSTRAINT fk_dd_groups FOREIGN KEY (id_dd_groups) REFERENCES dd_groups(id_dd_groups) ON DELETE CASCADE DEFERRABLE;


--
-- TOC entry 2136 (class 2606 OID 30277)
-- Dependencies: 144 2016 145
-- Name: fk_dd_groups; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_groups_detail
    ADD CONSTRAINT fk_dd_groups FOREIGN KEY (id_dd_groups) REFERENCES dd_groups(id_dd_groups) ON DELETE CASCADE DEFERRABLE;


--
-- TOC entry 2139 (class 2606 OID 30282)
-- Dependencies: 148 2022 152
-- Name: fk_dd_menus; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_sub_menus
    ADD CONSTRAINT fk_dd_menus FOREIGN KEY (id_dd_menus) REFERENCES dd_menus(id_dd_menus) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE;


--
-- TOC entry 2138 (class 2606 OID 30287)
-- Dependencies: 148 2028 150
-- Name: fk_dd_moduls; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_menus
    ADD CONSTRAINT fk_dd_moduls FOREIGN KEY (id_dd_moduls) REFERENCES dd_moduls(id_dd_moduls) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE;


--
-- TOC entry 2140 (class 2606 OID 30292)
-- Dependencies: 2034 152 154
-- Name: fk_dd_sub_menus; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_tabs
    ADD CONSTRAINT fk_dd_sub_menus FOREIGN KEY (id_dd_sub_menus) REFERENCES dd_sub_menus(id_dd_sub_menus) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE;


--
-- TOC entry 2137 (class 2606 OID 30297)
-- Dependencies: 145 154 2040
-- Name: fk_dd_tabs; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY dd_groups_detail
    ADD CONSTRAINT fk_dd_tabs FOREIGN KEY (id_dd_tabs) REFERENCES dd_tabs(id_dd_tabs) ON DELETE CASCADE DEFERRABLE;


SET search_path = trans, pg_catalog;

--
-- TOC entry 2156 (class 2606 OID 30697)
-- Dependencies: 2046 175 156
-- Name: fk_bank_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY bank
    ADD CONSTRAINT fk_bank_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2157 (class 2606 OID 30702)
-- Dependencies: 175 2078 173
-- Name: fk_bank_kota; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY bank
    ADD CONSTRAINT fk_bank_kota FOREIGN KEY (id_kota) REFERENCES kota(id_kota) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2158 (class 2606 OID 30726)
-- Dependencies: 2046 177 156
-- Name: fk_guru_tpa_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY guru_tpa
    ADD CONSTRAINT fk_guru_tpa_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2159 (class 2606 OID 30731)
-- Dependencies: 167 2068 177
-- Name: fk_guru_tpa_kategori_pengeluaran; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY guru_tpa
    ADD CONSTRAINT fk_guru_tpa_kategori_pengeluaran FOREIGN KEY (id_kategori_pengeluaran) REFERENCES kategori_pengeluaran(id_kategori_pengeluaran) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2160 (class 2606 OID 30736)
-- Dependencies: 173 177 2078
-- Name: fk_guru_tpa_kota; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY guru_tpa
    ADD CONSTRAINT fk_guru_tpa_kota FOREIGN KEY (id_kota) REFERENCES kota(id_kota) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2161 (class 2606 OID 30760)
-- Dependencies: 2046 156 179
-- Name: fk_karyawan_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY karyawan
    ADD CONSTRAINT fk_karyawan_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2162 (class 2606 OID 30765)
-- Dependencies: 167 179 2068
-- Name: fk_karyawan_kategori_pengeluaran; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY karyawan
    ADD CONSTRAINT fk_karyawan_kategori_pengeluaran FOREIGN KEY (id_kategori_pengeluaran) REFERENCES kategori_pengeluaran(id_kategori_pengeluaran) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2163 (class 2606 OID 30770)
-- Dependencies: 179 173 2078
-- Name: fk_karyawan_kota; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY karyawan
    ADD CONSTRAINT fk_karyawan_kota FOREIGN KEY (id_kota) REFERENCES kota(id_kota) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2149 (class 2606 OID 30451)
-- Dependencies: 167 2046 156
-- Name: fk_kategori_pengeluaran_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY kategori_pengeluaran
    ADD CONSTRAINT fk_kategori_pengeluaran_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2142 (class 2606 OID 30333)
-- Dependencies: 2046 156 159
-- Name: fk_klasifikasi_transaksi; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY klasifikasi_transaksi
    ADD CONSTRAINT fk_klasifikasi_transaksi FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2154 (class 2606 OID 30670)
-- Dependencies: 156 173 2046
-- Name: fk_kota_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY kota
    ADD CONSTRAINT fk_kota_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2155 (class 2606 OID 30675)
-- Dependencies: 2074 171 173
-- Name: fk_kota_propinsi; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY kota
    ADD CONSTRAINT fk_kota_propinsi FOREIGN KEY (id_propinsi) REFERENCES propinsi(id_propinsi) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2150 (class 2606 OID 30491)
-- Dependencies: 2046 156 169
-- Name: fk_map_kategori_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY map_kategori
    ADD CONSTRAINT fk_map_kategori_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2151 (class 2606 OID 30496)
-- Dependencies: 169 167 2068
-- Name: fk_map_kategori_kategori_pengeluaran; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY map_kategori
    ADD CONSTRAINT fk_map_kategori_kategori_pengeluaran FOREIGN KEY (id_kategori_pengeluaran) REFERENCES kategori_pengeluaran(id_kategori_pengeluaran) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2152 (class 2606 OID 30501)
-- Dependencies: 161 2056 169
-- Name: fk_map_kategori_sub_klasifikasi_transaksi; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY map_kategori
    ADD CONSTRAINT fk_map_kategori_sub_klasifikasi_transaksi FOREIGN KEY (id_sub_klasifikasi_transaksi) REFERENCES sub_klasifikasi_transaksi(id_sub_klasifikasi_transaksi) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2153 (class 2606 OID 30640)
-- Dependencies: 171 2046 156
-- Name: fk_propinsi_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY propinsi
    ADD CONSTRAINT fk_propinsi_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2143 (class 2606 OID 30386)
-- Dependencies: 161 2046 156
-- Name: fk_sub_klasifikasi_transaksi_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY sub_klasifikasi_transaksi
    ADD CONSTRAINT fk_sub_klasifikasi_transaksi_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2144 (class 2606 OID 30391)
-- Dependencies: 2050 161 159
-- Name: fk_sub_klasifikasi_transaksi_klasifikasi_transaksi; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY sub_klasifikasi_transaksi
    ADD CONSTRAINT fk_sub_klasifikasi_transaksi_klasifikasi_transaksi FOREIGN KEY (id_klasifikasi_transaksi) REFERENCES klasifikasi_transaksi(id_klasifikasi_transaksi) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2148 (class 2606 OID 30434)
-- Dependencies: 2046 156 165
-- Name: fk_sub_transaksi_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY sub_transaksi
    ADD CONSTRAINT fk_sub_transaksi_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2147 (class 2606 OID 30429)
-- Dependencies: 2056 165 161
-- Name: fk_sub_transaksi_sub_klasifikasi_transaksi; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY sub_transaksi
    ADD CONSTRAINT fk_sub_transaksi_sub_klasifikasi_transaksi FOREIGN KEY (id_sub_klasifikasi_transaksi) REFERENCES sub_klasifikasi_transaksi(id_sub_klasifikasi_transaksi) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2146 (class 2606 OID 30424)
-- Dependencies: 163 165 2062
-- Name: fk_sub_transaksi_transaksi; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY sub_transaksi
    ADD CONSTRAINT fk_sub_transaksi_transaksi FOREIGN KEY (id_transaksi) REFERENCES transaksi(id_transaksi) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2145 (class 2606 OID 30406)
-- Dependencies: 156 2046 163
-- Name: fk_transaksi_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY transaksi
    ADD CONSTRAINT fk_transaksi_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2164 (class 2606 OID 30794)
-- Dependencies: 156 2046 181
-- Name: fk_ustadz_dd_users; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY ustadz
    ADD CONSTRAINT fk_ustadz_dd_users FOREIGN KEY (id_dd_users) REFERENCES public.dd_users(id_dd_users) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2165 (class 2606 OID 30799)
-- Dependencies: 2068 181 167
-- Name: fk_ustadz_kategori_pengeluaran; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY ustadz
    ADD CONSTRAINT fk_ustadz_kategori_pengeluaran FOREIGN KEY (id_kategori_pengeluaran) REFERENCES kategori_pengeluaran(id_kategori_pengeluaran) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2166 (class 2606 OID 30804)
-- Dependencies: 181 2078 173
-- Name: fk_ustadz_kota; Type: FK CONSTRAINT; Schema: trans; Owner: -
--

ALTER TABLE ONLY ustadz
    ADD CONSTRAINT fk_ustadz_kota FOREIGN KEY (id_kota) REFERENCES kota(id_kota) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- TOC entry 2215 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: -
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO opensolutions;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2011-11-29 05:01:24

--
-- PostgreSQL database dump complete
--

