
global path "D:/Ian"


do "$path/psid_cleanup/workflow/Raw/IND2019ER.do"

// Get the interview numbers from the individual files 
	rename ER30001 famid
	label var famid "unique family id #, for each family from 1968"
	rename ER30002 pnid
	label var pnid "unique person #, for each individual"
	
	gen famidpn  = (famid*1000) + pn
	tostring famidpn, gen(famidpns)
	sort famidpn

// do a rename
	keep famidpns ER33601 ER33701 ER33801 ER33901 ER34001 ER34101 ER34201 ER34301 ER34501 
	rename ER33601 ind_int_num2001
	rename ER33701 ind_int_num2003
	rename ER33801 ind_int_num2005
	rename ER33901 ind_int_num2007
	rename ER34001 ind_int_num2009
	rename ER34101 ind_int_num2011
	rename ER34201 ind_int_num2013
	rename ER34301 ind_int_num2015
	rename ER34501 ind_int_num2017

// I'm in love with the reshape of you
	reshape long ind_int_num, i(famidpns) j(year)

// save
	save "$path/psid_cleanup/data/intermediate/individual_interview_numbers.dta" , replace 
	
*use 	"$path/psid_cleanup/data/intermediate/individual_interview_numbers.dta" , clear

// bring in the "final" data
	use "$path/psid_cleanup/data/intermediate/wealth_finaid_psid_final.dta", clear

// what a beautiful merge
	merge 1:1 famidpns year using "$path/psid_cleanup/data/intermediate/individual_interview_numbers.dta"
*merge m:1 famidpns using temp_int.dta
		keep if _merge == 3 
		drop _merge 

save "$path/psid_cleanup/data/intermediate/wealth_finaid_psid_with_indintnum.dta" , replace
	*keep famidpn age year int_num* ind_int_num*
	
	
***********************	
// MISC / Trash 	
***********************
cap drop ind_int_num_status
gen ind_int_num_status = "base"
	replace ind_int_num_status = "Same as M & F" if ind_int_num  == int_num_f & ind_int_num == int_num_m
	replace ind_int_num_status = "Same as Only M" if ind_int_num  != int_num_f & ind_int_num == int_num_m
	replace ind_int_num_status = "Same as Only F" if ind_int_num  == int_num_f & ind_int_num != int_num_m
	replace ind_int_num_status = "Different" if ind_int_num  != int_num_f & ind_int_num != int_num_m
	replace ind_int_num_status = "none" if ind_int_num == 0
	replace ind_int_num_status = "Grandparent" if ind_int_num_status == "Different" & (ind_int_num == int_num_ff | ind_int_num == int_num_fm |ind_int_num == int_num_mm | ind_int_num == int_num_mf)
	
	tab ind_int_num_status, m 
	tab ind_int_num_status if age >= 15 & age <= 16, m
	tab ind_int_num_status if age >= 17 & age <= 18, m

	
	count if ind_int_num_status == "Different" & age <=16
	
	bysort year: gen year_count = _n if ind_int_num_status == "Different" & age <=16
	sort famidpn year
br if ind_int_num_status == "Different" & age <=16

	
	
sort famidpns year
*br if ind_int_num_status == "Different" & age <= 16	

cap drop ever_different 
cap drop currently_different
gen currently_different = 0
replace currently_different = 1 if ind_int_num_status == "Different" & age <= 16
bysort famidpns: egen ever_different = max(currently_different )
order famidpn famidpns year birth_year age int_num int_num_f int_num_m ind_int_num ind_int_num_status currently_different ever_different
*br if ever_different == 1

gen mf_int_num_status = "base"
	replace mf_int_num_status = "Different" if int_num_f != int_num_m
	replace mf_int_num_status = "Same" if int_num_f == int_num_m
	replace mf_int_num_status = "One 0/." if (int_num_f == 0 | int_num_f == .)  | (int_num_m == 0 | int_num_m == . )
	replace mf_int_num_status = "Both 0/." if (int_num_f == 0 | int_num_f == .)  & (int_num_m == 0 | int_num_m == . )
	


 