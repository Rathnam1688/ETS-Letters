--------------------------------------------------------
--  DDL for Table G_PYE_PYR_TB
--------------------------------------------------------

  CREATE TABLE "ets_dev"."G_PYE_PYR_TB"
   (	"G_CMN_ENTY_SK" BIGINT,
	"G_SORT_NAM" VARCHAR(60),
	"G_FIRST_NAM" VARCHAR(25),
	"G_MID_NAM" VARCHAR(25),
	"G_LAST_NAM" VARCHAR(35),
	"G_BUSN_NAM" VARCHAR(50),
	"G_CMN_ENTY_TY_CD" VARCHAR(2),
	"G_ENTY_EXTL_ID" VARCHAR(15),
	"G_ENTY_EXTL_ID_TY_CD" VARCHAR(3),
	"G_RECOUP_INSTLMT_VALUE" NUMERIC(9,2),
	"G_RECOUP_PCT_VALUE" NUMERIC(9,2),
	"G_RECOUP_LAG_DAYS_NUM" INTEGER,
	"G_W9_SGND_DT" TIMESTAMP,
	"G_RECOUP_FREQ_CD" VARCHAR(2),
	"G_NOTE_SET_SK" BIGINT,
	"G_VND_MSTR_NUM" VARCHAR(10),
	"L_HIBERNATE_VER_NUM" INTEGER DEFAULT 0,
	"G_AUD_USER_ID" VARCHAR(30),
	"G_AUD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_AUD_ADD_USER_ID" VARCHAR(30),
	"G_AUD_ADD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_VOID_IND" VARCHAR(1) DEFAULT 'N',
	"G_VOID_DT" TIMESTAMP,
	"G_REMIT_TO_LOC_CD" VARCHAR(4),
	"G_OLD_VND_MSTR_NUM" VARCHAR(20)
   );

   COMMENT ON COLUMN "ets_dev"."G_PYE_PYR_TB"."G_CMN_ENTY_SK" IS 'Surrogate Key for the Common Entity.  This value may be referred to as Payer ID on some UI screens.';
   COMMENT ON COLUMN "ets_dev"."G_PYE_PYR_TB"."G_SORT_NAM" IS 'Provider Name';
   COMMENT ON COLUMN "ets_dev"."G_PYE_PYR_TB"."G_FIRST_NAM" IS 'Global First Name Data';
   COMMENT ON COLUMN "ets_dev"."G_PYE_PYR_TB"."G_MID_NAM" IS 'Global Middle Name Data';
   COMMENT ON COLUMN "ets_dev"."G_PYE_PYR_TB"."G_LAST_NAM" IS 'Global Last Name Data';
   COMMENT ON COLUMN "ets_dev"."G_PYE_PYR_TB"."G_BUSN_NAM" IS 'Global Name Data';
   COMMENT ON COLUMN "ets_dev"."G_PYE_PYR_TB"."G_CMN_ENTY_TY_CD" IS 'e.g. Member, Provider, TPL, Contact Management, etc.';
   COMMENT ON COLUMN "ets_dev"."G_PYE_PYR_TB"."G_ENTY_EXTL_ID" IS 'Entity external ID';
   COMMENT ON COLUMN "ets_dev"."G_PYE_PYR_TB"."G_ENTY_EXTL_ID_TY_CD" IS 'Entity External Identifier Type Code';
   COMMENT ON COLUMN "ets_dev"."G_PYE_PYR_TB"."G_RECOUP_INSTLMT_VALUE" IS 'Recoupment Installment Value';
   COMMENT ON COLUMN "ets_dev"."G_PYE_PYR_TB"."G_RECOUP_PCT_VALUE" IS 'Recoupment Percent Value';
   COMMENT ON COLUMN "ets_dev"."G_PYE_PYR_TB"."G_RECOUP_LAG_DAYS_NUM" IS 'How long to delay the recoupment from the time the receivable is created.';
   COMMENT ON COLUMN "ets_dev"."G_PYE_PYR_TB"."G_W9_SGND_DT" IS 'The date the W-9 was signed.';
   COMMENT ON COLUMN "ets_dev"."G_PYE_PYR_TB"."G_RECOUP_FREQ_CD" IS 'e.g. Weekly, bi-Weekly, Monthly.';
   COMMENT ON COLUMN "ets_dev"."G_PYE_PYR_TB"."G_NOTE_SET_SK" IS 'Surrogate Key';
   COMMENT ON COLUMN "ets_dev"."G_PYE_PYR_TB"."G_VND_MSTR_NUM" IS 'The Vendor Master Number is a unique identifier assigned to all payee''s in the NH accounting system. The Vendor Master Number must be submitted to the NH accounting system for check and EFT transactions.';
   COMMENT ON COLUMN "ets_dev"."G_PYE_PYR_TB"."L_HIBERNATE_VER_NUM" IS 'This supports hibernate caching mechanism and also supports the pessimistic Locking mechanism';
   COMMENT ON COLUMN "ets_dev"."G_PYE_PYR_TB"."G_AUD_USER_ID" IS 'The user ID or process that last modified the row.';
   COMMENT ON COLUMN "ets_dev"."G_PYE_PYR_TB"."G_AUD_TS" IS 'The timestamp when the row was last modified.';
   COMMENT ON COLUMN "ets_dev"."G_PYE_PYR_TB"."G_AUD_ADD_USER_ID" IS 'The user ID or process that added the row.';
   COMMENT ON COLUMN "ets_dev"."G_PYE_PYR_TB"."G_AUD_ADD_TS" IS 'The timestamp when the row was added.';
   COMMENT ON COLUMN "ets_dev"."G_PYE_PYR_TB"."G_REMIT_TO_LOC_CD" IS 'Remit To Location Code';
   COMMENT ON COLUMN "ets_dev"."G_PYE_PYR_TB"."G_OLD_VND_MSTR_NUM" IS 'Old Vendor Master Number';
   COMMENT ON TABLE "ets_dev"."G_PYE_PYR_TB"  IS 'Payee Payer Table';
