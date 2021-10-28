/*

Name: Veronika Konovalova
Project: Wealth and FAFSA 
Description: cleaning and stitching together all years of family files 
Last Updated: 7/20/21

*/

clear
global path "D:/Ian"
set maxvar 10000


/* Clean using prepared do-files 

forv i = 2001(2)2017{
clear
do "$path/psid_cleanup/workflow/Raw/FAM`i'ER.do"
save "$path/psid_cleanup/data/raw/fam_`i'.dta", replace
}

*$path/psid_cleanup/data/untouched/
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


*do "$path/psid_cleanup/workflow/Raw/J293921

global keep_vars total_wealth_equity biz_farm_netval biz_farm_debt savings val_other_realestate ///
val_debt_realestate val_stocks val_vehicles val_other_assets ira_annuity home_value ///
mortgage1 mortgage2 val_debt_credit val_debt_sl val_debt_medical val_debt_legal ///
val_debt_famloans home_equity int_num fam_weight couple_status tot_fam_income ///
val_inheritance1 val_inheritance2 val_inheritance3 tot_pension ///
val_all_debt val_debt_other


*****************
** 2001
*****************
// bring in wealth supplement
	clear 
	do "$path/psid_cleanup/workflow/Raw/WLTH2001

// merge on the main data
	rename S501 ER17002
	merge 1:1 ER17002 using "$path/psid_cleanup/data/raw/fam_2001.dta"
		drop _merge 

// rename variables  
	rename S517 total_wealth_equity
	rename S503 biz_farm_netval
	gen biz_farm_debt = . 
	rename S505 savings
	rename S509 val_other_realestate
	gen val_debt_realestate = . 
	rename S511 val_stocks
	rename S513 val_vehicles
	rename S515 val_other_assets
	rename S519 ira_annuity
	rename ER17044 home_value
	rename ER17052 mortgage1
	rename ER17063 mortgage2
	gen val_debt_credit = . 
	gen val_debt_sl = . 
	gen val_debt_medical = . 
	gen val_debt_legal = . 
	gen val_debt_famloans = . 
	rename S520 home_equity
	rename ER17002 int_num
	rename ER20394 fam_weight
	rename ER20371 couple_status
	rename ER20456 tot_fam_income
	rename ER19313 val_inheritance1
	rename ER19318 val_inheritance2
	rename ER19323 val_inheritance3
	rename ER19349 tot_pension
	rename S507 val_all_debt
	gen val_debt_other = . 

// wrap up
	keep $keep_vars
	
save "$path/psid_cleanup/data/raw/fam_2001_renamed.dta", replace 



*****************
** 2003
*****************
// bring in wealth supplement
	clear 
	do "$path/psid_cleanup/workflow/Raw/WLTH2003

// merge on the main data
	rename S601 ER21002
	merge 1:1 ER21002 using "$path/psid_cleanup/data/raw/fam_2003.dta"
		drop _merge 
		
// rename
	rename S617 total_wealth_equity
	rename S603 biz_farm_netval
	gen biz_farm_debt = . 
	rename S605 savings
	rename S609 val_other_realestate
	gen val_debt_realestate = . 
	rename S611 val_stocks
	rename S613 val_vehicles
	rename S615 val_other_assets
	rename S619 ira_annuity
	rename ER21043 home_value
	rename ER21051 mortgage1
	rename ER21062 mortgage2
	gen val_debt_credit = . 
	gen val_debt_sl = . 
	gen val_debt_medical = . 
	gen val_debt_legal = . 
	gen val_debt_famloans = . 
	rename S620 home_equity
	rename ER21002 int_num
	rename ER24179 fam_weight
	rename ER24152 couple_status
	rename ER24099 tot_fam_income
	rename ER22708 val_inheritance1
	rename ER22713 val_inheritance2
	rename ER22718 val_inheritance3
	rename ER22744 tot_pension
	rename S607 val_all_debt
	gen val_debt_other = . 

	
// wrap up
	keep $keep_vars

	save "$path/psid_cleanup/data/raw/fam_2003_renamed.dta", replace 

	

*****************
** 2005
*****************
// bring in wealth supplement
	clear 
	do "$path/psid_cleanup/workflow/Raw/WLTH2005

// merge on the main data
	rename S701 ER25002
	merge 1:1 ER25002 using "$path/psid_cleanup/data/raw/fam_2005.dta"
		drop _merge 
		
// rename
	rename S717 total_wealth_equity
	rename S703 biz_farm_netval
	gen biz_farm_debt = . 
	rename S705 savings
	rename S709 val_other_realestate
	gen val_debt_realestate = . 
	rename S711 val_stocks
	rename S713 val_vehicles
	rename S715 val_other_assets
	rename S719 ira_annuity
	rename ER25029 home_value
	rename ER25042 mortgage1
	rename ER25053 mortgage2
	gen val_debt_credit = . 
	gen val_debt_sl = . 
	gen val_debt_medical = . 
	gen val_debt_legal = . 
	gen val_debt_famloans = . 
	rename S720 home_equity
	rename ER25002 int_num
	rename ER28078 fam_weight
	rename ER28051 couple_status
	rename ER28037 tot_fam_income
	rename ER26689 val_inheritance1
	rename ER26694 val_inheritance2
	rename ER26699 val_inheritance3
	rename ER26725 tot_pension
	rename S707 val_all_debt
	gen val_debt_other = . 


// wrap up
	keep $keep_vars

	save "$path/psid_cleanup/data/raw/fam_2005_renamed.dta", replace 




*****************
** 2007
*****************
// bring in wealth supplement
	clear 
	do "$path/psid_cleanup/workflow/Raw/WLTH2007

// merge on the main data
	rename S801 ER36002
	merge 1:1 ER36002 using "$path/psid_cleanup/data/raw/fam_2007.dta"
		drop _merge 
		
// rename
	rename S817 total_wealth_equity
	rename S803 biz_farm_netval
	gen biz_farm_debt = . 
	rename S805 savings
	rename S809 val_other_realestate
	gen val_debt_realestate = . 
	rename S811 val_stocks
	rename S813 val_vehicles
	rename S815 val_other_assets
	rename S819 ira_annuity
	rename ER36029 home_value
	rename ER36042 mortgage1
	rename ER36054 mortgage2
	gen val_debt_credit = . 
	gen val_debt_sl = . 
	gen val_debt_medical = . 
	gen val_debt_legal = . 
	gen val_debt_famloans = . 
	rename S820 home_equity
	rename ER36002 int_num
	rename ER41069 fam_weight
	rename ER41041 couple_status
	rename ER41027 tot_fam_income
	rename ER37707 val_inheritance1
	rename ER37712 val_inheritance2
	rename ER37717 val_inheritance3
	rename ER37761 tot_pension
	rename S807 val_all_debt
	gen val_debt_other = . 


// wrap up
	keep $keep_vars

	save "$path/psid_cleanup/data/raw/fam_2007_renamed.dta", replace 
	
	
	

*****************
** 2009
*****************
// No more wealth supplement thankfully. 		
	use "$path/psid_cleanup/data/raw/fam_2009.dta" , clear		
	
// rename
	rename ER46970 total_wealth_equity
	rename ER46938 biz_farm_netval
	gen biz_farm_debt = . 
	rename ER46942 savings
	rename ER46950 val_other_realestate
	gen val_debt_realestate = . 
	rename ER46954 val_stocks
	rename ER46956 val_vehicles
	rename ER46960 val_other_assets
	rename ER46964 ira_annuity
	rename ER42030 home_value
	rename ER42043 mortgage1
	rename ER42062 mortgage2
	gen val_debt_credit = . 
	gen val_debt_sl = . 
	gen val_debt_medical = . 
	gen val_debt_legal = . 
	gen val_debt_famloans = . 
	rename ER46966 home_equity
	rename ER42002 int_num
	rename ER47012 fam_weight
	rename ER46985 couple_status
	rename ER46935 tot_fam_income
	rename ER43698 val_inheritance1
	rename ER43703 val_inheritance2
	rename ER43708 val_inheritance3
	rename ER43734 tot_pension
	rename ER46946 val_all_debt
	gen val_debt_other = . 


// wrap up
	keep $keep_vars

	save "$path/psid_cleanup/data/raw/fam_2009_renamed.dta", replace 
		


*****************
** 2011
*****************
// No more wealth supplement thankfully. 		
	use "$path/psid_cleanup/data/raw/fam_2011.dta" , clear		
	
// rename 
rename ER52394 total_wealth_equity
rename ER52346 biz_farm_netval
gen biz_farm_debt = . 
rename ER52350 savings
rename ER52354 val_other_realestate
gen val_debt_realestate = . 
rename ER52358 val_stocks
rename ER52360 val_vehicles
rename ER52364 val_other_assets
rename ER52368 ira_annuity
rename ER47330 home_value
rename ER47348 mortgage1
rename ER47369 mortgage2
rename ER52372 val_debt_credit
rename ER52376 val_debt_sl
rename ER52380 val_debt_medical
rename ER52384 val_debt_legal
rename ER52388 val_debt_famloans
rename ER52390 home_equity
rename ER47302 int_num
rename ER52436 fam_weight
rename ER52409 couple_status
rename ER52343 tot_fam_income
rename ER49043 val_inheritance1
rename ER49048 val_inheritance2
rename ER49053 val_inheritance3
rename ER49080 tot_pension
gen val_debt_other = . 
egen val_all_debt = rowtotal(val_debt_credit val_debt_medical val_debt_legal val_debt_famloans val_debt_sl)

// wrap up
	keep $keep_vars

	save "$path/psid_cleanup/data/raw/fam_2011_renamed.dta", replace 
		


*****************
** 2013
*****************
// No more wealth supplement thankfully. 		
	use "$path/psid_cleanup/data/raw/fam_2013.dta" , clear		
	
// rename 
	rename ER58211 total_wealth_equity
	rename ER58155 biz_farm_netval
	rename ER58157 biz_farm_debt
	rename ER58161 savings
	rename ER58165 val_other_realestate
	rename ER58167 val_debt_realestate
	rename ER58171 val_stocks
	rename ER58173 val_vehicles
	rename ER58177 val_other_assets
	rename ER58181 ira_annuity
	rename ER53030 home_value
	rename ER53048 mortgage1
	rename ER53069 mortgage2
	rename ER58185 val_debt_credit
	rename ER58189 val_debt_sl
	rename ER58193 val_debt_medical
	rename ER58197 val_debt_legal
	rename ER58201 val_debt_famloans
	rename ER58207 home_equity
	rename ER53002 int_num
	rename ER58257 fam_weight
	rename ER58227 couple_status
	rename ER58152 tot_fam_income
	rename ER54799 val_inheritance1
	rename ER54804 val_inheritance2
	rename ER54809 val_inheritance3
	rename ER54836 tot_pension
	rename ER58205 val_debt_other
	egen val_all_debt = rowtotal(val_debt_credit val_debt_medical val_debt_legal val_debt_famloans val_debt_sl)

// wrap up
	keep $keep_vars

	save "$path/psid_cleanup/data/raw/fam_2013_renamed.dta", replace 
	
	


*****************
** 2015
*****************
// No more wealth supplement thankfully. 		
	use "$path/psid_cleanup/data/raw/fam_2015.dta" , clear		
	
// rename 
	rename ER65408 total_wealth_equity
	rename ER65352 biz_farm_netval
	rename ER65354 biz_farm_debt
	rename ER65358 savings
	rename ER65362 val_other_realestate
	rename ER65364 val_debt_realestate
	rename ER65368 val_stocks
	rename ER65370 val_vehicles
	rename ER65374 val_other_assets
	rename ER65378 ira_annuity
	rename ER60031 home_value
	rename ER60049 mortgage1
	rename ER60070 mortgage2
	rename ER65382 val_debt_credit
	rename ER65386 val_debt_sl
	rename ER65390 val_debt_medical
	rename ER65394 val_debt_legal
	rename ER65398 val_debt_famloans
	rename ER65404 home_equity
	rename ER60002 int_num
	rename ER65492 fam_weight
	rename ER65463 couple_status
	rename ER65349 tot_fam_income
	rename ER61913 val_inheritance1
	rename ER61921 val_inheritance2
	rename ER61929 val_inheritance3
	rename ER61956 tot_pension
	rename ER65402 val_debt_other
	egen val_all_debt = rowtotal(val_debt_credit val_debt_medical val_debt_legal val_debt_famloans val_debt_sl)

// wrap up
	keep $keep_vars

	save "$path/psid_cleanup/data/raw/fam_2015_renamed.dta", replace 
		
	

*****************
** 2017
*****************
// No more wealth supplement thankfully. 		
	use "$path/psid_cleanup/data/raw/fam_2017.dta" , clear		
	
// rename 
	rename ER71485 total_wealth_equity
	rename ER71429 biz_farm_netval
	rename ER71431 biz_farm_debt
	rename ER71435 savings
	rename ER71439 val_other_realestate
	rename ER71441 val_debt_realestate
	rename ER71445 val_stocks
	rename ER71447 val_vehicles
	rename ER71451 val_other_assets
	rename ER71455 ira_annuity
	rename ER66031 home_value
	rename ER66051 mortgage1
	rename ER66072 mortgage2
	rename ER71459 val_debt_credit
	rename ER71463 val_debt_sl
	rename ER71467 val_debt_medical
	rename ER71471 val_debt_legal
	rename ER71475 val_debt_famloans
	rename ER71481 home_equity
	rename ER66002 int_num
	rename ER71570 fam_weight
	rename ER71542 couple_status
	rename ER71426 tot_fam_income
	rename ER67967 val_inheritance1
	rename ER67975 val_inheritance2
	rename ER67983 val_inheritance3
	rename ER68010 tot_pension
	rename ER71479 val_debt_other
	egen val_all_debt = rowtotal(val_debt_credit val_debt_medical val_debt_legal val_debt_famloans val_debt_sl)


// wrap up
	keep $keep_vars

	save "$path/psid_cleanup/data/raw/fam_2017_renamed.dta", replace 
		

***************************************
** Rename the variable for everyone 
***************************************

local list "f m ff fm mf mm"

forv i = 2001(2)2017 {
	
	foreach p of local list {
		use "$path/psid_cleanup/data/raw/fam_`i'_renamed.dta" , clear

		foreach var of varlist _all {
			rename `var' `var'_`p'`i'
			}
		
		save "$path/psid_cleanup/data/raw/fam_`i'_renamed_`p'.dta", replace 

	}
}


