/*

Name: Veronika Konovalova
Project: Wealth and FAFSA 
Description: cleaning and stitching together all years of family files 
Last Updated: 5/28/21

*/

/*
// Clean using prepared do-files 
forv i = 2005(2)2017{
clear
do D:/Veronika/psid_cleanup/workflow/Raw/FAM`i'ER.do
save D:/Veronika/psid_cleanup/data/raw/fam_`i'.dta, replace
}
*/ 


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
	// 2005
	use D:/Veronika/psid_cleanup/data/raw/fam_2005.dta, clear
	rename ER25002 int_num_`p'2005
	
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
	
	keep int_num_`p'2005 couple_status_`p'2005 tot_fam_income_`p'2005 ///
	ira_annuity_`p'2005 tot_pension_`p'2005 home_value_`p'2005 ///
	mortgage1_`p'2005 mortgage2_`p'2005 home_equity_`p'2005 ///
	biz_farm_netval_`p'2005 savings_`p'2005 val_stocks_`p'2005 ///
	val_inheritance1_`p'2005 val_inheritance2_`p'2005 val_inheritance3_`p'2005
	
	save D:/Veronika/psid_cleanup/data/raw/fam_2005_renamed_`p'.dta, replace 


	// 2007
	use D:/Veronika/psid_cleanup/data/raw/fam_2007.dta, clear
	rename ER36002 int_num_`p'2007

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

	keep int_num_`p'2007 couple_status_`p'2007 tot_fam_income_`p'2007 ///
	ira_annuity_`p'2007 tot_pension_`p'2007 home_value_`p'2007 ///
	mortgage1_`p'2007 mortgage2_`p'2007 home_equity_`p'2007 ///
	biz_farm_netval_`p'2007 val_inheritance1_`p'2007 val_inheritance2_`p'2007 ///
	val_inheritance3_`p'2007 savings_`p'2007 val_stocks_`p'2007
	
	save D:/Veronika/psid_cleanup/data/raw/fam_2007_renamed_`p'.dta, replace 


	// 2009
	use D:/Veronika/psid_cleanup/data/raw/fam_2009.dta, clear
	rename ER42002 int_num_`p'2009

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
	
	keep int_num_`p'2009 couple_status_`p'2009 ira_annuity_`p'2009 ///
	tot_pension_`p'2009 home_value_`p'2009 /// 
	mortgage1_`p'2009 mortgage2_`p'2009 home_equity_`p'2009 ///
	biz_farm_netval_`p'2009 val_inheritance1_`p'2009 val_inheritance2_`p'2009 ///
	val_inheritance3_`p'2009 savings_`p'2009 val_stocks_`p'2009 
	
	save D:/Veronika/psid_cleanup/data/raw/fam_2009_renamed_`p'.dta, replace 


	// 2011
	use D:/Veronika/psid_cleanup/data/raw/fam_2011.dta, clear
	rename ER47302 int_num_`p'2011
	
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
	rename ER48945 val_sl_`p'2011

	keep int_num_`p'2011 couple_status_`p'2011 tot_fam_income_`p'2011 ira_annuity_`p'2011 ///
	tot_pension_`p'2011 home_value_`p'2011 ///
	mortgage1_`p'2011 mortgage2_`p'2011 home_equity_`p'2011 /// 
	biz_farm_netval_`p'2011 val_inheritance1_`p'2011 val_inheritance2_`p'2011 ///
	savings_`p'2011 val_stocks_`p'2011 val_sl_`p'2011 
	
	save D:/Veronika/psid_cleanup/data/raw/fam_2011_renamed_`p'.dta, replace 


	// 2013
	use D:/Veronika/psid_cleanup/data/raw/fam_2013.dta, clear
	rename ER53002 int_num_`p'2013

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
	rename ER54697 val_sl_`p'2013
	
	keep int_num_`p'2013 couple_status_`p'2013 ira_annuity_`p'2013 ///
	tot_pension_`p'2013 home_value_`p'2013 ///
	mortgage1_`p'2013 mortgage2_`p'2013 home_equity_`p'2013 /// 
	biz_farm_debt_`p'2013 biz_farm_worth_`p'2013 val_inheritance1_`p'2013 ///
	val_inheritance2_`p'2013 val_inheritance3_`p'2013 savings_`p'2013 ///
	val_stocks_`p'2013 val_sl_`p'2013 
	
	save D:/Veronika/psid_cleanup/data/raw/fam_2013_renamed_`p'.dta, replace 


	// 2015
	use D:/Veronika/psid_cleanup/data/raw/fam_2015.dta, clear
	rename ER60002 int_num_`p'2015

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
	rename ER61808 val_sl_`p'2015
	
	keep int_num_`p'2015 couple_status_`p'2015 ira_annuity_`p'2015 ///
	tot_pension_`p'2015 home_value_`p'2015 ///
	mortgage1_`p'2015 mortgage2_`p'2015 home_equity_`p'2015 ///
	biz_farm_debt_`p'2015 biz_farm_worth_`p'2015 val_inheritance1_`p'2015 ///
	val_inheritance2_`p'2015 val_inheritance3_`p'2015 savings_`p'2015 ///
	val_stocks_`p'2015 val_sl_`p'2015
	
	save D:/Veronika/psid_cleanup/data/raw/fam_2015_renamed_`p'.dta, replace 


	// 2017
	use D:/Veronika/psid_cleanup/data/raw/fam_2017.dta, clear
	rename ER66002 int_num_`p'2017

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
	rename ER67862 val_sl_`p'2017
	
	keep int_num_`p'2017 couple_status_`p'2017 ira_annuity_`p'2017 ///
	tot_pension_`p'2017 home_value_`p'2017 /// 
	mortgage1_`p'2017 mortgage2_`p'2017 home_equity_`p'2017 ///
	biz_farm_debt_`p'2017 biz_farm_worth_`p'2017 val_inheritance1_`p'2017 ///
	val_inheritance2_`p'2017 val_inheritance3_`p'2017 savings_`p'2017 ///
	val_stocks_`p'2017 val_sl_`p'2017
	
	save D:/Veronika/psid_cleanup/data/raw/fam_2017_renamed_`p'.dta, replace 

// Use supplement file to get net worth 
forv i = 2005(2)2017{
clear
do D:/Veronika/psid_cleanup/workflow/Raw/J293921

rename ER25002 int_num_`p'2005
rename ER36002 int_num_`p'2007
rename ER42002 int_num_`p'2009
rename ER47302 int_num_`p'2011
rename ER53002 int_num_`p'2013
rename ER60002 int_num_`p'2015
rename ER66002 int_num_`p'2017

rename S717 total_wealth_equity_`p'2005
rename S817 total_wealth_equity_`p'2007
rename ER46970 total_wealth_equity_`p'2009
rename ER52394 total_wealth_equity_`p'2011
rename ER58211 total_wealth_equity_`p'2013
rename ER65408 total_wealth_equity_`p'2015
rename ER71485 total_wealth_equity_`p'2017

keep int_num_`p'`i' total_wealth_equity_`p'`i'
drop if int_num_`p'`i' == . 
save D:/Veronika/psid_cleanup/data/raw/fam_wealth_`p'_`i'.dta, replace 
}
	
}



// Now merge with TAS and IND
use D:/Veronika/psid_cleanup/data/raw/tas_with_ind.dta, clear

foreach p of local list{
	forv i = 2005(2)2017{
		merge m:1 int_num_`p'`i' using D:/Veronika/psid_cleanup/data/raw/fam_`i'_renamed_`p'.dta
		drop if _merge == 2
		drop _merge
		
		merge m:1 int_num_`p'`i' using D:/Veronika/psid_cleanup/data/raw/fam_wealth_`p'_`i'.dta
		drop if _merge == 2
		drop _merge
	}
}

save D:/Veronika/psid_cleanup/data/raw/tas_ind_fam_merged.dta, replace 



