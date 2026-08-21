CREATE TABLE "ets_dev"."P_ENROL_ALT_ID_TB" ( "P_SYS_ID" BIGINT NOT NULL, "P_ENROL_ALT_ID_SEQ_NUM" INTEGER NOT NULL, "P_ALT_ID" VARCHAR(15 BYTE) NOT NULL, "P_ENROL_ALT_ID_TY_CD" VARCHAR(3 BYTE) NOT NULL, "P_ENROL_ALT_ID_BEG_DT" TIMESTAMP, "P_ENROL_ALT_ID_END_DT" TIMESTAMP, "P_TAX_RPT_IND" VARCHAR(1 BYTE) NOT NULL, "L_HIBERNATE_VER_NUM" INTEGER DEFAULT 0 NOT NULL, "G_AUD_USER_ID" VARCHAR(30 BYTE) NOT NULL, "G_AUD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, "G_AUD_ADD_USER_ID" VARCHAR(30 BYTE) NOT NULL, "G_AUD_ADD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, CONSTRAINT "P_ENROL_ALT_ID_F1" FOREIGN KEY ("P_SYS_ID") REFERENCES "ets_dev"."P_DTL_TB" ("P_SYS_ID") ) ;

CREATE UNIQUE INDEX "ets_dev"."P_ENROL_ALT_ID_PK" ON "ets_dev"."P_ENROL_ALT_ID_TB" ("P_SYS_ID", "P_ENROL_ALT_ID_SEQ_NUM");

ALTER TABLE "ets_dev"."P_ENROL_ALT_ID_TB" ADD CONSTRAINT "P_ENROL_ALT_ID_PK" PRIMARY KEY ("P_SYS_ID", "P_ENROL_ALT_ID_SEQ_NUM");

COMMENT ON COLUMN "ets_dev"."P_ENROL_ALT_ID_TB"."P_SYS_ID" IS 'Provider Internal System Identifier.';

COMMENT ON COLUMN "ets_dev"."P_ENROL_ALT_ID_TB"."P_ENROL_ALT_ID_SEQ_NUM" IS 'Sequence Number';

COMMENT ON COLUMN "ets_dev"."P_ENROL_ALT_ID_TB"."P_ALT_ID" IS 'An alternate identifier for a Provider.  This may be used when a Provider is assigned an ID different than their primary ID (i.e. NABP Number, DEA Number) by a Customer or has multiple identifiers it can be recognized by.';

COMMENT ON COLUMN "ets_dev"."P_ENROL_ALT_ID_TB"."P_ENROL_ALT_ID_TY_CD" IS 'The Provider Alternate Identifier Type Code identifies the source of the identifier.';

COMMENT ON COLUMN "ets_dev"."P_ENROL_ALT_ID_TB"."P_ENROL_ALT_ID_BEG_DT" IS 'Provider Enrollment Alternate ID Begin Date.';

COMMENT ON COLUMN "ets_dev"."P_ENROL_ALT_ID_TB"."P_ENROL_ALT_ID_END_DT" IS 'Provider Enrollment Alternate ID End Date.';

COMMENT ON COLUMN "ets_dev"."P_ENROL_ALT_ID_TB"."P_TAX_RPT_IND" IS 'If the P_ALT_ID_TY_CD is "Tax ID" or "SSN" tells whether it should also be used for tax withholding.  Should only be used if the provider has both a Tax ID and an SSN.';

COMMENT ON COLUMN "ets_dev"."P_ENROL_ALT_ID_TB"."L_HIBERNATE_VER_NUM" IS 'This supports hibernate caching mechanism and also supports the pessimistic Locking mechanism';

COMMENT ON COLUMN "ets_dev"."P_ENROL_ALT_ID_TB"."G_AUD_USER_ID" IS 'The user ID or process that last modified the row.';

COMMENT ON COLUMN "ets_dev"."P_ENROL_ALT_ID_TB"."G_AUD_TS" IS 'The timestamp when the row was last modified.';

COMMENT ON COLUMN "ets_dev"."P_ENROL_ALT_ID_TB"."G_AUD_ADD_USER_ID" IS 'The user ID or process that added the row.';

COMMENT ON COLUMN "ets_dev"."P_ENROL_ALT_ID_TB"."G_AUD_ADD_TS" IS 'The timestamp when the row was added.';

COMMENT ON TABLE "ets_dev"."P_ENROL_ALT_ID_TB"  IS 'Provider Enroll Alternate ID Table';