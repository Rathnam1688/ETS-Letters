--------------------------------------------------------
--  DDL for Table R_PARAM_TB
--------------------------------------------------------

  CREATE TABLE "ets_dev"."R_PARAM_TB"
   (	"R_FUNC_AREA_CD" VARCHAR(2),
	"R_PARAM_NUM" BIGINT,
	"R_PARAM_NAM" VARCHAR(50),
	"R_PARAM_TY_CD" VARCHAR(1),
	"G_NOTE_SET_SK" BIGINT,
	"L_HIBERNATE_VER_NUM" INTEGER DEFAULT 0,
	"G_AUD_USER_ID" VARCHAR(30),
	"G_AUD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_AUD_ADD_USER_ID" VARCHAR(30),
	"G_AUD_ADD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP
   );

   COMMENT ON COLUMN "ets_dev"."R_PARAM_TB"."R_FUNC_AREA_CD" IS 'Functional Area Code, identifying the functional team that is responsible for maintenance of codes.';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_TB"."R_PARAM_NUM" IS 'This field contains the unique number associated with the system parameter.';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_TB"."R_PARAM_NAM" IS 'This field contains the name of the system parameter.';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_TB"."R_PARAM_TY_CD" IS 'This code identifies what type of data is stored in the System Parameter row.';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_TB"."G_NOTE_SET_SK" IS 'Surrogate Key';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_TB"."L_HIBERNATE_VER_NUM" IS 'This supports hibernate caching mechanism and also supports the pessimistic Locking mechanism';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_TB"."G_AUD_USER_ID" IS 'The user ID or process that last modified the row.';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_TB"."G_AUD_TS" IS 'The timestamp when the row was last modified.';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_TB"."G_AUD_ADD_USER_ID" IS 'The user ID or process that added the row.';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_TB"."G_AUD_ADD_TS" IS 'The timestamp when the row was added.';
   COMMENT ON TABLE "ets_dev"."R_PARAM_TB"  IS 'Reference Parameter Table';
