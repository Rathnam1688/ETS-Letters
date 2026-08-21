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
