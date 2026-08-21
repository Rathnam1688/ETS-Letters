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
