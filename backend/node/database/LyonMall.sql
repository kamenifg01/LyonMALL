PGDMP  6                    |           LyonMall    16.4    16.4 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16719    LyonMall    DATABASE     }   CREATE DATABASE "LyonMall" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'French_France.1252';
    DROP DATABASE "LyonMall";
                postgres    false            �            1259    16758    administrateurs    TABLE     f   CREATE TABLE public.administrateurs (
    id integer NOT NULL,
    utilisateur_id integer NOT NULL
);
 #   DROP TABLE public.administrateurs;
       public         heap    postgres    false            �            1259    16757    administrateurs_id_seq    SEQUENCE     �   CREATE SEQUENCE public.administrateurs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.administrateurs_id_seq;
       public          postgres    false    222            �           0    0    administrateurs_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.administrateurs_id_seq OWNED BY public.administrateurs.id;
          public          postgres    false    221            �            1259    16779 
   categories    TABLE     {   CREATE TABLE public.categories (
    id integer NOT NULL,
    nom character varying(255) NOT NULL,
    description text
);
    DROP TABLE public.categories;
       public         heap    postgres    false            �            1259    16778    categories_id_seq    SEQUENCE     �   CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.categories_id_seq;
       public          postgres    false    226            �           0    0    categories_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;
          public          postgres    false    225            �            1259    16734    clients    TABLE     ^   CREATE TABLE public.clients (
    id integer NOT NULL,
    utilisateur_id integer NOT NULL
);
    DROP TABLE public.clients;
       public         heap    postgres    false            �            1259    16733    clients_id_seq    SEQUENCE     �   CREATE SEQUENCE public.clients_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.clients_id_seq;
       public          postgres    false    218            �           0    0    clients_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.clients_id_seq OWNED BY public.clients.id;
          public          postgres    false    217            �            1259    16835    commande_produits    TABLE     �   CREATE TABLE public.commande_produits (
    id integer NOT NULL,
    commande_id integer NOT NULL,
    produit_id integer NOT NULL,
    quantite integer NOT NULL
);
 %   DROP TABLE public.commande_produits;
       public         heap    postgres    false            �            1259    16834    commande_produits_id_seq    SEQUENCE     �   CREATE SEQUENCE public.commande_produits_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.commande_produits_id_seq;
       public          postgres    false    234            �           0    0    commande_produits_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.commande_produits_id_seq OWNED BY public.commande_produits.id;
          public          postgres    false    233            �            1259    16822 	   commandes    TABLE     �   CREATE TABLE public.commandes (
    id integer NOT NULL,
    utilisateur_id integer NOT NULL,
    date_commande timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    statut character varying(50) NOT NULL,
    total numeric(10,2) NOT NULL
);
    DROP TABLE public.commandes;
       public         heap    postgres    false            �            1259    16821    commandes_id_seq    SEQUENCE     �   CREATE SEQUENCE public.commandes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.commandes_id_seq;
       public          postgres    false    232            �           0    0    commandes_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.commandes_id_seq OWNED BY public.commandes.id;
          public          postgres    false    231            �            1259    16922    contrats    TABLE     �   CREATE TABLE public.contrats (
    id integer NOT NULL,
    vendeur_id integer NOT NULL,
    date_signature timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    conditions text
);
    DROP TABLE public.contrats;
       public         heap    postgres    false            �            1259    16921    contrats_id_seq    SEQUENCE     �   CREATE SEQUENCE public.contrats_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.contrats_id_seq;
       public          postgres    false    246            �           0    0    contrats_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.contrats_id_seq OWNED BY public.contrats.id;
          public          postgres    false    245            �            1259    16886 
   livraisons    TABLE     W  CREATE TABLE public.livraisons (
    id integer NOT NULL,
    commande_id integer NOT NULL,
    prestataire_id integer NOT NULL,
    statut_livraison character varying(50) NOT NULL,
    numero_suivi character varying(100),
    date_envoi timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    date_livraison timestamp without time zone
);
    DROP TABLE public.livraisons;
       public         heap    postgres    false            �            1259    16885    livraisons_id_seq    SEQUENCE     �   CREATE SEQUENCE public.livraisons_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.livraisons_id_seq;
       public          postgres    false    242            �           0    0    livraisons_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.livraisons_id_seq OWNED BY public.livraisons.id;
          public          postgres    false    241            �            1259    16852 	   paiements    TABLE     �   CREATE TABLE public.paiements (
    id integer NOT NULL,
    commande_id integer NOT NULL,
    montant numeric(10,2) NOT NULL,
    methode_paiement character varying(50) NOT NULL,
    statut character varying(50) NOT NULL
);
    DROP TABLE public.paiements;
       public         heap    postgres    false            �            1259    16851    paiements_id_seq    SEQUENCE     �   CREATE SEQUENCE public.paiements_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.paiements_id_seq;
       public          postgres    false    236            �           0    0    paiements_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.paiements_id_seq OWNED BY public.paiements.id;
          public          postgres    false    235            �            1259    16805    panier_produits    TABLE     �   CREATE TABLE public.panier_produits (
    id integer NOT NULL,
    panier_id integer NOT NULL,
    produit_id integer NOT NULL,
    quantite integer NOT NULL
);
 #   DROP TABLE public.panier_produits;
       public         heap    postgres    false            �            1259    16804    panier_produits_id_seq    SEQUENCE     �   CREATE SEQUENCE public.panier_produits_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.panier_produits_id_seq;
       public          postgres    false    230            �           0    0    panier_produits_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.panier_produits_id_seq OWNED BY public.panier_produits.id;
          public          postgres    false    229            �            1259    16793    paniers    TABLE     ^   CREATE TABLE public.paniers (
    id integer NOT NULL,
    utilisateur_id integer NOT NULL
);
    DROP TABLE public.paniers;
       public         heap    postgres    false            �            1259    16792    paniers_id_seq    SEQUENCE     �   CREATE SEQUENCE public.paniers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.paniers_id_seq;
       public          postgres    false    228            �           0    0    paniers_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.paniers_id_seq OWNED BY public.paniers.id;
          public          postgres    false    227            �            1259    16877    prestataires_de_livraison    TABLE     �   CREATE TABLE public.prestataires_de_livraison (
    id integer NOT NULL,
    nom character varying(255) NOT NULL,
    adresse character varying(255) NOT NULL
);
 -   DROP TABLE public.prestataires_de_livraison;
       public         heap    postgres    false            �            1259    16876     prestataires_de_livraison_id_seq    SEQUENCE     �   CREATE SEQUENCE public.prestataires_de_livraison_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.prestataires_de_livraison_id_seq;
       public          postgres    false    240            �           0    0     prestataires_de_livraison_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.prestataires_de_livraison_id_seq OWNED BY public.prestataires_de_livraison.id;
          public          postgres    false    239            �            1259    16770    produits    TABLE     �   CREATE TABLE public.produits (
    id integer NOT NULL,
    nom character varying(255) NOT NULL,
    description text,
    prix numeric(10,2) NOT NULL,
    quantite integer NOT NULL,
    categorie_id integer,
    image_url text
);
    DROP TABLE public.produits;
       public         heap    postgres    false            �            1259    16769    produits_id_seq    SEQUENCE     �   CREATE SEQUENCE public.produits_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.produits_id_seq;
       public          postgres    false    224            �           0    0    produits_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.produits_id_seq OWNED BY public.produits.id;
          public          postgres    false    223            �            1259    16864    retours    TABLE     �   CREATE TABLE public.retours (
    id integer NOT NULL,
    commande_id integer NOT NULL,
    date_retour timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    statut character varying(50) NOT NULL
);
    DROP TABLE public.retours;
       public         heap    postgres    false            �            1259    16863    retours_id_seq    SEQUENCE     �   CREATE SEQUENCE public.retours_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.retours_id_seq;
       public          postgres    false    238            �           0    0    retours_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.retours_id_seq OWNED BY public.retours.id;
          public          postgres    false    237            �            1259    16722    utilisateurs    TABLE     �  CREATE TABLE public.utilisateurs (
    id integer NOT NULL,
    nom character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    mot_de_passe character varying(255) NOT NULL,
    adresse character varying(255),
    role character varying(50) NOT NULL,
    CONSTRAINT utilisateurs_role_check CHECK (((role)::text = ANY ((ARRAY['client'::character varying, 'vendeur'::character varying, 'admin'::character varying])::text[])))
);
     DROP TABLE public.utilisateurs;
       public         heap    postgres    false            �            1259    16721    utilisateurs_id_seq    SEQUENCE     �   CREATE SEQUENCE public.utilisateurs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.utilisateurs_id_seq;
       public          postgres    false    216            �           0    0    utilisateurs_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.utilisateurs_id_seq OWNED BY public.utilisateurs.id;
          public          postgres    false    215            �            1259    16746    vendeurs    TABLE     _   CREATE TABLE public.vendeurs (
    id integer NOT NULL,
    utilisateur_id integer NOT NULL
);
    DROP TABLE public.vendeurs;
       public         heap    postgres    false            �            1259    16745    vendeurs_id_seq    SEQUENCE     �   CREATE SEQUENCE public.vendeurs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.vendeurs_id_seq;
       public          postgres    false    220            �           0    0    vendeurs_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.vendeurs_id_seq OWNED BY public.vendeurs.id;
          public          postgres    false    219            �            1259    16904    ventes    TABLE     �   CREATE TABLE public.ventes (
    id integer NOT NULL,
    produit_id integer NOT NULL,
    quantite integer NOT NULL,
    date_vente timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    utilisateur_id integer NOT NULL
);
    DROP TABLE public.ventes;
       public         heap    postgres    false            �            1259    16903    ventes_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ventes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.ventes_id_seq;
       public          postgres    false    244            �           0    0    ventes_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.ventes_id_seq OWNED BY public.ventes.id;
          public          postgres    false    243            �           2604    16761    administrateurs id    DEFAULT     x   ALTER TABLE ONLY public.administrateurs ALTER COLUMN id SET DEFAULT nextval('public.administrateurs_id_seq'::regclass);
 A   ALTER TABLE public.administrateurs ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    221    222    222            �           2604    16782    categories id    DEFAULT     n   ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);
 <   ALTER TABLE public.categories ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    226    225    226            �           2604    16737 
   clients id    DEFAULT     h   ALTER TABLE ONLY public.clients ALTER COLUMN id SET DEFAULT nextval('public.clients_id_seq'::regclass);
 9   ALTER TABLE public.clients ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    218    217    218            �           2604    16838    commande_produits id    DEFAULT     |   ALTER TABLE ONLY public.commande_produits ALTER COLUMN id SET DEFAULT nextval('public.commande_produits_id_seq'::regclass);
 C   ALTER TABLE public.commande_produits ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    234    233    234            �           2604    16825    commandes id    DEFAULT     l   ALTER TABLE ONLY public.commandes ALTER COLUMN id SET DEFAULT nextval('public.commandes_id_seq'::regclass);
 ;   ALTER TABLE public.commandes ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    231    232    232            �           2604    16925    contrats id    DEFAULT     j   ALTER TABLE ONLY public.contrats ALTER COLUMN id SET DEFAULT nextval('public.contrats_id_seq'::regclass);
 :   ALTER TABLE public.contrats ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    246    245    246            �           2604    16889    livraisons id    DEFAULT     n   ALTER TABLE ONLY public.livraisons ALTER COLUMN id SET DEFAULT nextval('public.livraisons_id_seq'::regclass);
 <   ALTER TABLE public.livraisons ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    241    242    242            �           2604    16855    paiements id    DEFAULT     l   ALTER TABLE ONLY public.paiements ALTER COLUMN id SET DEFAULT nextval('public.paiements_id_seq'::regclass);
 ;   ALTER TABLE public.paiements ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    235    236    236            �           2604    16808    panier_produits id    DEFAULT     x   ALTER TABLE ONLY public.panier_produits ALTER COLUMN id SET DEFAULT nextval('public.panier_produits_id_seq'::regclass);
 A   ALTER TABLE public.panier_produits ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    230    229    230            �           2604    16796 
   paniers id    DEFAULT     h   ALTER TABLE ONLY public.paniers ALTER COLUMN id SET DEFAULT nextval('public.paniers_id_seq'::regclass);
 9   ALTER TABLE public.paniers ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    228    227    228            �           2604    16880    prestataires_de_livraison id    DEFAULT     �   ALTER TABLE ONLY public.prestataires_de_livraison ALTER COLUMN id SET DEFAULT nextval('public.prestataires_de_livraison_id_seq'::regclass);
 K   ALTER TABLE public.prestataires_de_livraison ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    240    239    240            �           2604    16773    produits id    DEFAULT     j   ALTER TABLE ONLY public.produits ALTER COLUMN id SET DEFAULT nextval('public.produits_id_seq'::regclass);
 :   ALTER TABLE public.produits ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    223    224    224            �           2604    16867 
   retours id    DEFAULT     h   ALTER TABLE ONLY public.retours ALTER COLUMN id SET DEFAULT nextval('public.retours_id_seq'::regclass);
 9   ALTER TABLE public.retours ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    237    238    238            �           2604    16725    utilisateurs id    DEFAULT     r   ALTER TABLE ONLY public.utilisateurs ALTER COLUMN id SET DEFAULT nextval('public.utilisateurs_id_seq'::regclass);
 >   ALTER TABLE public.utilisateurs ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    215    216    216            �           2604    16749    vendeurs id    DEFAULT     j   ALTER TABLE ONLY public.vendeurs ALTER COLUMN id SET DEFAULT nextval('public.vendeurs_id_seq'::regclass);
 :   ALTER TABLE public.vendeurs ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    219    220            �           2604    16907 	   ventes id    DEFAULT     f   ALTER TABLE ONLY public.ventes ALTER COLUMN id SET DEFAULT nextval('public.ventes_id_seq'::regclass);
 8   ALTER TABLE public.ventes ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    243    244    244            z          0    16758    administrateurs 
   TABLE DATA           =   COPY public.administrateurs (id, utilisateur_id) FROM stdin;
    public          postgres    false    222   �       ~          0    16779 
   categories 
   TABLE DATA           :   COPY public.categories (id, nom, description) FROM stdin;
    public          postgres    false    226   "�       v          0    16734    clients 
   TABLE DATA           5   COPY public.clients (id, utilisateur_id) FROM stdin;
    public          postgres    false    218   ?�       �          0    16835    commande_produits 
   TABLE DATA           R   COPY public.commande_produits (id, commande_id, produit_id, quantite) FROM stdin;
    public          postgres    false    234   \�       �          0    16822 	   commandes 
   TABLE DATA           U   COPY public.commandes (id, utilisateur_id, date_commande, statut, total) FROM stdin;
    public          postgres    false    232   y�       �          0    16922    contrats 
   TABLE DATA           N   COPY public.contrats (id, vendeur_id, date_signature, conditions) FROM stdin;
    public          postgres    false    246   ��       �          0    16886 
   livraisons 
   TABLE DATA           �   COPY public.livraisons (id, commande_id, prestataire_id, statut_livraison, numero_suivi, date_envoi, date_livraison) FROM stdin;
    public          postgres    false    242   ��       �          0    16852 	   paiements 
   TABLE DATA           W   COPY public.paiements (id, commande_id, montant, methode_paiement, statut) FROM stdin;
    public          postgres    false    236   П       �          0    16805    panier_produits 
   TABLE DATA           N   COPY public.panier_produits (id, panier_id, produit_id, quantite) FROM stdin;
    public          postgres    false    230   �       �          0    16793    paniers 
   TABLE DATA           5   COPY public.paniers (id, utilisateur_id) FROM stdin;
    public          postgres    false    228   
�       �          0    16877    prestataires_de_livraison 
   TABLE DATA           E   COPY public.prestataires_de_livraison (id, nom, adresse) FROM stdin;
    public          postgres    false    240   '�       |          0    16770    produits 
   TABLE DATA           a   COPY public.produits (id, nom, description, prix, quantite, categorie_id, image_url) FROM stdin;
    public          postgres    false    224   D�       �          0    16864    retours 
   TABLE DATA           G   COPY public.retours (id, commande_id, date_retour, statut) FROM stdin;
    public          postgres    false    238   a�       t          0    16722    utilisateurs 
   TABLE DATA           S   COPY public.utilisateurs (id, nom, email, mot_de_passe, adresse, role) FROM stdin;
    public          postgres    false    216   ~�       x          0    16746    vendeurs 
   TABLE DATA           6   COPY public.vendeurs (id, utilisateur_id) FROM stdin;
    public          postgres    false    220   ��       �          0    16904    ventes 
   TABLE DATA           V   COPY public.ventes (id, produit_id, quantite, date_vente, utilisateur_id) FROM stdin;
    public          postgres    false    244   ��       �           0    0    administrateurs_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.administrateurs_id_seq', 1, false);
          public          postgres    false    221            �           0    0    categories_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.categories_id_seq', 1, false);
          public          postgres    false    225            �           0    0    clients_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.clients_id_seq', 1, false);
          public          postgres    false    217            �           0    0    commande_produits_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.commande_produits_id_seq', 1, false);
          public          postgres    false    233            �           0    0    commandes_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.commandes_id_seq', 1, false);
          public          postgres    false    231            �           0    0    contrats_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.contrats_id_seq', 1, false);
          public          postgres    false    245            �           0    0    livraisons_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.livraisons_id_seq', 1, false);
          public          postgres    false    241            �           0    0    paiements_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.paiements_id_seq', 1, false);
          public          postgres    false    235            �           0    0    panier_produits_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.panier_produits_id_seq', 1, false);
          public          postgres    false    229            �           0    0    paniers_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.paniers_id_seq', 1, false);
          public          postgres    false    227            �           0    0     prestataires_de_livraison_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.prestataires_de_livraison_id_seq', 1, false);
          public          postgres    false    239            �           0    0    produits_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.produits_id_seq', 1, false);
          public          postgres    false    223            �           0    0    retours_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.retours_id_seq', 1, false);
          public          postgres    false    237            �           0    0    utilisateurs_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.utilisateurs_id_seq', 1, false);
          public          postgres    false    215            �           0    0    vendeurs_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.vendeurs_id_seq', 1, false);
          public          postgres    false    219            �           0    0    ventes_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.ventes_id_seq', 1, false);
          public          postgres    false    243            �           2606    16763 $   administrateurs administrateurs_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.administrateurs
    ADD CONSTRAINT administrateurs_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.administrateurs DROP CONSTRAINT administrateurs_pkey;
       public            postgres    false    222            �           2606    16786    categories categories_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.categories DROP CONSTRAINT categories_pkey;
       public            postgres    false    226            �           2606    16739    clients clients_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.clients DROP CONSTRAINT clients_pkey;
       public            postgres    false    218            �           2606    16840 (   commande_produits commande_produits_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.commande_produits
    ADD CONSTRAINT commande_produits_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.commande_produits DROP CONSTRAINT commande_produits_pkey;
       public            postgres    false    234            �           2606    16828    commandes commandes_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.commandes
    ADD CONSTRAINT commandes_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.commandes DROP CONSTRAINT commandes_pkey;
       public            postgres    false    232            �           2606    16930    contrats contrats_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.contrats
    ADD CONSTRAINT contrats_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.contrats DROP CONSTRAINT contrats_pkey;
       public            postgres    false    246            �           2606    16892    livraisons livraisons_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.livraisons
    ADD CONSTRAINT livraisons_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.livraisons DROP CONSTRAINT livraisons_pkey;
       public            postgres    false    242            �           2606    16857    paiements paiements_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.paiements
    ADD CONSTRAINT paiements_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.paiements DROP CONSTRAINT paiements_pkey;
       public            postgres    false    236            �           2606    16810 $   panier_produits panier_produits_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.panier_produits
    ADD CONSTRAINT panier_produits_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.panier_produits DROP CONSTRAINT panier_produits_pkey;
       public            postgres    false    230            �           2606    16798    paniers paniers_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.paniers
    ADD CONSTRAINT paniers_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.paniers DROP CONSTRAINT paniers_pkey;
       public            postgres    false    228            �           2606    16884 8   prestataires_de_livraison prestataires_de_livraison_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.prestataires_de_livraison
    ADD CONSTRAINT prestataires_de_livraison_pkey PRIMARY KEY (id);
 b   ALTER TABLE ONLY public.prestataires_de_livraison DROP CONSTRAINT prestataires_de_livraison_pkey;
       public            postgres    false    240            �           2606    16777    produits produits_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.produits
    ADD CONSTRAINT produits_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.produits DROP CONSTRAINT produits_pkey;
       public            postgres    false    224            �           2606    16870    retours retours_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.retours
    ADD CONSTRAINT retours_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.retours DROP CONSTRAINT retours_pkey;
       public            postgres    false    238            �           2606    16732 #   utilisateurs utilisateurs_email_key 
   CONSTRAINT     _   ALTER TABLE ONLY public.utilisateurs
    ADD CONSTRAINT utilisateurs_email_key UNIQUE (email);
 M   ALTER TABLE ONLY public.utilisateurs DROP CONSTRAINT utilisateurs_email_key;
       public            postgres    false    216            �           2606    16730    utilisateurs utilisateurs_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.utilisateurs
    ADD CONSTRAINT utilisateurs_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.utilisateurs DROP CONSTRAINT utilisateurs_pkey;
       public            postgres    false    216            �           2606    16751    vendeurs vendeurs_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.vendeurs
    ADD CONSTRAINT vendeurs_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.vendeurs DROP CONSTRAINT vendeurs_pkey;
       public            postgres    false    220            �           2606    16910    ventes ventes_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.ventes
    ADD CONSTRAINT ventes_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.ventes DROP CONSTRAINT ventes_pkey;
       public            postgres    false    244            �           2606    16764 3   administrateurs administrateurs_utilisateur_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.administrateurs
    ADD CONSTRAINT administrateurs_utilisateur_id_fkey FOREIGN KEY (utilisateur_id) REFERENCES public.utilisateurs(id) ON DELETE CASCADE;
 ]   ALTER TABLE ONLY public.administrateurs DROP CONSTRAINT administrateurs_utilisateur_id_fkey;
       public          postgres    false    216    222    4788            �           2606    16740 #   clients clients_utilisateur_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_utilisateur_id_fkey FOREIGN KEY (utilisateur_id) REFERENCES public.utilisateurs(id) ON DELETE CASCADE;
 M   ALTER TABLE ONLY public.clients DROP CONSTRAINT clients_utilisateur_id_fkey;
       public          postgres    false    4788    216    218            �           2606    16841 4   commande_produits commande_produits_commande_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.commande_produits
    ADD CONSTRAINT commande_produits_commande_id_fkey FOREIGN KEY (commande_id) REFERENCES public.commandes(id) ON DELETE CASCADE;
 ^   ALTER TABLE ONLY public.commande_produits DROP CONSTRAINT commande_produits_commande_id_fkey;
       public          postgres    false    4804    234    232            �           2606    16846 3   commande_produits commande_produits_produit_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.commande_produits
    ADD CONSTRAINT commande_produits_produit_id_fkey FOREIGN KEY (produit_id) REFERENCES public.produits(id) ON DELETE CASCADE;
 ]   ALTER TABLE ONLY public.commande_produits DROP CONSTRAINT commande_produits_produit_id_fkey;
       public          postgres    false    234    4796    224            �           2606    16829 '   commandes commandes_utilisateur_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.commandes
    ADD CONSTRAINT commandes_utilisateur_id_fkey FOREIGN KEY (utilisateur_id) REFERENCES public.utilisateurs(id) ON DELETE CASCADE;
 Q   ALTER TABLE ONLY public.commandes DROP CONSTRAINT commandes_utilisateur_id_fkey;
       public          postgres    false    232    216    4788            �           2606    16931 !   contrats contrats_vendeur_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.contrats
    ADD CONSTRAINT contrats_vendeur_id_fkey FOREIGN KEY (vendeur_id) REFERENCES public.vendeurs(id) ON DELETE CASCADE;
 K   ALTER TABLE ONLY public.contrats DROP CONSTRAINT contrats_vendeur_id_fkey;
       public          postgres    false    220    246    4792            �           2606    16893 &   livraisons livraisons_commande_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.livraisons
    ADD CONSTRAINT livraisons_commande_id_fkey FOREIGN KEY (commande_id) REFERENCES public.commandes(id) ON DELETE CASCADE;
 P   ALTER TABLE ONLY public.livraisons DROP CONSTRAINT livraisons_commande_id_fkey;
       public          postgres    false    242    4804    232            �           2606    16898 )   livraisons livraisons_prestataire_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.livraisons
    ADD CONSTRAINT livraisons_prestataire_id_fkey FOREIGN KEY (prestataire_id) REFERENCES public.prestataires_de_livraison(id) ON DELETE CASCADE;
 S   ALTER TABLE ONLY public.livraisons DROP CONSTRAINT livraisons_prestataire_id_fkey;
       public          postgres    false    240    242    4812            �           2606    16858 $   paiements paiements_commande_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.paiements
    ADD CONSTRAINT paiements_commande_id_fkey FOREIGN KEY (commande_id) REFERENCES public.commandes(id) ON DELETE CASCADE;
 N   ALTER TABLE ONLY public.paiements DROP CONSTRAINT paiements_commande_id_fkey;
       public          postgres    false    236    4804    232            �           2606    16811 .   panier_produits panier_produits_panier_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.panier_produits
    ADD CONSTRAINT panier_produits_panier_id_fkey FOREIGN KEY (panier_id) REFERENCES public.paniers(id) ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.panier_produits DROP CONSTRAINT panier_produits_panier_id_fkey;
       public          postgres    false    230    228    4800            �           2606    16816 /   panier_produits panier_produits_produit_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.panier_produits
    ADD CONSTRAINT panier_produits_produit_id_fkey FOREIGN KEY (produit_id) REFERENCES public.produits(id) ON DELETE CASCADE;
 Y   ALTER TABLE ONLY public.panier_produits DROP CONSTRAINT panier_produits_produit_id_fkey;
       public          postgres    false    230    224    4796            �           2606    16799 #   paniers paniers_utilisateur_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.paniers
    ADD CONSTRAINT paniers_utilisateur_id_fkey FOREIGN KEY (utilisateur_id) REFERENCES public.utilisateurs(id) ON DELETE CASCADE;
 M   ALTER TABLE ONLY public.paniers DROP CONSTRAINT paniers_utilisateur_id_fkey;
       public          postgres    false    216    228    4788            �           2606    16787 #   produits produits_categorie_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.produits
    ADD CONSTRAINT produits_categorie_id_fkey FOREIGN KEY (categorie_id) REFERENCES public.categories(id) ON DELETE SET NULL;
 M   ALTER TABLE ONLY public.produits DROP CONSTRAINT produits_categorie_id_fkey;
       public          postgres    false    4798    224    226            �           2606    16871     retours retours_commande_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.retours
    ADD CONSTRAINT retours_commande_id_fkey FOREIGN KEY (commande_id) REFERENCES public.commandes(id) ON DELETE CASCADE;
 J   ALTER TABLE ONLY public.retours DROP CONSTRAINT retours_commande_id_fkey;
       public          postgres    false    232    238    4804            �           2606    16752 %   vendeurs vendeurs_utilisateur_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.vendeurs
    ADD CONSTRAINT vendeurs_utilisateur_id_fkey FOREIGN KEY (utilisateur_id) REFERENCES public.utilisateurs(id) ON DELETE CASCADE;
 O   ALTER TABLE ONLY public.vendeurs DROP CONSTRAINT vendeurs_utilisateur_id_fkey;
       public          postgres    false    216    220    4788            �           2606    16911    ventes ventes_produit_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.ventes
    ADD CONSTRAINT ventes_produit_id_fkey FOREIGN KEY (produit_id) REFERENCES public.produits(id) ON DELETE CASCADE;
 G   ALTER TABLE ONLY public.ventes DROP CONSTRAINT ventes_produit_id_fkey;
       public          postgres    false    244    224    4796            �           2606    16916 !   ventes ventes_utilisateur_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.ventes
    ADD CONSTRAINT ventes_utilisateur_id_fkey FOREIGN KEY (utilisateur_id) REFERENCES public.utilisateurs(id) ON DELETE CASCADE;
 K   ALTER TABLE ONLY public.ventes DROP CONSTRAINT ventes_utilisateur_id_fkey;
       public          postgres    false    216    244    4788            z      x������ � �      ~      x������ � �      v      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      |      x������ � �      �      x������ � �      t      x������ � �      x      x������ � �      �      x������ � �     