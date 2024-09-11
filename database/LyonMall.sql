--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4
-- Dumped by pg_dump version 16.4

-- Started on 2024-08-22 13:58:28

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
-- TOC entry 220 (class 1259 OID 16422)
-- Name: administrateurs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.administrateurs (
    admin_id integer NOT NULL,
    nom character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    mot_de_passe character varying(255) NOT NULL
);


ALTER TABLE public.administrateurs OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16421)
-- Name: administrateurs_admin_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.administrateurs_admin_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.administrateurs_admin_id_seq OWNER TO postgres;

--
-- TOC entry 4996 (class 0 OID 0)
-- Dependencies: 219
-- Name: administrateurs_admin_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.administrateurs_admin_id_seq OWNED BY public.administrateurs.admin_id;


--
-- TOC entry 224 (class 1259 OID 16442)
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    categorie_id integer NOT NULL,
    nom character varying(255) NOT NULL,
    description text
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16441)
-- Name: categories_categorie_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_categorie_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_categorie_id_seq OWNER TO postgres;

--
-- TOC entry 4997 (class 0 OID 0)
-- Dependencies: 223
-- Name: categories_categorie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_categorie_id_seq OWNED BY public.categories.categorie_id;


--
-- TOC entry 216 (class 1259 OID 16400)
-- Name: clients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clients (
    client_id integer NOT NULL,
    nom character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    mot_de_passe character varying(255) NOT NULL,
    adresse text
);


ALTER TABLE public.clients OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16399)
-- Name: clients_client_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.clients_client_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.clients_client_id_seq OWNER TO postgres;

--
-- TOC entry 4998 (class 0 OID 0)
-- Dependencies: 215
-- Name: clients_client_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.clients_client_id_seq OWNED BY public.clients.client_id;


--
-- TOC entry 228 (class 1259 OID 16465)
-- Name: commandes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.commandes (
    commande_id integer NOT NULL,
    client_id integer,
    date_commande timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    statut character varying(50),
    total numeric(10,2),
    CONSTRAINT commandes_statut_check CHECK (((statut)::text = ANY ((ARRAY['pending'::character varying, 'paid'::character varying, 'shipped'::character varying, 'delivered'::character varying, 'cancelled'::character varying])::text[])))
);


ALTER TABLE public.commandes OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16464)
-- Name: commandes_commande_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.commandes_commande_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.commandes_commande_id_seq OWNER TO postgres;

--
-- TOC entry 4999 (class 0 OID 0)
-- Dependencies: 227
-- Name: commandes_commande_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.commandes_commande_id_seq OWNED BY public.commandes.commande_id;


--
-- TOC entry 240 (class 1259 OID 16553)
-- Name: contrats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contrats (
    contrat_id integer NOT NULL,
    vendeur_id integer,
    date_signature timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    conditions text
);


ALTER TABLE public.contrats OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 16552)
-- Name: contrats_contrat_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contrats_contrat_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.contrats_contrat_id_seq OWNER TO postgres;

--
-- TOC entry 5000 (class 0 OID 0)
-- Dependencies: 239
-- Name: contrats_contrat_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contrats_contrat_id_seq OWNED BY public.contrats.contrat_id;


--
-- TOC entry 236 (class 1259 OID 16521)
-- Name: livraisons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.livraisons (
    livraison_id integer NOT NULL,
    commande_id integer,
    prestataire_id integer,
    statut_livraison character varying(50),
    numero_suivi character varying(100),
    date_envoi timestamp without time zone,
    date_livraison timestamp without time zone,
    CONSTRAINT livraisons_statut_livraison_check CHECK (((statut_livraison)::text = ANY ((ARRAY['pending'::character varying, 'in_transit'::character varying, 'delivered'::character varying, 'failed'::character varying])::text[])))
);


ALTER TABLE public.livraisons OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16520)
-- Name: livraisons_livraison_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.livraisons_livraison_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.livraisons_livraison_id_seq OWNER TO postgres;

--
-- TOC entry 5001 (class 0 OID 0)
-- Dependencies: 235
-- Name: livraisons_livraison_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.livraisons_livraison_id_seq OWNED BY public.livraisons.livraison_id;


--
-- TOC entry 234 (class 1259 OID 16508)
-- Name: paiements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.paiements (
    paiement_id integer NOT NULL,
    commande_id integer,
    montant numeric(10,2),
    methode_paiement character varying(50),
    statut character varying(50),
    CONSTRAINT paiements_statut_check CHECK (((statut)::text = ANY ((ARRAY['pending'::character varying, 'completed'::character varying, 'failed'::character varying])::text[])))
);


ALTER TABLE public.paiements OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16507)
-- Name: paiements_paiement_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.paiements_paiement_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.paiements_paiement_id_seq OWNER TO postgres;

--
-- TOC entry 5002 (class 0 OID 0)
-- Dependencies: 233
-- Name: paiements_paiement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.paiements_paiement_id_seq OWNED BY public.paiements.paiement_id;


--
-- TOC entry 232 (class 1259 OID 16491)
-- Name: panierproduits; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.panierproduits (
    panier_produit_id integer NOT NULL,
    panier_id integer,
    produit_id integer,
    quantite integer
);


ALTER TABLE public.panierproduits OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16490)
-- Name: panierproduits_panier_produit_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.panierproduits_panier_produit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.panierproduits_panier_produit_id_seq OWNER TO postgres;

--
-- TOC entry 5003 (class 0 OID 0)
-- Dependencies: 231
-- Name: panierproduits_panier_produit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.panierproduits_panier_produit_id_seq OWNED BY public.panierproduits.panier_produit_id;


--
-- TOC entry 230 (class 1259 OID 16479)
-- Name: paniers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.paniers (
    panier_id integer NOT NULL,
    client_id integer
);


ALTER TABLE public.paniers OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16478)
-- Name: paniers_panier_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.paniers_panier_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.paniers_panier_id_seq OWNER TO postgres;

--
-- TOC entry 5004 (class 0 OID 0)
-- Dependencies: 229
-- Name: paniers_panier_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.paniers_panier_id_seq OWNED BY public.paniers.panier_id;


--
-- TOC entry 222 (class 1259 OID 16433)
-- Name: prestatairesdelivraison; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prestatairesdelivraison (
    prestataire_id integer NOT NULL,
    nom character varying(255) NOT NULL,
    adresse text
);


ALTER TABLE public.prestatairesdelivraison OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16432)
-- Name: prestatairesdelivraison_prestataire_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.prestatairesdelivraison_prestataire_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.prestatairesdelivraison_prestataire_id_seq OWNER TO postgres;

--
-- TOC entry 5005 (class 0 OID 0)
-- Dependencies: 221
-- Name: prestatairesdelivraison_prestataire_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.prestatairesdelivraison_prestataire_id_seq OWNED BY public.prestatairesdelivraison.prestataire_id;


--
-- TOC entry 226 (class 1259 OID 16451)
-- Name: produits; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.produits (
    produit_id integer NOT NULL,
    nom character varying(255) NOT NULL,
    description text,
    prix numeric(10,2) NOT NULL,
    quantite integer NOT NULL,
    categorie_id integer,
    image_url text
);


ALTER TABLE public.produits OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16450)
-- Name: produits_produit_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.produits_produit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.produits_produit_id_seq OWNER TO postgres;

--
-- TOC entry 5006 (class 0 OID 0)
-- Dependencies: 225
-- Name: produits_produit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.produits_produit_id_seq OWNED BY public.produits.produit_id;


--
-- TOC entry 238 (class 1259 OID 16539)
-- Name: retours; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.retours (
    retour_id integer NOT NULL,
    commande_id integer,
    date_retour timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    statut character varying(50),
    CONSTRAINT retours_statut_check CHECK (((statut)::text = ANY ((ARRAY['requested'::character varying, 'approved'::character varying, 'rejected'::character varying, 'completed'::character varying])::text[])))
);


ALTER TABLE public.retours OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16538)
-- Name: retours_retour_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.retours_retour_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.retours_retour_id_seq OWNER TO postgres;

--
-- TOC entry 5007 (class 0 OID 0)
-- Dependencies: 237
-- Name: retours_retour_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.retours_retour_id_seq OWNED BY public.retours.retour_id;


--
-- TOC entry 218 (class 1259 OID 16411)
-- Name: vendeurs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vendeurs (
    vendeur_id integer NOT NULL,
    nom character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    mot_de_passe character varying(255) NOT NULL,
    adresse text
);


ALTER TABLE public.vendeurs OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16410)
-- Name: vendeurs_vendeur_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vendeurs_vendeur_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vendeurs_vendeur_id_seq OWNER TO postgres;

--
-- TOC entry 5008 (class 0 OID 0)
-- Dependencies: 217
-- Name: vendeurs_vendeur_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vendeurs_vendeur_id_seq OWNED BY public.vendeurs.vendeur_id;


--
-- TOC entry 242 (class 1259 OID 16568)
-- Name: ventes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ventes (
    vente_id integer NOT NULL,
    produit_id integer,
    quantite integer,
    date_vente timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.ventes OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 16567)
-- Name: ventes_vente_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ventes_vente_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ventes_vente_id_seq OWNER TO postgres;

--
-- TOC entry 5009 (class 0 OID 0)
-- Dependencies: 241
-- Name: ventes_vente_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ventes_vente_id_seq OWNED BY public.ventes.vente_id;


--
-- TOC entry 4755 (class 2604 OID 16425)
-- Name: administrateurs admin_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.administrateurs ALTER COLUMN admin_id SET DEFAULT nextval('public.administrateurs_admin_id_seq'::regclass);


--
-- TOC entry 4757 (class 2604 OID 16445)
-- Name: categories categorie_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN categorie_id SET DEFAULT nextval('public.categories_categorie_id_seq'::regclass);


--
-- TOC entry 4753 (class 2604 OID 16403)
-- Name: clients client_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients ALTER COLUMN client_id SET DEFAULT nextval('public.clients_client_id_seq'::regclass);


--
-- TOC entry 4759 (class 2604 OID 16468)
-- Name: commandes commande_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commandes ALTER COLUMN commande_id SET DEFAULT nextval('public.commandes_commande_id_seq'::regclass);


--
-- TOC entry 4767 (class 2604 OID 16556)
-- Name: contrats contrat_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contrats ALTER COLUMN contrat_id SET DEFAULT nextval('public.contrats_contrat_id_seq'::regclass);


--
-- TOC entry 4764 (class 2604 OID 16524)
-- Name: livraisons livraison_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.livraisons ALTER COLUMN livraison_id SET DEFAULT nextval('public.livraisons_livraison_id_seq'::regclass);


--
-- TOC entry 4763 (class 2604 OID 16511)
-- Name: paiements paiement_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paiements ALTER COLUMN paiement_id SET DEFAULT nextval('public.paiements_paiement_id_seq'::regclass);


--
-- TOC entry 4762 (class 2604 OID 16494)
-- Name: panierproduits panier_produit_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.panierproduits ALTER COLUMN panier_produit_id SET DEFAULT nextval('public.panierproduits_panier_produit_id_seq'::regclass);


--
-- TOC entry 4761 (class 2604 OID 16482)
-- Name: paniers panier_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paniers ALTER COLUMN panier_id SET DEFAULT nextval('public.paniers_panier_id_seq'::regclass);


--
-- TOC entry 4756 (class 2604 OID 16436)
-- Name: prestatairesdelivraison prestataire_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prestatairesdelivraison ALTER COLUMN prestataire_id SET DEFAULT nextval('public.prestatairesdelivraison_prestataire_id_seq'::regclass);


--
-- TOC entry 4758 (class 2604 OID 16454)
-- Name: produits produit_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produits ALTER COLUMN produit_id SET DEFAULT nextval('public.produits_produit_id_seq'::regclass);


--
-- TOC entry 4765 (class 2604 OID 16542)
-- Name: retours retour_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.retours ALTER COLUMN retour_id SET DEFAULT nextval('public.retours_retour_id_seq'::regclass);


--
-- TOC entry 4754 (class 2604 OID 16414)
-- Name: vendeurs vendeur_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendeurs ALTER COLUMN vendeur_id SET DEFAULT nextval('public.vendeurs_vendeur_id_seq'::regclass);


--
-- TOC entry 4769 (class 2604 OID 16571)
-- Name: ventes vente_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ventes ALTER COLUMN vente_id SET DEFAULT nextval('public.ventes_vente_id_seq'::regclass);


--
-- TOC entry 4968 (class 0 OID 16422)
-- Dependencies: 220
-- Data for Name: administrateurs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.administrateurs (admin_id, nom, email, mot_de_passe) FROM stdin;
\.


--
-- TOC entry 4972 (class 0 OID 16442)
-- Dependencies: 224
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (categorie_id, nom, description) FROM stdin;
\.


--
-- TOC entry 4964 (class 0 OID 16400)
-- Dependencies: 216
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clients (client_id, nom, email, mot_de_passe, adresse) FROM stdin;
\.


--
-- TOC entry 4976 (class 0 OID 16465)
-- Dependencies: 228
-- Data for Name: commandes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.commandes (commande_id, client_id, date_commande, statut, total) FROM stdin;
\.


--
-- TOC entry 4988 (class 0 OID 16553)
-- Dependencies: 240
-- Data for Name: contrats; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contrats (contrat_id, vendeur_id, date_signature, conditions) FROM stdin;
\.


--
-- TOC entry 4984 (class 0 OID 16521)
-- Dependencies: 236
-- Data for Name: livraisons; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.livraisons (livraison_id, commande_id, prestataire_id, statut_livraison, numero_suivi, date_envoi, date_livraison) FROM stdin;
\.


--
-- TOC entry 4982 (class 0 OID 16508)
-- Dependencies: 234
-- Data for Name: paiements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.paiements (paiement_id, commande_id, montant, methode_paiement, statut) FROM stdin;
\.


--
-- TOC entry 4980 (class 0 OID 16491)
-- Dependencies: 232
-- Data for Name: panierproduits; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.panierproduits (panier_produit_id, panier_id, produit_id, quantite) FROM stdin;
\.


--
-- TOC entry 4978 (class 0 OID 16479)
-- Dependencies: 230
-- Data for Name: paniers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.paniers (panier_id, client_id) FROM stdin;
\.


--
-- TOC entry 4970 (class 0 OID 16433)
-- Dependencies: 222
-- Data for Name: prestatairesdelivraison; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.prestatairesdelivraison (prestataire_id, nom, adresse) FROM stdin;
\.


--
-- TOC entry 4974 (class 0 OID 16451)
-- Dependencies: 226
-- Data for Name: produits; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.produits (produit_id, nom, description, prix, quantite, categorie_id, image_url) FROM stdin;
\.


--
-- TOC entry 4986 (class 0 OID 16539)
-- Dependencies: 238
-- Data for Name: retours; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.retours (retour_id, commande_id, date_retour, statut) FROM stdin;
\.


--
-- TOC entry 4966 (class 0 OID 16411)
-- Dependencies: 218
-- Data for Name: vendeurs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vendeurs (vendeur_id, nom, email, mot_de_passe, adresse) FROM stdin;
\.


--
-- TOC entry 4990 (class 0 OID 16568)
-- Dependencies: 242
-- Data for Name: ventes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ventes (vente_id, produit_id, quantite, date_vente) FROM stdin;
\.


--
-- TOC entry 5010 (class 0 OID 0)
-- Dependencies: 219
-- Name: administrateurs_admin_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.administrateurs_admin_id_seq', 1, false);


--
-- TOC entry 5011 (class 0 OID 0)
-- Dependencies: 223
-- Name: categories_categorie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_categorie_id_seq', 1, false);


--
-- TOC entry 5012 (class 0 OID 0)
-- Dependencies: 215
-- Name: clients_client_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clients_client_id_seq', 1, false);


--
-- TOC entry 5013 (class 0 OID 0)
-- Dependencies: 227
-- Name: commandes_commande_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.commandes_commande_id_seq', 1, false);


--
-- TOC entry 5014 (class 0 OID 0)
-- Dependencies: 239
-- Name: contrats_contrat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contrats_contrat_id_seq', 1, false);


--
-- TOC entry 5015 (class 0 OID 0)
-- Dependencies: 235
-- Name: livraisons_livraison_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.livraisons_livraison_id_seq', 1, false);


--
-- TOC entry 5016 (class 0 OID 0)
-- Dependencies: 233
-- Name: paiements_paiement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.paiements_paiement_id_seq', 1, false);


--
-- TOC entry 5017 (class 0 OID 0)
-- Dependencies: 231
-- Name: panierproduits_panier_produit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.panierproduits_panier_produit_id_seq', 1, false);


--
-- TOC entry 5018 (class 0 OID 0)
-- Dependencies: 229
-- Name: paniers_panier_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.paniers_panier_id_seq', 1, false);


--
-- TOC entry 5019 (class 0 OID 0)
-- Dependencies: 221
-- Name: prestatairesdelivraison_prestataire_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.prestatairesdelivraison_prestataire_id_seq', 1, false);


--
-- TOC entry 5020 (class 0 OID 0)
-- Dependencies: 225
-- Name: produits_produit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.produits_produit_id_seq', 1, false);


--
-- TOC entry 5021 (class 0 OID 0)
-- Dependencies: 237
-- Name: retours_retour_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.retours_retour_id_seq', 1, false);


--
-- TOC entry 5022 (class 0 OID 0)
-- Dependencies: 217
-- Name: vendeurs_vendeur_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vendeurs_vendeur_id_seq', 1, false);


--
-- TOC entry 5023 (class 0 OID 0)
-- Dependencies: 241
-- Name: ventes_vente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ventes_vente_id_seq', 1, false);


--
-- TOC entry 4784 (class 2606 OID 16431)
-- Name: administrateurs administrateurs_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.administrateurs
    ADD CONSTRAINT administrateurs_email_key UNIQUE (email);


--
-- TOC entry 4786 (class 2606 OID 16429)
-- Name: administrateurs administrateurs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.administrateurs
    ADD CONSTRAINT administrateurs_pkey PRIMARY KEY (admin_id);


--
-- TOC entry 4790 (class 2606 OID 16449)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (categorie_id);


--
-- TOC entry 4776 (class 2606 OID 16409)
-- Name: clients clients_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_email_key UNIQUE (email);


--
-- TOC entry 4778 (class 2606 OID 16407)
-- Name: clients clients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (client_id);


--
-- TOC entry 4794 (class 2606 OID 16472)
-- Name: commandes commandes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commandes
    ADD CONSTRAINT commandes_pkey PRIMARY KEY (commande_id);


--
-- TOC entry 4806 (class 2606 OID 16561)
-- Name: contrats contrats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contrats
    ADD CONSTRAINT contrats_pkey PRIMARY KEY (contrat_id);


--
-- TOC entry 4802 (class 2606 OID 16527)
-- Name: livraisons livraisons_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.livraisons
    ADD CONSTRAINT livraisons_pkey PRIMARY KEY (livraison_id);


--
-- TOC entry 4800 (class 2606 OID 16514)
-- Name: paiements paiements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paiements
    ADD CONSTRAINT paiements_pkey PRIMARY KEY (paiement_id);


--
-- TOC entry 4798 (class 2606 OID 16496)
-- Name: panierproduits panierproduits_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.panierproduits
    ADD CONSTRAINT panierproduits_pkey PRIMARY KEY (panier_produit_id);


--
-- TOC entry 4796 (class 2606 OID 16484)
-- Name: paniers paniers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paniers
    ADD CONSTRAINT paniers_pkey PRIMARY KEY (panier_id);


--
-- TOC entry 4788 (class 2606 OID 16440)
-- Name: prestatairesdelivraison prestatairesdelivraison_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prestatairesdelivraison
    ADD CONSTRAINT prestatairesdelivraison_pkey PRIMARY KEY (prestataire_id);


--
-- TOC entry 4792 (class 2606 OID 16458)
-- Name: produits produits_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produits
    ADD CONSTRAINT produits_pkey PRIMARY KEY (produit_id);


--
-- TOC entry 4804 (class 2606 OID 16546)
-- Name: retours retours_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.retours
    ADD CONSTRAINT retours_pkey PRIMARY KEY (retour_id);


--
-- TOC entry 4780 (class 2606 OID 16420)
-- Name: vendeurs vendeurs_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendeurs
    ADD CONSTRAINT vendeurs_email_key UNIQUE (email);


--
-- TOC entry 4782 (class 2606 OID 16418)
-- Name: vendeurs vendeurs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendeurs
    ADD CONSTRAINT vendeurs_pkey PRIMARY KEY (vendeur_id);


--
-- TOC entry 4808 (class 2606 OID 16574)
-- Name: ventes ventes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ventes
    ADD CONSTRAINT ventes_pkey PRIMARY KEY (vente_id);


--
-- TOC entry 4810 (class 2606 OID 16473)
-- Name: commandes commandes_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commandes
    ADD CONSTRAINT commandes_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.clients(client_id);


--
-- TOC entry 4818 (class 2606 OID 16562)
-- Name: contrats contrats_vendeur_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contrats
    ADD CONSTRAINT contrats_vendeur_id_fkey FOREIGN KEY (vendeur_id) REFERENCES public.vendeurs(vendeur_id);


--
-- TOC entry 4815 (class 2606 OID 16528)
-- Name: livraisons livraisons_commande_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.livraisons
    ADD CONSTRAINT livraisons_commande_id_fkey FOREIGN KEY (commande_id) REFERENCES public.commandes(commande_id);


--
-- TOC entry 4816 (class 2606 OID 16533)
-- Name: livraisons livraisons_prestataire_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.livraisons
    ADD CONSTRAINT livraisons_prestataire_id_fkey FOREIGN KEY (prestataire_id) REFERENCES public.prestatairesdelivraison(prestataire_id);


--
-- TOC entry 4814 (class 2606 OID 16515)
-- Name: paiements paiements_commande_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paiements
    ADD CONSTRAINT paiements_commande_id_fkey FOREIGN KEY (commande_id) REFERENCES public.commandes(commande_id);


--
-- TOC entry 4812 (class 2606 OID 16497)
-- Name: panierproduits panierproduits_panier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.panierproduits
    ADD CONSTRAINT panierproduits_panier_id_fkey FOREIGN KEY (panier_id) REFERENCES public.paniers(panier_id);


--
-- TOC entry 4813 (class 2606 OID 16502)
-- Name: panierproduits panierproduits_produit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.panierproduits
    ADD CONSTRAINT panierproduits_produit_id_fkey FOREIGN KEY (produit_id) REFERENCES public.produits(produit_id);


--
-- TOC entry 4811 (class 2606 OID 16485)
-- Name: paniers paniers_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paniers
    ADD CONSTRAINT paniers_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.clients(client_id);


--
-- TOC entry 4809 (class 2606 OID 16459)
-- Name: produits produits_categorie_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produits
    ADD CONSTRAINT produits_categorie_id_fkey FOREIGN KEY (categorie_id) REFERENCES public.categories(categorie_id);


--
-- TOC entry 4817 (class 2606 OID 16547)
-- Name: retours retours_commande_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.retours
    ADD CONSTRAINT retours_commande_id_fkey FOREIGN KEY (commande_id) REFERENCES public.commandes(commande_id);


--
-- TOC entry 4819 (class 2606 OID 16575)
-- Name: ventes ventes_produit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ventes
    ADD CONSTRAINT ventes_produit_id_fkey FOREIGN KEY (produit_id) REFERENCES public.produits(produit_id);


-- Completed on 2024-08-22 13:58:28

--
-- PostgreSQL database dump complete
--

