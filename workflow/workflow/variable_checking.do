clear 
set more off

global path "D:/Ian"


*use "$path/psid_cleanup/data/wealth_finaid_psid_inf_adj.dta", clear
*use "$path/psid_cleanup/data/intermediate/wealth_finaid_psid_final.dta", clear

*do "$path/psid_cleanup/workflow/assign_ind_int_num.do" 
*do "$path/psid_cleanup/workflow/sat_act_convert.do" 

use "$path/psid_cleanup/data/intermediate/wealth_finaid_psid_with_indintnum.dta", clear


global keyvarlist famidpns year birth_year age int_num ind_int_num int_num_f int_num_m 
order $keyvarlist
	* br $keyvarlist 

	
// If I want keep only 17/18 year olds change this to 1 
	* I do it this way because some things I need the full history, so I'll drop it later, but I want the condition at the top for easy access. 
	global keep_ages = 1
	di "$keep_ages "	
	
	tab age
	
	
*******************************************************************************	
**# WEIGHTS 
*******************************************************************************
// The great rename. I don't want to mess anything up but this needs to be done. 
	rename tas_weight			   tas_long_weight
	rename cross_sectional_weight  tas_cross_weight
	rename ind_weight              ind_long_weight
	rename cds_weight 			   cds_weight
	rename ind_cross_weight		   ind_cross_weight
	
// Doing it the "old" way (see email 10/25 & 10/26 "Weights, weights, weights")
	gen tas_weight_old = tas_long_weight
		replace tas_weight_old  = cds_weight if year == 2017

// Take a look 
	tabstat tas_long_weight , by(year) stat(count min mean max sum p50)
	tabstat tas_cross_weight , by(year) stat(count min mean max sum p50)
	tabstat cds_weight , by(year) stat(count min mean max sum p50)
	tabstat ind_long_weight , by(year) stat(count min mean max sum p50)
	tabstat ind_cross_weight , by(year) stat(count min mean max sum p50)
	tabstat tas_weight_old , by(year) stat(count min mean max sum p50)
 
*sort famidpns year
*br famidpns year tas_long_weight cds_weight
 ** NOTE 0 should technically be missing.
	*replace tas_weight = . if tas_weight == 0
	*replace cds_weight = . if cds_weight == 0

	bysort year: count if tas_long_weight == 0 
	bysort year: count if cds_weight == 0 

	count if tas_long_weight != 0 & tas_cross_weight != 0 & tas_long_weight != . & tas_cross_weight!= . 
	count if tas_long_weight != 0 & cds_weight != 0 & cds_weight != . & cds_weight != .

	count if tas_long_weight != 0 & tas_long_weight != . & inlist(age,17,18)
	count if cds_weight != 0 & cds_weight != . & inlist(age,17,18)
	count if tas_long_weight != 0 & cds_weight != 0 & tas_long_weight != . & cds_weight != . & inlist(age,17,18)

	tab age if tas_long_weight != 0 & tas_cross_weight != 0 & tas_long_weight != . & tas_cross_weight!= . 
	*tab tas_long_weight if year== 2017

	
	tabstat tas_long_weight if inlist(age,17,18), by (year) stat(count sum min mean p50 max )
	tabstat tas_cross_weight if inlist(age,17,18), by (year) stat(count sum min mean p50 max )
	tabstat cds_weight if inlist(age,17,18), by (year) stat(count sum min mean p50 max )
	tabstat ind_long_weight if inlist(age,17,18), by (year) stat(count sum min mean p50 max )
	
	 
// Get the average tas_long_weight over the individual's life 
	sort famidpn
	egen avg_tas_long_weight = mean(tas_long_weight), by(famidpn)
	gen  avg_tas_long_weight_int = int(avg_tas_long_weight)
	*keep if famidpn ~= famidpn[_n-1]

	sort famidpn 
	egen avg_tas_weight_old = mean(tas_weight_old), by(famidpn)
	gen avg_tas_weight_old_int = int(avg_tas_weight_old)
	
// A bit deeper to drive it home
	tabstat tas_long_weight tas_weight_old if inlist(age,17,18), ///
		by (year) stat(count sum min mean p50 max )  col(statistics) format(%9.2f)
	
	tabstat avg_tas_long_weight avg_tas_weight_old_int if inlist(age,17,18), ///
		by (year) stat(count sum min mean p50 max )  col(statistics) format(%9.2f)

	tabstat tas_long_weight tas_weight_old ind_long_weight tas_cross_weight cds_weight ///
		, by (year) stat(count sum min mean p50 max ) col(statistics) format(%9.2f)	
/*
	sort famidpns year  
	drop fam_weight*
	br $keyvarlist *weight*
	gen diff = 1 if tasweightave_old != tasweightave

	twoway (scatter tas_long_weight tas_weight_old) /// 
			(function y=x, range(0 100) lwidth(0.8)) ///
			, xtitle(tas_weight_old) ytitle(tas_long_weight) ///
			legend(order(1 "weight" 2 "45 degree line"))
*/ 		
	
// Individual weight
	bysort famidpns: egen min_ind_long_weight = min(ind_long_weight)
	bysort famidpns: egen max_ind_long_weight = max(ind_long_weight)
	gen ind_long_weight_range = max_ind_long_weight - min_ind_long_weight

	gen ind_long_weight_nozero = ind_long_weight
		replace ind_long_weight_nozero = . if ind_long_weight_nozero == 0
	
	tabstat ind_long_weight if inlist(age,17,18), by (year) stat(count sum min mean p50 max )
	tabstat ind_long_weight_nozero if inlist(age,17,18), by (year) stat(count sum min mean p50 max )
	
	
	
// Weight by age 
	gen temp_tas_long_weight_15_16 = tas_long_weight if inlist(age,15,16 )
	gen temp_tas_long_weight_17_18 = tas_long_weight if inlist(age,17,18 )
	gen temp_tas_long_weight_19_20 = tas_long_weight if inlist(age,19,20 )
	gen temp_tas_long_weight_21_22 = tas_long_weight if inlist(age,21,22 )
	gen temp_tas_long_weight_23_24 = tas_long_weight if inlist(age,23,24 )
	gen temp_tas_long_weight_25_26 = tas_long_weight if inlist(age,25,26 )
	gen temp_tas_long_weight_27_28 = tas_long_weight if inlist(age,27,28 )
	
	bysort famidpns: egen tas_long_weight_15_16 = max(temp_tas_long_weight_15_16) 
	bysort famidpns: egen tas_long_weight_17_18 = max(temp_tas_long_weight_17_18) 
	bysort famidpns: egen tas_long_weight_19_20 = max(temp_tas_long_weight_19_20) 
	bysort famidpns: egen tas_long_weight_21_22 = max(temp_tas_long_weight_21_22) 
	bysort famidpns: egen tas_long_weight_23_24 = max(temp_tas_long_weight_23_24) 
	bysort famidpns: egen tas_long_weight_25_26 = max(temp_tas_long_weight_25_26) 
	bysort famidpns: egen tas_long_weight_27_28 = max(temp_tas_long_weight_27_28) 
	
	drop temp_tas*

	
*	 br $keyvarlist *weight*
*******************************************************************************
**# Identification Variables 
*******************************************************************************
	
// Baseline	
	tab year
	bysort famidpns: gen num_famid_obs = _n 
	tab num_famid_obs 

// Transitioning adult survey
	tab TAS,m // no one has never filled out TAS 
	tab age if int_num != . 
	 * seems like they fill out TAS at 16/17 - 27/28
	 tab age
	
	** Question: If they fill out TAS can they still live @ home.  

// Interview variables
	cap drop dup 
		bysort famidpn year: gen dup = cond(_N==1,0,_n)
		tab dup // these are are unique ids
		drop dup 
	
	cap drop dup
		bysort int_num_f: gen dup = cond(_N==1,0,_n) if int_num_f != . & int_num_f != 0
		tab dup
		
	** QUESTION: are 0s different from . 
		/* oh it looks like int_num 0 just means that they were not interviewed that year but are in the data 
		 Missing means that they weren't in the data. Basically, missings were created when we reshaped the data. 
		 But zeros indicate that something "should" be there but isn't. 
		I don't think this is right now...
		*/ 
		
	** QUESTION: 
	*br if int_num_f == 8471 
	*br if inlist(famidpn, 2119184,2119183,377030,377031)
		sort  famidpn year
		* So I think it is clear that int_num_f is not unique across years only within a year
		* next 377030 doesn't live at home, but 377031 does. 
	
	** int_num was actually the TAS int_num but we really needed the individual FAMILY int_num to see who the child interviewed with. 
	* br $keyvarlist 
	
	
*******************************************************************************
**# Age investigation
*******************************************************************************

// general variables 
	*hist year // these are even
	*hist birth_year
	*hist age
	tab age, m


// How many individuals do we have 
	count if year == 2015	// 4,058
	count if age == 15 | age == 16 // 
	count if age == 17 | age == 18 // 4,030

// problems with age?
	gen calendar_age = year-birth_year
	count if calendar_age != age
	gen age_diff = calendar_age-age
	tab age_diff if age <= 20, m 
	
	drop age_diff 
	rename age true_age
	rename calendar_age age 
	** NOTE: while this might be the "true" age, we need it to be calandar age for our purposes 
		** since the surveys are 2 years aparyt but some times it looks like 3 years. . 	

// mother / father birth year for later	
	replace age_f = . if age_f == 0
	replace age_m = . if age_m == 0
	
	gen temp_birth_year_f = year - age_f
	gen temp_birth_year_m = year - age_m 
	
	bysort famidpns: egen birth_year_f = max(temp_birth_year_f)
	bysort famidpns: egen birth_year_m = max(temp_birth_year_m)

	*sort famidpns year
	*br $keyvarlist age* birth* temp*
	
	
	drop age_f age_m age_ff age_fm age_fm age_mf age_mm temp* 

	** There are a lot of missings, but not many where BOTH are missing 
		tab birth_year_f , m 
		tab birth_year_m , m 
		
		count if birth_year_f  == . & birth_year_m == . 
		
// Age @ Birth 
		gen age_f_at_birth = birth_year- birth_year_f
		gen age_m_at_birth = birth_year- birth_year_m
		
		tab age_f_at_birth , m
		tab age_m_at_birth , m
		
// For me own curiosity 
	bysort famidpns: egen max_age_reached = max(age) 
	bysort famidpns: egen min_age_reached = min(age)
	tab max_age_reached if inlist(age, 17,18)

	gen age_withstl = age if value_sl != 0 & value_sl != . 
	bysort famidpns: egen max_age_reached_with_stl = max(age_withstl) 
	bysort famidpns: egen min_age_reached_with_stl = min(age_withstl)

	tab max_age_reached_with_stl

	drop max_age_reached min_age_reached age_withstl max_age_reached_with_stl min_age_reached_with_stl


// Parents ages 
tab birth_year_m 	, m 
tab birth_year_f ,m 
	* Okay obviously this is wrong. 


	
// Siblings? 
	sort famidpn year
	*br famid* year	age

	sort famidpn_f famidpn_m famidpns year 
	*br famid* year	age

	** So there is a problem with this. If the parent has a child that isn't in TAS then they wouldn't be counted. 
		** Makig this ropbust to if we add another year 
		bysort year: gen temp_nyrs = _n ==1
		count if temp_nyrs
		bysort famidpn_f: gen num_observed_kids_f = _N/r(N) 
		bysort famidpn_m: gen num_observed_kids_m = _N/r(N) 
		drop temp_nyrs
	sort famidpn_f famidpn_m famidpns year 

		
*******************************************************************************
**# Individual Student Loans
*******************************************************************************
* Note for value_sl I drop the 99s in renaming_tas.do
	tabstat value_sl , statistics(count mean p10 p50 p75 min max sd)
	
// Want the value of the child's student loan debt at each age group. But the variable is currently long	
	gen temp_sl_debt_at_17_18 = value_sl if inlist(age,17,18)
	gen temp_sl_debt_at_19_20 = value_sl if inlist(age,19,20)
	gen temp_sl_debt_at_21_22 = value_sl if inlist(age,21,22)
	gen temp_sl_debt_at_23_24 = value_sl if inlist(age,23,24)
	gen temp_sl_debt_at_25_26 = value_sl if inlist(age,25,26)
	
	bysort famidpns: egen sl_debt_at_17_18 = max(temp_sl_debt_at_17_18)
	bysort famidpns: egen sl_debt_at_19_20 = max(temp_sl_debt_at_19_20)
	bysort famidpns: egen sl_debt_at_21_22 = max(temp_sl_debt_at_21_22)
	bysort famidpns: egen sl_debt_at_23_24 = max(temp_sl_debt_at_23_24)
	bysort famidpns: egen sl_debt_at_25_26 = max(temp_sl_debt_at_25_26)

	drop temp_sl_d*

	egen sl_debt_by_21_22 = rowmax(sl_debt_at_17_18 sl_debt_at_19_20 sl_debt_at_21_22)
	egen sl_debt_by_23_24 = rowmax(sl_debt_at_17_18 sl_debt_at_19_20 sl_debt_at_21_22 sl_debt_at_23_24)
	egen sl_debt_by_25_26 = rowmax(sl_debt_at_17_18 sl_debt_at_19_20 sl_debt_at_21_22 sl_debt_at_23_24 sl_debt_at_25_26)

// see whats going on 
	tabstat sl_debt_by_21_22 if sl_debt_by_21_22 != 0 & inlist(age,17,18) , statistics(count mean p10 p50 p75 min max sd)
	tabstat sl_debt_by_23_24 if sl_debt_by_23_24 != 0 & inlist(age,17,18) , statistics(count mean p10 p50 p75 min max sd)
	tabstat sl_debt_by_25_26 if sl_debt_by_25_26 != 0 & inlist(age,17,18) , statistics(count mean p10 p50 p75 min max sd)

// If we want to use all the student loan variables or just the subsidized ones. 
	* We decided to only use: Stafford, Perkins, other federally subsidized since the rest are for graduate school. 
	gen value_sl_all_w09 = value_sl_all 
	replace value_sl_all_w09  = value_sl if year <2013
	
	tabstat value_sl if value_sl != 0           & age <= 25, statistics(count mean p10 p50 p75 min max) by(year)
	tabstat value_sl_all_w09 if value_sl_all_w09 != 0   & age <= 25, statistics(count mean p10 p50 p75 min max) by(year)
	
	drop value_sl_all_w09 value_sl_all

	sort famidpns year 
	*br $keyvarlist value_sl value_sl_all value_sl_all_w09 

	
	
*******************************************************************************
**# Quick Wealth Cleaning 
*******************************************************************************
**************	
// Family Income
	** This is from the family file
	** The first occurence of this question was in 2011, prior to that it was part of "all other debts"
**************
	
	sum tot_fam_income* 
	foreach var of varlist tot_fam_income*  {
		di "~~~~~~~~~ `var' ~~~~~~~"
		sum `var'
		count if `var' == 0
		count if `var' == . 
		count if `var' >= 9999997 & `var' != . 
		count if `var' < 0
		replace 	`var' = 0 if `var' < 0 
	} 
		** There is an upper bound at 9,999,999 but id doesn't look like that is ever hit. 
		** I was instructed to set negative income to zero since it is possible to have debt but that won't be materially different from 0 in FinAid considerations. 

		sum tot_fam_income* 
		

**************	
// Parent's Student Loan Debt 
	** This is from the family file
	** The first occurence of this question was in 2011, prior to that it was part of "all other debts"
	** I ended up needing to clean a lot of these variables in "renaming_fam_fin.do"
**************


drop val_debt_sl_ff val_debt_sl_fm val_debt_sl_mf val_debt_sl_mm val_debt_sl_f val_debt_sl_m

	sum val_debt_sl*
		** Seems like there is another upper value at 9,999,999
	foreach var of varlist val_debt_sl* {
	   di "~~~~~~~~~ `var' ~~~~~~~"
			sum `var'
			count if `var' == 0
			count if `var' == .
			count if `var' != 0 & `var' != . 
			count if `var' == 9999997
			count if `var' > 999999
			
			replace `var' = . if `var' >= 9999997
			sum `var'
	}
	
	* hist val_debt_sl_m_19 if val_debt_sl_m_19 < 999999 & val_debt_sl_m_19 > 0
		** There is a lot of 0/mising idk how usable this will be... but in this case it looks like 0s are actually zeros. 
		sum val_debt_sl*

**************	
// Parent's Total Debt 
	** This is from the family file
	** The first occurence of this question was in 2011, prior to that it was part of "all other debts"
	** I ended up needing to clean a lot of these variables in "renaming_fam_fin.do"
**************
	drop val_all_debt_f val_all_debt_m val_all_debt_ff val_all_debt_fm val_all_debt_mf val_all_debt_mm
	
	sum val_all_debt*
	
*****************		
// home_value
*****************

	sum home_value*
	sum home_value_f*
	sum home_value_m*
		*hist home_value_m_16 if home_value_m_16 != 0 
	** Homes value_f_19 seems to be an ourliar 
	** Home value is much more populated for men than women
	** The max home value is always 9,999,999, Idk why

	
	foreach var of varlist home_value* {
		sum `var'
	    count if `var' == 0
		*count if `var' == .
		*count if `var' == 9999999
		replace `var' = . if `var' >= 9999998
	}
	
	
	** There are a lot more zeros here and a lot more missings. But this might just be because of the sample? 
		* I think i want to look at residency for these kids? 
		* unclear the difference between zero & missing. 
	** There aren't that many 9999999 but I bet it is a coding thing. 
	** So zero home value isn't a problem right if they don't own a home, that is chill. The problem is only if they have a zero home value and their mortgage is > 0 
		** REMINDER: CHECK THIS WHEN YOU ASSIGN THE HOME VALUE.
	

*****************
// Mortgage 
*****************
	
	
	foreach var of varlist mortgage1* mortgage2* {
		sum `var'
	    count if `var' == 0
		count if `var' == .
		count if `var' == 9999999
		replace `var' = . if `var' >= 9999998
	}
	sum mortgage*

	sum mortgage1_m* mortgage2_m*
	sum mortgage1_f* mortgage2_f*
		** Mortgage 2 has a much higher variance because gets coded as zero rather than missing. 
		
	count if mortgage1_m_16 == 0 
	count if mortgage2_m_16 == 0

/*****************	
// home equity
	** NOTE This is calculated. 
	** This is actually a little werid for a couple of reasons, so I'm going to recalculate it after the assignment. 
*****************
	sum home_equity*
	
	foreach var of varlist home_equity* {
			sum `var'
			count if `var' == 0
			count if `var' == .
			count if `var' > 9999990 & `var' != . 
			count if `var' > 999999 & `var' != . 
	}
	stop 

*****************	
//  Savings
*****************/ 
	sum savings* 
		
	foreach var of varlist savings* {
			sum `var'
			count if `var' == 0
			count if `var' == .
			* Sorry Bezos, no trillionairs here 
			replace `var' = . if `var' > 999999990
			replace `var' = 0 if `var' <0 
	}
	sum savings*
	** Seem pretty stable, father have fewer zero savings than mothers. I wonder if family savings just go (by default) into father. 
	** There are a few negative savings, I put them to zero since they won't be materially different from 0 in FAFSA
	*br $keyvarlist income_asignement_combination savings*
	
*****************	
//  Stocks
*****************/ 
	sum val_stocks* 
		
	foreach var of varlist val_stocks* {
			sum `var'
			count if `var' == 0
			count if `var' == .
			replace `var' = . if `var' > 999999990
			replace `var' = 0 if `var' <0 
	}
	sum val_stocks*
	
**********************
// Retirement savings
	* This is a household level variable, so if the mother and father are together than they are equal. 
	* There is "Head IRAs-2014" ER65266 but I'm not sure if that is right in what we are looking for.  
	* For more information see "wealth_variables_supplement.docx"
**********************
	
	sum ira_annuity*
	foreach var of varlist ira_annuity* {
			sum `var'
			count if `var' == 0
			count if `var' == .
			count if `var' != 0 & `var' != .
			replace `var' = . if `var' > 999999990
			
	}
	** A TON of missings and zeros cause a LOT of variation but I guess things more or less make sense. 
	sort famidpns year
	*br $keyvarlist income_asignement_combination ira_annuity*
	sum ira_annuity*

*br $keyvarlist ira* tot_pen*

	
// We don't want pension 	
	sum tot_pension*
	foreach var of varlist ira_annuity* {
			sum `var'
			count if `var' == 0
			count if `var' == .
			count if `var' != 0 & `var' != . 
	}
	** A TON of missings and zeros here like this might not be super usable
	
				
		
	sum total_wealth*
	
	 sum total_wealth_equity_f_18
	*hist total_wealth_equity_f_18 if total_wealth_equity_f_18 != 0
	
	
*******************************************************************************
**# Categorical Variables 
*******************************************************************************/

// Couple Status
	*br famidpn year couple_status* home_val* if famidpn == 2119183 
	/* looking at this with interview is interesting, for example  
		this person's father and mother are completing the survey but have 
		different interview numbers. That implies that they dont live in the same
		house. And sure enough they have different couple status and home value
	 */ 

	 tab couple_status_f_16, m 
	 tab couple_status_m_16, m 
	 tab couple_status_m_16 year , m
	
		// I believe we need to consolidate these some how. I suspect that 
		// some categories weren't always an option or something. 
	
// Race Variables
	tab ethrace
	tab hispanic
	tab black
	tab white
	tab other

	 
// First enroll
	forvalues i=16/22 {
	   tab first_enroll_`i'
	}
	** Kind of as expected most people enroll at 17/19. 
	** Though I'm honeslty kind of shocked how many enrolled at 16 

// enrolled by 
	forvalues i=18/22 {
	   tab enrolled_by_`i', m
	}
	** This makes sense and seems consistent with first enroll. 
	** 68% enrolled by 22 seems a bit low to me. I googled it though and maybe it is reasonable. 
	
	tab ethrace enrolled_by_22 , row
		** kind of interesting 
	

* I wonder if couple status of father is always = to couple status of monther? 
	* Nope they can remarry


// Education of Mother/Father
	** note, 96 - Parent is unkown/never in the study no information
			* 0 - unclear the documentation states "Users may now identify parents who have 0
			*	  education from unknown parents or unknown education."
			*	  since it probably isn't actualy true i'm going to code as missing. 
			
	tab educ_mother , m	
	tab educ_father , m

	replace educ_mother = . if inlist(educ_mother, . , 0, 99, 98, 96)
	replace educ_father = . if inlist(educ_father, . , 0, 99, 98, 96)
	
	sort famidpns year
	*br $keyvarlist educ_mother educ_father 

	// Non-persistant education 
		** Between 2007 & 2009 there are sometimes where the parents's education 2007 != fathers education 2009 
			* this happens in other years but is most common in 2007 - 2009 
		gen has_f_edu= 0 
			replace has_f_edu = 1 if educ_father != . & year == 2007
			replace has_f_edu = 1 if educ_father != . & year == 2009
		bysort famidpns: egen has_f_edu_sum = sum(has_f_edu)
		
		*br $keyvarlist educ_mother educ_father if has_f_edu_sum == 2
		drop has_f_edu_sum has_f_edu
	
	// Persitant education 
		** There isn't always education data available for whatever reason, but I assume it is consitent for the parents
		bysort famidpns: egen max_educ_mother = max(educ_mother)
		bysort famidpns: egen max_educ_father = max(educ_father)
			*br $keyvarlist educ_mother educ_father max_educ*
		drop educ_mother educ_father
		
		rename max_educ_mother educ_mother
		rename max_educ_father educ_father

		
*******************************************************************************
**# Education scores
*******************************************************************************	

*****************	
//  SAT/ACT
*****************/ 

// Quick Cleaning
	replace sat_reading = . if sat_reading >800 
	replace sat_math = . if sat_math >800 
	replace sat_reading = . if sat_reading <200 
	replace sat_math = . if sat_math <200 
	replace act_score = . if act_score > 36 
	replace act_score = . if act_score < 11 

	count if sat_math != . & sat_reading == . 
	count if sat_math == . & sat_reading != . 
	gen sat_reading_round = round(sat_reading,10)
	gen sat_math_round = round(sat_math,10)
	gen sat_score= sat_reading_round + sat_math_round 
	gen act_merge = act_score
		
	
// Phil wants to use the sat equivalent score. See sat_act_convert.do for more details
	merge m:1 act_merge using "$path/psid_cleanup/data/intermediate/act_to_sat_conversion.dta"
		drop if _merge == 2
		drop _merge 
	
	gen sat_equivalent_score = sat_score 
	replace sat_equivalent_score  = sat_merge if sat_equivalent_score  == . 
	
// Some problems
	** Clearly there are some problems here 
		*hist sat_equivalent_score, width(10)
		tab sat_equivalent_score  
		
	* There is some suspicious reporting
		bysort famidpns: egen max_sat_equivalent = max(sat_equivalent_score)
		bysort famidpns: egen min_sat_equivalent = min(sat_equivalent_score)
		count if max_sat_equivalent !=  min_sat_equivalent

		sort famidpns year
		*br if max_sat_equivalent != min_sat_equivalent 
		
// // Wan to make it static over life
	gen temp_sat_at_15_16 = sat_equivalent_score if inlist(age,15,16)
	gen temp_sat_at_17_18 = sat_equivalent_score if inlist(age,17,18)
	gen temp_sat_at_19_20 = sat_equivalent_score if inlist(age,19,20)
	gen temp_sat_at_21_22 = sat_equivalent_score if inlist(age,21,22)
	gen temp_sat_at_23_24 = sat_equivalent_score if inlist(age,23,24)
	gen temp_sat_at_25_26 = sat_equivalent_score if inlist(age,25,26)

	
	bysort famidpns: egen sat_at_15_16 = max(temp_sat_at_15_16)	
	bysort famidpns: egen sat_at_17_18 = max(temp_sat_at_17_18)
	bysort famidpns: egen sat_at_19_20 = max(temp_sat_at_19_20)
	bysort famidpns: egen sat_at_21_22 = max(temp_sat_at_21_22)
	bysort famidpns: egen sat_at_23_24 = max(temp_sat_at_23_24)
	bysort famidpns: egen sat_at_25_26 = max(temp_sat_at_25_26)
	drop temp_sat*

// Take the most "highschool age" appropriate score when there are discrepencies 
	
	gen college_age_sat_equivalent 		   = sat_at_17_18
		replace college_age_sat_equivalent = sat_at_19_20 if college_age_sat_equivalent == . 
		replace college_age_sat_equivalent = sat_at_15_16 if college_age_sat_equivalent == . 
		replace college_age_sat_equivalent = sat_at_21_22 if college_age_sat_equivalent == . 
		replace college_age_sat_equivalent = sat_at_23_24 if college_age_sat_equivalent == . 
		replace college_age_sat_equivalent = sat_at_25_26 if college_age_sat_equivalent == . 
	
	drop sat_reading sat_math act_score sat_reading_round sat_math_round sat_score act_merge sat_merge /// 
	sat_equivalent_score max_sat_equivalent min_sat_equivalent /// 
	sat_at_15_16 sat_at_17_18 sat_at_19_20 sat_at_21_22 sat_at_23_24 sat_at_25_26 
	
	* This looks so much better 
		*hist college_age_sat_equivalent if inlist(age,17,18)
		
		
*****************	
//  High School GPA
*****************/ 

// Take out bad GPAs
	gen hs_gpa_raw = hs_gpa
	
	replace hs_gpa  = . if hs_gpa >= 95
	replace highest_hs_gpa  = . if highest_hs_gpa >= 98
	
	** NOT sure what we want to do about GPA actually now that I think about it? 
		* Honestly 96.67 % of gpas are <= 4.0 and 99. 19 are <= 5.0 
	tab hs_gpa
	
	replace hs_gpa = . if hs_gpa == 0 
	replace hs_gpa = . if hs_gpa == 8 | hs_gpa == 9
		
// 4.0 scale
	gen hs_gpa_4pointO = (hs_gpa/highest_hs_gpa)*4
	tab hs_gpa, m
	tab hs_gpa_4pointO , m

// Wan to make it static over life
	gen temp_gpa_at_15_16 = hs_gpa_4pointO if inlist(age,15,16)
	gen temp_gpa_at_17_18 = hs_gpa_4pointO if inlist(age,17,18)
	gen temp_gpa_at_19_20 = hs_gpa_4pointO if inlist(age,19,20)
	gen temp_gpa_at_21_22 = hs_gpa_4pointO if inlist(age,21,22)
	gen temp_gpa_at_23_24 = hs_gpa_4pointO if inlist(age,23,24)
	gen temp_gpa_at_25_26 = hs_gpa_4pointO if inlist(age,25,26)

	
	bysort famidpns: egen gpa_at_15_16 = max(temp_gpa_at_15_16)	
	bysort famidpns: egen gpa_at_17_18 = max(temp_gpa_at_17_18)
	bysort famidpns: egen gpa_at_19_20 = max(temp_gpa_at_19_20)
	bysort famidpns: egen gpa_at_21_22 = max(temp_gpa_at_21_22)
	bysort famidpns: egen gpa_at_23_24 = max(temp_gpa_at_23_24)
	bysort famidpns: egen gpa_at_25_26 = max(temp_gpa_at_25_26)
	
// Take the most "highschool age" appropriate score when there are discrepencies 
	gen hs_gpa_allyears 		= gpa_at_17_18
		replace hs_gpa_allyears = gpa_at_19_20 if hs_gpa_allyears == . 
		replace hs_gpa_allyears = gpa_at_15_16 if hs_gpa_allyears == . 
		replace hs_gpa_allyears = gpa_at_21_22 if hs_gpa_allyears == . 
		replace hs_gpa_allyears = gpa_at_23_24 if hs_gpa_allyears == . 
		replace hs_gpa_allyears = gpa_at_25_26 if hs_gpa_allyears == . 
	
	drop temp_gpa* gpa_at*
	tab hs_gpa_allyears , m
	*br $keyvarlist hs_gpa highest_hs_gpa hs_gpa_4pointO  hs_gpa_allyears
	
*****************	
//  College GPA
*****************/ 

// take out the bad GPAs, 
	gen col_gpa = gpa_most_rec_college
		replace col_gpa = . if col_gpa == 0 
		replace col_gpa = . if col_gpa > 90
		replace col_gpa = . if col_gpa == 8 | col_gpa == 9
		
// 4.0 scale		
		gen col_gpa_4pointO = (col_gpa/high_gpa_most_rec_college)*4
		tab col_gpa, m
		tab col_gpa_4pointO , m
	
// Wan to make it static over life	
	gen temp_gpa_at_15_16 = col_gpa_4pointO if inlist(age,15,16)
	gen temp_gpa_at_17_18 = col_gpa_4pointO if inlist(age,17,18)
	gen temp_gpa_at_19_20 = col_gpa_4pointO if inlist(age,19,20)
	gen temp_gpa_at_21_22 = col_gpa_4pointO if inlist(age,21,22)
	gen temp_gpa_at_23_24 = col_gpa_4pointO if inlist(age,23,24)
	gen temp_gpa_at_25_26 = col_gpa_4pointO if inlist(age,25,26)

	
	bysort famidpns: egen gpa_at_15_16 = max(temp_gpa_at_15_16)	
	bysort famidpns: egen gpa_at_17_18 = max(temp_gpa_at_17_18)
	bysort famidpns: egen gpa_at_19_20 = max(temp_gpa_at_19_20)
	bysort famidpns: egen gpa_at_21_22 = max(temp_gpa_at_21_22)
	bysort famidpns: egen gpa_at_23_24 = max(temp_gpa_at_23_24)
	bysort famidpns: egen gpa_at_25_26 = max(temp_gpa_at_25_26)
	
// Take the most "colleg age" appropriate score when there are discrepencies 
	
	gen col_gpa_allyears 		 = gpa_at_25_26
		replace col_gpa_allyears = gpa_at_23_24 if col_gpa_allyears == . 
		replace col_gpa_allyears = gpa_at_21_22 if col_gpa_allyears == . 
		replace col_gpa_allyears = gpa_at_19_20 if col_gpa_allyears == . 
		replace col_gpa_allyears = gpa_at_17_18 if col_gpa_allyears == . 
		replace col_gpa_allyears = gpa_at_15_16 if col_gpa_allyears == . 
	
	drop temp_gpa* gpa_at*
	tab col_gpa_allyears

	*br $keyvarlist col_gpa gpa_most_rec_college high_gpa_most_rec_college  col_gpa_allyears 

	

*****************	
//  Graduate HS 
*****************/ 
// Want an "ever_grad_hs"
	bysort famidpns: egen ever_grad_hs = max(grad_hs)
	sort famidpns year

	*br $keyvarlist grad_hs ever_grad_hs year_grad_hs

// No I think we actually want Graduated BY age so:
	gen ians_hs_grad_year = year if grad_hs == 1
	bysort famidpns: egen min_ians_hs_grad_year = min(ians_hs_grad_year)
	
	gen clean_psid_hs_grad_year = year_grad_hs
		replace clean_psid_hs_grad_year  = . if year_grad_hs == 0 
		
	bysort famidpns: egen min_clean_psid_hs_grad_year = min(clean_psid_hs_grad_year)
	
	gen psid_grad_age = min_clean_psid_hs_grad_year -birth_year
		tab psid_grad_age min_clean_psid_hs_grad_year if inlist(age,17,18)
	
	gen ians_grad_age = min_ians_hs_grad_year - birth_year
	count if ians_grad_age != . & psid_grad_age == .

	
	tab psid_grad_age if inlist(age,17,18) , m 
	tab ians_grad_age if inlist(age,17,18) , m
	
	replace psid_grad_age = ians_grad_age if psid_grad_age == . 
	
	gen grad_hs_by_19 = 0
		replace grad_hs_by_19 =1 if psid_grad_age != . & psid_grad_age <= 19


	drop ians_grad_age clean_psid_hs_grad_year ians_hs_grad_year min_ians_hs_grad_year 
	
*****************	
//  Graduate College 
*****************/ 
	/*
	order $keyvarlist famidpn_f famidpn_m ///
		yr_attend_earlier_college yr_enroll_earlier_college ///
		yr_attend_most_rec_college yr_enroll_most_rec_college /// 
		current_attend_college year_finished_college completed_college ///
		grad_college in_college
	
	br $keyvarlist famidpn_f famidpn_m ///
			yr_attend_earlier_college yr_enroll_earlier_college ///
			yr_attend_most_rec_college yr_enroll_most_rec_college /// 
			current_attend_college year_finished_college completed_college ///
			grad_college in_college completed_college_at_24 completed_college_at_23 
						
	*/ 
		
	gen grad_col_age = year_finished_college - birth_year
	
	gen grad_college_by_24 = 0 
		replace grad_college_by_24 = 1  if grad_col_age != . & grad_col_age <= 24 
		replace grad_college_by_24 =. if year_finished_college == . 
	*QUESTION: Should this be missing if they never went to college? 
	
	*QUESTION: Should two year colleges be different. 
	
	tab year_finished_college
	tab grad_college_by_24 , m
	
// Years attended college by
	*br $keyvarlist first_enr*
	gen age_first_enrolled = .
		replace age_first_enrolled = 16 if first_enroll_16 == 1
		replace age_first_enrolled = 17 if first_enroll_17 == 1
		replace age_first_enrolled = 18 if first_enroll_18 == 1
		replace age_first_enrolled = 19 if first_enroll_19 == 1
		replace age_first_enrolled = 20 if first_enroll_20 == 1
		replace age_first_enrolled = 21 if first_enroll_21 == 1
		replace age_first_enrolled = 22 if first_enroll_22 == 1

		tab age_first_enrolled ever_attend_college , m
	
	*br if age_first_enrolled != 0 & ever_attend_college == 0 
	

*****************	
//  Attending College
*****************/ 	


// Only want college degrees
	tab degree_most_rec_college , m 
	** honestly this is basically useless but I'll still use it for identifying graduate degrees where possible. 
	
	replace yr_enroll_most_rec_college = . if degree_most_rec_college >2 & degree_most_rec_college < 95 
	replace yr_attend_most_rec_college = . if degree_most_rec_college >2 & degree_most_rec_college < 95 
	
	replace yr_enroll_earlier_college = . if degree_earlier_college >2 & degree_earlier_college < 95 
	replace yr_attend_earlier_college = . if degree_earlier_college >2 & degree_earlier_college < 95 


// Kick of the bad values
	replace yr_enroll_earlier_college =. if yr_enroll_earlier_college < 1970 | yr_enroll_earlier_college > 2050
	replace yr_attend_earlier_college =. if yr_attend_earlier_college < 1970 | yr_attend_earlier_college > 2050

	replace yr_enroll_most_rec_college =. if yr_enroll_most_rec_college < 1970 | yr_enroll_most_rec_college > 2050
	replace yr_attend_most_rec_college =. if yr_attend_most_rec_college < 1970 | yr_attend_most_rec_college > 2050

// Get consitency in which college is which 
	bysort famidpns: egen min_enroll_earlier = min(yr_enroll_earlier_college) 
	bysort famidpns: egen min_attend_earlier = min(yr_attend_earlier_college) 
	bysort famidpns: egen min_enroll_mr = min(yr_enroll_most_rec_college) 
	bysort famidpns: egen min_attend_mr = min(yr_attend_most_rec_college) 

	bysort famidpns: egen max_enroll_earlier = max(yr_enroll_earlier_college) 
	bysort famidpns: egen max_attend_earlier = max(yr_attend_earlier_college) 
	bysort famidpns: egen max_enroll_mr = max(yr_enroll_most_rec_college) 
	bysort famidpns: egen max_attend_mr = max(yr_attend_most_rec_college) 

	egen yr_enroll_first_college = rowmin(min_enroll_earlier min_enroll_mr)
	egen yr_enroll_second_college = rowmax(max_enroll_earlier max_enroll_mr)
	
	egen yr_attend_first_college  = rowmin(min_attend_earlier min_attend_mr)
	egen yr_attend_second_college = rowmax(max_attend_earlier max_attend_mr)

// Clean up a bit 
	drop min_enroll_earlier min_attend_earlier min_enroll_mr min_attend_mr ///
	max_enroll_earlier max_attend_earlier max_enroll_mr max_attend_mr 
	*yr_enroll_earlier_college yr_attend_earlier_college 
	*yr_enroll_most_rec_college yr_attend_most_rec_college

	/* GOAL: Simplify to one enroll and attend - honestly not worth it. 
		gen year_enrolled_in_college = . 
		gen year_last_attend_college = . 
		
		  // if there is only one college 
			replace year_enrolled_in_college  = yr_enroll_first_college if (yr_enroll_first_college == yr_enroll_second_college) & (yr_attend_first_college == yr_attend_second_college)
			replace year_last_attend_college  = yr_attend_first_college if (yr_enroll_first_college == yr_enroll_second_college) & (yr_attend_first_college == yr_attend_second_college)
	*/ 		


	// years in college +1 because 2009-2009 is kind of one year 
	gen years_in_first_college = (yr_attend_first_college - yr_enroll_first_college) + 1
	gen years_in_second_college = (yr_attend_second_college - yr_enroll_second_college) + 1


// Redo the attend college 
	sort famidpns year
	cap drop current_attend_college 

	gen current_attend_college = 0 
		replace current_attend_college  = 1 if year >= yr_enroll_first_college & year <= yr_attend_first_college 
		replace current_attend_college  = 1 if year >= yr_enroll_second_college & year <= yr_attend_second_college 
		replace current_attend_college  = . if yr_enroll_second_college == . & yr_enroll_second_college ==.
		
	gen attend_college_next_wave = 0
		replace attend_college_next_wave  = 1 if year+2 >= yr_enroll_first_college & year+2 <= yr_attend_first_college 
		replace attend_college_next_wave  = 1 if year+2 >= yr_enroll_second_college & year+2 <= yr_attend_second_college
		replace attend_college_next_wave  = . if yr_enroll_second_college == . & yr_enroll_second_college ==.
		replace attend_college_next_wave  = . if year+2 >= 2019
		

	*gen enrolled_oneyear_ormore_college = 0 
	*	replace enrolled_oneyear_ormore_college = 1 if years_in_first_college >= 1
	*	replace enrolled_oneyear_ormore_college = 1 if years_in_second_college >= 1
	*	replace enrolled_oneyear_ormore_college = . if years_in_first_college ==.

		
	gen enrolled_oneyear_ormore_college = 0
		// same school - first school  
		replace enrolled_oneyear_ormore_college = 1 if (yr_enroll_first_college + 1) <= yr_attend_first_college 
		
		// first school didn't work out
		*replace enrolled_oneyear_later = 1 if (yr_enroll_second_college + 1) < yr_attend_second_college 
		
		replace enrolled_oneyear_ormore_college = . if yr_enroll_first_college == . & yr_enroll_second_college ==. 
		replace enrolled_oneyear_ormore_college = . if enrolled_by_19 == 0
	

/* Here is what Phil Described for persistence 
if you enrolled in X for the first time 
and enrolled in X+1

started by age 19 
look at the year they started 
were they enrolled a year later. 
were you enrolled in the following year. 	

are you enrolled in anything in this wave and then the next wave
 


gen enrolled_oneyear_ormore_college= 0
	// same school - first school  
	replace enrolled_oneyear_ormore_college = 1 if (yr_enroll_first_college + 1) < yr_attend_first_college 
	

	// first school didn't work out
	replace enrolled_oneyear_ormore_college = 1 if (yr_enroll_second_college + 1) < yr_attend_second_college 
	
	replace enrolled_oneyear_ormore_college = . if yr_enroll_first_college == . & yr_enroll_second_college ==. 
	

gen enrolled_this_and_next_wave = 0 
	replace enrolled_this_and_next_wave = 1 if current_attend_college == 1 & attend_college_next_wave ==1
	
*** We talked about this 10/29 and we want to see if they have more than 1 year of college. (see above) 
*/

// Graduate 2yr or 4yr degree 
	tab enrollment_status

	gen grad_2yr_degree = 0
		replace grad_2yr_degree = . if yr_enroll_first_college == . 
		replace grad_2yr_degree  = 1 if enrollment_status == 5
		replace grad_2yr_degree = 1 if grad_college == 1	
		
	bysort famidpns: egen max_grad_2yr_degree = max(grad_2yr_degree)
		

	gen grad_4yr_degree = 0
		replace grad_4yr_degree = . if yr_enroll_first_college == . 
		replace grad_4yr_degree = 1 if grad_college == 2
		replace grad_4yr_degree  = 1 if enrollment_status == 6
		** I'm going to assume that if they have a graduate degree they have a college 4 year degree
		replace grad_4yr_degree  = 1 if inlist(enrollment_status, 6, 7, 11)
		
	bysort famidpns: egen max_grad_4yr_degree = max(grad_4yr_degree)

	gen max_grad_2yr_or_4yr_degree =0 
		replace max_grad_2yr_or_4yr_degree = 1 if max_grad_2yr_degree == 1
		replace max_grad_2yr_or_4yr_degree = 1 if max_grad_4yr_degree == 1
		
	** Look into did they graduate and consitency with enrollment 
		tab max_grad_2yr_or_4yr_degree enrolled_oneyear_ormore_college , m 
		** looks pretty good, 210 people with graduate but no enrollment is not great. but very small. 
		
	
// Never Enrolled in College? 
	gen never_enrolled_college = 0 
		replace never_enrolled_college = 1 if yr_enroll_first_college == . 
	tab degree_earlier_college if never_enrolled_college  == 1, m 
	tab degree_most_rec_college if never_enrolled_college  == 1, m 
	tab ever_attend_college if never_enrolled_college  == 1
	tab grad_college if never_enrolled_college  == 1
		** There are some weird people but mostly seems okay


	
// Last year observed 
	gen survey_year = year if int_num != . 
	bysort famidpns: egen last_year_surveyed = max(survey_year)

	gen enrollment_status_last_year = enrollment_status if year == last_year_surveyed
	bysort famidpns: egen max_enrollment_status_last_year  = max(enrollment_status_last_year)

	
						
/*******************************************************************************
**# Family Interview Number Analysis 
	* This section isn't needed but I'm keeping it here for the record. 
*******************************************************************************
// Understanding int num
	count if int_num == . 
		gen int_num_eq = ""
			replace int_num_eq = "f" if int_num == int_num_f
			replace int_num_eq = "m" if int_num == int_num_m
			replace int_num_eq = "fm" if int_num == int_num_m & int_num == int_num_f 
			replace int_num_eq = "neither" if int_num != int_num_m  & int_num != int_num_f & int_num != . 
			tab int_num_eq , m

		gen int_num_f_eq_m = ""
			replace int_num_f_eq_m = "f=m" if int_num_f == int_num_m 
			replace int_num_f_eq_m = "f=., m!=. " if int_num_f == . & int_num_m !=. 
			replace int_num_f_eq_m = "f!=., m=. " if int_num_f != . & int_num_m ==. 
			tab int_num_f_eq_m , m
			
		tab int_num_eq  int_num_f_eq_m , m 

// For our relavent age group 
	count if inlist(age,17,18)	
	count if int_num != . & inlist(age,17,18)				

	count if inlist(age,17,18,19)	
	count if int_num != . & inlist(age,17,18,19)				
		

// When are they the same as the parent 
	cap drop ind_int_num_status
	gen ind_int_num_status = "base"
		replace ind_int_num_status = "Same as M & F" if ind_int_num  == int_num_f & ind_int_num == int_num_m
		replace ind_int_num_status = "Same as Only M" if ind_int_num  != int_num_f & ind_int_num == int_num_m
		replace ind_int_num_status = "Same as Only F" if ind_int_num  == int_num_f & ind_int_num != int_num_m
		replace ind_int_num_status = "Different" if ind_int_num  != int_num_f & ind_int_num != int_num_m
		replace ind_int_num_status = "none" if ind_int_num == 0
		replace ind_int_num_status = "Grandparent" if ind_int_num_status == "Different" ///
			& (ind_int_num == int_num_ff | ind_int_num == int_num_fm |ind_int_num == int_num_mm | ind_int_num == int_num_mf)
		
	tab ind_int_num_status, m 
	tab ind_int_num_status if age >= 15 & age <= 16, m
	tab ind_int_num_status if age >= 17 & age <= 18, m

	count if ind_int_num_status == "Different" & age <=16
	
// For younger people when are they different
	bysort year: gen year_count = _n if ind_int_num_status == "Different" & age <=16
	sort famidpn year
	*br if ind_int_num_status == "Different" & age <=16

// Who are these different folks 	
	cap drop ever_different 
	cap drop currently_different
		gen currently_different = 0
			replace currently_different = 1 if ind_int_num_status == "Different" & age <= 16
			bysort famidpns: egen ever_different = max(currently_different )

	*order famidpn famidpns year birth_year age int_num int_num_f int_num_m ind_int_num ind_int_num_status currently_different ever_different
	*br if ever_different == 1

// For the zero people
	gen mf_int_num_status = "base"
		replace mf_int_num_status = "Different" if int_num_f != int_num_m
		replace mf_int_num_status = "Same" if int_num_f == int_num_m
		replace mf_int_num_status = "One 0/." if (int_num_f == 0 | int_num_f == .)  | (int_num_m == 0 | int_num_m == . )
		replace mf_int_num_status = "Both 0/." if (int_num_f == 0 | int_num_f == .)  & (int_num_m == 0 | int_num_m == . )
	
	*tab ind_int_num_status mf_int_num_status  if age >= 15 & age <= 16, row col

	drop mf_int_num_status currently_different ever_different

	
*******************************************************************************
**# Question: Who does the child live with 
	* There is more documentation on this in "family_inome_investigation.docx"
*******************************************************************************/
	*br if famidpn == 2119183 
	/* Right off the bat, it is clear that at age 27 this person moves out and 
		lives on their own. That is the only year they filled out the TAS. 
		
		not necessarily, interview number is literally just when the information was collected, 
		it is feasible that kids come back home for a day to complete the interview as a family
		
		The int_num is blank mean that the person didn't fill out the TAS interview, 
		if int_num is the same as _m or _f then the TAS was conducted in the same session as the 
		main interview. 
		
		NOPE there is a family interview number that applies to the whole family. I was just pulling ONLY the tas for the individuals before
		I've changed it so that we get the family interview number for everyone. 
		
		I'm going to need more information on how this FAFSA picks a parent. 
	*/ 

// Classify different TAS interview number combinations 
	gen int_combinations = ""
		replace int_combinations = "All Missing" if int_num == . & int_num_f == . & int_num_m == . 
		replace int_combinations = "Only F non-missing" if int_num == . & int_num_f != . & int_num_m == . 
		replace int_combinations = "Only M non-missing" if int_num == . & int_num_f == . & int_num_m != . 
		replace int_combinations = "F&M Equal I missing" if int_num == . & int_num_f != . & int_num_m != . & int_num_f == int_num_m
		replace int_combinations = "All Equal" if int_num != . & int_num_f != . & int_num_m != . & int_num == int_num_f & int_num_f == int_num_m
		replace int_combinations = "F!=M, I missing" if int_num == . & int_num_f != . & int_num_m != . & int_num_m != int_num_f 
		replace int_combinations = "F=M!=I" if int_num != . & int_num_f != . & int_num_m != . & int_num == int_num_f & int_num_f != int_num
		replace int_combinations = "All Different" if int_num != . & int_num_f != . & int_num_m != . & int_num != int_num_f & int_num_f != int_num & int_num_m != int_num
		replace int_combinations = "F=I, M missing" if int_num != . & int_num_f != . & int_num_m == . & int_num == int_num_f 
		replace int_combinations = "M=I, F missing" if int_num != . & int_num_f == . & int_num_m != . & int_num == int_num_m
		
		tab int_combinations , m		
		
	gen zero_int_num = "0"
		replace zero_int_num = "F only" if int_num != 0 & int_num_f == 0 & int_num_m != 0
		replace zero_int_num = "M only" if int_num != 0 & int_num_f != 0 & int_num_m == 0
		replace zero_int_num = "I only" if int_num == 0 & int_num_f != 0 & int_num_m != 0
		replace zero_int_num = "F&M only" if int_num != 0 & int_num_f == 0 & int_num_m == 0
		replace zero_int_num = "F&I only" if int_num == 0 & int_num_f == 0 & int_num_m != 0
		replace zero_int_num = "M&I only" if int_num == 0 & int_num_f != 0 & int_num_m == 0
		replace zero_int_num = "F&M&I" if int_num == 0 & int_num_f == 0 & int_num_m == 0
		replace zero_int_num = "None" if int_num != 0 & int_num_f != 0 & int_num_m != 0
	
	tab zero_int_num 
		
		tab int_combinations zero_int_num , m

		
// Classify Interview numbers based on Individual Inteview Numbers
	* NOTE I'm going to set a zero int_num to missing since it is the same for our purposes. Probably not best practice but sue me I guesss. 
		replace ind_int_num = . if ind_int_num == 0
		replace int_num_m = . if int_num_m == 0
		replace int_num_f = . if int_num_f == 0
		
	cap drop ind_int_combinations
	gen ind_int_combinations = "Should be zero"
		replace ind_int_combinations = "All Missing" 			if ind_int_num == . & int_num_f == . & int_num_m == . 
		replace ind_int_combinations = "Only F non-missing" 	if ind_int_num == . & int_num_f != . & int_num_m == . 
		replace ind_int_combinations = "Only M non-missing" 	if ind_int_num == . & int_num_f == . & int_num_m != . 
		replace ind_int_combinations = "Only I non-missing" 	if ind_int_num != . & int_num_f == . & int_num_m == . 
		replace ind_int_combinations = "F&M Equal I missing" 	if ind_int_num == . & int_num_f != . & int_num_m != . & int_num_f == int_num_m
		replace ind_int_combinations = "All Equal" 				if ind_int_num != . & int_num_f != . & int_num_m != . & int_num_f == int_num_m & int_num_f == ind_int_num  
		replace ind_int_combinations = "F!=M, I missing" 		if ind_int_num == . & int_num_f != . & int_num_m != . & int_num_f != int_num_m 
		replace ind_int_combinations = "F=M!=I" 				if ind_int_num != . & int_num_f != . & int_num_m != . & int_num_f == int_num_m & int_num_f != ind_int_num
		replace ind_int_combinations = "All Different" 			if ind_int_num != . & int_num_f != . & int_num_m != . & int_num_f != int_num_m & int_num_f != ind_int_num  & int_num_m != ind_int_num
		replace ind_int_combinations = "F=I, M missing" 		if ind_int_num != . & int_num_f != . & int_num_m == . & int_num_f == ind_int_num 
		replace ind_int_combinations = "M=I, F missing" 		if ind_int_num != . & int_num_f == . & int_num_m != . & int_num_m == ind_int_num
		replace ind_int_combinations = "M!=I, F missing" 		if ind_int_num != . & int_num_f == . & int_num_m != . & int_num_m != ind_int_num
		replace ind_int_combinations = "F!=I, M missing" 		if ind_int_num != . & int_num_f != . & int_num_m == . & int_num_f != ind_int_num 
		replace ind_int_combinations = "M=I!=F" 				if ind_int_num != . & int_num_f != . & int_num_m != . & int_num_m == ind_int_num & int_num_f != ind_int_num 
		replace ind_int_combinations = "F=I!=M" 				if ind_int_num != . & int_num_f != . & int_num_m != . & int_num_f == ind_int_num & int_num_m != ind_int_num 

		replace ind_int_combinations = "Grandparent" if ///
			(ind_int_num != int_num_f & ind_int_num != int_num_m & ind_int_num != .) &  ///
			(ind_int_num == int_num_ff | ind_int_num == int_num_fm | ind_int_num == int_num_mm | ind_int_num == int_num_mf)		

			
			count if ind_int_combinations == "Should be zero" // Should be zero 
			*br if ind_int_combinations == "Should be zero"

		tab ind_int_combinations if inlist(age,15,16), m
		tab ind_int_combinations if inlist(age,17,18), m
		tab ind_int_combinations ethrace if inlist(age,15,16), m row col
		tab ind_int_combinations ethrace if inlist(age,17,18), m row col
	
// We want to use 17/18 ind_income_combinations where possible and 15/16 where not possible
	** NOTE: I call it income_asignement_combination but we use it for assigning all wealth variables. 
		gen ind_int_combinations_15_16 = ind_int_combinations if inlist(age, 15,16)
			gsort famidpns -ind_int_combinations_15_16
			bysort famidpns: replace ind_int_combinations_15_16 = ind_int_combinations_15_16[_n-1] if ind_int_combinations_15_16 == ""
			
		gen ind_int_combinations_17_18 = ind_int_combinations if inlist(age, 17,18)
			gsort famidpns -ind_int_combinations_17_18
			bysort famidpns: replace ind_int_combinations_17_18 = ind_int_combinations_17_18[_n-1] if ind_int_combinations_17_18 == ""	
	
		tab ind_int_combinations_17_18 ind_int_combinations_15_16 // included in excel file
		
		gen income_asignement_combination = ind_int_combinations_17_18
			replace income_asignement_combination = ind_int_combinations_15_16 if ///
				inlist(ind_int_combinations_17_18, "All Different", "All Missing", "F!=I, M missing", "M!=I, F missing", "Grandparent", "Only I non-missing")
				
		gen had_to_use_15_16 = 0 
			replace had_to_use_15_16  = 1 if ///
				inlist(ind_int_combinations_17_18, "All Different", "All Missing", "F!=I, M missing", "M!=I, F missing", "Grandparent", "Only I non-missing")
		
		tab income_asignement_combination if inlist(age, 17, 18) , m
			// there will be missings if the person is NEVER 15/16 but we drop these people anyway. 
						
		sort famidpns year
		*br famidpns year age int_num int_num_f int_num_m ind_int_num ind_int_num_status ind_int_combinations ind_int_combinations_15_16 ind_int_combinations_17_18
	
	

// The observations we can't really work with 
	drop if inlist(income_asignement_combination, "", "All Different", "All Missing", "F!=I, M missing", ///
							"Grandparent", "M!=I, F missing", "Only I non-missing")
	tab income_asignement_combination if inlist(age, 17, 18) , m
			
	drop couple_status_f couple_status_m couple_status_ff couple_status_fm couple_status_mf couple_status_mm

*******************************************************************************
**# Wealth Assignment 
*******************************************************************************

// This program assigns the wealth variables to the children at their college age based on thir parental gaurdianship. 
	cap program drop assign_college_age 
	program assign_college_age 
			
		// Step 1: get the 15/16 and 17/18 groupings for both parents individually 
			gen temp_`1'_f_15_16 = `1'_f_15
				replace temp_`1'_f_15_16 = `1'_f_16 if `1'_f_15 == . 
				
			gen temp_`1'_m_15_16 = `1'_m_15
				replace temp_`1'_m_15_16 = `1'_m_16 if `1'_m_15 == . 	
				
			gen temp_`1'_f_17_18 = `1'_f_17
				replace temp_`1'_f_17_18 = `1'_f_18 if `1'_f_17 == . 
				
			gen temp_`1'_m_17_18 = `1'_m_17
				replace temp_`1'_m_17_18 = `1'_m_18 if `1'_m_17 == . 	
					
		// Step 2: Assign the correct parent for both age groups
			** Note if F=M then the wealth variable will be the same for F & M so we don't need to add them. 
			gen `1'_at_15_16 = . 
				replace `1'_at_15_16 = temp_`1'_f_15_16 if inlist(income_asignement_combination, "Only F non-missing", "F=I, M missing", "F=I!=M")
				replace `1'_at_15_16 = temp_`1'_m_15_16 if inlist(income_asignement_combination, "Only M non-missing", "M=I, F missing", "M=I!=F")
				replace `1'_at_15_16 = temp_`1'_m_15_16 if inlist(income_asignement_combination, "All Equal", "F=M!=I")
			
			gen `1'_at_17_18 = . 
				replace `1'_at_17_18 = temp_`1'_f_17_18 if inlist(income_asignement_combination, "Only F non-missing", "F=I, M missing", "F=I!=M")
				replace `1'_at_17_18 = temp_`1'_m_17_18 if inlist(income_asignement_combination, "Only M non-missing", "M=I, F missing", "M=I!=F")
				replace `1'_at_17_18 = temp_`1'_m_17_18 if inlist(income_asignement_combination, "All Equal", "F=M!=I")
				
		// Step 3: Assign the correct age group 
			// I want o assign income to 17 18 where possible but 15 16 where I had to	
			gen `1'_at_15_18 = 	`1'_at_17_18
				replace `1'_at_15_18 = `1'_at_15_16 if had_to_use_15_16 == 1
			
		// Check and drop 
			cap sum `1'_at_15_18	
			
			drop temp_`1'_f_15_16 temp_`1'_m_15_16 temp_`1'_f_17_18  temp_`1'_m_17_18 
				 * `1'_at_15_16 `1'_at_17_18
			
			lab var `1'_at_15_18 "Gaurdian's `1' at individual college age"	
	end 

// Run the program
	assign_college_age tot_fam_income 
	assign_college_age val_debt_sl 
	assign_college_age home_value
	assign_college_age mortgage1
	assign_college_age mortgage2
	assign_college_age ira_annuity
	assign_college_age savings
	assign_college_age val_stocks
	assign_college_age val_all_debt
	assign_college_age couple_status
	assign_college_age total_wealth_equity
	assign_college_age num_kids_in_college
	assign_college_age home_equity

**** Outliars 
	replace val_debt_sl_at_15_18 = . if val_debt_sl_at_15_18 > 500000
	
	
// Extensions
*gen home_equity_at_15_18 = home_value_at_15_18 - mortgage1_at_15_18 - mortgage2_at_15_18
*	lab var home_equity_at_15_18 "Gaurdian's home_equity at individual college age"	
	

cap lab define couple_status 1 "Head with wife present in FU" 2 "Head with 'wife' present in FU" 3 "Head (female) with husband present in FU" 4 "Head with first year cohabitator present in FU" 5 "Head with no wife/'wife'/cohabitator present"


lab value couple_status_at_15_18 couple_status
	lab var couple_status_at_15_18 "Gaurdian's couple_status at individual college age"	


/// Post college age 

// This program assigns the wealth variables to the children at their college age based on thir parental gaurdianship. 
	cap program drop assign_post_college_age 
	program assign_post_college_age 
			
		// Step 1: get the 15/16 and 17/18 groupings for both parents individually 
			gen temp_`1'_f_23_24 = `1'_f_23
				replace temp_`1'_f_23_24 = `1'_f_24 if `1'_f_23 == . 
				
			gen temp_`1'_m_23_24 = `1'_m_23
				replace temp_`1'_m_23_24 = `1'_m_24 if `1'_m_23 == . 	
				
			gen temp_`1'_f_25_26 = `1'_f_25
				replace temp_`1'_f_25_26 = `1'_f_26 if `1'_f_25 == . 
				
			gen temp_`1'_m_25_26 = `1'_m_25
				replace temp_`1'_m_25_26 = `1'_m_26 if `1'_m_25 == . 	
					
		// Step 2: Assign the correct parent for both age groups
			** Note if F=M then the wealth variable will be the same for F & M so we don't need to add them. 
			gen `1'_at_23_24 = . 
				replace `1'_at_23_24 = temp_`1'_f_23_24 if inlist(income_asignement_combination, "Only F non-missing", "F=I, M missing", "F=I!=M")
				replace `1'_at_23_24 = temp_`1'_m_23_24 if inlist(income_asignement_combination, "Only M non-missing", "M=I, F missing", "M=I!=F")
				replace `1'_at_23_24 = temp_`1'_m_23_24 if inlist(income_asignement_combination, "All Equal", "F=M!=I")
			
			gen `1'_at_25_26 = . 
				replace `1'_at_25_26 = temp_`1'_f_25_26 if inlist(income_asignement_combination, "Only F non-missing", "F=I, M missing", "F=I!=M")
				replace `1'_at_25_26 = temp_`1'_m_25_26 if inlist(income_asignement_combination, "Only M non-missing", "M=I, F missing", "M=I!=F")
				replace `1'_at_25_26 = temp_`1'_m_25_26 if inlist(income_asignement_combination, "All Equal", "F=M!=I")
				
		// Step 3: Assign the correct age group 
			// I want o assign income to 17 18 where possible but 15 16 where I had to	
			gen `1'_at_23_26 = 	`1'_at_25_26
				replace `1'_at_23_26 = `1'_at_23_24 if `1'_at_25_26 == . 
			
		// Check and drop 
			cap sum `1'_at_23_26	
			
			drop temp_`1'_f_23_24 temp_`1'_m_23_24 temp_`1'_f_25_26  temp_`1'_m_25_26 
				 * `1'_at_15_16 `1'_at_17_18
			
			lab var `1'_at_23_26 "Gaurdian's `1' at individual post college age"	
	end 
				
				
	assign_post_college_age val_debt_sl 
	assign_post_college_age val_all_debt
	assign_post_college_age num_kids_in_college

	

*******************************************************************************
**# AGE DROP
*******************************************************************************/			

// Everything below here will be for the 17/18 year olds. 
if $keep_ages == 1 {
	keep if inlist(age, 17, 18)
}

*br $keyvarlist val_debt_sl*


*******************************************************************************
**# Income Investigation 
*******************************************************************************/			

	
		*hist fam_income_at_15_18 if fam_income_at_15_18  != 0 & fam_income_at_15_18  <= 500000, width(10000)
			count if tot_fam_income_at_15_18 == 0
			count if tot_fam_income_at_15_18 > 500000
		*br $keyvarlist fam_income* tot_fam_income* if fam_income_at_15_18 >0 & fam_income_at_15_18  <= 10000

		
	// Income Categories 
		gen fam_inc_cat= "none"
			replace fam_inc_cat = "<75000"  if tot_fam_income_at_15_18 < 75000
			replace fam_inc_cat = "75000-"  if tot_fam_income_at_15_18 >= 75000 & tot_fam_income_at_15_18 < 125000
			replace fam_inc_cat = "125000"  if tot_fam_income_at_15_18 >= 125000 
			replace fam_inc_cat = "Zero"    if tot_fam_income_at_15_18 ==0 
			replace fam_inc_cat = "Missing" if tot_fam_income_at_15_18 == . 
			
	
	// Distributions by category
		tab ethrace fam_inc_cat , row col 
			** So it is a little hard to directly compare since Phil didn't take out zeros? or did he? 
				** Whites are richer in the SCF (50% have highest compared to 33%)
				** blacks are slightly poorer in our sample (10% have highest compated to 5%)
				** hispanics are about the same, slightly richer in out sample. 
				** In gneral our sample seems to be very slightly richer with the excpetion of whites. 
			** QUESTION: do we want to drop other race. 
			
		tab enrolled_by_22 fam_inc_cat  , row col
			** this makes a lot of sense actually but "none" seems biased. 

	// Dubravka Question: Look at income changes year to year
		gen f15_17_income_diff = tot_fam_income_f_17 - tot_fam_income_f_15
		gen f16_18_income_diff = tot_fam_income_f_18 - tot_fam_income_f_16
		gen f17_19_income_diff = tot_fam_income_f_19 - tot_fam_income_f_17
		gen m15_17_income_diff = tot_fam_income_m_17 - tot_fam_income_m_15
		gen m16_18_income_diff = tot_fam_income_m_18 - tot_fam_income_m_16
		gen m17_19_income_diff = tot_fam_income_m_19 - tot_fam_income_m_17
		
		sum *income_diff
		
		gen f15_17_income_pctchange = (tot_fam_income_f_17 - tot_fam_income_f_15) / tot_fam_income_f_15
		gen f16_18_income_pctchange = (tot_fam_income_f_18 - tot_fam_income_f_16) / tot_fam_income_f_16
		gen f17_19_income_pctchange = (tot_fam_income_f_19 - tot_fam_income_f_17) / tot_fam_income_f_17
		gen m15_17_income_pctchange = (tot_fam_income_m_17 - tot_fam_income_m_15) / tot_fam_income_m_15
		gen m16_18_income_pctchange = (tot_fam_income_m_18 - tot_fam_income_m_16) / tot_fam_income_m_16
		gen m17_19_income_pctchange = (tot_fam_income_m_19 - tot_fam_income_m_17) / tot_fam_income_m_17
		gen fam_income_pctchange =    (tot_fam_income_at_17_18 - tot_fam_income_at_15_16)/ tot_fam_income_at_15_16
		
		tabstat *income_pctchange , statistics(count mean p10 p25 p50 p75 p90 min max)
		*hist fam_income_pctchange if fam_income_pctchange >= -1 & fam_income_pctchange < 5 , width(0.2)
			count if fam_income_pctchange  <= -1
			count if fam_income_pctchange > 1 & fam_income_pctchange != . 
			count if fam_income_pctchange == . 
		
		*tabstat fam_income_at_15_16 fam_income_at_17_18  if fam_income_pctchange > 3 & fam_income_pctchange != . , statistics(count mean p10 p25 p50 p75 p90 min max) c(s)
		*tabstat fam_income_at_15_16 fam_income_at_17_18  if fam_income_pctchange <= -0.5 & fam_income_pctchange != . , statistics(count mean p10 p25 p50 p75 p90 min max) c(s)

		
		*sum fam_income_at_15_16 fam_income_at_17_18 if fam_income_pctchange > 3 & fam_income_pctchange != . 
		*sum fam_income_at_15_16 fam_income_at_17_18 if fam_income_pctchange <= -0.5 & fam_income_pctchange != . 
		
		*br $keyvarlist  fam_income_at_15_16 fam_income_at_17_18 fam_income_pctchange ind_int_combinations* if fam_income_pctchange <= 0.5 
		*br $keyvarlist  fam_income_at_15_16 fam_income_at_17_18 fam_income_pctchange if fam_income_pctchange > 2 & fam_income_pctchange != . 
	
*drop tas_cross_weight2005 tas_cross_weight2007 tas_cross_weight2009 tas_cross_weight2011 tas_cross_weight2013 tas_cross_weight2015

	
/* Rename BACK for phil he doesn't want this anymore
	rename tas_long_weight	    tas_weight
	rename tas_cross_weight cross_sectional_weight  
	rename ind_long_weight  ind_weight              
	rename cds_weight       cds_weight 			   
	rename ind_cross_weight ind_cross_weight		   
	rename avg_tas_long_weight tasweightave
	rename avg_tas_weight_old tasweightave_old
*/ 

save "$path/psid_cleanup/data/intermediate/psid_regdat_temp.dta" ,replace 
	
	
// KEEP 
	drop if tot_fam_income_at_15_18 == .	
	*keep if cds97_result == 1 
	

	
	count if home_equity_at_15_18 == .
	count if tot_fam_income_at_15_18 == .
	count if total_wealth_equity_at_15_18 == . 
	
*	br famidpns year age cds*
	
	*gen has_tas_long = 0 
	*	replace has_tas_long =1 if tas_long_weight != 0 & tas_long_weight != . 
	
	*tab cds14_result has_tas_long if year == 2017 
	
	*tab cds_tas05_result has_tas_long if year == 2017 
	*tab cds_tas07_result has_tas_long if year == 2017 
	*tab cds_tas09_result has_tas_long if year == 2017 
	*tab cds_tas11_result has_tas_long if year == 2017 
	*tab cds_tas13_result has_tas_long if year == 2017 
	*tab cds_tas15_result has_tas_long if year == 2017 
	
*******************************************************************************
**# Matching SCF 
*******************************************************************************

tabstat ///
	tot_fam_income_at_15_18 ///
	savings_at_15_18  ///
	val_stocks_at_15_18 ///
	home_equity_at_15_18 ///
	ira_annuity_at_15_18 ///
	total_wealth_equity_at_15_18 ///
	val_all_debt_at_15_18 ///
	, by(ethrace) stat(median) format(%9.0f)
	** there are just too many zeros I need to figure out what to do with them. 

	

tabstat ///
	tot_fam_income_at_15_18 ///
	savings_at_15_18  ///
	val_stocks_at_15_18 ///
	home_equity_at_15_18 ///
	ira_annuity_at_15_18 ///
	total_wealth_equity_at_15_18 ///
	val_all_debt_at_15_18 ///
	, stat( count mean min p25 median p75 p90 max) format(%9.0f)
	
stop end 1424
	tabstat ///
	tot_fam_income_at_15_18 ///
	savings_at_15_18  ///
	val_stocks_at_15_18 ///
	home_equity_at_15_18 ///
	ira_annuity_at_15_18 ///
	total_wealth_equity_at_15_18 ///
	*if fam_inc_cat_f_16 != "75000-" ///
	, by(ethrace) stat(median) format(%9.0f)

	
	
	tabstat ///
	tot_fam_income_at_15_18 ///
	savings_at_15_18  ///
	val_stocks_at_15_18 ///
	home_equity_at_15_18 ///
	ira_annuity_at_15_18 ///
	total_wealth_equity_at_15_18 ///
	*if fam_inc_cat_f_16 != "125000" ///
	, by(ethrace) stat(median) format(%9.0f)

	tab ethrace fam_inc_cat_f_16 if fam_inc_cat_f_16 != "none" , row 
	
	

	
	tabstat tas_long_weight if inlist(age,17,18), by (year) stat(count sum min mean p50 max )
	tabstat tas_cross_weight if inlist(age,17,18), by (year) stat(count sum min mean p50 max )
	tabstat cds_weight if inlist(age,17,18), by (year) stat(count sum min mean p50 max )
	tabstat ind_long_weight if inlist(age,17,18), by (year) stat(count sum min mean p50 max )