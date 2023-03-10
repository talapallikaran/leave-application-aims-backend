PGDMP                  
         {            api    15.1    15.1 &    (           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            )           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            *           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            +           1262    24676    api    DATABASE     v   CREATE DATABASE api WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_India.1252';
    DROP DATABASE api;
                postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                pg_database_owner    false            ,           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   pg_database_owner    false    4            ?            1259    32880    leave_id_seq    SEQUENCE     u   CREATE SEQUENCE public.leave_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.leave_id_seq;
       public          postgres    false    4            ?            1259    57344    leaves    TABLE     ?   CREATE TABLE public.leaves (
    leave_id integer DEFAULT nextval('public.leave_id_seq'::regclass) NOT NULL,
    user_id integer,
    start_date date,
    end_date date,
    reason character varying(500),
    status integer,
    id uuid
);
    DROP TABLE public.leaves;
       public         heap    postgres    false    219    4            ?            1259    24683 
   que_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.que_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 9999999999
    CACHE 1
    CYCLE;
 !   DROP SEQUENCE public.que_id_seq;
       public          postgres    false    4            ?            1259    57350    reporting_person_map    TABLE     ?   CREATE TABLE public.reporting_person_map (
    user_id integer,
    reporting_person_id integer,
    reporting_person_uuid uuid,
    reporting_person_name character varying,
    user_uuid uuid
);
 (   DROP TABLE public.reporting_person_map;
       public         heap    postgres    false    4            ?            1259    40975    session_id_seq    SEQUENCE     w   CREATE SEQUENCE public.session_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.session_id_seq;
       public          postgres    false    4            ?            1259    24695    submissions_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.submissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 9999999999
    CACHE 1
    CYCLE;
 )   DROP SEQUENCE public.submissions_id_seq;
       public          postgres    false    4            ?            1259    24700    supervisor_rev_id_seq    SEQUENCE     ~   CREATE SEQUENCE public.supervisor_rev_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.supervisor_rev_id_seq;
       public          postgres    false    4            ?            1259    24705    supervisor_sub_id_seq    SEQUENCE     ~   CREATE SEQUENCE public.supervisor_sub_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.supervisor_sub_id_seq;
       public          postgres    false    4            ?            1259    32874    user_id_seq    SEQUENCE     t   CREATE SEQUENCE public.user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.user_id_seq;
       public          postgres    false    4            ?            1259    65547 
   user_roles    TABLE     f   CREATE TABLE public.user_roles (
    role_id integer NOT NULL,
    role_name character varying(25)
);
    DROP TABLE public.user_roles;
       public         heap    postgres    false    4            ?            1259    57353    user_session    TABLE     &  CREATE TABLE public.user_session (
    session_id integer DEFAULT nextval('public.session_id_seq'::regclass) NOT NULL,
    token character varying(1000),
    user_id integer,
    expires_at timestamp without time zone DEFAULT (CURRENT_TIMESTAMP + '03:00:00'::interval) NOT NULL,
    id uuid
);
     DROP TABLE public.user_session;
       public         heap    postgres    false    220    4            ?            1259    57360    users    TABLE     ?  CREATE TABLE public.users (
    user_id integer DEFAULT nextval('public.user_id_seq'::regclass) NOT NULL,
    id uuid DEFAULT gen_random_uuid(),
    role_id integer,
    name character varying(30),
    email_id character varying(50),
    dob date,
    password character varying(60),
    phone character varying(60)
);
    DROP TABLE public.users;
       public         heap    postgres    false    218    4            !          0    57344    leaves 
   TABLE DATA           ]   COPY public.leaves (leave_id, user_id, start_date, end_date, reason, status, id) FROM stdin;
    public          postgres    false    221   ?*       "          0    57350    reporting_person_map 
   TABLE DATA           ?   COPY public.reporting_person_map (user_id, reporting_person_id, reporting_person_uuid, reporting_person_name, user_uuid) FROM stdin;
    public          postgres    false    222   ?+       %          0    65547 
   user_roles 
   TABLE DATA           8   COPY public.user_roles (role_id, role_name) FROM stdin;
    public          postgres    false    225   },       #          0    57353    user_session 
   TABLE DATA           R   COPY public.user_session (session_id, token, user_id, expires_at, id) FROM stdin;
    public          postgres    false    223   ?,       $          0    57360    users 
   TABLE DATA           [   COPY public.users (user_id, id, role_id, name, email_id, dob, password, phone) FROM stdin;
    public          postgres    false    224   ?.       -           0    0    leave_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.leave_id_seq', 21, true);
          public          postgres    false    219            .           0    0 
   que_id_seq    SEQUENCE SET     8   SELECT pg_catalog.setval('public.que_id_seq', 1, true);
          public          postgres    false    214            /           0    0    session_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.session_id_seq', 20, true);
          public          postgres    false    220            0           0    0    submissions_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.submissions_id_seq', 253, true);
          public          postgres    false    215            1           0    0    supervisor_rev_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.supervisor_rev_id_seq', 75, true);
          public          postgres    false    216            2           0    0    supervisor_sub_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.supervisor_sub_id_seq', 54, true);
          public          postgres    false    217            3           0    0    user_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.user_id_seq', 9, true);
          public          postgres    false    218            ?           2606    57366    leaves leaves_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.leaves
    ADD CONSTRAINT leaves_pkey PRIMARY KEY (leave_id);
 <   ALTER TABLE ONLY public.leaves DROP CONSTRAINT leaves_pkey;
       public            postgres    false    221            ?           2606    65551    user_roles user_roles_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (role_id);
 D   ALTER TABLE ONLY public.user_roles DROP CONSTRAINT user_roles_pkey;
       public            postgres    false    225            ?           2606    57368    user_session user_session_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT user_session_pkey PRIMARY KEY (session_id);
 H   ALTER TABLE ONLY public.user_session DROP CONSTRAINT user_session_pkey;
       public            postgres    false    223            ?           2606    57370    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    224            ?           2606    57371    leaves Leave_to_users    FK CONSTRAINT     ?   ALTER TABLE ONLY public.leaves
    ADD CONSTRAINT "Leave_to_users" FOREIGN KEY (user_id) REFERENCES public.users(user_id) NOT VALID;
 A   ALTER TABLE ONLY public.leaves DROP CONSTRAINT "Leave_to_users";
       public          postgres    false    224    3205    221            ?           2606    57376 *   reporting_person_map reporting_id_to_users    FK CONSTRAINT     ?   ALTER TABLE ONLY public.reporting_person_map
    ADD CONSTRAINT reporting_id_to_users FOREIGN KEY (reporting_person_id) REFERENCES public.users(user_id) NOT VALID;
 T   ALTER TABLE ONLY public.reporting_person_map DROP CONSTRAINT reporting_id_to_users;
       public          postgres    false    3205    222    224            ?           2606    57381 '   reporting_person_map reporting_to_users    FK CONSTRAINT     ?   ALTER TABLE ONLY public.reporting_person_map
    ADD CONSTRAINT reporting_to_users FOREIGN KEY (user_id) REFERENCES public.users(user_id) NOT VALID;
 Q   ALTER TABLE ONLY public.reporting_person_map DROP CONSTRAINT reporting_to_users;
       public          postgres    false    222    3205    224            ?           2606    57386    user_session session_to_user    FK CONSTRAINT     ?   ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT session_to_user FOREIGN KEY (user_id) REFERENCES public.users(user_id) NOT VALID;
 F   ALTER TABLE ONLY public.user_session DROP CONSTRAINT session_to_user;
       public          postgres    false    223    3205    224            !   =  x??S]n? {&??L@?????z????#CJ`J?Oo?Ҧ??m?4	!??G????42X?G?\k??ԃo?????Й?e?B?qx ?
؆	??y??y?)?]4?نQT.bN?Z?F}??֌n8b?????_T,S?U?闻û!G6#\?P?@7?L??;??N?????w?0-e???????t??0?BH?;?T?uic{?????'????9????*?k???mY?-/??#??&?)Nj)%i*?+m%?.X?3??1???????_ݟ?????????=??%?բ0_!m? eI??"??T??[?? ???      "   ?   x???;?0 ?99E/`?Ď?܀?b`??8??H?*n??By?#?.??bT????"ԑ0J??-P????C??nz?????ŧ????FK??&0?0???K?f??ܢ}L??ޟ?/ƽ???J?bLZ?ǘa?y@m?)[??_??/X      %      x?3?-N-?2?tL????????? 6??      #   $  x????r?@??5<ż@[}o??"?@0?15US?t'`2j?Ax?0???ܞ>????Z???????z-?%u??]0?E<???V?L?????0HۺX???ٝ?F?q???<&so???q?6>N???vx??huo??kµ7_??x'?Mr7?.???W?W>nZKZb ??Х?%?*Vs
 +J@?q???JP"??I???w??p?+x??#??9z???]?<x;????&,??CWR]{?
?B???Z?".?.?*E?q???\ ? ?aP?KRj??6rns???c??ty?h?0??i?V{?ԤA?>?0???e??????ݝ??????-??1Ā.??AUTc?8zhn??HK)?????F??Ww?t???~?NWrtL????P?????????7??1+yf^??2?G-?-v??t8-???RU@K$??1J!5??L;6?7:?KG?޿?????_?????(yʖ?%dr???a?#?yv???tW????&????b?%C???
U?9?a I??P?R?Rf?ٶ?((?      $   O  x?m?Ks?8???Wd??@??n??&	??&$??H?????̯1???ԤJ%?J?O??+2??c?@,??̋*??^k?4s?g???T??ln??n?ƀ??L?_??)?m?????:?-?????=]?n?:?մ~?!4?#2Y\4?盤{p??????̗3}???#ВJD??E?&??e0#??? ?j??ǔ?L ???cnn??䷿???a?$??n??z??????m??????˗:??:??T???tfb??0?D?? A1a?3A[`+SB??		??? C?R??^???啭2ks8 ??_????_<???]?O"?E??y4k???l??4?e?:??????;+b2?G????? Z?? ??֥?k?? PqΡ?ڳ?f?{uuw_???ܜ?}
???;_	$??-???^4?gh??Nw???X??Gt??z????qSϰ??*+????Ҵ%B??1??P???p#??T?Tf??(?:??sS??M?t?)??:??0?K?'??|?tWw^]ۮ????I?E?$?Ϲ"????~????(?>w?"??Ƅԓ K9Oq]F}H^?jjtil?3??@86?)o~?n?W???9?????(Y??yg???.ٜV5??N??U??gcmN/??k?E"?YH?8?A(?
?#???@????V?jmihB???(???_??Z??j??O}f?&?ѧo???-????V?w.???W??j6:vm??X-C?H???oi`(q?7?'?2?S?????????6?bcsS??~?RQH???^V?X???{_U:7U{rW?????????ϷO??^Q?HT??%M??W?\?[?????`?     