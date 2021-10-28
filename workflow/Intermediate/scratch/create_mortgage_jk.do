**********************************************************************************
*Author: Jessica Kiser
*Date: 06.07.2018
*Description: This file renames and cleans PSID mortgage data
*********************************************************************************

clear all
set more off

use "Y:\PSID_Jessica\data\raw\mortgage_psid_raw.dta", clear



***Combining famid and pnid to create a unique identifier for each observation
rename ER30001 famid
	label var famid "unique family id #, for each family from 1968"
rename ER30002 pnid
	label var pnid "unique person #, for each individual"

gen famidpn  = (famid*1000)+ pn
tostring famidpn, gen(famidpns)
sort famidpn
order famidpn famidpns



********************Renaming variables***************

*homeowner
* owns = 1, pays rent = 5, neither = 8 
	rename ER25028 homeowner_2005
	rename ER36028 homeowner_2007
	rename ER42029 homeowner_2009
	rename ER47329 homeowner_2011
	rename ER53029 homeowner_2013
	rename ER60030 homeowner_2015

*house value
*1-9,999,997 actual amount, not a homeowner = 0 
	rename ER25029 hv_2005
	rename ER36029 hv_2007
	rename ER42030 hv_2009
	rename ER47330 hv_2011
	rename ER53030 hv_2013
	rename ER60031 hv_2015

*mortgage 
* yes = 1, no = 5, not a homeowner = 0 
	rename ER25039 mort_2005
	rename ER36039 mort_2007
	rename ER42040 mort_2009
	rename ER47345 mort_2011
	rename ER53045 mort_2013
	rename ER60046 mort_2015

*first mortgage type 
/* 1 = mortgage, 2 = land contract, 3 = home equity, 4 = home improvement, 
 5 = line of credit, 7 = other */ 
	rename ER25040 mtype_2005
	rename ER36040 mtype_2007
	rename ER42041 mtype_2009	
	rename ER47346 mtype_2011
	rename ER53046 mtype_2013
	rename ER60047 mtype_2015

*remaining prin
*1-9,999,996 /// 9,999,9997 or more, 0 either not a home owner or no mortgage on home
	
	rename ER25042 pr_2005
	rename ER36042 pr_2007
	rename ER42043 pr_2009
	rename ER47348 pr_2011
	rename ER53048 pr_2013
	rename ER60049 pr_2015
	
*interest
*1-97 actual number, 0 either not a home owner or no mortgage on home
	rename ER25046 mint_2005
	rename ER36046 mint_2007
	rename ER42047 mint_2009
	rename ER47355 mint_2011
	rename ER53055 mint_2013
	rename ER60056 mint_2015

*mortgage type of loan -not available for 2005
* fixed = 1, variable = 2, not a homeowner/no mortgage on home = 0
	rename ER36048 mtypevar_2007
	rename ER42049 mtypevar_2009
	rename ER47354 mtypevar_2011
	rename ER53054 mtypevar_2013
	rename ER60055 mtypevar_2015

*origination year (ie. year obtained loan)
*1959-2015 actual year, not a homeowner/no mortgage on home = 0
	rename ER25048 morig_2005
	rename ER36049 morig_2007
	rename ER42050 morig_2009
	rename ER47357 morig_2011
	rename ER53057 morig_2013
	rename ER60058 morig_2015

*years to pay mortage 1 
*1 one year or less, 2-97 actual number, not a homeowner/no mortgage on home = 0
	rename ER25049 yrs_remain_2005
	rename ER36050 yrs_remain_2007
	rename ER42051 yrs_remain_2009
	rename ER47358 yrs_remain_2011
	rename ER53058 yrs_remain_2013
	rename ER60059 yrs_remain_2015

*refinanced
*orginal = 1, refinanced = 2,0 = Inap.: not a homeowner; no mortgage or loan on home
	rename ER25041 refi_2005
	rename ER36041 refi_2007
	rename ER42042 refi_2009
	rename ER47347 refi_2011
	rename ER53047 refi_2013
	rename ER60048 refi_2015

*mothly payments mortgage 1  
*1-99,996 actual amount, 99,997 or more, not a homeowner/no mortgage on home = 0
	rename ER25044 mpay_2005
	rename ER36044 mpay_2007
	rename ER42045 mpay_2009
	rename ER47350 mpay_2011
	rename ER53050 mpay_2013
	rename ER60051 mpay_2015

*2nd mortgage 
* yes = 1, no = 5, not a homeowner/no morgage on home = 0 
	rename ER25050 m2_2005
	rename ER36051 m2_2007
	rename ER42059 m2_2009
	rename ER47366 m2_2011
	rename ER53066 m2_2013
	rename ER60067 m2_2015

*2nd mortgage type 
/*1 = mortgage, 2 = land contract, 3 = home equity, 4 = home improvement, 
5 = line of credit, 7 = other, not a homeowner/no mortgage on home = 0*/ 
	rename ER25051 m2type_2005
	rename ER36052 m2type_2007
	rename ER42060 m2type_2009
	rename ER47367 m2type_2011
	rename ER53067 m2type_2013
	rename ER60068 m2type_2015

*2 remaining prin
*1-9,999,996 actual amount, 9,999,997 or more, not a homeowner/no mortgage on home = 0
	rename ER25053 m2pr_2005
	rename ER36054 m2pr_2007
	rename ER42062 m2pr_2009
	rename ER47369 m2pr_2011
	rename ER53069 m2pr_2013
	rename ER60070 m2pr_2015

*monthly pay m2 
*1-99,996 actual amount, 99,9997 or more, not a homeowner/no mortgage on home = 0
	rename ER25055 m2pay_2005
	rename ER36056 m2pay_2007
	rename ER42064 m2pay_2009
	rename ER47371 m2pay_2011
	rename ER53071 m2pay_2013
	rename ER60072 m2pay_2015

*interest rate m2 
*1-65 actual number, not a homeowner/no mortgage on home = 0
	rename ER25057 m2int_2005
	rename ER36058 m2int_2007
	rename ER42066 m2int_2009
	rename ER47376 m2int_2011
	rename ER53076 m2int_2013
	rename ER60077 m2int_2015

*mortgage 2 orig year 
* 1959- 2015 actual year 
	rename ER25059 m2orig_2005
	rename ER36061 m2orig_2007
	rename ER42069 m2orig_2009
	rename ER47378 m2orig_2011
	rename ER53078 m2orig_2013
	rename ER60079 m2orig_2015

*2nd mortgage type of loan var-not available for 2005
* 1 = fixed, 2 = variable
	rename ER36060 m2typevar_2007
	rename ER42068 m2typevar_2009
	rename ER47375 m2typevar_2011
	rename ER53075 m2typevar_2013
	rename ER60076 m2typevar_2015

*moved? 
* 1= yes, 5 = no
	rename ER25098 move_2005
	rename ER36103 move_2007
	rename ER42132 move_2009
	rename ER47440 move_2011
	rename ER53140 move_2013
	rename ER60155 move_2015

*sold home 
* 1 = yes, 5 = no
	rename ER26618 sell_2005
	rename ER37636 sell_2007
	rename ER43627 sell_2009
	rename ER48972 sell_2011
	rename ER54734 sell_2013
	rename ER61845 sell_2015

*sold house value 
*1-999,999,996 actual amount, 999,999,997 or more
	rename ER26619 sell_hv_2005
	rename ER37637 sell_hv_2007
	rename ER43628 sell_hv_2009
	rename ER48973 sell_hv_2011
	rename ER54735 sell_hv_2013
	rename ER61846 sell_hv_2015

*release number
	rename ER30000 release_all
	rename ER25001 release_2005
	rename ER36001 release_2007
	rename ER42001 release_2009
	rename ER47301 release_2011
	rename ER53001 release_2013
	rename ER60001 release_2015

*interview number
	rename ER33801 int_num_2005
	rename ER33901 int_num_2007
	rename ER34001 int_num_2009
	rename ER34101 int_num_2011
	rename ER34201 int_num_2013
	rename ER34301 int_num_2015
	
*seauence number 
	rename ER33802 seq_num_2005
	rename ER33902 seq_num_2007
	rename ER34002 seq_num_2009
	rename ER34102 seq_num_2011
	rename ER34202 seq_num_2013
	rename ER34302 seq_num_2015
		
		
*relation to head
	rename ER33803 rel_head_2005
	rename ER33903 rel_head_2007
	rename ER34003 rel_head_2009
	rename ER34103 rel_head_2011
	rename ER34203 rel_head_2013
	rename ER34303 rel_head_2015
	

*MORTGAGE VARIABLES 2009-2015
**********************************************************
*modified your loan/mortgage 
*1 = yes, 5 = no, not a homeowner/no mortgage on home = 0
	rename ER42057 mod_2009  
	rename ER47364 mod_2011
	rename ER53064 mod_2013 
	rename ER60065 mod_2015

*delinquent 
*1-97 actual number of months behind,  not a homeowner/no mortgage on home = 0
	rename ER42053 months_behind_mtge_2009    
	rename ER47360 months_behind_mtge_2011    //Months delinq
	rename ER53060 months_behind_mtge_2013
	rename ER60061 months_behind_mtge_2015

*other real estate bought
* 1 = yes, 5 = no, not a homeowner/no mortgage on home = 0
	rename	ER26623	otherm_2005
	rename	ER37641	otherm_2007
	rename	ER43632	otherm_2009	//	W59 WTR BOUGHT OTR REAL ESTATE
	rename	ER48977	otherm_2011	//	W59 WTR BOUGHT OTR REAL ESTATE
	rename	ER54739 otherm_2013	//	W59 WTR BOUGHT OTR REAL ESTATE;
	rename	ER61850 otherm_2015	//	W59 WTR BOUGHT OTR REAL ESTATE;

*delinquent loan 2 
*1-97 actual number of months behind, not a homeowner/no mortgage on home = 0
	rename ER42072 months_behind_mtge_2_2009
	rename ER47381 months_behind_mtge_2_2011
	rename ER53081 months_behind_mtge_2_2013
	rename ER60082 months_behind_mtge_2_2015

*foreclosure loan 1 
* 1 = yes, 5 = no, not a homeowner/no mortgage on home = 0
	rename ER42054 forc_2009 //WTR foreclosure Loan #1
	rename ER47361 forc_2011 //WTR foreclosure Loan #1
	rename ER53061 forc_2013 //WTR foreclosure Loan #1;
	rename ER60062 forc_2015 //WTR foreclosure Loan #1;


*month foreclosure 1 
/*1-12 actual month, 21 winter, 22 spring, 23 summer, 24 fall, 
  not a homeowner/no mortgage on home = 0*/ 
	rename ER42055 mo1fc_2009 //Month of foreclosure Loan #1
	rename ER47362 mo1fc_2011 //Month of foreclosure Loan #1
	rename ER53062 mo1fc_2013 //Month of foreclosure Loan #1;
	rename ER60063 mo1fc_2015 //Month of foreclosure Loan #1;

*year foreclosure 1 
*2001-2015 actual year, not a homeowner/no mortgage on home = 0
	rename ER42056 yr1fc_2009 //Year of foreclosure Loan #1
	rename ER47363 yr1fc_2011
	rename ER53063 yr1fc_2013
	rename ER60064 yr1fc_2015 //Year of foreclosure Loan #1;

*foreclosure loan 2 
* 1 = yes, 5 = no, not a homeowner/no mortgage on home = 0
	rename ER42073 forc2_2009 //WTR foreclosure Loan #2
	rename ER47382 forc2_2011 //WTR foreclosure Loan #2
	rename ER53082 forc2_2013 //WTR foreclosure Loan #2;
	rename ER60083 forc2_2015 //WTR foreclosure Loan #2;

*month foreclosure 2 
/*1-12 actual month, 21 winter, 22 spring, 23 summer, 24 fall, 
  not a homeowner/no mortgage on home = 0*/ 
	rename ER42074 mo2fc_2009 //Month of foreclosure Loan #2
	rename ER47383 mo2fc_2011 //Month of foreclosure Loan #2
	rename ER53083 mo2fc_2013  //Month of foreclosure Loan #2;
	rename ER60084 mo2fc_2015  //Month of foreclosure Loan #2;

*year foreclosure 2 
*2001-2015 actual year, not a homeowner/no mortgage on home = 0
	rename ER42075 yr2fc_2009 //Year of foreclosure Loan #2
	rename ER47384 yr2fc_2011 //Year of foreclosure Loan #2
	rename ER53084 yr2fc_2013 //Year of foreclosure Loan #2;
	rename ER60085 yr2fc_2015 //Year of foreclosure Loan #2;

	
*****************Recoding missing values********************
*non-homeowners get a value of 0, so I changed it to missing to avoid miscodings
	recode hv_* (9999998=.) (9999999=.) (0=.) 
	recode mort_* (9=.) (8=.) (5=0) 
	recode pr_* (9999998=.) (9999999=.)
	recode mint_* (98=.) (99=.)
	recode morig_* (9998=.) (9999=.) 
	recode yrs_remain_* (98=.) (99=.) 
	recode refi_* (8=.) (9=.) 
	recode mpay_* (99998=.) (99999=.)
	recode m2_* (8=.)(9=.)(5=0)
	recode m2type_* (8=.) (9=.) 
	recode m2pay_* (99998=.) (99999=.)
	recode m2pr_* (9999998=.) (9999999=.)
	recode m2int_* (98=.) (99=.)
	recode m2orig_* (9998=.) (9999=.) 
	recode m2typevar_* (8=.) (9=.) 
	recode move_* (8=.) (9=.) (5=0)
	recode sell_* (8=.) (9=.) (5=0)
	recode mtype_* (8=.) (9=.) 
	recode sell_hv_* (999999998=.) (999999999=.) (0=.) 
	recode homeowner_* (5/8=0) 
	
***recoding mortgage variables
	recode otherm_* (8=.) (9=.) (5=0) 
	recode mod_* (8=.) (9=.) (5=0) 
	recode months_behind_mtge_* (98=.) (99=.) 
	recode months_behind_mtge_2_* (98=.) (99=.)
	recode forc_* (8=.) (9=.) (5=0)
	recode mo1fc_* (98=.) (99=.) 
	recode yr1fc_* (9998=.) (9999=.) 
	recode forc2_* (8=.) (9=.) (5=0) 
	recode mo2fc_* (98=.) (99=.)
	
	
	
******************Reshaping**********************
reshape	long ///
release_ ///
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
int_num_ ///
seq_num_ ///
rel_head_  ///
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
yr2fc_        , i(famidpn) j (year) 

order famidpn famidpns


****************************Generating New Variables***************
*combined remaining principle
gen combined_rem_prin_ =  pr_ + m2pr_ 

*LTVs
gen CLTV_ = (combined_rem_prin_)/hv_
gen LTV_1_ = pr_ /hv_
gen LTV_2_ = m2pr_ / hv_

*delinquency flags 60 days delinquent
gen delinq_flag_ = 0
replace delinq_flag_ = 1  if months_behind_mtge_ >= 2 
replace delinq_flag_ = 0 if months_behind_mtge_ == . 

gen delinq_2flag_ = 0
replace delinq_2flag_ = 1 if months_behind_mtge_2_ >= 2
replace delinq_2flag_ = 0 if months_behind_mtge_2_ ==.


