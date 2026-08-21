--------------------------------------------------------
--  DDL for Table R_DD_COL_TB
--------------------------------------------------------

  CREATE TABLE "ets_dev"."R_DD_COL_TB"
   (	"R_TABLE_NAM" VARCHAR(30),
	"R_COL_NAM" VARCHAR(30),
	"R_ADDL_BUSN_NAM" VARCHAR(40),
	"R_ADDL_BUSN_DESC" VARCHAR(320),
	"R_ORDNL_NUM" SMALLINT,
	"R_PK_NUM" SMALLINT,
	"R_REQD_VALUE_IND" VARCHAR(1) DEFAULT 'N',
	"R_DOMAIN_NAM" VARCHAR(30),
	"L_HIBERNATE_VER_NUM" INTEGER DEFAULT 0,
	"G_AUD_USER_ID" VARCHAR(30),
	"G_AUD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_AUD_ADD_USER_ID" VARCHAR(30),
	"G_AUD_ADD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"R_ASCTD_SEQ_NAM" VARCHAR(30),
	"R_DD_COL_SK" BIGINT
   );

   COMMENT ON COLUMN "ets_dev"."R_DD_COL_TB"."R_TABLE_NAM" IS 'Data Dictionary Table Definition.  One row exists for each table defined for the Enterprise MMIS application.';
   COMMENT ON COLUMN "ets_dev"."R_DD_COL_TB"."R_COL_NAM" IS 'Column Name';
   COMMENT ON COLUMN "ets_dev"."R_DD_COL_TB"."R_ADDL_BUSN_NAM" IS 'Short name.  Will display on pop-ups.';
   COMMENT ON COLUMN "ets_dev"."R_DD_COL_TB"."R_ADDL_BUSN_DESC" IS 'More verbose description than business name.';
   COMMENT ON COLUMN "ets_dev"."R_DD_COL_TB"."R_ORDNL_NUM" IS 'Specifies what order in the this column appears in the table.';
   COMMENT ON COLUMN "ets_dev"."R_DD_COL_TB"."R_PK_NUM" IS 'Indicates whether or not this attribute participates in the PK.';
   COMMENT ON COLUMN "ets_dev"."R_DD_COL_TB"."R_REQD_VALUE_IND" IS 'Indicates whether this column allows null values.';
   COMMENT ON COLUMN "ets_dev"."R_DD_COL_TB"."R_DOMAIN_NAM" IS 'Domain Name';
   COMMENT ON COLUMN "ets_dev"."R_DD_COL_TB"."L_HIBERNATE_VER_NUM" IS 'This supports hibernate caching mechanism and also supports the pessimistic Locking mechanism';
   COMMENT ON COLUMN "ets_dev"."R_DD_COL_TB"."G_AUD_USER_ID" IS 'The user ID or process that last modified the row.';
   COMMENT ON COLUMN "ets_dev"."R_DD_COL_TB"."G_AUD_TS" IS 'The timestamp when the row was last modified.';
   COMMENT ON COLUMN "ets_dev"."R_DD_COL_TB"."G_AUD_ADD_USER_ID" IS 'The user ID or process that added the row.';
   COMMENT ON COLUMN "ets_dev"."R_DD_COL_TB"."G_AUD_ADD_TS" IS 'The timestamp when the row was added.';
   COMMENT ON TABLE "ets_dev"."R_DD_COL_TB"  IS 'The Data Dictionary Column Definition Table contains every combination of table/column in the Enterprise database.';
