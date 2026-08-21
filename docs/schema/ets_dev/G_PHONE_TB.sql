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
