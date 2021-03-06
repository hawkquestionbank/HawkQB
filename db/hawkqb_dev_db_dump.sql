PGDMP         4                 w           hawkqb_development    9.5.17    9.5.17 a    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            �           1262    16807    hawkqb_development    DATABASE     �   CREATE DATABASE hawkqb_development WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';
 "   DROP DATABASE hawkqb_development;
             railsdevuser    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false            �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    6            �           0    0    SCHEMA public    ACL     �   REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;
                  postgres    false    6                        3079    12393    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false            �           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1            �            1259    24645    answers    TABLE     �   CREATE TABLE public.answers (
    id bigint NOT NULL,
    txt text,
    is_correct boolean DEFAULT false,
    question_id integer
);
    DROP TABLE public.answers;
       public         railsdevuser    false    6            �            1259    24643    answers_id_seq    SEQUENCE     w   CREATE SEQUENCE public.answers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.answers_id_seq;
       public       railsdevuser    false    6    196            �           0    0    answers_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.answers_id_seq OWNED BY public.answers.id;
            public       railsdevuser    false    195            �            1259    16849    ar_internal_metadata    TABLE     �   CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);
 (   DROP TABLE public.ar_internal_metadata;
       public         railsdevuser    false    6            �            1259    24698    attempts    TABLE     /  CREATE TABLE public.attempts (
    id bigint NOT NULL,
    txt text,
    question_id bigint,
    user_id bigint,
    answer_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    answer_hash json DEFAULT '{}'::json,
    score numeric
);
    DROP TABLE public.attempts;
       public         railsdevuser    false    6            �            1259    24696    attempts_id_seq    SEQUENCE     x   CREATE SEQUENCE public.attempts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.attempts_id_seq;
       public       railsdevuser    false    6    200            �           0    0    attempts_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.attempts_id_seq OWNED BY public.attempts.id;
            public       railsdevuser    false    199            �            1259    16941    course_registrations    TABLE     �   CREATE TABLE public.course_registrations (
    id bigint NOT NULL,
    user_id bigint,
    course_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);
 (   DROP TABLE public.course_registrations;
       public         railsdevuser    false    6            �            1259    16939    course_registrations_id_seq    SEQUENCE     �   CREATE SEQUENCE public.course_registrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.course_registrations_id_seq;
       public       railsdevuser    false    184    6            �           0    0    course_registrations_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.course_registrations_id_seq OWNED BY public.course_registrations.id;
            public       railsdevuser    false    183            �            1259    16951    courses    TABLE     �  CREATE TABLE public.courses (
    id bigint NOT NULL,
    title character varying,
    description text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    creator_user_id integer,
    token character varying,
    max_attempts integer DEFAULT 2,
    close_to_attempts timestamp without time zone,
    can_view_answers_after timestamp without time zone,
    is_an_exam boolean DEFAULT false,
    default_number_of_choices integer DEFAULT 4
);
    DROP TABLE public.courses;
       public         railsdevuser    false    6            �            1259    16949    courses_id_seq    SEQUENCE     w   CREATE SEQUENCE public.courses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.courses_id_seq;
       public       railsdevuser    false    186    6            �           0    0    courses_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.courses_id_seq OWNED BY public.courses.id;
            public       railsdevuser    false    185            �            1259    16962    micro_credential_maps    TABLE     |   CREATE TABLE public.micro_credential_maps (
    id bigint NOT NULL,
    course_id bigint,
    micro_credential_id bigint
);
 )   DROP TABLE public.micro_credential_maps;
       public         railsdevuser    false    6            �            1259    16960    micro_credential_maps_id_seq    SEQUENCE     �   CREATE SEQUENCE public.micro_credential_maps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.micro_credential_maps_id_seq;
       public       railsdevuser    false    188    6            �           0    0    micro_credential_maps_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.micro_credential_maps_id_seq OWNED BY public.micro_credential_maps.id;
            public       railsdevuser    false    187            �            1259    16972    micro_credentials    TABLE     �   CREATE TABLE public.micro_credentials (
    id bigint NOT NULL,
    title character varying,
    description text,
    creator_user_id integer,
    identifier character varying(20)
);
 %   DROP TABLE public.micro_credentials;
       public         railsdevuser    false    6            �            1259    16970    micro_credentials_id_seq    SEQUENCE     �   CREATE SEQUENCE public.micro_credentials_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.micro_credentials_id_seq;
       public       railsdevuser    false    190    6            �           0    0    micro_credentials_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.micro_credentials_id_seq OWNED BY public.micro_credentials.id;
            public       railsdevuser    false    189            �            1259    24667    question_micro_credentials    TABLE     �   CREATE TABLE public.question_micro_credentials (
    id bigint NOT NULL,
    question_id integer,
    micro_credential_id integer
);
 .   DROP TABLE public.question_micro_credentials;
       public         railsdevuser    false    6            �            1259    24665 !   question_micro_credentials_id_seq    SEQUENCE     �   CREATE SEQUENCE public.question_micro_credentials_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.question_micro_credentials_id_seq;
       public       railsdevuser    false    6    198            �           0    0 !   question_micro_credentials_id_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE public.question_micro_credentials_id_seq OWNED BY public.question_micro_credentials.id;
            public       railsdevuser    false    197            �            1259    24629 	   questions    TABLE     '  CREATE TABLE public.questions (
    id bigint NOT NULL,
    title character varying,
    description text,
    type character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    creator_user_id integer,
    course_id integer
);
    DROP TABLE public.questions;
       public         railsdevuser    false    6            �            1259    24627    questions_id_seq    SEQUENCE     y   CREATE SEQUENCE public.questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.questions_id_seq;
       public       railsdevuser    false    194    6            �           0    0    questions_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.questions_id_seq OWNED BY public.questions.id;
            public       railsdevuser    false    193            �            1259    16841    schema_migrations    TABLE     R   CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);
 %   DROP TABLE public.schema_migrations;
       public         railsdevuser    false    6            �            1259    16983    users    TABLE     �  CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    first_name character varying,
    last_name character varying,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    roles character varying
);
    DROP TABLE public.users;
       public         railsdevuser    false    6            �            1259    16981    users_id_seq    SEQUENCE     u   CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public       railsdevuser    false    6    192            �           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
            public       railsdevuser    false    191            -           2604    24648    id    DEFAULT     h   ALTER TABLE ONLY public.answers ALTER COLUMN id SET DEFAULT nextval('public.answers_id_seq'::regclass);
 9   ALTER TABLE public.answers ALTER COLUMN id DROP DEFAULT;
       public       railsdevuser    false    195    196    196            0           2604    24701    id    DEFAULT     j   ALTER TABLE ONLY public.attempts ALTER COLUMN id SET DEFAULT nextval('public.attempts_id_seq'::regclass);
 :   ALTER TABLE public.attempts ALTER COLUMN id DROP DEFAULT;
       public       railsdevuser    false    199    200    200            !           2604    16944    id    DEFAULT     �   ALTER TABLE ONLY public.course_registrations ALTER COLUMN id SET DEFAULT nextval('public.course_registrations_id_seq'::regclass);
 F   ALTER TABLE public.course_registrations ALTER COLUMN id DROP DEFAULT;
       public       railsdevuser    false    184    183    184            "           2604    16954    id    DEFAULT     h   ALTER TABLE ONLY public.courses ALTER COLUMN id SET DEFAULT nextval('public.courses_id_seq'::regclass);
 9   ALTER TABLE public.courses ALTER COLUMN id DROP DEFAULT;
       public       railsdevuser    false    185    186    186            &           2604    16965    id    DEFAULT     �   ALTER TABLE ONLY public.micro_credential_maps ALTER COLUMN id SET DEFAULT nextval('public.micro_credential_maps_id_seq'::regclass);
 G   ALTER TABLE public.micro_credential_maps ALTER COLUMN id DROP DEFAULT;
       public       railsdevuser    false    188    187    188            '           2604    16975    id    DEFAULT     |   ALTER TABLE ONLY public.micro_credentials ALTER COLUMN id SET DEFAULT nextval('public.micro_credentials_id_seq'::regclass);
 C   ALTER TABLE public.micro_credentials ALTER COLUMN id DROP DEFAULT;
       public       railsdevuser    false    190    189    190            /           2604    24670    id    DEFAULT     �   ALTER TABLE ONLY public.question_micro_credentials ALTER COLUMN id SET DEFAULT nextval('public.question_micro_credentials_id_seq'::regclass);
 L   ALTER TABLE public.question_micro_credentials ALTER COLUMN id DROP DEFAULT;
       public       railsdevuser    false    198    197    198            ,           2604    24632    id    DEFAULT     l   ALTER TABLE ONLY public.questions ALTER COLUMN id SET DEFAULT nextval('public.questions_id_seq'::regclass);
 ;   ALTER TABLE public.questions ALTER COLUMN id DROP DEFAULT;
       public       railsdevuser    false    194    193    194            (           2604    16986    id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public       railsdevuser    false    192    191    192            �          0    24645    answers 
   TABLE DATA               C   COPY public.answers (id, txt, is_correct, question_id) FROM stdin;
    public       railsdevuser    false    196   Pt       �           0    0    answers_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.answers_id_seq', 4, true);
            public       railsdevuser    false    195            �          0    16849    ar_internal_metadata 
   TABLE DATA               R   COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
    public       railsdevuser    false    182   �t       �          0    24698    attempts 
   TABLE DATA               x   COPY public.attempts (id, txt, question_id, user_id, answer_id, created_at, updated_at, answer_hash, score) FROM stdin;
    public       railsdevuser    false    200   �t       �           0    0    attempts_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.attempts_id_seq', 1, true);
            public       railsdevuser    false    199            �          0    16941    course_registrations 
   TABLE DATA               ^   COPY public.course_registrations (id, user_id, course_id, created_at, updated_at) FROM stdin;
    public       railsdevuser    false    184   :u       �           0    0    course_registrations_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.course_registrations_id_seq', 7, true);
            public       railsdevuser    false    183            �          0    16951    courses 
   TABLE DATA               �   COPY public.courses (id, title, description, created_at, updated_at, creator_user_id, token, max_attempts, close_to_attempts, can_view_answers_after, is_an_exam, default_number_of_choices) FROM stdin;
    public       railsdevuser    false    186   xu       �           0    0    courses_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.courses_id_seq', 4, true);
            public       railsdevuser    false    185            �          0    16962    micro_credential_maps 
   TABLE DATA               S   COPY public.micro_credential_maps (id, course_id, micro_credential_id) FROM stdin;
    public       railsdevuser    false    188   ev       �           0    0    micro_credential_maps_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.micro_credential_maps_id_seq', 5, true);
            public       railsdevuser    false    187            �          0    16972    micro_credentials 
   TABLE DATA               `   COPY public.micro_credentials (id, title, description, creator_user_id, identifier) FROM stdin;
    public       railsdevuser    false    190   �v       �           0    0    micro_credentials_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.micro_credentials_id_seq', 5, true);
            public       railsdevuser    false    189            �          0    24667    question_micro_credentials 
   TABLE DATA               Z   COPY public.question_micro_credentials (id, question_id, micro_credential_id) FROM stdin;
    public       railsdevuser    false    198   Jw       �           0    0 !   question_micro_credentials_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.question_micro_credentials_id_seq', 1, false);
            public       railsdevuser    false    197            �          0    24629 	   questions 
   TABLE DATA               u   COPY public.questions (id, title, description, type, created_at, updated_at, creator_user_id, course_id) FROM stdin;
    public       railsdevuser    false    194   gw       �           0    0    questions_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.questions_id_seq', 1, true);
            public       railsdevuser    false    193            �          0    16841    schema_migrations 
   TABLE DATA               4   COPY public.schema_migrations (version) FROM stdin;
    public       railsdevuser    false    181   x       �          0    16983    users 
   TABLE DATA               �   COPY public.users (id, email, encrypted_password, first_name, last_name, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, roles) FROM stdin;
    public       railsdevuser    false    192   �x       �           0    0    users_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.users_id_seq', 5, true);
            public       railsdevuser    false    191            I           2606    24654    answers_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.answers
    ADD CONSTRAINT answers_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.answers DROP CONSTRAINT answers_pkey;
       public         railsdevuser    false    196    196            5           2606    16856    ar_internal_metadata_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);
 X   ALTER TABLE ONLY public.ar_internal_metadata DROP CONSTRAINT ar_internal_metadata_pkey;
       public         railsdevuser    false    182    182            M           2606    24706    attempts_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.attempts
    ADD CONSTRAINT attempts_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.attempts DROP CONSTRAINT attempts_pkey;
       public         railsdevuser    false    200    200            7           2606    16946    course_registrations_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.course_registrations
    ADD CONSTRAINT course_registrations_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.course_registrations DROP CONSTRAINT course_registrations_pkey;
       public         railsdevuser    false    184    184            ;           2606    16959    courses_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.courses DROP CONSTRAINT courses_pkey;
       public         railsdevuser    false    186    186            ?           2606    16967    micro_credential_maps_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.micro_credential_maps
    ADD CONSTRAINT micro_credential_maps_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.micro_credential_maps DROP CONSTRAINT micro_credential_maps_pkey;
       public         railsdevuser    false    188    188            A           2606    16980    micro_credentials_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.micro_credentials
    ADD CONSTRAINT micro_credentials_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.micro_credentials DROP CONSTRAINT micro_credentials_pkey;
       public         railsdevuser    false    190    190            K           2606    24672    question_micro_credentials_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.question_micro_credentials
    ADD CONSTRAINT question_micro_credentials_pkey PRIMARY KEY (id);
 d   ALTER TABLE ONLY public.question_micro_credentials DROP CONSTRAINT question_micro_credentials_pkey;
       public         railsdevuser    false    198    198            G           2606    24637    questions_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.questions DROP CONSTRAINT questions_pkey;
       public         railsdevuser    false    194    194            3           2606    16848    schema_migrations_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);
 R   ALTER TABLE ONLY public.schema_migrations DROP CONSTRAINT schema_migrations_pkey;
       public         railsdevuser    false    181    181            E           2606    16994 
   users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public         railsdevuser    false    192    192            N           1259    24724    index_attempts_on_answer_id    INDEX     U   CREATE INDEX index_attempts_on_answer_id ON public.attempts USING btree (answer_id);
 /   DROP INDEX public.index_attempts_on_answer_id;
       public         railsdevuser    false    200            O           1259    24722    index_attempts_on_question_id    INDEX     Y   CREATE INDEX index_attempts_on_question_id ON public.attempts USING btree (question_id);
 1   DROP INDEX public.index_attempts_on_question_id;
       public         railsdevuser    false    200            P           1259    24723    index_attempts_on_user_id    INDEX     Q   CREATE INDEX index_attempts_on_user_id ON public.attempts USING btree (user_id);
 -   DROP INDEX public.index_attempts_on_user_id;
       public         railsdevuser    false    200            8           1259    16947 '   index_course_registrations_on_course_id    INDEX     m   CREATE INDEX index_course_registrations_on_course_id ON public.course_registrations USING btree (course_id);
 ;   DROP INDEX public.index_course_registrations_on_course_id;
       public         railsdevuser    false    184            9           1259    16948 %   index_course_registrations_on_user_id    INDEX     i   CREATE INDEX index_course_registrations_on_user_id ON public.course_registrations USING btree (user_id);
 9   DROP INDEX public.index_course_registrations_on_user_id;
       public         railsdevuser    false    184            <           1259    16968 (   index_micro_credential_maps_on_course_id    INDEX     o   CREATE INDEX index_micro_credential_maps_on_course_id ON public.micro_credential_maps USING btree (course_id);
 <   DROP INDEX public.index_micro_credential_maps_on_course_id;
       public         railsdevuser    false    188            =           1259    16969 2   index_micro_credential_maps_on_micro_credential_id    INDEX     �   CREATE INDEX index_micro_credential_maps_on_micro_credential_id ON public.micro_credential_maps USING btree (micro_credential_id);
 F   DROP INDEX public.index_micro_credential_maps_on_micro_credential_id;
       public         railsdevuser    false    188            B           1259    16995    index_users_on_email    INDEX     N   CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);
 (   DROP INDEX public.index_users_on_email;
       public         railsdevuser    false    192            C           1259    16996 #   index_users_on_reset_password_token    INDEX     l   CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);
 7   DROP INDEX public.index_users_on_reset_password_token;
       public         railsdevuser    false    192            X           2606    24707    fk_rails_103abcd17e    FK CONSTRAINT     �   ALTER TABLE ONLY public.attempts
    ADD CONSTRAINT fk_rails_103abcd17e FOREIGN KEY (question_id) REFERENCES public.questions(id);
 F   ALTER TABLE ONLY public.attempts DROP CONSTRAINT fk_rails_103abcd17e;
       public       railsdevuser    false    194    2119    200            Z           2606    24717    fk_rails_1baabff8ff    FK CONSTRAINT        ALTER TABLE ONLY public.attempts
    ADD CONSTRAINT fk_rails_1baabff8ff FOREIGN KEY (answer_id) REFERENCES public.answers(id);
 F   ALTER TABLE ONLY public.attempts DROP CONSTRAINT fk_rails_1baabff8ff;
       public       railsdevuser    false    200    196    2121            U           2606    24655    fk_rails_3d5ed4418f    FK CONSTRAINT     �   ALTER TABLE ONLY public.answers
    ADD CONSTRAINT fk_rails_3d5ed4418f FOREIGN KEY (question_id) REFERENCES public.questions(id);
 E   ALTER TABLE ONLY public.answers DROP CONSTRAINT fk_rails_3d5ed4418f;
       public       railsdevuser    false    194    2119    196            R           2606    17067    fk_rails_5f335dae7d    FK CONSTRAINT     �   ALTER TABLE ONLY public.micro_credentials
    ADD CONSTRAINT fk_rails_5f335dae7d FOREIGN KEY (creator_user_id) REFERENCES public.users(id);
 O   ALTER TABLE ONLY public.micro_credentials DROP CONSTRAINT fk_rails_5f335dae7d;
       public       railsdevuser    false    190    2117    192            Q           2606    16997    fk_rails_a0c8c21e8a    FK CONSTRAINT     �   ALTER TABLE ONLY public.courses
    ADD CONSTRAINT fk_rails_a0c8c21e8a FOREIGN KEY (creator_user_id) REFERENCES public.users(id);
 E   ALTER TABLE ONLY public.courses DROP CONSTRAINT fk_rails_a0c8c21e8a;
       public       railsdevuser    false    192    2117    186            V           2606    24673    fk_rails_a64fee3b64    FK CONSTRAINT     �   ALTER TABLE ONLY public.question_micro_credentials
    ADD CONSTRAINT fk_rails_a64fee3b64 FOREIGN KEY (question_id) REFERENCES public.questions(id);
 X   ALTER TABLE ONLY public.question_micro_credentials DROP CONSTRAINT fk_rails_a64fee3b64;
       public       railsdevuser    false    194    198    2119            S           2606    24638    fk_rails_acdac30c69    FK CONSTRAINT     �   ALTER TABLE ONLY public.questions
    ADD CONSTRAINT fk_rails_acdac30c69 FOREIGN KEY (creator_user_id) REFERENCES public.users(id);
 G   ALTER TABLE ONLY public.questions DROP CONSTRAINT fk_rails_acdac30c69;
       public       railsdevuser    false    2117    194    192            T           2606    24683    fk_rails_c73562d5b6    FK CONSTRAINT     �   ALTER TABLE ONLY public.questions
    ADD CONSTRAINT fk_rails_c73562d5b6 FOREIGN KEY (course_id) REFERENCES public.courses(id);
 G   ALTER TABLE ONLY public.questions DROP CONSTRAINT fk_rails_c73562d5b6;
       public       railsdevuser    false    2107    186    194            W           2606    24678    fk_rails_e8edaa449d    FK CONSTRAINT     �   ALTER TABLE ONLY public.question_micro_credentials
    ADD CONSTRAINT fk_rails_e8edaa449d FOREIGN KEY (micro_credential_id) REFERENCES public.micro_credentials(id);
 X   ALTER TABLE ONLY public.question_micro_credentials DROP CONSTRAINT fk_rails_e8edaa449d;
       public       railsdevuser    false    2113    198    190            Y           2606    24712    fk_rails_f881199d2c    FK CONSTRAINT     {   ALTER TABLE ONLY public.attempts
    ADD CONSTRAINT fk_rails_f881199d2c FOREIGN KEY (user_id) REFERENCES public.users(id);
 F   ALTER TABLE ONLY public.attempts DROP CONSTRAINT fk_rails_f881199d2c;
       public       railsdevuser    false    192    2117    200            �   @   x�3�,�)M/�)�ɳ��L�4�2�,��)KE2�NMT�H,φ�� E��%�E%9(�c���� �*      �   >   x�K�+�,���M�+�LI-K��/ ��-uLu��M��M���,�,�-p�p��qqq �G      �   <   x�3���4�4b#CK]s]c##+cS+SL1##=C#��ZN=�=... ���      �   .   x�3�4B#CK]3]C#+SK+C=SK#K3<R\1z\\\ ���      �   �   x�m��j�0E��W�"���6���n���@(��v��Jm�GR�00W�3"��.�2xr���:Pw�j<�E1J�J������&�3Av�jO-G'nXt�@�P�B�{`� �!�������O�Η~�f�:,�?N��tr��bCJ��WU<f��3������v>��i7�p����J�J�Vyǵ"�b��D���:�#"6����1���]����� �]8      �   "   x�3�4�4�2��\&���&\�@Ҕ+F��� 4�{      �   �   x��O;
�0��S��w)!C3u(� ^�X!!��z�ƱSr�
�ޓ�~��-k����a���ٲr�͔mv08҂?rC9�7���yk��~اd���Ë��Х�;9#�m� _�#��]��<��J<��(�w�.�)[As�$˨��.����S���V+��      �      x������ � �      �   �   x���M
�0���)�Z�G�f㢛nt'n���I���T�����>�o$���S�\�	c�@;���2�1�0���1�(T �i\<D� �;����q��9����DS��uJ9�Ԣ�Fٟ�����s��֪�h���c�9���@      �   �   x�U�Q�!�3�*@�.{�s,�nzl�^,!���P�l�Cp7���Ͼ)R��0�u� �'�4q���Ȧ��6�S:�c�$^�&��7�0��HI�O�'�i�uЍ��!�����ͧԪ��}С��D�jT�fW�h����E��c�u#}���Bթ3�>c��^[      �   �  x�}�]o�@���Wp��� WU���+�V�PD@���u�Ƶ��d2ɛ��<'�r�,��֩"�Nc������_��1����/Dc`x`S�Ц��sy�N\�{P��˛����e�,J�O
�jj��@�צ,�>���CTے܆� �&I��bIVأ"������_+�\��j;����2\�6'���1��o�~)p&z��#�\��^���W�*��7�%1	�L c��C~t��̽6X��ڍ/B�ۛ$TL�b��Jӝ���s��R�rQl�:}3�[�$�"/�E�+'�pf�<��-&�0D�
�2`�j"`������K���L��򋟕Ud��m��y�a�Z��2�ǔ�8��9�Sq������Ar'��@C����$ �IX� �`��
"�T"�����	�/SGw�^'���{�2��Y� ���QbQ�#s���=�`1��Vtz6�W���\���:�A�P���U��A�Ra�`�}�2���?Go�     