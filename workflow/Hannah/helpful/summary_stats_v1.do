********************************************************************
*Hannah Kronenberg September 2017 
*Summary Statistics 
*2007-2015
********************************************************************
********************************************************
clear all 
set more off
********************************************************************************
global Data "\\c1resp2\SRC Shared\PSID_mtge_demo\September_V1\Data" 
global RAW "$Data\Raw"
global INT  "$Data\Intermediate" 
global OUT  "$Data\Output" 
global LOG  "\\c1resp2\SRC Shared\PSID_mtge_demo\September_V1\Code\logs"

********************************************************************************
use "Y:\PSID_mtge_demo\Data\Raw\FHFA_house_price_annual_states.dta", clear
keep st_ Year AnnualChange HPI
	destring(HPI), replace 
	destring(AnnualChange), replace 
	destring(Year), replace 
save "Y:\PSID_mtge_demo\Data\Raw\FHFA_house_price_annual_states_psid.dta", replace

*HPI STUFF
********************************************************************************
use "Y:\PSID_mtge_demo\Data\Raw\FHFA_house_price_annual_states.dta", clear



********************************************************************************
*Setting a panel 2007-2015
********************************************************************************
drop if year < 2007

*kick out all the false entries*
gen inw = ( age !=. & seq != 0 & sex != . ) & (year == 2007 |year == 2009 | year == 2011 | year == 2013| year == 2015)
keep if inw == 1 & (year == 2007 |year == 2009 | year == 2011 | year == 2013| year == 2015)

xtset famidpn year, delta(2)

**************************Merging in HPI****************************************
































******different marriage*******
gen marry_diff= (l.imarry_ == 1 & imarry_ !=1)
gen divorce_ch= (l.married_ ==1 & (married_ ==4 | married_==5 | married_==3))
gen divorce = married_ ==4 | married_==5 | married_==3
//Income difference
gen hwsal_diff = hwsal - l.hwsal             
gen hwsal_diff_miss = (hwsal_diff==.)
replace hwsal_diff =0 if hwsal_diff_miss==1
//gen wfwsal_diff_2011=wfwsal2011-wfwsal2009          //Income difference
gen i_hwsal_neg =(hwsal_diff <0)
//gen i_wfwsal_neg_2011=(wfwsal_diff_2011<0) //
gen i_hhours_neg =(hhours- l.hhours <0)
gen i_whours_neg =(whours- l.whours <0)
//gen i_int2007=(mint2007>7)

gen i_int = (mint >7 & mint !=.)
gen i_int_miss= (mint==.)
replace mint =0 if mint ==.
gen i_term = (mtremain >15 & mtremain !=.)
gen term_miss= (mtremain ==.)
 
// African-American dummy
gen race_dummy = (race_ ==2)
//CLTV
gen cltv_miss= (cltv == .)
replace cltv =0 if cltv ==.

gen cltv_heloc_miss = (cltv_heloc == .)
replace cltv_heloc = 0 if cltv_heloc ==.

gen cltv0 = (cltv <.7)
gen cltv1= (cltv >= .7 & cltv <.8) //Combined loan to value
gen cltv2 = (cltv >=.8 & cltv <.9)
gen cltv3 = (cltv >=.9 & cltv <1.0)
gen cltv4 = (cltv >=1.0 & cltv !=.)

gen cltv4_heloc = (cltv_heloc >=1.0 & cltv_heloc !=.)


gen cltv_sum1 = (cltv <.9)
gen cltv_sum2 = (cltv >=.9 & cltv <1)
gen cltv_sum3 = (cltv >=1 & cltv <1.1)
gen cltv_sum4 = (cltv >=1.1 & cltv <1.2) 

gen cltv_75_100 = (cltv >.75 & cltv <= 1)
gen cltv_100_125 = (cltv > 1 & cltv <=1.25)
gen cltv_125p = (cltv >1.25 & cltv < .)

gen cltv_heloc_75_100 = (cltv_heloc >.75 & cltv_heloc <= 1)
gen cltv_heloc_100_125 = (cltv_heloc > 1 & cltv_heloc <=1.25)
gen cltv_heloc_125p = (cltv_heloc >1.25 & cltv_heloc <.)


***********************************************************************************************************************************
********************************************************
*White 
*Black 
*Age
*Gender 
*Married 
*Less than high school
*High School 
*Some College 
*College +
*Number of children 
*Total Income 
********************************************************
*Employment 
********************************************************
*Unemployed Head Last Year (d) 
*Unemployed Spouse Last Year (d) 
*Unemployed Head or Spouse Last Year (d) 
*Head Unemployed as of Survey Date (d) 
*Spouse Unemployed as of Survey Date (d) 
*Unemployment Duration 
*Unemployment Duration, Spouse
********************************************************
*Wealth
********************************************************
*Value of Stocks 
*Value of Liquid Assets 
*Unsecured Debt 
*Value of Vehicles 
*Value of Bonds 
*Value of Business 
*Value of IRA 
*Value of Other Housing 
*Value of Liquid Assets 
********************************************************
*Location 
********************************************************
*Urban vs. Rural 
********************************************************
*For homeowners  
********************************************************
*Home value 
*Principal Remaining 
*Monthly Mortgage Payment 
*Second Mortgage (d) 
*Refinanced Mortgage (d)
*ARM (d) 
*Mortgage Interest Rate 
*Mortgage Term Remaining 
*Default (60+ Days Late) (d) 
*Months Delinquent 
*LTV


