********************************************************************************
*Author: Jessica Kiser
*Date: 07.03.2018 updated 08.08.18
*Description: This is the do all code for PSID  data (merges, reshapes, cleans)
*File also contains preliminary desriptive statitics  
********************************************************************************
*program drop _all
clear all 
set more off

********************************* Setting Macros *******************************
global data "\\c1resp3\Retail_Risk_Analysis\Non_Restricted_Research\Kiser\PSID\PSID_Jessica\data" 
global raw  "$data\raw" 
global int  "$data\Intermediate" 
global output "$data\Output" 

**********************************************
***Merging all of the raw renamed PSID data to one dataset
 

/* Silvio-- I made the merge all note so you don't have to go through each merge, and skip straight to calling in the merged raw data 


use "$raw\demographics_psid_renamed.dta", clear 

*merge with personal data*
merge 1:1 famidpn using "$raw\personal_psid_renamed"
assert _m == 3
drop _m

*merge with mortgage data*
merge 1:1 famidpn using "$raw\mortgage_psid_renamed"
assert _m == 3
drop _m

*merge with unemployment data  
merge 1:1 famidpn using "$raw\unemployment_psid_renamed"
assert _m == 3
drop _m 

*merge with state and metro data
merge 1:1 famidpn using "$raw\state_metro_psid_renamed"
assert _m == 3 
drop _m 

*merge with state & unemployment 
merge 1:1 famidpn using "$raw\state_unemployment_renamed" 
drop if _merge==2
drop _m

*merge with income data
merge 1:1 famidpn using "$raw\income_psid_renamed"
assert _m == 3
drop _m

*merge with wife age data
merge 1:1 famidpn using "$raw\wife_psid_renamed"
assert _m == 3
drop _m

*merge with debts data
merge 1:1 famidpn using "$raw\debt_assets_psid_renamed"
assert _m == 3
drop _m
 
*merge with #inFU
merge 1:1 famidpn using "$raw\#inFU_psid_renamed"
assert _m == 3
drop _m

*merge with assets data
merge 1:1 famidpn using "$raw\assets_and_added_psid_renamed"
assert _m == 3
drop _m

save "$int/merged_psid_raw.dta",replace 

*/

*using raw merged data that has been renamed
use "$int/merged_psid_raw.dta", clear 


*cleaning and generating before the reshape because code is specific to years 
	
	*2005
	recode lfs1_2005 (99=.) (0=.)
	recode lfs2_2005 (0=.)
	recode lfs3_2005 (0=.)
	*2007
	recode lfs1_2007 (99=.)
	recode lfs2_2007 (0=.)
	recode lfs3_2007 (0=.)
	*2009
	recode lfs1_2009 (99=.)
	recode lfs2_2009 (0=.)
	recode lfs3_2009 (0=.)
	*2011
	recode lfs1_2011 (99=.)
	recode lfs2_2011 (0=.)
	recode lfs3_2011 (0=.)
	*2013
	recode lfs1_2013 (99=.)
	recode lfs2_2013 (0=.)
	recode lfs3_2013 (0=.)
	*2015
	recode lfs1_2015 (99=.)
	recode lfs2_2015 (0=.)
	recode lfs3_2015 (0=.)
	
	*2005
	recode lfs1_sp_2005 (99=.)
	*2007
	recode lfs1_sp_2007 (99=.) (32=.)
	*2009
	recode lfs1_sp_2009 (99=.)
	*2011
	recode lfs1_sp_2011 (99=.)
	*2013
	recode lfs1_sp_2013 (99=.)
	*2015
	recode lfs1_sp_2015 (99=.)
	
	*2005 
	recode retirement_inc_hd_2005 (8/9=.) (0=.) (5=0) 
	*2007
	recode retirement_inc_hd_2007 (8/9=.) (0=.) (5=0) 
	*2009
	recode retirement_inc_hd_2009 (8/9=.) (5=0) 
	*2011
	recode retirement_inc_hd_2011 (8/9=.) (5=0) 
	*2013
	recode retirement_inc_hd_2013 (8/9=.) (5=0) 
	*2015
	recode retirement_inc_hd_2015 (8/9=.) (5=0) 
	
	
	recode cr_st_med_legal_fam_2005 (8/9=.) (5=0)
	recode cr_st_med_legal_fam_2007 (8/9=.) (5=.)
	recode cr_st_med_legal_fam_2009 (8/9=.) (5=.)
	
	recode value_debts_2005 (999999998 =.) (999999999 =.) 
	recode value_debts_2007 (999999998 =.) (999999999 =.) 
	recode value_debts_2009 (999999998 =.) (999999999 =.) 

	recode credit_debt_2011 (8/9=.) (5=0)
	recode credit_debt_2013 (8/9=.) (5=0)
	recode credit_debt_2015 (8/9=.) (5=0)
	
	recode st_loans_2011 (8/9=.) (5=0) 
	recode med_bills_2011 (8/9=.) (5=0)
	recode legal_bills_2011 (8/9=.) (5=0)
	recode fam_loans_2011 (8/9=.) (5=0)

	recode value_card_debt_2013 (9999998/9999999 =.) 
	recode st_med_legal_fam_2013 (8/9=.) (5=0) 
	recode value_other_debt_2013 (9999998/9999999 =.)
	
	recode value_card_debt_2015 (9999998/9999999 =.) 
	recode st_med_legal_fam_2015 (8/9=.) (5=0)
	recode value_other_debt_2015 (9999998/9999999=.) 


	recode end_yrj1_2005 (9996=.) (9998/9999=.)
	recode end_yrj2_2005 (9998/9999=.)(2003=.) 
	recode end_yrj3_2005 (9998/9999=.)(2003=.) 
	recode end_yrj4_2005 (9998/9999=.)(2003=.) 
	
	recode end_yrj1_sp_2005 (9998/9999=.)
	recode end_yrj2_sp_2005 (9998/9999=.)(2003=.) 
	recode end_yrj3_sp_2005 (9998/9999=.)
	recode end_yrj4_sp_2005 (9998/9999=.)
	
	recode end_yrj1_2007 (9998/9999=.)
	recode end_yrj2_2007 (9998/9999=.) (2005=.) (9997=.)
	recode end_yrj3_2007 (9998/9999=.)
	recode end_yrj4_2007 (9998/9999=.)
	
	recode end_yrj1_sp_2007 (9998/9999=.)
	recode end_yrj2_sp_2007 (9998/9999=.)
	recode end_yrj3_sp_2007 (9998/9999=.)
	recode end_yrj4_sp_2007 (9998/9999=.)
	
	// all 2009-2015 --- 9996 code means (2007-2009 DK which year), 9997 means (before 2007 DK year)  
	recode end_yrj1_2009 (9998/9999=.)
	recode end_yrj2_2009 (9998/9999=.)
	recode end_yrj3_2009 (9998/9999=.)
	recode end_yrj4_2009 (9998/9999=.)
	
	recode end_yrj1_sp_2009 (9998/9999=.)
	recode end_yrj2_sp_2009 (9998/9999=.)
	recode end_yrj3_sp_2009 (9998/9999=.)
	recode end_yrj4_sp_2009 (9998/9999=.)
	
	recode end_yrj1_2011 (9998/9999=.)
	recode end_yrj2_2011 (9998/9999=.)
	recode end_yrj3_2011 (9998/9999=.)
	recode end_yrj4_2011 (9998/9999=.)
	
	recode end_yrj1_sp_2011 (9998/9999=.)
	recode end_yrj2_sp_2011 (9998/9999=.)
	recode end_yrj3_sp_2011 (9998/9999=.)
	recode end_yrj4_sp_2011 (9998/9999=.)
	
	recode end_yrj1_2013 (9998/9999=.)
	recode end_yrj2_2013 (9998/9999=.)
	recode end_yrj3_2013 (9998/9999=.)
	recode end_yrj4_2013 (9998/9999=.)
	
	recode end_yrj1_sp_2013 (9998/9999=.)
	recode end_yrj2_sp_2013 (9998/9999=.)
	recode end_yrj3_sp_2013 (9998/9999=.)
	recode end_yrj4_sp_2013 (9998/9999=.)
	
	recode end_yrj1_2015 (9998/9999=.)
	recode end_yrj2_2015 (9998/9999=.)
	recode end_yrj3_2015 (9998/9999=.)
	recode end_yrj4_2015 (9998/9999=.)
	
	recode beg_yrj1_2005 (9998/9999=.) (9996=.)
	recode beg_yrj1_2007 (9998/9999=.) 
	recode beg_yrj1_2009 (9998/9999=.) 
	recode beg_yrj1_2011 (9998/9999=.) 
	recode beg_yrj1_2013 (9998/9999=.) 
	recode beg_yrj1_2015 (9998/9999=.) 

	recode value_stock_2005 (999999998/999999999=.)
	recode value_stock_2007 (999999998/999999999=.) (-99999999/-4000=.)
	recode value_stock_2009 (999999998/999999999=.)
	recode value_stock_2011 (999999998/999999999=.)
	recode value_stock_2013 (999999998/999999999=.)
	recode value_stock_2015 (999999998/999999999=.)
	
	recode liq_assets_2005 (-400=.) (999999998/999999999=.)
	recode liq_assets_2007 (999999998/999999999=.)
	recode liq_assets_2009 (999999998/999999999=.)
	recode liq_assets_2011 (999999998/999999999=.)
	recode liq_assets_2013 (999999998/999999999=.)
	recode liq_assets_2015 (999999998/999999999=.)
	
	
/*for years 2005-2009 wtr have debt & value of debt (other than home/vehicle) is 
one variable, but is broken into multiple for 2011-2015 so here I combine them to 
create consistent code across years*/
	gen debt_flag_2005 = 0 
	replace debt_flag_2005 = 1 if  cr_st_med_legal_fam_2005 == 1

	gen debt_flag_2007 = 0 
	replace debt_flag_2007 = 1 if  cr_st_med_legal_fam_2007 == 1
	
	gen debt_flag_2009 = 0 
	replace debt_flag_2009 = 1 if  cr_st_med_legal_fam_2009 == 1 
	
	gen debt_flag_2011 = 0
	replace debt_flag_2011 = 1 if credit_debt_2011 == 1 | st_loans_2011 == 1 | med_bills_2011 == 1 | legal_bills_2011 == 1  | fam_loans_2011 == 1 
	
	gen debt_flag_2013 = 0 
	replace debt_flag_2013 = 1 if credit_debt_2013 == 1 | st_med_legal_fam_2013 == 1 
	
	gen debt_flag_2015 = 0 
	replace debt_flag_2015 = 1 if credit_debt_2015 == 1 | st_med_legal_fam_2015 == 1 
	

	gen value_debts_2011 = value_card_debt_2011 + value_student_debt_2011 + value_med_debt_2011 + value_legal_debt_2011 + value_fam_loan_debt_2011
	gen value_debts_2013 = value_card_debt_2013 + value_other_debt_2013
	gen value_debts_2015 = value_card_debt_2015 + value_other_debt_2015
	
*dropping the inconsistent variables used to create debt flag & value of debt variables	
	drop cr_st_med_legal_fam_2005 cr_st_med_legal_fam_2007 cr_st_med_legal_fam_2009
	drop credit_debt_2011 credit_debt_2013 credit_debt_2015
	drop st_loans_2011 med_bills_2011 legal_bills_2011 fam_loans_2011
	drop value_card_debt_2013 value_card_debt_2015
	drop st_med_legal_fam_2013 st_med_legal_fam_2015
	drop value_other_debt_2013 value_other_debt_2015 
	drop value_card_debt_2011 value_student_debt_2011 value_med_debt_2011 value_legal_debt_2011 value_fam_loan_debt_2011
	
***more recoding before creating the "real" values, adjusted to June 2018
	
*recoding hv so that non homeowners don't bring down the house value 	
recode hv_* (9999998=.) (9999999=.) (0=.)	
recode pr_* (9999998=.) (9999999=.)
		replace pr_2005 = . if homeowner_2005 == 0 	
		replace pr_2007 = . if homeowner_2007 == 0 	
		replace pr_2009 = . if homeowner_2009 == 0 	
		replace pr_2011 = . if homeowner_2011 == 0 	
		replace pr_2013 = . if homeowner_2013 == 0 
		replace pr_2015 = . if homeowner_2015 == 0 	
		
	recode mpay_* (99998=.) (99999=.)
		replace mpay_2005 =. if homeowner_2005 == 0 
		replace mpay_2007 =. if homeowner_2007 == 0 
		replace mpay_2009 =. if homeowner_2009 == 0 
		replace mpay_2011 =. if homeowner_2011 == 0 
		replace mpay_2013 =. if homeowner_2013 == 0 
		replace mpay_2015 =. if homeowner_2015 == 0 
		
replace labor_inc_sp_2005 =. if spouse_age_2005 == 0 	
replace labor_inc_sp_2007 =. if spouse_age_2007 == 0 
replace labor_inc_sp_2009 =. if spouse_age_2009 == 0 
replace labor_inc_sp_2011 =. if spouse_age_2011 == 0 
replace labor_inc_sp_2013 =. if spouse_age_2013 == 0 
replace labor_inc_sp_2015 =. if spouse_age_2015 == 0 
	
*recoding assets 	
	recode ira_* (999999998/999999999=.)		
	recode value_vehicles_* (999999998/999999999=.)	
	recode profit_otr_real_estate_* (999999998/999999999=.)
	recode bus_profit_* (999999998/999999999=.)
	recode bonds_* (999999998/999999999=.)

***generating real values of variables (adjusted to June 2018)	
	
gen hv_real_2005 = hv_2005/.7896929
gen hv_real_2007 = hv_2007/.8428906
gen hv_real_2009 = hv_2009/.8664179
gen hv_real_2011 = hv_2011/.905787
gen hv_real_2013 = hv_2013/.9356685
gen hv_real_2015 = hv_2015/.9480581

gen value_debts_real_2005 = value_debts_2005/.7896929
gen value_debts_real_2007 = value_debts_2007/.8428906
gen value_debts_real_2009 = value_debts_2009/.8664179
gen value_debts_real_2011 = value_debts_2011/.905787
gen value_debts_real_2013 = value_debts_2013/.9356685
gen value_debts_real_2015 = value_debts_2015/.9480581

gen liq_assets_real_2005 = liq_assets_2005/.7896929
gen liq_assets_real_2007 = liq_assets_2007/.8428906
gen liq_assets_real_2009 = liq_assets_2009/.8664179
gen liq_assets_real_2011 = liq_assets_2011/.905787
gen liq_assets_real_2013 = liq_assets_2013/.9356685
gen liq_assets_real_2015 = liq_assets_2015/.9480581

gen pr_real_2005 = pr_2005/.7896929
gen pr_real_2007 = pr_2007/.8428906
gen pr_real_2009 = pr_2009/.8664179
gen pr_real_2011 = pr_2011/.905787
gen pr_real_2013 = pr_2013/.9356685
gen pr_real_2015 = pr_2015/.9480581

gen mpay_real_2005 = mpay_2005/.7896929
gen mpay_real_2007 = mpay_2007/.8428906
gen mpay_real_2009 = mpay_2009/.8664179
gen mpay_real_2011 = mpay_2011/.905787
gen mpay_real_2013 = mpay_2013/.9356685
gen mpay_real_2015 = mpay_2015/.9480581

gen value_vehicles_real_2005 = value_vehicles_2005/.7896929
gen value_vehicles_real_2007 = value_vehicles_2007/.8428906
gen value_vehicles_real_2009 = value_vehicles_2009/.8664179
gen value_vehicles_real_2011 = value_vehicles_2011/.905787
gen value_vehicles_real_2013 = value_vehicles_2013/.9356685
gen value_vehicles_real_2015 = value_vehicles_2015/.9480581

gen value_stock_real_2005 = value_stock_2005/.7896929
gen value_stock_real_2007 = value_stock_2007/.8428906
gen value_stock_real_2009 = value_stock_2009/.8664179
gen value_stock_real_2011 = value_stock_2011/.905787
gen value_stock_real_2013 = value_stock_2013/.9356685
gen value_stock_real_2015 = value_stock_2015/.9480581

gen ira_real_2005 = ira_2005/.7896929
gen ira_real_2007 = ira_2007/.8428906
gen ira_real_2009 = ira_2009/.8664179
gen ira_real_2011 = ira_2011/.905787
gen ira_real_2013 = ira_2013/.9356685
gen ira_real_2015 = ira_2015/.9480581
	
gen labor_inc_hd_real_2005 = labor_inc_hd_2005/.7896929
gen labor_inc_hd_real_2007 = labor_inc_hd_2007/.8428906
gen labor_inc_hd_real_2009 = labor_inc_hd_2009/.8664179
gen labor_inc_hd_real_2011 = labor_inc_hd_2011/.905787
gen labor_inc_hd_real_2013 = labor_inc_hd_2013/.9356685
gen labor_inc_hd_real_2015 = labor_inc_hd_2015/.9480581


gen labor_inc_sp_real_2005 = labor_inc_sp_2005/.7896929
gen labor_inc_sp_real_2007 = labor_inc_sp_2007/.8428906
gen labor_inc_sp_real_2009 = labor_inc_sp_2009/.8664179
gen labor_inc_sp_real_2011 = labor_inc_sp_2011/.905787
gen labor_inc_sp_real_2013 = labor_inc_sp_2013/.9356685
gen labor_inc_sp_real_2015 = labor_inc_sp_2015/.9480581

gen total_fam_inc_real_2005 = total_fam_inc_2005/.7896929
gen total_fam_inc_real_2007 = total_fam_inc_2007/.8428906
gen total_fam_inc_real_2009 = total_fam_inc_2009/.8664179
gen total_fam_inc_real_2011 = total_fam_inc_2011/.905787
gen total_fam_inc_real_2013 = total_fam_inc_2013/.9356685
gen total_fam_inc_real_2015 = total_fam_inc_2015/.9480581

gen m2pr_real_2005 = m2pr_2005/.7896929
gen m2pr_real_2007 = m2pr_2007/.8428906
gen m2pr_real_2009 = m2pr_2009/.8664179
gen m2pr_real_2011 = m2pr_2011/.905787
gen m2pr_real_2013 = m2pr_2013/.9356685
gen m2pr_real_2015 = m2pr_2015/.9480581	

gen bonds_real_2005 = bonds_2005/.7896929
gen bonds_real_2007 = bonds_2007/.8428906
gen bonds_real_2009 = bonds_2009/.8664179
gen bonds_real_2011 = bonds_2011/.905787
gen bonds_real_2013 = bonds_2013/.9356685
gen bonds_real_2015 = bonds_2015/.9480581

gen profit_real_estate_real_2005 = profit_otr_real_estate_2005/.7896929
gen profit_real_estate_real_2007 = profit_otr_real_estate_2007/.8428906
gen profit_real_estate_real_2009 = profit_otr_real_estate_2009/.8664179
gen profit_real_estate_real_2011 = profit_otr_real_estate_2011/.905787
gen profit_real_estate_real_2013 = profit_otr_real_estate_2013/.9356685
gen profit_real_estate_real_2015 = profit_otr_real_estate_2015/.9480581

gen bus_profit_real_2005 = bus_profit_2005/.7896929
gen bus_profit_real_2007 = bus_profit_2007/.8428906
gen bus_profit_real_2009 = bus_profit_2009/.8664179
gen bus_profit_real_2011 = bus_profit_2011/.905787
gen bus_profit_real_2013 = bus_profit_2013/.9356685
gen bus_profit_real_2015 = bus_profit_2015/.9480581





**********************************Reshape***************************************
reshape long ///
age_ ///
sex_ ///
marr_status_ ///
race_exp_ ///
educ_exp_ ///
educ_exp_sp_ ///
seq_num_ ///
int_num_ ///
rel_head_ ///
release_  ///
weeks_hospital_hd_ ///
weeks_hospital_sp_ ///
wtr_any_fam_health_ins_  ///
relig_pref_sp_  ///
relig_pref_hd_ ///
psych_distress_ ///
likely_fall_beh_mtg_1_  ///
likely_fall_beh_mtg_2_   ///     
homeowner_ ///
hv_ ///
mort_ ///
mtype_ ///
refi_ ///
pr_ ///
mpay_ ///
mint_ ///
morig_ ///
yrs_remain_ ///
m2_ ///
m2type_ ///
m2pr_ ///
m2pay_ ///
m2int_ ///
m2orig_ ///
move_ ///
sell_ ///
sell_hv_ ///
otherm_ ///
mtypevar_ ///
m2typevar_ ///
months_behind_mtge_ ///
forc_ ///
mo1fc_ ///
yr1fc_ ///
mod_ ///
months_behind_mtge_2_ ///
forc2_ ///
mo2fc_ ///
yr2fc_ ///
lfs1_ ///
lfs2_ ///
lfs3_ ///
udur_ ///
lfs1_sp_ ///
lfs2_sp_ ///
lfs3_sp_ ///
udur_sp_ /// 
lfs_indiv_ ///
fips_state ///
metro_ ///
state_ ///
hpi   ///
hpi_state ///
unemplr_state ///
unemp_prev_yr_ ///
unemp_prev_yr_sp_ ///
wife_recd_inc_ ///         
unemp_comp_ ///
workers_comp_ ///
welfare_hd_ ///
retirement_inc_hd_ ///
welfare_sp_ ///
labor_inc_hd_ ///
labor_inc_sp_ ///
total_fam_inc_ /// 
spouse_age_ ///
end_yrj1_ ///
end_yrj2_ ///
end_yrj3_ ///
end_yrj4_ ///
end_yrj1_sp_ ///
end_yrj2_sp_ ///
end_yrj3_sp_ ///
end_yrj4_sp_ ///
reason_endj1_ ///
reason_endj2_ ///
reason_endj3_ ///
reason_endj4_ ///
reason_endj1_sp_ ///
reason_endj2_sp_ ///
reason_endj3_sp_ ///
reason_endj4_sp_ ///
savings_ ///
taxable_inc_hd_sp_ ///
num_jobs_ ///
num_jobs_sp_ ///
debt_flag_ ///
value_debts_ ///
beg_yrj1_ ///
beg_yrj2_ ///
beg_yrj3_ ///
beg_yrj4_ ///
beg_yrj1_sp_ ///
beg_yrj2_sp_ ///
beg_yrj3_sp_ ///
beg_yrj4_sp_ ///
profit_otr_real_estate_ ///
value_vehicles_ ///
bus_profit_ ///
value_stock_ ///
ira_ ///
liq_assets_ ///
hv_real_ ///
value_debts_real_ ///
liq_assets_real_ ///
pr_real_ ///
mpay_real_ ///
value_vehicles_real_ ///
value_stock_real_ ///
ira_real_ ///
total_fam_inc_real_ ///
labor_inc_hd_real_ ///
labor_inc_sp_real_ ///
num_in_fam_ ///
num_children_ ///
m2pr_real_ ///
bonds_ ///
bonds_real_ ///
bus_profit_real_ ///
profit_real_estate_real_ , i(famidpn) j (year)

*******************cleaning up missing code********************************
*demographic variables
	recode age_ (999=.)
	recode spouse_age_ (999=.) 
	recode race_exp_ (9=.) (0=.)
	recode marr_status_ (9=.) (8=.)
	recode educ_exp_ (99=.)
	recode educ_exp_sp_ (99=.)
*replacing spouse vars with dot if head doesn't have a spouse		
		replace educ_exp_sp = . if spouse_age == 0
		
*mortgage variables
*non-homeowners get a value of 0, so I changed some vars to missing to avoid miscodings
*replaced on some because zero includes both no mortgage and not a homeowner, but wanted to include no mortgage for accuracy 
	recode homeowner_ (5/8=0) (9=.) 
		*filling in missing values for the homeowner variable
		replace homeowner_ = 1 if hv_ >= 0 & hv_ <.
		replace homeowner_ = 0 if hv_ == .
	
*coding rents and no mortgage as zero, but can be changed 
*before recode (0) was not homeowner & (5) was no mortgage
	recode mort_ (9=.) (8=.) (5=0)  
		replace mort_ = 1 if mort_ ==. &  pr_ > 0 & pr_ < .
	recode mint_ (98=.) (99=.)
		replace mint_ = . if homeowner == 0 
	recode morig_ (9998=.) (9999=.) 
	recode yrs_remain_ (98=.) (99=.) 
		replace yrs_remain_ =. if homeowner == 0 
	recode refi_ (8=.) (9=.) 

	recode mtypevar_ (8/9=.) 
*replacing some of the m2 variables with (.) if don't have a second mortgage 
	recode m2_ (8=.)(9=.) (5=0) //yes or no 
	recode m2type_ (8=.) (9=.) 
	recode m2pay_ (99998=.) (99999=.)
		replace m2pay_ = . if m2_ == 0
	recode m2pr_ (9999998=.) (9999999=.)
		replace m2pr_ = . if m2_ == 0
	recode m2int_ (98=.) (99=.)
		replace m2int_ = . if m2_ == 0
	recode m2orig_ (9998=.) (9999=.) 
	recode m2typevar_ (8=.) (9=.) 
	recode move_ (8=.) (9=.) (5=0)
	recode sell_ (8=.) (9=.) (5=0)
	recode mtype_ (8=.) (9=.) 
	recode sell_hv_ (999999998=.) (999999999=.) (0=.) //0 did not sell home 
	recode otherm_ (8=.) (9=.) (5=0) (2=0) (3=1)
	recode mod_ (8=.) (9=.) (5=0) 
	recode months_behind_mtge_ (98=.) (99=.) 
		replace months_behind_mtge_ = . if mort_ == 0 
	recode months_behind_mtge_2_ (98=.) (99=.)
		replace months_behind_mtge_2_ = . if m2_ == 0 
	recode forc_ (8=.) (9=.) (5=0)
	recode mo1fc_ (98=.) (99=.) 
	recode yr1fc_ (9998=.) (9999=.) 
	recode forc2_ (8=.) (9=.) (5=0) 
	recode mo2fc_ (98=.) (99=.)
	recode likely_fall_beh_mtg_1_ (8/9=.)
	recode likely_fall_beh_mtg_2_ (8/9=.) 
	recode weeks_hospital_hd_(98=.) (99=.) 
*recoding spouse vars with (.) if no spouse (if spouse_age_ == 0)	
	recode weeks_hospital_sp_(98=.) (99=.) 
		replace weeks_hospital_sp_ = . if spouse_age_ == 0
	recode wtr_any_fam_health_ins_ (0=.) (5=0) (8/9=.) 
	recode relig_pref_hd_ (99=.) (98=.)
	recode relig_pref_sp_ (99=.) (98=.)
		replace relig_pref_sp_ = . if spouse_age_ == 0 
	recode psych_distress_ (99=.) 
	
*unemployment varaibles
	recode lfs_indiv_ (9=.) (0=.) 
	recode udur_ (98/99=.)
	recode udur_sp_ (98/99=.) // unemployment duration 
		replace udur_sp_ = . if spouse_age_ == 0 
	recode metro_ (99=.) 
	 
*income variables
	replace lfs1_sp_ = . if spouse_age_ == 0
	replace lfs2_sp_ = . if spouse_age_ == 0 
	replace lfs3_sp_ = . if spouse_age_ == 0 
	recode unemp_prev_yr_ (8/9=.) (0=.) (5=0) 
	recode unemp_prev_yr_sp_ (8/9=.) (5=0) 
		replace unemp_prev_yr_sp_ =. if spouse_age_ == 0 
	recode wife_recd_inc_ (8/9=.) (0=.) (5=0)
		replace wife_recd_inc = . if spouse_age == 0 
	recode unemp_comp_ (8/9=.) (0=.) (5=0)
	recode workers_comp_ (8/9=.) (0=.) (5=0)
	recode welfare_hd_(8/9=.) (0=.) (5=0)
	recode welfare_sp_ (8/9=.) (5=0)
		replace welfare_sp_ = . if spouse_age_ == 0 
		
	
*why end/ beginning job
	recode reason_endj1_ (9=.)
	recode reason_endj2_ (9=.)
	recode reason_endj3_ (9=.)
	recode reason_endj4_ (9=.)
	recode beg_yrj2_ (9998/9999=.)
	recode beg_yrj3_ (9998/9999=.)
	recode beg_yrj4_ (9998/9999=.)
	recode beg_yrj1_sp_ (9998/9999=.) 
	recode beg_yrj2_sp_ (9998/9999=.) 
	recode beg_yrj3_sp_ (9998/9999=.) 
	recode beg_yrj4_sp_ (9998/9999=.) 
	
*if you want to keep no spouse in 0 code then delete replace code
*coded it out bc 0 also includes still working for this employer
	recode reason_endj1_sp_ (9=.)
		replace reason_endj1_sp_ = . if spouse_age_ == 0 
	recode reason_endj2_sp_ (9=.)
		replace reason_endj2_sp_ = . if spouse_age_ == 0 
	recode reason_endj3_sp_ (9=.)
		replace reason_endj3_sp_ = . if spouse_age_ == 0 
	recode reason_endj4_sp_ (9=.)
		replace reason_endj4_sp_ = . if spouse_age_ == 0 
	
	recode savings_ (8/9=.) (5=0)
	

	
*****************************generating new variables*************************

*combined remaining principle
	gen combined_rem_prin_ =  pr_ + m2pr_
gen combined_rem_prin_real_ = pr_real_ + m2pr_real_
*LTVs
	gen CLTV_ = (combined_rem_prin_)/hv_
		gen CLTV_real_ = (combined_rem_prin_real_)/hv_real_
	gen LTV_1_ = pr_ /hv_
		gen LTV_1_real_ = pr_real_ /hv_real_
	gen LTV_2_real_ = m2pr_real_ / hv_real_
	
*mortgage type dummies	(the same as mort_ & m2_ but created in case want to keep those as categorical)
	gen mort_1_flag = (mort_ == 1)
		replace mort_1_flag = . if mort_ == .
		label var mort_1_flag "have a first mortgage"

	gen m2_flag_ = (m2_==1)
		label var m2_flag_ "have a second mortgage"

	gen homeowner_ever_ = 0 
	 replace homeowner_ever_ = 1 if homeowner_ == 1
		label var homeowner_ever_ "transitioned to owning before or during this yr"
	
****creating categorical variables for demographics 
* race: 1 = white, 2 = black, 3 = other 
	gen race_ = 0 
	replace race_ = 1 if race_exp_ == 1
	replace race_ = 2 if race_exp_ == 2
	replace race_ = 3 if race_exp_ >= 3  
	replace race_ = . if race_exp == . 

*married
	gen married_ = 0
	replace married_ = 1 if marr_status_ == 1 
	replace married_ = . if marr_status_ == . 
	
***creating categorical variable for educ of head
* 0 = less than HS, 1 = HS, 2 = 2 year college, 3 = 4 year college, 4 = Post grad
	gen educ_ = 0 if educ_exp_< 12 
	replace educ_= 1 if educ_exp_ == 12
	replace educ_ = 2 if educ_exp_ == 14
	replace educ_ = 3 if educ_exp_ == 16
	replace educ_ = 4 if educ_exp_ == 17
	
***creating categorical variable for educ of head
* 0 = less than HS, 1 = HS, 2 = 2 year college, 3 = 4 year college, 4 = Post grad
	gen educ_sp_ = 0 if educ_exp_< 12 
	replace educ_sp_= 1 if educ_exp_sp_ == 12
	replace educ_sp_ = 2 if educ_exp_sp_ == 14
	replace educ_sp_ = 3 if educ_exp_sp_ == 16
	replace educ_sp_ = 4 if educ_exp_sp_ == 17	
	replace educ_sp_ = . if spouse_age_ == 0

*labor force status for spouse 1st, 2nd, 3rd mention combined 
*like prioritized version for head, lfs_indiv_ 
	gen lfs_indiv_sp = 2 if (lfs1_sp_ == 2 | lfs2_sp_ == 2 | lfs3_sp_ == 2)
	replace lfs_indiv_sp = 1 if (lfs1_sp_ == 1 | lfs2_sp_ == 1 | lfs3_sp_ == 1) & lfs_indiv_sp == .
	replace lfs_indiv_sp = 3 if (lfs1_sp_ == 3 | lfs2_sp_ == 3 | lfs3_sp_ == 3) & lfs_indiv_sp == .
	replace lfs_indiv_sp = 4 if (lfs1_sp_ == 4 | lfs2_sp_ == 4 | lfs3_sp_ == 4) & lfs_indiv_sp == .
	replace lfs_indiv_sp = 5 if (lfs1_sp_ == 5 | lfs2_sp_ == 5 | lfs3_sp_ == 5) & lfs_indiv_sp == .
	replace lfs_indiv_sp = 7 if (lfs1_sp_ == 7 | lfs2_sp_ == 7 | lfs3_sp_ == 7) & lfs_indiv_sp == .
	replace lfs_indiv_sp = 6 if (lfs1_sp_ == 6 | lfs2_sp_ == 6 | lfs3_sp_ == 6) & lfs_indiv_sp == .
	replace lfs_indiv_sp = 8 if (lfs1_sp_ == 8 | lfs2_sp_ == 8 | lfs3_sp_ == 8) & lfs_indiv_sp == .

*retired
	gen retired_ = (lfs1_ == 4 | lfs2_ == 4 | lfs3_ == 4)
	gen retired_sp_ = (lfs1_sp == 4 | lfs2_sp == 4 | lfs3_sp == 4)
*student 
	gen student_ = (lfs1_ == 7 | lfs2_ == 7 | lfs3_ == 7)
	gen student_sp_ = (lfs1_sp == 7 | lfs2_sp == 7 | lfs3_sp == 7)	


*income levels
gen income_levels_real_ = 0
replace income_levels_real_ = 1 if total_fam_inc_real_ >=0 & total_fam_inc_real_ <=50000
replace income_levels_real_ = 2 if total_fam_inc_real_ >50000 & total_fam_inc_real_ <=100000
replace income_levels_real_ = 3 if total_fam_inc_real_ >100000 & total_fam_inc_real_ <=150000
replace income_levels_real_ = 4 if total_fam_inc_real_ >150000 & total_fam_inc_real_ <=200000
replace income_levels_real_ = 5 if total_fam_inc_real_ >200000 & total_fam_inc_real_ !=.
recode income_levels_real_ (0=.)

gen income_levels_ = 0
replace income_levels_ = 1 if total_fam_inc_ >=0 & total_fam_inc_ <=50000
replace income_levels_ = 2 if total_fam_inc_ >50000 & total_fam_inc_ <=100000
replace income_levels_ = 3 if total_fam_inc_ >100000 & total_fam_inc_ <=150000
replace income_levels_ = 4 if total_fam_inc_ >150000 & total_fam_inc_ <=200000
replace income_levels_ = 5 if total_fam_inc_ >200000 & total_fam_inc_ !=.
recode income_levels_ (0=.)


***CLTV categorized
gen CLTV_levels_ = 0 
replace CLTV_levels_ = 1 if CLTV_ <= .2 
replace CLTV_levels_ = 2 if CLTV_ >.2 & CLTV_<= .4 
replace CLTV_levels_ = 3 if CLTV_ >.4 & CLTV_<= .6 
replace CLTV_levels_ = 4 if CLTV_ >.6 & CLTV_<= .8 
replace CLTV_levels_ = 5 if CLTV_ >.8 & CLTV_<= 1.0 
replace CLTV_levels_ = 6 if CLTV_ >1.0 & CLTV_<= 1.2
replace CLTV_levels_ = 7 if CLTV_ >1.2 & CLTV_<= 1.4 
replace CLTV_levels_ = 8 if CLTV_ >1.4 & CLTV_<= 1.6
replace CLTV_levels_ = 9 if CLTV_ >1.6 & CLTV_<= 1.8 
replace CLTV_levels_ = 10 if CLTV_ >1.8 & CLTV_<= 2.0 
replace CLTV_levels_ = 11 if CLTV_ >2.0 & CLTV_<= 2.2
replace CLTV_levels_ = 12 if CLTV_ >2.2 & CLTV_<= 2.4
replace CLTV_levels_ = 13 if CLTV_ >2.4 & CLTV_<= 2.6 
replace CLTV_levels_ = 14 if CLTV_ >2.6 & CLTV_<= 2.8
replace CLTV_levels_ = 15 if CLTV_ >2.8 & CLTV_<= 3.0



gen LTV_levels_ = 0 
replace LTV_levels = 1 if LTV_1_ <.2
replace LTV_levels_ = 2 if LTV_1_ >.2 & LTV_1_<= .4 
replace LTV_levels_ = 3 if LTV_1_ >.4 & LTV_1_<= .6 
replace LTV_levels_ = 4 if LTV_1_ >.6 & LTV_1_<= .8 
replace LTV_levels_ = 5 if LTV_1_ >.8 & LTV_1_<= 1.0 
replace LTV_levels_ = 6 if LTV_1_ >1.0 & LTV_1_<= 1.2
replace LTV_levels_ = 7 if LTV_1_ >1.2 & LTV_1_<= 1.4 
replace LTV_levels_ = 8 if LTV_1_ >1.4 & LTV_1_<= 1.6
replace LTV_levels_ = 9 if LTV_1_ >1.6 & LTV_1_<= 1.8 
replace LTV_levels_ = 10 if LTV_1_ >1.8 & LTV_1_<= 2.0 
replace LTV_levels_ = 11 if LTV_1_ >2.0 & LTV_1_<= 2.2
replace LTV_levels_ = 12 if LTV_1_ >2.2 & LTV_1_<= 2.4
replace LTV_levels_ = 13 if LTV_1_ >2.4 & LTV_1_<= 2.6 
replace LTV_levels_ = 14 if LTV_1_ >2.6 & LTV_1_<= 2.8
replace LTV_levels_ = 15 if LTV_1_ >2.8 & LTV_1_<= 3.0
replace LTV_levels = 16 if LTV_1_ >3.0

*real 
gen LTV_levels_real_ = 0 
replace LTV_levels_real_ = 1 if LTV_1_real_ <.2
replace LTV_levels_real_ = 2 if LTV_1_real_ >.2 & LTV_1_real_<= .4 
replace LTV_levels_real_ = 3 if LTV_1_real_ >.4 & LTV_1_real_<= .6 
replace LTV_levels_real_ = 4 if LTV_1_real_ >.6 & LTV_1_real_<= .8 
replace LTV_levels_real_ = 5 if LTV_1_real_ >.8 & LTV_1_real_<= 1.0 
replace LTV_levels_real_ = 6 if LTV_1_real_ >1.0 & LTV_1_real_<= 1.2
replace LTV_levels_real_ = 7 if LTV_1_real_ >1.2 & LTV_1_real_<= 1.4 
replace LTV_levels_real_ = 8 if LTV_1_real_ >1.4 & LTV_1_real_<= 1.6
replace LTV_levels_real_ = 9 if LTV_1_real_ >1.6 & LTV_1_real_<= 1.8 
replace LTV_levels_real_ = 10 if LTV_1_real_ >1.8 & LTV_1_real_<= 2.0 
replace LTV_levels_real_ = 11 if LTV_1_real_ >2.0 & LTV_1_real_<= 2.2
replace LTV_levels_real_ = 12 if LTV_1_real_ >2.2 & LTV_1_real_<= 2.4
replace LTV_levels_real_ = 13 if LTV_1_real_ >2.4 & LTV_1_real_<= 2.6 
replace LTV_levels_real_ = 14 if LTV_1_real_ >2.6 & LTV_1_real_<= 2.8
replace LTV_levels_real_ = 15 if LTV_1_real_ >2.8 & LTV_1_real_<= 3.0
replace LTV_levels_real_ = 16 if LTV_1_real_ >3.0
	
************************************FLAGS**************************************
****demographics***
*less than HS
	gen less_than_HS_ = 0
		replace less_than_HS_ = 1 if educ_exp_ <12
		
*just HS
	gen HS_flag_ = 0
		replace HS_flag_ = 1 if educ_exp_ == 12
		
*some of college
	gen some_college_ = 0
		replace some_college_ = 1 if educ_exp_ >12 & educ_exp_ <16
		
*college grad
	gen college_grad_ = 0 
		replace college_grad_ = 1 if educ_exp_ == 16
		
*college grad and some post grad
	gen college_grad_plus_ = 0 
		replace college_grad_plus_ = 1 if educ_exp_ == 17
	
*religion flag 
	gen relig_hd_flag_=0
		replace relig_hd_flag_=1 if relig_pref_hd_ <=97

	gen relig_sp_flag_=0
			replace relig_sp_flag_=1 if relig_pref_sp_ <=97
			replace relig_sp_flag_ =. if spouse_age_ == 0 
			
*Psychological distress (0-24 scale) 
	gen distress_flag_ = 0 
		replace distress_flag_=1 if psych_distress_>=13
			
*hospitalization 
	gen hosp_hd_flag_ = 0
		replace hosp_hd_flag_=1 if weeks_hospital_hd_>0 & weeks_hospital_hd_<=52 
		
	gen hosp_sp_flag_= 0
		replace hosp_sp_flag_=1 if weeks_hospital_sp_>0 & weeks_hospital_sp_<=52 
		
*divorce flag
	gen divorced_flag_ = 0
		replace divorced_flag_ = 1 if marr_status_ == 4 
	
*unemployment head current 
*2-temp laid off, 3- looking for work 
	gen unemploy_curr_hd_ = 0
		replace unemploy_curr_hd = 1 if lfs1_==2 | lfs1_==3 | lfs2_==2 | lfs2_==3 ///
		| lfs3_==2 |lfs3_==3

*unemployment spouse current
	gen unemploy_curr_sp_ = 0
		replace unemploy_curr_sp_ = 1 if lfs1_sp_==2 | lfs1_sp_==3 | lfs2_sp_==2 ///
		| lfs2_sp_==3 | lfs3_sp_==2 | lfs3_sp_==3

***mortgage***		
*delinquency flags 60 days delinquent
	gen delinq_flag_ = 0
		replace delinq_flag_ = 1  if months_behind_mtge_ >= 3 
		replace delinq_flag_ = 0 if months_behind_mtge_ == . 
		//to account for stata thinking (.) is a very large number 

	gen delinq_2flag_ = 0
		replace delinq_2flag_ = 1 if months_behind_mtge_2_ >= 3
		replace delinq_2flag_ = 0 if months_behind_mtge_2_ ==.
		
	gen mort_flag_ = 0 
		replace mort_flag_ = 1 if mort_ == 1
		
	gen refinanced_flag_ = 0
		replace refinanced_flag = 1 if refi_ == 2
		
	gen mort_2_flag_ = 0
		replace mort_2_flag_ = 1 if m2_ == 1

*Months unemployed flag by every three months for head
	gen unemployed_1_3_m_flag_ = 0
		replace unemployed_1_3_m_flag_ = 1 if udur_ >=1 & udur_ <=3  

	gen unemployed_4_6_m_flag_ = 0
		replace unemployed_4_6_m_flag_ = 1 if udur_ >=4 & udur_ <=6

	gen unemployed_7_9_m_flag_ = 0
		replace unemployed_7_9_m_flag_ = 1 if udur_ >=7 & udur_ <=9

	gen unemployed_10_12_m_flag_ = 0 
		replace unemployed_10_12_m_flag_ = 1 if udur_ >=10 & udur_ <=12


*Months unemployed flag by every three months for spouse
	gen unemployed_1_3_m_sp_flag_ = 0
		replace unemployed_1_3_m_sp_flag_ = 1 if udur_sp_ >=1 & udur_sp_ <=3  

	gen unemployed_4_6_m_sp_flag_ = 0
		replace unemployed_4_6_m_sp_flag_ = 1 if udur_sp >=4 & udur_sp <=6

	gen unemployed_7_9_m_sp_flag_ = 0
		replace unemployed_7_9_m_sp_flag_ = 1 if udur_sp_ >=7 & udur_sp_ <=9

	gen unemployed_10_12_m_sp_flag_ = 0 
		replace unemployed_10_12_m_sp_flag_ = 1 if udur_sp_ >=10 & udur_sp_ <=12

*likely to fall behind on mtg     
 // 1-very likely, 3-somewhat likely, 5-not likely at all    
	gen likely_fall_behind_flag_=0
		replace likely_fall_behind_flag_=1 if (likely_fall_beh_mtg_1_<=3 | ///
		likely_fall_beh_mtg_2_ <=3) & likely_fall_beh_mtg_1_ !=0 & likely_fall_beh_mtg_1_ !=0 

*groupings for months behind on first mtge 
	gen zero_months_behind_=0
		replace zero_months_behind_=1 if months_behind_mtge_==0
	gen one_months_behind_=0
		replace one_months_behind_=1 if months_behind_mtge_==1
	gen two_months_behind_=0
		replace two_months_behind_=1 if months_behind_mtge_==2
	gen three_months_behind_=0
		replace three_months_behind_=1 if months_behind_mtge_==3
	gen four_months_behind_=0 
		replace four_months_behind_=1 if months_behind_mtge_==4
	gen five_months_behind_=0
		replace five_months_behind_=1 if months_behind_mtge_==5
	gen  six_months_behind_=0
		replace six_months_behind_=1 if months_behind_mtge_==6
	gen seven_months_behind_=0
		replace seven_months_behind_=1 if months_behind_mtge_==7
	gen eight_months_behind_=0
		replace eight_months_behind_=1 if months_behind_mtge_==8
	gen nine_months_behind_=0
		replace nine_months_behind_=1 if months_behind_mtge_==9
	gen ten_months_behind_=0
		replace ten_months_behind_=1 if months_behind_mtge_==10	
	gen eleven_months_behind_=0
		replace eleven_months_behind_=1 if months_behind_mtge_==11
	gen twelve_months_behind_=0
		replace twelve_months_behind_=1 if months_behind_mtge_==12		
	gen more_twelve_months_behind_=0
		replace more_twelve_months_behind_=1 if months_behind_mtge_ >12 & months_behind_mtge_ <=48

***making flags easily identifable 
	gen male_flag_ = 0
	replace male_flag_ = 1 if sex_ == 1 
	label variable male_flag_ "head is a male"


	rename married_ married_flag_ 
	rename forc_ forc_flag_ 
	rename forc2_ forc2_flag 

*black dummy variable
gen black_ = 0 
replace black_ =1 if race_ == 2 

*0 months unemplpyed
gen unemployed_0_m_flag_ = 0
replace unemployed_0_m_flag_ = 1 if udur_ == 0 
gen female_flag_ = 0 
replace female_flag_ = 1 if sex_ == 2


gen wtr_marr_div_ = 0 
replace wtr_marr_div = 1 if married_flag_ ==1
replace wtr_marr_div = 2 if divorced_flag_ == 1
label var wtr_marr_div "married (1), dirvorced (2)"
	
gen educ_2levels = 0 if educ_ == 0 | educ_ == 1 
replace educ_2levels = 1 if educ_ == 2 | educ_ == 3 | educ_ == 4 
label var educ_2levels "HS or less (0), College or more (1)"


******************

**************************************Labeling Variables************************		
*with categorical variable descriptions
label variable release_ "release number"
label variable age_ "age of head"
label variable sex_ "sex of head"
label variable marr_status_ "head marrital status" 
// 1 Married 2 Never married 3 Widowed 4 Divorced, annulled 5 Separated
label variable race_exp_ "race of head expanded"
//1 White 2 Black, African-American, or Negro 3 American Indian or Alaska Native 4 Asian 5 Native Hawaiian or Pacific Islander 7 Other
label variable educ_exp_ "completed ed head"
label variable educ_exp_sp "completed ed head"
label variable int_num_ "interview number"
label variable seq_num_ "sequence numner"
label variable rel_head_ "relation to head"
// 10 head, 20 22 legal wife or "wife"
label variable likely_fall_beh_mtg_1_ "likely to fall behind on mtg #1"
label variable likely_fall_beh_mtg_2_ "likely to fall behind on mtg #2"
// 1 very likely, 3 somewhat likely 5 not likely at all, 0 no mortgage on home/not homeowner
label variable weeks_hospital_hd_ "# weeks in hospital head"
label variable weeks_hospital_sp_ "# weeks in hospital spouse"
label variable psych_distress_ "non-spec psych distress scale 0-24"
label variable wtr_any_fam_health_ins_ "wtr fu member w/ hlth ins last 2 years" 
label variable relig_pref_sp_ "relgious pref spouse"
label variable relig_pref_hd_ "relgious pref head"
// 1 catholic, 2 jewish, 8 protestant, 10 muslim, rastafarian, etc.,13 greek/russian, eastern orth., 97 other, 0 agnostic
label variable homeowner_ "own or rent?"
label variable hv_ "house value" 
label variable mort_ "have mortgage"
// 1 yes, 5 no, 0 pays rent (or neither)
label variable mtype_ "1st mortgage type" 
// 1 mortgage, 2 land contract, 3 home equity, 4 home improvement, 5 line of credit, 7 other, 0 rents or no mtg 
label variable refi_ "wtr refinanced mortgage loan"
// 1 original, 2 refinanced, 0 not a homeowner, no mtg, or loan type is not a mtg
label variable pr_ "remaining principal mtg #1" 
// 0 no mtg on home
label variable mpay_ "monthly payments mtg #1"
label variable mtypevar_ "type of loan (var/fixed) mtg #1"
//1 fixed, 2 variable, 0 rents or no mtg
label variable mint_ "current interest rate (whole%) mtg #1"
label variable morig_ "year obtained original loan mtg #1"
//0 no mortgage on home 
label variable yrs_remain_ "years to pay mtg #1"
//0 no mtg on home
label variable months_behind_mtge_ "months behind on mtg #1"
//0 no mtg on home or not currently behind on payments (not a homeowner are coded as missing)
label variable forc_ "wtr forclosed on mtg #1"
label variable mo1fc_ "month forclosure on mtg #1"
// 1-12 months, 21 Winter 22 Spring 23 Summer 24 Fall; Autumn 
label variable yr1fc_ "year forclosure on mtg #1"
label variable mod_ "wtr modified mortgage"
//0 no mtg or didnt modify mtg
label variable m2_ "wtr have a 2nd mortgage"
//1 yes, 0 no 
label variable m2type_ "2nd mortgage type"
//// 1 mortgage, 2 land contract, 3 home equity, 4 home improvement, 5 line of credit, 7 other, 0 rents or no mtg 
label variable m2pr_ "remaining principal mtg #2"
label variable m2pay_ "monthly payments mtg #2"
//0 no second mortgage
label variable m2typevar "type of loan (var/fixed) mtg #2"
//1 fixed, 2 variable, 0 not homowner, no mtg on home, no second mtg
label variable m2int_ "cureent interest rate (whole%) mtg #2"
// 1-65 actualy number tab
label variable m2orig_ "year obtained oringinal loan mtg #2"
// 0 not homowner, no mtg on home, no second mtg
label variable months_behind_mtge_2_ "months behind on mtg #2"
// 1-97 actual months; 0 not currently behind
label variable forc2_"wtr forclosed on mtg #2"
label variable mo2fc_ "month forclosure on mtg #2"
//1-12 months,21 Winter 22 Spring 23 Summer 24 Fall; Autumn 
label variable yr2fc_ "year forclosure on mtg #2"
label variable move_ "wtr moved since jan 1 of prior year" // 1 yes, 0 no 
label variable sell_ "wtr sold home" // 1 yes, 0 no 
label variable sell_hv_ "home selling price"
label variable otherm_ "wtr bought other real estate"
label variable lfs1_ "employment status head-1st mention"
label variable lfs2_ "employment status head-2nd mention"
label variable lfs3_ "employment status head-3rd mention"
// 1 Working now 2 Only temporarily laid off, sick leave or maternity leave
// 3 Looking for work, unemployed 4 Retired 5 Permanently disabled; temporarily disabled 
// 6 Keeping house 7 Student 8 Other; "workfare"; in prison or jail
label variable lfs1_sp_ "employment status spouse-1st mention"		
label variable lfs2_sp_ "employment status spouse-2nd mention"		
label variable lfs3_sp_ "employment status spouse-3rd mention"	
// 0 no second or third mention 
label variable udur_ "unemployment duration head(months) prev year"
label variable udur_sp_	"unemployment duration spouse(months) prev year"	
label variable lfs_indiv_ "prioratized version of employmend status"
//1 Working now 2 Only temporarily laid off 3 Looking for work, unemployed 
//4 Retired 5 Permanently disabled 6 HouseWife; keeping house 7 Student 8 Other
label variable fips_state"state number"
label variable metro_ "rural urban code"
     * 1-central counties of metropolitian areas >= 1,000,000
	 * 2-fringe counties of metro >= 1,000,000
	 * 3-counties in metro areas, 250,000-1,000,000
	 * 4-counties in metro areas <250,000
	 * 5-urban pop >= 20,000 adj to metro area
	 * 6-urban pop 20,000, not adj to metro area
	 * 7-urban pop <20,000, adj to metro areas
	 * 8-urban pop <20,000, not adj to metro area
	 * 9-completely rural 
	 * 0-foreign country
label variable state_ "current state"
label variable hpi "housing price index (mean)"
label variable combined_rem_prin_ " remaining prin mtg#1 & mtg#2"
label variable CLTV_ "combined loan to value ratio- mtg 1 & mtg 2 "
label variable LTV_1_ "loan to value ratio mtg #1"
label variable LTV_2_ "loan to value ratio mtg #2"
label variable race_ "white, black, or other head"
label variable married_ "married flag"
label variable educ_ "education levels head"
//(0) less than HS, (1) HS, (2) 2 year college, (3) 4 year college, (4) Post grad
label variable educ_sp_ "education levels spouse"
label variable less_than_HS_ "less than HS educ flag"
label variable HS_flag_ "HS educ flag"
label variable some_college_ "completed some of college flag"
label variable college_grad_ "college graduate flag"
label variable college_grad_plus_ "college grad and some grad school flag"
label variable relig_hd_flag_ "head believes some religion flag"
label variable relig_sp_flag_ "spouse believes some religion flag"
label variable distress_flag_ "mild to severe pysch distress flag"
//>=13 on a 0-24 scale
label variable hosp_hd_flag_ "head hospitalized flag"
label variable hosp_sp_flag_ "spouse hospitalized flag"		
//hospitalized for any amount of weeks
label variable divorced_flag_ "divorced flag"
label variable unemploy_curr_hd_ "head currently unemployed flag"
label variable unemploy_curr_sp_ "spouse currently unemployed flag"
label variable delinq_flag_ "3 months or more behind on mtg #1"
label variable delinq_2flag_ "2 months or more behind on mtg #2"
label variable unemployed_1_3_m_flag_ "unemployed head 1-3 months"
label variable unemployed_4_6_m_flag_ "unemployed head 4-6 months"
label variable unemployed_7_9_m_flag_ "unemployed head 7-9 months"
label variable unemployed_10_12_m_flag_ "unemployed head 10-12 months"
label variable unemployed_1_3_m_sp_flag_ "unemployed spouse 1-3 months" 
label variable unemployed_4_6_m_sp_flag_ "unemployed spouse 4-6 months" 
label variable unemployed_7_9_m_sp_flag_ "unemployed spouse 7-9 months" 
label variable unemployed_10_12_m_sp_flag_ "unemployed spouse 10-12 months" 
label variable likely_fall_behind_flag_ "likely to fall behind on mtg"
// 1 somewhat or very likely to fall behind on mtg
label variable zero_months_behind_ "zero months behind flag"
label variable one_months_behind_ "one months behind flag"
label variable two_months_behind_ "two months behind flag"
label variable three_months_behind_ "three months behind flag"
label variable four_months_behind_ "four months behind flag"
label variable five_months_behind_ "five months behind flag"
label variable six_months_behind_"six months behind flag"
label variable seven_months_behind_ "seven months behind flag"
label variable eight_months_behind_ "eight months behind flag"
label variable nine_months_behind_ "nine months behind flag"
label variable ten_months_behind_ "ten months behind flag"		
label variable eleven_months_behind_ "eleven months behind flag"		
label variable twelve_months_behind_ "twelve months behind flag"		
label variable more_twelve_months_behind_ "more than 12 months behind flag"	
label variable year "year of survey"
label variable famidpn "unique id # for each observation"
label variable mort_flag_ "mortgage #1 flag"
label variable mort_2_flag_ "mortgage #2 flag"
label variable refinanced_flag_ " mtg #1 refinanced flag"
label variable retirement_inc_hd_ "wtr retirement income during prev year" 
label variable spouse_age_ "age of wife/spouse"
label variable total_fam_inc_ "combined family income from prev year"
label variable welfare_hd_ "wtr welfare income during prev year-head"
label variable welfare_sp_ "wtr welfare income during prev yr-spouse"
label variable wife_recd_inc_ "wtr wife/spouse recieved income during prev year"
label variable workers_comp_ "wtr recieved workers comp during prev year"
label variable unemp_comp "wtr recieved unemployment comp during prev year"
label variable unemp_prev_yr_ "wtr unemployed during the prev year-head"
label variable unemp_prev_yr_sp_ "wtr unemployed during the prev year_ spouse"
label variable labor_inc_hd_ "labor income of head during prev year"  
/// includes wages & salaries, bonuses, overtime, tips, commissions, professional trade
/// market gardening, additional job income, & miscellaneous labor income
label variable labor_inc_sp_ "labor income of spouse during prev year" 
label variable end_yrj1_ "year last main job ended"
// 9996 (2007-2009, DK which year), 9997(before specific year, but DK year)
//0 did not work for money during prev year or still working for this employer
label variable end_yrj2_ "year 2nd job ended"
//0 did not work for money during prev year, didn't have a 2nd job, or still working for this employer
label variable end_yrj3_ "year 3rd job ended"
label variable end_yrj4_ "year 4th job ended"
label variable end_yrj1_sp_ "year last main job ended-spouse" 
// 9996 (2007-2009, DK which year), 9997(before specific year, but DK year)
//0 no wife, did not work for money during prev year, or still working for this employer
label variable end_yrj2_sp_ "year 2nd job ended-spouse"
//0 also no second employer
label variable end_yrj3_sp_ "year 3rd job ended-spouse"
label variable end_yrj4_sp_ "year 4th job ended-spouse"
label variable reason_endj1_ "reason last main job ended"
//1) Company folded 2) Strike; lockout 3) Laid off; fired 4) Quit; resigned; retired; pregnant; needed more money; just wanted a change 
//7) Other; transfer; any mention of armed services 8) temporary job 
//0) did not work for money during prev year, began working for this employer in this year; still working for this employer
label variable reason_endj2_ "reason 2nd job ended"
label variable reason_endj3_ "reason 3rd job ended"
label variable reason_endj4_ "reason 4th job ended"
label variable reason_endj1_sp_ "reason last main job ended-spouse"
//1) Company folded 2) Strike; lockout 3) Laid off; fired 4) Quit; resigned; retired; pregnant; needed more money; just wanted a change 
//7) Other; transfer; any mention of armed services 8) temporary job 
//0) no wife, did not work for money during prev year, began working for this employer in this year; still working for this employer
label variable reason_endj2_sp_ "reason 2nd job ended-spouse"
//0 also no second employer
label variable reason_endj3_sp_ "reason 3rd job ended-spouse"
label variable reason_endj4_sp_ "reason 4th job ended-spouse"
label variable savings_ "wtr have CK/savings/CD" 
label variable taxable_inc_hd_sp_ "head & spouse total taxable income prev year"
// Head's and Wife's/"Wife's" income from assets, earnings, and net profit from farm or business
label variable debt_flag_ "wtr debts other than mortgage & cars"
//credit card charges, student loans, medical or legal bills, or loans from relatives
label variable value_debts_ "value of all other debts"
//1-999,999,996, 0 none
label variable num_jobs_ "number of jobs during prev year"
label variable num_jobs_sp_ "number of jobs during prev yr spouse"
label variable retired_ "wtr retired-head"
label variable retired_sp_ "wtr retired-spouse" 
label variable student_ "wtr student-head"
label variable student_sp_ "wtr student-spouse"
label variable lfs_indiv_sp "prioratized version of emp status-spouse"
label var beg_yrj1_ "year last main job began"
// 0 did not work for money
//1997- before specific year (DK exact), 1996-between int. years (DK exact)
label var beg_yrj2_ "year 2nd job began"
// 0 did not work for money in the past year, or did not have a second job 
label var beg_yrj3_ "year 3rd job began"
label var beg_yrj4_ "year 4th job began"
label var beg_yrj1_sp "year last main job began-spouse"
// 0 no wife, did not work for money, etc... 
label var beg_yrj2_sp "year 2nd job began-spouse" 
label var beg_yrj3_sp "year 3rd job began-spouse" 
label var beg_yrj4_sp "year 4th job began-spouse"
label var value_vehicles_ "profit if sold vehicles"
//-99,999,999 Loss of $99,999,999 or more; or loss but DK how much 
label var value_stock_ "profit if sold non-ira stocks"
// 0 value is zero, does not own stocks
//-99,999,999 Loss of $99,999,999 or more; or loss but DK how much 
label var ira_ "value of idividual retirement acc + annuity"
// 0 value is 0 or doesn't have money in private annuitites or IRAs
label var liq_assets_ "value all accounts" 
label var bonds_ "profit if sold bonds/insurance"
label var profit_otr_real_estate_ "profit if sold other real estate"
//-99,999,999Loss of $99,999,999 or more, loss DK how much, don't own real estate other than home 
label var bus_profit_ "profit if sold farm or business" 
// 0 zero, or doesn't own a business or farm 
//-99,999,999Loss of $99,999,999 or more; Loss DK how much 
label var unemployed_0_m_flag_ "uemployed head 0 months"
label var female_flag_ "female head flag"
rename black_ black_flag_ 
label var black_flag_ "black flag"
label var CLTV_levels_ "levels of CLTV (1-14) inc by .2"
label var income_levels_ "total fam income by 50K levels ang greater than 200K"


****



save "$int/cleaned_psid_05_15.dta",replace 



use "$int/cleaned_psid_05_15.dta", clear 
 

***********creating subsets*************************
preserve
***saving the version of data that is conditional on age and having a mortgage
keep if age_>=24 & age_<=65
keep if mort_flag_==1 
count
save "$int/sample_psid_05_15.dta",replace 
restore 

***creating counterfactual sample 
preserve 
keep if age_>=24 & age_ <=65
keep if mort_flag_ == 0 
count 
*82,005
save "$int/counter_psid_05_15.dta", replace 
restore 


***summary stats and graphs of full sample for presentation 
keep if age_>=24 & age_<=65


tabstat mort_flag_ m2_flag_ age_ male_flag_ married_flag_ black_ divorced_flag_ relig_hd_flag_ less_than_HS_ HS_flag_ ///
some_college_ college_grad_ college_grad_plus_ wtr_any_fam_health_ins_ , stat(n mean sd min max) save
return list

matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515_presentation1", sheet("Full_Sample") modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt

*Means graph of mortgage dummies 
graph bar (mean) m2_flag if mort_flag_==1, over(year) name(m2_if_m1, replace)
graph bar (mean) mort_flag_, over(year) name(m1, replace)
graph combine m1 m2_if_m1, ycommon name(combined_mortgages, replace)
	graph save Graph "$output\mortgages_combined.gph", replace
	graph export "$output\combined_mortgages.png", as(png) replace

**marrital status for non mortgage holders (may use)
graph bar if mort_flag_==0, over(marr_status_) ylabel(0(20)80) name(no_mortgage, replace)

**educ expanded for non mortgage holders (may use)
graph bar if mort_flag_==0, over(educ_exp_) ylabel(0(20)80) name(no_mortgage, replace)

*psid vs nlsy
graph bar, over(race_, relabel(1 White 2 Black 3 Other)) ylabel(0(10)60) name(psid_race, replace)
graph save Graph "$output\race_full_sample.gph", replace 


*calculating the mean of total family income for the full sample
preserve
keep if total_fam_inc_ >=0
 
sum total_fam_inc_Real_

restore


	
**********SUBGROUPS**************
*white women
preserve 
	keep if male_flag_ == 0 
	keep if race_ == 1 
	
tabstat mort_flag_ delinq_flag_ married_flag_ educ_exp_ refinanced_flag_ months_behind_mtge_ forc_flag_ udur_ unemp_prev_yr_ welfare_hd_ retirement_inc_hd_ unemp_comp_ workers_comp_ labor_inc_hd_ total_fam_inc_ ///
debt_flag_ value_debts_ , stat(n mean sd min max) save
return list

matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515_subsets2", sheet("White Women") modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt

restore 

***
*black women
preserve 
	keep if male_flag_ == 0 
	keep if race_ == 2 
	
tabstat mort_flag_ delinq_flag_ married_flag_ educ_exp_ refinanced_flag_ months_behind_mtge_ forc_flag_ udur_ unemp_prev_yr_ welfare_hd_ retirement_inc_hd_ unemp_comp_ workers_comp_ labor_inc_hd_ total_fam_inc_ ///
debt_flag_ value_debts_ , stat(n mean sd min max) save
return list

matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515_subsets2", sheet("Black Women") modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt

restore 

***
*white men 
preserve 
	keep if male_flag_ == 1
	keep if race_ == 1 
	
tabstat mort_flag_ delinq_flag_ married_flag_ educ_exp_ refinanced_flag_ months_behind_mtge_ forc_flag_ udur_ unemp_prev_yr_ welfare_hd_ retirement_inc_hd_ unemp_comp_ workers_comp_ labor_inc_hd_ total_fam_inc_ ///
debt_flag_ value_debts_ , stat(n mean sd min max) save
return list

matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515_subsets2", sheet("White Men") modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt

restore 

***
*black men
preserve 
	keep if male_flag_ == 1
	keep if race_ == 2 
	
tabstat mort_flag_ delinq_flag_ married_flag_ educ_exp_ refinanced_flag_ months_behind_mtge_ forc_flag_ udur_ unemp_prev_yr_ welfare_hd_ retirement_inc_hd_ unemp_comp_ workers_comp_ labor_inc_hd_ total_fam_inc_ ///
debt_flag_ value_debts_ , stat(n mean sd min max) save
return list

matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515_subsets2", sheet("Black Men") modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt

restore 

***
*college educated men
preserve 
	keep if male_flag_ == 1
	keep if educ_2levels == 1
	
tabstat mort_flag_ delinq_flag_ married_flag_ refinanced_flag_ months_behind_mtge_ forc_flag_ udur_ unemp_prev_yr_ welfare_hd_ retirement_inc_hd_ unemp_comp_ workers_comp_ labor_inc_hd_ total_fam_inc_ ///
debt_flag_ value_debts_ , stat(n mean sd min max) save
return list

matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515_subsets2", sheet("College Educated Men") modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt

restore
 
***
*college educated women
preserve 
	keep if male_flag_ == 0
	keep if educ_2levels == 1
	
tabstat mort_flag_ delinq_flag_ married_flag_  refinanced_flag_ months_behind_mtge_ forc_flag_ udur_ unemp_prev_yr_ welfare_hd_ retirement_inc_hd_ unemp_comp_ workers_comp_ labor_inc_hd_ total_fam_inc_ ///
debt_flag_ value_debts_ , stat(n mean sd min max) save
return list

matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515_subsets2", sheet("College Educated Women") modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt

restore 

***
*College educated white women
preserve 
	keep if male_flag_ == 0
	keep if educ_2levels == 1
	keep if race_ == 1
	
tabstat mort_flag_ delinq_flag_ married_flag_  refinanced_flag_ months_behind_mtge_ forc_flag_ udur_ unemp_prev_yr_ welfare_hd_ retirement_inc_hd_ unemp_comp_ workers_comp_ labor_inc_hd_ total_fam_inc_ ///
debt_flag_ value_debts_ , stat(n mean sd min max) save
return list

matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515_subsets2", sheet("College Educ White Women") modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt
restore

***
* College educated black women 
preserve 
	keep if male_flag_ == 0
	keep if educ_2levels == 1
	keep if race_ == 2
	
tabstat mort_flag_ delinq_flag_ married_flag_  refinanced_flag_ months_behind_mtge_ forc_flag_ udur_ unemp_prev_yr_ welfare_hd_ retirement_inc_hd_ unemp_comp_ workers_comp_ labor_inc_hd_ total_fam_inc_ ///
debt_flag_ value_debts_ , stat(n mean sd min max) save
return list

matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515_subsets2", sheet("College Educ Black Women") modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt
restore

***
*College Educated White Men
preserve 
	keep if male_flag_ == 1
	keep if educ_2levels == 1
	keep if race_ == 1
	
tabstat mort_flag_ delinq_flag_ married_flag_  refinanced_flag_ months_behind_mtge_ forc_flag_ udur_ unemp_prev_yr_ welfare_hd_ retirement_inc_hd_ unemp_comp_ workers_comp_ labor_inc_hd_ total_fam_inc_ ///
debt_flag_ value_debts_ , stat(n mean sd min max) save
return list

matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515_subsets2", sheet("College Educ White Men") modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt
restore

***
*College Educated Black men 
preserve 
	keep if male_flag_ == 1
	keep if educ_2levels == 1
	keep if race_ == 2
	
tabstat mort_flag_ delinq_flag_ married_flag_  refinanced_flag_ months_behind_mtge_ forc_flag_ udur_ unemp_prev_yr_ welfare_hd_ retirement_inc_hd_ unemp_comp_ workers_comp_ labor_inc_hd_ total_fam_inc_ ///
debt_flag_ value_debts_ , stat(n mean sd min max) save
return list

matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515_subsets2", sheet("College Educ Black Men") modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt
restore


***
*HS educated white women 
preserve 
	keep if male_flag_ == 0
	keep if educ_2levels == 0
	keep if race_ == 1
	
tabstat mort_flag_ delinq_flag_ married_flag_  refinanced_flag_ months_behind_mtge_ forc_flag_ udur_ unemp_prev_yr_ welfare_hd_ retirement_inc_hd_ unemp_comp_ workers_comp_ labor_inc_hd_ total_fam_inc_ ///
debt_flag_ value_debts_ , stat(n mean sd min max) save
return list

matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515_subsets2", sheet("HS Educ White Women") modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt
restore

***
*HS educated black women
preserve 
	keep if male_flag_ == 0
	keep if educ_2levels == 0
	keep if race_ == 2
	
tabstat mort_flag_ delinq_flag_ married_flag_  refinanced_flag_ months_behind_mtge_ forc_flag_ udur_ unemp_prev_yr_ welfare_hd_ retirement_inc_hd_ unemp_comp_ workers_comp_ labor_inc_hd_ total_fam_inc_ ///
debt_flag_ value_debts_ , stat(n mean sd min max) save
return list

matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515_subsets2", sheet("HS Educ Black Women") modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt
restore

***
*HS Educated White men 
preserve 
	keep if male_flag_ == 1
	keep if educ_2levels == 0
	keep if race_ == 1
	
tabstat mort_flag_ delinq_flag_ married_flag_  refinanced_flag_ months_behind_mtge_ forc_flag_ udur_ unemp_prev_yr_ welfare_hd_ retirement_inc_hd_ unemp_comp_ workers_comp_ labor_inc_hd_ total_fam_inc_ ///
debt_flag_ value_debts_ , stat(n mean sd min max) save
return list

matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515_subsets2", sheet("HS Educ White Men") modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt
restore


***
*HS Educated Black men 
preserve 
	keep if male_flag_ == 1
	keep if educ_2levels == 0
	keep if race_ == 2
	
tabstat mort_flag_ delinq_flag_ married_flag_  refinanced_flag_ months_behind_mtge_ forc_flag_ udur_ unemp_prev_yr_ welfare_hd_ retirement_inc_hd_ unemp_comp_ workers_comp_ labor_inc_hd_ total_fam_inc_ ///
debt_flag_ value_debts_ , stat(n mean sd min max) save
return list

matrix results = r(StatTotal)' 
matlist results

putexcel set "$output\PSID_0515_subsets2", sheet("HS Educ Black Men") modify

putexcel A1 = matrix(results), names nformat(number_d3)
putexcel A1:F1, hcenter bold border(bottom) overwritefmt
restore


***8/1/18 Full Sample FREQUENCY GRAPHS***
graph bar (count), over(income_levels_)
graph save Graph "$output\income_freq_full.gph", modify

graph bar (count), over(educ_exp_)
graph save Graph "$output\educ_freq_full.gph", modify
graph export "$output\educ_freq_full.png", as(png) replace


graph bar (count),	over(marr_status_)
graph save Graph "$output\marr_freq_full.gph", modify
graph export "$output\marr_freq_full.png", as(png) replace



*income
graph bar (count) if mort_flag_==1, over(income_levels_, relabel( 1 "0-50K" 2 "50K-100K" 3 "100K-150K" 4 "150K-200K" 5 ">200K"))  name(mort_inc, replace)
graph bar (count) if mort_flag_==0, over(income_levels_, relabel( 1 "0-50K" 2 "50K-100K" 3 "100K-150K" 4 "150K-200K" 5 ">200K"))  name(no_mort_inc, replace)
graph combine mort_inc no_mort_inc, ycommon name(combined, replace)

graph save combined "$output\combined_mort_inc.gph", replace
graph export "output\combined_mort_inc.png", as(png) replace


*income REAL
graph bar (count) if mort_flag_==1, over(income_levels_real_, relabel( 1 "0-50K" 2 "50K-100K" 3 "100K-150K" 4 "150K-200K" 5 ">200K"))  name(mort_inc, replace)
graph bar (count) if mort_flag_==0, over(income_levels_real_, relabel( 1 "0-50K" 2 "50K-100K" 3 "100K-150K" 4 "150K-200K" 5 ">200K"))  name(no_mort_inc, replace)
graph combine mort_inc no_mort_inc, ycommon name(combined, replace)

graph save combined "$output\combined_mort_inc.gph", replace
graph export "output\combined_mort_inc.png", as(png) replace

*education
graph hbar (count) if mort_flag_==1, over(educ_exp_)  name(mort_educ, replace)
graph hbar (count) if mort_flag_==0, over(educ_exp_)  name(no_mort_educ, replace)
graph combine mort_educ no_mort_educ, ycommon name(combined, replace)

graph save combined "$output\combined_mort_educ.gph", replace
graph export "output\combined_mort_educ.png", as(png) replace

*marrital status
graph bar (count) if mort_flag_==1, over(marr_status_, relabel(1 "Married" 2 "Never Married" 3 "Widowed" 4 "Divorced" 5 "Seperated"))  name(mort_marr, replace)
graph bar (count) if mort_flag_==0, over(marr_status_, relabel(1 "Married" 2 "Never Married" 3 "Widowed" 4 "Divorced" 5 "Seperated"))  name(no_mort_marr, replace)
graph combine mort_marr no_mort_marr, ycommon name(combined, replace)

graph save combined "$output\combined_mort_marr.gph", replace
graph export "output\combined_mort_marr.png", as(png) replace















