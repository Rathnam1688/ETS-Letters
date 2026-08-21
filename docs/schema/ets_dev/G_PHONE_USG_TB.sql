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
