--
-- PostgreSQL database dump
--

-- Dumped from database version 10.5 (Debian 10.5-1)
-- Dumped by pg_dump version 13.2 (Debian 13.2-1)

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

--
-- Name: agents; Type: TABLE; Schema: public; Owner: progetto
--

CREATE TABLE public.agents (
    agent_code character(6) NOT NULL,
    agent_name character(40),
    working_area character(35),
    commission numeric(10,2),
    phone_no character(15),
    country character varying(25)
);


ALTER TABLE public.agents OWNER TO progetto;

--
-- Name: customer; Type: TABLE; Schema: public; Owner: progetto
--

CREATE TABLE public.customer (
    cust_code character varying(6) NOT NULL,
    cust_name character varying(40) NOT NULL,
    cust_city character(35),
    working_area character varying(35) NOT NULL,
    cust_country character varying(20) NOT NULL,
    grade numeric,
    opening_amt numeric(12,2) NOT NULL,
    receive_amt numeric(12,2) NOT NULL,
    payment_amt numeric(12,2) NOT NULL,
    outstanding_amt numeric(12,2) NOT NULL,
    phone_no character varying(17) NOT NULL,
    agent_code character(6) NOT NULL
);


ALTER TABLE public.customer OWNER TO progetto;

--
-- Name: orders; Type: TABLE; Schema: public; Owner: progetto
--

CREATE TABLE public.orders (
    ord_num numeric(6,0) NOT NULL,
    ord_amount numeric(12,2) NOT NULL,
    advance_amount numeric(12,2) NOT NULL,
    ord_date date NOT NULL,
    cust_code character varying(6) NOT NULL,
    agent_code character(6) NOT NULL,
    ord_description character varying(60) NOT NULL
);


ALTER TABLE public.orders OWNER TO progetto;

--
-- Data for Name: agents; Type: TABLE DATA; Schema: public; Owner: progetto
--

COPY public.agents (agent_code, agent_name, working_area, commission, phone_no, country) FROM stdin;
A007  	Ramasundar                              	Bangalore                          	0.15	077-25814763   	
A003  	Alex                                    	London                             	0.13	075-12458969   	
A008  	Alford                                  	New York                           	0.12	044-25874365   	
A011  	RaviKumar                               	Bangalore                          	0.15	077-45625874   	
A010  	Santakumar                              	Chennai                            	0.14	007-22388644   	
A012  	Lucida                                  	San Jose                           	0.12	044-52981425   	
A005  	Anderson                                	Brisban                            	0.13	045-21447739   	
A001  	Subbarao                                	Bangalore                          	0.14	077-12346674   	
A002  	Mukesh                                  	Mumbai                             	0.11	029-12358964   	
A006  	McDen                                   	London                             	0.15	078-22255588   	
A004  	Ivan                                    	Torento                            	0.15	008-22544166   	
A009  	Benjamin                                	Hampshair                          	0.11	008-22536178   	
\.


--
-- Data for Name: customer; Type: TABLE DATA; Schema: public; Owner: progetto
--

COPY public.customer (cust_code, cust_name, cust_city, working_area, cust_country, grade, opening_amt, receive_amt, payment_amt, outstanding_amt, phone_no, agent_code) FROM stdin;
C00013	Holmes	London                             	London	UK	2	6000.00	5000.00	7000.00	4000.00	BBBBBBB	A003  
C00001	Micheal	New York                           	New York	USA	2	3000.00	5000.00	2000.00	6000.00	CCCCCCC	A008  
C00020	Albert	New York                           	New York	USA	3	5000.00	7000.00	6000.00	6000.00	BBBBSBB	A008  
C00025	Ravindran	Bangalore                          	Bangalore	India	2	5000.00	7000.00	4000.00	8000.00	AVAVAVA	A011  
C00024	Cook	London                             	London	UK	2	4000.00	9000.00	7000.00	6000.00	FSDDSDF	A006  
C00015	Stuart	London                             	London	UK	1	6000.00	8000.00	3000.00	11000.00	GFSGERS	A003  
C00002	Bolt	New York                           	New York	USA	3	5000.00	7000.00	9000.00	3000.00	DDNRDRH	A008  
C00018	Fleming	Brisban                            	Brisban	Australia	2	7000.00	7000.00	9000.00	5000.00	NHBGVFC	A005  
C00021	Jacks	Brisban                            	Brisban	Australia	1	7000.00	7000.00	7000.00	7000.00	WERTGDF	A005  
C00008	Karolina	Torento                            	Torento	Canada	1	7000.00	7000.00	9000.00	5000.00	HJKORED	A004  
C00003	Martin	Torento                            	Torento	Canada	2	8000.00	7000.00	7000.00	8000.00	MJYURFD	A004  
C00009	Ramesh	Mumbai                             	Mumbai	India	3	8000.00	7000.00	3000.00	12000.00	Phone No	A002  
C00014	Rangarappa	Bangalore                          	Bangalore	India	2	8000.00	11000.00	7000.00	12000.00	AAAATGF	A001  
C00016	Venkatpati	Bangalore                          	Bangalore	India	2	8000.00	11000.00	7000.00	12000.00	JRTVFDD	A007  
C00011	Sundariya	Chennai                            	Chennai	India	3	7000.00	11000.00	7000.00	11000.00	PPHGRTS	A010  
C00019	Yearannaidu	Chennai                            	Chennai	India	1	8000.00	7000.00	7000.00	8000.00	ZZZZBFV	A010  
C00005	Sasikant	Mumbai                             	Mumbai	India	1	7000.00	11000.00	7000.00	11000.00	147-25896312	A002  
C00007	Ramanathan	Chennai                            	Chennai	India	1	7000.00	11000.00	9000.00	9000.00	GHRDWSD	A010  
C00022	Avinash	Mumbai                             	Mumbai	India	2	7000.00	11000.00	9000.00	9000.00	113-12345678	A002  
C00004	Winston	Brisban                            	Brisban	Australia	1	5000.00	8000.00	7000.00	6000.00	AAAAAAA	A005  
C00023	Karl	London                             	London	UK	0	4000.00	6000.00	7000.00	3000.00	AAAABAA	A006  
C00006	Shilton	Torento                            	Torento	Canada	1	10000.00	7000.00	6000.00	11000.00	DDDDDDD	A004  
C00010	Charles	Hampshair                          	Hampshair	UK	3	6000.00	4000.00	5000.00	5000.00	MMMMMMM	A009  
C00017	Srinivas	Bangalore                          	Bangalore	India	2	8000.00	4000.00	3000.00	9000.00	AAAAAAB	A007  
C00012	Steven	San Jose                           	San Jose	USA	1	5000.00	7000.00	9000.00	3000.00	KRFYGJK	A012  
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: progetto
--

COPY public.orders (ord_num, ord_amount, advance_amount, ord_date, cust_code, agent_code, ord_description) FROM stdin;
200100	1000.00	600.00	2008-08-01	C00013	A003  	SOD
200110	3000.00	500.00	2008-04-15	C00019	A010  	SOD
200107	4500.00	900.00	2008-08-30	C00007	A010  	SOD
200112	2000.00	400.00	2008-05-30	C00016	A007  	SOD
200113	4000.00	600.00	2008-06-10	C00022	A002  	SOD
200102	2000.00	300.00	2008-05-25	C00012	A012  	SOD
200114	3500.00	2000.00	2008-08-15	C00002	A008  	SOD
200122	2500.00	400.00	2008-09-16	C00003	A004  	SOD
200118	500.00	100.00	2008-07-20	C00023	A006  	SOD
200121	1500.00	600.00	2008-09-23	C00008	A004  	SOD
200130	2500.00	400.00	2008-07-30	C00025	A011  	SOD
200134	4200.00	1800.00	2008-09-25	C00004	A005  	SOD
200108	4000.00	600.00	2008-02-15	C00008	A004  	SOD
200105	2500.00	500.00	2008-07-18	C00025	A011  	SOD
200109	3500.00	800.00	2008-07-30	C00011	A010  	SOD
200101	3000.00	1000.00	2008-07-15	C00001	A008  	SOD
200111	1000.00	300.00	2008-07-10	C00020	A008  	SOD
200104	1500.00	500.00	2008-03-13	C00006	A004  	SOD
200106	2500.00	700.00	2008-04-20	C00005	A002  	SOD
200125	2000.00	600.00	2008-10-10	C00018	A005  	SOD
200117	800.00	200.00	2008-10-20	C00014	A001  	SOD
200123	500.00	100.00	2008-09-16	C00022	A002  	SOD
200120	500.00	100.00	2008-07-20	C00009	A002  	SOD
200116	500.00	100.00	2008-07-13	C00010	A009  	SOD
200124	500.00	100.00	2008-06-20	C00017	A007  	SOD
200126	500.00	100.00	2008-06-24	C00022	A002  	SOD
200129	2500.00	500.00	2008-07-20	C00024	A006  	SOD
200127	2500.00	400.00	2008-07-20	C00015	A003  	SOD
200128	3500.00	1500.00	2008-07-20	C00009	A002  	SOD
200135	2000.00	800.00	2008-09-16	C00007	A010  	SOD
200131	900.00	150.00	2008-08-26	C00012	A012  	SOD
200133	1200.00	400.00	2008-06-29	C00009	A002  	SOD
200405	1234.00	122.00	2021-06-16	C00021	A005  	Prova cambio da admin con select dinamica
200403	100.00	50.00	2021-06-13	C00008	A004  	Prova fadeout
200400	1440.10	523.11	2021-06-08	C00006	A004  	Prova con API e permessi PUT ter
200402	3500.00	100.56	2021-06-12	C00003	A004  	Altro
200119	4000.00	700.00	2008-09-16	C00007	A010  	SOD
200404	1234.00	122.00	2021-06-15	C00006	A004  	Test insert manager
\.


--
-- Name: agents agents_pkey; Type: CONSTRAINT; Schema: public; Owner: progetto
--

ALTER TABLE ONLY public.agents
    ADD CONSTRAINT agents_pkey PRIMARY KEY (agent_code);


--
-- Name: customer customer_pkey; Type: CONSTRAINT; Schema: public; Owner: progetto
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (cust_code);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: progetto
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (ord_num);


--
-- Name: customer customer_agent_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: progetto
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_agent_code_fkey FOREIGN KEY (agent_code) REFERENCES public.agents(agent_code);


--
-- Name: orders orders_agent_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: progetto
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_agent_code_fkey FOREIGN KEY (agent_code) REFERENCES public.agents(agent_code);


--
-- Name: orders orders_cust_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: progetto
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_cust_code_fkey FOREIGN KEY (cust_code) REFERENCES public.customer(cust_code);


--
-- PostgreSQL database dump complete
--

