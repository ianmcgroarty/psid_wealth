********************************************************************************
*Author: Jessica Kiser
*Date: 06.28.2018
*Description: This code creates descriptive stats tables and graphs for PSID 2005-2015
********************************************************************************
*program drop _all
clear all 
set more off

********************************* Setting Macros *******************************
global data "\\c1resp3\Retail_Risk_Analysis\Non_Restricted_Research\Kiser\PSID\PSID_Jessica\data" 
global raw  "$data\raw" 
global int  "$data\Intermediate" 
global output "$data\Output" 


****
use "$int/cleaned_psid_05_15.dta",clear



/*********************************************************
						SUMMARY STATS
*********************************************************/
*Herkenkoff conditions which leave us with 10,108 observations 
preserve 
	keep if age_>=24 & age_<=65
	keep if mort_flag_==1 
	keep if CLTV_<2.5


collapse (sum) mort_2_flag_ (count)famidpn  (median) pr_ mpay_ mint_  yrs_remain_ LTV_1_, by(year) 

export excel using "$output\PSID_0515_demo_mtge_summary_stats", sheet ("Herk Summ Stats_mtge") firstrow(variables) sheetreplace

restore 


****summary stats of full sample 
preserve 
	keep if age_>=24 & age_<=65
	keep if mort_flag_==1
	keep if CLTV<2.5
	
	collapse (mean) age_ male_flag_ married_flag_ divorced_flag_ less_than_HS_ HS_flag_ ///
	some_college_ college_grad_plus_ labor_inc_hd_ mpay_ m2_ refinanced_flag  /// 
	hv_ pr_ mint_ yrs_remain_ delinq_flag_ forc_flag_ months_behind_mtge_ LTV_1 ///
	unemploy_curr_hd_ unemp_prev_yr_ unemp_prev_yr_sp_ unemploy_curr_sp_ udur_ udur_sp_ welfare_hd_ welfare_sp_ ///
	savings_ value_debts_  debt_flag_ value_vehicles_ value_stock_ ira_ liq_assets_ bonds_ profit_otr_real_estate_ ///
	bus_profit_ ///
	, by(year) 
	
export excel using "$output\PSID_0515_demo_mtge_summary_stats", sheet ("Full Sample") firstrow(variables) sheetreplace
restore 


***10th  percentile 
preserve 
keep if age_>=24 & age_<=65
	keep if mort_flag_==1
	keep if CLTV<2.5
	
	collapse (p10) age_ male_flag_ married_flag_ divorced_flag_ less_than_HS_ HS_flag_ ///
	some_college_ college_grad_plus_ labor_inc_hd_ mpay_ m2_ refinanced_flag  /// 
	hv_ pr_ mint_ yrs_remain_ delinq_flag_ forc_flag_ months_behind_mtge_ LTV_1 ///
	unemploy_curr_hd_ unemp_prev_yr_ unemp_prev_yr_sp_ unemploy_curr_sp_ udur_ udur_sp_ welfare_hd_ welfare_sp_ ///
	savings_ value_debts_  debt_flag_ value_vehicles_ value_stock_ ira_ liq_assets_ bonds_ profit_otr_real_estate_ ///
	bus_profit_ ///
	, by(year) 

export excel using "$output\PSID_0515_demo_mtge_summary_stats", sheet ("10th Percentile") firstrow(variables) sheetreplace
restore 


****50th percentile 
preserve 
keep if age_>=24 & age_<=65
	keep if mort_flag_==1
	keep if CLTV<2.5
	
	collapse (p50) age_ male_flag_ married_flag_ divorced_flag_ less_than_HS_ HS_flag_ ///
	some_college_ college_grad_plus_ labor_inc_hd_ mpay_ m2_ refinanced_flag  /// 
	hv_ pr_ mint_ yrs_remain_ delinq_flag_ forc_flag_ months_behind_mtge_ LTV_1 ///
	unemploy_curr_hd_ unemp_prev_yr_ unemp_prev_yr_sp_ unemploy_curr_sp_ udur_ udur_sp_ welfare_hd_ welfare_sp_ ///
	savings_ value_debts_  debt_flag_ value_vehicles_ value_stock_ ira_ liq_assets_ bonds_ profit_otr_real_estate_ ///
	bus_profit_ ///
	, by(year) 

export excel using "$output\PSID_0515_demo_mtge_summary_stats", sheet ("50th Percentile") firstrow(variables) sheetreplace
restore 


****75th percentile 
preserve 
keep if age_>=24 & age_<=65
	keep if mort_flag_==1
	keep if CLTV<2.5
	
	collapse (p75) age_ male_flag_ married_flag_ divorced_flag_ less_than_HS_ HS_flag_ ///
	some_college_ college_grad_plus_ labor_inc_hd_ mpay_ m2_ refinanced_flag  /// 
	hv_ pr_ mint_ yrs_remain_ delinq_flag_ forc_flag_ months_behind_mtge_ LTV_1 ///
	unemploy_curr_hd_ unemp_prev_yr_ unemp_prev_yr_sp_ unemploy_curr_sp_ udur_ udur_sp_ welfare_hd_ welfare_sp_ ///
	savings_ value_debts_  debt_flag_ value_vehicles_ value_stock_ ira_ liq_assets_ bonds_ profit_otr_real_estate_ ///
	bus_profit_ ///
	, by(year) 

export excel using "$output\PSID_0515_demo_mtge_summary_stats", sheet ("75th Percentile") firstrow(variables) sheetreplace
restore 


****90th percentile 
preserve 
keep if age_>=24 & age_<=65
	keep if mort_flag_==1
	keep if CLTV<2.5
	
	collapse (p90) age_ male_flag_ married_flag_ divorced_flag_ less_than_HS_ HS_flag_ ///
	some_college_ college_grad_plus_ labor_inc_hd_ mpay_ m2_ refinanced_flag  /// 
	hv_ pr_ mint_ yrs_remain_ delinq_flag_ forc_flag_ months_behind_mtge_ LTV_1 ///
	unemploy_curr_hd_ unemp_prev_yr_ unemp_prev_yr_sp_ unemploy_curr_sp_ udur_ udur_sp_ welfare_hd_ welfare_sp_ ///
	savings_ value_debts_  debt_flag_ value_vehicles_ value_stock_ ira_ liq_assets_ bonds_ profit_otr_real_estate_ ///
	bus_profit_ ///
	, by(year) 

export excel using "$output\PSID_0515_demo_mtge_summary_stats", sheet ("90th Percentile") firstrow(variables) sheetreplace
restore 

********************************************************************************
****delinquency 
preserve 

	keep if age_>=24 & age_<=65
	keep if mort_flag_==1
	keep if CLTV<2.5
	keep if delinq_flag_==1 
	keep if year==2009|year==2011|year==2013|year==2015  //No delinquency flag for 2005, 2007
	
 	collapse (mean) age_ male_flag_ married_flag_ divorced_flag_ race_ student_ student_sp_ weeks_hospital_hd_ less_than_HS_ HS_flag_ ///
	some_college_ college_grad_plus_ wtr_any_fam_health_ins_ psych_distress_ relig_pref_hd_  mpay_ m2_ morig_ refinanced_flag  /// 
	hv_ pr_ mint_ yrs_remain_ delinq_flag_ delinq_2flag_ forc_flag_ months_behind_mtge_ LTV_1 likely_fall_beh_mtg_1_ ///
	num_jobs_ num_jobs_sp_ unemploy_curr_hd_ unemp_prev_yr_ unemp_prev_yr_sp_ unemploy_curr_sp_ udur_ udur_sp_ welfare_hd_ welfare_sp_ unemp_comp_ workers_comp_ ///
	labor_inc_hd_ total_fam_inc_ savings_ value_debts_  debt_flag_ value_vehicles_ value_stock_ ira_ liq_assets_ bonds_ otherm_ profit_otr_real_estate_ ///
	bus_profit_ ///
	, by(year) 
	
export excel using "$output\PSID_0515_demo_mtge_summary_stats", sheet ("Delinquency") firstrow(variables) sheetreplace

restore

***delinquent (10th percentile)
preserve 
keep if age_>=24 & age_<=65
	keep if mort_flag_==1
	keep if CLTV<2.5
	keep if delinq_flag_==1 
	keep if year==2009|year==2011|year==2013|year==2015  //No delinquency flag for 2005, 2007
	
	collapse (p10) age_ male_flag_ married_flag_ divorced_flag_ less_than_HS_ HS_flag_ ///
	some_college_ college_grad_plus_ labor_inc_hd_ mpay_ m2_ refinanced_flag  /// 
	hv_ pr_ mint_ yrs_remain_ delinq_flag_ forc_flag_ months_behind_mtge_ LTV_1 ///
	unemploy_curr_hd_ unemp_prev_yr_ unemp_prev_yr_sp_ unemploy_curr_sp_ udur_ udur_sp_ welfare_hd_ welfare_sp_ ///
	savings_ value_debts_  debt_flag_ value_vehicles_ value_stock_ ira_ liq_assets_ bonds_ profit_otr_real_estate_ ///
	bus_profit_ ///
	, by(year) 
	
export excel using "$output\PSID_0515_demo_mtge_summary_stats", sheet ("Delinq 10th Percentile") firstrow(variables) sheetreplace
restore

***delinquent (50th percentile)
preserve
keep if age_>=24 & age_<=65
	keep if mort_flag_==1
	keep if CLTV<2.5
	keep if delinq_flag_==1 
	keep if year==2009|year==2011|year==2013|year==2015  //No delinquency flag for 2005, 2007
	
	collapse (p50) age_ male_flag_ married_flag_ divorced_flag_ less_than_HS_ HS_flag_ ///
	some_college_ college_grad_plus_ labor_inc_hd_ mpay_ m2_ refinanced_flag  /// 
	hv_ pr_ mint_ yrs_remain_ delinq_flag_ forc_flag_ months_behind_mtge_ LTV_1 ///
	unemploy_curr_hd_ unemp_prev_yr_ unemp_prev_yr_sp_ unemploy_curr_sp_ udur_ udur_sp_ welfare_hd_ welfare_sp_ ///
	savings_ value_debts_  debt_flag_ value_vehicles_ value_stock_ ira_ liq_assets_ bonds_ profit_otr_real_estate_ ///
	bus_profit_ ///
	, by(year) 
	
export excel using "$output\PSID_0515_demo_mtge_summary_stats", sheet ("Delinq 50th Percentile") firstrow(variables) sheetreplace
restore 

****delinquent (90th percentile)
preserve
keep if age_>=24 & age_<=65
	keep if mort_flag_==1
	keep if CLTV<2.5
	keep if delinq_flag_==1 
	keep if year==2009|year==2011|year==2013|year==2015  //No delinquency flag for 2005, 2007
	
	collapse (p90) age_ male_flag_ married_flag_ divorced_flag_ less_than_HS_ HS_flag_ ///
	some_college_ college_grad_plus_ labor_inc_hd_ mpay_ m2_ refinanced_flag  /// 
	hv_ pr_ mint_ yrs_remain_ delinq_flag_ forc_flag_ months_behind_mtge_ LTV_1 ///
	unemploy_curr_hd_ unemp_prev_yr_ unemp_prev_yr_sp_ unemploy_curr_sp_ udur_ udur_sp_ welfare_hd_ welfare_sp_ ///
	savings_ value_debts_  debt_flag_ value_vehicles_ value_stock_ ira_ liq_assets_ bonds_ profit_otr_real_estate_ ///
	bus_profit_ ///
	, by(year) 
	
export excel using "$output\PSID_0515_demo_mtge_summary_stats", sheet ("Delinq 90th Percentile") firstrow(variables) sheetreplace
restore 


*****putexcel/tabstat*****

tabstat age_ male_flag_ married_flag_ divorced_flag_ less_than_HS_ HS_flag_ some_college_ college_grad_ college_grad_plus_ mort_flag_ , stat(n mean sd min max) save
return list

matrix results = r(StatTotal)'
matlist results

putexcel set "$output\PSID_0515_demo_mtge_summary_stats_3.xls", sheet(Demographics) modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt

****lots of variables
tabstat age_ male_flag_ married_flag_ black_ divorced_flag_ relig_hd_flag_ less_than_HS_ HS_flag_ some_college_ college_grad_ college_grad_plus_ weeks_hospital_hd_ distress_flag_ wtr_any_fam_health_ins_ ///
mort_ hv_ refinanced_flag_ pr_ mpay_ mint_ yrs_remain_ months_behind_mtge_ forc_flag_ m2_ move_ udur_ unemp_prev_yr_ welfare_hd_ retirement_inc_hd_ unemp_comp_ workers_comp_ labor_inc_hd_ ///
value_vehicles_ value_stock_ ira_ liq_assets_ bonds_ debt_flag_ value_debts_ num_jobs_ CLTV_ LTV_1_ , stat(n mean sd min max) save
return list

matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515_demo_mtge_summary_stats_3.xls", sheet(Variables) modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt

***spouse
tabstat weeks_hospital_sp_ udur_sp_ unemp_prev_yr_sp_ welfare_sp_ labor_inc_sp_ spouse_age_ wife_recd_inc_ student_sp_ relig_sp_flag_ unemploy_curr_sp_ , stat(n mean sd min max) save
return list

matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515_demo_mtge_summary_stats_3.xls", sheet(Variables-spouse) modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt

****sort by year 
tabstat age_ male_flag_ married_flag_ divorced_flag_ less_than_HS_ HS_flag_ some_college_ college_grad_ college_grad_plus_ mort_flag_ , stat(n mean sd min max) by(year) save
return list


matrix results = (r(Stat1) \ r(Stat2) \ r(Stat3) \ r(Stat4) \ r(Stat5) \ r(Stat6) \ r(StatTotal))
matrix list results 

putexcel set "$output\PSID_0515_demo_mtge_summary_stats_3.xls", sheet(Demographics_By_Year) modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:K1, hcenter bold border(bottom) overwritefmt


/***** look into on monday 
putexcel A1= tab mort_flag_ year
return list

*no matrix, figure out other code to use 
martix results = (r(N) \ r(r) \ r(c)) 
matrix list results

putexcel set "$output\PSID_0515_demo_mtge_summary_stats_3.xls", sheet(Have Mortgage) modify
*/


****many variables 7/9/18
tab delinq_flag_ educ_exp_
tab delinq_flag_ year


preserve 
	keep if age_>=24 & age_<=65
	keep if mort_flag_==1
	keep if CLTV<2.5
	
	collapse (mean) age_ male_flag_ married_flag_ divorced_flag_ race_ student_ student_sp_ weeks_hospital_hd_ less_than_HS_ HS_flag_ ///
	some_college_ college_grad_plus_ wtr_any_fam_health_ins_ psych_distress_ relig_pref_hd_  mpay_ m2_ morig_ refinanced_flag  /// 
	hv_ pr_ mint_ yrs_remain_ delinq_flag_ delinq_2flag_ forc_flag_ months_behind_mtge_ LTV_1 likely_fall_beh_mtg_1_ ///
	num_jobs_ num_jobs_sp_ unemploy_curr_hd_ unemp_prev_yr_ unemp_prev_yr_sp_ unemploy_curr_sp_ udur_ udur_sp_ welfare_hd_ welfare_sp_ unemp_comp_ workers_comp_ ///
	labor_inc_hd_ total_fam_inc_ savings_ value_debts_  debt_flag_ value_vehicles_ value_stock_ ira_ liq_assets_ bonds_ otherm_ profit_otr_real_estate_ ///
	bus_profit_ ///
	, by(year) 
	
export excel using "$output\PSID_0515_demo_mtge_summary_stats", sheet ("Many variables") firstrow(variables) sheetreplace
restore
*************************************GRAPHS*************************************
graph bar (mean) CLTV_, over(year) blabel(bar)
graph save "$output\CLTV_graph.gph"
graph export "$output\CLT_graph.png", replace
*****
graph export age.png, replace

putexcel set putexcel2.xlsx, sheet(example5) modify

. putexcel A1 = picture(age.png)
file putexcel2.xlsx saved

***


