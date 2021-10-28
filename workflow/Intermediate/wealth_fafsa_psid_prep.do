/*

Name: Veronika Konovalova
Project: Wealth and FAFSA 
Description: Preparing intergenerational PSID dataset for analysis
Last Updated: 6/7/21

*/

*************************************************************
*************************************************************
** STAGE 1: CLEANING RAW DATA, MERGING, CONVERTING TO LONG **
*************************************************************
*************************************************************
clear
set maxvar 10000

// Step 1: stitch together all years of TAS, rename variables and keep the ones of interest. 
	* If you need more TAS variables, get them here:
do D:/Veronika/psid_cleanup/workflow/Intermediate/Renaming_Raw_data/renaming_tas.do 
   * Product: D:/Veronika/psid_cleanup/data/Raw/tas_psid_renamed.dta, contains all TAS variables on children with 1968 identifiers for merging

   
// Step 2: clean the FIMS files and merge them with the TAS 
do D:/Veronika/psid_cleanup/workflow/Intermediate/PSID_child_parent_gp_combine.do
   * Product: D:/Veronika/psid_cleanup/data/raw/tas_fims.dta, TAS variables with attached parent and grandparent 1968 dynasty identifiers

   
// Step 3: clean individual level files, get marital status and age of parents + grab the 1968 IDs and merge with TAS
	* If you need more individual level variables for grandparents, parents, or children, get them here:
do D:/Veronika/psid_cleanup/workflow/Intermediate/ind_prep.do 
   * Product: D:/Veronika/psid_cleanup/data/raw/tas_with_ind.dta

	* We now have the TAS + FIMS + IND with the following info on the parents: 
		* 1968 famidpn_f and famidpn_m 
		* Interview number and sequence number for every year (int_num_20XX_m int_num_20XX_f and seq_num_20XX_m seq_num_20XX_f)
	* We will use these identifiers to merge TAS children with wealth info from their parents and grandparents 


// Step 4: stitch together all years of the family files, rename variables and keep the ones of interest. Then, merge that with TAS and IND
	* If you need more family level variables, get them here: 
do D:/Veronika/psid_cleanup/workflow/Intermediate/Renaming_Raw_data/renaming_fam_fin.do 
	* Product: D:/Veronika/psid_cleanup/data/raw/tas_ind_fam_merged.dta

// Step 5: fix ages and make long 
use D:/Veronika/psid_cleanup/data/raw/tas_ind_fam_merged.dta, clear 

forv i = 2005(2)2015{
g temp_early`i' = yr_attend_earlier_college`i'
replace temp_early`i' = . if temp_early`i' == 0 | inrange(degree_earlier_college`i', 8, 9) | ///
degree_earlier_college`i' == 0 | degree_earlier_college`i' == .
}

egen yr_early = rowmin(temp_early*)
drop temp_early* 
	
forv i = 2005(2)2015{
g temp_rec`i' = yr_attend_most_rec_college`i'
replace temp_rec`i' = . if temp_rec`i' == 0 | inrange(degree_most_rec_college`i', 8, 9) | ///
degree_most_rec_college`i' == 0 | degree_most_rec_college`i' == .
}

egen yr_rec = rowmin(temp_rec*)
drop temp_rec* 

egen yr_last_attend = rowmin(yr_early yr_rec)

reshape long int_num fam_bought_house_condo ///
value_house_condo fam_paid_rent_mortgage ///
value_rent_mortgage fam_bought_car value_car fam_paid_tuition value_tuition fam_helped_pay_sl ///
value_sl_payments fam_paid_expenses value_expenses got_personal_loan value_personal_loan ///
other_fin_help val_other_fin_help other_large_gifts large_gift_first_mention large_gift_one_amt ///
large_gift_one_yr_rec large_gift_two_amt large_gift_two_yr_rec large_gift_three_amt ///
large_gift_three_yr_rec received_inheritance value_inheritance ///
large_gift_second_mention how_much_second_mention yr_rec_second_mention ///
gift_inheritance_one gift_inheritance_two gift_inheritance_three yr_rec_third_mention ///
how_much_one how_much_two how_much_three yr_rec_first_mention_one ///
yr_rec_first_mention_two yr_rec_first_mention_three grad_hs month_grad_hs ///
year_grad_hs grade_lvl_if_ged month_last_in_school_if_ged year_last_in_school_if_ged ///
month_received_ged year_received_ged last_grade_finished mo_last_school_ifnograd ///
yr_last_in_school_ifnograd hs_gpa highest_hs_gpa had_more_educ ///
highest_lvl_complete grad_college took_sat sat_reading sat_math act_score ever_attend_college ///
in_college current_attend_college ft_or_pt_student mo_enroll_most_rec_college ///
yr_enroll_most_rec_college mo_attend_most_rec_college yr_attend_most_rec_college ///  
major_most_rec_college gpa_most_rec_college high_gpa_most_rec_college degree_most_rec_college ///  
gpa_college_one highest_gpa_college_one tot_credit_hrs_college_one semester_system_college_one /// 
mo_enroll_earlier_college yr_enroll_earlier_college mo_attend_earlier_college /// 
yr_attend_earlier_college gpa_earlier_college gpa_college_two highest_gpa_earlier_college /// 
highest_gpa_college_two degree_earlier_college ethnicity race highest_educ_level educ_mother ///
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
val_sl_f val_sl_m val_sl_ff val_sl_fm val_sl_mf val_sl_mm /// 
seq_num_f seq_num_m seq_num_ff seq_num_fm seq_num_mf seq_num_mm, ///
i(famidpn famidpns yr_last_attend) j(year)

order famidpn famidpns year int_num age

// Fill in ages when they're 0, do it sequentially forwards and backwards 

forv i = 2005(2)2017 {
replace age = age[_n-1] + 2 if age == 0 & age[_n-1] !=. & age[_n-1]!= 0 & ///
famidpn == famidpn[_n-1] & year == `i'
}

forv i = 2017(-2)2005{
replace age = age[_n+1] - 2 if age == 0 & age[_n+1] !=. & age[_n+1]!= 0 & ///
famidpn == famidpn[_n+1] & year == `i'
}

// Save the full long dataset 
save D:/Veronika/psid_cleanup/data/Intermediate/psid_clean_long.dta, replace 

// Back to wide with fixed age 
reshape wide int_num yr_last_attend fam_bought_house_condo ///
value_house_condo fam_paid_rent_mortgage ///
value_rent_mortgage fam_bought_car value_car fam_paid_tuition value_tuition fam_helped_pay_sl ///
value_sl_payments fam_paid_expenses value_expenses got_personal_loan value_personal_loan ///
other_fin_help val_other_fin_help other_large_gifts large_gift_first_mention large_gift_one_amt ///
large_gift_one_yr_rec large_gift_two_amt large_gift_two_yr_rec large_gift_three_amt ///
large_gift_three_yr_rec received_inheritance value_inheritance ///
large_gift_second_mention how_much_second_mention yr_rec_second_mention ///
gift_inheritance_one gift_inheritance_two gift_inheritance_three yr_rec_third_mention ///
how_much_one how_much_two how_much_three yr_rec_first_mention_one ///
yr_rec_first_mention_two yr_rec_first_mention_three grad_hs month_grad_hs ///
year_grad_hs grade_lvl_if_ged month_last_in_school_if_ged year_last_in_school_if_ged ///
month_received_ged year_received_ged last_grade_finished mo_last_school_ifnograd ///
yr_last_in_school_ifnograd hs_gpa highest_hs_gpa had_more_educ ///
highest_lvl_complete grad_college took_sat sat_reading sat_math act_score ever_attend_college ///
in_college current_attend_college ft_or_pt_student mo_enroll_most_rec_college ///
yr_enroll_most_rec_college mo_attend_most_rec_college yr_attend_most_rec_college ///  
major_most_rec_college gpa_most_rec_college high_gpa_most_rec_college degree_most_rec_college ///  
gpa_college_one highest_gpa_college_one tot_credit_hrs_college_one semester_system_college_one /// 
mo_enroll_earlier_college yr_enroll_earlier_college mo_attend_earlier_college /// 
yr_attend_earlier_college gpa_earlier_college gpa_college_two highest_gpa_earlier_college /// 
highest_gpa_college_two degree_earlier_college ethnicity race highest_educ_level educ_mother ///
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
val_sl_f val_sl_m val_sl_ff val_sl_fm val_sl_mf val_sl_mm /// 
seq_num_f seq_num_m seq_num_ff seq_num_fm seq_num_mf seq_num_mm, ///
i(famidpn famidpns) j(year)
 
sort famidpn age*
save D:/Veronika/psid_cleanup/data/Intermediate/psid_clean_wide.dta, replace 

******************************************************************
******************************************************************
** STAGE 2: EXTRACTING FAMILY CHARACTERISTICS AT DIFFERENT AGES **
******************************************************************
******************************************************************

/* 1) select age 17-18 to extract family characteristics at the point of potential college entry. Sort by ID and save. Go back to wide data. */
use D:/Veronika/psid_cleanup/data/Intermediate/psid_clean_long.dta, clear 

local list "f m ff fm mf mm"
local vars "couple_status home_value mortgage1 mortgage2 biz_farm_worth biz_farm_debt biz_farm_netval val_stocks ira_annuity savings val_sl val_inheritance1 val_inheritance2 val_inheritance3 tot_pension home_equity total_wealth_equity tot_fam_income"

foreach p of local list{
    foreach v of local vars{
	g temp_`v'_`p'_17 = `v'_`p' if age == 17
	egen `v'_`p'_17 = max(temp_`v'_`p'_17), by(famidpn)
 
 	drop temp_`v'_`p'_17

 	g temp_`v'_`p'_18 = `v'_`p' if age == 18
	egen `v'_`p'_18 = max(temp_`v'_`p'_18), by(famidpn)
	
	drop temp_`v'_`p'_18
	}
}

// We do these again later
//drop total_wealth_equity_f_17 total_wealth_equity_f_18

/* 2) select age 19-20 to measure college entry. Rename variables with a 19_20 suffix. Sort by ID and save. */
	
	egen earlier_college_yr = max(yr_enroll_earlier_college), by(famidpn)
	g temp_college_19_20 = earlier_college_yr if inrange(age, 19, 20) & ///    
	earlier_college_yr == year
	egen enter_college_19_20 = max(temp_college_19_20), by(famidpn)
	drop temp_college_19_20

/* 3) select age 21-22 and repeat step 2 */
	g temp_college_21_22 = earlier_college_yr if inrange(age, 21, 22) & ///    
	earlier_college_yr == year
	egen enter_college_21_22 = max(temp_college_21_22), by(famidpn)
	drop temp_college_21_22

/*4) select age 23-24. Now we're interested in college completion. Create measures of that, add 23_24 suffixes*/ 
	
	g temp_complete_23_24 = year if inrange(age, 23, 24) & yr_last_attend == year  
	egen completed_college_23_24 = max(temp_complete_23_24), by(famidpn)
	
/*5) select ages 25-26. Now we want to start measuring labor market outcomes. Create measures of employment and wages, add 25_26 suffix*/ 

/* 6) Tracking parent debt while parents' kid is in college. We don't have a great way of doing that, but we could just track their total debt and net worth (looking for declines in the latter). That would require selecting values for those variables when the kid is 19-20, 21-22, and 23-24. */
local vars "total_wealth_equity "
foreach p of local list{
    foreach v of local vars{
	    forv i = 19/24{
		g t_`v'_`p'_`i' = `v'_`p' if age == `i'
		egen `v'_`p'_`i' = max(t_`v'_`p'_`i'), by(famidpn)
	 
		drop t_`v'_`p'_`i'

		}
	}
}

// Keep all relevant variables
keep famidpn famidpns year enter_college_19_20 enter_college_21_22 completed_college_23_24 total_wealth_equity_f_* total_wealth_equity_m_* couple_status_f_17 couple_status_f_18 couple_status_m_18 home_value_f_17 home_value_m_17 home_value_f_18 home_value_m_18 mortgage1_f_17 mortgage1_f_18 mortgage1_m_17 mortgage1_m_18 mortgage2_f_17 mortgage2_f_18 mortgage2_m_17 mortgage2_m_18 biz_farm_worth_f_17 biz_farm_worth_f_18 biz_farm_worth_m_17 biz_farm_worth_m_18 biz_farm_debt_f_17 biz_farm_debt_f_18 biz_farm_debt_m_17 biz_farm_debt_m_18 biz_farm_netval_f_17 biz_farm_netval_f_18 biz_farm_netval_m_17 biz_farm_netval_m_18 val_stocks_f_17 val_stocks_f_18 val_stocks_m_17 val_stocks_m_18 ira_annuity_f_17 ira_annuity_f_18 ira_annuity_m_17 ira_annuity_m_18 savings_f_17 savings_f_18 savings_m_17 savings_m_18 val_sl_f_17 val_sl_f_18 val_inheritance1_f_17 val_inheritance1_f_18 val_inheritance1_m_17 val_inheritance1_m_18 val_inheritance2_f_17 val_inheritance2_f_18 val_inheritance2_m_17 val_inheritance2_m_18 val_inheritance3_f_17 val_inheritance3_f_18 val_inheritance3_m_17 val_inheritance3_m_18 tot_pension_f_17 tot_pension_f_18 tot_pension_m_17 tot_pension_m_18 home_equity_f_17 home_equity_f_18 home_equity_m_17 home_equity_m_18 total_wealth_equity_f_17 total_wealth_equity_f_18 total_wealth_equity_m_17 total_wealth_equity_m_18 tot_fam_income_f_17 tot_fam_income_f_18 tot_fam_income_m_17 tot_fam_income_m_18 total_wealth_equity_ff_17 total_wealth_equity_ff_18 total_wealth_equity_fm_17 total_wealth_equity_fm_18 total_wealth_equity_mf_17 total_wealth_equity_mf_18 total_wealth_equity_mm_17 total_wealth_equity_mm_18

order famidpn famidpns enter_college_19_20 enter_college_21_22 completed_college_23_24 couple_status_f_17 couple_status_f_18 couple_status_m_18 home_value_f_17 home_value_m_17 home_value_f_18 home_value_m_18 mortgage1_f_17 mortgage1_f_18 mortgage1_m_17 mortgage1_m_18 mortgage2_f_17 mortgage2_f_18 mortgage2_m_17 mortgage2_m_18 biz_farm_worth_f_17 biz_farm_worth_f_18 biz_farm_worth_m_17 biz_farm_worth_m_18 biz_farm_debt_f_17 biz_farm_debt_f_18 biz_farm_debt_m_17 biz_farm_debt_m_18 biz_farm_netval_f_17 biz_farm_netval_f_18 biz_farm_netval_m_17 biz_farm_netval_m_18 val_stocks_f_17 val_stocks_f_18 val_stocks_m_17 val_stocks_m_18 ira_annuity_f_17 ira_annuity_f_18 ira_annuity_m_17 ira_annuity_m_18 savings_f_17 savings_f_18 savings_m_17 savings_m_18 val_sl_f_17 val_sl_f_18 val_inheritance1_f_17 val_inheritance1_f_18 val_inheritance1_m_17 val_inheritance1_m_18 val_inheritance2_f_17 val_inheritance2_f_18 val_inheritance2_m_17 val_inheritance2_m_18 val_inheritance3_f_17 val_inheritance3_f_18 val_inheritance3_m_17 val_inheritance3_m_18 tot_pension_f_17 tot_pension_f_18 tot_pension_m_17 tot_pension_m_18 home_equity_f_17 home_equity_f_18 home_equity_m_17 home_equity_m_18 total_wealth_equity_f_17 total_wealth_equity_f_18 total_wealth_equity_m_17 total_wealth_equity_m_18 tot_fam_income_f_17 tot_fam_income_f_18 tot_fam_income_m_17 tot_fam_income_m_18 total_wealth_equity_ff_17 total_wealth_equity_ff_18 total_wealth_equity_fm_17 total_wealth_equity_fm_18 total_wealth_equity_mf_17 total_wealth_equity_mf_18 total_wealth_equity_mm_17 total_wealth_equity_mm_18
