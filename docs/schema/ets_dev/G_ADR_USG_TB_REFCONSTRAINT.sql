--------------------------------------------------------
--  Ref Constraints for Table G_ADR_USG_TB
--------------------------------------------------------

  ALTER TABLE "ets_dev"."G_ADR_USG_TB" ADD CONSTRAINT "G_ADR_USG_F2" FOREIGN KEY ("G_ADR_SK")
	  REFERENCES "ets_dev"."G_ADR_TB" ("G_ADR_SK") ;
  ALTER TABLE "ets_dev"."G_ADR_USG_TB" ADD CONSTRAINT "G_ADR_USG_F1" FOREIGN KEY ("G_CMN_ENTY_SK")
	  REFERENCES "ets_dev"."G_CMN_ENTY_TB" ("G_CMN_ENTY_SK") ;
