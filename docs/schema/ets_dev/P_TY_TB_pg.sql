CREATE TABLE "ets_dev"."P_TY_TB" ("P_SYS_ID" BIGINT NOT NULL, "P_TY_SK" BIGINT NOT NULL, "P_TY_CD" VARCHAR(3 BYTE) NOT NULL, "L_HIBERNATE_VER_NUM" INTEGER DEFAULT 0 NOT NULL, "G_AUD_USER_ID" VARCHAR(30 BYTE) NOT NULL, "G_AUD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, "G_AUD_ADD_USER_ID" VARCHAR(30 BYTE) NOT NULL, "G_AUD_ADD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, CONSTRAINT "P_TY_F1" FOREIGN KEY ("P_SYS_ID") REFERENCES "ets_dev"."P_DTL_TB" ("P_SYS_ID") ) ;

CREATE UNIQUE INDEX "ets_dev"."P_TY_PK" ON "ets_dev"."P_TY_TB" ("P_SYS_ID", "P_TY_SK");

ALTER TABLE "ets_dev"."P_TY_TB" ADD CONSTRAINT "P_TY_PK" PRIMARY KEY ("P_SYS_ID", "P_TY_SK");

COMMENT ON COLUMN "ets_dev"."P_TY_TB"."P_SYS_ID" IS 'Provider Internal System Identifier.';

COMMENT ON COLUMN "ets_dev"."P_TY_TB"."P_TY_SK" IS 'Provider Type Surrogate Key';

COMMENT ON COLUMN "ets_dev"."P_TY_TB"."P_TY_CD" IS 'A code that designates the State''s classification of providers.';

COMMENT ON COLUMN "ets_dev"."P_TY_TB"."L_HIBERNATE_VER_NUM" IS 'This supports hibernate caching mechanism and also supports the pessimistic Locking mechanism';

COMMENT ON COLUMN "ets_dev"."P_TY_TB"."G_AUD_USER_ID" IS 'The user ID or process that last modified the row.';

COMMENT ON COLUMN "ets_dev"."P_TY_TB"."G_AUD_TS" IS 'The timestamp when the row was last modified.';

COMMENT ON COLUMN "ets_dev"."P_TY_TB"."G_AUD_ADD_USER_ID" IS 'The user ID or process that added the row.';

COMMENT ON COLUMN "ets_dev"."P_TY_TB"."G_AUD_ADD_TS" IS 'The timestamp when the row was added.';

COMMENT ON TABLE "ets_dev"."P_TY_TB" IS 'The Provider Type Table contains information about different provider types.';

CREATE UNIQUE INDEX "ets_dev"."P_TY_UX1" ON "ets_dev"."P_TY_TB" ("P_TY_SK");

CREATE UNIQUE INDEX "ets_dev"."P_TY_UX2" ON "ets_dev"."P_TY_TB" ("P_SYS_ID");