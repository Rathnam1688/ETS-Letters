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
