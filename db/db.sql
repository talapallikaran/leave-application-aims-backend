PGDMP         )                 {            api    15.1    15.1 #    !           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            "           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            #           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            $           1262    24690    api    DATABASE     v   CREATE DATABASE api WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_India.1252';
    DROP DATABASE api;
                postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                pg_database_owner    false            %           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   pg_database_owner    false    4            �            1259    24691    leave_id_seq    SEQUENCE     u   CREATE SEQUENCE public.leave_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.leave_id_seq;
       public          postgres    false    4            �            1259    24692    leaves    TABLE     �   CREATE TABLE public.leaves (
    leave_id integer DEFAULT nextval('public.leave_id_seq'::regclass) NOT NULL,
    user_id integer,
    start_date date,
    end_date date,
    reason character varying(500),
    status integer
);
    DROP TABLE public.leaves;
       public         heap    postgres    false    214    4            �            1259    24698 
   que_id_seq    SEQUENCE     �   CREATE SEQUENCE public.que_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 9999999999
    CACHE 1
    CYCLE;
 !   DROP SEQUENCE public.que_id_seq;
       public          postgres    false    4            �            1259    24699    reporting_person_map    TABLE     c   CREATE TABLE public.reporting_person_map (
    user_id integer,
    reporting_person_id integer
);
 (   DROP TABLE public.reporting_person_map;
       public         heap    postgres    false    4            �            1259    24702    session_id_seq    SEQUENCE     w   CREATE SEQUENCE public.session_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.session_id_seq;
       public          postgres    false    4            �            1259    24703    submissions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.submissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 9999999999
    CACHE 1
    CYCLE;
 )   DROP SEQUENCE public.submissions_id_seq;
       public          postgres    false    4            �            1259    24704    supervisor_rev_id_seq    SEQUENCE     ~   CREATE SEQUENCE public.supervisor_rev_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.supervisor_rev_id_seq;
       public          postgres    false    4            �            1259    24705    supervisor_sub_id_seq    SEQUENCE     ~   CREATE SEQUENCE public.supervisor_sub_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.supervisor_sub_id_seq;
       public          postgres    false    4            �            1259    24706    user_id_seq    SEQUENCE     t   CREATE SEQUENCE public.user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.user_id_seq;
       public          postgres    false    4            �            1259    24707    user_session    TABLE       CREATE TABLE public.user_session (
    session_id integer DEFAULT nextval('public.session_id_seq'::regclass) NOT NULL,
    token character varying(1000),
    user_id integer,
    expires_at time without time zone DEFAULT (CURRENT_TIME(0) + '03:00:00'::interval) NOT NULL
);
     DROP TABLE public.user_session;
       public         heap    postgres    false    218    4            �            1259    24714    users    TABLE     ?  CREATE TABLE public.users (
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
       public         heap    postgres    false    222    4                      0    24692    leaves 
   TABLE DATA           Y   COPY public.leaves (leave_id, user_id, start_date, end_date, reason, status) FROM stdin;
    public          postgres    false    215   �&                 0    24699    reporting_person_map 
   TABLE DATA           L   COPY public.reporting_person_map (user_id, reporting_person_id) FROM stdin;
    public          postgres    false    217   �'                 0    24707    user_session 
   TABLE DATA           N   COPY public.user_session (session_id, token, user_id, expires_at) FROM stdin;
    public          postgres    false    223   �'                 0    24714    users 
   TABLE DATA           [   COPY public.users (user_id, id, role_id, name, email_id, dob, password, phone) FROM stdin;
    public          postgres    false    224   �(       &           0    0    leave_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.leave_id_seq', 14, true);
          public          postgres    false    214            '           0    0 
   que_id_seq    SEQUENCE SET     8   SELECT pg_catalog.setval('public.que_id_seq', 1, true);
          public          postgres    false    216            (           0    0    session_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.session_id_seq', 12, true);
          public          postgres    false    218            )           0    0    submissions_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.submissions_id_seq', 253, true);
          public          postgres    false    219            *           0    0    supervisor_rev_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.supervisor_rev_id_seq', 75, true);
          public          postgres    false    220            +           0    0    supervisor_sub_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.supervisor_sub_id_seq', 54, true);
          public          postgres    false    221            ,           0    0    user_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.user_id_seq', 7, true);
          public          postgres    false    222            }           2606    24720    leaves leaves_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.leaves
    ADD CONSTRAINT leaves_pkey PRIMARY KEY (leave_id);
 <   ALTER TABLE ONLY public.leaves DROP CONSTRAINT leaves_pkey;
       public            postgres    false    215                       2606    24722    user_session user_session_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT user_session_pkey PRIMARY KEY (session_id);
 H   ALTER TABLE ONLY public.user_session DROP CONSTRAINT user_session_pkey;
       public            postgres    false    223            �           2606    24724    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    224            �           2606    24725    leaves Leave_to_users    FK CONSTRAINT     �   ALTER TABLE ONLY public.leaves
    ADD CONSTRAINT "Leave_to_users" FOREIGN KEY (user_id) REFERENCES public.users(user_id) NOT VALID;
 A   ALTER TABLE ONLY public.leaves DROP CONSTRAINT "Leave_to_users";
       public          postgres    false    215    224    3201            �           2606    24730 *   reporting_person_map reporting_id_to_users    FK CONSTRAINT     �   ALTER TABLE ONLY public.reporting_person_map
    ADD CONSTRAINT reporting_id_to_users FOREIGN KEY (reporting_person_id) REFERENCES public.users(user_id) NOT VALID;
 T   ALTER TABLE ONLY public.reporting_person_map DROP CONSTRAINT reporting_id_to_users;
       public          postgres    false    3201    224    217            �           2606    24735 '   reporting_person_map reporting_to_users    FK CONSTRAINT     �   ALTER TABLE ONLY public.reporting_person_map
    ADD CONSTRAINT reporting_to_users FOREIGN KEY (user_id) REFERENCES public.users(user_id) NOT VALID;
 Q   ALTER TABLE ONLY public.reporting_person_map DROP CONSTRAINT reporting_to_users;
       public          postgres    false    224    217    3201            �           2606    24740    user_session session_to_user    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT session_to_user FOREIGN KEY (user_id) REFERENCES public.users(user_id) NOT VALID;
 F   ALTER TABLE ONLY public.user_session DROP CONSTRAINT session_to_user;
       public          postgres    false    223    3201    224               �   x�m�An�0EדS�R�r (�r6�dbFJ�*1Pn�MA���_�{��ނ�LS�x���ow͖]w]����������te��֋g���/?h�3���e�Z�sl���4�x��� �%E�ΊQ��˿4%��յY帆#s�
�]���,d���,��7���cٯ�?q�V�ggδ�{���U��J������`            x�3�4�2b3Ns.S ���� v�         �   x����n�@��5�K���"�
����A�1i(?:#�&�g���]u����@�ez�\�,g))d�|�9mH�����SϘ��a2)XS�¯w���	��r�c�����LT�@E����A��ˉ��v�����袒F�>u�&�5����훖�,t0���G����]�U�eq��JL�lƯ���4���ۏby],�]0��>'������mW?���i�ai         �  x�m�Ks�0���W��VFoY��!�Bx9��F���<���)��43�ќ{7��9"��f	���Y�`(���*��b&���1׫��?tq���9��~{��b���ķH��у���L7�pxS�꽅���h�1Q'�����L����|4�O�y�-�@I*E�����Z�#��L#5OT\	�)�hO���\���h��p"	1��s|E/�<���oy�\�Ө�/��_�q��J���3[���ń)��1�S���HHȰ긃����`j���Z[���z�w��7�/V��ƣw<w}9���K�̣ɥ�>O�6��;W�Y�ܓ�S�i<���;�-T����r��&�Va���!��RY�Q'�o�nK��O�1�f�p_�J �w����Y�hO�x΍j�쌕q��4�S��j�i���RM��f��+5���y�hM��Q���Pf�C�PY�`�ӡ�(K�gk�z�)V޼��,@�9����K�;�i:zz��&Hߢvz532�v��I��yH����v`�� Y�8lf$�E d
.�wO�q�a_:G�o��*�4)���p�/��?�߰݃�&�J�w�/�Q�<-C�4t�h�&Y�*����*�N�$Z��k�Y"f�I �9��(Z��j�_�r�     