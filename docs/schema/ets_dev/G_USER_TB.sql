--------------------------------------------------------
--  DDL for Table G_USER_TB
--------------------------------------------------------

  CREATE TABLE "ets_dev"."G_USER_TB"
   (	"G_USER_WORK_UNIT_SK" BIGINT,
	"G_USER_ID" VARCHAR(30),
	"G_PREFX_NAM" VARCHAR(25),
	"G_LAST_NAM" VARCHAR(35),
	"G_FIRST_NAM" VARCHAR(25),
	"G_MI_NAM" VARCHAR(1),
	"G_SFX_NAM" VARCHAR(10),
	"G_PHONE_NUM" VARCHAR(10),
	"G_PHONE_EXT_NUM" VARCHAR(6),
	"G_EMAIL_ADR_TEXT" VARCHAR(64),
	"G_ORG_ID" VARCHAR(10),
	"G_ORG_NAM" VARCHAR(50),
	"G_ORG_DESC_TEXT" VARCHAR(320),
	"G_SPRVSR_REVW_REQD_IND" VARCHAR(1),
	"G_CASE_FLTR_NAM" VARCHAR(50),
	"G_CR_FLTR_NAM" VARCHAR(50),
	"G_SPRVSR_IND" VARCHAR(1),
	"G_ACCT_ACTV_IND" VARCHAR(1),
	"L_HIBERNATE_VER_NUM" INTEGER DEFAULT 0,
	"G_AUD_USER_ID" VARCHAR(30),
	"G_AUD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_AUD_ADD_USER_ID" VARCHAR(30),
	"G_AUD_ADD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_ORG_TY_TEXT" VARCHAR(250),
	"G_MFA_FST_TM_USR" VARCHAR(1) DEFAULT 'N'
   );

   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."G_USER_WORK_UNIT_SK" IS 'Surrogate Key';
   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."G_USER_ID" IS 'The user ID or process that last modified the row.';
   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."G_PREFX_NAM" IS 'e.g. Mr., Mrs....';
   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."G_LAST_NAM" IS 'Last name of the user.
LDAP Specific Attribute Name: sn';
   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."G_FIRST_NAM" IS 'First name.
LDAP Specific Attribute Name: givenName';
   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."G_MI_NAM" IS 'Middle initials of the user.
LDAP Specific Attribute Name: middleInitials';
   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."G_SFX_NAM" IS 'e.g. Sr., Jr., III...';
   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."G_PHONE_NUM" IS 'Phone number';
   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."G_PHONE_EXT_NUM" IS 'Phone Extension Number';
   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."G_EMAIL_ADR_TEXT" IS 'Email Address Text';
   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."G_ORG_ID" IS 'e.g. State Code, County ID...';
   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."G_ORG_NAM" IS 'e.g. State Name, County Name...';
   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."G_ORG_DESC_TEXT" IS 'Sentence(s) about the organization.';
   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."G_SPRVSR_REVW_REQD_IND" IS 'Supervisor must review CR before it is closed.  A supervisor cannot have this indicator set to positive.  ';
   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."G_CASE_FLTR_NAM" IS 'CM Filter Name';
   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."G_CR_FLTR_NAM" IS 'CM Filter Name';
   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."G_SPRVSR_IND" IS 'Supervisor indicator';
   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."G_ACCT_ACTV_IND" IS 'Global Indicator';
   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."L_HIBERNATE_VER_NUM" IS 'This supports hibernate caching mechanism and also supports the pessimistic Locking mechanism';
   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."G_AUD_USER_ID" IS 'The user ID or process that last modified the row.';
   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."G_AUD_TS" IS 'The timestamp when the row was last modified.';
   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."G_AUD_ADD_USER_ID" IS 'The user ID or process that added the row.';
   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."G_AUD_ADD_TS" IS 'The timestamp when the row was added.';
   COMMENT ON COLUMN "ets_dev"."G_USER_TB"."G_MFA_FST_TM_USR" IS 'The field contains the value of the MFA First Time User';
   COMMENT ON TABLE "ets_dev"."G_USER_TB"  IS 'The master user data originates in, and resides in, LDAP.  Custom code integrated with LDAP will synchronize the user data with "g user tb" for internal users.  The rows in "g user tb" can be queried as necessary (by Enterprise or other tools (e.g. Cognos)).  There is no need for Enterprise to modify the information in "g user tb".';
