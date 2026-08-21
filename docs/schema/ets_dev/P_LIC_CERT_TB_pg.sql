CREATE TABLE "ets_dev"."P_LIC_CERT_TB" ( "P_SYS_ID" BIGINT NOT NULL, "P_LIC_CERT_SK" BIGINT NOT NULL, "P_LIC_CERT_NUM" VARCHAR(10 BYTE) NOT NULL, "P_LIC_CERT_CD" VARCHAR(2 BYTE) NOT NULL, "P_LIC_CERT_IND_CD" VARCHAR(1 BYTE) NOT NULL, "P_LIC_CERT_BEG_DT" TIMESTAMP NOT NULL, "P_LIC_CERT_END_DT" TIMESTAMP DEFAULT '9999-12-31' NOT NULL, "P_LIC_RSTRCT_CD" VARCHAR(1 BYTE) DEFAULT 'N', "P_LIC_VRFY_IND" VARCHAR(1 BYTE) DEFAULT 'N' NOT NULL, "P_LIC_CERT_AGCY_CD" VARCHAR(3 BYTE), "P_LIC_PRMT_ID" VARCHAR(30 BYTE), "P_LIC_CERT_STATE_CD" VARCHAR(2 BYTE), "L_HIBERNATE_VER_NUM" INTEGER DEFAULT 0 NOT NULL, "G_AUD_USER_ID" VARCHAR(30 BYTE) NOT NULL, "G_AUD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, "G_AUD_ADD_USER_ID" VARCHAR(30 BYTE) NOT NULL, "G_AUD_ADD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, CONSTRAINT "P_LIC_CERT_F1" FOREIGN KEY ("P_SYS_ID") REFERENCES "ets_dev"."P_DTL_TB" ("P_SYS_ID") ) ;

CREATE UNIQUE INDEX "ets_dev"."P_LIC_CERT_PK" ON "ets_dev"."P_LIC_CERT_TB" ("P_SYS_ID", "P_LIC_CERT_SK");

CREATE UNIQUE INDEX "ets_dev"."P_LIC_CERT_UX1" ON "ets_dev"."P_LIC_CERT_TB" ("P_SYS_ID", "P_LIC_CERT_NUM", "P_LIC_CERT_CD", "P_LIC_CERT_IND_CD", "P_LIC_CERT_BEG_DT");

ALTER TABLE "ets_dev"."P_LIC_CERT_TB" ADD CONSTRAINT "P_LIC_CERT_PK" PRIMARY KEY ("P_SYS_ID", "P_LIC_CERT_SK");

ALTER TABLE "ets_dev"."P_LIC_CERT_TB" ADD CONSTRAINT "P_LIC_CERT_UX1" UNIQUE ("P_SYS_ID", "P_LIC_CERT_NUM", "P_LIC_CERT_CD", "P_LIC_CERT_IND_CD", "P_LIC_CERT_BEG_DT");

COMMENT ON COLUMN "ets_dev"."P_LIC_CERT_TB"."P_SYS_ID" IS 'Provider Internal System Identifier.';

COMMENT ON COLUMN "ets_dev"."P_LIC_CERT_TB"."P_LIC_CERT_SK" IS 'Provider License Certificate Surrogate Key';

COMMENT ON COLUMN "ets_dev"."P_LIC_CERT_TB"."P_LIC_CERT_NUM" IS 'The provider''s certification number.';

COMMENT ON COLUMN "ets_dev"."P_LIC_CERT_TB"."P_LIC_CERT_CD" IS 'The type of license certification for a provider.';

COMMENT ON COLUMN "ets_dev"."P_LIC_CERT_TB"."P_LIC_CERT_IND_CD" IS 'Tells whether the row is for a license or certification';

COMMENT ON COLUMN "ets_dev"."P_LIC_CERT_TB"."P_LIC_CERT_BEG_DT" IS 'Identifies the effective date of the provider''s license.';

COMMENT ON COLUMN "ets_dev"."P_LIC_CERT_TB"."P_LIC_CERT_END_DT" IS 'The date on which the provider''s license is to expire.';

COMMENT ON COLUMN "ets_dev"."P_LIC_CERT_TB"."P_LIC_RSTRCT_CD" IS 'The reason that a provider''s license is restricted.';

COMMENT ON COLUMN "ets_dev"."P_LIC_CERT_TB"."P_LIC_VRFY_IND" IS 'Indicates whether the provider''s license has been verified.';

COMMENT ON COLUMN "ets_dev"."P_LIC_CERT_TB"."P_LIC_CERT_AGCY_CD" IS 'Provider License Board Name Code.';

COMMENT ON COLUMN "ets_dev"."P_LIC_CERT_TB"."P_LIC_PRMT_ID" IS 'The name of the Permit holder associtated with the provider''s license or permit.';

COMMENT ON COLUMN "ets_dev"."P_LIC_CERT_TB"."P_LIC_CERT_STATE_CD" IS 'The provider''s certification State Code.';

COMMENT ON COLUMN "ets_dev"."P_LIC_CERT_TB"."L_HIBERNATE_VER_NUM" IS 'This supports hibernate caching mechanism and also supports the pessimistic Locking mechanism';

COMMENT ON COLUMN "ets_dev"."P_LIC_CERT_TB"."G_AUD_USER_ID" IS 'The user ID or process that last modified the row.';

COMMENT ON COLUMN "ets_dev"."P_LIC_CERT_TB"."G_AUD_TS" IS 'The timestamp when the row was last modified.';

COMMENT ON COLUMN "ets_dev"."P_LIC_CERT_TB"."G_AUD_ADD_USER_ID" IS 'The user ID or process that added the row.';

COMMENT ON COLUMN "ets_dev"."P_LIC_CERT_TB"."G_AUD_ADD_TS" IS 'The timestamp when the row was added.';

COMMENT ON TABLE "ets_dev"."P_LIC_CERT_TB"  IS 'The Provider License Certification Table contains license information for a provider.';

CREATE UNIQUE INDEX "ets_dev"."P_LIC_CERT_UX2" ON "ets_dev"."P_LIC_CERT_TB" ("P_LIC_CERT_SK");