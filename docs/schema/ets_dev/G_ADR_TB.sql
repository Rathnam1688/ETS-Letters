--------------------------------------------------------
--  DDL for Table G_ADR_TB
--------------------------------------------------------

  CREATE TABLE "ets_dev"."G_ADR_TB"
   (	"G_ADR_SK" BIGINT,
	"G_LINE1_ADR" VARCHAR(64),
	"G_LINE2_ADR" VARCHAR(64),
	"G_LINE3_ADR" VARCHAR(64),
	"G_LINE4_ADR" VARCHAR(64),
	"G_CITY_NAM" VARCHAR(30),
	"G_TOWN_CD" VARCHAR(3),
	"G_US_STATE_CD" VARCHAR(2),
	"G_ZIP5_CD" VARCHAR(5),
	"G_ZIP4_CD" VARCHAR(4),
	"G_CNTRY_CD" VARCHAR(3),
	"G_CNTY_CD" VARCHAR(5),
	"G_USPS_ADR_VRFY_CD" VARCHAR(2),
	"G_USPS_LINE1_ADR" VARCHAR(64),
	"G_USPS_LINE2_ADR" VARCHAR(64),
	"G_LAT_NUM" NUMERIC(7,4),
	"G_LON_NUM" NUMERIC(7,4),
	"G_CMN_ENTY_TY_CD" VARCHAR(2),
	"G_DSTCT_OFC_CD" VARCHAR(2),
	"L_HIBERNATE_VER_NUM" INTEGER DEFAULT 0,
	"G_AUD_USER_ID" VARCHAR(30),
	"G_AUD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_AUD_ADD_USER_ID" VARCHAR(30),
	"G_AUD_ADD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_DUMMY_IND" VARCHAR(1) DEFAULT 'N',
	"G_DUMMY_TS" TIMESTAMP,
	"G_DUMMY_USER_ID" VARCHAR(30)
   );

   COMMENT ON COLUMN "ets_dev"."G_ADR_TB"."G_ADR_SK" IS 'Integer value that uniquely identifies each address row.';
   COMMENT ON COLUMN "ets_dev"."G_ADR_TB"."G_LINE1_ADR" IS 'Address line 1.';
   COMMENT ON COLUMN "ets_dev"."G_ADR_TB"."G_LINE2_ADR" IS 'Address line 2. ';
   COMMENT ON COLUMN "ets_dev"."G_ADR_TB"."G_LINE3_ADR" IS 'Address line 3.';
   COMMENT ON COLUMN "ets_dev"."G_ADR_TB"."G_LINE4_ADR" IS 'Address line 4.';
   COMMENT ON COLUMN "ets_dev"."G_ADR_TB"."G_CITY_NAM" IS 'City Name';
   COMMENT ON COLUMN "ets_dev"."G_ADR_TB"."G_US_STATE_CD" IS 'USPS State Code.';
   COMMENT ON COLUMN "ets_dev"."G_ADR_TB"."G_ZIP5_CD" IS 'Zip5 Code (Length of 5)';
   COMMENT ON COLUMN "ets_dev"."G_ADR_TB"."G_ZIP4_CD" IS 'Zip4 Code (Length of 4)';
   COMMENT ON COLUMN "ets_dev"."G_ADR_TB"."G_USPS_LINE1_ADR" IS 'Verfified USPS address.  Will conform to the output parameters of the call to Geostan.';
   COMMENT ON COLUMN "ets_dev"."G_ADR_TB"."G_USPS_LINE2_ADR" IS 'Verfified USPS address.  Will conform to the output parameters of the call to Geostan.';
   COMMENT ON COLUMN "ets_dev"."G_ADR_TB"."G_LAT_NUM" IS 'Latitude of the address.  The value will be null if the address cannot be validated (per GeoStan as per 12/13/06).';
   COMMENT ON COLUMN "ets_dev"."G_ADR_TB"."G_LON_NUM" IS 'Latitude of the address.  The value will be null if the address cannot be validated (per GeoStan as per 12/13/06).';
   COMMENT ON COLUMN "ets_dev"."G_ADR_TB"."L_HIBERNATE_VER_NUM" IS 'This supports hibernate caching mechanism and also supports the pessimistic Locking mechanism';
   COMMENT ON COLUMN "ets_dev"."G_ADR_TB"."G_AUD_USER_ID" IS 'The user ID or process that last modified the row.';
   COMMENT ON COLUMN "ets_dev"."G_ADR_TB"."G_AUD_TS" IS 'The timestamp when the row was last modified.';
   COMMENT ON COLUMN "ets_dev"."G_ADR_TB"."G_AUD_ADD_USER_ID" IS 'The user ID or process that added the row.';
   COMMENT ON COLUMN "ets_dev"."G_ADR_TB"."G_AUD_ADD_TS" IS 'The timestamp when the row was added.';
   COMMENT ON TABLE "ets_dev"."G_ADR_TB"  IS 'The General Address Table is used to store addresses for all types of entties throughout the Enterprise system.';
