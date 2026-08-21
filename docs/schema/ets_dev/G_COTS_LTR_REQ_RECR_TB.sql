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
