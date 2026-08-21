--------------------------------------------------------
--  DDL for Table G_NOTE_TB
--------------------------------------------------------

  CREATE TABLE "ets_dev"."G_NOTE_TB"
   (	"G_NOTE_SET_SK" BIGINT,
	"G_NOTE_SEQ_NUM" INTEGER,
	"G_NOTE_TEXT_VT" BIGINT,
	"G_NOTE_TY_CD" VARCHAR(2),
	"L_HIBERNATE_VER_NUM" INTEGER DEFAULT 0,
	"G_AUD_USER_ID" VARCHAR(30),
	"G_AUD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_AUD_ADD_USER_ID" VARCHAR(30),
	"G_AUD_ADD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP
   );

   COMMENT ON COLUMN "ets_dev"."G_NOTE_TB"."G_NOTE_TEXT_VT" IS 'Note Text Value Token';
