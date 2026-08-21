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