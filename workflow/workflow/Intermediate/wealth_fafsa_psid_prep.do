/*

Name: Veronika Konovalova
Project: Wealth and FAFSA 
Description: Preparing intergenerational PSID dataset for analysis
Last Updated: 10/28/2021
*takes like 4 minutes
*/

*************************************************************
*************************************************************
** STAGE 1: CLEANING RAW DATA, MERGING, CONVERTING TO LONG **
*************************************************************
*************************************************************
clear
cap clear mata
set maxvar 10000


global path "D:/Ian"

// Step 1: stitch together all years of TAS, rename variables and keep the ones of interest. 
	* If you need more TAS variables, get them here:
do "$path/psid_cleanup/workflow/Intermediate/Renaming_Raw_data/renaming_tas.do" 
   * Product: "$path/psid_cleanup/data/raw/tas_psid_renamed.dta", contains all TAS variables on children with 1968 identifiers for merging

   
// Step 2: clean the FIMS files and merge them with the TAS 
do "$path/psid_cleanup/workflow/Intermediate/PSID_child_parent_gp_combine.do"
   * Product: "$path/psid_cleanup/data/raw/tas_fims.dta", TAS variables with attached parent and grandparent 1968 dynasty identifiers

   
// Step 3: clean individual level files, get marital status and age of parents + grab the 1968 IDs and merge with TAS
	* If you need more individual level variables for grandparents, parents, or children, get them here:
do "$path/psid_cleanup/workflow/Intermediate/Renaming_Raw_data/renaming_ind.do" 

* Merge this with the TAS 
use "$path/psid_cleanup/data/raw/tas_fims.dta", clear 
merge m:1 famidpn using "$path/psid_cleanup/data/raw/ind_er.dta"
drop if _merge == 2
drop _merge 

local list "f m ff fm mf mm"
foreach p of local list{
merge m:1 famidpn_`p' using "$path/psid_cleanup/data/raw/fam_ids_int_`p'.dta"
drop if _merge == 2
drop _merge 

}

save "$path/psid_cleanup/data/raw/tas_with_ind.dta", replace
	* We now have the TAS + FIMS + IND with the following info on the parents: 
		* 1968 famidpn_f and famidpn_m 
		* Interview number and sequence number for every year (int_num_20XX_m int_num_20XX_f and seq_num_20XX_m seq_num_20XX_f)
	* We will use these identifiers to merge TAS children with wealth info from their parents and grandparents 


// Step 4: stitch together all years of the family files, rename variables and keep the ones of interest. Then, merge that with TAS and IND
	* If you need more family level variables, get them here: 
do "$path/psid_cleanup/workflow/Intermediate/Renaming_Raw_data/renaming_fam_fin_imputed.do" 

use "$path/psid_cleanup/data/raw/tas_with_ind.dta"

// Now merge with TAS and IND
use "$path/psid_cleanup/data/raw/tas_with_ind.dta", clear

foreach p of local list{
	forv i = 2001(2)2017{
		merge m:1 int_num_`p'`i' using "$path/psid_cleanup/data/raw/fam_`i'_renamed_`p'.dta"
		drop if _merge == 2
		drop _merge
		
		merge m:1 int_num_`p'`i' using "$path/psid_cleanup/data/raw/fam_wealth_`p'_`i'.dta"
		drop if _merge == 2
		drop _merge
	}
}

save "$path/psid_cleanup/data/raw/tas_ind_fam_merged.dta", replace 

	 sum val_all_debt_m*
	
// Step 5: fix ages and make long 
use "$path/psid_cleanup/data/raw/tas_ind_fam_merged.dta", clear 

reshape long int_num ind_weight ind_cross_weight tas_weight cross_sectional_weight cds_weight ///
 completed_college fam_bought_house_condo ///
value_house_condo fam_paid_rent_mortgage ///
value_rent_mortgage fam_bought_car value_car fam_paid_tuition value_tuition fam_helped_pay_sl ///
value_sl value_sl_all fam_paid_expenses value_expenses got_personal_loan value_personal_loan ///
other_fin_help val_other_fin_help other_large_gifts large_gift_first_mention large_gift_one_amt ///
large_gift_one_yr_rec large_gift_two_amt large_gift_two_yr_rec large_gift_three_amt ///
large_gift_three_yr_rec received_inheritance value_inheritance ///
large_gift_second_mention how_much_second_mention yr_rec_second_mention ///
gift_inheritance_one gift_inheritance_two gift_inheritance_three yr_rec_third_mention ///
how_much_one how_much_two how_much_three yr_rec_first_mention_one ///
yr_rec_first_mention_two yr_rec_first_mention_three grad_hs month_grad_hs ///
year_grad_hs grade_lvl_if_ged month_last_in_school_if_ged year_last_in_school_if_ged ///
month_received_ged year_received_ged last_pgrade_finished mo_last_school_ifnograd ///
yr_last_in_school_ifnograd hs_gpa highest_hs_gpa had_more_educ ///
highest_lvl_complete grad_college took_sat sat_reading sat_math act_score ever_attend_college ///
in_college current_attend_college ft_or_pt_student mo_enroll_most_rec_college ///
yr_enroll_most_rec_college mo_attend_most_rec_college yr_attend_most_rec_college ///  
major_most_rec_college gpa_most_rec_college high_gpa_most_rec_college degree_most_rec_college ///  
gpa_college_one highest_gpa_college_one tot_credit_hrs_college_one semester_system_college_one /// 
mo_enroll_earlier_college yr_enroll_earlier_college mo_attend_earlier_college /// 
yr_attend_earlier_college gpa_earlier_college gpa_college_two highest_gpa_earlier_college /// 
highest_gpa_college_two degree_earlier_college ethnicity race hispan highest_educ_level educ_mother ///
recent_educ_mother educ_father recent_educ_father ///
age age_f age_m age_ff age_fm age_mf age_mm ///
int_num_f total_wealth_equity_f ///
couple_status_f tot_fam_income_f ///
ira_annuity_f tot_pension_f home_value_f ///
mortgage1_f mortgage2_f home_equity_f ///
biz_farm_netval_f biz_farm_debt_f biz_farm_worth_f ///
val_inheritance1_f val_inheritance2_f ///
val_inheritance3_f savings_f val_stocks_f ///
int_num_m total_wealth_equity_m ///
couple_status_m tot_fam_income_m ///
ira_annuity_m tot_pension_m home_value_m ///
mortgage1_m mortgage2_m home_equity_m ///
biz_farm_netval_m biz_farm_debt_m biz_farm_worth_m ///
val_inheritance1_m val_inheritance2_m ///
val_inheritance3_m savings_m val_stocks_m ///
int_num_ff total_wealth_equity_ff ///
couple_status_ff tot_fam_income_ff ///
ira_annuity_ff tot_pension_ff home_value_ff ///
mortgage1_ff mortgage2_ff home_equity_ff ///
biz_farm_netval_ff biz_farm_debt_ff biz_farm_worth_ff ///
val_inheritance1_ff val_inheritance2_ff ///
val_inheritance3_ff savings_ff val_stocks_ff ///
int_num_fm total_wealth_equity_fm ///
couple_status_fm tot_fam_income_fm ///
ira_annuity_fm tot_pension_fm home_value_fm ///
mortgage1_fm mortgage2_fm home_equity_fm ///
biz_farm_netval_fm biz_farm_debt_fm biz_farm_worth_fm ///
val_inheritance1_fm val_inheritance2_fm ///
val_inheritance3_fm savings_fm val_stocks_fm ///
int_num_mf total_wealth_equity_mf ///
couple_status_mf tot_fam_income_mf ///
ira_annuity_mf tot_pension_mf home_value_mf ///
mortgage1_mf mortgage2_mf home_equity_mf ///
biz_farm_netval_mf biz_farm_debt_mf biz_farm_worth_mf ///
val_inheritance1_mf val_inheritance2_mf ///
val_inheritance3_mf savings_mf val_stocks_mf ///
int_num_mm total_wealth_equity_mm ///
couple_status_mm tot_fam_income_mm ///
ira_annuity_mm tot_pension_mm home_value_mm ///
mortgage1_mm mortgage2_mm home_equity_mm ///
biz_farm_netval_mm biz_farm_debt_mm biz_farm_worth_mm ///
val_inheritance1_mm val_inheritance2_mm ///
val_inheritance3_mm savings_mm val_stocks_mm ///
val_debt_sl_f val_debt_sl_m val_debt_sl_ff val_debt_sl_fm val_debt_sl_mf val_debt_sl_mm /// 
val_all_debt_f val_all_debt_m val_all_debt_ff val_all_debt_fm val_all_debt_mf val_all_debt_mm /// 
seq_num_f seq_num_m seq_num_ff seq_num_fm seq_num_mf seq_num_mm fam_weight_f fam_weight_m ///
val_debt_credit_f val_debt_credit_m val_debt_credit_ff val_debt_credit_fm val_debt_credit_mf val_debt_credit_mm ///
val_debt_medical_f val_debt_medical_m val_debt_medical_ff val_debt_medical_fm val_debt_medical_mf val_debt_medical_mm ///
val_debt_legal_f val_debt_legal_m val_debt_legal_ff val_debt_legal_fm val_debt_legal_mf val_debt_legal_mm ///
val_debt_famloans_f val_debt_famloans_m val_debt_famloans_ff val_debt_famloans_fm val_debt_famloans_mf val_debt_famloans_mm ///
val_other_realestate_f val_other_realestate_m val_vehicles_f val_vehicles_m val_other_assets_f val_other_assets_m ///
val_debt_other_f val_debt_other_m enrollment_status ///
fam_weight_ff fam_weight_fm fam_weight_mf fam_weight_mm, i(famidpn famidpns) j(year)

order famidpn famidpns year int_num tas_weight TAS* age

// Fill in ages when they're 0
g birth = year - age 
replace birth = . if age == 0 | missing(age)
egen birth_year = max(birth), by(famidpn)
replace age = year - birth_year if age == 0 | missing(age)
drop birth

*br famidpn year age birth_year age_f age_m

// Save the full long dataset 
save "$path/psid_cleanup/data/intermediate/psid_clean_long.dta", replace 


// Back to wide with fixed age 
reshape wide int_num ind_weight ind_cross_weight tas_weight cross_sectional_weight cds_weight completed_college fam_bought_house_condo ///
value_house_condo fam_paid_rent_mortgage ///
value_rent_mortgage fam_bought_car value_car fam_paid_tuition value_tuition fam_helped_pay_sl ///
value_sl value_sl_all fam_paid_expenses value_expenses got_personal_loan value_personal_loan ///
other_fin_help val_other_fin_help other_large_gifts large_gift_first_mention large_gift_one_amt ///
large_gift_one_yr_rec large_gift_two_amt large_gift_two_yr_rec large_gift_three_amt ///
large_gift_three_yr_rec received_inheritance value_inheritance ///
large_gift_second_mention how_much_second_mention yr_rec_second_mention ///
gift_inheritance_one gift_inheritance_two gift_inheritance_three yr_rec_third_mention ///
how_much_one how_much_two how_much_three yr_rec_first_mention_one ///
yr_rec_first_mention_two yr_rec_first_mention_three grad_hs month_grad_hs ///
year_grad_hs grade_lvl_if_ged month_last_in_school_if_ged year_last_in_school_if_ged ///
month_received_ged year_received_ged /*last_grade_finished */ mo_last_school_ifnograd ///
yr_last_in_school_ifnograd hs_gpa highest_hs_gpa had_more_educ ///
highest_lvl_complete grad_college took_sat sat_reading sat_math act_score ever_attend_college ///
in_college current_attend_college ft_or_pt_student mo_enroll_most_rec_college ///
yr_enroll_most_rec_college mo_attend_most_rec_college yr_attend_most_rec_college ///  
major_most_rec_college gpa_most_rec_college high_gpa_most_rec_college degree_most_rec_college ///  
gpa_college_one highest_gpa_college_one tot_credit_hrs_college_one semester_system_college_one /// 
mo_enroll_earlier_college yr_enroll_earlier_college mo_attend_earlier_college /// 
yr_attend_earlier_college gpa_earlier_college gpa_college_two highest_gpa_earlier_college /// 
highest_gpa_college_two degree_earlier_college ethnicity race hispan highest_educ_level educ_mother ///
recent_educ_mother educ_father recent_educ_father ///
age age_f age_m age_ff age_fm age_mf age_mm ///
int_num_f total_wealth_equity_f ///
couple_status_f tot_fam_income_f ///
ira_annuity_f tot_pension_f home_value_f ///
mortgage1_f mortgage2_f home_equity_f ///
biz_farm_netval_f biz_farm_debt_f biz_farm_worth_f ///
val_inheritance1_f val_inheritance2_f ///
val_inheritance3_f savings_f val_stocks_f ///
int_num_m total_wealth_equity_m ///
couple_status_m tot_fam_income_m ///
ira_annuity_m tot_pension_m home_value_m ///
mortgage1_m mortgage2_m home_equity_m ///
biz_farm_netval_m biz_farm_debt_m biz_farm_worth_m ///
val_inheritance1_m val_inheritance2_m ///
val_inheritance3_m savings_m val_stocks_m ///
int_num_ff total_wealth_equity_ff ///
couple_status_ff tot_fam_income_ff ///
ira_annuity_ff tot_pension_ff home_value_ff ///
mortgage1_ff mortgage2_ff home_equity_ff ///
biz_farm_netval_ff biz_farm_debt_ff biz_farm_worth_ff ///
val_inheritance1_ff val_inheritance2_ff ///
val_inheritance3_ff savings_ff val_stocks_ff ///
int_num_fm total_wealth_equity_fm ///
couple_status_fm tot_fam_income_fm ///
ira_annuity_fm tot_pension_fm home_value_fm ///
mortgage1_fm mortgage2_fm home_equity_fm ///
biz_farm_netval_fm biz_farm_debt_fm biz_farm_worth_fm ///
val_inheritance1_fm val_inheritance2_fm ///
val_inheritance3_fm savings_fm val_stocks_fm ///
int_num_mf total_wealth_equity_mf ///
couple_status_mf tot_fam_income_mf ///
ira_annuity_mf tot_pension_mf home_value_mf ///
mortgage1_mf mortgage2_mf home_equity_mf ///
biz_farm_netval_mf biz_farm_debt_mf biz_farm_worth_mf ///
val_inheritance1_mf val_inheritance2_mf ///
val_inheritance3_mf savings_mf val_stocks_mf ///
int_num_mm total_wealth_equity_mm ///
couple_status_mm tot_fam_income_mm ///
ira_annuity_mm tot_pension_mm home_value_mm ///
mortgage1_mm mortgage2_mm home_equity_mm ///
biz_farm_netval_mm biz_farm_debt_mm biz_farm_worth_mm ///
val_inheritance1_mm val_inheritance2_mm ///
val_inheritance3_mm savings_mm val_stocks_mm ///
val_debt_sl_f val_debt_sl_m val_debt_sl_ff val_debt_sl_fm val_debt_sl_mf val_debt_sl_mm /// 
val_all_debt_f val_all_debt_m val_all_debt_ff val_all_debt_fm val_all_debt_mf val_all_debt_mm /// 
seq_num_f seq_num_m seq_num_ff seq_num_fm seq_num_mf seq_num_mm ///
fam_weight_f fam_weight_m ///
val_debt_credit_f val_debt_credit_m val_debt_credit_ff val_debt_credit_fm val_debt_credit_mf val_debt_credit_mm ///
val_debt_medical_f val_debt_medical_m val_debt_medical_ff val_debt_medical_fm val_debt_medical_mf val_debt_medical_mm ///
val_debt_legal_f val_debt_legal_m val_debt_legal_ff val_debt_legal_fm val_debt_legal_mf val_debt_legal_mm ///
val_debt_famloans_f val_debt_famloans_m val_debt_famloans_ff val_debt_famloans_fm val_debt_famloans_mf val_debt_famloans_mm ///
val_other_realestate_f val_other_realestate_m val_vehicles_f val_vehicles_m val_other_assets_f val_other_assets_m ///
val_debt_other_f val_debt_other_m enrollment_status  ///
fam_weight_ff fam_weight_fm fam_weight_mf fam_weight_mm, i(famidpn famidpns) j(year)
 
sort famidpn age*
save "$path/psid_cleanup/data/intermediate/psid_clean_wide.dta", replace 


******************************************************************
******************************************************************
** STAGE 2: EXTRACTING FAMILY CHARACTERISTICS AT DIFFERENT AGES **
******************************************************************
******************************************************************

/* 1) select age 17-18 to extract family characteristics at the point of potential college entry. Sort by ID and save. Go back to wide data. */
use "$path/psid_cleanup/data/intermediate/psid_clean_long.dta", clear 

// For parents # kids in college
gen currently_in_college = 0
	replace currently_in_college  = 1 if in_college == 1 

bysort famidpn_f year: egen num_kids_in_college_f = sum(currently_in_college) if famidpn_f != . & famidpn_f != 0 
bysort famidpn_m year: egen num_kids_in_college_m = sum(currently_in_college) if famidpn_m != . & famidpn_m != 0 

* parent wealth variables
local list "f m"
local vars "couple_status home_value mortgage1 mortgage2 biz_farm_worth biz_farm_debt biz_farm_netval val_stocks ira_annuity savings val_debt_sl val_inheritance1 val_inheritance2 val_inheritance3 tot_pension home_equity total_wealth_equity tot_fam_income val_all_debt num_kids_in_college"
foreach p of local list{
    foreach v of local vars{

	forv i = 15/26{
			g temp_`v'_`p'_`i' = `v'_`p' if age == `i'
			egen `v'_`p'_`i' = max(temp_`v'_`p'_`i'), by(famidpn)
			
			drop temp_`v'_`p'_`i'
		}
	}
}

* total wealth equity for grandparents only
local list "ff fm mf mm"
foreach p of local list{
	forv i = 16/19{
			g temp_total_wealth_equity_`p'_`i' = total_wealth_equity_`p' if age == `i'
			egen total_wealth_equity_`p'_`i' = max(temp_total_wealth_equity_`p'_`i'), by(famidpn)
			
			drop temp_total_wealth_equity_`p'_`i'
		}
}
		
/* 2) Measure college entry at every early age bracket */

replace yr_first_enroll = 0 if yr_first_enroll > 2050

	forv i = 16/22{
	g temp_college_`i' = yr_first_enroll if age == `i' & ///    
	yr_first_enroll == year
	egen first_enroll1_`i' = max(temp_college_`i'), by(famidpn)
	drop temp_college_`i'
	
	g temp_college_`i' = yr_first_enroll if age + 1 == `i' & ///
	yr_first_enroll == year + 1
	egen first_enroll2_`i' = max(temp_college_`i'), by(famidpn)
	drop temp_college_`i'
	
	g temp_college_`i' = yr_first_enroll if age - 1 == `i' & ///
	yr_first_enroll == year - 1
	egen first_enroll3_`i' = max(temp_college_`i'), by(famidpn)
	drop temp_college_`i'
	
	egen first_enroll_`i' = rowtotal(first_enroll1_`i' first_enroll2_`i' first_enroll3_`i')
	replace first_enroll_`i' = 1 if first_enroll_`i' != 0
	
	drop first_enroll1_`i' first_enroll2_`i' first_enroll3_`i'
	}
	
	
	// Also develop variables that mark BY WHEN a person enrolled in college for each age bracket 
	g enrolled_by_18 = 0
	replace enrolled_by_18 = 1 if first_enroll_16 == 1 |first_enroll_17 == 1 | first_enroll_18 == 1
	
	g enrolled_by_19 = 0
	replace enrolled_by_19 = 1 if first_enroll_16 == 1 |first_enroll_17 == 1 | first_enroll_18 == 1 | first_enroll_19 == 1

	g enrolled_by_20 = 0
	replace enrolled_by_20 = 1 if first_enroll_16 == 1 |first_enroll_17 == 1 | first_enroll_18 == 1 | first_enroll_19 == 1 ///
	| first_enroll_20 == 1

	g enrolled_by_21 = 0
	replace enrolled_by_21 = 1 if first_enroll_16 == 1 |first_enroll_17 == 1 | first_enroll_18 == 1 | first_enroll_19 == 1 ///
	| first_enroll_20 == 1 | first_enroll_21 == 1
	
	g enrolled_by_22 = 0
	replace enrolled_by_22 = 1 if first_enroll_16 == 1 |first_enroll_17 == 1 | first_enroll_18 == 1 | first_enroll_19 == 1 ///
	| first_enroll_20 == 1 | first_enroll_21 == 1 | first_enroll_22 == 1 

/*3) select age 23-24. Now we're interested in college completion. Create measures of that, add 23_24 suffixes*/ 
	* Have most recent and earlier college degree
	g flag_has_degree_now = 0 
	replace flag_has_degree_now = 1 if degree_earlier_college == 2
	replace flag_has_degree_now = 1 if degree_most_rec_college == 2
	
	g year_deg = year if flag_has_degree_now == 1 
	egen year_finished_college = min(year_deg), by(famidpn)
	
	forv i = 23/24{
	g completed_college_temp_`i' = 0
	replace completed_college_temp_`i' = 1 if age == `i' & year == year_finished_college 
	egen completed_college_at_`i' = max(completed_college_temp_`i'), by(famidpn)
	drop completed_college_temp_`i'
	}


/*4) select ages 25-26. Now we want to start measuring labor market outcomes. Create measures of employment and wages, add 25_26 suffix*/ 

/*5) Tracking parent debt while parents' kid is in college. We don't have a great way of doing that, but we could just track their total debt and net worth (looking for declines in the latter). That would require selecting values for those variables when the kid is 19-20, 21-22, and 23-24. */
local vars "total_wealth_equity "
foreach p of local list{
    foreach v of local vars{
	    forv i = 20/24{
		g t_`v'_`p'_`i' = `v'_`p' if age == `i'
		egen `v'_`p'_`i' = max(t_`v'_`p'_`i'), by(famidpn)
	 
		drop t_`v'_`p'_`i'

		}
	}
}

// Make ethnicity variable static
egen ethmax = max(ethnicity), by(famidpn)
drop ethnicity 
rename ethmax ethnicity 

// Make race variable static 
egen racemax = max(race), by(famidpn)
drop race 
rename racemax race

// Make Hispanic variable static 
egen hispanmax = max(hispan), by(famidpn)
drop hispan
rename hispanmax hispan

// Black, non-Hispanic, White, non-Hispanic, Hispanic, and other 
g black = 0
replace black = 1 if race == 2 & hispan == 0
replace black = 1 if race == 2 & hispan == .

g white = 0
replace white = 1 if race == 1 & hispan == 0
replace white = 1 if race == 1 & hispan == .

g hispanic = 0
replace hispanic = 1 if inrange(hispan, 1, 7)

g other = 0
replace other = 1 if black == 0 & white == 0 & hispanic == 0

assert black + white + hispanic + other == 1

g ethrace = .
replace ethrace = 0 if white == 1
replace ethrace = 1 if black == 1
replace ethrace = 2 if hispanic == 1
replace ethrace = 3 if other == 1
lab define ethrace 0 "White" 1 "Black" 2 "Hispanic" 3 "Other"
lab value ethrace ethrace

lab define sex 1 "Male" 2 "Female"
lab value sex sex

// Adding some more labels 
forv i = 16/22{
    lab var first_enroll_`i' "TAS subject first enrolled in college at age `i'"
	}

forv i = 18/22{
    lab var enrolled_by_`i' "TAS subject was enrolled in college by age `i'"
}

*lab var completed_college_23_24 "TAS subject completed college in 23-24 age group"

lab define couple_status 1 "Head with wife present in FU" 2 "Head with 'wife' present in FU" 3 "Head (female) with husband present in FU" 4 "Head with first year cohabitator present in FU" 5 "Head with no wife/'wife'/cohabitator present"

forv i = 16/19{
lab var couple_status_f_`i' "Couple status of father when TAS subject was `i'"
lab value couple_status_f_`i' couple_status

lab var couple_status_m_`i' "Couple status of mother when TAS subject was `i'"
lab value couple_status_m_`i' couple_status

}

/*
egen couple_status_f_1718 = rowmax(couple_status_f_17 couple_status_f_18)
egen couple_status_m_1718 = rowmax(couple_status_m_17 couple_status_m_18)
lab value couple_status_f_1718 couple_status
lab value couple_status_m_1718 couple_status
*/

*keep famidpn famidpns int_num year age birth_year tas_weight TAS* sex ethrace hispanic black white other value_sl int_num_f fam_weight_f int_num_m fam_weight_m int_num_ff fam_weight_ff int_num_fm fam_weight_fm int_num_mf fam_weight_mf int_num_mm fam_weight_mm first_enroll* enrolled_by* completed_college_at* couple_status_* home_value_* mortgage1_* mortgage2_* biz_farm_worth_* biz_farm_debt_* biz_farm_netval_* val_stocks_* ira_annuity_* savings_* val_debt_sl_* val_inheritance1_* val_inheritance2_* val_inheritance3_* tot_pension_* home_equity_* total_wealth_equity_* tot_fam_income_* total_wealth_equity_* age_* educ_*

order famidpn famidpns int_num year age birth_year tas_weight TAS* sex ethrace hispanic black white other value_sl int_num_f fam_weight_f int_num_m fam_weight_m int_num_ff fam_weight_ff int_num_fm fam_weight_fm int_num_mf fam_weight_mf int_num_mm fam_weight_mm first_enroll* enrolled_by* completed_college_at* couple_status_* home_value_* mortgage1_* mortgage2_* biz_farm_worth_* biz_farm_debt_* biz_farm_netval_* val_stocks_* ira_annuity_* savings_* val_debt_sl_* val_inheritance1_* val_inheritance2_* val_inheritance3_* tot_pension_* home_equity_* total_wealth_equity_* tot_fam_income_* total_wealth_equity_*

* drop the non-static wealth variables 
*drop couple_status_f couple_status_m couple_status_ff couple_status_fm couple_status_mf couple_status_mm home_value_f home_value_m home_value_ff home_value_fm home_value_mf home_value_mm mortgage1_f mortgage1_m mortgage1_fm mortgage1_ff mortgage1_mf mortgage1_mm mortgage2_f mortgage2_m mortgage2_fm mortgage2_ff mortgage2_mf mortgage2_mm biz_farm_worth_f biz_farm_worth_m biz_farm_worth_fm biz_farm_worth_ff biz_farm_worth_mf biz_farm_worth_mm biz_farm_debt_f biz_farm_debt_m biz_farm_debt_fm biz_farm_debt_ff biz_farm_debt_mf biz_farm_debt_mm biz_farm_netval_f biz_farm_netval_m biz_farm_netval_fm biz_farm_netval_ff biz_farm_netval_mf biz_farm_netval_mm val_stocks_f val_stocks_m val_stocks_ff val_stocks_fm val_stocks_mf val_stocks_mm ira_annuity_f ira_annuity_m ira_annuity_fm ira_annuity_ff ira_annuity_mf ira_annuity_mm savings_f savings_m savings_ff savings_fm savings_mf savings_mm val_debt_sl_f val_debt_sl_m val_debt_sl_ff val_debt_sl_fm val_debt_sl_mf val_debt_sl_mm val_inheritance1_f val_inheritance1_m val_inheritance1_ff val_inheritance1_fm val_inheritance1_mf val_inheritance1_mm val_inheritance2_f val_inheritance2_m val_inheritance2_ff val_inheritance2_fm val_inheritance2_mf val_inheritance2_mm val_inheritance3_f val_inheritance3_m val_inheritance3_ff val_inheritance3_fm val_inheritance3_mf val_inheritance3_mm tot_pension_f tot_pension_m tot_pension_ff tot_pension_fm tot_pension_mf tot_pension_mm home_equity_f home_equity_m home_equity_fm home_equity_ff home_equity_mf home_equity_mm total_wealth_equity_f total_wealth_equity_m total_wealth_equity_fm total_wealth_equity_ff total_wealth_equity_mf total_wealth_equity_mm tot_fam_income_f tot_fam_income_m tot_fam_income_ff tot_fam_income_fm tot_fam_income_mf tot_fam_income_mm

sort famidpn year
order int_num_f int_num_m couple_status*, after(int_num)
order year birth_year age, after(famidpns)

save "$path/psid_cleanup/data/intermediate/wealth_finaid_psid_final.dta", replace


do "$path/psid_cleanup/workflow/intermediate/assign_ind_int_num.do"