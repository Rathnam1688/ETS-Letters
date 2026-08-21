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
