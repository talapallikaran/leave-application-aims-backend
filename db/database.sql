PGDMP     *                     {            user_db    15.1    15.1 ;    O           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            P           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            Q           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            R           1262    16396    user_db    DATABASE     z   CREATE DATABASE user_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_India.1252';
    DROP DATABASE user_db;
                postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                pg_database_owner    false            S           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   pg_database_owner    false    4            �            1259    16397 
   que_id_seq    SEQUENCE     �   CREATE SEQUENCE public.que_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 9999999999
    CACHE 1
    CYCLE;
 !   DROP SEQUENCE public.que_id_seq;
       public          postgres    false    4            �            1259    16398 	   questions    TABLE     �   CREATE TABLE public.questions (
    id integer DEFAULT nextval('public.que_id_seq'::regclass) NOT NULL,
    isactive integer,
    deleteflag integer,
    question character varying(250),
    dateupdate timestamp with time zone
);
    DROP TABLE public.questions;
       public         heap    postgres    false    214    4            �            1259    16402    reviews    TABLE     v   CREATE TABLE public.reviews (
    id integer NOT NULL,
    qid integer,
    ans integer,
    submission_id integer
);
    DROP TABLE public.reviews;
       public         heap    postgres    false    4            �            1259    16405    reviews_id_seq    SEQUENCE     �   CREATE SEQUENCE public.reviews_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.reviews_id_seq;
       public          postgres    false    216    4            T           0    0    reviews_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.reviews_id_seq OWNED BY public.reviews.id;
          public          postgres    false    217            �            1259    16406    roles    TABLE     �   CREATE TABLE public.roles (
    id integer NOT NULL,
    name character varying(25),
    isactive integer,
    deleteflag integer,
    dateupdated timestamp with time zone
);
    DROP TABLE public.roles;
       public         heap    postgres    false    4            �            1259    16409    submissions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.submissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 9999999999
    CACHE 1
    CYCLE;
 )   DROP SEQUENCE public.submissions_id_seq;
       public          postgres    false    4            �            1259    16410    submissions    TABLE     �   CREATE TABLE public.submissions (
    id integer DEFAULT nextval('public.submissions_id_seq'::regclass) NOT NULL,
    comment character varying(100),
    survey_id integer,
    dateupdated timestamp with time zone,
    user_id integer
);
    DROP TABLE public.submissions;
       public         heap    postgres    false    219    4            �            1259    16414    supervisor_rev_id_seq    SEQUENCE     ~   CREATE SEQUENCE public.supervisor_rev_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.supervisor_rev_id_seq;
       public          postgres    false    4            �            1259    16415    supervisor_reviews    TABLE     �   CREATE TABLE public.supervisor_reviews (
    "id " integer DEFAULT nextval('public.supervisor_rev_id_seq'::regclass) NOT NULL,
    qid integer,
    ans integer,
    sv_submission_id integer
);
 &   DROP TABLE public.supervisor_reviews;
       public         heap    postgres    false    221    4            �            1259    16419    supervisor_sub_id_seq    SEQUENCE     ~   CREATE SEQUENCE public.supervisor_sub_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.supervisor_sub_id_seq;
       public          postgres    false    4            �            1259    16420    supervisor_submissions    TABLE       CREATE TABLE public.supervisor_submissions (
    id integer DEFAULT nextval('public.supervisor_sub_id_seq'::regclass) NOT NULL,
    comment character varying(100),
    dateupdated timestamp with time zone,
    user_id integer,
    survey_id integer,
    worker_id integer
);
 *   DROP TABLE public.supervisor_submissions;
       public         heap    postgres    false    223    4            �            1259    16424    survey    TABLE     �   CREATE TABLE public.survey (
    id integer NOT NULL,
    title character varying(25),
    month integer,
    year integer,
    accesslevel integer,
    isactive integer,
    deleteflag integer,
    dateupdate timestamp with time zone
);
    DROP TABLE public.survey;
       public         heap    postgres    false    4            �            1259    16427    surveyquestions    TABLE     n   CREATE TABLE public.surveyquestions (
    sq_id integer NOT NULL,
    qu_id integer,
    survey_id integer
);
 #   DROP TABLE public.surveyquestions;
       public         heap    postgres    false    4            �            1259    16430    users    TABLE     �  CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(25),
    email character varying(50),
    phone character varying(15),
    isactive integer,
    deleteflag integer,
    role_id integer,
    password character varying(60),
    uuid character varying(60),
    updateddate timestamp with time zone,
    reporting_person_id integer,
    image_src character varying,
    last_name character varying(25)
);
    DROP TABLE public.users;
       public         heap    postgres    false    4            �            1259    16435    users_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public          postgres    false    227    4            U           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public          postgres    false    228            �            1259    16436    worker_supervisor_map    TABLE     y   CREATE TABLE public.worker_supervisor_map (
    id integer NOT NULL,
    worker_id integer,
    supervisor_id integer
);
 )   DROP TABLE public.worker_supervisor_map;
       public         heap    postgres    false    4            �           2604    16439 
   reviews id    DEFAULT     h   ALTER TABLE ONLY public.reviews ALTER COLUMN id SET DEFAULT nextval('public.reviews_id_seq'::regclass);
 9   ALTER TABLE public.reviews ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    217    216            �           2604    16440    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    228    227            >          0    16398 	   questions 
   TABLE DATA           S   COPY public.questions (id, isactive, deleteflag, question, dateupdate) FROM stdin;
    public          postgres    false    215   0E       ?          0    16402    reviews 
   TABLE DATA           >   COPY public.reviews (id, qid, ans, submission_id) FROM stdin;
    public          postgres    false    216   �E       A          0    16406    roles 
   TABLE DATA           L   COPY public.roles (id, name, isactive, deleteflag, dateupdated) FROM stdin;
    public          postgres    false    218   [H       C          0    16410    submissions 
   TABLE DATA           S   COPY public.submissions (id, comment, survey_id, dateupdated, user_id) FROM stdin;
    public          postgres    false    220   �H       E          0    16415    supervisor_reviews 
   TABLE DATA           O   COPY public.supervisor_reviews ("id ", qid, ans, sv_submission_id) FROM stdin;
    public          postgres    false    222   IJ       G          0    16420    supervisor_submissions 
   TABLE DATA           i   COPY public.supervisor_submissions (id, comment, dateupdated, user_id, survey_id, worker_id) FROM stdin;
    public          postgres    false    224   �K       H          0    16424    survey 
   TABLE DATA           g   COPY public.survey (id, title, month, year, accesslevel, isactive, deleteflag, dateupdate) FROM stdin;
    public          postgres    false    225   �L       I          0    16427    surveyquestions 
   TABLE DATA           B   COPY public.surveyquestions (sq_id, qu_id, survey_id) FROM stdin;
    public          postgres    false    226   .M       J          0    16430    users 
   TABLE DATA           �   COPY public.users (id, name, email, phone, isactive, deleteflag, role_id, password, uuid, updateddate, reporting_person_id, image_src, last_name) FROM stdin;
    public          postgres    false    227   M       L          0    16436    worker_supervisor_map 
   TABLE DATA           M   COPY public.worker_supervisor_map (id, worker_id, supervisor_id) FROM stdin;
    public          postgres    false    229   �T       V           0    0 
   que_id_seq    SEQUENCE SET     8   SELECT pg_catalog.setval('public.que_id_seq', 1, true);
          public          postgres    false    214            W           0    0    reviews_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.reviews_id_seq', 1315, true);
          public          postgres    false    217            X           0    0    submissions_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.submissions_id_seq', 267, true);
          public          postgres    false    219            Y           0    0    supervisor_rev_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.supervisor_rev_id_seq', 120, true);
          public          postgres    false    221            Z           0    0    supervisor_sub_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.supervisor_sub_id_seq', 63, true);
          public          postgres    false    223            [           0    0    users_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.users_id_seq', 201, true);
          public          postgres    false    228            �           2606    16442    questions questions_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.questions DROP CONSTRAINT questions_pkey;
       public            postgres    false    215            �           2606    16444    reviews reviews_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.reviews DROP CONSTRAINT reviews_pkey;
       public            postgres    false    216            �           2606    16446    roles roles_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.roles DROP CONSTRAINT roles_pkey;
       public            postgres    false    218            �           2606    16448    submissions submissions_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT submissions_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.submissions DROP CONSTRAINT submissions_pkey;
       public            postgres    false    220            �           2606    16450 *   supervisor_reviews supervisor_reviews_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public.supervisor_reviews
    ADD CONSTRAINT supervisor_reviews_pkey PRIMARY KEY ("id ");
 T   ALTER TABLE ONLY public.supervisor_reviews DROP CONSTRAINT supervisor_reviews_pkey;
       public            postgres    false    222            �           2606    16452 2   supervisor_submissions supervisor_submissions_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.supervisor_submissions
    ADD CONSTRAINT supervisor_submissions_pkey PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.supervisor_submissions DROP CONSTRAINT supervisor_submissions_pkey;
       public            postgres    false    224            �           2606    16454    survey survey_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.survey
    ADD CONSTRAINT survey_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.survey DROP CONSTRAINT survey_pkey;
       public            postgres    false    225            �           2606    16456 $   surveyquestions surveyquestions_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.surveyquestions
    ADD CONSTRAINT surveyquestions_pkey PRIMARY KEY (sq_id);
 N   ALTER TABLE ONLY public.surveyquestions DROP CONSTRAINT surveyquestions_pkey;
       public            postgres    false    226            �           2606    16458    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    227            �           2606    16460 .   worker_supervisor_map work_supervisor_map_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.worker_supervisor_map
    ADD CONSTRAINT work_supervisor_map_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.worker_supervisor_map DROP CONSTRAINT work_supervisor_map_pkey;
       public            postgres    false    229            �           2606    16461    reviews rev_to_sub    FK CONSTRAINT     �   ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT rev_to_sub FOREIGN KEY (submission_id) REFERENCES public.submissions(id) NOT VALID;
 <   ALTER TABLE ONLY public.reviews DROP CONSTRAINT rev_to_sub;
       public          postgres    false    220    3227    216            �           2606    16466    users role_id    FK CONSTRAINT     l   ALTER TABLE ONLY public.users
    ADD CONSTRAINT role_id FOREIGN KEY (role_id) REFERENCES public.roles(id);
 7   ALTER TABLE ONLY public.users DROP CONSTRAINT role_id;
       public          postgres    false    218    227    3225            �           2606    16471    surveyquestions sq_to_questions    FK CONSTRAINT     �   ALTER TABLE ONLY public.surveyquestions
    ADD CONSTRAINT sq_to_questions FOREIGN KEY (qu_id) REFERENCES public.questions(id) NOT VALID;
 I   ALTER TABLE ONLY public.surveyquestions DROP CONSTRAINT sq_to_questions;
       public          postgres    false    226    3221    215            �           2606    16476    surveyquestions sq_to_survey    FK CONSTRAINT     �   ALTER TABLE ONLY public.surveyquestions
    ADD CONSTRAINT sq_to_survey FOREIGN KEY (survey_id) REFERENCES public.survey(id) NOT VALID;
 F   ALTER TABLE ONLY public.surveyquestions DROP CONSTRAINT sq_to_survey;
       public          postgres    false    226    3233    225            �           2606    16481 5   supervisor_submissions supervisor_submissions_to_user    FK CONSTRAINT     �   ALTER TABLE ONLY public.supervisor_submissions
    ADD CONSTRAINT supervisor_submissions_to_user FOREIGN KEY (user_id) REFERENCES public.users(id) NOT VALID;
 _   ALTER TABLE ONLY public.supervisor_submissions DROP CONSTRAINT supervisor_submissions_to_user;
       public          postgres    false    227    3237    224            �           2606    16486 (   supervisor_reviews supervisor_to_reviews    FK CONSTRAINT     �   ALTER TABLE ONLY public.supervisor_reviews
    ADD CONSTRAINT supervisor_to_reviews FOREIGN KEY (sv_submission_id) REFERENCES public.supervisor_submissions(id) NOT VALID;
 R   ALTER TABLE ONLY public.supervisor_reviews DROP CONSTRAINT supervisor_to_reviews;
       public          postgres    false    3231    224    222            �           2606    16491    submissions user_to_sub    FK CONSTRAINT     �   ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT user_to_sub FOREIGN KEY (user_id) REFERENCES public.users(id) NOT VALID;
 A   ALTER TABLE ONLY public.submissions DROP CONSTRAINT user_to_sub;
       public          postgres    false    3237    220    227            >   y   x�}й�0��\�+@^M��!9 ���Ht��
�|��@���z��ϒ�g;��e_��!��j&j����VE�D�"2U�L�*&#�
Z̀{��͂��nAsa����ߥr���.�e      ?   �  x�E�ەe!D��`f���$&��?������?�"p���~��f��y��n�g��H�Ӭ�����:��go��p���<����(��ٌK��f+��f� Q��ڀ�	X���ʆ�+�r��S"˔H��d�ڝW���8Gqzh΀�밬�!9h`A���⬨her�[z�瓊��ICn�H�(�u%`�pH5�*iQ=��<��5�k:$��wi�Z��ѕP'�F6/�+�S7S��
&���J�=�XQ%�Z�#����RE�����[��-ҝ���q�2� x�BƳ��H>��Tc��i����f�
�UΘ������>Ӓ�0�T$�h�f�*F�ua����! !c�(�`����V��Tʈ�;��f�u����,#bC)�|\F�nG~Tm�ϧ��4P�K��&h�ޥ6��fkI��C�7�B)1�'=�,�B�y�}ݣ��L8V��JnQΨ�a2f︒��bN�K��L{�B����C59�fH1ʄLO���_�H�`!�29�{�7��o��SgI�sV��Og4M �?zo�=�n����t��u��雡�����ۿ����~rs���u�A�C�΅�X�S��xw�v�e����ɑ�U&���?uD���������?h�#�      A   1   x�3�,�/�N-�� .#��҂Ԣ����|$aC�Ĕ��<�@� Q�1      C   �  x���Kn�0���)�uab�|] 7�1��N]��"�Ϙ�I�SZ~�f�')��~�^:�-�s�R �'�o����ԐD��tzu�?��3ȘU�}w�h_��(������G�ȕ�T���=K�rm�� e��G���04�!�d42Wr:�`���/Ra)�E�����V/1���t�e���˼�����-���v+z�;��jEOC��X0:�Kw���-�5�ZsE/r���ŹFOii��SZ��f���.i�fE�g	w/JC�<+f�亊�dk�p�Sr�Ӿ{oi��V(dZ2�v���e_�I k�5pŊ�v&���?総��a��Eȋ�a��̽\�� �S��r�cp�)7��{���vh���ű��N��.L���tf#�OΊg2�c�8����4�'��.�      E   �  x�M�[�� D�a1�T��&f��u\$�Ҫ�2�n:8h��,��Y	��F�N1xҤ�/��	c�/z����#�p��>p���K�tt���3�|?ܗ�����t���	U����g�K�{{������s�%nX����t���{��Q�Dʓh�+w2w�w�˝�r��q�����ʫT�U���Z��t�'}��S������l�%��dZzf�g�������~��?��Z7�����Lm��LAA!���+�r@�R�i��Z�e�+�eY��P��t��.6��㔍�?�A���ǻ^��e��9~��=�}���&t��r�� �[�=q�⍚/B��^�$��Q�ka)p�L�	��뙚N�=y����čOCY��?f�ħ�      G   �   x����n�0Eg�+�6�K)���ԱS�5��I]�S�>��>����:G��ަ�6OR��<O��V����
.���N���%���2��E�lB����%@+�cKWQ�fڍ��俎�����0:<%�br��S�ͥ��p# �W�)V|�PQ��K����vۃ�#����6~A�9�YQG0<^����"����peK[����sgY�y�      H   M   x�3�.-*K�T0�44�4202�4�4bS��R��H��������L���P����؀��͈$m�0m�$i����� \�!      I   A   x����@��L1Q������2��g�h�l}8�ru��-��b;bb'b��p�z�$��$?�"�      J   E  x���Is��F��W��w/$jX]����Û��b���_��n���#^���@����<�H�a��e���b5wA�\xR1�	%�x�C����;FߛB頙�ӭM���w�Mx��v�����^G�C��n����-��i9�f�RL|�c�3ũ%��:�h"T"�G!>F>�߰*qU"4����E��;�*`���$�v&����/������������γ�Im�����!�V���9�?Y�饍V���h}�(�Z�ȋh��'>���g.B�����HS��E����O�7�KT�0��oG�*��i���.��m���� %(�����N̤��ƙ��v��3^�t~��J
� tHT������ͺ(��~3.���L͢Z�����u׽[3l�vP�D����Z�3��9��$�<I�%o\��g.�J��h߸����H*!)�<Xecoevn^�^s�o'�7�l��T�`�h�ͧ�6����+����Q/����9̊.�_�f��8�D������`�X$��L"����c��X+*��4�K�ȯ�$#P\��^�,=���������,^��-�K]�e�C5��PK�0ջ�i��1 �i��t�t�_�֕����-/wv��څ��Q��ȵϐq��\��!��V�:���/��E���.�R~ʦ�b��д�����.��.�Z��&�ޥ䠏/��K�S̥Zo����6a������n�nZܜ�w�_.O�'��6����P�I�G��3Hkcch�߹�.!Ub$�L�K�]�AJ��+��-ݛl�~|��ulo����A�;��: �x3OQ������ǃ��sy4�p�rk;���Y������s� �>���+�ǹ���ܢ�%�}8�o��(
�_�Iʄzu�r�f3��6P���ze�)��O��q��퀒O�iI�s˺#�����bk<cH�w/T^�W����p\�z,R��t�"E	���W��e�f�h�/DȸJ\��f�\��m��,�QI���-��U���l��>�"ꋟ|����5�u[��F��U]������e�O:�K��#^�,�����"d,�T�2qI'�������ouF�f��U1���1#୫�Z2��� CJ�ga�cǝxX6������Ulu��k��^K7mt��"i 9��8��g�~S�Kc+���w�Å���;1@TZj|A\,mZ8�ua�y:�������\�3"�n�kO�!���_��Ko���ޅ�X����F�F���>��D	���)e(��bX���"�*�~�4��oM��_�CQy���b���|�s��vn��������E����'������^��~@;����(v/�Z�qqQn��<��3=
מ!�I
�3�^�i00�:�~��`F%Q�67!����M|�������Q���᠀������ϯ��Y��0~]�����p}�����Ge��.sr�k���Ju��Df#s�̛8x��i;�"���cG����S�o%51%��������]�^���O���/u��,����1w/�o��YR	ߨ����8��]r����V�*�*����հ�ۋ��e��B��IQNc�_k�q�G<���h��_T�H*9�$�����l
���x[X�~s��,�w׺�y:Nz١Ż̹���z����͊��@�2�x�q��$2���T"=������๝�Ʈ�neV�4@D}�⳨4�T q�
�P8��΄g���yZ��͞ZD����Y[>�dwh���}�7�Z���g�ӿk,�7l���^lT<�8|��羊`���L�>eIq������#��%T_���9;�9(
��겐      L      x�3�4�4�2�4�Ɯ�@2F��� !��     