--------------------------------------------------------
--  DDL for Table G_COTS_LTR_TMPLT_TB
--------------------------------------------------------

  CREATE TABLE "ets_dev"."G_COTS_LTR_TMPLT_TB"
   (	"G_COTS_LTR_TMPLT_KEY_DATA" VARCHAR(50),
	"G_NAM" VARCHAR(50),
	"G_DESC" VARCHAR(50),
	"G_DFLT_SPRVSR_REVW_REQD_IND" VARCHAR(1),
	"G_VOID_IND" VARCHAR(1),
	"G_COTS_VND_CAT_DESC" VARCHAR(255),
	"G_DFLT_DUE_DT_OFFST_NUM" SMALLINT,
	"L_HIBERNATE_VER_NUM" INTEGER DEFAULT 0,
	"G_AUD_USER_ID" VARCHAR(30),
	"G_AUD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_AUD_ADD_USER_ID" VARCHAR(30),
	"G_AUD_ADD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP
   );

   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_TMPLT_TB"."G_COTS_LTR_TMPLT_KEY_DATA" IS 'Unique identifier for letter template information found in the letter generation COTS product.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_TMPLT_TB"."G_NAM" IS 'Name of the template.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_TMPLT_TB"."G_DESC" IS 'Description of the template.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_TMPLT_TB"."G_DFLT_SPRVSR_REVW_REQD_IND" IS 'Indicates whether it is required for a supervisor to review this template.  This is a default value for other areas.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_TMPLT_TB"."G_VOID_IND" IS 'If Enterprise syncs with the letter generation COTS product, remove rows from this table (physically if they were not referenced in another table; else logically).';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_TMPLT_TB"."G_COTS_VND_CAT_DESC" IS 'e.g. Serice Auth, Member, Provider.  This list is very similar to the Common Entity Type values.  It remains separate because of the potential for them being different.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_TMPLT_TB"."G_DFLT_DUE_DT_OFFST_NUM" IS 'Combined with To Be Sent date (Letter Request) to set the default of Due Date (Letter Receiver).';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_TMPLT_TB"."L_HIBERNATE_VER_NUM" IS 'This supports hibernate caching mechanism and also supports the pessimistic Locking mechanism';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_TMPLT_TB"."G_AUD_USER_ID" IS 'The user ID or process that last modified the row.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_TMPLT_TB"."G_AUD_TS" IS 'The timestamp when the row was last modified.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_TMPLT_TB"."G_AUD_ADD_USER_ID" IS 'The user ID or process that added the row.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_TMPLT_TB"."G_AUD_ADD_TS" IS 'The timestamp when the row was added.';
   COMMENT ON TABLE "ets_dev"."G_COTS_LTR_TMPLT_TB"  IS 'The Commercial Off-the-shelf Letter Template Table contains the actual template data, which is sourced from xPression (or whatever Letter Generation product is used).  The population of this Table is a physical implementation issue.  i.e. Not via a UI.';
