
/****************************************************************************
Programmer: Hannah Kronenberg 
Date: 5/2/2017
Version: v1 
*******************************************************************************/
global Data "\\c1resp2\SRC Shared\PSID_mtge_demo\Data" 
global RAW  "$Data\Raw" 
global TEMP "$Data\Temp"
global INT  "$Data\Intermediate" 
global OUT  "$Data\Output" 
*******************************************************************************/
/*********************************************************
				IMPORT AND NEW VARIABLES 
*********************************************************/
use "$RAW\PSID_appended_part1_05_13.dta", clear 

*months behind mtge
replace months_behind_mtge_1=. if months_behind_mtge_1==99|months_behind_mtge_1==98

*values for 2013
replace imp_val_business=imp_val_business_asset-imp_val_business_debt if year==2013

replace imp_val_otr_real_estate =  imp_val_otr_real_estate_asset - imp_val_otr_real_estate_debt if year==2013

*current interest rate* 
	replace curr_int_rate_whole_pct_1=. if curr_int_rate_whole_pct_1==98|curr_int_rate_whole_pct_1==99

*LTVs*
	gen combined_rem_princ = rem_princ_mtge_1+rem_princ_mtge_2 
	gen CLTV=(combined_rem_princ)/house_value
	gen LTV_1=rem_princ_mtge_1/house_value
	gen LTV_2=rem_princ_mtge_2/house_value
*some dummy variables 	
	*second mtge, 0-No, 1-Yes
	gen  second_mtge_flag= 0
	replace second_mtge_flag=1 if second_mtge == 1
	*refinanced mtge 1 and 2, 0-Original,1-Refinanced 
	gen refinance_flg_1=0
		replace refinance_flg_1=1 if orig_loan_refinance_1==2
	gen refinance_flg_2=0
		replace refinance_flg_2=1 if orig_loan_refinance_2==2
	*60 day delinquency flag?????* 
	gen delinquency_flag_1=0
		replace delinquency_flag=1 if months_behind_mtge_1>=2 
	gen delinquency_flag_2=0
		replace delinquency_flag_2=1 if months_behind_mtge_2>=2 
	*unemployed head and wife flags* 
	gen unemployed_flag_head=0
		replace unemployed_flag_head=1 if unemployed_head==1
	gen unemployed_flag_spouse=0
		replace unemployed_flag_spouse=1 if unemployed_spouse==1
	gen unemployed_flag_both=0
			replace unemployed_flag_both=1 if unemployed_spouse==1 & unemployed_head==1
	gen unemployed_flag_either=0
	replace unemployed_flag_either=1 if unemployed_spouse==1 | unemployed_head==1
	*unemployed as of survey date* 
	gen unemployed_asof_surv_flag_hd=0
		replace unemployed_asof_surv_flag_hd=1 if employ_stat_head_1==3|employ_stat_head_2==3|employ_stat_head_3==3
	gen unemployed_asof_surv_flag_sp=0
		replace unemployed_asof_surv_flag_sp=1 if employ_stat_spouse_1==3|employ_stat_spouse_2==3|employ_stat_spouse_3==3
	*male flag*
	replace sex_head = sex_head_ if year!= 2005
	drop sex_head_
	gen male_flag=0 
		replace male_flag = 1 if sex_head==1 
	*married flag* 
	gen married_flag=0
	replace married_flag=1 if head_marital_stat==1 
	*divorce flag* 
	gen divorce_flag=0
	replace divorce_flag=1 if head_marital_stat==4
	*education flags 
	gen less_than_HS_flag=0 
		replace less_than_HS_flag=1 if completed_education_head<12 
	gen HS_flag=0
			replace HS_flag=1 if completed_education_head==12 
	gen some_college_flag=0
			replace some_college_flag=1 if completed_education_head>12 & completed_education_head<17 
	gen college_grad_plus_flag=0
			replace college_grad_plus_flag=1 if completed_education_head==17 
	
*ask about ARM, Recourse, judicial* 
*liquid assets*

*error in my code 
rename months_unemployed months_unemployed_head 
	replace months_unemployed_head=months_unemployed_ if year==2009|year==2011|year==2013
		
		
replace beg_month_job_1=beg_month_job_1_  if (year==2009|year==2011|year==2013) 
	drop beg_month_job_1_



replace beg_year_job_1=beg_year_job_1_ if (year==2009|year==2011|year==2013) 
	drop beg_year_job_1_

	
	
replace end_month_job_1=end_month_job_1_ if (year==2009|year==2011|year==2013) 
	drop end_month_job_1_

	
replace end_year_job_1=end_year_job_1_ if (year==2009|year==2011|year==2013) 
	drop end_year_job_1_


replace why_last_job_end=why_last_job_end_ if (year==2009|year==2011|year==2013) 
	drop why_last_job_end_
	
replace beg_month_job_2=beg_month_job_2_ if (year==2009|year==2011|year==2013) 
	drop beg_month_job_2_


replace beg_year_job_2=beg_year_job_2_ if (year==2009|year==2011|year==2013) 
	drop beg_year_job_2_

replace end_month_job_2=end_month_job_2_ if (year==2009|year==2011|year==2013) 
	drop end_month_job_2_

replace end_year_job_2=end_year_job_2_ if (year==2009|year==2011|year==2013) 
	drop end_year_job_2_


replace why_job_2_end=why_job_2_end_ if (year==2009|year==2011|year==2013) 
	drop why_job_2_end_

replace beg_month_job_3=beg_month_job_3_ if (year==2009|year==2011|year==2013) 
	drop beg_month_job_3_

replace beg_year_job_3=beg_year_job_3_ if (year==2009|year==2011|year==2013) 
	drop beg_year_job_3_

replace end_month_job_3=end_month_job_3_ if (year==2009|year==2011|year==2013) 
	drop end_month_job_3_

replace why_job_3_end=why_job_3_end_ if (year==2009|year==2011|year==2013) 
	drop why_job_3_end_


replace why_job_4_end=why_job_4_end_ if (year==2009|year==2011|year==2013) 
	drop why_job_4_end_

replace missed_work_otr_ill=missed_work_otr_ill_ if (year==2009|year==2011|year==2013) 
	drop missed_work_otr_ill_ 
	
replace missed_work_self_ill=missed_work_self_ill_ if (year==2009|year==2011|year==2013) 
	drop missed_work_self_ill_
	
	drop months_unemployed_

replace months_out_of_lab_force=months_out_of_lab_force_ if (year==2009|year==2011|year==2013) 
	drop months_out_of_lab_force_


replace end_month_job_1_spouse=end_month_job_1_spouse_ if (year==2009|year==2011|year==2013) 
	drop end_month_job_1_spouse_
replace why_last_job_end_spouse=why_last_job_end_spouse_ if (year==2009|year==2011|year==2013) 
	drop why_last_job_end_spouse_


replace end_month_job_2_spouse=end_month_job_2_spouse_ if (year==2009|year==2011|year==2013) 
	drop end_month_job_2_spouse_

replace end_year_job_2_spouse=end_year_job_2_spouse_ if (year==2009|year==2011|year==2013) 
	drop end_year_job_2_spouse_
	
replace end_month_job_3_spouse=end_month_job_3_spouse_ if (year==2009|year==2011|year==2013) 
	drop end_month_job_3_spouse_

replace end_year_job_3_spouse=end_year_job_3_spouse_ if (year==2009|year==2011|year==2013) 
	drop end_year_job_3_spouse_

replace why_job_3_end_spouse=why_job_3_end_spouse_ if (year==2009|year==2011|year==2013) 
	drop why_job_3_end_spouse_

replace end_month_job_4=end_month_job_4_ if (year==2009|year==2011|year==2013) 
	drop end_month_job_4_


replace end_year_job_4=end_year_job_4_ if (year==2009|year==2011|year==2013) 
	drop end_year_job_4_
	
replace end_year_job_1_spouse=end_year_job_1_spouse_ if (year==2009|year==2011|year==2013) 
	drop end_year_job_1_spouse_
	
	
replace beg_year_job_4=beg_year_job_4_ if (year==2009|year==2011|year==2013) 
	drop beg_year_job_4_

replace end_year_job_3=end_year_job_3_ if (year==2009|year==2011|year==2013) 
	drop end_year_job_3_


save "$INT/PSID_mtge_demo_clean_2005_2013.dta", replace  
		
/*********************************************************
						SUMMARY STATS
*********************************************************/
*Herkenhoff condtions 
preserve 
	keep if age>=24 & age<=65
	keep if have_mtge==1
	keep if CLTV<2.5
	*second mortgage* 

	collapse (sum)second_mtge (count)family_int_id (median) rem_princ_mtge_1 monthly_pay_mtge_1 curr_int_rate_whole_pct_1  yrs_to_pay_mtge_1 LTV_1, by(year) 

	
	
	
	export excel using "$OUT\PSID_0513_demo_mtge_summary_stats", sheet ("Herk Summ Stats_mtge") firstrow(variables) sheetreplace

*summ stats of the full sample 
restore 

preserve 
	keep if age>=24 & age<=65
	keep if have_mtge==1
	keep if CLTV<2.5
	
	collapse (mean) age_head male_flag married_flag divorce_flag less_than_HS_flag HS_flag some_college_flag college_grad_plus_flag children_in_fam wage_salary /// 
	house_value rem_princ_mtge_1 monthly_pay_mtge_1 second_mtge refinance_flg_1 curr_int_rate_whole_pct_1 yrs_to_pay_mtge_1 delinquency_flag_1 months_behind_mtge_1 LTV_1 ///
	unemployed_flag_head unemployed_flag_spouse unemployed_flag_both unemployed_flag_either unemployed_asof_surv_flag_hd unemployed_asof_surv_flag_sp months_unemployed_head  months_unemployed_spouse ///
	imp_val_stocks imp_val_savings value_debts imp_val_vehicle profit_if_sold_bonds imp_val_business imp_val_business_asset imp_val_business_debt  imp_val_ira  imp_val_otr_real_estate imp_val_otr_real_estate_asset imp_val_otr_real_estate_debt  ///
	, by(year) 
	
	
export excel using "$OUT\PSID_0513_demo_mtge_summary_stats", sheet ("Herk Summ Stats_demo_mean") firstrow(variables) sheetreplace
restore 


preserve 
	keep if age>=24 & age<=65
	keep if have_mtge==1
	keep if CLTV<2.5
	
	collapse (p10) age_head male_flag married_flag divorce_flag less_than_HS_flag HS_flag some_college_flag college_grad_plus_flag children_in_fam wage_salary /// 
	house_value rem_princ_mtge_1 monthly_pay_mtge_1 second_mtge refinance_flg_1 curr_int_rate_whole_pct_1 yrs_to_pay_mtge_1 delinquency_flag_1 months_behind_mtge_1 LTV_1 ///
	unemployed_flag_head unemployed_flag_spouse unemployed_flag_both unemployed_flag_either unemployed_asof_surv_flag_hd unemployed_asof_surv_flag_sp months_unemployed_head months_unemployed_spouse ///
	imp_val_stocks imp_val_savings value_debts imp_val_vehicle profit_if_sold_bonds imp_val_business imp_val_business_asset imp_val_business_debt  imp_val_ira  imp_val_otr_real_estate imp_val_otr_real_estate_asset imp_val_otr_real_estate_debt  ///
	, by(year) 

export excel using "$OUT\PSID_0513_demo_mtge_summary_stats", sheet ("Herk Summ Stats_demo_p10") firstrow(variables) sheetreplace
restore 

preserve 
	keep if age>=24 & age<=65
	keep if have_mtge==1
	keep if CLTV<2.5
	
	collapse (p50) age_head male_flag married_flag divorce_flag less_than_HS_flag HS_flag some_college_flag college_grad_plus_flag children_in_fam  wage_salary /// 
	house_value rem_princ_mtge_1 monthly_pay_mtge_1 second_mtge refinance_flg_1 curr_int_rate_whole_pct_1 yrs_to_pay_mtge_1 delinquency_flag_1 months_behind_mtge_1 LTV_1 ///
	unemployed_flag_head unemployed_flag_spouse unemployed_flag_both unemployed_flag_either unemployed_asof_surv_flag_hd unemployed_asof_surv_flag_sp months_unemployed_head months_unemployed_spouse ///
	imp_val_stocks imp_val_savings value_debts imp_val_vehicle profit_if_sold_bonds imp_val_business imp_val_business_asset imp_val_business_debt  imp_val_ira  imp_val_otr_real_estate imp_val_otr_real_estate_asset imp_val_otr_real_estate_debt  ///
	, by(year) 

export excel using "$OUT\PSID_0513_demo_mtge_summary_stats", sheet ("Herk Summ Stats_demo_p50") firstrow(variables) sheetreplace
restore 

preserve 
	keep if age>=24 & age<=65
	keep if have_mtge==1
	keep if CLTV<2.5
	
	collapse (p90) age_head male_flag married_flag divorce_flag less_than_HS_flag HS_flag some_college_flag college_grad_plus_flag children_in_fam wage_salary /// 
	house_value rem_princ_mtge_1 monthly_pay_mtge_1 second_mtge refinance_flg_1 curr_int_rate_whole_pct_1 yrs_to_pay_mtge_1 delinquency_flag_1 months_behind_mtge_1 LTV_1 ///
	unemployed_flag_head unemployed_flag_spouse unemployed_flag_both unemployed_flag_either unemployed_asof_surv_flag_hd unemployed_asof_surv_flag_sp months_unemployed_head months_unemployed_spouse ///
	imp_val_stocks imp_val_savings value_debts imp_val_vehicle profit_if_sold_bonds imp_val_business imp_val_business_asset imp_val_business_debt  imp_val_ira  imp_val_otr_real_estate imp_val_otr_real_estate_asset imp_val_otr_real_estate_debt  ///
	, by(year) 

export excel using "$OUT\PSID_0513_demo_mtge_summary_stats", sheet ("Herk Summ Stats_demo_p90") firstrow(variables) sheetreplace
restore 

****DELINQUENT****
preserve 
	keep if age>=24 & age<=65
	keep if have_mtge==1
	keep if CLTV<2.5
	keep if delinquency_flag_1==1 
	keep if year==2009|year==2011|year==2013 //No delinquency flag for 2005, 2007
	
	collapse (mean) age_head male_flag married_flag divorce_flag less_than_HS_flag HS_flag some_college_flag college_grad_plus_flag children_in_fam wage_salary /// 
	house_value rem_princ_mtge_1 monthly_pay_mtge_1 second_mtge refinance_flg_1 curr_int_rate_whole_pct_1 yrs_to_pay_mtge_1  months_behind_mtge_1 LTV_1 ///
	unemployed_flag_head unemployed_flag_spouse unemployed_flag_both unemployed_flag_either unemployed_asof_surv_flag_hd unemployed_asof_surv_flag_sp months_unemployed_head months_unemployed_spouse ///
	imp_val_stocks imp_val_savings value_debts imp_val_vehicle profit_if_sold_bonds imp_val_business imp_val_business_asset imp_val_business_debt  imp_val_ira  imp_val_otr_real_estate imp_val_otr_real_estate_asset imp_val_otr_real_estate_debt  ///
	, by(year) 
	
	
export excel using "$OUT\PSID_0513_demo_mtge_summary_stats", sheet ("Herk Summ Stats_demo_mean_DEL") firstrow(variables) sheetreplace
restore 


preserve 
	keep if age>=24 & age<=65
	keep if have_mtge==1
	keep if CLTV<2.5
	keep if delinquency_flag_1==1 
	keep if year==2009|year==2011|year==2013
	
	collapse (p10) age_head male_flag married_flag divorce_flag less_than_HS_flag HS_flag some_college_flag college_grad_plus_flag children_in_fam wage_salary /// 
	house_value rem_princ_mtge_1 monthly_pay_mtge_1 second_mtge refinance_flg_1 curr_int_rate_whole_pct_1 yrs_to_pay_mtge_1  months_behind_mtge_1 LTV_1 ///
	unemployed_flag_head unemployed_flag_spouse unemployed_flag_both unemployed_flag_either unemployed_asof_surv_flag_hd unemployed_asof_surv_flag_sp months_unemployed_head months_unemployed_spouse ///
	imp_val_stocks imp_val_savings value_debts imp_val_vehicle profit_if_sold_bonds imp_val_business imp_val_business_asset imp_val_business_debt  imp_val_ira  imp_val_otr_real_estate imp_val_otr_real_estate_asset imp_val_otr_real_estate_debt  ///
	, by(year) 

export excel using "$OUT\PSID_0513_demo_mtge_summary_stats", sheet ("Herk Summ Stats_demo_p10_DEL") firstrow(variables) sheetreplace
restore 

preserve 
	keep if age>=24 & age<=65
	keep if have_mtge==1
	keep if CLTV<2.5
	keep if delinquency_flag_1==1 
	keep if year==2009|year==2011|year==2013
	
	collapse (p50) age_head male_flag married_flag divorce_flag less_than_HS_flag HS_flag some_college_flag college_grad_plus_flag children_in_fam wage_salary /// 
	house_value rem_princ_mtge_1 monthly_pay_mtge_1 second_mtge refinance_flg_1 curr_int_rate_whole_pct_1 yrs_to_pay_mtge_1  months_behind_mtge_1 LTV_1 ///
	unemployed_flag_head unemployed_flag_spouse unemployed_flag_both unemployed_flag_either unemployed_asof_surv_flag_hd unemployed_asof_surv_flag_sp months_unemployed_head months_unemployed_spouse ///
	imp_val_stocks imp_val_savings value_debts imp_val_vehicle profit_if_sold_bonds imp_val_business imp_val_business_asset imp_val_business_debt  imp_val_ira  imp_val_otr_real_estate imp_val_otr_real_estate_asset imp_val_otr_real_estate_debt  ///
	, by(year) 

export excel using "$OUT\PSID_0513_demo_mtge_summary_stats", sheet ("Herk Summ Stats_demo_p50_DEL") firstrow(variables) sheetreplace
restore 

preserve 
	keep if age>=24 & age<=65
	keep if have_mtge==1
	keep if CLTV<2.5
	keep if delinquency_flag_1==1 
	keep if year==2009|year==2011|year==2013
	
	collapse (p90) age_head male_flag married_flag divorce_flag less_than_HS_flag HS_flag some_college_flag college_grad_plus_flag children_in_fam wage_salary /// 
	house_value rem_princ_mtge_1 monthly_pay_mtge_1 second_mtge refinance_flg_1 curr_int_rate_whole_pct_1 yrs_to_pay_mtge_1 months_behind_mtge_1 LTV_1 ///
	unemployed_flag_head unemployed_flag_spouse unemployed_flag_both unemployed_flag_either unemployed_asof_surv_flag_hd unemployed_asof_surv_flag_sp months_unemployed_head months_unemployed_spouse ///
	imp_val_stocks imp_val_savings value_debts imp_val_vehicle profit_if_sold_bonds imp_val_business imp_val_business_asset imp_val_business_debt  imp_val_ira  imp_val_otr_real_estate imp_val_otr_real_estate_asset imp_val_otr_real_estate_debt  ///
	, by(year) 

export excel using "$OUT\PSID_0513_demo_mtge_summary_stats", sheet ("Herk Stats_demo_p90_DEL") firstrow(variables) sheetreplace
restore 





















