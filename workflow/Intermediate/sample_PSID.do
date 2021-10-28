********************************************************************************
*Author: Jessica Kiser
*Date: 07.10.2018
*Description: This code explores the sample of PSID data from 2005-2015
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
use "$int/sample_psid_05_15.dta",clear //data that has ages 24-65 and people that have mortgages


***setting macros
local categorical i.male_flag_ i.married_flag_ i.divorced_flag_ i.educ_exp_ i.race_ 
local continuous age_ labor_inc_hd_ total_fam_inc_ 


******************
	preserve 
	keep if delinq_flag_==1 
	keep if year==2009|year==2011|year==2013|year==2015  //No delinquency flag for 2005, 2007
	
	count 
**1,066 people that were delinquent on mortgage for 3 or more months 
	restore
	
	preserve 
	keep if months_behind_mtge_ >1 
	count 
**29,813 people are at least month month behind on paying mortgage
	restore

*amount of people behind on mortgages for each year 
	preserve 
	keep if months_behind_mtge_ >=1
	keep if year==2009
	count 
**949 people that were delinquent on mortgage for 1 or more months in 2009 
	restore

	
preserve 
	keep if months_behind_mtge_ >=1
	keep if year==2011
	count 
**817, people that were delinquent on mortgage for 1 or more months in 2009 
	restore	


preserve 
	keep if months_behind_mtge_ >=1
	keep if year==2013
	count 
**562, people that were delinquent on mortgage for 1 or more months in 2009 
	restore	

	
preserve 
	keep if months_behind_mtge_ >=1
	keep if year==2015
	count 
**338, people that were delinquent on mortgage for 1 or more months in 2009 
	restore

	

***/Probit trials

probit delinq_flag_ udur_ `categorical' `continuous' 
margins udur_, atmeans
margins, at(udur_=(1(1)12)) vsquish post 
marginsplot


graph save "$output\delinq_graph2.gph", replace
graph export "$output\delinq_graph2.png", replace 


**probit regression with more controls 
probit delinq_flag_ i.udur_ `categorical' `continuous' 

margins, at(udur_=(1(1)12)) atmeans vsquish post 
marginsplot


graph save "$output\delinq_graph1.gph", replace
graph export "$output\delinq_graph1.png", replace 

****7/11*****
probit delinq_flag_ unemployed_1_3_m_flag_ i.male_flag_ i.married_flag_ i.divorced_flag_ i.educ_exp_ i.race_  age_ labor_inc_hd_ total_fam_inc_  year
probit delinq_flag_ unemployed_4_6_m_flag_ i.male_flag_ i.married_flag_ i.divorced_flag_ i.educ_exp_ i.race_  age_ labor_inc_hd_ total_fam_inc_  year
probit delinq_flag_ unemployed_7_9_m_flag_ i.male_flag_ i.married_flag_ i.divorced_flag_ i.educ_exp_ i.race_  age_ labor_inc_hd_ total_fam_inc_  year
probit delinq_flag_ unemployed_10_12_m_flag_ i.male_flag_ i.married_flag_ i.divorced_flag_ i.educ_exp_ i.race_  age_ labor_inc_hd_ total_fam_inc_  year

***look into why all marginal effects are around the same 
probit delinq_flag_ i.unemployed_1_3_m_flag year
margins unemployed_1_3_m_flag_


probit delinq_flag_ i.unemployed_4_6_m_flag year
margins unemployed_4_6_m_flag_


probit delinq_flag_ i.unemployed_7_9_m_flag year
margins unemployed_7_9_m_flag_


probit delinq_flag_ i.unemployed_10_12_m_flag year
margins unemployed_10_12_m_flag_

probit delinq_flag_ i.unemp_prev_yr_ year
margins unemp_prev_yr_ 

***logit trials
*****************average marginal effect****************************************
 
/*We are using our estimated model to make predictions when we
change a continuous variable by a small amount or when we change
an indicator variable from 0 to 1*/

****checking margins using OLS
logit delinq_flag_ i.unemp_prev_yr_ year age_ total_fam_inc_
margins, dydx(*)

reg delinq_flag_ i.unemp_prev_yr_ year age_ total_fam_inc_
margins, dydx(*)

****doing marginal analysis "by hand"
* Get the "small change"
qui sum udur_ 
di r(sd)/1000
*.0012198
preserve
qui logit delinq_flag_ udur_ year age total_fam_inc, nolog
* as is//e(sample) to gen predicted values only for those used to estimate the model. 
predict delinq_flag_0 if e(sample)
* Change delinquency by a bit
replace udur_ = udur_ + .0012198
predict delinq_flag_1 if e(sample)
* For each obs
gen dydx = (delinq_flag_1-delinq_flag_0)/.0012198
* Average
sum dydx
restore
**additional unit(month) of unemployment increases probability delinquency by .29%

qui logit delinq_flag_ udur_ year age total_fam_inc, nolog
margins, dydx(udur_) //get the same answer as above (long way)
*.29%

logit delinq_flag_ udur_ year age total_fam_inc i.married_ i.debt_flag_ race_ i.male_flag_, nolog
margins, dydx(udur_) //get the same answer as above (long way)
*.21%

*****unemployment probability bimonthly***** (1 unit = 1 month)

***unemployment duration is NOT compounding 
**changing "small change" to any change (2 months) 
preserve
qui logit delinq_flag_ udur_ year age total_fam_inc, nolog
predict delinq_flag_0 if e(sample)
replace udur_ = udur_ + 2
predict delinq_flag_1 if e(sample)
gen dydx = (delinq_flag_1-delinq_flag_0)/2
sum dydx
restore
*.32%
***changing "small change" to any change (4 months) 
preserve
qui logit delinq_flag_ udur_ year age total_fam_inc, nolog
predict delinq_flag_0 if e(sample)
replace udur_ = udur_ + 4
predict delinq_flag_1 if e(sample)
gen dydx = (delinq_flag_1-delinq_flag_0)/4
sum dydx
restore
*.36%
***changing "small change" to any change (6 months) 
preserve
qui logit delinq_flag_ udur_ year age total_fam_inc, nolog
predict delinq_flag_0 if e(sample)
replace udur_ = udur_ + 6
predict delinq_flag_1 if e(sample)
gen dydx = (delinq_flag_1-delinq_flag_0)/6
sum dydx
restore
*.38%
***changing "small change" to any change (8 months) 
preserve
qui logit delinq_flag_ udur_ year age total_fam_inc, nolog
predict delinq_flag_0 if e(sample)
replace udur_ = udur_ + 8
predict delinq_flag_1 if e(sample)
gen dydx = (delinq_flag_1-delinq_flag_0)/8
sum dydx
restore
*.45%
***changing "small change" to any change (10 months) 
preserve
qui logit delinq_flag_ udur_ year age total_fam_inc, nolog
predict delinq_flag_0 if e(sample)
replace udur_ = udur_ + 10
predict delinq_flag_1 if e(sample)
gen dydx = (delinq_flag_1-delinq_flag_0)/10
sum dydx
restore


***changing "small change" to any change (12 months) 
preserve
qui logit delinq_flag_ udur_ year age total_fam_inc, nolog
predict delinq_flag_0 if e(sample)
replace udur_ = udur_ + 12
predict delinq_flag_1 if e(sample)
gen dydx = (delinq_flag_1-delinq_flag_0)/12
sum dydx
restore
*.56%

**Marginal effects (dummy variable)
qui logit delinq_flag_ i.unemp_prev_yr_ year age total_fam_inc, nolog
margins, dydx(unemp_prev_yr_)
*being unemployed increases the prob of delinquency by 2.3%

logit delinq_flag_ i.unemp_prev_yr_ year age total_fam_inc i.married_ i.debt_flag_ race_ i.male_flag_, nolog
margins, dydx(unemp_prev_yr_)
*2.2%


*Predicted Margins
*With indicator variables, we can also get predictive margins (not marginal efects). Diff in predicted margins
qui logit delinq_flag_ i.unemp_prev_yr_ year age total_fam_inc, nolog
margins unemp_prev_yr_ 
*.0548304-.0221296 = .0327 which is the same as marginal effect of 3.3%
*the rarer the event the closer they are
*maybe use r. to make this easier???

*relative probabilty 
di .0548304/.0221296
*2.477695

************************MARGINAL EFFECT AT THE MEAN*****************************
qui logit delinq_flag_ udur_ year age total_fam_inc fam_inc_levels_, nolog
margins, dydx(udur_) at((mean) year age_ total_fam_inc_ fam_inc_levels_)
*.12995%

logit delinq_flag_ udur_ year age total_fam_inc i.married_ i.debt_flag_ race_ i.male_flag_, nolog
margins, dydx(udur_) at((mean) year age_ total_fam_inc_ married_ debt_flag_ race_ male_flag_)
*.11917%


margins, dydx(udur_) atmeans
*.165%

qui logit delinq_flag_ udur_ year age total_fam_inc fam_inc_levels_, nolog
margins, dydx(udur_) at(year=(2005 2007 2009 2011 2013 2015)) vsquish
marginsplot
*1.3%

/*the marginal effect of an additional month unemp (udur) on the prob 
of delinquency at different levels of income*/
qui logit delinq_flag_ udur_ year age fam_inc_levels_, nolog
margins, dydx(udur_) at(fam_inc_levels_=(1 2 3 4 5 6 7 8 9 10)) at((mean) year age_) vsquish
marginsplot

qui logit delinq_flag_ udur_ year age fam_inc_levels_ educ_exp_, nolog
margins, dydx(udur_) at(educ_exp_=(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17)) at((mean) year age_ fam_inc_levels_) vsquish
marginsplot

qui logit delinq_flag_ i.unemp_prev_yr_ year age fam_inc_levels_ educ_exp_, nolog
margins, dydx(unemp_prev_yr_) at(educ_exp_=(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17)) at((mean) year age_ fam_inc_levels_) vsquish
marginsplot

qui logit delinq_flag_ udur_ year age fam_inc_levels_ educ_exp_ CLTV_levels_, nolog
margins, dydx(udur_) at(CLTV_levels_=(2 3 4 5 6)) at((mean) year age_ fam_inc_levels_ educ_exp_) vsquish
marginsplot

qui logit delinq_flag_ i.unemp_prev_yr_ year age fam_inc_levels_ educ_exp_ CLTV_levels_, nolog
margins, dydx(unemp_prev_yr_) at(CLTV_levels_=(2 3 4 5 6)) at((mean) year age_ fam_inc_levels_ educ_exp_) vsquish
marginsplot


**Marginal effects at means (dummy variable)
qui logit delinq_flag_ i.unemp_prev_yr_ year age total_fam_inc, nolog
margins, dydx(unemp_prev_yr_) atmeans


logit delinq_flag_ i.unemp_prev_yr_ year age total_fam_inc_ i.married_ i.debt_flag_ race_ i.male_flag, nolog
margins, dydx(unemp_prev_yr_) at((mean) year age_ total_fam_inc_ married_ debt_flag_ race_ male_flag_)


****calculating the observations correctly predicted 
*Note: didn't end up using this (observations correcly predicted)
/*transform probabilities into 1/0 values. If the predicted probabilities is <0.5, 
then the observation is more likely than not to experience the event*/
qui logit delinq_flag_ i.unemp_prev_yr_ year age total_fam_inc, nolog
predict phat if e(sample)
gen hat_delinq_flag_ = 0 if phat ~= .
replace hat_delinq_flag_ = 1 if phat >= 0.5 & phat ~= .
tab delinq_flag_ hat_delinq_flag_, row col
tab delinq_flag_ hat_delinq_flag_

qui logit delinq_flag_ unemp_prev_yr_ total_fam_inc, nolog
lroc, saving(lrocm1.gph, replace)
qui logit delinq_flag_ unemp_prev_yr_ year age total_fam_inc, nolog
lroc, saving(lrocm2.gph, replace)
graph combine lrocm1.gph lrocm2.gph, xsize(15) ysize(10)
graph export "$output\predictions.png",replace



*more probit trials 
probit delinq_flag_ i.unemp_prev_yr_ i.male_flag_ i.married_flag_ i.divorced_flag_ i.educ_exp_ i.race_  age_ labor_inc_hd_ total_fam_inc_  year
margins unemp_prev_yr_, atmeans 
marginsplot

graph save "$output\delinq_graph3.gph", replace
graph export "$output\delinq_graph3.png", replace 


probit delinq_flag i.unemp_prev_yr_ total_fam_inc_ year if male_flag_ == 1 
probit delinq_flag i.unemp_prev_yr_ total_fam_inc_ year if male_flag_ == 0 
probit delinq_flag_ male_flag_ 
probit delinq_flag_ married_flag_
probit delinq_flag_ black_
probit delinq_flag_ divorced_flag_
probit delinq_flag_ female_flag_ 


********************************SUMMARY STATS*************************************
preserve 
	keep if CLTV<2.5
	
	collapse (mean) age_ male_flag_ married_flag_ divorced_flag_ race_ student_ student_sp_ weeks_hospital_hd_ less_than_HS_ HS_flag_ ///
	some_college_ college_grad_plus_ wtr_any_fam_health_ins_ psych_distress_ relig_pref_hd_  mpay_ m2_ morig_ refinanced_flag  /// 
	hv_ pr_ mint_ yrs_remain_ delinq_flag_ delinq_2flag_ forc_flag_ months_behind_mtge_ LTV_1 likely_fall_beh_mtg_1_ ///
	num_jobs_ num_jobs_sp_ unemploy_curr_hd_ unemp_prev_yr_ unemp_prev_yr_sp_ unemploy_curr_sp_ udur_ udur_sp_ welfare_hd_ welfare_sp_ unemp_comp_ workers_comp_ ///
	labor_inc_hd_ total_fam_inc_ savings_ value_debts_  debt_flag_ value_vehicles_ value_stock_ ira_ liq_assets_ bonds_ otherm_ profit_otr_real_estate_ ///
	bus_profit_ ///
	, by(year) 
	
export excel using "$output\PSID_0515_descriptives", sheet ("Many variables") firstrow(variables) sheetreplace
restore
***
preserve 
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
	
export excel using "$output\PSID_0515_descriptives", sheet ("Delinquency") firstrow(variables) sheetreplace

restore
***


*****putexcel/tabstat*****
***people that have mortgage both delinq and not delinq 
tabstat age_ male_flag_ married_flag_ black_ divorced_flag_ relig_hd_flag_ less_than_HS_ HS_flag_ some_college_ college_grad_ college_grad_plus_ weeks_hospital_hd_ distress_flag_ wtr_any_fam_health_ins_ ///
mort_ hv_ refinanced_flag_ pr_ mpay_ mint_ yrs_remain_ months_behind_mtge_ forc_flag_ m2_ move_ udur_ unemp_prev_yr_ welfare_hd_ retirement_inc_hd_ unemp_comp_ workers_comp_ labor_inc_hd_ ///
value_vehicles_ value_stock_ ira_ liq_assets_ bonds_ debt_flag_ value_debts_ num_jobs_ CLTV_ LTV_1_ hpi, stat(n mean sd min max) save
return list

matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515_subsets", sheet("All mortgage holders") modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt


****people that have mortgage and go delinquent
preserve 
	keep if delinq_flag_==1 
	keep if year==2009|year==2011|year==2013|year==2015  //No delinquency flag for 2005, 2007
	
tabstat age_ male_flag_ married_flag_ black_ divorced_flag_ relig_hd_flag_ less_than_HS_ HS_flag_ some_college_ college_grad_ college_grad_plus_ weeks_hospital_hd_ distress_flag_ wtr_any_fam_health_ins_ ///
mort_ hv_ refinanced_flag_ pr_ mpay_ mint_ yrs_remain_ months_behind_mtge_ forc_flag_ m2_ move_ udur_ unemp_prev_yr_ welfare_hd_ retirement_inc_hd_ unemp_comp_ workers_comp_ labor_inc_hd_ ///
value_vehicles_ value_stock_ ira_ liq_assets_ bonds_ debt_flag_ value_debts_ num_jobs_ CLTV_ LTV_1_ hpi, stat(n mean sd min max) save
return list

matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515_subsets", sheet("Delinquent mortgage holders") modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt

restore



****people that have mortgage & don't go delinquent 
preserve 
	keep if delinq_flag_==0 
	keep if year==2009|year==2011|year==2013|year==2015  //No delinquency flag for 2005, 2007
	
tabstat age_ male_flag_ married_flag_ black_ divorced_flag_ relig_hd_flag_ less_than_HS_ HS_flag_ some_college_ college_grad_ college_grad_plus_ weeks_hospital_hd_ distress_flag_ wtr_any_fam_health_ins_ ///
mort_ hv_ refinanced_flag_ pr_ mpay_ mint_ yrs_remain_ months_behind_mtge_ forc_flag_ m2_ move_ udur_ unemp_prev_yr_ welfare_hd_ retirement_inc_hd_ unemp_comp_ workers_comp_ labor_inc_hd_ ///
value_vehicles_ value_stock_ ira_ liq_assets_ bonds_ debt_flag_ value_debts_ num_jobs_ CLTV_ LTV_1_ hpi, stat(n mean sd min max) save
return list

matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515_subsets", sheet("Not delinquent holders") modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt

restore 



****sort by year 
tabstat age_ male_flag_ married_flag_ black_ divorced_flag_ less_than_HS_ HS_flag_ some_college_ college_grad_ college_grad_plus_ m2_ , stat(n mean sd min max) by(year) save
return list


matrix results = (r(Stat1) \ r(Stat2) \ r(Stat3) \ r(Stat4) \ r(Stat5) \ r(Stat6) \ r(StatTotal))
matrix list results 

putexcel set "$output\PSID_0515_descriptives", sheet(Demographics_By_Year) modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:L1, hcenter bold border(bottom) overwritefmt

****spouse
tabstat weeks_hospital_sp_ udur_sp_ unemp_prev_yr_sp_ welfare_sp_ labor_inc_sp_ spouse_age_ wife_recd_inc_ student_sp_ relig_sp_flag_ unemploy_curr_sp_ , stat(n mean sd min max) save
return list

matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515_descriptives", sheet(Variables-spouse) modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt


*****GRAPHS******

graph bar (mean) CLTV_, over(year) blabel(bar)
graph save "$output\CLTV_graph.gph", replace
graph export "$output\CLT_graph.png", replace

*****
***********************************************************************************
**********************PRESENTATION TABLES AND GRAPHS*****************************
************************************************************************************
*same as above just fined

***people that have mortgage both delinq and not delinq (demographics) 
tabstat age_ male_flag_ married_flag_ black_ divorced_flag_ relig_hd_flag_ less_than_HS_ ///
HS_flag_ some_college_ college_grad_ college_grad_plus_ wtr_any_fam_health_ins_, stat(n mean sd min max) save
return list

matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515_presentation_final", sheet("All mortg holders Demo") modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt

*****income and mortgage 
tabstat hv_ refinanced_flag_ pr_ mpay_ mint_ yrs_remain_ months_behind_mtge_ forc_flag_ m2_ udur_ unemp_prev_yr_ ///
welfare_hd_ retirement_inc_hd_ unemp_comp_ workers_comp_ labor_inc_hd_ total_fam_inc_ debt_flag_ value_debts_ CLTV_ LTV_1_ hpi_state, stat(n mean sd min max) save
return list

matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515_presentation_final", sheet("All mortg holders Income") modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt


*just delinquency
tabstat delinq_flag_, stat(n mean sd min max) save
return list

matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515_presentation_final", sheet("delinquency") modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt

****REAL
****income and mortgage 
tabstat hv_real_ refinanced_flag_ pr_real_ mpay_real_ mint_ yrs_remain_ months_behind_mtge_ forc_flag_ m2_ udur_ unemp_prev_yr_ ///
welfare_hd_ retirement_inc_hd_ unemp_comp_ workers_comp_ labor_inc_hd_real_ total_fam_inc_real_ debt_flag_ value_debts_real_ CLTV_real_ LTV_1_real_ hpi_state, stat(n mean sd min max) save
return list

matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515__subsets2", sheet("All mortg holders Income2") modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt


****people that have mortgage and go delinquent
preserve 
	keep if delinq_flag_==1 
	keep if year==2009|year==2011|year==2013|year==2015  //No delinquency flag for 2005, 2007
	
tabstat age_ male_flag_ married_flag_ black_ divorced_flag_ relig_hd_flag_ less_than_HS_ ///
HS_flag_ some_college_ college_grad_ college_grad_plus_ wtr_any_fam_health_ins_ , stat(n mean sd min max) save
return list

matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515_presentation_final", sheet("Delinquent mortgage holders") modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt

restore



****people that have mortgage & don't go delinquent 
preserve 
	keep if delinq_flag_==0 
	keep if year==2009|year==2011|year==2013|year==2015  //No delinquency flag for 2005, 2007
	
tabstat age_ male_flag_ married_flag_ black_ divorced_flag_ relig_hd_flag_ less_than_HS_ HS_flag_ ///
some_college_ college_grad_ college_grad_plus_ wtr_any_fam_health_ins_ , stat(n mean sd min max) save
return list

matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515_presentation_final", sheet("Not delinquent holders") modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt

restore 


******Mortgage Vars



*REAL values
****people that have mortgage and go delinquent-M
preserve 
	keep if delinq_flag_==1 
	keep if year==2009|year==2011|year==2013|year==2015  //No delinquency flag for 2005, 2007
	
tabstat hv_real_ refinanced_flag_ pr_real_ mpay_real_ mint_ yrs_remain_ months_behind_mtge_ forc_flag_ m2_ udur_ unemp_prev_yr_ ///
welfare_hd_ retirement_inc_hd_ unemp_comp_ workers_comp_ labor_inc_hd_real_ total_fam_inc_real_ debt_flag_ value_debts_real_ CLTV_real_ LTV_1_real_ hpi_state, stat(n mean sd min max) save
return list

matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515_subsets2", sheet("Delinq mtge holders-M2") modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt

restore


*REAL values
****people that have mortgage & don't go delinquent 
preserve 
	keep if delinq_flag_==0 
	keep if year==2009|year==2011|year==2013|year==2015  //No delinquency flag for 2005, 2007
	
tabstat hv_real_ refinanced_flag_ pr_real_ mpay_real_ mint_ yrs_remain_ months_behind_mtge_ forc_flag_ m2_ udur_ unemp_prev_yr_ ///
welfare_hd_ retirement_inc_hd_ unemp_comp_ workers_comp_ labor_inc_hd_real_ total_fam_inc_real_ debt_flag_ value_debts_real_ CLTV_real_ LTV_1_real_ hpi_state, stat(n mean sd min max) save
return list

matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515_subsets2", sheet("Not delinq mtg holders-M2") modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt

restore 

***************




*10th
preserve 
	
	collapse (p10) labor_inc_hd_ total_fam_inc_ LTV_1 hpi_state ///
	, by(year) 

export excel using "$output\PSID_0515_presentation1", sheet ("10th Percentile") firstrow(variables) sheetreplace
restore 

*90th
preserve 
	
	collapse (p90) labor_inc_hd_ total_fam_inc_ LTV_1 hpi_state ///
	, by(year) 

export excel using "$output\PSID_0515_presentation1", sheet ("90th Percentile") firstrow(variables) sheetreplace
restore 

*50th 
preserve 
	
	collapse (p50) labor_inc_hd_ total_fam_inc_ LTV_1 hpi_state ///
	, by(year) 

export excel using "$output\PSID_0515_presentation1", sheet ("50th Percentile") firstrow(variables) sheetreplace
restore 


****not by year 
*REAL values
*10th
preserve 
	
	collapse (p10) labor_inc_hd_real_ total_fam_inc_real_ LTV_1_real_ hpi_state 

export excel using "$output\PSID_0515_presentation_final", sheet ("10th P-Not year") firstrow(variables) sheetreplace
restore 

*90th
preserve 
	
	collapse (p90) labor_inc_hd_real_ total_fam_inc_real_ LTV_1_real_ hpi_state

export excel using "$output\PSID_0515_presentation_final", sheet ("90th P-Not year") firstrow(variables) sheetreplace
restore 

*50th 
preserve 
	
	collapse (p50) labor_inc_hd_real_ total_fam_inc_real_ LTV_1_real_ hpi_state 

export excel using "$output\PSID_0515_presentation_final", sheet ("50th P-Not year") firstrow(variables) sheetreplace
restore 


************





*25th
preserve 
	
	collapse (p25) married_flag_ labor_inc_hd_ total_fam_inc_ LTV_1 hpi ///
	, by(year) 

export excel using "$output\PSID_0515_presentation1", sheet ("25th Percentile") firstrow(variables) sheetreplace
restore 


*75th
preserve 
	
	collapse (p75) married_flag_ labor_inc_hd_ total_fam_inc_ LTV_1 hpi ///
	, by(year) 

export excel using "$output\PSID_0515_presentation1", sheet ("75th Percentile") firstrow(variables) sheetreplace
restore 

**********Margins *************

**average marginal effects
logit delinq_flag_ udur_ year age_ educ_exp_ total_fam_inc_real_ i.married_ i.debt_flag_ i.race_ i.male_flag_, nolog
margins, dydx(udur_)
*.21841%
*In effect, you are comparing two hypothetical populations –one all white, one all black –that have the exact same values on the other independent variables in the model.

**average marginal effects
logit delinq_flag_ i.unemp_prev_yr_ year age_ educ_exp_ total_fam_inc_real_ i.married_ i.debt_flag_ i.race_ i.male_flag_, nolog
margins, dydx(unemp_prev_yr_)
*2.31529%

** marginal effect at means
logit delinq_flag_ udur_ year age_ educ_exp_ total_fam_inc_real_ i.married_ i.debt_flag_ value_debts_real_ i.race_ i.male_flag_ liq_assets_real_, nolog
margins, dydx(udur_) at((mean) year age_ educ_exp_ total_fam_inc_real_ married_ debt_flag_ race_ male_flag_)
*.1279%

**marginal effect at means
logit delinq_flag_ i.unemp_prev_yr_ year age_ educ_exp_ total_fam_inc_real labor_inc_hd_real_ i.marr_status_ value_debts_real_ i.race_ i.male_flag liq_assets_real_ num_children  LTV_1_real_, nolog
margins, dydx(unemp_prev_yr_) at((mean) year age_ educ_exp_ total_fam_inc_real_ labor_inc_hd_real_ marr_status_ value_debts_real_ race_ male_flag_ liq_assets_real_ num_children_ LTV_1_real_ )
*.98 percentage points
*if you had two otherwise-average individuals, unemp prev yr, not not, the unemp probability of delinquency would be 1.3 percentage points higher


**adjusted predictions (basic graph used in presentation)
logit delinq_flag_ i.unemp_prev_yr_ year age_ educ_exp_ total_fam_inc_real labor_inc_hd_real_ marr_status_ value_debts_real_ i.race_ i.male_flag liq_assets_real_ num_children  LTV_1_real_, nolog
margins unemp_prev_yr_, atmeans
marginsplot
*why dydx, but good graph 
*.99 percentage 


****interaction logit's
logit delinq_flag_ i.unemp_prev_yr_ year age_ educ_exp_ total_fam_inc_real labor_inc_hd_real_ i.marr_status_ value_debts_real_ i.race_ i.male_flag liq_assets_real_ num_children  LTV_1_real_, nolog
margins, dydx(race_ male_flag_) at((mean) unemp_prev_yr_ year age_ educ_exp_ total_fam_inc_real_ labor_inc_hd_real_ marr_status_ value_debts_real_ liq_assets_real_ num_children_ LTV_1_real_ )
*.99 per

logit delinq_flag_ i.unemp_prev_yr_ year age_ educ_exp_ total_fam_inc_real labor_inc_hd_real_ i.marr_status_ value_debts_real_ i.race_ i.male_flag liq_assets_real_ num_children  LTV_1_real_ i.unemp_prev_yr_#c.age_, nolog
margins unemp_prev_yr_#male_flag_, at(age=(25 35 45 55 65)) at((mean) year educ_exp_ total_fam_inc_real_ labor_inc_hd_real_ marr_status_ value_debts_real_ liq_assets_real_ num_children_ LTV_1_real_ race_) vsquish
marginsplot

logit delinq_flag_ i.male_flag_ i.black_flag_ i.unemp_prev_yr_ year age_ educ_exp_ total_fam_inc_real labor_inc_hd_real_ i.marr_status_ value_debts_real_ liq_assets_real_ num_children  LTV_1_real_ i.male_flag_#c.age_, nolog
margins male_flag_#black_flag_, at(age=(25 35 45 55 65)) at((mean) unemp_prev_yr_ year educ_exp_ total_fam_inc_real_ labor_inc_hd_real_ marr_status_ value_debts_real_ liq_assets_real_ num_children_ LTV_1_real_) vsquish
marginsplot



*******AT*****************
*CLTV levels/one line
qui logit delinq_flag_ i.unemp_prev_yr_ CLTV_levels i.male_flag_ i.married_flag_ i.divorced_flag_ i.educ_exp_ i.race_  age_ labor_inc_hd_ total_fam_inc_  year value_debts_, nolog
qui margins, dydx(unemp_prev_yr_) at(CLTV_levels_=(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)) at((mean) year age_ total_fam_inc_ educ_exp_ male_flag_ married_flag_ divorced_flag_ value_debts_) vsquish
marginsplot

*CLTV/ 2 lines
qui logit delinq_flag_ i.unemp_prev_yr_ CLTV_levels i.male_flag_ i.married_flag_ i.divorced_flag_ i.educ_exp_ i.race_  age_ labor_inc_hd_ total_fam_inc_ value_debts_ year, nolog
qui margins unemp_prev_yr_, at(CLTV_levels_=(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)) at((mean) year age_ total_fam_inc_ educ_exp_ male_flag_ married_flag_ divorced_flag_ value_debts_ ) vsquish
marginsplot

*LTV/ 2 lines
qui logit delinq_flag_ i.unemp_prev_yr_ LTV_levels i.male_flag_ i.married_flag_ i.divorced_flag_ i.educ_exp_ i.race_  age_ labor_inc_hd_ total_fam_inc_ value_debts_ year, nolog
qui margins unemp_prev_yr_, at(LTV_levels_=(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16)) at((mean) year age_ total_fam_inc_ educ_exp_ male_flag_ married_flag_ divorced_flag_ value_debts_ ) vsquish
marginsplot

*LTV/ 1 line
qui logit delinq_flag_ i.unemp_prev_yr_ LTV_levels i.male_flag_ i.married_flag_ i.divorced_flag_ i.educ_exp_ i.race_  age_ labor_inc_hd_ total_fam_inc_ value_debts_ year, nolog
qui margins, dydx(unemp_prev_yr_) at(LTV_levels_=(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16)) at((mean) year age_ total_fam_inc_ educ_exp_ male_flag_ married_flag_ divorced_flag_ value_debts_ ) vsquish
marginsplot

*LTV 2 lines / REAL
qui logit delinq_flag_ i.unemp_prev_yr_  LTV_levels_real_ year age_ educ_exp_ total_fam_inc_real labor_inc_hd_real_ i.marr_status_ value_debts_real_ i.race_ i.male_flag liq_assets_real_ num_children_, nolog
margins unemp_prev_yr_, at(LTV_levels_=(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16)) at((mean) year age_ race_ total_fam_inc_real_ labor_inc_hd_real_ educ_exp_ male_flag_ marr_status_ value_debts_real_ num_children_ liq_assets_real_) vsquish
marginsplot

*race / 1 line
qui logit delinq_flag_ i.unemp_prev_yr_ LTV_levels i.male_flag_ i.married_flag_ i.divorced_flag_ i.educ_exp_ i.race_  age_ labor_inc_hd_ total_fam_inc_ CLTV_levels value_debts_ year, nolog
margins, dydx(unemp_prev_yr_) at(race_=(1 2 3)) at((mean) year age_ total_fam_inc_ educ_exp_ male_flag_ married_flag_ divorced_flag_ LTV_levels value_debts_) vsquish
marginsplot

*race/ 2 lines
qui logit delinq_flag_ i.unemp_prev_yr_ CLTV_levels i.male_flag_ i.married_flag_ i.divorced_flag_ i.educ_exp_ i.race_  age_ labor_inc_hd_ total_fam_inc_ LTV_levels year value_debts_ , nolog
qui margins unemp_prev_yr_, at(race_=(1 2 3)) at((mean) year age_ total_fam_inc_ educ_exp_ male_flag_ married_flag_ divorced_flag_ LTV_levels value_debts_) vsquish
marginsplot

*race/ interation
qui logit delinq_flag_ i.unemp_prev_yr_ CLTV_levels i.male_flag_ i.married_flag_ i.divorced_flag_ i.educ_exp_ i.race_  age_ labor_inc_hd_ total_fam_inc_ LTV_levels year value_debts_ , nolog
qui margins unemp_prev_yr_#race_, at((mean) year age_ total_fam_inc_ educ_exp_ male_flag_ married_flag_ divorced_flag_ LTV_levels value_debts_) vsquish
marginsplot

*race/ interaction / REAL 
qui logit delinq_flag_ i.unemp_prev_yr_  LTV_levels_real_ year age_ educ_exp_ total_fam_inc_real labor_inc_hd_real_ i.marr_status_ value_debts_real_ i.race_ i.male_flag liq_assets_real_ num_children_, nolog
margins unemp_prev_yr_#race_, at((mean) year age_ total_fam_inc_real_ labor_inc_hd_real_ educ_exp_ male_flag_ marr_status_ value_debts_real_ num_children_ liq_assets_real_ LTV_levels_real_) vsquish
marginsplot

*educ/ 1 line
logit delinq_flag_ i.unemp_prev_yr_ i.male_flag_ i.married_flag_ i.divorced_flag_ i.educ_exp_ i.race_  age_ labor_inc_hd_ total_fam_inc_ LTV_levels value_debts_ year
margins, dydx(unemp_prev_yr_) at(educ_exp=( 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17)) at((mean) year age_ total_fam_inc_ race_ male_flag_ married_flag_ divorced_flag_ LTV_levels labor_inc_hd value_debts_) vsquish
marginsplot

*educ/ 2 lines 
logit delinq_flag_ i.unemp_prev_yr_ i.male_flag_ i.married_flag_ i.divorced_flag_ i.educ_exp_ i.race_  age_ labor_inc_hd_ total_fam_inc_ LTV_levels year value_debts_
margins unemp_prev_yr_, at(educ_exp=( 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17)) at((mean) year age_ total_fam_inc_ race_ male_flag_ married_flag_ divorced_flag_ LTV_levels labor_inc_hd value_debts_) vsquish
marginsplot  

*educ 5 levels / 2 lines 
logit delinq_flag_ i.unemp_prev_yr_ i.male_flag_ i.married_flag_ i.divorced_flag_ i.educ_ i.race_  age_ labor_inc_hd_ total_fam_inc_ LTV_levels year value_debts_
margins unemp_prev_yr_, at(educ_=(0 1 2 3 4 )) at((mean) year age_ total_fam_inc_ race_ male_flag_ married_flag_ divorced_flag_ LTV_levels labor_inc_hd value_debts_) vsquish
marginsplot  

*educ 2 levels / 2 lines

logit delinq_flag_ i.unemp_prev_yr_ i.male_flag_ i.married_flag_ i.divorced_flag_ i.educ_2levels i.race_  age_ labor_inc_hd_ total_fam_inc_ LTV_levels year value_debts_
margins unemp_prev_yr_, at(educ_2levels=(0 1)) at((mean) year age_ total_fam_inc_ race_ male_flag_ married_flag_ divorced_flag_ LTV_levels labor_inc_hd value_debts_) vsquish
marginsplot  


*income / 1 line
logit delinq_flag_ i.unemp_prev_yr_ income_levels_ i.male_flag_ i.married_flag_ i.divorced_flag_ i.educ_exp_ i.race_ age_ LTV_levels year value_debts_
margins, dydx(unemp_prev_yr_) at(income_levels_=( 1 2 3 4 5)) at((mean) year age_  race_ male_flag_ married_flag_ divorced_flag_ LTV_levels educ_exp_ value_debts_) vsquish
marginsplot

*income/ 2 lines
logit delinq_flag_ i.unemp_prev_yr_ income_levels_ i.male_flag_ i.married_flag_ i.divorced_flag_ i.educ_exp_ i.race_ age_ LTV_levels year value_debts_
margins unemp_prev_yr_, at(income_levels_=( 1 2 3 4 5)) at((mean) year age_  race_ male_flag_ married_flag_ divorced_flag_ LTV_levels educ_exp_ value_debts_) vsquish
marginsplot

*income / 2 lines/ REAL 
logit delinq_flag_ i.unemp_prev_yr_ i.income_levels_real_ LTV_1_real_ year age_ educ_exp_ i.marr_status_ value_debts_real_ i.race_ i.male_flag liq_assets_real_ num_children_, nolog
margins unemp_prev_yr_, at(income_levels_=( 1 2 3 4 5)) at((mean) year age_ race_ LTV_1_real_ educ_exp_ male_flag_ marr_status_ value_debts_real_ num_children_ liq_assets_real_) vsquish
marginsplot

*income 1 line/ REAL 
logit delinq_flag_ i.unemp_prev_yr_ i.income_levels_real_ LTV_1_real_ year age_ educ_exp_ i.marr_status_ value_debts_real_ i.race_ i.male_flag liq_assets_real_ num_children_, nolog
margins, dydx(unemp_prev_yr_) at(income_levels_ = (1 2 3 4 5)) at((mean) year age_ race_ LTV_1_real_ educ_exp_ male_flag_ marr_status_ value_debts_real_ num_children_ liq_assets_real_) vsquish
marginsplot


*gender interaction/ 2 lines
qui logit delinq_flag_ i.unemp_prev_yr_ LTV_levels i.male_flag_ i.married_flag_ i.divorced_flag_ i.educ_exp_ i.race_  age_ labor_inc_hd_ total_fam_inc_ value_debts_ year, nolog
qui margins unemp_prev_yr_#male_flag_, at((mean) year age_ total_fam_inc_ educ_exp_  married_flag_ divorced_flag_ value_debts_ race_ LTV_levels) vsquish
marginsplot

*gender interaction/ 2 lines / REAL 
qui logit delinq_flag_ i.unemp_prev_yr_ i.male_flag_ LTV_levels_real_ year age_ educ_exp_ total_fam_inc_real labor_inc_hd_real_ i.marr_status_ value_debts_real_ i.race_ liq_assets_real_ num_children_, nolog
margins unemp_prev_yr_#male_flag_, at((mean) LTV_levels_real_ year age_ educ_exp_ total_fam_inc_real labor_inc_hd_real_ marr_status_ value_debts_real_ race_ liq_assets_real_ num_children_) vsquish
marginsplot

*gender/ 1 line
logit delinq_flag_ i.unemp_prev_yr_ total_fam_inc_ i.male_flag_ i.married_flag_ i.divorced_flag_ i.educ_exp_ i.race_ age_ LTV_levels year value_debts_
margins, dydx(unemp_prev_yr_) at(male_flag_ = (0 1)) at((mean) year age_  race_  married_flag_ divorced_flag_ LTV_levels educ_exp_ total_fam_inc_ value_debts_) vsquish
marginsplot

*gender/ 2 lines
logit delinq_flag_ i.unemp_prev_yr_ total_fam_inc_ i.male_flag_ i.married_flag_ i.divorced_flag_ i.educ_exp_ i.race_ age_ LTV_levels year value_debts_
margins unemp_prev_yr_, at(male_flag_ = (0 1)) at((mean) year age_  race_  married_flag_ divorced_flag_ LTV_levels educ_exp_ total_fam_inc_ value_debts_) vsquish
marginsplot

*married/ 1 line
logit delinq_flag_ i.unemp_prev_yr_ total_fam_inc_ i.male_flag_ i.married_flag_ i.educ_exp_ i.race_ age_ LTV_levels year value_debts_
margins, dydx(unemp_prev_yr_) at(married_flag_ = (0 1)) at((mean) year age_  race_ male_flag_  LTV_levels educ_exp_ total_fam_inc_ value_debts_) vsquish
marginsplot

*married/ 2 line
logit delinq_flag_ i.unemp_prev_yr_ total_fam_inc_ i.male_flag_ i.married_flag_ i.educ_exp_ i.race_ age_ LTV_levels year value_debts_
margins unemp_prev_yr_, at(married_flag_ = (0 1)) at((mean) year age_  race_ male_flag_  LTV_levels educ_exp_ total_fam_inc_ value_debts_) vsquish
marginsplot

*married&divorced/ interaction
logit delinq_flag_ i.unemp_prev_yr_ total_fam_inc_ i.male_flag_ i.wtr_marr_div_ i.educ_exp_ i.race_ age_ LTV_levels year value_debts_
margins unemp_prev_yr_#wtr_marr_div_, at((mean) year age_  race_ male_flag_  LTV_levels educ_exp_ total_fam_inc_ value_debts_) vsquish
marginsplot

*******************************GRAPHS*****************************************
*******************************************************************************
*mortgage holders frequencies
graph bar (count), over(income_levels_)
graph save Graph "$output\income_freq_.gph", modify

graph bar (count), over(educ_exp_)
graph save Graph "$output\educ_freq.gph", modify
graph export "$output\educ_freq.png", as(png) replace


graph bar (count),	over(marr_status_)
graph save Graph "$output\educ_freq.gph", modify


***delinquent and not delinquent frequency graphs***
*marrital status
graph bar if delinq_flag_==1, over(marr_status_, relabel (1 "Married" 2 "Never Married" 3 "Widowed" 4 "Divorced" 5 "Seperated")) ylabel(0(20)80) name(delinquent, replace)
graph bar if delinq_flag_==0, over(marr_status_, relabel (1 "Married" 2 "Never Married" 3 "Widowed" 4 "Divorced" 5 "Seperated")) ylabel(0(20)80) name(not_delinquent, replace)
graph combine delinquent not_delinquent, name(combined, replace)

graph save combined "$output\combined_marr_status.gph", replace
graph export "output\comibed_marr_status.png", as(png) replace

*education 
recode educ_exp_ (0/1=.)
graph line if delinq_flag_==1, over(educ_exp_) name(delinquent_educ, replace)
graph line if delinq_flag_==0, over(educ_exp_)  name(not_delinquent_educ, replace)
graph combine delinquent_educ not_delinquent_educ, ycommon xcommon name(combined_educ, replace)

graph save combined "$output\combined_educ.gph", replace
graph export "output\cominbed_educ.png", as(png) replace


*race 
graph bar if delinq_flag_==1, over(race_, relabel(1 White 2 Black 3 Other)) name(delinquent_race, replace)
graph bar if delinq_flag_==0, over(race_, relabel(1 White 2 Black 3 Other)) name(not_delinquent_race, replace)
graph combine delinquent_race not_delinquent_race, ycommon name(combined_race, replace)

graph save combined "$output\combined_race.gph", replace
graph export "output\cominbed_race.png", as(png) replace

graph bar if delinq_flag_== 1 & if delinq_flag_==0 , over(race_)

*gender 
graph bar if delinq_flag_==1, over(sex_, relabel(1 Male 2 Female)) name(delinquent_gender, replace)
graph bar if delinq_flag_==0, over(sex_, relabel(1 White 2 Female)) name(not_delinquent_gender, replace)
graph combine delinquent_gender not_delinquent_gender, ycommon name(combined_gender, replace)

graph save combined "$output\combined_gender.gph", replace
graph export "output\cominbed_gender.png", as(png) replace

*income levels
graph bar if delinq_flag_==1, over(income_levels_, relabel( 1 "0-50K" 2 "50K-100K" 3 "100K-150K" 4 "150K-200K" 5 ">200K")) name(delinquent_income, replace)
graph bar if delinq_flag_==0, over(income_levels_, relabel( 1 "0-50K" 2 "50K-100K" 3 "100K-150K" 4 "150K-200K" 5 ">200K")) name(not_delinquent_income, replace)
graph combine delinquent_income not_delinquent_income, ycommon name(combined_income, replace)

graph save combined "$output\combined_income.gph", replace
graph export "output\cominbed_income.png", as(png) replace

*income levels REAL
graph bar if delinq_flag_==1, over(income_levels_real_, relabel( 1 "0-50K" 2 "50K-100K" 3 "100K-150K" 4 "150K-200K" 5 ">200K")) name(delinquent_income, replace)
graph bar if delinq_flag_==0, over(income_levels_real_, relabel( 1 "0-50K" 2 "50K-100K" 3 "100K-150K" 4 "150K-200K" 5 ">200K")) name(not_delinquent_income, replace)
graph combine delinquent_income not_delinquent_income, ycommon name(combined_income, replace)

**by year
preserve 
keep if year==2009|year==2011|year==2013|year==2015  //No delinquency flag for 2005, 2007
graph bar (mean) delinq_flag_ , over(year) name(deliq_yearly, replace)
restore 

**changes in HPI for each state
bysort fips_state (year): tab hpi
*what is happening to the marginal increase over the years?
	
twoway (line hpi year, lcolor(red) lwidth(vvthin) lpattern(solid) connect(direct)), ttitle(, size(medium) margin(medium)) tscale(lwidth(vthin) lpattern(solid) line) xla(2005(2)2015)	
	
xtline hpi, t(year) i(fips_state) overlay 

	
*hpi growth rate 
preserve
  sort state_ year  
  quietly by state_ year: gen dup = cond(_N==1,0,_n)
  drop if dup>1
  
 bysort state_ (year): tab hpi 
 
 ***one to use
 bysort state_ (year) : gen hpi_change = (hpi[_n]-hpi[_n-1])/ hpi[_n-1]
 
 bysort state_ (year): tab hpi_change


****more logit estimation
	
**marginal effect at means// not sure about this yet, suspicious results
logit delinq_flag_ i.hpi_inc year age_ educ_exp_ total_fam_inc_ i.married_ i.debt_flag_ race_ i.male_flag, nolog
margins, dydx(hpi_inc) at((mean) year age_ educ_exp_ total_fam_inc_ married_ debt_flag_ race_ male_flag_)
*.715 percentage points less likely 
marginsplot

logit delinq_flag_ i.hpi_dec year age_ educ_exp_ total_fam_inc_ i.married_ i.debt_flag_ race_ i.male_flag, nolog
margins, dydx(hpi_dec) at((mean) year age_ educ_exp_ total_fam_inc_ married_ debt_flag_ race_ male_flag_)

restore 


logit delinq_flag_ i.male_flag educ_exp_ year age_ i.unemp_prev_yr_ total_fam_inc_ i.married_ i.debt_flag_ race_ , nolog
margins, dydx(male_flag_) at((mean) year age_ educ_exp_ total_fam_inc_ married_ debt_flag_ race_ unemp_prev_yr_)
*-.2806 percentage points, so females are more likely to go delinquent 



logit delinq_flag_ i.male_flag educ_exp_ year age_ i.unemp_prev_yr_ total_fam_inc_ i.married_flag_ i.debt_flag_ race_ , nolog
margins, dydx(married_flag_) at((mean) year age_ educ_exp_ total_fam_inc_ debt_flag_ race_ unemp_prev_yr_)
*-.05102 percentage points, so unmarried are more likely to go delinquent 
*but not statistically significant 


********** subgroups with and without mortgages**************
 

*white women
preserve 
	keep if male_flag_ == 0 
	keep if race_ == 1 
	
tabstat delinq_flag_ married_flag_ educ_exp_ refinanced_flag_ months_behind_mtge_ forc_flag_ udur_ unemp_prev_yr_ welfare_hd_ retirement_inc_hd_ unemp_comp_ workers_comp_ labor_inc_hd_ total_fam_inc_ ///
debt_flag_ value_debts_ , stat(n mean sd min max) save
return list

matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515_subsets1", sheet("White Women") modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt

restore 

***
*black women
preserve 
	keep if male_flag_ == 0 
	keep if race_ == 2 
	
tabstat delinq_flag_ married_flag_ educ_exp_ refinanced_flag_ months_behind_mtge_ forc_flag_ udur_ unemp_prev_yr_ welfare_hd_ retirement_inc_hd_ unemp_comp_ workers_comp_ labor_inc_hd_real_ total_fam_inc_real_ ///
debt_flag_ value_debts_real_ , stat(n mean sd min max) save
return list

matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515_subsets1", sheet("Black Women") modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt

restore 

***
*white men 
preserve 
	keep if male_flag_ == 1
	keep if race_ == 1 
	
tabstat delinq_flag_ married_flag_ educ_exp_ refinanced_flag_ months_behind_mtge_ forc_flag_ udur_ unemp_prev_yr_ welfare_hd_ retirement_inc_hd_ unemp_comp_ workers_comp_ labor_inc_hd_real_ total_fam_inc_real_ ///
debt_flag_ value_debts_real_ , stat(n mean sd min max) save
return list

matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515_subsets1", sheet("White Men") modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt

restore 

***
*black men
preserve 
	keep if male_flag_ == 1
	keep if race_ == 2 
	
tabstat delinq_flag_ married_flag_ educ_exp_ refinanced_flag_ months_behind_mtge_ forc_flag_ udur_ unemp_prev_yr_ welfare_hd_ retirement_inc_hd_ unemp_comp_ workers_comp_ labor_inc_hd_real_ total_fam_inc_real_ ///
debt_flag_ value_debts_real_ , stat(n mean sd min max) save
return list

matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515_subsets1", sheet("Black Men") modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt

restore 

***
*college educated men
preserve 
	keep if male_flag_ == 1
	keep if educ_2levels == 1
	
tabstat delinq_flag_ married_flag_ educ_exp_ refinanced_flag_ months_behind_mtge_ forc_flag_ udur_ unemp_prev_yr_ welfare_hd_ retirement_inc_hd_ unemp_comp_ workers_comp_ labor_inc_hd_real_ total_fam_inc_real_ ///
debt_flag_ value_debts_real_ , stat(n mean sd min max) save
return list

matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515_subsets1", sheet("College Educated Men") modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt

restore
 
***
*college educated women
preserve 
	keep if male_flag_ == 0
	keep if educ_2levels == 1
	
tabstat delinq_flag_ married_flag_ educ_exp_ refinanced_flag_ months_behind_mtge_ forc_flag_ udur_ unemp_prev_yr_ welfare_hd_ retirement_inc_hd_ unemp_comp_ workers_comp_ labor_inc_hd_real_ total_fam_inc_real_ ///
debt_flag_ value_debts_real_ , stat(n mean sd min max) save
return list

matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515_subsets1", sheet("College Educated Women") modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt

restore 

***
*College educated white women
preserve 
	keep if male_flag_ == 0
	keep if educ_2levels == 1
	keep if race_ == 1
	
tabstat delinq_flag_ married_flag_ educ_exp_ refinanced_flag_ months_behind_mtge_ forc_flag_ udur_ unemp_prev_yr_ welfare_hd_ retirement_inc_hd_ unemp_comp_ workers_comp_ labor_inc_hd_real_ total_fam_inc_real_ ///
debt_flag_ value_debts_real_ , stat(n mean sd min max) save
return list

matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515_subsets1", sheet("College Educ White Women") modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt
restore

***
* College educated black women 
preserve 
	keep if male_flag_ == 0
	keep if educ_2levels == 1
	keep if race_ == 2
	
tabstat delinq_flag_ married_flag_ educ_exp_ refinanced_flag_ months_behind_mtge_ forc_flag_ udur_ unemp_prev_yr_ welfare_hd_ retirement_inc_hd_ unemp_comp_ workers_comp_ labor_inc_hd_real_ total_fam_inc_real_ ///
debt_flag_ value_debts_real_ , stat(n mean sd min max) save
return list

matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515_subsets1", sheet("College Educ Black Women") modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt
restore

***
*College Educated White Men
preserve 
	keep if male_flag_ == 1
	keep if educ_2levels == 1
	keep if race_ == 1
	
tabstat delinq_flag_ married_flag_ educ_exp_ refinanced_flag_ months_behind_mtge_ forc_flag_ udur_ unemp_prev_yr_ welfare_hd_ retirement_inc_hd_ unemp_comp_ workers_comp_ labor_inc_hd_real_ total_fam_inc_real_ ///
debt_flag_ value_debts_real_ , stat(n mean sd min max) save
return list

matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515_subsets1", sheet("College Educ White Men") modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt
restore

***
*College Educated Black men 
preserve 
	keep if male_flag_ == 1
	keep if educ_2levels == 1
	keep if race_ == 2
	
tabstat delinq_flag_ married_flag_ educ_exp_ refinanced_flag_ months_behind_mtge_ forc_flag_ udur_ unemp_prev_yr_ welfare_hd_ retirement_inc_hd_ unemp_comp_ workers_comp_ labor_inc_hd_real_ total_fam_inc_real_ ///
debt_flag_ value_debts_real_ , stat(n mean sd min max) save
return list

matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515_subsets1", sheet("College Educ Black Men") modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt
restore


***
*HS educated white women 
preserve 
	keep if male_flag_ == 0
	keep if educ_2levels == 0
	keep if race_ == 1
	
tabstat delinq_flag_ married_flag_ educ_exp_ refinanced_flag_ months_behind_mtge_ forc_flag_ udur_ unemp_prev_yr_ welfare_hd_ retirement_inc_hd_ unemp_comp_ workers_comp_ labor_inc_hd_real_ total_fam_inc_real_ ///
debt_flag_ value_debts_real_ , stat(n mean sd min max) save
return list

matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515_subsets1", sheet("HS Educ White Women") modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt
restore

***
*HS educated black women
preserve 
	keep if male_flag_ == 0
	keep if educ_2levels == 0
	keep if race_ == 2
	
tabstat delinq_flag_ married_flag_ educ_exp_ refinanced_flag_ months_behind_mtge_ forc_flag_ udur_ unemp_prev_yr_ welfare_hd_ retirement_inc_hd_ unemp_comp_ workers_comp_ labor_inc_hd_real_ total_fam_inc_real_ ///
debt_flag_ value_debts_real_ , stat(n mean sd min max) save
return list

matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515_subsets1", sheet("HS Educ Black Women") modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt
restore

***
*HS Educated White men 
preserve 
	keep if male_flag_ == 1
	keep if educ_2levels == 0
	keep if race_ == 1
	
tabstat delinq_flag_ married_flag_ educ_exp_ refinanced_flag_ months_behind_mtge_ forc_flag_ udur_ unemp_prev_yr_ welfare_hd_ retirement_inc_hd_ unemp_comp_ workers_comp_ labor_inc_hd_real_ total_fam_inc_real_ ///
debt_flag_ value_debts_real_ , stat(n mean sd min max) save
return list

matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515_subsets1", sheet("HS Educ White Men") modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt
restore


***
*HS Educated Black men 
preserve 
	keep if male_flag_ == 1
	keep if educ_2levels == 0
	keep if race_ == 2
	
tabstat delinq_flag_ married_flag_ educ_exp_ refinanced_flag_ months_behind_mtge_ forc_flag_ udur_ unemp_prev_yr_ welfare_hd_ retirement_inc_hd_ unemp_comp_ workers_comp_ labor_inc_hd_real_ total_fam_inc_real_ ///
debt_flag_ value_debts_real_ , stat(n mean sd min max) save
return list

matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515_subsets1", sheet("HS Educ Black Men") modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt
restore






