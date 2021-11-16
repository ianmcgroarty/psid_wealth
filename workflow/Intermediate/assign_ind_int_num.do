
global path "D:/Ian"


***********************
// Get the interview numbers from the individual files 
***********************
do "$path/psid_cleanup/workflow/Raw/IND2019ER.do"


	rename ER30001 famid
	label var famid "unique family id #, for each family from 1968"
	rename ER30002 pnid
	label var pnid "unique person #, for each individual"
	
	gen famidpn  = (famid*1000) + pn
	tostring famidpn, gen(famidpns)
	sort famidpn

// do a rename
	keep famidpns ///
		ER33601 ER33701 ER33801 ER33901 ER34001 ER34101 ER34201 ER34301 ER34501  ER34701 ///
		ER33838C ER33938C ER34032A ER34144A ER34251A ER34401A ER34636 ER34845 

	rename ER33601 ind_int_num2001
	rename ER33701 ind_int_num2003
	rename ER33801 ind_int_num2005
	rename ER33901 ind_int_num2007
	rename ER34001 ind_int_num2009
	rename ER34101 ind_int_num2011
	rename ER34201 ind_int_num2013
	rename ER34301 ind_int_num2015
	rename ER34501 ind_int_num2017
	rename ER34701 ind_int_num2019
	
	rename ER33838C labor_income_earned2005
	rename ER33938C labor_income_earned2007
	rename ER34032A labor_income_earned2009
	rename ER34144A labor_income_earned2011
	rename ER34251A labor_income_earned2013
	rename ER34401A labor_income_earned2015
	rename ER34636 labor_income_earned2017
	rename ER34845 labor_income_earned2019

// I'm in love with the reshape of you
	reshape long ind_int_num labor_income_earned , i(famidpns) j(year)

// save
	save "$path/psid_cleanup/data/intermediate/individual_interview_numbers.dta" , replace 
	
*use 	"$path/psid_cleanup/data/intermediate/individual_interview_numbers.dta" , clear

***********************
// Interview Eligiblilty
***********************
do "$path/psid_cleanup/workflow/Raw/IND2019ER.do"


***Combining famid and pnid to create a unique identifier for each observation
	rename ER30001 famid
	label var famid "unique family id #, for each family from 1968"
	rename ER30002 pnid
	label var pnid "unique person #, for each individual"

	gen famidpn  = (famid*1000) + pn
	tostring famidpn, gen(famidpns)
	sort famidpn
	

	rename ER33418 cds97_eligible
	rename ER33419 cds97_selected
	rename ER33420 cds97_result
	rename ER33638 cds01_result
	rename ER33844 cds_tas05_eligible
	rename ER33845 cds_tas05_result
	rename ER33944 cds_tas07_eligible
	rename ER33945 cds_tas07_result
	rename ER34038 cds_tas09_eligible
	rename ER34039 cds_tas09_result
	rename ER34150 cds_tas11_eligible
	rename ER34151 cds_tas11_result
	rename ER34257 cds_tas13_eligible
	rename ER34258 cds_tas13_result
	rename ER34259 cds14_eligible
	rename ER34260 cds14_selected
	rename ER34261 cds14_result
	rename ER34261A cds14_complete
	rename ER34407 cds_tas15_eligible
	rename ER34408 cds_tas15_result
	rename ER34646 cds_tas17_eligible
	rename ER34647 cds_tas17_result
	rename ER34859 cds_tas19_result
	rename ER34857 cds_tas_eligible 

	
keep famidpns cds*
save "$path/psid_cleanup/data/intermediate/interview_eligibility.dta", replace 	
	

***********************
// Merge 
***********************

// bring in the "final" data
	use "$path/psid_cleanup/data/intermediate/wealth_finaid_psid_final.dta", clear

// merge the weights by year
	merge 1:1 famidpns year using "$path/psid_cleanup/data/intermediate/individual_interview_numbers.dta"
*merge m:1 famidpns using temp_int.dta
		keep if _merge == 3 
		drop _merge 

// merge the eligibility for the individual 
	merge m:1 famidpns using "$path/psid_cleanup/data/intermediate/interview_eligibility.dta"
		keep if _merge == 3 
		drop _merge 
		
			
save "$path/psid_cleanup/data/intermediate/wealth_finaid_psid_with_indintnum.dta" , replace
	*keep famidpn age year int_num* ind_int_num*
	
	

 