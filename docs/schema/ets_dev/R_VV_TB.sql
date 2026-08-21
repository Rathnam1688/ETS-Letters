
 --------------------------------------------------------
--  DDL for Table R_VV_TB
--------------------------------------------------------

 CREATE TABLE "ets_dev"."R_VV_TB"
   (	"R_VV_DOMAIN_NAM" VARCHAR(30) NOT NULL ,
	"R_VV_CD" VARCHAR(15) NOT NULL ,
	"R_VOID_DT" TIMESTAMP,
	"R_VV_SHORT_DESC" VARCHAR(10),
	"R_VV_LONG_DESC" VARCHAR(40),
	"L_HIBERNATE_VER_NUM" INTEGER DEFAULT 0 NOT NULL ,
	"G_AUD_USER_ID" VARCHAR(30) NOT NULL ,
	"G_AUD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	"G_AUD_ADD_USER_ID" VARCHAR(30) NOT NULL ,
	"G_AUD_ADD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL ,
	"R_CNSTNT_TEXT" VARCHAR(50),
	"R_USED_IN_APPL_IND" VARCHAR(1) DEFAULT 'N' NOT NULL ,     CONSTRAINT "R_VV_F1" FOREIGN KEY ("R_VV_DOMAIN_NAM")
	  REFERENCES "ets_dev"."R_VV_DOMAIN_TB" ("R_VV_DOMAIN_NAM")
   );
  CREATE UNIQUE INDEX "ets_dev"."R_VV_PK" ON "ets_dev"."R_VV_TB" ("R_VV_DOMAIN_NAM", "R_VV_CD");
ALTER TABLE "ets_dev"."R_VV_TB" ADD CONSTRAINT "R_VV_PK" PRIMARY KEY ("R_VV_DOMAIN_NAM", "R_VV_CD") ;

   COMMENT ON COLUMN "ets_dev"."R_VV_TB"."R_VV_DOMAIN_NAM" IS 'Valid Value Domain Name.  This is the data domain as defined in R_VV_DOMAIN_TB, with which a set of valid values may be associated.';
   COMMENT ON COLUMN "ets_dev"."R_VV_TB"."R_VV_CD" IS 'Valid Value Code.  This identifies one specific valid value for the associated data domain.';
   COMMENT ON COLUMN "ets_dev"."R_VV_TB"."R_VOID_DT" IS 'The date the associated data was inactivated';
   COMMENT ON COLUMN "ets_dev"."R_VV_TB"."R_VV_SHORT_DESC" IS 'Short Description of the valid value code.';
   COMMENT ON COLUMN "ets_dev"."R_VV_TB"."R_VV_LONG_DESC" IS 'Long description of the valid value code.';
   COMMENT ON COLUMN "ets_dev"."R_VV_TB"."L_HIBERNATE_VER_NUM" IS 'This supports hibernate caching mechanism and also supports the pessimistic Locking mechanism';
   COMMENT ON COLUMN "ets_dev"."R_VV_TB"."G_AUD_USER_ID" IS 'The user ID or process that last modified the row.';
   COMMENT ON COLUMN "ets_dev"."R_VV_TB"."G_AUD_TS" IS 'The timestamp when the row was last modified.';
   COMMENT ON COLUMN "ets_dev"."R_VV_TB"."G_AUD_ADD_USER_ID" IS 'The user ID or process that added the row.';
   COMMENT ON COLUMN "ets_dev"."R_VV_TB"."G_AUD_ADD_TS" IS 'The timestamp when the row was added.';
   COMMENT ON COLUMN "ets_dev"."R_VV_TB"."R_CNSTNT_TEXT" IS 'This column is used to generate a constant
 file that can be used in java code as a mnemonic for code values, rather than hard coding the codes
 themselves.';
   COMMENT ON COLUMN "ets_dev"."R_VV_TB"."R_USED_IN_APPL_IND" IS 'Indicates that a valid value is used within the application code.';
   COMMENT ON TABLE "ets_dev"."R_VV_TB"  IS 'The Reference Valid Value Table defines the set of valid values that are associated with a specific data domain, and is used for all generic code fields which do not require any additional information, other than a long and short description, and whose set of valid values are reasonably limited in number.';

  /* TODO(ets_dev): Oracle PL/SQL trigger not auto-converted — rewrite as a Postgres trigger function.
CREATE OR REPLACE EDITIONABLE TRIGGER "ets_dev"."R_CNSTNT_TR"
   BEFORE INSERT
   ON ets_dev.R_VV_TB
   REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
BEGIN
   IF :new.r_cnstnt_text IS NULL
   THEN
      :new.r_cnstnt_text :=
              replace_invalid_fn (UPPER ('VV_' || UPPER (:new.r_vv_short_desc)));
   END IF;
END r_cnstnt_tr;
/
ALTER TRIGGER "ets_dev"."R_CNSTNT_TR" ;
*/
