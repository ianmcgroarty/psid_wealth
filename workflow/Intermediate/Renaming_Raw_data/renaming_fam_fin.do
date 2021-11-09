/*

Name: Veronika Konovalova
Project: Wealth and FAFSA 
Description: cleaning and stitching together all years of family files 
Last Updated: 7/20/21

*/

clear
global path "D:/Ian"
set maxvar 10000


STOP THIS FILE HAS BEEN RETIRED 



// Clean using prepared do-files 

forv i = 2001(2)2017{
clear
do "$path/psid_cleanup/workflow/Raw/FAM`i'ER.do"
save "$path/psid_cleanup/data/raw/fam_`i'.dta", replace
}



// Remember that for parents we want:
  * Total family income 
  * Retirement savings  
  * Non-retirement savings 
  * Cash savings
  * Home equity
  * Total net worth
  
// and for grandparents we want 
  * Net worth
  * Transfers to grandchildren 
  
// Find the annual famliy ID and head ID + spouse ID. Save two datasets in each year 


local list "f m ff fm mf mm"

foreach p of local list{
   
// 2001
	use "$path/psid_cleanup/data/raw/fam_2001.dta", clear
	rename ER17002 int_num_`p'2001

	* Family weight 
	rename ER20394 fam_weight_`p'2001
	
	* Couple status 
	rename ER20371 couple_status_`p'2001
	
	* Income
	rename ER20456 tot_fam_income_`p'2001

	* Retirement savings
	rename ER19210 ira_annuity_`p'2001 
	rename ER19349 tot_pension_`p'2001

	* PSID imputes home equity by defining it as home value - mortgage
	rename ER17044 home_value_`p'2001
	rename ER17052 mortgage1_`p'2001
	rename ER17063 mortgage2_`p'2001
	g home_equity_`p'2001 = home_value_`p'2001 - mortgage1_`p'2001 - mortgage2_`p'2001
	lab var home_equity_`p'2001 "HOME EQUITY"
	
	* Farm/business net value 
	rename ER19198 biz_farm_netval_`p'2001
	
	* Inheritance 
	rename ER19313 val_inheritance1_`p'2001
	rename ER19318 val_inheritance2_`p'2001
	rename ER19323 val_inheritance3_`p'2001
	
	* Savings 
	rename ER19216 savings_`p'2001
	
	* Value of stocks 
	rename ER19203 val_stocks_`p'2001
	
	* Debt 
	rename ER19227 val_all_debt_`p'2001
			replace val_all_debt_`p'2001       = . if val_all_debt_`p'2001      >= 9999998

	gen val_debt_sl_`p'2001 = . 
	gen val_debt_credit_`p'2001   = . 
	gen val_debt_medical_`p'2001  = . 
	gen val_debt_legal_`p'2001   = . 
	gen val_debt_famloans_`p'2001 = . 
	
	keep int_num_`p'2001 couple_status_`p'2001 tot_fam_income_`p'2001 ///
	ira_annuity_`p'2001 tot_pension_`p'2001 home_value_`p'2001 ///
	mortgage1_`p'2001 mortgage2_`p'2001 home_equity_`p'2001 ///
	biz_farm_netval_`p'2001 savings_`p'2001 val_stocks_`p'2001 ///
	val_inheritance1_`p'2001 val_inheritance2_`p'2001 val_inheritance3_`p'2001 ///
	val_all_debt_`p'2001 fam_weight_`p'2001 val_debt_sl_`p'2001 ///
	val_debt_credit_`p'2001  val_debt_medical_`p'2001 val_debt_legal_`p'2001  val_debt_famloans_`p'2001

	save "$path/psid_cleanup/data/raw/fam_2001_renamed_`p'.dta", replace 

// 2003
	use "$path/psid_cleanup/data/raw/fam_2003.dta", clear
	rename ER21002 int_num_`p'2003

	* Family weight 
	rename ER24179 fam_weight_`p'2003
	
	* Couple status 
	rename ER24152 couple_status_`p'2003
	
	* Income
	rename ER24099 tot_fam_income_`p'2003

	* Retirement savings
	rename ER22590 ira_annuity_`p'2003 
	rename ER22744 tot_pension_`p'2003

	* PSID imputes home equity by defining it as home value - mortgage
	rename ER21043 home_value_`p'2003
	rename ER21051 mortgage1_`p'2003
	rename ER21052 mortgage2_`p'2003
	g home_equity_`p'2003 = home_value_`p'2003 - mortgage1_`p'2003 - mortgage2_`p'2003
	lab var home_equity_`p'2003 "HOME EQUITY"
	
	* Farm/business net value 
	rename ER22563 biz_farm_netval_`p'2003
	
	* Inheritance 
	rename ER22708 val_inheritance1_`p'2003
	rename ER22713 val_inheritance2_`p'2003
	rename ER22718 val_inheritance3_`p'2003
	
	* Savings 
	rename ER22596 savings_`p'2003
	
	* Value of stocks 
	rename ER22568 val_stocks_`p'2003
	
	* Debt 
	rename ER22622 val_all_debt_`p'2003
			replace val_all_debt_`p'2003       = . if val_all_debt_`p'2003       >= 9999998

	gen val_debt_sl_`p'2003 = . 
	gen val_debt_credit_`p'2003   = . 
	gen val_debt_medical_`p'2003  = . 
	gen val_debt_legal_`p'2003   = . 
	gen val_debt_famloans_`p'2003 = . 
	
	keep int_num_`p'2003 couple_status_`p'2003 tot_fam_income_`p'2003 ///
	ira_annuity_`p'2003 tot_pension_`p'2003 home_value_`p'2003 ///
	mortgage1_`p'2003 mortgage2_`p'2003 home_equity_`p'2003 ///
	biz_farm_netval_`p'2003 savings_`p'2003 val_stocks_`p'2003 ///
	val_inheritance1_`p'2003 val_inheritance2_`p'2003 val_inheritance3_`p'2003 ///
	val_all_debt_`p'2003 fam_weight_`p'2003 val_debt_sl_`p'2003 ///
	val_debt_credit_`p'2003  val_debt_medical_`p'2003 val_debt_legal_`p'2003  val_debt_famloans_`p'2003

	save "$path/psid_cleanup/data/raw/fam_2003_renamed_`p'.dta", replace 

	
	// 2005
	use "$path/psid_cleanup/data/raw/fam_2005.dta", clear
	rename ER25002 int_num_`p'2005

	* Family weight 
	rename ER28078 fam_weight_`p'2005
	
	* Couple status 
	rename ER28051 couple_status_`p'2005
	
	* Income
	rename ER28037 tot_fam_income_`p'2005

	* Retirement savings
	rename ER26571 ira_annuity_`p'2005 
	rename ER26725 tot_pension_`p'2005

	* PSID imputes home equity by defining it as home value - mortgage
	rename ER25029 home_value_`p'2005
	rename ER25042 mortgage1_`p'2005
	rename ER25053 mortgage2_`p'2005
	g home_equity_`p'2005 = home_value_`p'2005 - mortgage1_`p'2005 - mortgage2_`p'2005
	lab var home_equity_`p'2005 "HOME EQUITY"
	
	* Farm/business net value 
	rename ER26544 biz_farm_netval_`p'2005
	
	* Inheritance 
	rename ER26689 val_inheritance1_`p'2005
	rename ER26694 val_inheritance2_`p'2005
	rename ER26699 val_inheritance3_`p'2005
	
	* Savings 
	rename ER26577 savings_`p'2005
	
	* Value of stocks 
	rename ER26549 val_stocks_`p'2005
	
	* Debt 
	rename ER26603 val_all_debt_`p'2005
		replace val_all_debt_`p'2005       = . if val_all_debt_`p'2005       >= 9999998

	gen val_debt_sl_`p'2005 = . 
	gen val_debt_credit_`p'2005   = . 
	gen val_debt_medical_`p'2005  = . 
	gen val_debt_legal_`p'2005   = . 
	gen val_debt_famloans_`p'2005 = . 
	
	keep int_num_`p'2005 couple_status_`p'2005 tot_fam_income_`p'2005 ///
	ira_annuity_`p'2005 tot_pension_`p'2005 home_value_`p'2005 ///
	mortgage1_`p'2005 mortgage2_`p'2005 home_equity_`p'2005 ///
	biz_farm_netval_`p'2005 savings_`p'2005 val_stocks_`p'2005 ///
	val_inheritance1_`p'2005 val_inheritance2_`p'2005 val_inheritance3_`p'2005 ///
	val_all_debt_`p'2005 fam_weight_`p'2005 val_debt_sl_`p'2005 ///
	val_debt_credit_`p'2005  val_debt_medical_`p'2005 val_debt_legal_`p'2005  val_debt_famloans_`p'2005

	save "$path/psid_cleanup/data/raw/fam_2005_renamed_`p'.dta", replace 


	// 2007
	use "$path/psid_cleanup/data/raw/fam_2007.dta", clear
	rename ER36002 int_num_`p'2007
	
	* Family weight 
	rename ER41069 fam_weight_`p'2007
	
	* Couple status 
	rename ER41041 couple_status_`p'2007
	
	* Income
	rename ER41027 tot_fam_income_`p'2007

	* Retirement savings
	rename ER37589 ira_annuity_`p'2007 
	rename ER37761 tot_pension_`p'2007

	* PSID imputes home equity by defining it as home value - mortgage
	rename ER36029 home_value_`p'2007
	rename ER36042 mortgage1_`p'2007
	rename ER36054 mortgage2_`p'2007 
	g home_equity_`p'2007 = home_value_`p'2007 - mortgage1_`p'2007 - mortgage2_`p'2007
	lab var home_equity_`p'2007 "HOME EQUITY"
	
	* Farm/business net value 
	rename ER37562 biz_farm_netval_`p'2007 
	
	* Inheritance 
	rename ER37707 val_inheritance1_`p'2007
	rename ER37712 val_inheritance2_`p'2007
	rename ER37717 val_inheritance3_`p'2007
	
	* Savings 
	rename ER37595 savings_`p'2007
	
	* Value of stocks 
	rename ER37567 val_stocks_`p'2007
	
	* Debt 
	rename ER37621 val_all_debt_`p'2007
	replace val_all_debt_`p'2007       = . if val_all_debt_`p'2007       >= 9999998
	
	gen val_debt_sl_`p'2007 = . 
	gen val_debt_credit_`p'2007   = . 
	gen val_debt_medical_`p'2007  = . 
	gen val_debt_legal_`p'2007   = . 
	gen val_debt_famloans_`p'2007 = . 
	
	keep int_num_`p'2007 couple_status_`p'2007 tot_fam_income_`p'2007 ///
	ira_annuity_`p'2007 tot_pension_`p'2007 home_value_`p'2007 ///
	mortgage1_`p'2007 mortgage2_`p'2007 home_equity_`p'2007 ///
	biz_farm_netval_`p'2007 val_inheritance1_`p'2007 val_inheritance2_`p'2007 ///
	val_inheritance3_`p'2007 savings_`p'2007 val_stocks_`p'2007 ///
	val_all_debt_`p'2007 fam_weight_`p'2007 val_debt_sl_`p'2007 ///
	val_debt_credit_`p'2007  val_debt_medical_`p'2007 val_debt_legal_`p'2007  val_debt_famloans_`p'2007

	save "$path/psid_cleanup/data/raw/fam_2007_renamed_`p'.dta", replace 
	

	// 2009
	use "$path/psid_cleanup/data/raw/fam_2009.dta", clear
	rename ER42002 int_num_`p'2009

	* Family weight 
	rename ER47012 fam_weight_`p'2009

	* Couple status 
	rename ER46985 couple_status_`p'2009
	
	* Income
	rename ER46935 tot_fam_income_`p'2009

	* Retirement savings
	rename ER43580 ira_annuity_`p'2009
	rename ER43734 tot_pension_`p'2009

	* PSID imputes home equity by defining it as home value - mortgage
	rename ER42030 home_value_`p'2009
	rename ER42043 mortgage1_`p'2009
	rename ER42062 mortgage2_`p'2009 
	g home_equity_`p'2009 = home_value_`p'2009 - mortgage1_`p'2009 - mortgage2_`p'2009
	lab var home_equity_`p'2009 "HOME EQUITY"
	
	* Farm/business net value 
	rename ER43553 biz_farm_netval_`p'2009
	
	* Inheritance 
	rename ER43698 val_inheritance1_`p'2009
	rename ER43703 val_inheritance2_`p'2009
	rename ER43708 val_inheritance3_`p'2009
	
	* Savings 
	rename ER43586 savings_`p'2009
	
	* Value of stocks 
	rename ER43558 val_stocks_`p'2009
	
	* Debt 
	rename ER43612 val_all_debt_`p'2009
	replace val_all_debt_`p'2009       = . if val_all_debt_`p'2009       >= 9999998
	*replace val_all_debt_`p'2009       = . if val_all_debt_`p'2009       == 2000000 
	
	gen val_debt_sl_`p'2009 = . 
	gen val_debt_credit_`p'2009   = . 
	gen val_debt_medical_`p'2009  = . 
	gen val_debt_legal_`p'2009    = . 
	gen val_debt_famloans_`p'2009 = . 
	
	keep int_num_`p'2009 couple_status_`p'2009 ira_annuity_`p'2009 ///
	tot_pension_`p'2009 home_value_`p'2009 tot_fam_income_`p'2009 /// 
	mortgage1_`p'2009 mortgage2_`p'2009 home_equity_`p'2009 val_all_debt_`p'2009 ///
	biz_farm_netval_`p'2009 val_inheritance1_`p'2009 val_inheritance2_`p'2009 ///
	val_inheritance3_`p'2009 savings_`p'2009 val_stocks_`p'2009 fam_weight_`p'2009 val_debt_sl_`p'2009 ///
	val_debt_credit_`p'2009  val_debt_medical_`p'2009 val_debt_legal_`p'2009  val_debt_famloans_`p'2009

	 save "$path/psid_cleanup/data/raw/fam_2009_renamed_`p'.dta", replace 
	
	// 2011
	use "$path/psid_cleanup/data/raw/fam_2011.dta", clear
	rename ER47302 int_num_`p'2011
	
	* Family weight 
	rename ER52436 fam_weight_`p'2011
	
	* Couple status 
	rename ER52409 couple_status_`p'2011
	
	* Income
	rename ER52343 tot_fam_income_`p'2011

	* Retirement savings
	rename ER48905 ira_annuity_`p'2011 
	rename ER49080 tot_pension_`p'2011

	* PSID imputes home equity by defining it as home value - mortgage
	rename ER47330 home_value_`p'2011
	rename ER47348 mortgage1_`p'2011
	rename ER47369 mortgage2_`p'2011 
	g home_equity_`p'2011 = home_value_`p'2011 - mortgage1_`p'2011 - mortgage2_`p'2011
	lab var home_equity_`p'2011 "HOME EQUITY"
	
	* Farm/business net value 
	rename ER48878 biz_farm_netval_`p'2011
	
	* Inheritance 
	rename ER49043 val_inheritance1_`p'2011
	rename ER49048 val_inheritance2_`p'2011
	rename ER49053 val_inheritance3_`p'2011
	
	* Savings 
	rename ER48911 savings_`p'2011
	
	* Value of stocks 
	rename ER48883 val_stocks_`p'2011
	
	* Student loans 
	rename ER48945 val_debt_sl_`p'2011
	
	* Other debt: more than one category 
	rename ER48937 val_debt_credit_`p'2011
	rename ER48949 val_debt_medical_`p'2011
	rename ER48953 val_debt_legal_`p'2011
	rename ER48957 val_debt_famloans_`p'2011

	replace val_debt_sl_`p'2011       = . if val_debt_sl_`p'2011       >= 9999998
	replace val_debt_credit_`p'2011   = . if val_debt_credit_`p'2011   >= 9999998
	replace val_debt_medical_`p'2011  = . if val_debt_medical_`p'2011  >= 9999998
	replace val_debt_legal_`p'2011    = . if val_debt_legal_`p'2011    >= 9999998
	replace val_debt_famloans_`p'2011 = . if val_debt_famloans_`p'2011 >= 9999998
	
	egen val_all_debt_`p'2011 = rowtotal(val_debt_credit_`p'2011 val_debt_medical_`p'2011 val_debt_legal_`p'2011 val_debt_famloans_`p'2011 val_debt_sl_`p'2011)
	
	keep int_num_`p'2011 couple_status_`p'2011 ///
	tot_fam_income_`p'2011 ira_annuity_`p'2011 ///
	tot_pension_`p'2011 home_value_`p'2011 ///
	mortgage1_`p'2011 mortgage2_`p'2011 home_equity_`p'2011 /// 
	biz_farm_netval_`p'2011 val_inheritance1_`p'2011 val_inheritance2_`p'2011 ///
	val_inheritance3_`p'2011 savings_`p'2011 val_stocks_`p'2011 val_debt_sl_`p'2011 ///
	val_debt_credit_`p'2011 val_debt_medical_`p'2011 val_debt_legal_`p'2011 ///
	val_debt_famloans_`p'2011 fam_weight_`p'2011 val_all_debt_`p'2011
	
	save "$path/psid_cleanup/data/raw/fam_2011_renamed_`p'.dta", replace 


	// 2013
	use "$path/psid_cleanup/data/raw/fam_2013.dta", clear
	rename ER53002 int_num_`p'2013

	* Family weight 
	rename ER58257 fam_weight_`p'2013
	
	* Couple status 
	rename ER58227 couple_status_`p'2013
	
	* Income
	rename ER58152 tot_fam_income_`p'2013

	* Retirement savings
	rename ER54655 ira_annuity_`p'2013 
	rename ER54836 tot_pension_`p'2013

	* PSID imputes home equity by defining it as home value - mortgage
	rename ER53030 home_value_`p'2013
	rename ER53048 mortgage1_`p'2013
	rename ER53069 mortgage2_`p'2013 
	g home_equity_`p'2013 = home_value_`p'2013 - mortgage1_`p'2013 - mortgage2_`p'2013
	lab var home_equity_`p'2013 "HOME EQUITY"

    * Farm/business debt 
	rename ER54629 biz_farm_debt_`p'2013
	
	* Farm/business worth 
	rename ER54625 biz_farm_worth_`p'2013
	
	* Inheritance 
	rename ER54799 val_inheritance1_`p'2013
	rename ER54804 val_inheritance2_`p'2013
	rename ER54809 val_inheritance3_`p'2013
	
	* Savings 
	rename ER54661 savings_`p'2013
	
	* Value of stocks 
	rename ER54634 val_stocks_`p'2013
	
	* Student loans 
	rename ER54697 val_debt_sl_`p'2013
	
	* Other debt: more than one category 
	rename ER54687 val_debt_credit_`p'2013
	rename ER58193 val_debt_medical_`p'2013
	rename ER54707 val_debt_legal_`p'2013
	rename ER54712 val_debt_famloans_`p'2013
	
	replace val_debt_sl_`p'2013       = . if val_debt_sl_`p'2013       >= 9999998
	replace val_debt_credit_`p'2013   = . if val_debt_credit_`p'2013   >= 9999998
	replace val_debt_medical_`p'2013  = . if val_debt_medical_`p'2013  >= 9999998
	replace val_debt_legal_`p'2013    = . if val_debt_legal_`p'2013    >= 9999998
	replace val_debt_famloans_`p'2013 = . if val_debt_famloans_`p'2013 >= 9999998
	
	egen val_all_debt_`p'2013 = rowtotal(val_debt_credit_`p'2013 val_debt_medical_`p'2013 val_debt_legal_`p'2013 val_debt_famloans_`p'2013 val_debt_sl_`p'2013)
	
	keep int_num_`p'2013 couple_status_`p'2013 ira_annuity_`p'2013 ///
	tot_pension_`p'2013 home_value_`p'2013 tot_fam_income_`p'2013 ///
	mortgage1_`p'2013 mortgage2_`p'2013 home_equity_`p'2013 /// 
	biz_farm_debt_`p'2013 biz_farm_worth_`p'2013 val_inheritance1_`p'2013 ///
	val_inheritance2_`p'2013 val_inheritance3_`p'2013 savings_`p'2013 ///
	val_stocks_`p'2013 val_debt_sl_`p'2013 fam_weight_`p'2013 ///
	val_debt_credit_`p'2013 val_debt_medical_`p'2013 val_debt_legal_`p'2013 ///
	val_debt_famloans_`p'2013 val_all_debt_`p'2013
	
	save "$path/psid_cleanup/data/raw/fam_2013_renamed_`p'.dta", replace 


	// 2015
	use "$path/psid_cleanup/data/raw/fam_2015.dta", clear
	rename ER60002 int_num_`p'2015

	* Family weight 
	rename ER65492 fam_weight_`p'2015
	
	* Couple status 
	rename ER65463 couple_status_`p'2015
	
	* Income
	rename ER65349 tot_fam_income_`p'2015

	* Retirement savings
	rename ER61766 ira_annuity_`p'2015 
	rename ER61956 tot_pension_`p'2015

	* PSID imputes home equity by defining it as home value - mortgage
	rename ER60031 home_value_`p'2015
	rename ER60049 mortgage1_`p'2015
	rename ER60070 mortgage2_`p'2015 
	g home_equity_`p'2015 = home_value_`p'2015 - mortgage1_`p'2015 - mortgage2_`p'2015
	lab var home_equity_`p'2015 "HOME EQUITY"
	
	* Farm/business debt 
	rename ER61740 biz_farm_debt_`p'2015
	
	* Farm/business worth 
	rename ER61736 biz_farm_worth_`p'2015
	
	* Inheritance 
	rename ER61913 val_inheritance1_`p'2015
	rename ER61921 val_inheritance2_`p'2015
	rename ER61929 val_inheritance3_`p'2015
	
	* Savings 
	rename ER61772 savings_`p'2015
	
	* Value of stocks 
	rename ER61745 val_stocks_`p'2015
	
	* Student loans 
	rename ER61808 val_debt_sl_`p'2015

	* Other debt: more than one category 
	rename ER61798 val_debt_credit_`p'2015
	rename ER65390 val_debt_medical_`p'2015
	rename ER61818 val_debt_legal_`p'2015
	rename ER61823 val_debt_famloans_`p'2015

	replace val_debt_sl_`p'2015       = . if val_debt_sl_`p'2015       >= 9999998
	replace val_debt_credit_`p'2015   = . if val_debt_credit_`p'2015   >= 9999998
	replace val_debt_medical_`p'2015  = . if val_debt_medical_`p'2015  >= 9999998
	replace val_debt_legal_`p'2015    = . if val_debt_legal_`p'2015    >= 9999998
	replace val_debt_famloans_`p'2015 = . if val_debt_famloans_`p'2015 >= 9999998
	
	egen val_all_debt_`p'2015 = rowtotal(val_debt_credit_`p'2015 val_debt_medical_`p'2015 val_debt_legal_`p'2015 val_debt_famloans_`p'2015 val_debt_sl_`p'2015)
		
	keep int_num_`p'2015 couple_status_`p'2015 ira_annuity_`p'2015 ///
	tot_pension_`p'2015 home_value_`p'2015 tot_fam_income_`p'2015 ///
	mortgage1_`p'2015 mortgage2_`p'2015 home_equity_`p'2015 ///
	biz_farm_debt_`p'2015 biz_farm_worth_`p'2015 val_inheritance1_`p'2015 ///
	val_inheritance2_`p'2015 val_inheritance3_`p'2015 savings_`p'2015 ///
	val_stocks_`p'2015 val_debt_sl_`p'2015 fam_weight_`p'2015 ///
	val_debt_credit_`p'2015 val_debt_medical_`p'2015 val_debt_legal_`p'2015 ///
	val_debt_famloans_`p'2015 val_all_debt_`p'2015
	
	save "$path/psid_cleanup/data/raw/fam_2015_renamed_`p'.dta", replace 


	// 2017
	use "$path/psid_cleanup/data/raw/fam_2017.dta", clear
	rename ER66002 int_num_`p'2017

	* Family weight 
	rename ER71570 fam_weight_`p'2017
	
	* Couple status 
	rename ER71542 couple_status_`p'2017
	
	* Income
	rename ER71426 tot_fam_income_`p'2017

	* Retirement savings
	rename ER67819 ira_annuity_`p'2017 
	rename ER68010 tot_pension_`p'2017

	* PSID imputes home equity by defining it as home value - mortgage
	rename ER66031 home_value_`p'2017
	rename ER66051 mortgage1_`p'2017
	rename ER66072 mortgage2_`p'2017 
	g home_equity_`p'2017 = home_value_`p'2017 - mortgage1_`p'2017 - mortgage2_`p'2017
	lab var home_equity_`p'2017 "HOME EQUITY"

    * Farm/business debt 
	rename ER67793 biz_farm_debt_`p'2017
	
	* Farm/business worth
	rename ER67789 biz_farm_worth_`p'2017
	
	* Inheritance 
	rename ER67967 val_inheritance1_`p'2017
	rename ER67975 val_inheritance2_`p'2017
	rename ER67983 val_inheritance3_`p'2017
	
	* Savings 
	rename ER67826 savings_`p'2017
	
	* Value of stocks 
	rename ER67798 val_stocks_`p'2017
	
	* Student loans 
	rename ER67862 val_debt_sl_`p'2017

	* Other debt: more than one category 
	rename ER67852 val_debt_credit_`p'2017
	rename ER71467 val_debt_medical_`p'2017
	rename ER67872 val_debt_legal_`p'2017
	rename ER67877 val_debt_famloans_`p'2017
	
	replace val_debt_sl_`p'2017       = . if val_debt_sl_`p'2017       >= 9999998
	replace val_debt_credit_`p'2017   = . if val_debt_credit_`p'2017   >= 9999998
	replace val_debt_medical_`p'2017  = . if val_debt_medical_`p'2017  >= 9999998
	replace val_debt_legal_`p'2017    = . if val_debt_legal_`p'2017    >= 9999998
	replace val_debt_famloans_`p'2017 = . if val_debt_famloans_`p'2017 >= 9999998
	
	egen val_all_debt_`p'2017 = rowtotal(val_debt_credit_`p'2017 val_debt_medical_`p'2017 val_debt_legal_`p'2017 val_debt_famloans_`p'2017 val_debt_sl_`p'2017)
	
	keep int_num_`p'2017 couple_status_`p'2017 ira_annuity_`p'2017 ///
	tot_pension_`p'2017 home_value_`p'2017 tot_fam_income_`p'2017 /// 
	mortgage1_`p'2017 mortgage2_`p'2017 home_equity_`p'2017 ///
	biz_farm_debt_`p'2017 biz_farm_worth_`p'2017 val_inheritance1_`p'2017 ///
	val_inheritance2_`p'2017 val_inheritance3_`p'2017 savings_`p'2017 ///
	val_stocks_`p'2017 val_debt_sl_`p'2017 fam_weight_`p'2017 ///
	val_debt_credit_`p'2017 val_debt_medical_`p'2017 val_debt_legal_`p'2017 ///
	val_debt_famloans_`p'2017 val_all_debt_`p'2017
	
	
	save "$path/psid_cleanup/data/raw/fam_2017_renamed_`p'.dta", replace 

// Use supplement file to get net worth 
forv i = 2001(2)2017{
clear
do "$path/psid_cleanup/workflow/Raw/J293921

rename ER17002 int_num_`p'2001
rename ER21002 int_num_`p'2003
rename ER25002 int_num_`p'2005
rename ER36002 int_num_`p'2007
rename ER42002 int_num_`p'2009
rename ER47302 int_num_`p'2011
rename ER53002 int_num_`p'2013
rename ER60002 int_num_`p'2015
rename ER66002 int_num_`p'2017

rename S517 total_wealth_equity_`p'2001
rename S617 total_wealth_equity_`p'2003
rename S717 total_wealth_equity_`p'2005
rename S817 total_wealth_equity_`p'2007
rename ER46970 total_wealth_equity_`p'2009
rename ER52394 total_wealth_equity_`p'2011
rename ER58211 total_wealth_equity_`p'2013
rename ER65408 total_wealth_equity_`p'2015
rename ER71485 total_wealth_equity_`p'2017

keep int_num_`p'`i' total_wealth_equity_`p'`i'
drop if int_num_`p'`i' == . 
save "$path/psid_cleanup/data/raw/fam_wealth_`p'_`i'.dta", replace 
}
	
}