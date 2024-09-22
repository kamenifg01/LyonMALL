--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4
-- Dumped by pg_dump version 16.4

-- Started on 2024-09-17 16:14:23

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
-- TOC entry 247 (class 1259 OID 16937)
-- Name: SequelizeMeta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."SequelizeMeta" (
    name character varying(255) NOT NULL
);


ALTER TABLE public."SequelizeMeta" OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16758)
-- Name: administrateurs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.administrateurs (
    id integer NOT NULL,
    utilisateur_id integer NOT NULL
);


ALTER TABLE public.administrateurs OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16757)
-- Name: administrateurs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.administrateurs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.administrateurs_id_seq OWNER TO postgres;

--
-- TOC entry 5037 (class 0 OID 0)
-- Dependencies: 221
-- Name: administrateurs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.administrateurs_id_seq OWNED BY public.administrateurs.id;


--
-- TOC entry 226 (class 1259 OID 16779)
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    nom character varying(255) NOT NULL,
    description text
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16778)
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_id_seq OWNER TO postgres;

--
-- TOC entry 5038 (class 0 OID 0)
-- Dependencies: 225
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- TOC entry 218 (class 1259 OID 16734)
-- Name: clients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clients (
    id integer NOT NULL,
    utilisateur_id integer NOT NULL
);


ALTER TABLE public.clients OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16733)
-- Name: clients_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.clients_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.clients_id_seq OWNER TO postgres;

--
-- TOC entry 5039 (class 0 OID 0)
-- Dependencies: 217
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.clients_id_seq OWNED BY public.clients.id;


--
-- TOC entry 234 (class 1259 OID 16835)
-- Name: commande_produits; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.commande_produits (
    id integer NOT NULL,
    commande_id integer NOT NULL,
    produit_id integer NOT NULL,
    quantite integer NOT NULL
);


ALTER TABLE public.commande_produits OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16834)
-- Name: commande_produits_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.commande_produits_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.commande_produits_id_seq OWNER TO postgres;

--
-- TOC entry 5040 (class 0 OID 0)
-- Dependencies: 233
-- Name: commande_produits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.commande_produits_id_seq OWNED BY public.commande_produits.id;


--
-- TOC entry 232 (class 1259 OID 16822)
-- Name: commandes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.commandes (
    id integer NOT NULL,
    utilisateur_id integer NOT NULL,
    date_commande timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    statut character varying(50) NOT NULL,
    total numeric(10,2) NOT NULL
);


ALTER TABLE public.commandes OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16821)
-- Name: commandes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.commandes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.commandes_id_seq OWNER TO postgres;

--
-- TOC entry 5041 (class 0 OID 0)
-- Dependencies: 231
-- Name: commandes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.commandes_id_seq OWNED BY public.commandes.id;


--
-- TOC entry 246 (class 1259 OID 16922)
-- Name: contrats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contrats (
    id integer NOT NULL,
    vendeur_id integer NOT NULL,
    date_signature timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    conditions text
);


ALTER TABLE public.contrats OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 16921)
-- Name: contrats_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contrats_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.contrats_id_seq OWNER TO postgres;

--
-- TOC entry 5042 (class 0 OID 0)
-- Dependencies: 245
-- Name: contrats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contrats_id_seq OWNED BY public.contrats.id;


--
-- TOC entry 242 (class 1259 OID 16886)
-- Name: livraisons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.livraisons (
    id integer NOT NULL,
    commande_id integer NOT NULL,
    prestataire_id integer NOT NULL,
    statut_livraison character varying(50) NOT NULL,
    numero_suivi character varying(100),
    date_envoi timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    date_livraison timestamp without time zone
);


ALTER TABLE public.livraisons OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 16885)
-- Name: livraisons_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.livraisons_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.livraisons_id_seq OWNER TO postgres;

--
-- TOC entry 5043 (class 0 OID 0)
-- Dependencies: 241
-- Name: livraisons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.livraisons_id_seq OWNED BY public.livraisons.id;


--
-- TOC entry 249 (class 1259 OID 16943)
-- Name: notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notifications (
    id integer NOT NULL,
    "userId" integer NOT NULL,
    message character varying(255) NOT NULL,
    status character varying(255) DEFAULT 'unread'::character varying NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.notifications OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 16942)
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notifications_id_seq OWNER TO postgres;

--
-- TOC entry 5044 (class 0 OID 0)
-- Dependencies: 248
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- TOC entry 236 (class 1259 OID 16852)
-- Name: paiements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.paiements (
    id integer NOT NULL,
    commande_id integer NOT NULL,
    montant numeric(10,2) NOT NULL,
    methode_paiement character varying(50) NOT NULL,
    statut character varying(50) NOT NULL
);


ALTER TABLE public.paiements OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16851)
-- Name: paiements_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.paiements_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.paiements_id_seq OWNER TO postgres;

--
-- TOC entry 5045 (class 0 OID 0)
-- Dependencies: 235
-- Name: paiements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.paiements_id_seq OWNED BY public.paiements.id;


--
-- TOC entry 230 (class 1259 OID 16805)
-- Name: panier_produits; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.panier_produits (
    id integer NOT NULL,
    panier_id integer NOT NULL,
    produit_id integer NOT NULL,
    quantite integer NOT NULL
);


ALTER TABLE public.panier_produits OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16804)
-- Name: panier_produits_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.panier_produits_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.panier_produits_id_seq OWNER TO postgres;

--
-- TOC entry 5046 (class 0 OID 0)
-- Dependencies: 229
-- Name: panier_produits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.panier_produits_id_seq OWNED BY public.panier_produits.id;


--
-- TOC entry 228 (class 1259 OID 16793)
-- Name: paniers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.paniers (
    id integer NOT NULL,
    utilisateur_id integer NOT NULL
);


ALTER TABLE public.paniers OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16792)
-- Name: paniers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.paniers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.paniers_id_seq OWNER TO postgres;

--
-- TOC entry 5047 (class 0 OID 0)
-- Dependencies: 227
-- Name: paniers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.paniers_id_seq OWNED BY public.paniers.id;


--
-- TOC entry 240 (class 1259 OID 16877)
-- Name: prestataires_de_livraison; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prestataires_de_livraison (
    id integer NOT NULL,
    nom character varying(255) NOT NULL,
    adresse character varying(255) NOT NULL
);


ALTER TABLE public.prestataires_de_livraison OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 16876)
-- Name: prestataires_de_livraison_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.prestataires_de_livraison_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.prestataires_de_livraison_id_seq OWNER TO postgres;

--
-- TOC entry 5048 (class 0 OID 0)
-- Dependencies: 239
-- Name: prestataires_de_livraison_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.prestataires_de_livraison_id_seq OWNED BY public.prestataires_de_livraison.id;


--
-- TOC entry 224 (class 1259 OID 16770)
-- Name: produits; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.produits (
    id integer NOT NULL,
    nom character varying(255) NOT NULL,
    description text,
    prix numeric(10,2) NOT NULL,
    quantite integer NOT NULL,
    categorie_id integer,
    image_url text
);


ALTER TABLE public.produits OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16769)
-- Name: produits_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.produits_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.produits_id_seq OWNER TO postgres;

--
-- TOC entry 5049 (class 0 OID 0)
-- Dependencies: 223
-- Name: produits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.produits_id_seq OWNED BY public.produits.id;


--
-- TOC entry 238 (class 1259 OID 16864)
-- Name: retours; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.retours (
    id integer NOT NULL,
    commande_id integer NOT NULL,
    date_retour timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    statut character varying(50) NOT NULL
);


ALTER TABLE public.retours OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16863)
-- Name: retours_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.retours_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.retours_id_seq OWNER TO postgres;

--
-- TOC entry 5050 (class 0 OID 0)
-- Dependencies: 237
-- Name: retours_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.retours_id_seq OWNED BY public.retours.id;


--
-- TOC entry 216 (class 1259 OID 16722)
-- Name: utilisateurs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.utilisateurs (
    id integer NOT NULL,
    nom character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    mot_de_passe character varying(255) NOT NULL,
    adresse character varying(255),
    role character varying(50) NOT NULL,
    CONSTRAINT utilisateurs_role_check CHECK (((role)::text = ANY ((ARRAY['client'::character varying, 'vendeur'::character varying, 'admin'::character varying])::text[])))
);


ALTER TABLE public.utilisateurs OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16721)
-- Name: utilisateurs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.utilisateurs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.utilisateurs_id_seq OWNER TO postgres;

--
-- TOC entry 5051 (class 0 OID 0)
-- Dependencies: 215
-- Name: utilisateurs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.utilisateurs_id_seq OWNED BY public.utilisateurs.id;


--
-- TOC entry 220 (class 1259 OID 16746)
-- Name: vendeurs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vendeurs (
    id integer NOT NULL,
    utilisateur_id integer NOT NULL
);


ALTER TABLE public.vendeurs OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16745)
-- Name: vendeurs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vendeurs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vendeurs_id_seq OWNER TO postgres;

--
-- TOC entry 5052 (class 0 OID 0)
-- Dependencies: 219
-- Name: vendeurs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vendeurs_id_seq OWNED BY public.vendeurs.id;


--
-- TOC entry 244 (class 1259 OID 16904)
-- Name: ventes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ventes (
    id integer NOT NULL,
    produit_id integer NOT NULL,
    quantite integer NOT NULL,
    date_vente timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    utilisateur_id integer NOT NULL
);


ALTER TABLE public.ventes OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 16903)
-- Name: ventes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ventes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ventes_id_seq OWNER TO postgres;

--
-- TOC entry 5053 (class 0 OID 0)
-- Dependencies: 243
-- Name: ventes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ventes_id_seq OWNED BY public.ventes.id;


--
-- TOC entry 4775 (class 2604 OID 16761)
-- Name: administrateurs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.administrateurs ALTER COLUMN id SET DEFAULT nextval('public.administrateurs_id_seq'::regclass);


--
-- TOC entry 4777 (class 2604 OID 16782)
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- TOC entry 4773 (class 2604 OID 16737)
-- Name: clients id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients ALTER COLUMN id SET DEFAULT nextval('public.clients_id_seq'::regclass);


--
-- TOC entry 4782 (class 2604 OID 16838)
-- Name: commande_produits id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commande_produits ALTER COLUMN id SET DEFAULT nextval('public.commande_produits_id_seq'::regclass);


--
-- TOC entry 4780 (class 2604 OID 16825)
-- Name: commandes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commandes ALTER COLUMN id SET DEFAULT nextval('public.commandes_id_seq'::regclass);


--
-- TOC entry 4791 (class 2604 OID 16925)
-- Name: contrats id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contrats ALTER COLUMN id SET DEFAULT nextval('public.contrats_id_seq'::regclass);


--
-- TOC entry 4787 (class 2604 OID 16889)
-- Name: livraisons id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.livraisons ALTER COLUMN id SET DEFAULT nextval('public.livraisons_id_seq'::regclass);


--
-- TOC entry 4793 (class 2604 OID 16946)
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- TOC entry 4783 (class 2604 OID 16855)
-- Name: paiements id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paiements ALTER COLUMN id SET DEFAULT nextval('public.paiements_id_seq'::regclass);


--
-- TOC entry 4779 (class 2604 OID 16808)
-- Name: panier_produits id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.panier_produits ALTER COLUMN id SET DEFAULT nextval('public.panier_produits_id_seq'::regclass);


--
-- TOC entry 4778 (class 2604 OID 16796)
-- Name: paniers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paniers ALTER COLUMN id SET DEFAULT nextval('public.paniers_id_seq'::regclass);


--
-- TOC entry 4786 (class 2604 OID 16880)
-- Name: prestataires_de_livraison id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prestataires_de_livraison ALTER COLUMN id SET DEFAULT nextval('public.prestataires_de_livraison_id_seq'::regclass);


--
-- TOC entry 4776 (class 2604 OID 16773)
-- Name: produits id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produits ALTER COLUMN id SET DEFAULT nextval('public.produits_id_seq'::regclass);


--
-- TOC entry 4784 (class 2604 OID 16867)
-- Name: retours id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.retours ALTER COLUMN id SET DEFAULT nextval('public.retours_id_seq'::regclass);


--
-- TOC entry 4772 (class 2604 OID 16725)
-- Name: utilisateurs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateurs ALTER COLUMN id SET DEFAULT nextval('public.utilisateurs_id_seq'::regclass);


--
-- TOC entry 4774 (class 2604 OID 16749)
-- Name: vendeurs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendeurs ALTER COLUMN id SET DEFAULT nextval('public.vendeurs_id_seq'::regclass);


--
-- TOC entry 4789 (class 2604 OID 16907)
-- Name: ventes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ventes ALTER COLUMN id SET DEFAULT nextval('public.ventes_id_seq'::regclass);


--
-- TOC entry 5029 (class 0 OID 16937)
-- Dependencies: 247
-- Data for Name: SequelizeMeta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."SequelizeMeta" (name) FROM stdin;
20240914232240-create-notifications.js
\.


--
-- TOC entry 5004 (class 0 OID 16758)
-- Dependencies: 222
-- Data for Name: administrateurs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.administrateurs (id, utilisateur_id) FROM stdin;
\.


--
-- TOC entry 5008 (class 0 OID 16779)
-- Dependencies: 226
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, nom, description) FROM stdin;
\.


--
-- TOC entry 5000 (class 0 OID 16734)
-- Dependencies: 218
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clients (id, utilisateur_id) FROM stdin;
\.


--
-- TOC entry 5016 (class 0 OID 16835)
-- Dependencies: 234
-- Data for Name: commande_produits; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.commande_produits (id, commande_id, produit_id, quantite) FROM stdin;
\.


--
-- TOC entry 5014 (class 0 OID 16822)
-- Dependencies: 232
-- Data for Name: commandes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.commandes (id, utilisateur_id, date_commande, statut, total) FROM stdin;
\.


--
-- TOC entry 5028 (class 0 OID 16922)
-- Dependencies: 246
-- Data for Name: contrats; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contrats (id, vendeur_id, date_signature, conditions) FROM stdin;
\.


--
-- TOC entry 5024 (class 0 OID 16886)
-- Dependencies: 242
-- Data for Name: livraisons; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.livraisons (id, commande_id, prestataire_id, statut_livraison, numero_suivi, date_envoi, date_livraison) FROM stdin;
\.


--
-- TOC entry 5031 (class 0 OID 16943)
-- Dependencies: 249
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notifications (id, "userId", message, status, "createdAt", "updatedAt") FROM stdin;
\.


--
-- TOC entry 5018 (class 0 OID 16852)
-- Dependencies: 236
-- Data for Name: paiements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.paiements (id, commande_id, montant, methode_paiement, statut) FROM stdin;
\.


--
-- TOC entry 5012 (class 0 OID 16805)
-- Dependencies: 230
-- Data for Name: panier_produits; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.panier_produits (id, panier_id, produit_id, quantite) FROM stdin;
\.


--
-- TOC entry 5010 (class 0 OID 16793)
-- Dependencies: 228
-- Data for Name: paniers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.paniers (id, utilisateur_id) FROM stdin;
\.


--
-- TOC entry 5022 (class 0 OID 16877)
-- Dependencies: 240
-- Data for Name: prestataires_de_livraison; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.prestataires_de_livraison (id, nom, adresse) FROM stdin;
\.


--
-- TOC entry 5006 (class 0 OID 16770)
-- Dependencies: 224
-- Data for Name: produits; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.produits (id, nom, description, prix, quantite, categorie_id, image_url) FROM stdin;
\.


--
-- TOC entry 5020 (class 0 OID 16864)
-- Dependencies: 238
-- Data for Name: retours; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.retours (id, commande_id, date_retour, statut) FROM stdin;
\.


--
-- TOC entry 4998 (class 0 OID 16722)
-- Dependencies: 216
-- Data for Name: utilisateurs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.utilisateurs (id, nom, email, mot_de_passe, adresse, role) FROM stdin;
\.


--
-- TOC entry 5002 (class 0 OID 16746)
-- Dependencies: 220
-- Data for Name: vendeurs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vendeurs (id, utilisateur_id) FROM stdin;
\.


--
-- TOC entry 5026 (class 0 OID 16904)
-- Dependencies: 244
-- Data for Name: ventes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ventes (id, produit_id, quantite, date_vente, utilisateur_id) FROM stdin;
\.


--
-- TOC entry 5054 (class 0 OID 0)
-- Dependencies: 221
-- Name: administrateurs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.administrateurs_id_seq', 1, false);


--
-- TOC entry 5055 (class 0 OID 0)
-- Dependencies: 225
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 1, false);


--
-- TOC entry 5056 (class 0 OID 0)
-- Dependencies: 217
-- Name: clients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clients_id_seq', 1, false);


--
-- TOC entry 5057 (class 0 OID 0)
-- Dependencies: 233
-- Name: commande_produits_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.commande_produits_id_seq', 1, false);


--
-- TOC entry 5058 (class 0 OID 0)
-- Dependencies: 231
-- Name: commandes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.commandes_id_seq', 1, false);


--
-- TOC entry 5059 (class 0 OID 0)
-- Dependencies: 245
-- Name: contrats_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contrats_id_seq', 1, false);


--
-- TOC entry 5060 (class 0 OID 0)
-- Dependencies: 241
-- Name: livraisons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.livraisons_id_seq', 1, false);


--
-- TOC entry 5061 (class 0 OID 0)
-- Dependencies: 248
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notifications_id_seq', 1, false);


--
-- TOC entry 5062 (class 0 OID 0)
-- Dependencies: 235
-- Name: paiements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.paiements_id_seq', 1, false);


--
-- TOC entry 5063 (class 0 OID 0)
-- Dependencies: 229
-- Name: panier_produits_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.panier_produits_id_seq', 1, false);


--
-- TOC entry 5064 (class 0 OID 0)
-- Dependencies: 227
-- Name: paniers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.paniers_id_seq', 1, false);


--
-- TOC entry 5065 (class 0 OID 0)
-- Dependencies: 239
-- Name: prestataires_de_livraison_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.prestataires_de_livraison_id_seq', 1, false);


--
-- TOC entry 5066 (class 0 OID 0)
-- Dependencies: 223
-- Name: produits_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.produits_id_seq', 1, false);


--
-- TOC entry 5067 (class 0 OID 0)
-- Dependencies: 237
-- Name: retours_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.retours_id_seq', 1, false);


--
-- TOC entry 5068 (class 0 OID 0)
-- Dependencies: 215
-- Name: utilisateurs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.utilisateurs_id_seq', 1, false);


--
-- TOC entry 5069 (class 0 OID 0)
-- Dependencies: 219
-- Name: vendeurs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vendeurs_id_seq', 1, false);


--
-- TOC entry 5070 (class 0 OID 0)
-- Dependencies: 243
-- Name: ventes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ventes_id_seq', 1, false);


--
-- TOC entry 4833 (class 2606 OID 16941)
-- Name: SequelizeMeta SequelizeMeta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SequelizeMeta"
    ADD CONSTRAINT "SequelizeMeta_pkey" PRIMARY KEY (name);


--
-- TOC entry 4807 (class 2606 OID 16763)
-- Name: administrateurs administrateurs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.administrateurs
    ADD CONSTRAINT administrateurs_pkey PRIMARY KEY (id);


--
-- TOC entry 4811 (class 2606 OID 16786)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- TOC entry 4803 (class 2606 OID 16739)
-- Name: clients clients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- TOC entry 4819 (class 2606 OID 16840)
-- Name: commande_produits commande_produits_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commande_produits
    ADD CONSTRAINT commande_produits_pkey PRIMARY KEY (id);


--
-- TOC entry 4817 (class 2606 OID 16828)
-- Name: commandes commandes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commandes
    ADD CONSTRAINT commandes_pkey PRIMARY KEY (id);


--
-- TOC entry 4831 (class 2606 OID 16930)
-- Name: contrats contrats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contrats
    ADD CONSTRAINT contrats_pkey PRIMARY KEY (id);


--
-- TOC entry 4827 (class 2606 OID 16892)
-- Name: livraisons livraisons_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.livraisons
    ADD CONSTRAINT livraisons_pkey PRIMARY KEY (id);


--
-- TOC entry 4835 (class 2606 OID 16953)
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- TOC entry 4821 (class 2606 OID 16857)
-- Name: paiements paiements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paiements
    ADD CONSTRAINT paiements_pkey PRIMARY KEY (id);


--
-- TOC entry 4815 (class 2606 OID 16810)
-- Name: panier_produits panier_produits_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.panier_produits
    ADD CONSTRAINT panier_produits_pkey PRIMARY KEY (id);


--
-- TOC entry 4813 (class 2606 OID 16798)
-- Name: paniers paniers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paniers
    ADD CONSTRAINT paniers_pkey PRIMARY KEY (id);


--
-- TOC entry 4825 (class 2606 OID 16884)
-- Name: prestataires_de_livraison prestataires_de_livraison_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prestataires_de_livraison
    ADD CONSTRAINT prestataires_de_livraison_pkey PRIMARY KEY (id);


--
-- TOC entry 4809 (class 2606 OID 16777)
-- Name: produits produits_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produits
    ADD CONSTRAINT produits_pkey PRIMARY KEY (id);


--
-- TOC entry 4823 (class 2606 OID 16870)
-- Name: retours retours_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.retours
    ADD CONSTRAINT retours_pkey PRIMARY KEY (id);


--
-- TOC entry 4799 (class 2606 OID 16732)
-- Name: utilisateurs utilisateurs_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateurs
    ADD CONSTRAINT utilisateurs_email_key UNIQUE (email);


--
-- TOC entry 4801 (class 2606 OID 16730)
-- Name: utilisateurs utilisateurs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateurs
    ADD CONSTRAINT utilisateurs_pkey PRIMARY KEY (id);


--
-- TOC entry 4805 (class 2606 OID 16751)
-- Name: vendeurs vendeurs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendeurs
    ADD CONSTRAINT vendeurs_pkey PRIMARY KEY (id);


--
-- TOC entry 4829 (class 2606 OID 16910)
-- Name: ventes ventes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ventes
    ADD CONSTRAINT ventes_pkey PRIMARY KEY (id);


--
-- TOC entry 4838 (class 2606 OID 16764)
-- Name: administrateurs administrateurs_utilisateur_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.administrateurs
    ADD CONSTRAINT administrateurs_utilisateur_id_fkey FOREIGN KEY (utilisateur_id) REFERENCES public.utilisateurs(id) ON DELETE CASCADE;


--
-- TOC entry 4836 (class 2606 OID 16740)
-- Name: clients clients_utilisateur_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_utilisateur_id_fkey FOREIGN KEY (utilisateur_id) REFERENCES public.utilisateurs(id) ON DELETE CASCADE;


--
-- TOC entry 4844 (class 2606 OID 16841)
-- Name: commande_produits commande_produits_commande_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commande_produits
    ADD CONSTRAINT commande_produits_commande_id_fkey FOREIGN KEY (commande_id) REFERENCES public.commandes(id) ON DELETE CASCADE;


--
-- TOC entry 4845 (class 2606 OID 16846)
-- Name: commande_produits commande_produits_produit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commande_produits
    ADD CONSTRAINT commande_produits_produit_id_fkey FOREIGN KEY (produit_id) REFERENCES public.produits(id) ON DELETE CASCADE;


--
-- TOC entry 4843 (class 2606 OID 16829)
-- Name: commandes commandes_utilisateur_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commandes
    ADD CONSTRAINT commandes_utilisateur_id_fkey FOREIGN KEY (utilisateur_id) REFERENCES public.utilisateurs(id) ON DELETE CASCADE;


--
-- TOC entry 4852 (class 2606 OID 16931)
-- Name: contrats contrats_vendeur_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contrats
    ADD CONSTRAINT contrats_vendeur_id_fkey FOREIGN KEY (vendeur_id) REFERENCES public.vendeurs(id) ON DELETE CASCADE;


--
-- TOC entry 4848 (class 2606 OID 16893)
-- Name: livraisons livraisons_commande_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.livraisons
    ADD CONSTRAINT livraisons_commande_id_fkey FOREIGN KEY (commande_id) REFERENCES public.commandes(id) ON DELETE CASCADE;


--
-- TOC entry 4849 (class 2606 OID 16898)
-- Name: livraisons livraisons_prestataire_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.livraisons
    ADD CONSTRAINT livraisons_prestataire_id_fkey FOREIGN KEY (prestataire_id) REFERENCES public.prestataires_de_livraison(id) ON DELETE CASCADE;


--
-- TOC entry 4853 (class 2606 OID 16954)
-- Name: notifications notifications_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT "notifications_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.utilisateurs(id) ON DELETE CASCADE;


--
-- TOC entry 4846 (class 2606 OID 16858)
-- Name: paiements paiements_commande_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paiements
    ADD CONSTRAINT paiements_commande_id_fkey FOREIGN KEY (commande_id) REFERENCES public.commandes(id) ON DELETE CASCADE;


--
-- TOC entry 4841 (class 2606 OID 16811)
-- Name: panier_produits panier_produits_panier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.panier_produits
    ADD CONSTRAINT panier_produits_panier_id_fkey FOREIGN KEY (panier_id) REFERENCES public.paniers(id) ON DELETE CASCADE;


--
-- TOC entry 4842 (class 2606 OID 16816)
-- Name: panier_produits panier_produits_produit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.panier_produits
    ADD CONSTRAINT panier_produits_produit_id_fkey FOREIGN KEY (produit_id) REFERENCES public.produits(id) ON DELETE CASCADE;


--
-- TOC entry 4840 (class 2606 OID 16799)
-- Name: paniers paniers_utilisateur_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paniers
    ADD CONSTRAINT paniers_utilisateur_id_fkey FOREIGN KEY (utilisateur_id) REFERENCES public.utilisateurs(id) ON DELETE CASCADE;


--
-- TOC entry 4839 (class 2606 OID 16787)
-- Name: produits produits_categorie_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produits
    ADD CONSTRAINT produits_categorie_id_fkey FOREIGN KEY (categorie_id) REFERENCES public.categories(id) ON DELETE SET NULL;


--
-- TOC entry 4847 (class 2606 OID 16871)
-- Name: retours retours_commande_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.retours
    ADD CONSTRAINT retours_commande_id_fkey FOREIGN KEY (commande_id) REFERENCES public.commandes(id) ON DELETE CASCADE;


--
-- TOC entry 4837 (class 2606 OID 16752)
-- Name: vendeurs vendeurs_utilisateur_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendeurs
    ADD CONSTRAINT vendeurs_utilisateur_id_fkey FOREIGN KEY (utilisateur_id) REFERENCES public.utilisateurs(id) ON DELETE CASCADE;


--
-- TOC entry 4850 (class 2606 OID 16911)
-- Name: ventes ventes_produit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ventes
    ADD CONSTRAINT ventes_produit_id_fkey FOREIGN KEY (produit_id) REFERENCES public.produits(id) ON DELETE CASCADE;


--
-- TOC entry 4851 (class 2606 OID 16916)
-- Name: ventes ventes_utilisateur_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ventes
    ADD CONSTRAINT ventes_utilisateur_id_fkey FOREIGN KEY (utilisateur_id) REFERENCES public.utilisateurs(id) ON DELETE CASCADE;


-- Completed on 2024-09-17 16:14:23

--
-- PostgreSQL database dump complete
--

