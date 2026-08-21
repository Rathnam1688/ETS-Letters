--------------------------------------------------------
--  Ref Constraints for Table G_PYE_PYR_EFT_SETUP_TB
--------------------------------------------------------

  ALTER TABLE "ets_dev"."G_PYE_PYR_EFT_SETUP_TB" ADD CONSTRAINT "G_PYE_PYR_EFT_SETUP_F4" FOREIGN KEY ("G_PROV_ADR_SK")
	  REFERENCES "ets_dev"."G_ADR_TB" ("G_ADR_SK") ;
  ALTER TABLE "ets_dev"."G_PYE_PYR_EFT_SETUP_TB" ADD CONSTRAINT "G_PYE_PYR_EFT_SETUP_F1" FOREIGN KEY ("G_CMN_ENTY_SK")
	  REFERENCES "ets_dev"."G_PYE_PYR_TB" ("G_CMN_ENTY_SK") ;
  ALTER TABLE "ets_dev"."G_PYE_PYR_EFT_SETUP_TB" ADD CONSTRAINT "G_PYE_PYR_EFT_SETUP_F2" FOREIGN KEY ("G_BANK_ADR_SK")
	  REFERENCES "ets_dev"."G_ADR_TB" ("G_ADR_SK") ;
