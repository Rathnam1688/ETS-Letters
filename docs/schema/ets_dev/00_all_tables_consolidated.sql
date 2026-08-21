-- ets_dev consolidated schema — generated from Oracle NHMMIS52E2/NDMMIS73E2/NDMMIS75E2
-- and TXT2SQL_APP sources, converted to Postgres dialect and unified under a single
-- schema per explicit direction (structures assumed equivalent across state instances).
-- NOT independently verified against a live database. See README.md in this folder.

CREATE SCHEMA IF NOT EXISTS ets_dev;

-- ======================================================================
-- Source: G_ADR_TB.sql
-- ======================================================================
--------------------------------------------------------
--  DDL for Table G_ADR_TB
--------------------------------------------------------

  CREATE TABLE "ets_dev"."G_ADR_TB"
   (	"G_ADR_SK" BIGINT,
	"G_LINE1_ADR" VARCHAR(64),
	"G_LINE2_ADR" VARCHAR(64),
	"G_LINE3_ADR" VARCHAR(64),
	"G_LINE4_ADR" VARCHAR(64),
	"G_CITY_NAM" VARCHAR(30),
	"G_TOWN_CD" VARCHAR(3),
	"G_US_STATE_CD" VARCHAR(2),
	"G_ZIP5_CD" VARCHAR(5),
	"G_ZIP4_CD" VARCHAR(4),
	"G_CNTRY_CD" VARCHAR(3),
	"G_CNTY_CD" VARCHAR(5),
	"G_USPS_ADR_VRFY_CD" VARCHAR(2),
	"G_USPS_LINE1_ADR" VARCHAR(64),
	"G_USPS_LINE2_ADR" VARCHAR(64),
	"G_LAT_NUM" NUMERIC(7,4),
	"G_LON_NUM" NUMERIC(7,4),
	"G_CMN_ENTY_TY_CD" VARCHAR(2),
	"G_DSTCT_OFC_CD" VARCHAR(2),
	"L_HIBERNATE_VER_NUM" INTEGER DEFAULT 0,
	"G_AUD_USER_ID" VARCHAR(30),
	"G_AUD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_AUD_ADD_USER_ID" VARCHAR(30),
	"G_AUD_ADD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_DUMMY_IND" VARCHAR(1) DEFAULT 'N',
	"G_DUMMY_TS" TIMESTAMP,
	"G_DUMMY_USER_ID" VARCHAR(30)
   );

   COMMENT ON COLUMN "ets_dev"."G_ADR_TB"."G_ADR_SK" IS 'Integer value that uniquely identifies each address row.';
   COMMENT ON COLUMN "ets_dev"."G_ADR_TB"."G_LINE1_ADR" IS 'Address line 1.';
   COMMENT ON COLUMN "ets_dev"."G_ADR_TB"."G_LINE2_ADR" IS 'Address line 2. ';
   COMMENT ON COLUMN "ets_dev"."G_ADR_TB"."G_LINE3_ADR" IS 'Address line 3.';
   COMMENT ON COLUMN "ets_dev"."G_ADR_TB"."G_LINE4_ADR" IS 'Address line 4.';
   COMMENT ON COLUMN "ets_dev"."G_ADR_TB"."G_CITY_NAM" IS 'City Name';
   COMMENT ON COLUMN "ets_dev"."G_ADR_TB"."G_US_STATE_CD" IS 'USPS State Code.';
   COMMENT ON COLUMN "ets_dev"."G_ADR_TB"."G_ZIP5_CD" IS 'Zip5 Code (Length of 5)';
   COMMENT ON COLUMN "ets_dev"."G_ADR_TB"."G_ZIP4_CD" IS 'Zip4 Code (Length of 4)';
   COMMENT ON COLUMN "ets_dev"."G_ADR_TB"."G_USPS_LINE1_ADR" IS 'Verfified USPS address.  Will conform to the output parameters of the call to Geostan.';
   COMMENT ON COLUMN "ets_dev"."G_ADR_TB"."G_USPS_LINE2_ADR" IS 'Verfified USPS address.  Will conform to the output parameters of the call to Geostan.';
   COMMENT ON COLUMN "ets_dev"."G_ADR_TB"."G_LAT_NUM" IS 'Latitude of the address.  The value will be null if the address cannot be validated (per GeoStan as per 12/13/06).';
   COMMENT ON COLUMN "ets_dev"."G_ADR_TB"."G_LON_NUM" IS 'Latitude of the address.  The value will be null if the address cannot be validated (per GeoStan as per 12/13/06).';
   COMMENT ON COLUMN "ets_dev"."G_ADR_TB"."L_HIBERNATE_VER_NUM" IS 'This supports hibernate caching mechanism and also supports the pessimistic Locking mechanism';
   COMMENT ON COLUMN "ets_dev"."G_ADR_TB"."G_AUD_USER_ID" IS 'The user ID or process that last modified the row.';
   COMMENT ON COLUMN "ets_dev"."G_ADR_TB"."G_AUD_TS" IS 'The timestamp when the row was last modified.';
   COMMENT ON COLUMN "ets_dev"."G_ADR_TB"."G_AUD_ADD_USER_ID" IS 'The user ID or process that added the row.';
   COMMENT ON COLUMN "ets_dev"."G_ADR_TB"."G_AUD_ADD_TS" IS 'The timestamp when the row was added.';
   COMMENT ON TABLE "ets_dev"."G_ADR_TB"  IS 'The General Address Table is used to store addresses for all types of entties throughout the Enterprise system.';


-- ======================================================================
-- Source: G_ADR_USG_TB.sql
-- ======================================================================
--------------------------------------------------------
--  DDL for Table G_ADR_USG_TB
--------------------------------------------------------

  CREATE TABLE "ets_dev"."G_ADR_USG_TB"
   (	"G_CMN_ENTY_SK" BIGINT,
	"G_ADR_USG_TY_CD" VARCHAR(2),
	"G_ADR_SK" BIGINT,
	"G_ADR_USG_SEQ_NUM" INTEGER,
	"G_ADR_GLBL_SIG_CD" VARCHAR(2),
	"G_ADR_USG_TY_SIG_CD" VARCHAR(2),
	"G_ADR_USG_CHG_RSN_CD" VARCHAR(2),
	"G_ADR_USG_STAT_CD" VARCHAR(2),
	"G_ADR_USG_END_DT" TIMESTAMP,
	"G_ADR_USG_BEG_DT" TIMESTAMP,
	"G_ATTN_NAM" VARCHAR(50),
	"L_HIBERNATE_VER_NUM" INTEGER DEFAULT 0,
	"G_AUD_USER_ID" VARCHAR(30),
	"G_AUD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_AUD_ADD_USER_ID" VARCHAR(30),
	"G_AUD_ADD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_DUMMY_IND" VARCHAR(1) DEFAULT 'N',
	"G_DUMMY_TS" TIMESTAMP,
	"G_DUMMY_USER_ID" VARCHAR(30)
   );

   COMMENT ON COLUMN "ets_dev"."G_ADR_USG_TB"."G_CMN_ENTY_SK" IS 'Surrogate Key for the Common Entity.  This value may be referred to as Payer ID on some UI screens.';
   COMMENT ON COLUMN "ets_dev"."G_ADR_USG_TB"."G_ADR_USG_TY_CD" IS 'Member
  Residential
  Mailing
Provider
  Service Location
  Billing
  Mailing
Carrier
  Corporate
  Billing
  Payment';
   COMMENT ON COLUMN "ets_dev"."G_ADR_USG_TB"."G_ADR_SK" IS 'Surrogate Key';
   COMMENT ON COLUMN "ets_dev"."G_ADR_USG_TB"."G_ADR_USG_SEQ_NUM" IS 'Sequence Number';
   COMMENT ON COLUMN "ets_dev"."G_ADR_USG_TB"."G_ADR_GLBL_SIG_CD" IS 'Primary, Secondary, Tertiary among all addresses for a CE.';
   COMMENT ON COLUMN "ets_dev"."G_ADR_USG_TB"."G_ADR_USG_TY_SIG_CD" IS 'P    Primary
S    Secondary
T    Tertiary
within Address Usage Type.';
   COMMENT ON COLUMN "ets_dev"."G_ADR_USG_TB"."G_ADR_USG_CHG_RSN_CD" IS 'Explains the reason for the Address Usage being changed.
R    Returned mail
I    Incorrect';
   COMMENT ON COLUMN "ets_dev"."G_ADR_USG_TB"."G_ADR_USG_STAT_CD" IS 'V    Void
P    Pending
A    Active
D    Deactivated
';
   COMMENT ON COLUMN "ets_dev"."G_ADR_USG_TB"."G_ADR_USG_END_DT" IS 'Initially set to ''12-31-9999''.
This column can be used to record when the current date ceases to be effective.  This can be used with or without the Address History table.';
   COMMENT ON COLUMN "ets_dev"."G_ADR_USG_TB"."G_ADR_USG_BEG_DT" IS 'By default, set to sysdate when the row is created.';
   COMMENT ON COLUMN "ets_dev"."G_ADR_USG_TB"."L_HIBERNATE_VER_NUM" IS 'This supports hibernate caching mechanism and also supports the pessimistic Locking mechanism';
   COMMENT ON COLUMN "ets_dev"."G_ADR_USG_TB"."G_AUD_USER_ID" IS 'The user ID or process that last modified the row.';
   COMMENT ON COLUMN "ets_dev"."G_ADR_USG_TB"."G_AUD_TS" IS 'The timestamp when the row was last modified.';
   COMMENT ON COLUMN "ets_dev"."G_ADR_USG_TB"."G_AUD_ADD_USER_ID" IS 'The user ID or process that added the row.';
   COMMENT ON COLUMN "ets_dev"."G_ADR_USG_TB"."G_AUD_ADD_TS" IS 'The timestamp when the row was added.';
   COMMENT ON COLUMN "ets_dev"."G_ADR_USG_TB"."G_DUMMY_IND" IS 'Global Indicator';
   COMMENT ON TABLE "ets_dev"."G_ADR_USG_TB"  IS 'Address Usage Table';


-- ======================================================================
-- Source: G_CMN_ENTY_REP_XREF_TB.sql
-- ======================================================================
--------------------------------------------------------
--  DDL for Table G_CMN_ENTY_REP_XREF_TB
--------------------------------------------------------

  CREATE TABLE "ets_dev"."G_CMN_ENTY_REP_XREF_TB"
   (	"G_CMN_ENTY_SK" BIGINT,
	"G_REP_SK" BIGINT,
	"G_REP_XREF_TY_CD" VARCHAR(2),
	"G_BEG_DT" TIMESTAMP DEFAULT '01-JAN-0001',
	"G_END_DT" TIMESTAMP DEFAULT '31-DEC-9999',
	"G_CMN_ENTY_REP_SIG_CD" VARCHAR(2),
	"G_REL_CD" VARCHAR(3),
	"G_CMN_ENTY_REP_XREF_STAT_CD" VARCHAR(2),
	"L_HIBERNATE_VER_NUM" INTEGER DEFAULT 0,
	"G_AUD_USER_ID" VARCHAR(30),
	"G_AUD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_AUD_ADD_USER_ID" VARCHAR(30),
	"G_AUD_ADD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_DUMMY_IND" VARCHAR(1) DEFAULT 'N',
	"G_DUMMY_TS" TIMESTAMP,
	"G_DUMMY_USER_ID" VARCHAR(30)
   );

   COMMENT ON COLUMN "ets_dev"."G_CMN_ENTY_REP_XREF_TB"."G_CMN_ENTY_SK" IS 'Surrogate Key for the Common Entity.  This value may be referred to as Payer ID on some UI screens.';
   COMMENT ON COLUMN "ets_dev"."G_CMN_ENTY_REP_XREF_TB"."G_REP_SK" IS 'Surrogate Key';
   COMMENT ON COLUMN "ets_dev"."G_CMN_ENTY_REP_XREF_TB"."G_REP_XREF_TY_CD" IS 'Defines the type of representative for any type of Common Entity.

For SA - Presumptive Member, Requesting Office, Alternate Addressee

For Provider - RA contact, Authorized Rep, Managing Employee, Pharmacist in charge.

For Member - Absent Parent, Custodial Parent.

For Member Case - Head of Household, Authorized Rep.

For TPL Carrier - Contact.

For Acuity - Facility Administrator (maybe in Provider''s system list)';
   COMMENT ON COLUMN "ets_dev"."G_CMN_ENTY_REP_XREF_TB"."G_BEG_DT" IS 'Common Entity Representative Begin Date';
   COMMENT ON COLUMN "ets_dev"."G_CMN_ENTY_REP_XREF_TB"."G_END_DT" IS 'Common Entitiy Represenative End Date';
   COMMENT ON COLUMN "ets_dev"."G_CMN_ENTY_REP_XREF_TB"."G_CMN_ENTY_REP_SIG_CD" IS 'Common Entity Representative Significance Code';
   COMMENT ON COLUMN "ets_dev"."G_CMN_ENTY_REP_XREF_TB"."G_REL_CD" IS 'Generally used for family relationships.  Generally, these represent dependent relationships of the provider.

e.g. Child, Grandmother, Spouse, Parent ';
   COMMENT ON COLUMN "ets_dev"."G_CMN_ENTY_REP_XREF_TB"."G_CMN_ENTY_REP_XREF_STAT_CD" IS 'Common Entity Represenative XREF Status Code';
   COMMENT ON COLUMN "ets_dev"."G_CMN_ENTY_REP_XREF_TB"."L_HIBERNATE_VER_NUM" IS 'This supports hibernate caching mechanism and also supports the pessimistic Locking mechanism';
   COMMENT ON COLUMN "ets_dev"."G_CMN_ENTY_REP_XREF_TB"."G_AUD_USER_ID" IS 'The user ID or process that last modified the row.';
   COMMENT ON COLUMN "ets_dev"."G_CMN_ENTY_REP_XREF_TB"."G_AUD_TS" IS 'The timestamp when the row was last modified.';
   COMMENT ON COLUMN "ets_dev"."G_CMN_ENTY_REP_XREF_TB"."G_AUD_ADD_USER_ID" IS 'The user ID or process that added the row.';
   COMMENT ON COLUMN "ets_dev"."G_CMN_ENTY_REP_XREF_TB"."G_AUD_ADD_TS" IS 'The timestamp when the row was added.';
   COMMENT ON TABLE "ets_dev"."G_CMN_ENTY_REP_XREF_TB"  IS 'The Common Entity Represenative Xref Table provides a many-to-many association between Common Entity and Common Entity Rep.';


-- ======================================================================
-- Source: G_CMN_ENTY_TB.sql
-- ======================================================================
--------------------------------------------------------
--  DDL for Table G_CMN_ENTY_TB
--------------------------------------------------------

  CREATE TABLE "ets_dev"."G_CMN_ENTY_TB"
   (	"G_CMN_ENTY_SK" BIGINT,
	"G_PREFRD_COMMUN_MTHD_CD" VARCHAR(2),
	"G_SEC_COMMUN_MTHD_CD" VARCHAR(2),
	"G_CMN_ENTY_TY_CD" VARCHAR(2),
	"G_VOID_IND" VARCHAR(1),
	"G_NOTE_SET_SK" BIGINT,
	"L_HIBERNATE_VER_NUM" INTEGER DEFAULT 0,
	"G_AUD_USER_ID" VARCHAR(30),
	"G_AUD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_AUD_ADD_USER_ID" VARCHAR(30),
	"G_AUD_ADD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_DUMMY_IND" VARCHAR(1) DEFAULT 'N',
	"G_DUMMY_TS" TIMESTAMP,
	"G_DUMMY_USER_ID" VARCHAR(30)
   );

   COMMENT ON COLUMN "ets_dev"."G_CMN_ENTY_TB"."G_CMN_ENTY_SK" IS 'Surrogate Key for the Common Entity.  This value may be referred to as Payer ID on some UI screens.';
   COMMENT ON COLUMN "ets_dev"."G_CMN_ENTY_TB"."G_PREFRD_COMMUN_MTHD_CD" IS 'F    FAX
P    Phone
M    US Mail
E    Email';
   COMMENT ON COLUMN "ets_dev"."G_CMN_ENTY_TB"."G_SEC_COMMUN_MTHD_CD" IS 'F    FAX
P    Phone
M    US Mail
E    Email';
   COMMENT ON COLUMN "ets_dev"."G_CMN_ENTY_TB"."G_CMN_ENTY_TY_CD" IS 'e.g. Member, Provider, TPL, Contact Management, etc.';
   COMMENT ON COLUMN "ets_dev"."G_CMN_ENTY_TB"."G_VOID_IND" IS 'Void Indicator';
   COMMENT ON COLUMN "ets_dev"."G_CMN_ENTY_TB"."G_NOTE_SET_SK" IS 'Surrogate Key';
   COMMENT ON COLUMN "ets_dev"."G_CMN_ENTY_TB"."L_HIBERNATE_VER_NUM" IS 'This supports hibernate caching mechanism and also supports the pessimistic Locking mechanism';
   COMMENT ON COLUMN "ets_dev"."G_CMN_ENTY_TB"."G_AUD_USER_ID" IS 'The user ID or process that last modified the row.';
   COMMENT ON COLUMN "ets_dev"."G_CMN_ENTY_TB"."G_AUD_TS" IS 'The timestamp when the row was last modified.';
   COMMENT ON COLUMN "ets_dev"."G_CMN_ENTY_TB"."G_AUD_ADD_USER_ID" IS 'The user ID or process that added the row.';
   COMMENT ON COLUMN "ets_dev"."G_CMN_ENTY_TB"."G_AUD_ADD_TS" IS 'The timestamp when the row was added.';
   COMMENT ON TABLE "ets_dev"."G_CMN_ENTY_TB"  IS 'The Common Entity Table is the primary portal into Contact Management and Common data.  Generally represents a Provider or Recipient.  Can be other types, such as Attorney or state government employee.  i.e. This is generally a person or place that possesses a Medicaid ID. Common Entity types include (not limited to): 1. MMIS specific entity types   a. Provider (entered)   b. Member (enrolled)   c. TPL Carrier 2. Specific Entity (Contact Management Entity)';


-- ======================================================================
-- Source: G_COTS_LTR_REQ_RECR_TB.sql
-- ======================================================================
--------------------------------------------------------
--  DDL for Table G_COTS_LTR_REQ_RECR_TB
--------------------------------------------------------

  CREATE TABLE "ets_dev"."G_COTS_LTR_REQ_RECR_TB"
   (	"G_COTS_LTR_REQ_RECR_SK" BIGINT,
	"G_COTS_LTR_REQ_SK" BIGINT,
	"G_COTS_LTR_RECR_TY_CD" VARCHAR(2),
	"G_LTR_REQ_COMMUN_MTHD_CD" VARCHAR(2),
	"G_CMN_ENTY_SK" BIGINT,
	"G_ADR_USG_TY_CD" VARCHAR(2),
	"G_ADR_SK" BIGINT,
	"G_E_ADR_USG_TY_CD" VARCHAR(2),
	"G_E_ADR_SK" BIGINT,
	"G_FIRST_NAM" VARCHAR(25),
	"G_LAST_NAM" VARCHAR(35),
	"G_DBA_NAM" VARCHAR(60),
	"G_LINE1_ADR" VARCHAR(64),
	"G_LINE2_ADR" VARCHAR(64),
	"G_CITY_NAM" VARCHAR(30),
	"G_COTS_LTR_REQ_TY_CD" VARCHAR(2),
	"G_US_STATE_CD" VARCHAR(2),
	"G_ZIP5_CD" VARCHAR(5),
	"G_ZIP4_CD" VARCHAR(4),
	"G_CNTRY_CD" VARCHAR(3),
	"G_CNTY_CD" VARCHAR(5),
	"G_USPS_LINE1_ADR" VARCHAR(64),
	"G_USPS_LINE2_ADR" VARCHAR(64),
	"L_HIBERNATE_VER_NUM" INTEGER DEFAULT 0,
	"G_AUD_USER_ID" VARCHAR(30),
	"G_AUD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_AUD_ADD_USER_ID" VARCHAR(30),
	"G_AUD_ADD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_ADR_USG_SEQ_NUM" INTEGER,
	"G_E_ADR_USG_SEQ_NUM" BIGINT,
	"G_REP_NAM_PREFX_CD" VARCHAR(4),
	"G_REP_TITLE_NAM" VARCHAR(20),
	"G_REP_FIRST_NAM" VARCHAR(25),
	"G_REP_MID_NAM" VARCHAR(25),
	"G_REP_LAST_NAM" VARCHAR(35),
	"G_REP_SFX_NAM" VARCHAR(10),
	"G_REP_ORG_NAM" VARCHAR(50),
	"G_LINE3_ADR" VARCHAR(64),
	"G_LINE4_ADR" VARCHAR(64),
	"G_LTR_STAT_CD" VARCHAR(1),
	"G_LTR_RTRN_CD" VARCHAR(2)
   );

   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_RECR_TB"."G_COTS_LTR_REQ_RECR_SK" IS 'COTS Letter Request Receiver Surrogate Key';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_RECR_TB"."G_COTS_LTR_REQ_SK" IS 'System generated sequential number.  ';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_RECR_TB"."G_COTS_LTR_RECR_TY_CD" IS 'To, CC, BC';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_RECR_TB"."G_LTR_REQ_COMMUN_MTHD_CD" IS 'F    FAX M    US Mail I    Inbox';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_RECR_TB"."G_CMN_ENTY_SK" IS 'Surrogate Key for the Common Entity.  This value may be referred to as Payer ID on some UI screens.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_RECR_TB"."G_ADR_USG_TY_CD" IS 'Member   Residential   Mailing Provider   Service Location   Billing   Mailing Carrier   Corporate   Billing   Payment';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_RECR_TB"."G_ADR_SK" IS 'Surrogate Key';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_RECR_TB"."G_E_ADR_USG_TY_CD" IS 'e.g. email address, IP address, FTP address, URL, Web Access, Provider Inbox ID, etc.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_RECR_TB"."G_E_ADR_SK" IS 'Surrogate Key';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_RECR_TB"."G_FIRST_NAM" IS 'First Name';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_RECR_TB"."G_LAST_NAM" IS 'Last Name';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_RECR_TB"."G_DBA_NAM" IS 'DBA = Doing Business As.  ';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_RECR_TB"."G_LINE1_ADR" IS 'Address line 1.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_RECR_TB"."G_LINE2_ADR" IS 'Address line 2. ';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_RECR_TB"."G_CITY_NAM" IS 'City Name';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_RECR_TB"."G_COTS_LTR_REQ_TY_CD" IS 'COTS Letter Request Type Code';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_RECR_TB"."G_US_STATE_CD" IS 'United States (US) State Code';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_RECR_TB"."G_ZIP5_CD" IS 'Zip5 Code (Length of 5)';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_RECR_TB"."G_ZIP4_CD" IS 'Zip4 Code (Length of 4)';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_RECR_TB"."G_CNTRY_CD" IS 'Code representing the country.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_RECR_TB"."G_CNTY_CD" IS 'Defines the counties of the state where Enterprise is implemented.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_RECR_TB"."G_USPS_LINE1_ADR" IS 'Verfified USPS address.  Will conform to the output parameters of the call to Geostan.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_RECR_TB"."G_USPS_LINE2_ADR" IS 'Verfified USPS address.  Will conform to the output parameters of the call to Geostan.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_RECR_TB"."L_HIBERNATE_VER_NUM" IS 'This supports hibernate caching mechanism and also supports the pessimistic Locking mechanism';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_RECR_TB"."G_AUD_USER_ID" IS 'The user ID or process that last modified the row.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_RECR_TB"."G_AUD_TS" IS 'The timestamp when the row was last modified.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_RECR_TB"."G_AUD_ADD_USER_ID" IS 'The user ID or process that added the row.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_RECR_TB"."G_AUD_ADD_TS" IS 'The timestamp when the row was added.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_RECR_TB"."G_ADR_USG_SEQ_NUM" IS 'Added to PK to ensure uniqueness and/or provide order to the rows.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_RECR_TB"."G_E_ADR_USG_SEQ_NUM" IS 'Added to PK to ensure uniqueness and/or provide order to the rows.';
   COMMENT ON TABLE "ets_dev"."G_COTS_LTR_REQ_RECR_TB"  IS 'Commercial Off-the-shelf (COTS) Letter Request Receiver Table';


-- ======================================================================
-- Source: G_COTS_LTR_REQ_TB.sql
-- ======================================================================
--------------------------------------------------------
--  DDL for Table G_COTS_LTR_REQ_TB
--------------------------------------------------------

  CREATE TABLE "ets_dev"."G_COTS_LTR_REQ_TB"
   (	"G_COTS_LTR_REQ_SK" BIGINT,
	"G_COTS_LTR_TMPLT_KEY_DATA" VARCHAR(50),
	"G_SPRVSR_REVW_REQD_IND" VARCHAR(1),
	"G_SPRVSR_REVW_DT" TIMESTAMP,
	"G_REVWG_SPRVSR_WORK_UNIT_SK" VARCHAR(99),
	"G_USER_ID" VARCHAR(30),
	"G_EXPLN_TEXT" VARCHAR(255),
	"G_TO_BE_SENT_DT" TIMESTAMP,
	"G_COTS_LTR_REQ_DISP_CD" VARCHAR(2),
	"G_DUE_DT_OFFST_NUM" SMALLINT,
	"G_RPLY_DUE_DT" TIMESTAMP,
	"G_RPLY_RECD_DT" TIMESTAMP,
	"G_LTR_REQ_ALERT_RSN_CD" VARCHAR(2),
	"G_NOTFY_ALERT_USER_ID" VARCHAR(30),
	"G_ALERT_BASED_ON_TABLE_NAM" VARCHAR(30),
	"G_ALERT_BASED_ON_COL_NAM" VARCHAR(30),
	"G_SEND_ALERT_DAYS_CD" VARCHAR(10),
	"G_BEFORE_AFTER_CD" VARCHAR(1),
	"G_COTS_LTR_GNRTN_RTRN_CD" VARCHAR(20),
	"G_COTS_LTR_GNRTN_RTRN_CD_DT" TIMESTAMP,
	"G_NOTE_SET_SK" BIGINT,
	"G_NOTE_SEQ_NUM" INTEGER,
	"L_HIBERNATE_VER_NUM" INTEGER DEFAULT 0,
	"G_AUD_USER_ID" VARCHAR(30),
	"G_AUD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_AUD_ADD_USER_ID" VARCHAR(30),
	"G_AUD_ADD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_COTS_LTR_ATTACH_IND" VARCHAR(1) DEFAULT 'N',
	"G_EDMS_PAGE_ID" VARCHAR(32)
   );

   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_COTS_LTR_REQ_SK" IS 'System generated sequential number.  ';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_COTS_LTR_TMPLT_KEY_DATA" IS 'Correlates directly with a letter template in the COTS letter generation product.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_SPRVSR_REVW_REQD_IND" IS 'Indicates whether the letter request has been reviewed by a supervisor.  Source of this attribute is the Letter Temlate entity.  This attribute stores a historical record of the value as of the date this row was inserted.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_SPRVSR_REVW_DT" IS 'The date a supervisor reviewed the letter request.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_REVWG_SPRVSR_WORK_UNIT_SK" IS 'Reviewing Supervisor Work Unit Surrogate Key';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_USER_ID" IS 'The user ID or process that last modified the row.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_EXPLN_TEXT" IS 'Source not determined.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_TO_BE_SENT_DT" IS 'Indicates the Date the letter information is "as of".';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_COTS_LTR_REQ_DISP_CD" IS 'COTS Letter Request Disposition Code';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_DUE_DT_OFFST_NUM" IS 'Determines when the alert is created based on the letter sent date.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_RPLY_DUE_DT" IS 'Global Date Data';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_RPLY_RECD_DT" IS 'Global Date Data';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_LTR_REQ_ALERT_RSN_CD" IS 'Letter Request Alert Reason Code';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_NOTFY_ALERT_USER_ID" IS 'The user ID or process that last modified the row.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_ALERT_BASED_ON_TABLE_NAM" IS 'Data Dictionary Table Definition.  One row exists for each table defined for the Enterprise MMIS application.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_ALERT_BASED_ON_COL_NAM" IS 'Column Name';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_SEND_ALERT_DAYS_CD" IS 'e.g. 1-5, 5-10, 11-20...';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_BEFORE_AFTER_CD" IS 'e.g. B=Before, A=After.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_COTS_LTR_GNRTN_RTRN_CD" IS 'This error code value comes from the COTS letter generation request product.  The data type was made intentionally generic.

The value is null initially (status code of in process), 0 for success (status code of complete), and one of the following for errors (status code of pended):

Fault Code    Fault String
9000    An error occurred while executing the web service.
9002    Access denied. The user name or password are incorrect.
9003    User is not authorized to access the required document.
9004    Output profile not found.
9005    Document not found.
9006    No Web service license available.
9007    Invalid customer key.
9008    Application not defined.
9009    Customer data source not defined.
9010    Data source not found.
9011    Failed to get connection to the database.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_COTS_LTR_GNRTN_RTRN_CD_DT" IS 'Commercial Off-the-shelf (COTS) Letter Generation Return Code Date';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_NOTE_SET_SK" IS 'The most recent Case note set for this Letter Request.  Paired with "g note sequence number".';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_NOTE_SEQ_NUM" IS 'The most recent Case note for this Letter Request.  Paired with "g note set SK".';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."L_HIBERNATE_VER_NUM" IS 'This supports hibernate caching mechanism and also supports the pessimistic Locking mechanism';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_AUD_USER_ID" IS 'The user ID or process that last modified the row.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_AUD_TS" IS 'The timestamp when the row was last modified.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_AUD_ADD_USER_ID" IS 'The user ID or process that added the row.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_AUD_ADD_TS" IS 'The timestamp when the row was added.';
   COMMENT ON TABLE "ets_dev"."G_COTS_LTR_REQ_TB"  IS 'One row for each letter that is requested to be generated.  ';


-- ======================================================================
-- Source: G_COTS_LTR_TMPLT_TB.sql
-- ======================================================================
--------------------------------------------------------
--  DDL for Table G_COTS_LTR_TMPLT_TB
--------------------------------------------------------

  CREATE TABLE "ets_dev"."G_COTS_LTR_TMPLT_TB"
   (	"G_COTS_LTR_TMPLT_KEY_DATA" VARCHAR(50),
	"G_NAM" VARCHAR(50),
	"G_DESC" VARCHAR(50),
	"G_DFLT_SPRVSR_REVW_REQD_IND" VARCHAR(1),
	"G_VOID_IND" VARCHAR(1),
	"G_COTS_VND_CAT_DESC" VARCHAR(255),
	"G_DFLT_DUE_DT_OFFST_NUM" SMALLINT,
	"L_HIBERNATE_VER_NUM" INTEGER DEFAULT 0,
	"G_AUD_USER_ID" VARCHAR(30),
	"G_AUD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_AUD_ADD_USER_ID" VARCHAR(30),
	"G_AUD_ADD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP
   );

   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_TMPLT_TB"."G_COTS_LTR_TMPLT_KEY_DATA" IS 'Unique identifier for letter template information found in the letter generation COTS product.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_TMPLT_TB"."G_NAM" IS 'Name of the template.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_TMPLT_TB"."G_DESC" IS 'Description of the template.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_TMPLT_TB"."G_DFLT_SPRVSR_REVW_REQD_IND" IS 'Indicates whether it is required for a supervisor to review this template.  This is a default value for other areas.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_TMPLT_TB"."G_VOID_IND" IS 'If Enterprise syncs with the letter generation COTS product, remove rows from this table (physically if they were not referenced in another table; else logically).';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_TMPLT_TB"."G_COTS_VND_CAT_DESC" IS 'e.g. Serice Auth, Member, Provider.  This list is very similar to the Common Entity Type values.  It remains separate because of the potential for them being different.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_TMPLT_TB"."G_DFLT_DUE_DT_OFFST_NUM" IS 'Combined with To Be Sent date (Letter Request) to set the default of Due Date (Letter Receiver).';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_TMPLT_TB"."L_HIBERNATE_VER_NUM" IS 'This supports hibernate caching mechanism and also supports the pessimistic Locking mechanism';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_TMPLT_TB"."G_AUD_USER_ID" IS 'The user ID or process that last modified the row.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_TMPLT_TB"."G_AUD_TS" IS 'The timestamp when the row was last modified.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_TMPLT_TB"."G_AUD_ADD_USER_ID" IS 'The user ID or process that added the row.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_TMPLT_TB"."G_AUD_ADD_TS" IS 'The timestamp when the row was added.';
   COMMENT ON TABLE "ets_dev"."G_COTS_LTR_TMPLT_TB"  IS 'The Commercial Off-the-shelf Letter Template Table contains the actual template data, which is sourced from xPression (or whatever Letter Generation product is used).  The population of this Table is a physical implementation issue.  i.e. Not via a UI.';


-- ======================================================================
-- Source: G_E_ADR_TB.sql
-- ======================================================================
--------------------------------------------------------
--  DDL for Table G_E_ADR_TB
--------------------------------------------------------

  CREATE TABLE "ets_dev"."G_E_ADR_TB"
   (	"G_E_ADR_SK" BIGINT NOT NULL ,
	"G_E_ADR_TEXT" VARCHAR(64) NOT NULL ,
	"G_BNCD_ADR_IND" VARCHAR(1) DEFAULT 'N' NOT NULL ,
	"G_CMN_ENTY_TY_CD" VARCHAR(2) NOT NULL ,
	"L_HIBERNATE_VER_NUM" INTEGER DEFAULT 0 NOT NULL ,
	"G_AUD_USER_ID" VARCHAR(30) NOT NULL ,
	"G_AUD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	"G_AUD_ADD_USER_ID" VARCHAR(30) NOT NULL ,
	"G_AUD_ADD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	"G_DUMMY_IND" VARCHAR(1) DEFAULT 'N' NOT NULL ,
	"G_DUMMY_TS" TIMESTAMP,
	"G_DUMMY_USER_ID" VARCHAR(30)
);
  CREATE UNIQUE INDEX "ets_dev"."G_E_ADR_PK" ON "ets_dev"."G_E_ADR_TB" ("G_E_ADR_SK");
ALTER TABLE "ets_dev"."G_E_ADR_TB" ADD CONSTRAINT "G_E_ADR_PK" PRIMARY KEY ("G_E_ADR_SK") ;

   COMMENT ON COLUMN "ets_dev"."G_E_ADR_TB"."G_E_ADR_SK" IS 'Surrogate Key';
   COMMENT ON COLUMN "ets_dev"."G_E_ADR_TB"."G_E_ADR_TEXT" IS 'Electronic Address Text';
   COMMENT ON COLUMN "ets_dev"."G_E_ADR_TB"."G_BNCD_ADR_IND" IS 'Indicates that this address was bounced as not deliverable.';
   COMMENT ON COLUMN "ets_dev"."G_E_ADR_TB"."G_CMN_ENTY_TY_CD" IS 'e.g. Member, Provider, TPL, Contact Management, etc.

In this entity, the Common Entity type code is used to help filter rows to assist search performance.';
   COMMENT ON COLUMN "ets_dev"."G_E_ADR_TB"."L_HIBERNATE_VER_NUM" IS 'This supports hibernate caching mechanism and also supports the pessimistic Locking mechanism';
   COMMENT ON COLUMN "ets_dev"."G_E_ADR_TB"."G_AUD_USER_ID" IS 'The user ID or process that last modified the row.';
   COMMENT ON COLUMN "ets_dev"."G_E_ADR_TB"."G_AUD_TS" IS 'The timestamp when the row was last modified.';
   COMMENT ON COLUMN "ets_dev"."G_E_ADR_TB"."G_AUD_ADD_USER_ID" IS 'The user ID or process that added the row.';
   COMMENT ON COLUMN "ets_dev"."G_E_ADR_TB"."G_AUD_ADD_TS" IS 'The timestamp when the row was added.';
   COMMENT ON TABLE "ets_dev"."G_E_ADR_TB"  IS 'The Electronic Address Table contains information about e-addresses.';


-- ======================================================================
-- Source: G_E_ADR_USG_TB.sql
-- ======================================================================
--------------------------------------------------------
--  DDL for Table G_E_ADR_USG_TB
--------------------------------------------------------

  CREATE TABLE "ets_dev"."G_E_ADR_USG_TB"
   (	"G_CMN_ENTY_SK" BIGINT,
	"G_E_ADR_USG_TY_CD" VARCHAR(2),
	"G_E_ADR_SK" BIGINT,
	"G_E_ADR_USG_SEQ_NUM" INTEGER,
	"G_E_ADR_GLBL_SIG_CD" VARCHAR(2),
	"G_E_ADR_TY_SIG_CD" VARCHAR(2),
	"G_E_ADR_USG_STAT_CD" VARCHAR(2),
	"G_E_ADR_USG_BEG_DT" TIMESTAMP,
	"G_E_ADR_USG_END_DT" TIMESTAMP,
	"L_HIBERNATE_VER_NUM" INTEGER DEFAULT 0,
	"G_AUD_USER_ID" VARCHAR(30),
	"G_AUD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_AUD_ADD_USER_ID" VARCHAR(30),
	"G_AUD_ADD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_DUMMY_IND" VARCHAR(1) DEFAULT 'N',
	"G_DUMMY_TS" TIMESTAMP,
	"G_DUMMY_USER_ID" VARCHAR(30)
   );

   COMMENT ON COLUMN "ets_dev"."G_E_ADR_USG_TB"."G_CMN_ENTY_SK" IS 'Surrogate Key for the Common Entity.  This value may be referred to as Payer ID on some UI screens.';
   COMMENT ON COLUMN "ets_dev"."G_E_ADR_USG_TB"."G_E_ADR_USG_TY_CD" IS 'e.g. email address, IP address, FTP address, URL, Web Access, Provider Inbox ID, etc.';
   COMMENT ON COLUMN "ets_dev"."G_E_ADR_USG_TB"."G_E_ADR_SK" IS 'Surrogate Key';
   COMMENT ON COLUMN "ets_dev"."G_E_ADR_USG_TB"."G_E_ADR_USG_SEQ_NUM" IS 'Sequence Number';
   COMMENT ON COLUMN "ets_dev"."G_E_ADR_USG_TB"."G_E_ADR_GLBL_SIG_CD" IS 'Primary, Secondary, Tertiary among all addresses for a CE.';
   COMMENT ON COLUMN "ets_dev"."G_E_ADR_USG_TB"."G_E_ADR_TY_SIG_CD" IS 'e.g. Primary, Secondary, etc.  This is the significance type *within* an e-address type.';
   COMMENT ON COLUMN "ets_dev"."G_E_ADR_USG_TB"."G_E_ADR_USG_STAT_CD" IS 'Electronic Address Usage Status Code';
   COMMENT ON COLUMN "ets_dev"."G_E_ADR_USG_TB"."G_E_ADR_USG_BEG_DT" IS 'E-Address Usage Begin Date';
   COMMENT ON COLUMN "ets_dev"."G_E_ADR_USG_TB"."G_E_ADR_USG_END_DT" IS 'E-Address Usage End Date';
   COMMENT ON COLUMN "ets_dev"."G_E_ADR_USG_TB"."L_HIBERNATE_VER_NUM" IS 'This supports hibernate caching mechanism and also supports the pessimistic Locking mechanism';
   COMMENT ON COLUMN "ets_dev"."G_E_ADR_USG_TB"."G_AUD_USER_ID" IS 'The user ID or process that last modified the row.';
   COMMENT ON COLUMN "ets_dev"."G_E_ADR_USG_TB"."G_AUD_TS" IS 'The timestamp when the row was last modified.';
   COMMENT ON COLUMN "ets_dev"."G_E_ADR_USG_TB"."G_AUD_ADD_USER_ID" IS 'The user ID or process that added the row.';
   COMMENT ON COLUMN "ets_dev"."G_E_ADR_USG_TB"."G_AUD_ADD_TS" IS 'The timestamp when the row was added.';
   COMMENT ON TABLE "ets_dev"."G_E_ADR_USG_TB"  IS 'The Electronic Usage Table is an associative Table, which allows an address to be defined as multiple types (billing, shipping, etc.).';


-- ======================================================================
-- Source: G_NOTE_TB.sql
-- ======================================================================
--------------------------------------------------------
--  DDL for Table G_NOTE_TB
--------------------------------------------------------

  CREATE TABLE "ets_dev"."G_NOTE_TB"
   (	"G_NOTE_SET_SK" BIGINT,
	"G_NOTE_SEQ_NUM" INTEGER,
	"G_NOTE_TEXT_VT" BIGINT,
	"G_NOTE_TY_CD" VARCHAR(2),
	"L_HIBERNATE_VER_NUM" INTEGER DEFAULT 0,
	"G_AUD_USER_ID" VARCHAR(30),
	"G_AUD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_AUD_ADD_USER_ID" VARCHAR(30),
	"G_AUD_ADD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP
   );

   COMMENT ON COLUMN "ets_dev"."G_NOTE_TB"."G_NOTE_TEXT_VT" IS 'Note Text Value Token';


-- ======================================================================
-- Source: G_PHONE_TB.sql
-- ======================================================================
--------------------------------------------------------
--  DDL for Table G_PHONE_TB
--------------------------------------------------------

  CREATE TABLE "ets_dev"."G_PHONE_TB"
   (	"G_PHONE_SK" BIGINT,
	"G_PHONE_NUM" VARCHAR(10),
	"G_EXT_NUM" VARCHAR(6),
	"G_CNTRY_CD" VARCHAR(3),
	"G_INTL_PHONE_NUM" VARCHAR(20),
	"G_OUT_OF_SVC_IND" VARCHAR(1) DEFAULT 'N',
	"G_CMN_ENTY_TY_CD" VARCHAR(2),
	"L_HIBERNATE_VER_NUM" INTEGER DEFAULT 0,
	"G_AUD_USER_ID" VARCHAR(30),
	"G_AUD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_AUD_ADD_USER_ID" VARCHAR(30),
	"G_AUD_ADD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_DUMMY_IND" VARCHAR(1) DEFAULT 'N',
	"G_DUMMY_TS" TIMESTAMP,
	"G_DUMMY_USER_ID" VARCHAR(30)
   );

   COMMENT ON COLUMN "ets_dev"."G_PHONE_TB"."G_PHONE_SK" IS 'Surrogate Key';
   COMMENT ON COLUMN "ets_dev"."G_PHONE_TB"."G_PHONE_NUM" IS 'Note: Either the US or international phone number must be populated.';
   COMMENT ON COLUMN "ets_dev"."G_PHONE_TB"."G_EXT_NUM" IS 'Phone Extension Number';
   COMMENT ON COLUMN "ets_dev"."G_PHONE_TB"."G_CNTRY_CD" IS 'If the phone number is in the USA, this attribute will contain no value.';
   COMMENT ON COLUMN "ets_dev"."G_PHONE_TB"."G_INTL_PHONE_NUM" IS 'International Phone Number';
   COMMENT ON COLUMN "ets_dev"."G_PHONE_TB"."G_OUT_OF_SVC_IND" IS 'Indicates that this address was returned as not deliverable.';
   COMMENT ON COLUMN "ets_dev"."G_PHONE_TB"."G_CMN_ENTY_TY_CD" IS 'e.g. Member, Provider, TPL, Contact Management, etc.

In this context, the Common Entity type code is used to help filter rows to assist search performance.';
   COMMENT ON COLUMN "ets_dev"."G_PHONE_TB"."L_HIBERNATE_VER_NUM" IS 'This supports hibernate caching mechanism and also supports the pessimistic Locking mechanism';
   COMMENT ON COLUMN "ets_dev"."G_PHONE_TB"."G_AUD_USER_ID" IS 'The user ID or process that last modified the row.';
   COMMENT ON COLUMN "ets_dev"."G_PHONE_TB"."G_AUD_TS" IS 'The timestamp when the row was last modified.';
   COMMENT ON COLUMN "ets_dev"."G_PHONE_TB"."G_AUD_ADD_USER_ID" IS 'The user ID or process that added the row.';
   COMMENT ON COLUMN "ets_dev"."G_PHONE_TB"."G_AUD_ADD_TS" IS 'The timestamp when the row was added.';
   COMMENT ON TABLE "ets_dev"."G_PHONE_TB"  IS 'The Phone Table stores individual phone numbers.';


-- ======================================================================
-- Source: G_PHONE_USG_TB.sql
-- ======================================================================
--------------------------------------------------------
--  DDL for Table G_PHONE_USG_TB
--------------------------------------------------------

  CREATE TABLE "ets_dev"."G_PHONE_USG_TB"
   (	"G_CMN_ENTY_SK" BIGINT,
	"G_PHONE_USG_TY_CD" VARCHAR(2),
	"G_PHONE_SK" BIGINT,
	"G_PHONE_USG_SEQ_NUM" INTEGER,
	"G_PHONE_GLBL_SIG_CD" VARCHAR(2),
	"G_PHONE_TY_SIG_CD" VARCHAR(2),
	"G_PHONE_USG_STAT_CD" VARCHAR(2),
	"G_PHONE_USG_END_DT" TIMESTAMP,
	"G_PHONE_USG_BEG_DT" TIMESTAMP,
	"L_HIBERNATE_VER_NUM" INTEGER DEFAULT 0,
	"G_AUD_USER_ID" VARCHAR(30),
	"G_AUD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_AUD_ADD_USER_ID" VARCHAR(30),
	"G_AUD_ADD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_DUMMY_IND" VARCHAR(1) DEFAULT 'N',
	"G_DUMMY_TS" TIMESTAMP,
	"G_DUMMY_USER_ID" VARCHAR(30)
   );

   COMMENT ON COLUMN "ets_dev"."G_PHONE_USG_TB"."G_CMN_ENTY_SK" IS 'Surrogate Key for the Common Entity.  This value may be referred to as Payer ID on some UI screens.';
   COMMENT ON COLUMN "ets_dev"."G_PHONE_USG_TB"."G_PHONE_USG_TY_CD" IS 'e.g. Home, Work, Cell, Home Fax, Work Fax, Bank, Web Access, etc.

Member: Home, Work, Fax, Cell

Provider: Phone, Fax (dual-purpose code would show Service Phone, Service Fax, Billing Phone, Billing Fax, Mailing Phone, etc.)

Carrier:

  ';
   COMMENT ON COLUMN "ets_dev"."G_PHONE_USG_TB"."G_PHONE_SK" IS 'Surrogate Key';
   COMMENT ON COLUMN "ets_dev"."G_PHONE_USG_TB"."G_PHONE_USG_SEQ_NUM" IS 'Sequence Number';
   COMMENT ON COLUMN "ets_dev"."G_PHONE_USG_TB"."G_PHONE_GLBL_SIG_CD" IS 'Primary, Secondary, Tertiary among all phones for a CE.';
   COMMENT ON COLUMN "ets_dev"."G_PHONE_USG_TB"."G_PHONE_TY_SIG_CD" IS 'e.g. Primary, Secondary, Tertiary, etc.

Note: This code identifies the primary (etc.) phone *within* each phone type.';
   COMMENT ON COLUMN "ets_dev"."G_PHONE_USG_TB"."G_PHONE_USG_STAT_CD" IS 'Phone Usage Status Code';
   COMMENT ON COLUMN "ets_dev"."G_PHONE_USG_TB"."G_PHONE_USG_END_DT" IS 'Phone Usage End Date';
   COMMENT ON COLUMN "ets_dev"."G_PHONE_USG_TB"."G_PHONE_USG_BEG_DT" IS 'Phone Usage Begin Date';
   COMMENT ON COLUMN "ets_dev"."G_PHONE_USG_TB"."L_HIBERNATE_VER_NUM" IS 'This supports hibernate caching mechanism and also supports the pessimistic Locking mechanism';
   COMMENT ON COLUMN "ets_dev"."G_PHONE_USG_TB"."G_AUD_USER_ID" IS 'The user ID or process that last modified the row.';
   COMMENT ON COLUMN "ets_dev"."G_PHONE_USG_TB"."G_AUD_TS" IS 'The timestamp when the row was last modified.';
   COMMENT ON COLUMN "ets_dev"."G_PHONE_USG_TB"."G_AUD_ADD_USER_ID" IS 'The user ID or process that added the row.';
   COMMENT ON COLUMN "ets_dev"."G_PHONE_USG_TB"."G_AUD_ADD_TS" IS 'The timestamp when the row was added.';
   COMMENT ON COLUMN "ets_dev"."G_PHONE_USG_TB"."G_DUMMY_IND" IS 'Global Indicator';
   COMMENT ON TABLE "ets_dev"."G_PHONE_USG_TB"  IS 'The Phone Usage Table indicates how a phone number can be used as defined by Phone Type.  Each phone number can be associated with one or more Phone Types.';


-- ======================================================================
-- Source: G_PYE_PYR_EFT_SETUP_TB.sql
-- ======================================================================
--------------------------------------------------------
--  DDL for Table G_PYE_PYR_EFT_SETUP_TB
--------------------------------------------------------

  CREATE TABLE "ets_dev"."G_PYE_PYR_EFT_SETUP_TB"
   (	"G_CMN_ENTY_SK" BIGINT,
	"G_PYE_PYR_EFT_SETUP_SEQ_NUM" INTEGER,
	"G_EFT_SETUP_BEG_DT" TIMESTAMP,
	"G_EFT_SETUP_END_DT" TIMESTAMP,
	"G_BIN_ROUTNG_NUM" VARCHAR(12),
	"G_FIN_INST_NAM" VARCHAR(50),
	"G_EFT_STAT_CD" VARCHAR(2),
	"G_EFT_STAT_DT" TIMESTAMP,
	"G_EFT_ACCT_TY_CD" VARCHAR(2),
	"G_EFT_ACCT_NUM" VARCHAR(15),
	"G_BANK_BRNCH_NAM" VARCHAR(50),
	"G_PRE_NOTE_DT" TIMESTAMP,
	"G_ACCT_HLDR_NAM" VARCHAR(50),
	"G_PROV_PYE_NAM" VARCHAR(50),
	"G_BANK_ADR_SK" BIGINT,
	"G_BANK_PHONE_SK" BIGINT,
	"L_HIBERNATE_VER_NUM" INTEGER DEFAULT 0,
	"G_AUD_USER_ID" VARCHAR(30),
	"G_AUD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_AUD_ADD_USER_ID" VARCHAR(30),
	"G_AUD_ADD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_EFT_ACCT_NUM_LNKG_DESC" VARCHAR(50),
	"G_EFT_SUBM_RSN_DESC" VARCHAR(18),
	"G_EFT_AUTH_SIGN_DESC" VARCHAR(50),
	"G_EFT_STREET_ADR" VARCHAR(64),
	"G_PROV_ADR_SK" BIGINT
   );


-- ======================================================================
-- Source: G_PYE_PYR_TB.sql
-- ======================================================================
--------------------------------------------------------
--  DDL for Table G_PYE_PYR_TB
--------------------------------------------------------

  CREATE TABLE "ets_dev"."G_PYE_PYR_TB"
   (	"G_CMN_ENTY_SK" BIGINT,
	"G_SORT_NAM" VARCHAR(60),
	"G_FIRST_NAM" VARCHAR(25),
	"G_MID_NAM" VARCHAR(25),
	"G_LAST_NAM" VARCHAR(35),
	"G_BUSN_NAM" VARCHAR(50),
	"G_CMN_ENTY_TY_CD" VARCHAR(2),
	"G_ENTY_EXTL_ID" VARCHAR(15),
	"G_ENTY_EXTL_ID_TY_CD" VARCHAR(3),
	"G_RECOUP_INSTLMT_VALUE" NUMERIC(9,2),
	"G_RECOUP_PCT_VALUE" NUMERIC(9,2),
	"G_RECOUP_LAG_DAYS_NUM" INTEGER,
	"G_W9_SGND_DT" TIMESTAMP,
	"G_RECOUP_FREQ_CD" VARCHAR(2),
	"G_NOTE_SET_SK" BIGINT,
	"G_VND_MSTR_NUM" VARCHAR(10),
	"L_HIBERNATE_VER_NUM" INTEGER DEFAULT 0,
	"G_AUD_USER_ID" VARCHAR(30),
	"G_AUD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_AUD_ADD_USER_ID" VARCHAR(30),
	"G_AUD_ADD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_VOID_IND" VARCHAR(1) DEFAULT 'N',
	"G_VOID_DT" TIMESTAMP,
	"G_REMIT_TO_LOC_CD" VARCHAR(4),
	"G_OLD_VND_MSTR_NUM" VARCHAR(20)
   );

   COMMENT ON COLUMN "ets_dev"."G_PYE_PYR_TB"."G_CMN_ENTY_SK" IS 'Surrogate Key for the Common Entity.  This value may be referred to as Payer ID on some UI screens.';
   COMMENT ON COLUMN "ets_dev"."G_PYE_PYR_TB"."G_SORT_NAM" IS 'Provider Name';
   COMMENT ON COLUMN "ets_dev"."G_PYE_PYR_TB"."G_FIRST_NAM" IS 'Global First Name Data';
   COMMENT ON COLUMN "ets_dev"."G_PYE_PYR_TB"."G_MID_NAM" IS 'Global Middle Name Data';
   COMMENT ON COLUMN "ets_dev"."G_PYE_PYR_TB"."G_LAST_NAM" IS 'Global Last Name Data';
   COMMENT ON COLUMN "ets_dev"."G_PYE_PYR_TB"."G_BUSN_NAM" IS 'Global Name Data';
   COMMENT ON COLUMN "ets_dev"."G_PYE_PYR_TB"."G_CMN_ENTY_TY_CD" IS 'e.g. Member, Provider, TPL, Contact Management, etc.';
   COMMENT ON COLUMN "ets_dev"."G_PYE_PYR_TB"."G_ENTY_EXTL_ID" IS 'Entity external ID';
   COMMENT ON COLUMN "ets_dev"."G_PYE_PYR_TB"."G_ENTY_EXTL_ID_TY_CD" IS 'Entity External Identifier Type Code';
   COMMENT ON COLUMN "ets_dev"."G_PYE_PYR_TB"."G_RECOUP_INSTLMT_VALUE" IS 'Recoupment Installment Value';
   COMMENT ON COLUMN "ets_dev"."G_PYE_PYR_TB"."G_RECOUP_PCT_VALUE" IS 'Recoupment Percent Value';
   COMMENT ON COLUMN "ets_dev"."G_PYE_PYR_TB"."G_RECOUP_LAG_DAYS_NUM" IS 'How long to delay the recoupment from the time the receivable is created.';
   COMMENT ON COLUMN "ets_dev"."G_PYE_PYR_TB"."G_W9_SGND_DT" IS 'The date the W-9 was signed.';
   COMMENT ON COLUMN "ets_dev"."G_PYE_PYR_TB"."G_RECOUP_FREQ_CD" IS 'e.g. Weekly, bi-Weekly, Monthly.';
   COMMENT ON COLUMN "ets_dev"."G_PYE_PYR_TB"."G_NOTE_SET_SK" IS 'Surrogate Key';
   COMMENT ON COLUMN "ets_dev"."G_PYE_PYR_TB"."G_VND_MSTR_NUM" IS 'The Vendor Master Number is a unique identifier assigned to all payee''s in the NH accounting system. The Vendor Master Number must be submitted to the NH accounting system for check and EFT transactions.';
   COMMENT ON COLUMN "ets_dev"."G_PYE_PYR_TB"."L_HIBERNATE_VER_NUM" IS 'This supports hibernate caching mechanism and also supports the pessimistic Locking mechanism';
   COMMENT ON COLUMN "ets_dev"."G_PYE_PYR_TB"."G_AUD_USER_ID" IS 'The user ID or process that last modified the row.';
   COMMENT ON COLUMN "ets_dev"."G_PYE_PYR_TB"."G_AUD_TS" IS 'The timestamp when the row was last modified.';
   COMMENT ON COLUMN "ets_dev"."G_PYE_PYR_TB"."G_AUD_ADD_USER_ID" IS 'The user ID or process that added the row.';
   COMMENT ON COLUMN "ets_dev"."G_PYE_PYR_TB"."G_AUD_ADD_TS" IS 'The timestamp when the row was added.';
   COMMENT ON COLUMN "ets_dev"."G_PYE_PYR_TB"."G_REMIT_TO_LOC_CD" IS 'Remit To Location Code';
   COMMENT ON COLUMN "ets_dev"."G_PYE_PYR_TB"."G_OLD_VND_MSTR_NUM" IS 'Old Vendor Master Number';
   COMMENT ON TABLE "ets_dev"."G_PYE_PYR_TB"  IS 'Payee Payer Table';


-- ======================================================================
-- Source: G_REP_PROV_TB.sql
-- ======================================================================
--------------------------------------------------------
--  DDL for Table G_REP_PROV_TB
--------------------------------------------------------

  CREATE TABLE "ets_dev"."G_REP_PROV_TB"
   (	"G_CMN_ENTY_SK" BIGINT,
	"G_REP_SK" BIGINT,
	"G_REP_XREF_TY_CD" VARCHAR(2),
	"G_DBA_NAM" VARCHAR(60),
	"G_REP_PROV_PSTN_CD" VARCHAR(2),
	"G_STATE_OR_CNTRY_OF_BIRTH_TEXT" VARCHAR(20),
	"G_TAX_ID" VARCHAR(9),
	"G_BUSN_NAM" VARCHAR(50),
	"G_ME_ID_NUM" VARCHAR(1),
	"G_ME_BIRTH_CNTRY_CD" VARCHAR(3),
	"G_ME_MCAID_ID_STATE_CD" VARCHAR(2),
	"G_ME_BIRTH_US_STATE_CD" VARCHAR(2),
	"G_ME_BIRTH_CNTY_CD" VARCHAR(5),
	"G_ME_DBA_BUSN_NAM" VARCHAR(50),
	"G_RA_BUSN_ATTENTION_NAM" VARCHAR(50),
	"L_HIBERNATE_VER_NUM" INTEGER DEFAULT 0,
	"G_AUD_USER_ID" VARCHAR(30),
	"G_AUD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_AUD_ADD_USER_ID" VARCHAR(30),
	"G_AUD_ADD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP
   );

   COMMENT ON COLUMN "ets_dev"."G_REP_PROV_TB"."G_CMN_ENTY_SK" IS 'Surrogate Key for the Common Entity.  This value may be referred to as Payer ID on some UI screens.';
   COMMENT ON COLUMN "ets_dev"."G_REP_PROV_TB"."G_REP_SK" IS 'Surrogate Key';
   COMMENT ON COLUMN "ets_dev"."G_REP_PROV_TB"."G_REP_XREF_TY_CD" IS 'Defines the type of representative for any type of Common Entity.

For SA - Presumptive Member, Requesting Office, Alternate Addressee

For Provider - RA contact, Authorized Rep, Managing Employee, Pharmacist in charge.

For Member - Absent Parent, Custodial Parent.

For Member Case - Head of Household, Authorized Rep.

For TPL Carrier - Contact.

For Acuity - Facility Administrator (maybe in Provider''s system list)';
   COMMENT ON COLUMN "ets_dev"."G_REP_PROV_TB"."G_DBA_NAM" IS 'DBA = Doing Business As.  ';
   COMMENT ON COLUMN "ets_dev"."G_REP_PROV_TB"."G_REP_PROV_PSTN_CD" IS 'Job title code.

e.g. Senior Accountant, Head CSR Rep, etc.';
   COMMENT ON COLUMN "ets_dev"."G_REP_PROV_TB"."G_STATE_OR_CNTRY_OF_BIRTH_TEXT" IS 'State or country of birth.';
   COMMENT ON COLUMN "ets_dev"."G_REP_PROV_TB"."G_TAX_ID" IS 'Provider Representative Tax Identifier';
   COMMENT ON COLUMN "ets_dev"."G_REP_PROV_TB"."G_BUSN_NAM" IS 'Provider Representative Business Name';
   COMMENT ON COLUMN "ets_dev"."G_REP_PROV_TB"."G_ME_ID_NUM" IS 'Managing Employee Identifier Number';
   COMMENT ON COLUMN "ets_dev"."G_REP_PROV_TB"."G_ME_BIRTH_CNTRY_CD" IS 'Code representing the country.';
   COMMENT ON COLUMN "ets_dev"."G_REP_PROV_TB"."G_ME_MCAID_ID_STATE_CD" IS 'Managing Employee Medicaid Identifier State Code';
   COMMENT ON COLUMN "ets_dev"."G_REP_PROV_TB"."G_ME_BIRTH_US_STATE_CD" IS 'US State of birth of the Managing Employee.';
   COMMENT ON COLUMN "ets_dev"."G_REP_PROV_TB"."G_ME_BIRTH_CNTY_CD" IS 'Defines the counties of the state where Enterprise is implemented.';
   COMMENT ON COLUMN "ets_dev"."G_REP_PROV_TB"."G_ME_DBA_BUSN_NAM" IS 'Managing Employee Database Administrator Business Name';
   COMMENT ON COLUMN "ets_dev"."G_REP_PROV_TB"."G_RA_BUSN_ATTENTION_NAM" IS 'Remittance Advice Business Attention Name';
   COMMENT ON COLUMN "ets_dev"."G_REP_PROV_TB"."L_HIBERNATE_VER_NUM" IS 'This supports hibernate caching mechanism and also supports the pessimistic Locking mechanism';
   COMMENT ON COLUMN "ets_dev"."G_REP_PROV_TB"."G_AUD_USER_ID" IS 'The user ID or process that last modified the row.';
   COMMENT ON COLUMN "ets_dev"."G_REP_PROV_TB"."G_AUD_TS" IS 'The timestamp when the row was last modified.';
   COMMENT ON COLUMN "ets_dev"."G_REP_PROV_TB"."G_AUD_ADD_USER_ID" IS 'The user ID or process that added the row.';
   COMMENT ON COLUMN "ets_dev"."G_REP_PROV_TB"."G_AUD_ADD_TS" IS 'The timestamp when the row was added.';
   COMMENT ON TABLE "ets_dev"."G_REP_PROV_TB"  IS 'Represenative Provider Table';


-- ======================================================================
-- Source: G_REP_TB.sql
-- ======================================================================
--------------------------------------------------------
--  DDL for Table G_REP_TB
--------------------------------------------------------

  CREATE TABLE "ets_dev"."G_REP_TB"
   (	"G_REP_SK" BIGINT,
	"G_NAM_PREFX_CD" VARCHAR(4),
	"G_TITLE_NAM" VARCHAR(20),
	"G_FIRST_NAM" VARCHAR(25),
	"G_MID_NAM" VARCHAR(25),
	"G_LAST_NAM" VARCHAR(35),
	"G_SFX_NAM" VARCHAR(10),
	"G_PHNTC_LAST_NAM" VARCHAR(4),
	"G_PHNTC_FIRST_NAM" VARCHAR(4),
	"G_DOB_DT" TIMESTAMP,
	"G_DOD_DT" TIMESTAMP,
	"G_SSN" VARCHAR(9),
	"G_GENDER_CD" VARCHAR(1),
	"G_CMN_ENTY_TY_CD" VARCHAR(2),
	"G_REP_CMN_ENTY_SK" BIGINT,
	"G_ORG_NAM" VARCHAR(50),
	"G_NOTE_SET_SK" BIGINT,
	"L_HIBERNATE_VER_NUM" INTEGER DEFAULT 0,
	"G_AUD_USER_ID" VARCHAR(30),
	"G_AUD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_AUD_ADD_USER_ID" VARCHAR(30),
	"G_AUD_ADD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_DUMMY_IND" VARCHAR(1) DEFAULT 'N',
	"G_DUMMY_TS" TIMESTAMP,
	"G_DUMMY_USER_ID" VARCHAR(30)
   );

   COMMENT ON COLUMN "ets_dev"."G_REP_TB"."G_REP_SK" IS 'Surrogate Key';
   COMMENT ON COLUMN "ets_dev"."G_REP_TB"."G_NAM_PREFX_CD" IS 'e.g. Mr., Mrs....';
   COMMENT ON COLUMN "ets_dev"."G_REP_TB"."G_TITLE_NAM" IS 'e.g. President';
   COMMENT ON COLUMN "ets_dev"."G_REP_TB"."G_FIRST_NAM" IS 'First Name';
   COMMENT ON COLUMN "ets_dev"."G_REP_TB"."G_MID_NAM" IS 'Middle Name';
   COMMENT ON COLUMN "ets_dev"."G_REP_TB"."G_LAST_NAM" IS 'Last Name';
   COMMENT ON COLUMN "ets_dev"."G_REP_TB"."G_SFX_NAM" IS 'e.g. Sr, Jr, III';
   COMMENT ON COLUMN "ets_dev"."G_REP_TB"."G_PHNTC_LAST_NAM" IS 'Phonetic name similar to that found in the Member table.';
   COMMENT ON COLUMN "ets_dev"."G_REP_TB"."G_PHNTC_FIRST_NAM" IS 'Phonetic name similar to that found in the Member table.';
   COMMENT ON COLUMN "ets_dev"."G_REP_TB"."G_DOB_DT" IS 'Date of Birth';
   COMMENT ON COLUMN "ets_dev"."G_REP_TB"."G_DOD_DT" IS 'Date of Death';
   COMMENT ON COLUMN "ets_dev"."G_REP_TB"."G_SSN" IS 'Social Security Number.  There is not a requirement to know the Rep''s SSN.';
   COMMENT ON COLUMN "ets_dev"."G_REP_TB"."G_GENDER_CD" IS 'Gender Code';
   COMMENT ON COLUMN "ets_dev"."G_REP_TB"."G_CMN_ENTY_TY_CD" IS 'Denormalized for performance reasons.  This value can be found in Common Entity.';
   COMMENT ON COLUMN "ets_dev"."G_REP_TB"."G_REP_CMN_ENTY_SK" IS 'Surrogate Key for the Common Entity.  This value may be referred to as Payer ID on some UI screens.';
   COMMENT ON COLUMN "ets_dev"."G_REP_TB"."G_ORG_NAM" IS 'Organization Name';
   COMMENT ON COLUMN "ets_dev"."G_REP_TB"."G_NOTE_SET_SK" IS 'Surrogate Key';
   COMMENT ON COLUMN "ets_dev"."G_REP_TB"."L_HIBERNATE_VER_NUM" IS 'This supports hibernate caching mechanism and also supports the pessimistic Locking mechanism';
   COMMENT ON COLUMN "ets_dev"."G_REP_TB"."G_AUD_USER_ID" IS 'The user ID or process that last modified the row.';
   COMMENT ON COLUMN "ets_dev"."G_REP_TB"."G_AUD_TS" IS 'The timestamp when the row was added.';
   COMMENT ON COLUMN "ets_dev"."G_REP_TB"."G_AUD_ADD_USER_ID" IS 'The user ID or process that added the row.';
   COMMENT ON COLUMN "ets_dev"."G_REP_TB"."G_AUD_ADD_TS" IS 'The timestamp when the row was added.';
   COMMENT ON TABLE "ets_dev"."G_REP_TB"  IS 'g rep tb - fka Contact The Rep Table contains information about an individual that represents the entity (e.g. Someone who works for a Provider). A Rep cannot be a payee.  Payees that don''t have base Tables associated with them are stored in Specific Entity. Notice that Rep is a "base" Table.  Thus, every row in the Rep Table has one corresponding row in Common Entity. Also, the app must enforce that a Rep cannot have Reps associated with him/her."';


-- ======================================================================
-- Source: G_USER_TB.sql
-- ======================================================================
--------------------------------------------------------
--  DDL for Table G_USER_TB
--------------------------------------------------------

  CREATE TABLE "ets_dev"."G_USER_TB"
   (	"G_USER_WORK_UNIT_SK" BIGINT,
	"G_USER_ID" VARCHAR(30),
	"G_PREFX_NAM" VARCHAR(25),
	"G_LAST_NAM" VARCHAR(35),
	"G_FIRST_NAM" VARCHAR(25),
	"G_MI_NAM" VARCHAR(1),
	"G_SFX_NAM" VARCHAR(10),
	"G_PHONE_NUM" VARCHAR(10),
	"G_PHONE_EXT_NUM" VARCHAR(6),
	"G_EMAIL_ADR_TEXT" VARCHAR(64),
	"G_ORG_ID" VARCHAR(10),
	"G_ORG_NAM" VARCHAR(50),
	"G_ORG_DESC_TEXT" VARCHAR(320),
	"G_SPRVSR_REVW_REQD_IND" VARCHAR(1),
	"G_CASE_FLTR_NAM" VARCHAR(50),
	"G_CR_FLTR_NAM" VARCHAR(50),
	"G_SPRVSR_IND" VARCHAR(1),
	"G_ACCT_ACTV_IND" VARCHAR(1),
	"L_HIBERNATE_VER_NUM" INTEGER DEFAULT 0,
	"G_AUD_USER_ID" VARCHAR(30),
	"G_AUD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_AUD_ADD_USER_ID" VARCHAR(30),
	"G_AUD_ADD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_ORG_TY_TEXT" VARCHAR(250),
	"G_MFA_FST_TM_USR" VARCHAR(1) DEFAULT 'N'
   );

   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."G_USER_WORK_UNIT_SK" IS 'Surrogate Key';
   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."G_USER_ID" IS 'The user ID or process that last modified the row.';
   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."G_PREFX_NAM" IS 'e.g. Mr., Mrs....';
   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."G_LAST_NAM" IS 'Last name of the user.
LDAP Specific Attribute Name: sn';
   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."G_FIRST_NAM" IS 'First name.
LDAP Specific Attribute Name: givenName';
   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."G_MI_NAM" IS 'Middle initials of the user.
LDAP Specific Attribute Name: middleInitials';
   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."G_SFX_NAM" IS 'e.g. Sr., Jr., III...';
   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."G_PHONE_NUM" IS 'Phone number';
   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."G_PHONE_EXT_NUM" IS 'Phone Extension Number';
   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."G_EMAIL_ADR_TEXT" IS 'Email Address Text';
   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."G_ORG_ID" IS 'e.g. State Code, County ID...';
   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."G_ORG_NAM" IS 'e.g. State Name, County Name...';
   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."G_ORG_DESC_TEXT" IS 'Sentence(s) about the organization.';
   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."G_SPRVSR_REVW_REQD_IND" IS 'Supervisor must review CR before it is closed.  A supervisor cannot have this indicator set to positive.  ';
   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."G_CASE_FLTR_NAM" IS 'CM Filter Name';
   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."G_CR_FLTR_NAM" IS 'CM Filter Name';
   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."G_SPRVSR_IND" IS 'Supervisor indicator';
   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."G_ACCT_ACTV_IND" IS 'Global Indicator';
   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."L_HIBERNATE_VER_NUM" IS 'This supports hibernate caching mechanism and also supports the pessimistic Locking mechanism';
   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."G_AUD_USER_ID" IS 'The user ID or process that last modified the row.';
   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."G_AUD_TS" IS 'The timestamp when the row was last modified.';
   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."G_AUD_ADD_USER_ID" IS 'The user ID or process that added the row.';
   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."G_AUD_ADD_TS" IS 'The timestamp when the row was added.';
   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."G_MFA_FST_TM_USR" IS 'The field contains the value of the MFA First Time User';
   COMMENT ON TABLE "ets_dev"."G_USER_TB"  IS 'The master user data originates in, and resides in, LDAP.  Custom code integrated with LDAP will synchronize the user data with "g user tb" for internal users.  The rows in "g user tb" can be queried as necessary (by Enterprise or other tools (e.g. Cognos)).  There is no need for Enterprise to modify the information in "g user tb".';


-- ======================================================================
-- Source: P_ALT_ID_TB_pg.sql
-- ======================================================================
CREATE TABLE "ets_dev"."P_ALT_ID_TB" ("P_SYS_ID" BIGINT NOT NULL, "P_ALT_ID_SK" BIGINT NOT NULL, "P_ALT_ID" VARCHAR(15 BYTE) NOT NULL, "P_ALT_ID_TY_CD" VARCHAR(3 BYTE) NOT NULL, "P_ALT_ID_BEG_DT" TIMESTAMP NOT NULL, "P_ALT_ID_SVC_LOCN_CD" VARCHAR(3 BYTE), "P_ALT_ID_END_DT" TIMESTAMP DEFAULT '9999-12-31' NOT NULL, "P_TAX_RPT_IND" VARCHAR(1 BYTE) NOT NULL, "L_HIBERNATE_VER_NUM" INTEGER DEFAULT 0 NOT NULL, "G_AUD_USER_ID" VARCHAR(30 BYTE) NOT NULL, "G_AUD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, "G_AUD_ADD_USER_ID" VARCHAR(30 BYTE) NOT NULL, "G_AUD_ADD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, "P_ALT_ID_VRFY_IND" VARCHAR(1 BYTE) DEFAULT NULL, CONSTRAINT "P_ALT_ID_F1" FOREIGN KEY ("P_SYS_ID") REFERENCES "ets_dev"."P_DTL_TB" ("P_SYS_ID") ) ;

CREATE UNIQUE INDEX "ets_dev"."P_ALT_ID_PK" ON "ets_dev"."P_ALT_ID_TB" ("P_SYS_ID", "P_ALT_ID_SK");

CREATE UNIQUE INDEX "ets_dev"."P_ALT_ID_UX1" ON "ets_dev"."P_ALT_ID_TB" ("P_ALT_ID", "P_ALT_ID_TY_CD", "P_ALT_ID_BEG_DT", "P_SYS_ID");

ALTER TABLE "ets_dev"."P_ALT_ID_TB" ADD CONSTRAINT "P_ALT_ID_PK" PRIMARY KEY ("P_SYS_ID", "P_ALT_ID_SK");

ALTER TABLE "ets_dev"."P_ALT_ID_TB" ADD CONSTRAINT "P_ALT_ID_UX1" UNIQUE ("P_ALT_ID", "P_ALT_ID_TY_CD", "P_ALT_ID_BEG_DT", "P_SYS_ID");

COMMENT ON COLUMN "ets_dev"."P_ALT_ID_TB"."P_SYS_ID" IS 'Provider Internal System Identifier.';

COMMENT ON COLUMN "ets_dev"."P_ALT_ID_TB"."P_ALT_ID_SK" IS 'Provider Alternate Identifier Surrogate Key';

COMMENT ON COLUMN "ets_dev"."P_ALT_ID_TB"."P_ALT_ID" IS 'An alternate identifier for a Provider. This may be used when a Provider is assigned an ID different than their primary ID (i.e. NABP Number, DEA Number) by a Customer or has multiple identifiers it can be recognized by.';

COMMENT ON COLUMN "ets_dev"."P_ALT_ID_TB"."P_ALT_ID_TY_CD" IS 'The Provider Alternate Identifier Type Code identifies the source of the identifier.';

COMMENT ON COLUMN "ets_dev"."P_ALT_ID_TB"."P_ALT_ID_BEG_DT" IS 'Provider Alternate ID Begin Date.';

COMMENT ON COLUMN "ets_dev"."P_ALT_ID_TB"."P_ALT_ID_SVC_LOCN_CD" IS 'Provider Alternate ID Service Location Code..';

COMMENT ON COLUMN "ets_dev"."P_ALT_ID_TB"."P_ALT_ID_END_DT" IS 'Provider Alternate ID End Date.';

COMMENT ON COLUMN "ets_dev"."P_ALT_ID_TB"."P_TAX_RPT_IND" IS 'Provider Tax Report Indicator.';

COMMENT ON COLUMN "ets_dev"."P_ALT_ID_TB"."L_HIBERNATE_VER_NUM" IS 'This supports hibernate caching mechanism and also supports the pessimistic Locking mechanism';

COMMENT ON COLUMN "ets_dev"."P_ALT_ID_TB"."G_AUD_USER_ID" IS 'The user ID or process that last modified the row.';

COMMENT ON COLUMN "ets_dev"."P_ALT_ID_TB"."G_AUD_TS" IS 'The timestamp when the row was last modified.';

COMMENT ON COLUMN "ets_dev"."P_ALT_ID_TB"."G_AUD_ADD_USER_ID" IS 'The user ID or process that added the row.';

COMMENT ON COLUMN "ets_dev"."P_ALT_ID_TB"."G_AUD_ADD_TS" IS 'The timestamp when the row was added.';

COMMENT ON COLUMN "ets_dev"."P_ALT_ID_TB"."P_ALT_ID_VRFY_IND" IS 'ID verified indicator';

COMMENT ON TABLE "ets_dev"."P_ALT_ID_TB" IS 'The Provider Alternative ID Table is for Provider Cross Reference.';

CREATE INDEX "ets_dev"."P_ALT_ID_IX1" ON "ets_dev"."P_ALT_ID_TB" ("P_SYS_ID");

CREATE UNIQUE INDEX "ets_dev"."P_ALT_ID_UX2" ON "ets_dev"."P_ALT_ID_TB" ("P_ALT_ID_SK");

-- ======================================================================
-- Source: P_DTL_TB_pg.sql
-- ======================================================================
CREATE TABLE "ets_dev"."P_DTL_TB" ("P_SYS_ID" BIGINT NOT NULL, "P_TY_CLASS_CD" VARCHAR(1 BYTE), "P_REC_TY_CD" VARCHAR(1 BYTE) DEFAULT 'A', "P_APPL_NUM" VARCHAR(15 BYTE), "P_LOCN_CD" VARCHAR(1 BYTE), "P_RA_SORT_SEQ_CD" VARCHAR(1 BYTE), "P_RA_PRT_SUSP_CD" VARCHAR(1 BYTE), "P_PRACT_TY_CD" VARCHAR(1 BYTE), "P_INDIV_GRP_CD" VARCHAR(1 BYTE), "P_OWNER_TY_CD" VARCHAR(1 BYTE), "P_NF_CLASS_CD" VARCHAR(2 BYTE), "P_PHARM_CLASS_CD" VARCHAR(1 BYTE), "P_DBA_NAM" VARCHAR(60 BYTE), "P_DBA_ORG_IND" VARCHAR(1 BYTE) NOT NULL, "P_DBA_LAST_NAM" VARCHAR(35 BYTE), "P_DBA_FIRST_NAM" VARCHAR(25 BYTE), "P_DBA_MID_NAM" VARCHAR(25 BYTE), "P_DBA_SFX_NAM" VARCHAR(10 BYTE), "P_NAM" VARCHAR(60 BYTE), "P_NAM_ORG_IND" VARCHAR(1 BYTE) DEFAULT 'N' NOT NULL, "P_LAST_NAM" VARCHAR(35 BYTE), "P_FIRST_NAM" VARCHAR(25 BYTE), "P_MID_NAM" VARCHAR(25 BYTE), "P_SFX_NAM" VARCHAR(10 BYTE), "P_MCARE_FY_MO_NUM" VARCHAR(2 BYTE), "P_MCAID_FY_MO_NUM" VARCHAR(2 BYTE), "P_COST_STTLMT_DT" TIMESTAMP, "P_BLLTN_MEDM_CD" VARCHAR(1 BYTE), "P_BLLTN_COPY_NUM" INTEGER, "P_MCARE_IND" VARCHAR(1 BYTE) NOT NULL, "P_BKUP_WHOLD_IND" VARCHAR(1 BYTE) NOT NULL, "P_MULTI_LOCN_IND" VARCHAR(1 BYTE) NOT NULL, "P_PRFT_IND" VARCHAR(1 BYTE) NOT NULL, "P_REVER_DT" TIMESTAMP, "P_BLNG_CD" VARCHAR(1 BYTE), "P_PROF_TECH_CD" VARCHAR(1 BYTE), "P_IHS_IND" VARCHAR(1 BYTE) NOT NULL, "P_SOLE_COMM_IND" VARCHAR(1 BYTE) NOT NULL, "P_EPSDT_ONLY_IND" VARCHAR(1 BYTE) NOT NULL, "P_ADD_DT" TIMESTAMP, "P_SORT_NAM" VARCHAR(60 BYTE), "P_STATE_MATCH_IND" VARCHAR(1 BYTE) NOT NULL, "P_PHNTC_SORT_NAM" VARCHAR(4 BYTE), "P_ENROL_ACTN_CD" VARCHAR(1 BYTE), "P_TPL_AUD_DT" TIMESTAMP, "P_TPL_AUD_TY_CD" VARCHAR(1 BYTE), "P_DUPL_OVRRD_IND" VARCHAR(1 BYTE) NOT NULL, "P_CANCEL_APPL_IND" VARCHAR(1 BYTE) NOT NULL, "P_DOB_DT" TIMESTAMP, "P_FSCL_END_MO_NUM" VARCHAR(2 BYTE), "P_BIRTH_CNTRY_CD" VARCHAR(3 BYTE), "P_GENDER_CD" VARCHAR(1 BYTE), "P_OPEN_24_IND" VARCHAR(1 BYTE) NOT NULL, "P_BIRTH_STATE_CD" VARCHAR(2 BYTE), "P_RACE_CD" VARCHAR(1 BYTE), "P_TITLE_CD" VARCHAR(5 BYTE), "P_HNDCPD_ACCS_IND" VARCHAR(1 BYTE) NOT NULL, "P_TEACH_HOSP_IND" VARCHAR(1 BYTE) NOT NULL, "P_TDD_TTY_IND" VARCHAR(1 BYTE) NOT NULL, "P_DBA_FMR_NAM" VARCHAR(60 BYTE), "P_IN_KIND_IND" VARCHAR(1 BYTE) NOT NULL, "P_DBA_YRS_NUM" SMALLINT, "P_DRIVE_THRU_IND" VARCHAR(1 BYTE) NOT NULL, "P_CURR_ALT_ID" VARCHAR(15 BYTE), "P_CURR_ALT_ID_TY_CD" VARCHAR(3 BYTE), "P_PEER_GRP_CD" VARCHAR(2 BYTE), "P_OTHER_LANG_TEXT" VARCHAR(40 BYTE), "P_PHNTC_LAST_NAM" VARCHAR(4 BYTE), "P_PHNTC_FIRST_NAM" VARCHAR(4 BYTE), "P_PHARM_DLVRY_SVC_IND" VARCHAR(1 BYTE) NOT NULL, "G_CMN_ENTY_SK" BIGINT NOT NULL, "G_NOTE_SET_SK" BIGINT, "L_HIBERNATE_VER_NUM" INTEGER DEFAULT 0 NOT NULL, "G_WEB_USER_ID" VARCHAR(30 BYTE), "G_AUD_USER_ID" VARCHAR(30 BYTE) NOT NULL, "G_AUD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, "G_AUD_ADD_USER_ID" VARCHAR(30 BYTE) NOT NULL, "G_AUD_ADD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, "P_LOCN_OVRRD_IND" VARCHAR(1 BYTE) DEFAULT 'N' NOT NULL, "P_SA_LTR_MEDM_CD" VARCHAR(1 BYTE), "P_LEGAL_NAM" VARCHAR(60 BYTE), "P_OWNER_ATTEST_IND" VARCHAR(1 BYTE), "P_AFTR_HRS_IND" VARCHAR(1 BYTE), "P_PRIM_WEBSITE_IND" VARCHAR(1 BYTE), "P_TELEHEALTH_IND" VARCHAR(1 BYTE), CONSTRAINT "P_DTL_F1" FOREIGN KEY ("G_NOTE_SET_SK") REFERENCES "ets_dev"."G_NOTE_SET_TB" ("G_NOTE_SET_SK"), CONSTRAINT "P_DTL_F2" FOREIGN KEY ("G_CMN_ENTY_SK") REFERENCES "ets_dev"."G_CMN_ENTY_TB" ("G_CMN_ENTY_SK") ) ;

CREATE UNIQUE INDEX "ets_dev"."P_DTL_PK" ON "ets_dev"."P_DTL_TB" ("P_SYS_ID");

ALTER TABLE "ets_dev"."P_DTL_TB" ADD CONSTRAINT "P_DTL_PK" PRIMARY KEY ("P_SYS_ID");

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_SYS_ID" IS 'Provider Internal System Identifier.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_TY_CLASS_CD" IS 'The Provider Type Class Code is the classification of the Provider Type.

1 = Physician, 2 = Dentist, 3 = Pharmacy, 4 = Institution';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_REC_TY_CD" IS 'This field is used to segregate those provider records that are still in the enrollment process from those that have completed the process and have been accepted as enrolled providers.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_APPL_NUM" IS 'A unique number assigned to each provider enrollment application form. This number is used to track the progress of the provider''s enrollment up to approval or denial. The number is assigned by the system at the time the data from the enrollment for is en';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_LOCN_CD" IS 'Indicates if the provider''s practice location is in-state, out-of-state or on the border.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_RA_SORT_SEQ_CD" IS 'This code indicates how the remittance advice is sorted before it is sent to the provider.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_RA_PRT_SUSP_CD" IS 'Whether to include Suspended claims into Remittance Advice';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_PRACT_TY_CD" IS 'This code indicates the legal organization that the provider belongs to.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_INDIV_GRP_CD" IS 'The Provider Individual or Group Code identifies whether the provider?s practice is an individual or group practice, for example:

I ? Individual provider / sole proprietorship

G ? Group provider / corporate partnership

B ? Independent practitioner / sole proprietor group

';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_OWNER_TY_CD" IS 'Describes the type of ownership for the provider.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_NF_CLASS_CD" IS 'This code indicates what type of nursing care is provided.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_PHARM_CLASS_CD" IS 'This explains what type of business a pharmacy provider participates in.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_DBA_NAM" IS 'The provider''s "doing business as" name.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_DBA_ORG_IND" IS 'Indicates that the DBA name is an organizational name.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_DBA_LAST_NAM" IS 'The doing business as last name.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_DBA_FIRST_NAM" IS 'The doing business as first name.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_DBA_MID_NAM" IS 'The doing business as middle initial.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_DBA_SFX_NAM" IS 'The doing business as name suffix.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_NAM" IS 'The legal name of the provider.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_NAM_ORG_IND" IS 'Indicates that the legal name of the provider is organizational.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_LAST_NAM" IS 'The legal last name of a provider.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_FIRST_NAM" IS 'The legal first name of a provider.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_MID_NAM" IS 'The legal middle name of a provider.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_SFX_NAM" IS 'The legal suffix of a provider.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_MCARE_FY_MO_NUM" IS 'The month number in which the providers Medicare Fiscal Year begins.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_MCAID_FY_MO_NUM" IS 'The month in which the providers Medicaid Fiscal Year begins.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_COST_STTLMT_DT" IS 'Date of the provider''s cost settlement with the State.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_BLLTN_MEDM_CD" IS 'The medium used to send bulletins to the provider.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_BLLTN_COPY_NUM" IS 'Number of copies of bulletins the provider needs to receive.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_MCARE_IND" IS 'A y/n value indicating if medicare providers were requested.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_BKUP_WHOLD_IND" IS 'Indicates the provider''s current W9 or tax withholding status, as related to B-Notice processing.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_MULTI_LOCN_IND" IS 'This indicates whether a provider practices in multiple locations and has more than one provider number. This indicator will have a value of ''Y'' of ''N''. It will default to ''N'' when the row is inserted.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_PRFT_IND" IS 'This indicates if this provider is a profit of non-profit provider. This indicator will have a value of ''Y'' of ''N''. It will default to ''Y'' (for profit) when the row is inserted.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_REVER_DT" IS 'This indicates the date by which the provider must reverify selected data. It has a DATE format and will default to ''0001-01-01'' when the row is inserted.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_BLNG_CD" IS 'This indicates who can bill (submit claims) and who can provide services.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_PROF_TECH_CD" IS 'Provider Professional Technical Indicator';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_IHS_IND" IS 'This indicates if the provider is an Indian Health Service provider. This indicator will have a value of ''Y'' or ''N''. It will default to ''N'' when the row is inserted.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_SOLE_COMM_IND" IS 'This indicates whether the provider participates in a community program. This indicator will have a value of ''Y'' or ''N''. It will default to ''N'' when the row is inserted.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_EPSDT_ONLY_IND" IS 'This indicates that the provider can only provide services for the EPSDT program. This indicator will have a value of ''Y'' or ''N''. It will default to ''N'' when the row is inserted.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_ADD_DT" IS 'The date the provider was added to the system.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_SORT_NAM" IS 'This is the provider sort name.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_STATE_MATCH_IND" IS 'This field indicates if the provider is eligible for state matching funds.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_PHNTC_SORT_NAM" IS 'This is the provider phonetic sort name.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_ENROL_ACTN_CD" IS 'A code indicating if the provider enrollment form being processed is for an initial enrollment or for a change of ownership.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_TPL_AUD_DT" IS 'The date of the last TPL audit for this provider.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_TPL_AUD_TY_CD" IS 'Indicated the type of TPL audit last performed for this provider.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_DUPL_OVRRD_IND" IS 'This indicator is checked when the user wants to override a duplicate SSN or TIN condition during provider enrollment.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_CANCEL_APPL_IND" IS 'This is an indicator for canceling a provider application.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_DOB_DT" IS 'Provider Date of Birth';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_FSCL_END_MO_NUM" IS 'This indicates the month when the fiscal year ends for the provider. Default to 00.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_BIRTH_CNTRY_CD" IS 'Country where the provider was born';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_GENDER_CD" IS 'This code represents the provider''s gender.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_OPEN_24_IND" IS 'Tells if a provider is open 24 hours.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_BIRTH_STATE_CD" IS 'State where the provider was born';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_RACE_CD" IS 'Provider Race Code.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_TITLE_CD" IS 'The provider''s title (MD, RN, LPN, etc...)';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_HNDCPD_ACCS_IND" IS 'Provider Handicapped Accessible Indicator.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_TEACH_HOSP_IND" IS 'Provider Teach Hospital Indicator.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_TDD_TTY_IND" IS 'Provider TDD TTY Indicator';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_DBA_FMR_NAM" IS 'Provider Name';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_IN_KIND_IND" IS 'Provider In Kind Indicator

If Yes, the provider is a type of state agency that provides Medicaid services. It is used during final payment calculations if a provider is in-kind, the payment is reduced to the amount that will be covered by Federal match money, so additional state-budgeted money is not transferred from DHHS to the other agency.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_DBA_YRS_NUM" IS 'The doing business as Year.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_DRIVE_THRU_IND" IS 'Provider Drive Through Indicator.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_CURR_ALT_ID" IS 'Provider Current Alternate ID.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_CURR_ALT_ID_TY_CD" IS 'The Provider Alternate Identifier Type Code identifies the source of the identifier.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_PEER_GRP_CD" IS 'Provider Peer Group Code';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_OTHER_LANG_TEXT" IS 'Provider Other Language Code';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_PHNTC_LAST_NAM" IS 'Provider Phonetic Last Name';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_PHNTC_FIRST_NAM" IS 'Provider Phonetic First Name';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_PHARM_DLVRY_SVC_IND" IS 'Indicates that the pharmacy offers delivery of pharmaceuticals or durable medical equipment.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."G_CMN_ENTY_SK" IS 'Common Entity Surrogate Key (pointing to the contact management data for the enrolled provider).';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."G_NOTE_SET_SK" IS 'Surrogate Key';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."L_HIBERNATE_VER_NUM" IS 'This supports hibernate caching mechanism and also supports the pessimistic Locking mechanism';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."G_WEB_USER_ID" IS 'User ID used in the web interface.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."G_AUD_USER_ID" IS 'The user ID or process that last modified the row.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."G_AUD_TS" IS 'The timestamp when the row was last modified.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."G_AUD_ADD_USER_ID" IS 'The user ID or process that added the row.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."G_AUD_ADD_TS" IS 'The timestamp when the row was added.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_SA_LTR_MEDM_CD" IS 'This controls if the provide receives their SA Letters in their Inbox or Mailbox.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_LEGAL_NAM" IS 'This field will capture the Legal Name of Providers.';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_OWNER_ATTEST_IND" IS 'Ownership Attestation Indicator';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_AFTR_HRS_IND" IS 'Provider Afterhours Indicator';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_PRIM_WEBSITE_IND" IS 'Primary Provider Website Indicator';

COMMENT ON COLUMN "ets_dev"."P_DTL_TB"."P_TELEHEALTH_IND" IS 'Telehealth Indicator';

COMMENT ON TABLE "ets_dev"."P_DTL_TB" IS 'The Provider Detail Table is the main provider Table, holding data that occurs once for a provider.';

CREATE INDEX "ets_dev"."P_DTL_IX1" ON "ets_dev"."P_DTL_TB" ("G_CMN_ENTY_SK");

-- ======================================================================
-- Source: P_ENROL_ALT_ID_TB_pg.sql
-- ======================================================================
CREATE TABLE "ets_dev"."P_ENROL_ALT_ID_TB" ( "P_SYS_ID" BIGINT NOT NULL, "P_ENROL_ALT_ID_SEQ_NUM" INTEGER NOT NULL, "P_ALT_ID" VARCHAR(15 BYTE) NOT NULL, "P_ENROL_ALT_ID_TY_CD" VARCHAR(3 BYTE) NOT NULL, "P_ENROL_ALT_ID_BEG_DT" TIMESTAMP, "P_ENROL_ALT_ID_END_DT" TIMESTAMP, "P_TAX_RPT_IND" VARCHAR(1 BYTE) NOT NULL, "L_HIBERNATE_VER_NUM" INTEGER DEFAULT 0 NOT NULL, "G_AUD_USER_ID" VARCHAR(30 BYTE) NOT NULL, "G_AUD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, "G_AUD_ADD_USER_ID" VARCHAR(30 BYTE) NOT NULL, "G_AUD_ADD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, CONSTRAINT "P_ENROL_ALT_ID_F1" FOREIGN KEY ("P_SYS_ID") REFERENCES "ets_dev"."P_DTL_TB" ("P_SYS_ID") ) ;

CREATE UNIQUE INDEX "ets_dev"."P_ENROL_ALT_ID_PK" ON "ets_dev"."P_ENROL_ALT_ID_TB" ("P_SYS_ID", "P_ENROL_ALT_ID_SEQ_NUM");

ALTER TABLE "ets_dev"."P_ENROL_ALT_ID_TB" ADD CONSTRAINT "P_ENROL_ALT_ID_PK" PRIMARY KEY ("P_SYS_ID", "P_ENROL_ALT_ID_SEQ_NUM");

COMMENT ON COLUMN "ets_dev"."P_ENROL_ALT_ID_TB"."P_SYS_ID" IS 'Provider Internal System Identifier.';

COMMENT ON COLUMN "ets_dev"."P_ENROL_ALT_ID_TB"."P_ENROL_ALT_ID_SEQ_NUM" IS 'Sequence Number';

COMMENT ON COLUMN "ets_dev"."P_ENROL_ALT_ID_TB"."P_ALT_ID" IS 'An alternate identifier for a Provider.  This may be used when a Provider is assigned an ID different than their primary ID (i.e. NABP Number, DEA Number) by a Customer or has multiple identifiers it can be recognized by.';

COMMENT ON COLUMN "ets_dev"."P_ENROL_ALT_ID_TB"."P_ENROL_ALT_ID_TY_CD" IS 'The Provider Alternate Identifier Type Code identifies the source of the identifier.';

COMMENT ON COLUMN "ets_dev"."P_ENROL_ALT_ID_TB"."P_ENROL_ALT_ID_BEG_DT" IS 'Provider Enrollment Alternate ID Begin Date.';

COMMENT ON COLUMN "ets_dev"."P_ENROL_ALT_ID_TB"."P_ENROL_ALT_ID_END_DT" IS 'Provider Enrollment Alternate ID End Date.';

COMMENT ON COLUMN "ets_dev"."P_ENROL_ALT_ID_TB"."P_TAX_RPT_IND" IS 'If the P_ALT_ID_TY_CD is "Tax ID" or "SSN" tells whether it should also be used for tax withholding.  Should only be used if the provider has both a Tax ID and an SSN.';

COMMENT ON COLUMN "ets_dev"."P_ENROL_ALT_ID_TB"."L_HIBERNATE_VER_NUM" IS 'This supports hibernate caching mechanism and also supports the pessimistic Locking mechanism';

COMMENT ON COLUMN "ets_dev"."P_ENROL_ALT_ID_TB"."G_AUD_USER_ID" IS 'The user ID or process that last modified the row.';

COMMENT ON COLUMN "ets_dev"."P_ENROL_ALT_ID_TB"."G_AUD_TS" IS 'The timestamp when the row was last modified.';

COMMENT ON COLUMN "ets_dev"."P_ENROL_ALT_ID_TB"."G_AUD_ADD_USER_ID" IS 'The user ID or process that added the row.';

COMMENT ON COLUMN "ets_dev"."P_ENROL_ALT_ID_TB"."G_AUD_ADD_TS" IS 'The timestamp when the row was added.';

COMMENT ON TABLE "ets_dev"."P_ENROL_ALT_ID_TB"  IS 'Provider Enroll Alternate ID Table';

-- ======================================================================
-- Source: P_LIC_CERT_TB_pg.sql
-- ======================================================================
CREATE TABLE "ets_dev"."P_LIC_CERT_TB" ( "P_SYS_ID" BIGINT NOT NULL, "P_LIC_CERT_SK" BIGINT NOT NULL, "P_LIC_CERT_NUM" VARCHAR(10 BYTE) NOT NULL, "P_LIC_CERT_CD" VARCHAR(2 BYTE) NOT NULL, "P_LIC_CERT_IND_CD" VARCHAR(1 BYTE) NOT NULL, "P_LIC_CERT_BEG_DT" TIMESTAMP NOT NULL, "P_LIC_CERT_END_DT" TIMESTAMP DEFAULT '9999-12-31' NOT NULL, "P_LIC_RSTRCT_CD" VARCHAR(1 BYTE) DEFAULT 'N', "P_LIC_VRFY_IND" VARCHAR(1 BYTE) DEFAULT 'N' NOT NULL, "P_LIC_CERT_AGCY_CD" VARCHAR(3 BYTE), "P_LIC_PRMT_ID" VARCHAR(30 BYTE), "P_LIC_CERT_STATE_CD" VARCHAR(2 BYTE), "L_HIBERNATE_VER_NUM" INTEGER DEFAULT 0 NOT NULL, "G_AUD_USER_ID" VARCHAR(30 BYTE) NOT NULL, "G_AUD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, "G_AUD_ADD_USER_ID" VARCHAR(30 BYTE) NOT NULL, "G_AUD_ADD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, CONSTRAINT "P_LIC_CERT_F1" FOREIGN KEY ("P_SYS_ID") REFERENCES "ets_dev"."P_DTL_TB" ("P_SYS_ID") ) ;

CREATE UNIQUE INDEX "ets_dev"."P_LIC_CERT_PK" ON "ets_dev"."P_LIC_CERT_TB" ("P_SYS_ID", "P_LIC_CERT_SK");

CREATE UNIQUE INDEX "ets_dev"."P_LIC_CERT_UX1" ON "ets_dev"."P_LIC_CERT_TB" ("P_SYS_ID", "P_LIC_CERT_NUM", "P_LIC_CERT_CD", "P_LIC_CERT_IND_CD", "P_LIC_CERT_BEG_DT");

ALTER TABLE "ets_dev"."P_LIC_CERT_TB" ADD CONSTRAINT "P_LIC_CERT_PK" PRIMARY KEY ("P_SYS_ID", "P_LIC_CERT_SK");

ALTER TABLE "ets_dev"."P_LIC_CERT_TB" ADD CONSTRAINT "P_LIC_CERT_UX1" UNIQUE ("P_SYS_ID", "P_LIC_CERT_NUM", "P_LIC_CERT_CD", "P_LIC_CERT_IND_CD", "P_LIC_CERT_BEG_DT");

COMMENT ON COLUMN "ets_dev"."P_LIC_CERT_TB"."P_SYS_ID" IS 'Provider Internal System Identifier.';

COMMENT ON COLUMN "ets_dev"."P_LIC_CERT_TB"."P_LIC_CERT_SK" IS 'Provider License Certificate Surrogate Key';

COMMENT ON COLUMN "ets_dev"."P_LIC_CERT_TB"."P_LIC_CERT_NUM" IS 'The provider''s certification number.';

COMMENT ON COLUMN "ets_dev"."P_LIC_CERT_TB"."P_LIC_CERT_CD" IS 'The type of license certification for a provider.';

COMMENT ON COLUMN "ets_dev"."P_LIC_CERT_TB"."P_LIC_CERT_IND_CD" IS 'Tells whether the row is for a license or certification';

COMMENT ON COLUMN "ets_dev"."P_LIC_CERT_TB"."P_LIC_CERT_BEG_DT" IS 'Identifies the effective date of the provider''s license.';

COMMENT ON COLUMN "ets_dev"."P_LIC_CERT_TB"."P_LIC_CERT_END_DT" IS 'The date on which the provider''s license is to expire.';

COMMENT ON COLUMN "ets_dev"."P_LIC_CERT_TB"."P_LIC_RSTRCT_CD" IS 'The reason that a provider''s license is restricted.';

COMMENT ON COLUMN "ets_dev"."P_LIC_CERT_TB"."P_LIC_VRFY_IND" IS 'Indicates whether the provider''s license has been verified.';

COMMENT ON COLUMN "ets_dev"."P_LIC_CERT_TB"."P_LIC_CERT_AGCY_CD" IS 'Provider License Board Name Code.';

COMMENT ON COLUMN "ets_dev"."P_LIC_CERT_TB"."P_LIC_PRMT_ID" IS 'The name of the Permit holder associtated with the provider''s license or permit.';

COMMENT ON COLUMN "ets_dev"."P_LIC_CERT_TB"."P_LIC_CERT_STATE_CD" IS 'The provider''s certification State Code.';

COMMENT ON COLUMN "ets_dev"."P_LIC_CERT_TB"."L_HIBERNATE_VER_NUM" IS 'This supports hibernate caching mechanism and also supports the pessimistic Locking mechanism';

COMMENT ON COLUMN "ets_dev"."P_LIC_CERT_TB"."G_AUD_USER_ID" IS 'The user ID or process that last modified the row.';

COMMENT ON COLUMN "ets_dev"."P_LIC_CERT_TB"."G_AUD_TS" IS 'The timestamp when the row was last modified.';

COMMENT ON COLUMN "ets_dev"."P_LIC_CERT_TB"."G_AUD_ADD_USER_ID" IS 'The user ID or process that added the row.';

COMMENT ON COLUMN "ets_dev"."P_LIC_CERT_TB"."G_AUD_ADD_TS" IS 'The timestamp when the row was added.';

COMMENT ON TABLE "ets_dev"."P_LIC_CERT_TB"  IS 'The Provider License Certification Table contains license information for a provider.';

CREATE UNIQUE INDEX "ets_dev"."P_LIC_CERT_UX2" ON "ets_dev"."P_LIC_CERT_TB" ("P_LIC_CERT_SK");

-- ======================================================================
-- Source: P_TXNMY_TB_pg.sql
-- ======================================================================
CREATE TABLE "ets_dev"."P_TXNMY_TB" ("P_SYS_ID" BIGINT NOT NULL, "P_TXNMY_SK" BIGINT NOT NULL, "P_TXNMY_CD" VARCHAR(10 BYTE) NOT NULL, "P_TXNMY_BEG_DT" TIMESTAMP NOT NULL, "P_TXNMY_END_DT" TIMESTAMP DEFAULT '9999-12-31' NOT NULL, "L_HIBERNATE_VER_NUM" INTEGER DEFAULT 0 NOT NULL, "G_AUD_USER_ID" VARCHAR(30 BYTE) NOT NULL, "G_AUD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, "G_AUD_ADD_USER_ID" VARCHAR(30 BYTE) NOT NULL, "G_AUD_ADD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, CONSTRAINT "P_TXNMY_F1" FOREIGN KEY ("P_SYS_ID") REFERENCES "ets_dev"."P_DTL_TB" ("P_SYS_ID") ) ;

CREATE UNIQUE INDEX "ets_dev"."P_TXNMY_PK" ON "ets_dev"."P_TXNMY_TB" ("P_SYS_ID", "P_TXNMY_SK");

CREATE UNIQUE INDEX "ets_dev"."P_TXNMY_UX1" ON "ets_dev"."P_TXNMY_TB" ("P_SYS_ID", "P_TXNMY_CD", "P_TXNMY_BEG_DT");

ALTER TABLE "ets_dev"."P_TXNMY_TB" ADD CONSTRAINT "P_TXNMY_PK" PRIMARY KEY ("P_SYS_ID", "P_TXNMY_SK");

ALTER TABLE "ets_dev"."P_TXNMY_TB" ADD CONSTRAINT "P_TXNMY_UX1" UNIQUE ("P_SYS_ID", "P_TXNMY_CD", "P_TXNMY_BEG_DT");

COMMENT ON COLUMN "ets_dev"."P_TXNMY_TB"."P_SYS_ID" IS 'Provider Internal System Identifier.';

COMMENT ON COLUMN "ets_dev"."P_TXNMY_TB"."P_TXNMY_SK" IS 'Provider Taxonomy Surrogate Key';

COMMENT ON COLUMN "ets_dev"."P_TXNMY_TB"."P_TXNMY_CD" IS 'The Taxonomy code for the provider, as per HIPAA requirements.';

COMMENT ON COLUMN "ets_dev"."P_TXNMY_TB"."P_TXNMY_BEG_DT" IS 'The begin date for the taxonomy code.';

COMMENT ON COLUMN "ets_dev"."P_TXNMY_TB"."P_TXNMY_END_DT" IS 'The date a provider taxonomy code ends.';

COMMENT ON COLUMN "ets_dev"."P_TXNMY_TB"."L_HIBERNATE_VER_NUM" IS 'This supports hibernate caching mechanism and also supports the pessimistic Locking mechanism';

COMMENT ON COLUMN "ets_dev"."P_TXNMY_TB"."G_AUD_USER_ID" IS 'The user ID or process that last modified the row.';

COMMENT ON COLUMN "ets_dev"."P_TXNMY_TB"."G_AUD_TS" IS 'The timestamp when the row was last modified.';

COMMENT ON COLUMN "ets_dev"."P_TXNMY_TB"."G_AUD_ADD_USER_ID" IS 'The user ID or process that added the row.';

COMMENT ON COLUMN "ets_dev"."P_TXNMY_TB"."G_AUD_ADD_TS" IS 'The timestamp when the row was added.';

COMMENT ON TABLE "ets_dev"."P_TXNMY_TB" IS 'The Provider TaxonomyTable contains Provider Taxonomy codes for HIPAA compliance.';

CREATE UNIQUE INDEX "ets_dev"."P_TXNMY_UX2" ON "ets_dev"."P_TXNMY_TB" ("P_TXNMY_SK");

-- ======================================================================
-- Source: P_TY_TB_pg.sql
-- ======================================================================
CREATE TABLE "ets_dev"."P_TY_TB" ("P_SYS_ID" BIGINT NOT NULL, "P_TY_SK" BIGINT NOT NULL, "P_TY_CD" VARCHAR(3 BYTE) NOT NULL, "L_HIBERNATE_VER_NUM" INTEGER DEFAULT 0 NOT NULL, "G_AUD_USER_ID" VARCHAR(30 BYTE) NOT NULL, "G_AUD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, "G_AUD_ADD_USER_ID" VARCHAR(30 BYTE) NOT NULL, "G_AUD_ADD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, CONSTRAINT "P_TY_F1" FOREIGN KEY ("P_SYS_ID") REFERENCES "ets_dev"."P_DTL_TB" ("P_SYS_ID") ) ;

CREATE UNIQUE INDEX "ets_dev"."P_TY_PK" ON "ets_dev"."P_TY_TB" ("P_SYS_ID", "P_TY_SK");

ALTER TABLE "ets_dev"."P_TY_TB" ADD CONSTRAINT "P_TY_PK" PRIMARY KEY ("P_SYS_ID", "P_TY_SK");

COMMENT ON COLUMN "ets_dev"."P_TY_TB"."P_SYS_ID" IS 'Provider Internal System Identifier.';

COMMENT ON COLUMN "ets_dev"."P_TY_TB"."P_TY_SK" IS 'Provider Type Surrogate Key';

COMMENT ON COLUMN "ets_dev"."P_TY_TB"."P_TY_CD" IS 'A code that designates the State''s classification of providers.';

COMMENT ON COLUMN "ets_dev"."P_TY_TB"."L_HIBERNATE_VER_NUM" IS 'This supports hibernate caching mechanism and also supports the pessimistic Locking mechanism';

COMMENT ON COLUMN "ets_dev"."P_TY_TB"."G_AUD_USER_ID" IS 'The user ID or process that last modified the row.';

COMMENT ON COLUMN "ets_dev"."P_TY_TB"."G_AUD_TS" IS 'The timestamp when the row was last modified.';

COMMENT ON COLUMN "ets_dev"."P_TY_TB"."G_AUD_ADD_USER_ID" IS 'The user ID or process that added the row.';

COMMENT ON COLUMN "ets_dev"."P_TY_TB"."G_AUD_ADD_TS" IS 'The timestamp when the row was added.';

COMMENT ON TABLE "ets_dev"."P_TY_TB" IS 'The Provider Type Table contains information about different provider types.';

CREATE UNIQUE INDEX "ets_dev"."P_TY_UX1" ON "ets_dev"."P_TY_TB" ("P_TY_SK");

CREATE UNIQUE INDEX "ets_dev"."P_TY_UX2" ON "ets_dev"."P_TY_TB" ("P_SYS_ID");

-- ======================================================================
-- Source: R_DD_COL_TB.sql
-- ======================================================================
--------------------------------------------------------
--  DDL for Table R_DD_COL_TB
--------------------------------------------------------

  CREATE TABLE "ets_dev"."R_DD_COL_TB"
   (	"R_TABLE_NAM" VARCHAR(30),
	"R_COL_NAM" VARCHAR(30),
	"R_ADDL_BUSN_NAM" VARCHAR(40),
	"R_ADDL_BUSN_DESC" VARCHAR(320),
	"R_ORDNL_NUM" SMALLINT,
	"R_PK_NUM" SMALLINT,
	"R_REQD_VALUE_IND" VARCHAR(1) DEFAULT 'N',
	"R_DOMAIN_NAM" VARCHAR(30),
	"L_HIBERNATE_VER_NUM" INTEGER DEFAULT 0,
	"G_AUD_USER_ID" VARCHAR(30),
	"G_AUD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_AUD_ADD_USER_ID" VARCHAR(30),
	"G_AUD_ADD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"R_ASCTD_SEQ_NAM" VARCHAR(30),
	"R_DD_COL_SK" BIGINT
   );

   COMMENT ON COLUMN "ets_dev"."R_DD_COL_TB"."R_TABLE_NAM" IS 'Data Dictionary Table Definition.  One row exists for each table defined for the Enterprise MMIS application.';
   COMMENT ON COLUMN "ets_dev"."R_DD_COL_TB"."R_COL_NAM" IS 'Column Name';
   COMMENT ON COLUMN "ets_dev"."R_DD_COL_TB"."R_ADDL_BUSN_NAM" IS 'Short name.  Will display on pop-ups.';
   COMMENT ON COLUMN "ets_dev"."R_DD_COL_TB"."R_ADDL_BUSN_DESC" IS 'More verbose description than business name.';
   COMMENT ON COLUMN "ets_dev"."R_DD_COL_TB"."R_ORDNL_NUM" IS 'Specifies what order in the this column appears in the table.';
   COMMENT ON COLUMN "ets_dev"."R_DD_COL_TB"."R_PK_NUM" IS 'Indicates whether or not this attribute participates in the PK.';
   COMMENT ON COLUMN "ets_dev"."R_DD_COL_TB"."R_REQD_VALUE_IND" IS 'Indicates whether this column allows null values.';
   COMMENT ON COLUMN "ets_dev"."R_DD_COL_TB"."R_DOMAIN_NAM" IS 'Domain Name';
   COMMENT ON COLUMN "ets_dev"."R_DD_COL_TB"."L_HIBERNATE_VER_NUM" IS 'This supports hibernate caching mechanism and also supports the pessimistic Locking mechanism';
   COMMENT ON COLUMN "ets_dev"."R_DD_COL_TB"."G_AUD_USER_ID" IS 'The user ID or process that last modified the row.';
   COMMENT ON COLUMN "ets_dev"."R_DD_COL_TB"."G_AUD_TS" IS 'The timestamp when the row was last modified.';
   COMMENT ON COLUMN "ets_dev"."R_DD_COL_TB"."G_AUD_ADD_USER_ID" IS 'The user ID or process that added the row.';
   COMMENT ON COLUMN "ets_dev"."R_DD_COL_TB"."G_AUD_ADD_TS" IS 'The timestamp when the row was added.';
   COMMENT ON TABLE "ets_dev"."R_DD_COL_TB"  IS 'The Data Dictionary Column Definition Table contains every combination of table/column in the Enterprise database.';


-- ======================================================================
-- Source: R_PARAM_DTL_TB.sql
-- ======================================================================
--------------------------------------------------------
--  DDL for Table R_PARAM_DTL_TB
--------------------------------------------------------

  CREATE TABLE "ets_dev"."R_PARAM_DTL_TB"
   (	"R_FUNC_AREA_CD" VARCHAR(2),
	"R_PARAM_NUM" BIGINT,
	"R_PARAM_DTL_SK" BIGINT,
	"R_LOB_CD" VARCHAR(3),
	"R_PARAM_BEG_DT" TIMESTAMP,
	"R_VOID_DT" TIMESTAMP,
	"R_PARAM_END_DT" TIMESTAMP,
	"R_PARAM_VALUE_DT" TIMESTAMP,
	"R_PARAM_VALUE_TS" TIMESTAMP,
	"R_PARAM_VALUE_AMT" NUMERIC(11,2),
	"R_PARAM_VALUE_PCT" NUMERIC(5,4),
	"R_PARAM_VALUE_NUM" BIGINT,
	"R_PARAM_VALUE_DATA" VARCHAR(60),
	"L_HIBERNATE_VER_NUM" INTEGER DEFAULT 0,
	"G_AUD_USER_ID" VARCHAR(30),
	"G_AUD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_AUD_ADD_USER_ID" VARCHAR(30),
	"G_AUD_ADD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP
   );

   COMMENT ON COLUMN "ets_dev"."R_PARAM_DTL_TB"."R_FUNC_AREA_CD" IS 'Functional Area Code, identifying the functional team that is responsible for maintenance of codes.';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_DTL_TB"."R_PARAM_NUM" IS 'This field contains the unique number associated with the system parameter.';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_DTL_TB"."R_PARAM_DTL_SK" IS 'Reference Parameter Detail Surrogate Key';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_DTL_TB"."R_LOB_CD" IS 'This field indicates a line of business code to be used for system processing. The line of business is used to identify the entities that have fiscal responsibility for payment of insurance claims on behalf of their respective members.';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_DTL_TB"."R_PARAM_BEG_DT" IS 'The start date for the parameter.';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_DTL_TB"."R_VOID_DT" IS 'The date the associated data was inactivated';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_DTL_TB"."R_PARAM_END_DT" IS 'This field is the end date on which the value for the system parameter is valid.';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_DTL_TB"."R_PARAM_VALUE_DT" IS 'If the data format type for this system parameter is defined as date, this field is the date value associated with the parameter.';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_DTL_TB"."R_PARAM_VALUE_TS" IS 'Parameter Value Timestamp.';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_DTL_TB"."R_PARAM_VALUE_AMT" IS 'If the data format type for this system parameter is defined as currency, this field is the dollar amount associated with the parameter.';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_DTL_TB"."R_PARAM_VALUE_PCT" IS 'If the data format type for this system parameter is defined as a percentage, this field is the percent associated with the parameter.';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_DTL_TB"."R_PARAM_VALUE_NUM" IS 'If the data format type for this system parameter is defined as numeric, this field contains the number associated with the parameter.';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_DTL_TB"."R_PARAM_VALUE_DATA" IS 'If the data format for this system parameter is defined as alphanumeric text, this field contains the character string value associated with the parameter.';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_DTL_TB"."L_HIBERNATE_VER_NUM" IS 'This supports hibernate caching mechanism and also supports the pessimistic Locking mechanism';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_DTL_TB"."G_AUD_USER_ID" IS 'The user ID or process that last modified the row.';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_DTL_TB"."G_AUD_TS" IS 'The timestamp when the row was last modified.';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_DTL_TB"."G_AUD_ADD_USER_ID" IS 'The user ID or process that added the row.';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_DTL_TB"."G_AUD_ADD_TS" IS 'The timestamp when the row was added.';
   COMMENT ON TABLE "ets_dev"."R_PARAM_DTL_TB"  IS 'Reference Parameter Detail Table';


-- ======================================================================
-- Source: R_PARAM_TB.sql
-- ======================================================================
--------------------------------------------------------
--  DDL for Table R_PARAM_TB
--------------------------------------------------------

  CREATE TABLE "ets_dev"."R_PARAM_TB"
   (	"R_FUNC_AREA_CD" VARCHAR(2),
	"R_PARAM_NUM" BIGINT,
	"R_PARAM_NAM" VARCHAR(50),
	"R_PARAM_TY_CD" VARCHAR(1),
	"G_NOTE_SET_SK" BIGINT,
	"L_HIBERNATE_VER_NUM" INTEGER DEFAULT 0,
	"G_AUD_USER_ID" VARCHAR(30),
	"G_AUD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_AUD_ADD_USER_ID" VARCHAR(30),
	"G_AUD_ADD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP
   );

   COMMENT ON COLUMN "ets_dev"."R_PARAM_TB"."R_FUNC_AREA_CD" IS 'Functional Area Code, identifying the functional team that is responsible for maintenance of codes.';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_TB"."R_PARAM_NUM" IS 'This field contains the unique number associated with the system parameter.';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_TB"."R_PARAM_NAM" IS 'This field contains the name of the system parameter.';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_TB"."R_PARAM_TY_CD" IS 'This code identifies what type of data is stored in the System Parameter row.';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_TB"."G_NOTE_SET_SK" IS 'Surrogate Key';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_TB"."L_HIBERNATE_VER_NUM" IS 'This supports hibernate caching mechanism and also supports the pessimistic Locking mechanism';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_TB"."G_AUD_USER_ID" IS 'The user ID or process that last modified the row.';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_TB"."G_AUD_TS" IS 'The timestamp when the row was last modified.';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_TB"."G_AUD_ADD_USER_ID" IS 'The user ID or process that added the row.';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_TB"."G_AUD_ADD_TS" IS 'The timestamp when the row was added.';
   COMMENT ON TABLE "ets_dev"."R_PARAM_TB"  IS 'Reference Parameter Table';


-- ======================================================================
-- Source: R_VV_TB.sql
-- ======================================================================

 --------------------------------------------------------
--  DDL for Table R_VV_TB
--------------------------------------------------------

 CREATE TABLE "ets_dev"."R_VV_TB"
   (	"R_VV_DOMAIN_NAM" VARCHAR(30) NOT NULL ,
	"R_VV_CD" VARCHAR(15) NOT NULL ,
	"R_VOID_DT" TIMESTAMP,
	"R_VV_SHORT_DESC" VARCHAR(10),
	"R_VV_LONG_DESC" VARCHAR(40),
	"L_HIBERNATE_VER_NUM" INTEGER DEFAULT 0 NOT NULL ,
	"G_AUD_USER_ID" VARCHAR(30) NOT NULL ,
	"G_AUD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	"G_AUD_ADD_USER_ID" VARCHAR(30) NOT NULL ,
	"G_AUD_ADD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	"R_CNSTNT_TEXT" VARCHAR(50),
	"R_USED_IN_APPL_IND" VARCHAR(1) DEFAULT 'N' NOT NULL ,     CONSTRAINT "R_VV_F1" FOREIGN KEY ("R_VV_DOMAIN_NAM")
	  REFERENCES "ets_dev"."R_VV_DOMAIN_TB" ("R_VV_DOMAIN_NAM")
   );
  CREATE UNIQUE INDEX "ets_dev"."R_VV_PK" ON "ets_dev"."R_VV_TB" ("R_VV_DOMAIN_NAM", "R_VV_CD");
ALTER TABLE "ets_dev"."R_VV_TB" ADD CONSTRAINT "R_VV_PK" PRIMARY KEY ("R_VV_DOMAIN_NAM", "R_VV_CD") ;

   COMMENT ON COLUMN "ets_dev"."R_VV_TB"."R_VV_DOMAIN_NAM" IS 'Valid Value Domain Name.  This is the data domain as defined in R_VV_DOMAIN_TB, with which a set of valid values may be associated.';
   COMMENT ON COLUMN "ets_dev"."R_VV_TB"."R_VV_CD" IS 'Valid Value Code.  This identifies one specific valid value for the associated data domain.';
   COMMENT ON COLUMN "ets_dev"."R_VV_TB"."R_VOID_DT" IS 'The date the associated data was inactivated';
   COMMENT ON COLUMN "ets_dev"."R_VV_TB"."R_VV_SHORT_DESC" IS 'Short Description of the valid value code.';
   COMMENT ON COLUMN "ets_dev"."R_VV_TB"."R_VV_LONG_DESC" IS 'Long description of the valid value code.';
   COMMENT ON COLUMN "ets_dev"."R_VV_TB"."L_HIBERNATE_VER_NUM" IS 'This supports hibernate caching mechanism and also supports the pessimistic Locking mechanism';
   COMMENT ON COLUMN "ets_dev"."R_VV_TB"."G_AUD_USER_ID" IS 'The user ID or process that last modified the row.';
   COMMENT ON COLUMN "ets_dev"."R_VV_TB"."G_AUD_TS" IS 'The timestamp when the row was last modified.';
   COMMENT ON COLUMN "ets_dev"."R_VV_TB"."G_AUD_ADD_USER_ID" IS 'The user ID or process that added the row.';
   COMMENT ON COLUMN "ets_dev"."R_VV_TB"."G_AUD_ADD_TS" IS 'The timestamp when the row was added.';
   COMMENT ON COLUMN "ets_dev"."R_VV_TB"."R_CNSTNT_TEXT" IS 'This column is used to generate a constant
 file that can be used in java code as a mnemonic for code values, rather than hard coding the codes
 themselves.';
   COMMENT ON COLUMN "ets_dev"."R_VV_TB"."R_USED_IN_APPL_IND" IS 'Indicates that a valid value is used within the application code.';
   COMMENT ON TABLE "ets_dev"."R_VV_TB"  IS 'The Reference Valid Value Table defines the set of valid values that are associated with a specific data domain, and is used for all generic code fields which do not require any additional information, other than a long and short description, and whose set of valid values are reasonably limited in number.';

  /* TODO(ets_dev): Oracle PL/SQL trigger not auto-converted — rewrite as a Postgres trigger function.
CREATE OR REPLACE EDITIONABLE TRIGGER "ets_dev"."R_CNSTNT_TR"
   BEFORE INSERT
   ON ets_dev.R_VV_TB
   REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
BEGIN
   IF :new.r_cnstnt_text IS NULL
   THEN
      :new.r_cnstnt_text :=
              replace_invalid_fn (UPPER ('VV_' || UPPER (:new.r_vv_short_desc)));
   END IF;
END r_cnstnt_tr;
/
ALTER TRIGGER "ets_dev"."R_CNSTNT_TR" ;
*/

