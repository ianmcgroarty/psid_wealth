********************************************************************************
*Author: Jessica Kiser
*Date: 07.17.2018
*Description: This code explores the sample counterfactuals of PSID data from 2005-2015
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
use "$int/counter_psid_05_15.dta",clear //data that has ages 24-65 and people that don't have mortgages

***setting macros
local categorical i.male_flag_ i.married_flag_ i.divorced_flag_ i.educ_exp_ i.race_ 
local continuous age_ labor_inc_hd_ total_fam_inc_ 


**descriptives/ preliminary 
tabstat age_ male_flag_ married_flag_ black_ divorced_flag_ relig_hd_flag_ less_than_HS_ HS_flag_ some_college_ college_grad_ college_grad_plus_ weeks_hospital_hd_ distress_flag_ wtr_any_fam_health_ins_ ///
mort_ hv_ refinanced_flag_ pr_ mpay_ mint_ yrs_remain_ months_behind_mtge_ forc_flag_ m2_ move_ udur_ unemp_prev_yr_ welfare_hd_ retirement_inc_hd_ unemp_comp_ workers_comp_ labor_inc_hd_ ///
value_vehicles_ value_stock_ ira_ liq_assets_ bonds_ debt_flag_ value_debts_ num_jobs_ CLTV_ LTV_1_ hpi, stat(n mean sd min max) save
return list

matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515_subsets", sheet("Not delinquent non holders") modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt









*********************PRESENTATION TABLES AND GRAPHS****************************************
***demographic vars
tabstat age_ male_flag_ married_flag_ black_ divorced_flag_ relig_hd_flag_ less_than_HS_ ///
HS_flag_ some_college_ college_grad_ college_grad_plus_ wtr_any_fam_health_ins_ , stat(n mean sd min max) save
return list

matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515_presentation_final", sheet("not holders-Demo") modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt



****financieal variables
tabstat move_ udur_ unemp_prev_yr_ welfare_hd_ retirement_inc_hd_ unemp_comp_ workers_comp_ labor_inc_hd_ ///
debt_flag_ value_debts_ hpi_state , stat(n mean sd min max) save
return list

matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515_presentation_final", sheet("Non holders-Mtg") modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt

****financial vars REAL
tabstat hv_real_ refinanced_flag_ pr_real_ mpay_real_ mint_ yrs_remain_ months_behind_mtge_ forc_flag_ m2_ udur_ unemp_prev_yr_ ///
welfare_hd_ retirement_inc_hd_ unemp_comp_ workers_comp_ labor_inc_hd_real_ total_fam_inc_real_ debt_flag_ value_debts_real_ CLTV_real_ LTV_1_real_ hpi_state, stat(n mean sd min max) save
return list


matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515_subsets2", sheet("Non holders-Mtg_M2") modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt



***8/1/18 Frequencies of counter sample (non mortgage holders)  
*income
graph bar (count), over(income_levels_)
graph save Graph "$output\income_freq_full.gph", modify

*education
graph bar (count), over(educ_exp_)
graph save Graph "$output\educ_freq_full.gph", modify
graph export "$output\educ_freq_full.png", as(png) replace

*marrital status 
graph bar (count),	over(marr_status_)
graph save Graph "$output\marr_freq_full.gph", modify
graph export "$output\marr_freq_full.png", as(png) replace


















