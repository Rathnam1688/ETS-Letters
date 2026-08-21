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
