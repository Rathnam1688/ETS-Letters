--------------------------------------------------------
--  DDL for Table G_COTS_LTR_REQ_TB
--------------------------------------------------------

  CREATE TABLE "ets_dev"."G_COTS_LTR_REQ_TB"
   (	"G_COTS_LTR_REQ_SK" BIGINT,
	"G_COTS_LTR_TMPLT_KEY_DATA" VARCHAR(50),
	"G_SPRVSR_REVW_REQD_IND" VARCHAR(1),
	"G_SPRVSR_REVW_DT" TIMESTAMP,
	"G_REVWG_SPRVSR_WORK_UNIT_SK" VARCHAR(99),
	"G_USER_ID" VARCHAR(30),
	"G_EXPLN_TEXT" VARCHAR(255),
	"G_TO_BE_SENT_DT" TIMESTAMP,
	"G_COTS_LTR_REQ_DISP_CD" VARCHAR(2),
	"G_DUE_DT_OFFST_NUM" SMALLINT,
	"G_RPLY_DUE_DT" TIMESTAMP,
	"G_RPLY_RECD_DT" TIMESTAMP,
	"G_LTR_REQ_ALERT_RSN_CD" VARCHAR(2),
	"G_NOTFY_ALERT_USER_ID" VARCHAR(30),
	"G_ALERT_BASED_ON_TABLE_NAM" VARCHAR(30),
	"G_ALERT_BASED_ON_COL_NAM" VARCHAR(30),
	"G_SEND_ALERT_DAYS_CD" VARCHAR(10),
	"G_BEFORE_AFTER_CD" VARCHAR(1),
	"G_COTS_LTR_GNRTN_RTRN_CD" VARCHAR(20),
	"G_COTS_LTR_GNRTN_RTRN_CD_DT" TIMESTAMP,
	"G_NOTE_SET_SK" BIGINT,
	"G_NOTE_SEQ_NUM" INTEGER,
	"L_HIBERNATE_VER_NUM" INTEGER DEFAULT 0,
	"G_AUD_USER_ID" VARCHAR(30),
	"G_AUD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_AUD_ADD_USER_ID" VARCHAR(30),
	"G_AUD_ADD_TS" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"G_COTS_LTR_ATTACH_IND" VARCHAR(1) DEFAULT 'N',
	"G_EDMS_PAGE_ID" VARCHAR(32)
   );

   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_COTS_LTR_REQ_SK" IS 'System generated sequential number.  ';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_COTS_LTR_TMPLT_KEY_DATA" IS 'Correlates directly with a letter template in the COTS letter generation product.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_SPRVSR_REVW_REQD_IND" IS 'Indicates whether the letter request has been reviewed by a supervisor.  Source of this attribute is the Letter Temlate entity.  This attribute stores a historical record of the value as of the date this row was inserted.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_SPRVSR_REVW_DT" IS 'The date a supervisor reviewed the letter request.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_REVWG_SPRVSR_WORK_UNIT_SK" IS 'Reviewing Supervisor Work Unit Surrogate Key';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_USER_ID" IS 'The user ID or process that last modified the row.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_EXPLN_TEXT" IS 'Source not determined.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_TO_BE_SENT_DT" IS 'Indicates the Date the letter information is "as of".';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_COTS_LTR_REQ_DISP_CD" IS 'COTS Letter Request Disposition Code';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_DUE_DT_OFFST_NUM" IS 'Determines when the alert is created based on the letter sent date.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_RPLY_DUE_DT" IS 'Global Date Data';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_RPLY_RECD_DT" IS 'Global Date Data';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_LTR_REQ_ALERT_RSN_CD" IS 'Letter Request Alert Reason Code';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_NOTFY_ALERT_USER_ID" IS 'The user ID or process that last modified the row.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_ALERT_BASED_ON_TABLE_NAM" IS 'Data Dictionary Table Definition.  One row exists for each table defined for the Enterprise MMIS application.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_ALERT_BASED_ON_COL_NAM" IS 'Column Name';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_SEND_ALERT_DAYS_CD" IS 'e.g. 1-5, 5-10, 11-20...';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_BEFORE_AFTER_CD" IS 'e.g. B=Before, A=After.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_COTS_LTR_GNRTN_RTRN_CD" IS 'This error code value comes from the COTS letter generation request product.  The data type was made intentionally generic.

The value is null initially (status code of in process), 0 for success (status code of complete), and one of the following for errors (status code of pended):

Fault Code    Fault String
9000    An error occurred while executing the web service.
9002    Access denied. The user name or password are incorrect.
9003    User is not authorized to access the required document.
9004    Output profile not found.
9005    Document not found.
9006    No Web service license available.
9007    Invalid customer key.
9008    Application not defined.
9009    Customer data source not defined.
9010    Data source not found.
9011    Failed to get connection to the database.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_COTS_LTR_GNRTN_RTRN_CD_DT" IS 'Commercial Off-the-shelf (COTS) Letter Generation Return Code Date';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_NOTE_SET_SK" IS 'The most recent Case note set for this Letter Request.  Paired with "g note sequence number".';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_NOTE_SEQ_NUM" IS 'The most recent Case note for this Letter Request.  Paired with "g note set SK".';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."L_HIBERNATE_VER_NUM" IS 'This supports hibernate caching mechanism and also supports the pessimistic Locking mechanism';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_AUD_USER_ID" IS 'The user ID or process that last modified the row.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_AUD_TS" IS 'The timestamp when the row was last modified.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_AUD_ADD_USER_ID" IS 'The user ID or process that added the row.';
   COMMENT ON COLUMN "ets_dev"."G_COTS_LTR_REQ_TB"."G_AUD_ADD_TS" IS 'The timestamp when the row was added.';
   COMMENT ON TABLE "ets_dev"."G_COTS_LTR_REQ_TB"  IS 'One row for each letter that is requested to be generated.  ';
