--------------------------------------------------------
--  Ref Constraints for Table R_PARAM_DTL_TB
--------------------------------------------------------

  ALTER TABLE "ets_dev"."R_PARAM_DTL_TB" ADD CONSTRAINT "R_PARAM_DTL_F1" FOREIGN KEY ("R_FUNC_AREA_CD", "R_PARAM_NUM")
	  REFERENCES "ets_dev"."R_PARAM_TB" ("R_FUNC_AREA_CD", "R_PARAM_NUM") ;
