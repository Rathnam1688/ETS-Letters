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