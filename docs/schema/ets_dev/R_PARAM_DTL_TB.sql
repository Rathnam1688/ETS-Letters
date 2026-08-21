--------------------------------------------------------
--  DDL for Table R_PARAM_DTL_TB
--------------------------------------------------------

  CREATE TABLE "ets_dev"."R_PARAM_DTL_TB"
   (	"R_FUNC_AREA_CD" VARCHAR(2),
	"R_PARAM_NUM" BIGINT,
	"R_PARAM_DTL_SK" BIGINT,
	"R_LOB_CD" VARCHAR(3),
	"R_PARAM_BEG_DT" TIMESTAMP,
	"R_VOID_DT" TIMESTAMP,
	"R_PARAM_END_DT" TIMESTAMP,
	"R_PARAM_VALUE_DT" TIMESTAMP,
	"R_PARAM_VALUE_TS" TIMESTAMP,
	"R_PARAM_VALUE_AMT" NUMERIC(11,2),
	"R_PARAM_VALUE_PCT" NUMERIC(5,4),
	"R_PARAM_VALUE_NUM" BIGINT,
	"R_PARAM_VALUE_DATA" VARCHAR(60),
	"L_HIBERNATE_VER_NUM" INTEGER DEFAULT 0,
	"G_AUD_USER_ID" VARCHAR(30),
	"G_AUD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_AUD_ADD_USER_ID" VARCHAR(30),
	"G_AUD_ADD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP
   );

   COMMENT ON COLUMN "ets_dev"."R_PARAM_DTL_TB"."R_FUNC_AREA_CD" IS 'Functional Area Code, identifying the functional team that is responsible for maintenance of codes.';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_DTL_TB"."R_PARAM_NUM" IS 'This field contains the unique number associated with the system parameter.';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_DTL_TB"."R_PARAM_DTL_SK" IS 'Reference Parameter Detail Surrogate Key';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_DTL_TB"."R_LOB_CD" IS 'This field indicates a line of business code to be used for system processing. The line of business is used to identify the entities that have fiscal responsibility for payment of insurance claims on behalf of their respective members.';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_DTL_TB"."R_PARAM_BEG_DT" IS 'The start date for the parameter.';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_DTL_TB"."R_VOID_DT" IS 'The date the associated data was inactivated';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_DTL_TB"."R_PARAM_END_DT" IS 'This field is the end date on which the value for the system parameter is valid.';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_DTL_TB"."R_PARAM_VALUE_DT" IS 'If the data format type for this system parameter is defined as date, this field is the date value associated with the parameter.';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_DTL_TB"."R_PARAM_VALUE_TS" IS 'Parameter Value Timestamp.';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_DTL_TB"."R_PARAM_VALUE_AMT" IS 'If the data format type for this system parameter is defined as currency, this field is the dollar amount associated with the parameter.';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_DTL_TB"."R_PARAM_VALUE_PCT" IS 'If the data format type for this system parameter is defined as a percentage, this field is the percent associated with the parameter.';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_DTL_TB"."R_PARAM_VALUE_NUM" IS 'If the data format type for this system parameter is defined as numeric, this field contains the number associated with the parameter.';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_DTL_TB"."R_PARAM_VALUE_DATA" IS 'If the data format for this system parameter is defined as alphanumeric text, this field contains the character string value associated with the parameter.';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_DTL_TB"."L_HIBERNATE_VER_NUM" IS 'This supports hibernate caching mechanism and also supports the pessimistic Locking mechanism';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_DTL_TB"."G_AUD_USER_ID" IS 'The user ID or process that last modified the row.';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_DTL_TB"."G_AUD_TS" IS 'The timestamp when the row was last modified.';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_DTL_TB"."G_AUD_ADD_USER_ID" IS 'The user ID or process that added the row.';
   COMMENT ON COLUMN "ets_dev"."R_PARAM_DTL_TB"."G_AUD_ADD_TS" IS 'The timestamp when the row was added.';
   COMMENT ON TABLE "ets_dev"."R_PARAM_DTL_TB"  IS 'Reference Parameter Detail Table';
