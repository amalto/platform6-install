--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Drop databases (except postgres and template1)
--

--DROP DATABASE b2box;




--
-- Drop roles
--

--DROP ROLE b2box;
--DROP ROLE postgres;


--
-- Roles
--

CREATE ROLE b2box;
ALTER ROLE b2box WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md556e436fe2c6d8a21cdd3d1313b6410e4';
--CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS;






--
-- PostgreSQL database dump
--

-- Dumped from database version 11.7
-- Dumped by pg_dump version 11.7

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

UPDATE pg_catalog.pg_database SET datistemplate = false WHERE datname = 'template1';
DROP DATABASE template1;
--
-- Name: template1; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE template1 OWNER TO postgres;

\connect template1

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

--
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: template1; Type: DATABASE PROPERTIES; Schema: -; Owner: postgres
--

ALTER DATABASE template1 IS_TEMPLATE = true;


\connect template1

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

--
-- Name: DATABASE template1; Type: ACL; Schema: -; Owner: postgres
--

REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 11.7
-- Dumped by pg_dump version 11.7

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

--
-- Name: b2box; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE b2box WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE b2box OWNER TO postgres;

\connect b2box

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

--
-- Name: p6core; Type: SCHEMA; Schema: -; Owner: b2box
--

CREATE SCHEMA p6core;


ALTER SCHEMA p6core OWNER TO b2box;

--
-- Name: tablefunc; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS tablefunc WITH SCHEMA public;


--
-- Name: EXTENSION tablefunc; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION tablefunc IS 'functions that manipulate whole tables, including crosstab';


--
-- Name: itempartitiontype; Type: TYPE; Schema: p6core; Owner: b2box
--

CREATE TYPE p6core.itempartitiontype AS ENUM (
    'LOG',
    'TABLE_DATA',
    'TRANSACTION'
);


ALTER TYPE p6core.itempartitiontype OWNER TO b2box;

--
-- Name: array_to_string_i(text[], text); Type: FUNCTION; Schema: public; Owner: b2box
--

CREATE FUNCTION public.array_to_string_i(texts text[], sep text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$


                            select array_to_string (texts, sep)


                        $$;


ALTER FUNCTION public.array_to_string_i(texts text[], sep text) OWNER TO b2box;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: activeroutingorder; Type: TABLE; Schema: p6core; Owner: b2box
--

CREATE TABLE p6core.activeroutingorder (
    name character varying(512) NOT NULL,
    content xml NOT NULL
);


ALTER TABLE p6core.activeroutingorder OWNER TO b2box;

--
-- Name: completedroutingorder; Type: TABLE; Schema: p6core; Owner: b2box
--

CREATE TABLE p6core.completedroutingorder (
    name character varying(512) NOT NULL,
    content xml NOT NULL
);


ALTER TABLE p6core.completedroutingorder OWNER TO b2box;

--
-- Name: failedroutingorder; Type: TABLE; Schema: p6core; Owner: b2box
--

CREATE TABLE p6core.failedroutingorder (
    name character varying(512) NOT NULL,
    content xml NOT NULL
);


ALTER TABLE p6core.failedroutingorder OWNER TO b2box;

--
-- Name: flyway_schema_history; Type: TABLE; Schema: p6core; Owner: b2box
--

CREATE TABLE p6core.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE p6core.flyway_schema_history OWNER TO b2box;

--
-- Name: instancedata; Type: TABLE; Schema: p6core; Owner: b2box
--

CREATE TABLE p6core.instancedata (
    application character varying(512) NOT NULL,
    service character varying(512) NOT NULL,
    type character varying(512) NOT NULL,
    content jsonb NOT NULL
);


ALTER TABLE p6core.instancedata OWNER TO b2box;

--
-- Name: item; Type: TABLE; Schema: p6core; Owner: b2box
--

CREATE TABLE p6core.item (
    datapartition p6core.itempartitiontype NOT NULL,
    datatype character varying(64) NOT NULL,
    iid1 character varying(256) NOT NULL,
    iid2 character varying(96) NOT NULL,
    iid3 character varying(96) NOT NULL,
    iid4 character varying(96) NOT NULL,
    content xml NOT NULL,
    inserttime bigint
)
PARTITION BY LIST (datapartition);


ALTER TABLE p6core.item OWNER TO b2box;

--
-- Name: log; Type: TABLE; Schema: p6core; Owner: b2box
--

CREATE TABLE p6core.log (
    datapartition p6core.itempartitiontype NOT NULL,
    datatype character varying(64) NOT NULL,
    iid1 character varying(256) NOT NULL,
    iid2 character varying(96) NOT NULL,
    iid3 character varying(96) NOT NULL,
    iid4 character varying(96) NOT NULL,
    content xml NOT NULL,
    inserttime bigint
);
ALTER TABLE ONLY p6core.item ATTACH PARTITION p6core.log FOR VALUES IN ('LOG');


ALTER TABLE p6core.log OWNER TO b2box;

--
-- Name: rawbytes; Type: TABLE; Schema: p6core; Owner: b2box
--

CREATE TABLE p6core.rawbytes (
    id1 character varying(96) NOT NULL,
    id2 character varying(96) NOT NULL,
    content bytea NOT NULL,
    inserttime bigint
);


ALTER TABLE p6core.rawbytes OWNER TO b2box;

--
-- Name: serviceconfig; Type: TABLE; Schema: p6core; Owner: b2box
--

CREATE TABLE p6core.serviceconfig (
    id1 character varying(512) NOT NULL,
    id2 character varying(256) NOT NULL,
    id3 character varying(256) NOT NULL,
    content jsonb NOT NULL,
    bytes bytea,
    inserttime bigint
);


ALTER TABLE p6core.serviceconfig OWNER TO b2box;

--
-- Name: table_data; Type: TABLE; Schema: p6core; Owner: b2box
--

CREATE TABLE p6core.table_data (
    datapartition p6core.itempartitiontype NOT NULL,
    datatype character varying(64) NOT NULL,
    iid1 character varying(256) NOT NULL,
    iid2 character varying(96) NOT NULL,
    iid3 character varying(96) NOT NULL,
    iid4 character varying(96) NOT NULL,
    content xml NOT NULL,
    inserttime bigint
);
ALTER TABLE ONLY p6core.item ATTACH PARTITION p6core.table_data FOR VALUES IN ('TABLE_DATA');


ALTER TABLE p6core.table_data OWNER TO b2box;

--
-- Name: transaction; Type: TABLE; Schema: p6core; Owner: b2box
--

CREATE TABLE p6core.transaction (
    datapartition p6core.itempartitiontype NOT NULL,
    datatype character varying(64) NOT NULL,
    iid1 character varying(256) NOT NULL,
    iid2 character varying(96) NOT NULL,
    iid3 character varying(96) NOT NULL,
    iid4 character varying(96) NOT NULL,
    content xml NOT NULL,
    inserttime bigint
);
ALTER TABLE ONLY p6core.item ATTACH PARTITION p6core.transaction FOR VALUES IN ('TRANSACTION');


ALTER TABLE p6core.transaction OWNER TO b2box;

--
-- Data for Name: activeroutingorder; Type: TABLE DATA; Schema: p6core; Owner: b2box
--

COPY p6core.activeroutingorder (name, content) FROM stdin;
\.


--
-- Data for Name: completedroutingorder; Type: TABLE DATA; Schema: p6core; Owner: b2box
--

COPY p6core.completedroutingorder (name, content) FROM stdin;
\.


--
-- Data for Name: failedroutingorder; Type: TABLE DATA; Schema: p6core; Owner: b2box
--

COPY p6core.failedroutingorder (name, content) FROM stdin;
\.


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: p6core; Owner: b2box
--

COPY p6core.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	1	<< Flyway Baseline >>	BASELINE	<< Flyway Baseline >>	\N	b2box	2019-07-09 16:56:52.327831	0	t
2	2	B2BOX5-1833 Rename schema	SQL	V2__B2BOX5-1833_Rename_schema.sql	-1383918368	b2box	2019-07-09 16:56:52.555483	81	t
3	3	B2BOX5-1757 Remove old tables	SQL	V3__B2BOX5-1757_Remove_old_tables.sql	-877196747	b2box	2019-07-09 16:56:52.69576	76	t
4	4	B2BOX5-1797 Rename transaction dataType	SQL	V4__B2BOX5-1797_Rename_transaction_dataType.sql	-1502122155	b2box	2019-07-09 16:56:52.976214	101	t
5	5	B2BOX5-1832 Remove iid-columns from item table	SQL	V5__B2BOX5-1832_Remove_iid-columns_from_item_table.sql	2108340418	b2box	2019-07-09 16:56:53.098325	26	t
6	6	B2BOX5-1832 Rename cluster column from item table	SQL	V6__B2BOX5-1832_Rename_cluster_column_from_item_table.sql	-828191573	b2box	2019-07-09 16:56:53.153305	970	t
7	7	B2BOX5-1832 Rename concept column from item table	SQL	V7__B2BOX5-1832_Rename_concept_column_from_item_table.sql	938934585	b2box	2019-07-09 16:56:54.436847	45	t
8	8	B2BOX5-1832 Remove universPK from routingorder tables content	SQL	V8__B2BOX5-1832_Remove_universPK_from_routingorder_tables_content.sql	-1348765445	b2box	2019-07-09 16:56:54.5331	277	t
9	9	B2BOX5-1832 Fix routingorder tables content	SQL	V9__B2BOX5-1832_Fix_routingorder_tables_content.sql	-2075348165	b2box	2019-07-09 16:56:54.8256	38	t
10	10	B2BOX5-1832 Fix routingorder tables content adapter	SQL	V10__B2BOX5-1832_Fix_routingorder_tables_content_adapter.sql	-1495442787	b2box	2019-07-09 16:56:54.892106	77	t
11	11	B2BOX5-1845 Table item partition	SQL	V11__B2BOX5-1845_Table_item_partition.sql	-1362038486	b2box	2019-07-09 16:56:54.99719	417	t
12	12	B2BOX-1852 Fix transaction content for WFWorkItem	SQL	V12__B2BOX-1852_Fix_transaction_content_for_WFWorkItem.sql	-257561398	b2box	2019-07-09 16:56:55.457054	72	t
13	13	B2BOX5-1540 Rename WFWorkItem to WorkflowTask	SQL	V13__B2BOX5-1540_Rename_WFWorkItem_to_WorkflowTask.sql	1974853329	b2box	2019-07-09 16:56:55.568073	29	t
14	13.1	B2BOX5-1540 Rename WFWorkItem to WorkflowTask in views	SQL	V13_1__B2BOX5-1540_Rename_WFWorkItem_to_WorkflowTask_in_views.sql	142754584	b2box	2019-07-09 16:56:55.631853	31	t
15	14	B2BOX5-1839 Simplify counter view	SQL	V14__B2BOX5-1839_Simplify_counter_view.sql	2110665982	b2box	2019-07-09 16:56:55.687712	35	t
16	15	B2BOX5-1901 Add indexes	SQL	V15__B2BOX5-1901_Add_indexes.sql	-1607078097	b2box	2019-07-12 12:36:31.128033	66	t
17	16	B2BOX5-1928 Remove meta table	SQL	V16__B2BOX5-1928_Remove_meta_table.sql	-1060199810	b2box	2019-09-19 14:45:47.956626	67	t
19	18	B2BOX5-1937 Exception migration	SQL	V18__B2BOX5-1937_Exception_migration.sql	1562596096	b2box	2019-09-19 14:45:48.204782	13	t
20	19	B2BOX5-1929 Remove application min-max version	SQL	V19__B2BOX5-1929_Remove_application_min-max_version.sql	-656397094	b2box	2019-09-19 14:45:48.230868	147	t
18	17	B2BOX5-1914 DSL migration	SQL	V17__B2BOX5-1914_DSL_migration.sql	1644579705	b2box	2019-09-19 14:45:48.067897	117	t
21	20	B2BOX5-1822 DSL remove deprecated	SQL	V20__B2BOX5-1822_DSL_remove_deprecated.sql	-1538317084	b2box	2019-09-19 14:45:48.395351	9	t
22	21	B2BOX5-1874 Remove TS Resource type for script	SQL	V21__B2BOX5-1874_Remove_TS_Resource_type_for_script.sql	-1806590714	b2box	2019-10-21 17:02:03.381198	23	t
23	23	B2BOX5-1705 DSL migration	SQL	V23__B2BOX5-1705_DSL_migration.sql	1366299083	b2box	2019-10-21 17:02:03.430765	6	t
24	24	B2BOX5-1995 Remove Autoloaded datamodel	SQL	V24__B2BOX5-1995_Remove_Autoloaded_datamodel.sql	-478008942	b2box	2019-10-21 17:02:03.45305	4	t
25	25	B2BOX5-2004 Item should be enabled by default	SQL	V25__B2BOX5-2004_Item_should_be_enabled_by_default.sql	1455541446	b2box	2019-10-21 17:02:03.468839	128	t
26	26	B2BOX5-2002 Migrate Script DSL	SQL	V26__B2BOX5-2002_Migrate_Script_DSL.sql	-1600785459	b2box	2019-10-21 17:02:03.615834	8	t
27	27	B2BOX5-2008 Migrate Script Items	SQL	V27__B2BOX5-2008_Migrate_Script_Items.sql	122384951	b2box	2019-10-21 17:02:03.634207	5	t
28	28	B2BOX5-2016 Migrate Variable Names	SQL	V28__B2BOX5-2016_Migrate_Variable_Names.sql	-548187125	b2box	2020-01-10 11:43:55.194265	39	t
29	29	B2BOX5-2052-Remove enabled attribute	SQL	V29__B2BOX5-2052-Remove_enabled_attribute.sql	-278415559	b2box	2020-01-10 11:43:55.26231	183	t
30	30	B2BOX5-2059 Remove p6rest registration	SQL	V30__B2BOX5-2059_Remove_p6rest_registration.sql	1031885722	b2box	2020-01-10 11:43:55.526183	8	t
31	31	B2BOX5-2048 Create instancedata table	SQL	V31__B2BOX5-2048_Create_instancedata_table.sql	-2118184683	b2box	2020-02-20 18:14:02.649568	31	t
32	32	B2BOX5-2100 Simplify table field	SQL	V32__B2BOX5-2100_Simplify_table_field.sql	1117258956	b2box	2020-02-20 18:14:02.696593	5	t
33	33	P6CORE-28 TransactionMessage xpath indexes	SQL	V33__P6CORE-28_TransactionMessage_xpath_indexes.sql	453706835	b2box	2020-03-25 17:30:36.086775	37	t
34	34	P6CORE-216 Remove unused datasource attributes	SQL	V34__P6CORE-216_Remove_unused_datasource_attributes.sql	-1034506901	b2box	2020-03-25 17:30:36.136025	3	t
35	35	P6CORE-126 b2box to p6core	SQL	V35__P6CORE-126_b2box_to_p6core.sql	338269797	b2box	2020-04-01 20:20:47.28884	15	t
36	36	P6CORE-241 remove views type	SQL	V36__P6CORE-241_remove_views_type.sql	-1823806519	b2box	2020-04-01 20:20:47.318573	4	t
37	37	P6CORE-245 ContentType from b2box to p6core	SQL	V37__P6CORE-245_ContentType_from_b2box_to_p6core.sql	432647329	b2box	2020-04-01 20:20:47.335151	37	t
\.


--
-- Data for Name: instancedata; Type: TABLE DATA; Schema: p6core; Owner: b2box
--

COPY p6core.instancedata (application, service, type, content) FROM stdin;
\.


--
-- Data for Name: log; Type: TABLE DATA; Schema: p6core; Owner: b2box
--

COPY p6core.log (datapartition, datatype, iid1, iid2, iid3, iid4, content, inserttime) FROM stdin;
\.


--
-- Data for Name: rawbytes; Type: TABLE DATA; Schema: p6core; Owner: b2box
--

COPY p6core.rawbytes (id1, id2, content, inserttime) FROM stdin;
\.


--
-- Data for Name: serviceconfig; Type: TABLE DATA; Schema: p6core; Owner: b2box
--

COPY p6core.serviceconfig (id1, id2, id3, content, bytes, inserttime) FROM stdin;
Default		email	{"name": "Default", "type": "JAVAMAIL", "appKey": "", "revisionId": "edf7ea27e3c35e3c0071e669e34d1d98", "contentMode": "NONE", "description": {"EN": "Default email profile"}, "defaultProfile": true, "lastModifiedBy": "admin@amalto.com", "lastModifiedDate": 1548169368257, "configurationProperties": {}}	\N	1548169368271
_logging_event		datamodels	{"name": "_logging_event", "appKey": "", "schema": "<xsd:schema xmlns:xsd=\\"http://www.w3.org/2001/XMLSchema\\" attributeFormDefault=\\"unqualified\\" blockDefault=\\"\\" elementFormDefault=\\"qualified\\" finalDefault=\\"\\">\\n\\n    <xsd:element abstract=\\"false\\" name=\\"logging_event\\" nillable=\\"false\\">\\n        <xsd:complexType mixed=\\"false\\">\\n            <xsd:sequence maxOccurs=\\"1\\" minOccurs=\\"1\\">\\n                <xsd:element maxOccurs=\\"1\\" minOccurs=\\"1\\" name=\\"id\\" nillable=\\"false\\" type=\\"xsd:string\\"/>\\n                <xsd:element maxOccurs=\\"1\\" minOccurs=\\"1\\" name=\\"time\\" nillable=\\"false\\" type=\\"xsd:string\\"/>\\n                <xsd:element maxOccurs=\\"1\\" minOccurs=\\"1\\" name=\\"level\\" nillable=\\"false\\" type=\\"xsd:string\\"/>\\n                <xsd:element maxOccurs=\\"1\\" minOccurs=\\"1\\" name=\\"logger\\" nillable=\\"false\\" type=\\"xsd:string\\"/>\\n                <xsd:element maxOccurs=\\"1\\" minOccurs=\\"1\\" name=\\"message\\" nillable=\\"false\\" type=\\"xsd:string\\"/>\\n                <xsd:element maxOccurs=\\"1\\" minOccurs=\\"1\\" name=\\"ndc\\" nillable=\\"false\\" type=\\"xsd:string\\"/>\\n                <xsd:element maxOccurs=\\"1\\" minOccurs=\\"1\\" name=\\"thread\\" nillable=\\"false\\" type=\\"xsd:string\\"/>\\n                <xsd:element maxOccurs=\\"1\\" minOccurs=\\"0\\" name=\\"throwable\\" nillable=\\"false\\" type=\\"xsd:string\\"/>\\n            </xsd:sequence>\\n        </xsd:complexType>\\n        <xsd:unique name=\\"logging_event\\">\\n            <xsd:selector xpath=\\".\\"/>\\n            <xsd:field xpath=\\"time\\"/>\\n        </xsd:unique>\\n    </xsd:element>\\n\\n\\n</xsd:schema>", "revisionId": "92330d48ae06ac2623bca161872d6cf0", "contentMode": "NONE", "description": {"EN": " Logging events (formerly named .logging_event)"}, "lastModifiedBy": "admin@amalto.com", "lastModifiedDate": 1538389926868}	\N	1538389926969
Logging Event		views	{"name": "Logging Event", "appKey": "", "xmlView": "<View>\\n    <SmartTags/>\\n    <DataType>logging_event</DataType>\\n    <DataModel/>\\n    <DataPartition>LOG</DataPartition>\\n    <ReprocessRouteUri/>\\n    <ListOfKeys>\\n        <Key>\\n            <Name>ID</Name>\\n            <Description>\\n                <EN>Id</EN>\\n                <FR>Identifiant</FR>\\n            </Description>\\n            <XPath>logging_event/id</XPath>\\n        </Key>\\n    </ListOfKeys>\\n    <ListOfSearchables>\\n        <Searchable>\\n            <Name>Creation Date</Name>\\n            <Description>\\n                <EN>Creation Date</EN>\\n                <FR>Date de Création</FR>\\n            </Description>\\n            <XPath>logging_event/time</XPath>\\n            <Type>RangeOfDates(yyyy'-'MM'-'dd' 'HH:mm:ss.S z)</Type>\\n        </Searchable>\\n        <Searchable>\\n            <Name>ID</Name>\\n            <Description>\\n                <EN>ID</EN>\\n                <FR>Identifiant</FR>\\n            </Description>\\n            <XPath>logging_event/id</XPath>\\n            <Type>StringContains</Type>\\n        </Searchable>\\n        <Searchable>\\n            <Name>Logger</Name>\\n            <Description>\\n                <EN>Logger</EN>\\n                <FR>logger</FR>\\n            </Description>\\n            <XPath>logging_event/logger</XPath>\\n            <Type>StringContains</Type>\\n        </Searchable>\\n        <Searchable>\\n            <Name>Message</Name>\\n            <Description>\\n                <EN>Message</EN>\\n                <FR>Message</FR>\\n            </Description>\\n            <XPath>logging_event/message</XPath>\\n            <Type>StringContains</Type>\\n        </Searchable>\\n        <Searchable>\\n            <Name>AnyField</Name>\\n            <Description>\\n                <EN>Contains the words</EN>\\n                <FR>Contient les mots</FR>\\n            </Description>\\n            <XPath>logging_event</XPath>\\n            <Type>StringContains</Type>\\n        </Searchable>\\n    </ListOfSearchables>\\n    <ListOfViewables>\\n        <Viewable>\\n            <Name>Creation Date</Name>\\n            <Description>\\n                <EN>Creation Date</EN>\\n                <FR>Date de Création</FR>\\n            </Description>\\n            <XPath>logging_event/time</XPath>\\n            <Type>Date(yyyy'-'MM'-'dd' 'HH:mm:ss.S z)</Type>\\n        </Viewable>\\n        <Viewable>\\n            <Name>ID</Name>\\n            <Description>\\n                <EN>ID</EN>\\n                <FR>Identifiant</FR>\\n            </Description>\\n            <XPath>logging_event/id</XPath>\\n            <Type>String</Type>\\n        </Viewable>\\n        <Viewable>\\n            <Name>Logger</Name>\\n            <Description>\\n                <EN>Logger</EN>\\n                <FR>logger</FR>\\n            </Description>\\n            <XPath>logging_event/logger</XPath>\\n            <Type>String</Type>\\n        </Viewable>\\n        <Viewable>\\n            <Name>Message</Name>\\n            <Description>\\n                <EN>Message</EN>\\n                <FR>Message</FR>\\n            </Description>\\n            <XPath>logging_event/message</XPath>\\n            <Type>String</Type>\\n        </Viewable>\\n        <Viewable>\\n            <Name>Level</Name>\\n            <Description>\\n                <EN>Level</EN>\\n                <FR>Level</FR>\\n            </Description>\\n            <XPath>logging_event/level</XPath>\\n            <Type>String</Type>\\n        </Viewable>\\n    </ListOfViewables>\\n</View>\\n", "revisionId": "efe8acc7d4f399db36d7f501f3487c9c", "contentMode": "NONE", "description": {"EN": "Logging Event", "FR": "Evènement de log"}, "lastModifiedBy": "admin@amalto.com", "lastModifiedDate": 1548267162338}	\N	1548267162347
\.


--
-- Data for Name: table_data; Type: TABLE DATA; Schema: p6core; Owner: b2box
--

COPY p6core.table_data (datapartition, datatype, iid1, iid2, iid3, iid4, content, inserttime) FROM stdin;
\.


--
-- Data for Name: transaction; Type: TABLE DATA; Schema: p6core; Owner: b2box
--

COPY p6core.transaction (datapartition, datatype, iid1, iid2, iid3, iid4, content, inserttime) FROM stdin;
\.


--
-- Name: activeroutingorder activeroutingorder_pkey; Type: CONSTRAINT; Schema: p6core; Owner: b2box
--

ALTER TABLE ONLY p6core.activeroutingorder
    ADD CONSTRAINT activeroutingorder_pkey PRIMARY KEY (name);


--
-- Name: completedroutingorder completedroutingorder_pkey; Type: CONSTRAINT; Schema: p6core; Owner: b2box
--

ALTER TABLE ONLY p6core.completedroutingorder
    ADD CONSTRAINT completedroutingorder_pkey PRIMARY KEY (name);


--
-- Name: failedroutingorder failedroutingorder_pkey; Type: CONSTRAINT; Schema: p6core; Owner: b2box
--

ALTER TABLE ONLY p6core.failedroutingorder
    ADD CONSTRAINT failedroutingorder_pkey PRIMARY KEY (name);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: p6core; Owner: b2box
--

ALTER TABLE ONLY p6core.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: instancedata instance_pkey; Type: CONSTRAINT; Schema: p6core; Owner: b2box
--

ALTER TABLE ONLY p6core.instancedata
    ADD CONSTRAINT instance_pkey PRIMARY KEY (application, service, type);


--
-- Name: transaction item_pkey; Type: CONSTRAINT; Schema: p6core; Owner: b2box
--

ALTER TABLE ONLY p6core.transaction
    ADD CONSTRAINT item_pkey PRIMARY KEY (datapartition, datatype, iid1, iid2, iid3, iid4);


--
-- Name: rawbytes rawbytes_pkey; Type: CONSTRAINT; Schema: p6core; Owner: b2box
--

ALTER TABLE ONLY p6core.rawbytes
    ADD CONSTRAINT rawbytes_pkey PRIMARY KEY (id1, id2);


--
-- Name: serviceconfig serviceconfig_pkey; Type: CONSTRAINT; Schema: p6core; Owner: b2box
--

ALTER TABLE ONLY p6core.serviceconfig
    ADD CONSTRAINT serviceconfig_pkey PRIMARY KEY (id1, id2, id3) WITH (fillfactor='100');


--
-- Name: aro_idx01; Type: INDEX; Schema: p6core; Owner: b2box
--

CREATE INDEX aro_idx01 ON p6core.activeroutingorder USING btree (((public.array_to_string_i((xpath('/routingOrder/timeScheduled//text()'::text, content))::text[], ' '::text))::bigint));


--
-- Name: aro_idx02; Type: INDEX; Schema: p6core; Owner: b2box
--

CREATE INDEX aro_idx02 ON p6core.activeroutingorder USING btree (public.array_to_string_i((xpath('/routingOrder/itemPK/conceptName//text()'::text, content))::text[], ' '::text));


--
-- Name: aro_idx03; Type: INDEX; Schema: p6core; Owner: b2box
--

CREATE INDEX aro_idx03 ON p6core.activeroutingorder USING btree (public.array_to_string_i((xpath('/routingOrder/adapter//text()'::text, content))::text[], ' '::text));


--
-- Name: aro_idx04; Type: INDEX; Schema: p6core; Owner: b2box
--

CREATE INDEX aro_idx04 ON p6core.activeroutingorder USING btree (public.array_to_string_i((xpath('/routingOrder/itemPK/itemIds[1]//text()'::text, content))::text[], ' '::text));


--
-- Name: aro_idx_itempk_datapartition; Type: INDEX; Schema: p6core; Owner: b2box
--

CREATE INDEX aro_idx_itempk_datapartition ON p6core.activeroutingorder USING btree (((public.array_to_string_i((xpath('/routingOrder/itemPK/dataPartitionPK/dataPartition//text()'::text, content, '{}'::text[]))::text[], ' '::text))::character varying(256)));


--
-- Name: cro_idx01; Type: INDEX; Schema: p6core; Owner: b2box
--

CREATE INDEX cro_idx01 ON p6core.completedroutingorder USING btree (((public.array_to_string_i((xpath('/routingOrder/timeLastRunCompleted//text()'::text, content))::text[], ' '::text))::bigint));


--
-- Name: cro_idx02; Type: INDEX; Schema: p6core; Owner: b2box
--

CREATE INDEX cro_idx02 ON p6core.completedroutingorder USING btree (public.array_to_string_i((xpath('/routingOrder/itemPK/conceptName//text()'::text, content))::text[], ' '::text));


--
-- Name: cro_idx03; Type: INDEX; Schema: p6core; Owner: b2box
--

CREATE INDEX cro_idx03 ON p6core.completedroutingorder USING btree (public.array_to_string_i((xpath('/routingOrder/adapter//text()'::text, content))::text[], ' '::text));


--
-- Name: cro_idx04; Type: INDEX; Schema: p6core; Owner: b2box
--

CREATE INDEX cro_idx04 ON p6core.completedroutingorder USING btree (public.array_to_string_i((xpath('/routingOrder/itemPK/itemIds[1]//text()'::text, content))::text[], ' '::text));


--
-- Name: cro_idx_itempk_datapartition; Type: INDEX; Schema: p6core; Owner: b2box
--

CREATE INDEX cro_idx_itempk_datapartition ON p6core.completedroutingorder USING btree (((public.array_to_string_i((xpath('/routingOrder/itemPK/dataPartitionPK/dataPartition//text()'::text, content, '{}'::text[]))::text[], ' '::text))::character varying(256)));


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: p6core; Owner: b2box
--

CREATE INDEX flyway_schema_history_s_idx ON p6core.flyway_schema_history USING btree (success);


--
-- Name: fro_idx01; Type: INDEX; Schema: p6core; Owner: b2box
--

CREATE INDEX fro_idx01 ON p6core.failedroutingorder USING btree (((public.array_to_string_i((xpath('/routingOrder/timeLastRunCompleted//text()'::text, content))::text[], ' '::text))::bigint));


--
-- Name: fro_idx02; Type: INDEX; Schema: p6core; Owner: b2box
--

CREATE INDEX fro_idx02 ON p6core.failedroutingorder USING btree (public.array_to_string_i((xpath('/routingOrder/itemPK/conceptName//text()'::text, content))::text[], ' '::text));


--
-- Name: fro_idx03; Type: INDEX; Schema: p6core; Owner: b2box
--

CREATE INDEX fro_idx03 ON p6core.failedroutingorder USING btree (public.array_to_string_i((xpath('/routingOrder/adapter//text()'::text, content))::text[], ' '::text));


--
-- Name: fro_idx04; Type: INDEX; Schema: p6core; Owner: b2box
--

CREATE INDEX fro_idx04 ON p6core.failedroutingorder USING btree (public.array_to_string_i((xpath('/routingOrder/itemPK/itemIds[1]//text()'::text, content))::text[], ' '::text));


--
-- Name: fro_idx_itempk_datapartition; Type: INDEX; Schema: p6core; Owner: b2box
--

CREATE INDEX fro_idx_itempk_datapartition ON p6core.failedroutingorder USING btree (((public.array_to_string_i((xpath('/routingOrder/itemPK/dataPartitionPK/dataPartition//text()'::text, content, '{}'::text[]))::text[], ' '::text))::character varying(256)));


--
-- Name: fts_aro_idx; Type: INDEX; Schema: p6core; Owner: b2box
--

CREATE INDEX fts_aro_idx ON p6core.activeroutingorder USING gist (to_tsvector('english'::regconfig, public.array_to_string_i((xpath('/routingOrder//text()'::text, content))::text[], ' '::text)));


--
-- Name: fts_cro_idx; Type: INDEX; Schema: p6core; Owner: b2box
--

CREATE INDEX fts_cro_idx ON p6core.completedroutingorder USING gist (to_tsvector('english'::regconfig, public.array_to_string_i((xpath('/routingOrder//text()'::text, content))::text[], ' '::text)));


--
-- Name: fts_fro_idx; Type: INDEX; Schema: p6core; Owner: b2box
--

CREATE INDEX fts_fro_idx ON p6core.failedroutingorder USING gist (to_tsvector('english'::regconfig, public.array_to_string_i((xpath('/routingOrder//text()'::text, content))::text[], ' '::text)));


--
-- Name: instance_idx_application_type; Type: INDEX; Schema: p6core; Owner: b2box
--

CREATE INDEX instance_idx_application_type ON p6core.instancedata USING btree (application, type);


--
-- Name: instance_idx_content; Type: INDEX; Schema: p6core; Owner: b2box
--

CREATE INDEX instance_idx_content ON p6core.instancedata USING btree (content);


--
-- Name: item_idx01; Type: INDEX; Schema: p6core; Owner: b2box
--

CREATE INDEX item_idx01 ON p6core.transaction USING btree (datapartition);


--
-- Name: item_idx02; Type: INDEX; Schema: p6core; Owner: b2box
--

CREATE INDEX item_idx02 ON p6core.transaction USING btree (datatype);


--
-- Name: item_mi_fts_idx01; Type: INDEX; Schema: p6core; Owner: b2box
--

CREATE INDEX item_mi_fts_idx01 ON p6core.transaction USING gist (to_tsvector('english'::regconfig, public.array_to_string_i((xpath('/MessageInfo//text()'::text, content))::text[], ' '::text))) WHERE ((datapartition = 'TRANSACTION'::p6core.itempartitiontype) AND ((datatype)::text = 'TransactionInfo'::text));


--
-- Name: item_mi_fts_idx02; Type: INDEX; Schema: p6core; Owner: b2box
--

CREATE INDEX item_mi_fts_idx02 ON p6core.transaction USING gist (to_tsvector('english'::regconfig, public.array_to_string_i((xpath('/MessageInfo/CreationDate//text()'::text, content))::text[], ' '::text))) WHERE ((datapartition = 'TRANSACTION'::p6core.itempartitiontype) AND ((datatype)::text = 'TransactionInfo'::text));


--
-- Name: item_mi_fts_idx03; Type: INDEX; Schema: p6core; Owner: b2box
--

CREATE INDEX item_mi_fts_idx03 ON p6core.transaction USING gist (to_tsvector('english'::regconfig, public.array_to_string_i((xpath('/MessageInfo/BusinessDocName//text()'::text, content))::text[], ' '::text))) WHERE ((datapartition = 'TRANSACTION'::p6core.itempartitiontype) AND ((datatype)::text = 'TransactionInfo'::text));


--
-- Name: item_mi_fts_idx04; Type: INDEX; Schema: p6core; Owner: b2box
--

CREATE INDEX item_mi_fts_idx04 ON p6core.transaction USING gist (to_tsvector('english'::regconfig, public.array_to_string_i((xpath('/MessageInfo/BusinessDocNumber//text()'::text, content))::text[], ' '::text))) WHERE ((datapartition = 'TRANSACTION'::p6core.itempartitiontype) AND ((datatype)::text = 'TransactionInfo'::text));


--
-- Name: item_mi_fts_idx05; Type: INDEX; Schema: p6core; Owner: b2box
--

CREATE INDEX item_mi_fts_idx05 ON p6core.transaction USING gist (to_tsvector('english'::regconfig, public.array_to_string_i((xpath('/MessageInfo/LastStatusCode//text()'::text, content))::text[], ' '::text))) WHERE ((datapartition = 'TRANSACTION'::p6core.itempartitiontype) AND ((datatype)::text = 'TransactionInfo'::text));


--
-- Name: item_mi_idx01; Type: INDEX; Schema: p6core; Owner: b2box
--

CREATE INDEX item_mi_idx01 ON p6core.transaction USING btree (((public.array_to_string_i((xpath('/MessageInfo/CreationDate//text()'::text, content))::text[], ' '::text))::character varying(256))) WHERE ((datapartition = 'TRANSACTION'::p6core.itempartitiontype) AND ((datatype)::text = 'TransactionInfo'::text));


--
-- Name: item_mi_idx02; Type: INDEX; Schema: p6core; Owner: b2box
--

CREATE INDEX item_mi_idx02 ON p6core.transaction USING btree (((public.array_to_string_i((xpath('/MessageInfo/BusinessDocName//text()'::text, content))::text[], ' '::text))::character varying(256))) WHERE ((datapartition = 'TRANSACTION'::p6core.itempartitiontype) AND ((datatype)::text = 'TransactionInfo'::text));


--
-- Name: item_mi_idx03; Type: INDEX; Schema: p6core; Owner: b2box
--

CREATE INDEX item_mi_idx03 ON p6core.transaction USING btree (((public.array_to_string_i((xpath('/MessageInfo/BusinessDocNumber//text()'::text, content))::text[], ' '::text))::character varying(256))) WHERE ((datapartition = 'TRANSACTION'::p6core.itempartitiontype) AND ((datatype)::text = 'TransactionInfo'::text));


--
-- Name: item_mi_idx04; Type: INDEX; Schema: p6core; Owner: b2box
--

CREATE INDEX item_mi_idx04 ON p6core.transaction USING btree (((public.array_to_string_i((xpath('/MessageInfo/LastStatusCode//text()'::text, content))::text[], ' '::text))::character varying(256))) WHERE ((datapartition = 'TRANSACTION'::p6core.itempartitiontype) AND ((datatype)::text = 'TransactionInfo'::text));


--
-- Name: item_ti_fts_idx01; Type: INDEX; Schema: p6core; Owner: b2box
--

CREATE INDEX item_ti_fts_idx01 ON p6core.transaction USING gist (to_tsvector('english'::regconfig, public.array_to_string_i((xpath('/TransactionInfo//text()'::text, content))::text[], ' '::text))) WHERE ((datatype)::text = 'TransactionInfo'::text);


--
-- Name: item_ti_fts_idx02; Type: INDEX; Schema: p6core; Owner: b2box
--

CREATE INDEX item_ti_fts_idx02 ON p6core.transaction USING gist (to_tsvector('english'::regconfig, public.array_to_string_i((xpath('/TransactionInfo/CreationDate//text()'::text, content))::text[], ' '::text))) WHERE ((datatype)::text = 'TransactionInfo'::text);


--
-- Name: item_ti_fts_idx03; Type: INDEX; Schema: p6core; Owner: b2box
--

CREATE INDEX item_ti_fts_idx03 ON p6core.transaction USING gist (to_tsvector('english'::regconfig, public.array_to_string_i((xpath('/TransactionInfo/BusinessDocName//text()'::text, content))::text[], ' '::text))) WHERE ((datatype)::text = 'TransactionInfo'::text);


--
-- Name: item_ti_fts_idx04; Type: INDEX; Schema: p6core; Owner: b2box
--

CREATE INDEX item_ti_fts_idx04 ON p6core.transaction USING gist (to_tsvector('english'::regconfig, public.array_to_string_i((xpath('/TransactionInfo/BusinessDocNumber//text()'::text, content))::text[], ' '::text))) WHERE ((datatype)::text = 'TransactionInfo'::text);


--
-- Name: item_ti_fts_idx05; Type: INDEX; Schema: p6core; Owner: b2box
--

CREATE INDEX item_ti_fts_idx05 ON p6core.transaction USING gist (to_tsvector('english'::regconfig, public.array_to_string_i((xpath('/TransactionInfo/LastStatusCode//text()'::text, content))::text[], ' '::text))) WHERE ((datatype)::text = 'TransactionInfo'::text);


--
-- Name: item_ti_idx01; Type: INDEX; Schema: p6core; Owner: b2box
--

CREATE INDEX item_ti_idx01 ON p6core.transaction USING btree (((public.array_to_string_i((xpath('/TransactionInfo/CreationDate//text()'::text, content))::text[], ' '::text))::character varying(256))) WHERE ((datatype)::text = 'TransactionInfo'::text);


--
-- Name: item_ti_idx02; Type: INDEX; Schema: p6core; Owner: b2box
--

CREATE INDEX item_ti_idx02 ON p6core.transaction USING btree (((public.array_to_string_i((xpath('/TransactionInfo/BusinessDocName//text()'::text, content))::text[], ' '::text))::character varying(256))) WHERE ((datatype)::text = 'TransactionInfo'::text);


--
-- Name: item_ti_idx03; Type: INDEX; Schema: p6core; Owner: b2box
--

CREATE INDEX item_ti_idx03 ON p6core.transaction USING btree (((public.array_to_string_i((xpath('/TransactionInfo/BusinessDocNumber//text()'::text, content))::text[], ' '::text))::character varying(256))) WHERE ((datatype)::text = 'TransactionInfo'::text);


--
-- Name: item_ti_idx04; Type: INDEX; Schema: p6core; Owner: b2box
--

CREATE INDEX item_ti_idx04 ON p6core.transaction USING btree (((public.array_to_string_i((xpath('/TransactionInfo/LastStatusCode//text()'::text, content))::text[], ' '::text))::character varying(256))) WHERE ((datatype)::text = 'TransactionInfo'::text);


--
-- Name: log_datatype_idx; Type: INDEX; Schema: p6core; Owner: b2box
--

CREATE INDEX log_datatype_idx ON p6core.log USING btree (datatype);


--
-- Name: sconfigjson_idx01; Type: INDEX; Schema: p6core; Owner: b2box
--

CREATE INDEX sconfigjson_idx01 ON p6core.serviceconfig USING gin (content jsonb_path_ops);


--
-- Name: table_data_datatype_idx; Type: INDEX; Schema: p6core; Owner: b2box
--

CREATE INDEX table_data_datatype_idx ON p6core.table_data USING btree (datatype);


--
-- Name: xrocswyd3g5rejujxo; Type: INDEX; Schema: p6core; Owner: b2box
--

CREATE INDEX xrocswyd3g5rejujxo ON p6core.table_data USING btree (public.array_to_string_i((xpath('/DUNS_Internal/DUNSNumber//text()'::text, content))::text[], ' '::text)) WHERE ((datapartition = 'TABLE_DATA'::p6core.itempartitiontype) AND ((datatype)::text = 'DUNS_Internal'::text));


--
-- Name: xrvlaoi4elt5bbntlz; Type: INDEX; Schema: p6core; Owner: b2box
--

CREATE INDEX xrvlaoi4elt5bbntlz ON p6core.table_data USING btree (public.array_to_string_i((xpath('/DUNS_Customers/DUNSNumber//text()'::text, content))::text[], ' '::text)) WHERE ((datapartition = 'TABLE_DATA'::p6core.itempartitiontype) AND ((datatype)::text = 'DUNS_Customers'::text));


--
-- Name: DATABASE b2box; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON DATABASE b2box TO b2box;


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 11.7
-- Dumped by pg_dump version 11.7

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

DROP DATABASE postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE postgres OWNER TO postgres;

\connect postgres

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

--
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: b2head; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA b2head;


ALTER SCHEMA b2head OWNER TO postgres;

--
-- Name: tablefunc; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS tablefunc WITH SCHEMA public;


--
-- Name: EXTENSION tablefunc; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION tablefunc IS 'functions that manipulate whole tables, including crosstab';


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

