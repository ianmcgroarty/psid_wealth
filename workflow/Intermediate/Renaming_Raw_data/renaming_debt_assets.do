*Author: Jessica Kiser
*Date:06.25.2018
*Description: This file renames demographics PSID data

clear all
set more off
******************************************************************************************/

use "\\c1resp3\Retail_Risk_Analysis\Non_Restricted_Research\Kiser\PSID\PSID_Jessica\data\raw\debt_assets_psid_raw.dta", clear 


***Combining famid and pnid to create a unique identifier for each observation
	rename ER30001 famid
	label var famid "unique family id #, for each family from 1968"
	rename ER30002 pnid
	label var pnid "unique person #, for each individual"

	gen famidpn  = (famid*1000)+ pn
	tostring famidpn, gen(famidpns)
	sort famidpn
	order famidpn famidpns

	*****************renaming variables**********************
		
*sequence number 
	rename ER33802 seq_num_2005
	rename ER33902 seq_num_2007
	rename ER34002 seq_num_2009
	rename ER34102 seq_num_2011
	rename ER34202 seq_num_2013
	rename ER34302 seq_num_2015
	
*interview number
	rename ER33801 int_num_2005
	rename ER33901 int_num_2007
	rename ER34001 int_num_2009
	rename ER34101 int_num_2011
	rename ER34201 int_num_2013
	rename ER34301 int_num_2015
	
*relation to head
	rename ER33803 rel_head_2005
	rename ER33903 rel_head_2007
	rename ER34003 rel_head_2009
	rename ER34103 rel_head_2011
	rename ER34203 rel_head_2013
	rename ER34303 rel_head_2015
	
*release number
	rename ER30000 release_all
	rename ER25001 release_2005
	rename ER36001 release_2007
	rename ER42001 release_2009
	rename ER47301 release_2011
	rename ER53001 release_2013
	rename ER60001 release_2015

**end year job 1	
rename ER25114 end_yrj1_2005
rename ER36119 end_yrj1_2007
rename ER42154 end_yrj1_2009
rename ER47466 end_yrj1_2011
rename ER53166 end_yrj1_2013
rename ER60181 end_yrj1_2015

*end year job 2
rename ER25177 end_yrj2_2005
rename ER36182 end_yrj2_2007
rename ER42215 end_yrj2_2009
rename ER47528 end_yrj2_2011
rename ER53228 end_yrj2_2013
rename ER60243 end_yrj2_2015

*end year job 3
rename ER25209 end_yrj3_2005
rename ER36214 end_yrj3_2007
rename ER42245 end_yrj3_2009
rename ER47558 end_yrj3_2011
rename ER53258 end_yrj3_2013
rename ER60273 end_yrj3_2015

*end year job 4 
rename ER25241 end_yrj4_2005
rename ER36246 end_yrj4_2007
rename ER42275 end_yrj4_2009
rename ER47588 end_yrj4_2011
rename ER53288 end_yrj4_2013
rename ER60303 end_yrj4_2015

*reason end job 1
rename ER25173 reason_endj1_2005
rename ER36178 reason_endj1_2007
rename ER42211 reason_endj1_2009
rename ER47524 reason_endj1_2011
rename ER53224 reason_endj1_2013
rename ER60239 reason_endj1_2015

*reason end job 2
rename ER25205 reason_endj2_2005
rename ER36210 reason_endj2_2007
rename ER42241 reason_endj2_2009
rename ER47554 reason_endj2_2011
rename ER53254 reason_endj2_2013
rename ER60269 reason_endj2_2015

*reason end job 3
rename ER25237 reason_endj3_2005
rename ER36242 reason_endj3_2007
rename ER42271 reason_endj3_2009
rename ER47584 reason_endj3_2011
rename ER53284 reason_endj3_2013
rename ER60299 reason_endj3_2015

*reason end job 4
rename ER25269 reason_endj4_2005
rename ER36274 reason_endj4_2007
rename ER42301 reason_endj4_2009
rename ER47614 reason_endj4_2011
rename ER53314 reason_endj4_2013
rename ER60329 reason_endj4_2015

*end year job 1 spouse
rename ER25372 end_yrj1_sp_2005
rename ER36377 end_yrj1_sp_2007
rename ER42406 end_yrj1_sp_2009
rename ER47723 end_yrj1_sp_2011
rename ER53429 end_yrj1_sp_2013
rename ER60444 end_yrj1_sp_2015

*end year job 2 spouse
rename ER25435 end_yrj2_sp_2005
rename ER36440 end_yrj2_sp_2007
rename ER42467 end_yrj2_sp_2009
rename ER47785 end_yrj2_sp_2011
rename ER53491 end_yrj2_sp_2013
rename ER60506 end_yrj2_sp_2015

*end year job 3 spouse
rename ER25467 end_yrj3_sp_2005
rename ER36472 end_yrj3_sp_2007
rename ER42497 end_yrj3_sp_2009
rename ER47815 end_yrj3_sp_2011
rename ER53521 end_yrj3_sp_2013
rename ER60536 end_yrj3_sp_2015

*end year job 4 spouse
rename ER25499 end_yrj4_sp_2005
rename ER36504 end_yrj4_sp_2007
rename ER42527 end_yrj4_sp_2009
rename ER47845 end_yrj4_sp_2011
rename ER53551 end_yrj4_sp_2013
rename ER60566 end_yrj4_sp_2015

*reason end job 1 spouse
rename ER25431 reason_endj1_sp_2005
rename ER36436 reason_endj1_sp_2007
rename ER42463 reason_endj1_sp_2009
rename ER47781 reason_endj1_sp_2011
rename ER53487 reason_endj1_sp_2013
rename ER60502 reason_endj1_sp_2015

*reason end job 2 spouse
rename ER25463 reason_endj2_sp_2005
rename ER36468 reason_endj2_sp_2007
rename ER42493 reason_endj2_sp_2009
rename ER47811 reason_endj2_sp_2011
rename ER53517 reason_endj2_sp_2013
rename ER60532 reason_endj2_sp_2015

*reason end job 3 spouse
rename ER25495 reason_endj3_sp_2005
rename ER36500 reason_endj3_sp_2007
rename ER42523 reason_endj3_sp_2009
rename ER47841 reason_endj3_sp_2011
rename ER53547 reason_endj3_sp_2013
rename ER60562 reason_endj3_sp_2015

*reason end job 4 spouse
rename ER25527 reason_endj4_sp_2005
rename ER36532 reason_endj4_sp_2007
rename ER42553 reason_endj4_sp_2009
rename ER47871 reason_endj4_sp_2011
rename ER53577 reason_endj4_sp_2013
rename ER60592 reason_endj4_sp_2015

*number of jobs held by head
rename ER40686D4 num_jobs_2005
rename ER46670A num_jobs_2007
rename ER52071A num_jobs_2009
rename ER57826 num_jobs_2011
rename ER65006 num_jobs_2013

*drop 2003
drop ER27711D4 ER27711J7

*number of jobs held by spouse
rename ER40686J7 num_jobs_sp_2005
rename ER46681A num_jobs_sp_2007
rename ER52082A num_jobs_sp_2009
rename ER57874 num_jobs_sp_2011
rename ER65054 num_jobs_sp_2013

*head and spouse taxable income
rename ER27953 taxable_inc_hd_sp_2005
rename ER40943 taxable_inc_hd_sp_2007
rename ER46851 taxable_inc_hd_sp_2009
rename ER52259 taxable_inc_hd_sp_2011
rename ER58060 taxable_inc_hd_sp_2013
rename ER65253 taxable_inc_hd_sp_2015

*wtr have checking, savings, cds, etc... 
rename ER26576 savings_2005 
rename ER37594 savings_2007
rename ER43585 savings_2009
rename ER48910 savings_2011
rename ER54660 savings_2013
rename ER61771 savings_2015

*debts
rename ER26602 cr_st_med_legal_fam_2005
rename ER37620 cr_st_med_legal_fam_2007
rename ER43611 cr_st_med_legal_fam_2009

rename ER26603 value_debts_2005
rename ER37621 value_debts_2007
rename ER43612 value_debts_2009

rename ER48936 credit_debt_2011
rename ER54686 credit_debt_2013
rename ER61797 credit_debt_2015

rename ER48941 st_loans_2011
rename ER48942 med_bills_2011
rename ER48943 legal_bills_2011
rename ER48944 fam_loans_2011
rename ER54696 st_med_legal_fam_2013
rename ER61807 st_med_legal_fam_2015

rename ER52372 value_card_debt_2011
rename ER52376 value_student_debt_2011
rename ER52380 value_med_debt_2011
rename ER52384 value_legal_debt_2011
rename ER52388 value_fam_loan_debt_2011

rename ER54687 value_card_debt_2013
rename ER54718 value_other_debt_2013
rename ER61798 value_card_debt_2015
rename ER61829 value_other_debt_2015

save \\c1resp3\Retail_Risk_Analysis\Non_Restricted_Research\Kiser\PSID\PSID_Jessica\data\raw\debt_assets_psid_renamed.dta,replace 



gen bus2013=ER58155 - ER5815
