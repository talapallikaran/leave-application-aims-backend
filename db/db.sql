PGDMP     6    ;        
         {            api    15.1    15.1 '    )           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            *           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            +           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            ,           1262    24676    api    DATABASE     v   CREATE DATABASE api WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_India.1252';
    DROP DATABASE api;
                postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                pg_database_owner    false            -           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
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
       public         heap    postgres    false    218    4            "          0    57344    leaves 
   TABLE DATA           ]   COPY public.leaves (leave_id, user_id, start_date, end_date, reason, status, id) FROM stdin;
    public          postgres    false    221   ?+       #          0    57350    reporting_person_map 
   TABLE DATA           ?   COPY public.reporting_person_map (user_id, reporting_person_id, reporting_person_uuid, reporting_person_name, user_uuid) FROM stdin;
    public          postgres    false    222   G-       &          0    65547 
   user_roles 
   TABLE DATA           8   COPY public.user_roles (role_id, role_name) FROM stdin;
    public          postgres    false    225   ?-       $          0    57353    user_session 
   TABLE DATA           R   COPY public.user_session (session_id, token, user_id, expires_at, id) FROM stdin;
    public          postgres    false    223   ?-       %          0    57360    users 
   TABLE DATA           [   COPY public.users (user_id, id, role_id, name, email_id, dob, password, phone) FROM stdin;
    public          postgres    false    224   ?/       .           0    0    leave_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.leave_id_seq', 21, true);
          public          postgres    false    219            /           0    0 
   que_id_seq    SEQUENCE SET     8   SELECT pg_catalog.setval('public.que_id_seq', 1, true);
          public          postgres    false    214            0           0    0    session_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.session_id_seq', 19, true);
          public          postgres    false    220            1           0    0    submissions_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.submissions_id_seq', 253, true);
          public          postgres    false    215            2           0    0    supervisor_rev_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.supervisor_rev_id_seq', 75, true);
          public          postgres    false    216            3           0    0    supervisor_sub_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.supervisor_sub_id_seq', 54, true);
          public          postgres    false    217            4           0    0    user_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.user_id_seq', 7, true);
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
       public          postgres    false    224    222    3205            ?           2606    57381 '   reporting_person_map reporting_to_users    FK CONSTRAINT     ?   ALTER TABLE ONLY public.reporting_person_map
    ADD CONSTRAINT reporting_to_users FOREIGN KEY (user_id) REFERENCES public.users(user_id) NOT VALID;
 Q   ALTER TABLE ONLY public.reporting_person_map DROP CONSTRAINT reporting_to_users;
       public          postgres    false    222    3205    224            ?           2606    57386    user_session session_to_user    FK CONSTRAINT     ?   ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT session_to_user FOREIGN KEY (user_id) REFERENCES public.users(user_id) NOT VALID;
 F   ALTER TABLE ONLY public.user_session DROP CONSTRAINT session_to_user;
       public          postgres    false    223    224    3205            ?           2606    65552    users user_role_id    FK CONSTRAINT     ?   ALTER TABLE ONLY public.users
    ADD CONSTRAINT user_role_id FOREIGN KEY (role_id) REFERENCES public.user_roles(role_id) NOT VALID;
 <   ALTER TABLE ONLY public.users DROP CONSTRAINT user_role_id;
       public          postgres    false    225    224    3207            "   =  x??S]n? {&??L@?????z????#CJ`J?Oo?Ҧ??m?4	!??G????42X?G?\k??ԃo?????Й?e?B?qx ?
؆	??y??y?)?]4?نQT.bN?Z?F}??֌n8b?????_T,S?U?闻û!G6#\?P?@7?L??;??N?????w?0-e???????t??0?BH?;?T?uic{?????'????9????*?k???mY?-/??#??&?)Nj)%i*?+m%?.X?3??1???????_ݟ?????????=??%?բ0_!m? eI??"??T??[?? ???      #   {   x???;?0 ??9E/`dǉ?ހ?b`??$??HU,?qx?H??????LL?u䁉?J??????M'??f???%???B??s????b?8?6??kkF)?boۦ???????q=?>????      &      x?3?-N-?2?tL????????? 6??      $   ?  x????r?@ ?3<ž?P?????P?FS[?Ì?I?D????u?䵫?U#?1]??b?M???By??????Pq?k??0?޵Ծ]?<<7??????ou??
?3????$OM??p?g0?)??S齩x????s?~??a??㸫?iB???¼??CL?`?	? ?? ? QU~?q????A*?,??W?2??H<?Ț[?u?p~??>?|vu??E݆?m?q?&?,*֭???w??ny!????r?0?X$???a???8@FJ	%Օ?.???r?(?ktb??ޱ??jI???eӽ?Md?*Z????Į?v>yVg9??Ai@?SK?I?k`$???8?1*_Z?3#\$ttw??kz?P?b???r?Fx$??????\????k>?l??<?´?? ????`2???B:?f?F5?(AHRB?9??Һ???<?u????      %   ?  x?m?Ks?0???W??VFoY??!?Bx9??F???<???)??43?ќ{7??9"???f	???Y?`(???*??b&???1׫???tq???9??~{??b???ķH??у???L7?pxS?꽅???h?1Q'?????L????|4?O?y?-?@I*E?????Z??#??L#5OT\	?)?hO???\???h??p"	1??s|E/?<???oy?\?Ө?/??_?q??J???3[???ń)??1?S???HHȰ긃????`j???Z[???z?w??7?/V??ƣw<w}9???K?̣ɥ?>O?6???;W?Y?ܓ?S?i<???;?-T????r??&?Va???!??RY?Q'?o?nK??O?1?f?p_?J ?w????Y?hO?x΍j?쌕q??4?S??j?i???RM??f??+5???y?hM??Q???Pf?C?PY?`?ӡ?(K?gk?z?)V޼???,@?9????K?;?i:zz??&Hߢvz532?v??I??yH????v`?? Y?8lf$?E d
.?wO?q?a_:G?o??*?4)????p?/????߰݃?&?J?w?/?Q?<-C?4t?h?&Y?*????*?N?$Z??k?Y"f?I ?9??(Z??j?_?r?     