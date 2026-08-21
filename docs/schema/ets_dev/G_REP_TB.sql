--------------------------------------------------------
--  DDL for Table G_REP_TB
--------------------------------------------------------

  CREATE TABLE "ets_dev"."G_REP_TB"
   (	"G_REP_SK" BIGINT,
	"G_NAM_PREFX_CD" VARCHAR(4),
	"G_TITLE_NAM" VARCHAR(20),
	"G_FIRST_NAM" VARCHAR(25),
	"G_MID_NAM" VARCHAR(25),
	"G_LAST_NAM" VARCHAR(35),
	"G_SFX_NAM" VARCHAR(10),
	"G_PHNTC_LAST_NAM" VARCHAR(4),
	"G_PHNTC_FIRST_NAM" VARCHAR(4),
	"G_DOB_DT" TIMESTAMP,
	"G_DOD_DT" TIMESTAMP,
	"G_SSN" VARCHAR(9),
	"G_GENDER_CD" VARCHAR(1),
	"G_CMN_ENTY_TY_CD" VARCHAR(2),
	"G_REP_CMN_ENTY_SK" BIGINT,
	"G_ORG_NAM" VARCHAR(50),
	"G_NOTE_SET_SK" BIGINT,
	"L_HIBERNATE_VER_NUM" INTEGER DEFAULT 0,
	"G_AUD_USER_ID" VARCHAR(30),
	"G_AUD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_AUD_ADD_USER_ID" VARCHAR(30),
	"G_AUD_ADD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_DUMMY_IND" VARCHAR(1) DEFAULT 'N',
	"G_DUMMY_TS" TIMESTAMP,
	"G_DUMMY_USER_ID" VARCHAR(30)
   );

   COMMENT ON COLUMN "ets_dev"."G_REP_TB"."G_REP_SK" IS 'Surrogate Key';
   COMMENT ON COLUMN "ets_dev"."G_REP_TB"."G_NAM_PREFX_CD" IS 'e.g. Mr., Mrs....';
   COMMENT ON COLUMN "ets_dev"."G_REP_TB"."G_TITLE_NAM" IS 'e.g. President';
   COMMENT ON COLUMN "ets_dev"."G_REP_TB"."G_FIRST_NAM" IS 'First Name';
   COMMENT ON COLUMN "ets_dev"."G_REP_TB"."G_MID_NAM" IS 'Middle Name';
   COMMENT ON COLUMN "ets_dev"."G_REP_TB"."G_LAST_NAM" IS 'Last Name';
   COMMENT ON COLUMN "ets_dev"."G_REP_TB"."G_SFX_NAM" IS 'e.g. Sr, Jr, III';
   COMMENT ON COLUMN "ets_dev"."G_REP_TB"."G_PHNTC_LAST_NAM" IS 'Phonetic name similar to that found in the Member table.';
   COMMENT ON COLUMN "ets_dev"."G_REP_TB"."G_PHNTC_FIRST_NAM" IS 'Phonetic name similar to that found in the Member table.';
   COMMENT ON COLUMN "ets_dev"."G_REP_TB"."G_DOB_DT" IS 'Date of Birth';
   COMMENT ON COLUMN "ets_dev"."G_REP_TB"."G_DOD_DT" IS 'Date of Death';
   COMMENT ON COLUMN "ets_dev"."G_REP_TB"."G_SSN" IS 'Social Security Number.  There is not a requirement to know the Rep''s SSN.';
   COMMENT ON COLUMN "ets_dev"."G_REP_TB"."G_GENDER_CD" IS 'Gender Code';
   COMMENT ON COLUMN "ets_dev"."G_REP_TB"."G_CMN_ENTY_TY_CD" IS 'Denormalized for performance reasons.  This value can be found in Common Entity.';
   COMMENT ON COLUMN "ets_dev"."G_REP_TB"."G_REP_CMN_ENTY_SK" IS 'Surrogate Key for the Common Entity.  This value may be referred to as Payer ID on some UI screens.';
   COMMENT ON COLUMN "ets_dev"."G_REP_TB"."G_ORG_NAM" IS 'Organization Name';
   COMMENT ON COLUMN "ets_dev"."G_REP_TB"."G_NOTE_SET_SK" IS 'Surrogate Key';
   COMMENT ON COLUMN "ets_dev"."G_REP_TB"."L_HIBERNATE_VER_NUM" IS 'This supports hibernate caching mechanism and also supports the pessimistic Locking mechanism';
   COMMENT ON COLUMN "ets_dev"."G_REP_TB"."G_AUD_USER_ID" IS 'The user ID or process that last modified the row.';
   COMMENT ON COLUMN "ets_dev"."G_REP_TB"."G_AUD_TS" IS 'The timestamp when the row was added.';
   COMMENT ON COLUMN "ets_dev"."G_REP_TB"."G_AUD_ADD_USER_ID" IS 'The user ID or process that added the row.';
   COMMENT ON COLUMN "ets_dev"."G_REP_TB"."G_AUD_ADD_TS" IS 'The timestamp when the row was added.';
   COMMENT ON TABLE "ets_dev"."G_REP_TB"  IS 'g rep tb - fka Contact The Rep Table contains information about an individual that represents the entity (e.g. Someone who works for a Provider). A Rep cannot be a payee.  Payees that don''t have base Tables associated with them are stored in Specific Entity. Notice that Rep is a "base" Table.  Thus, every row in the Rep Table has one corresponding row in Common Entity. Also, the app must enforce that a Rep cannot have Reps associated with him/her."';
