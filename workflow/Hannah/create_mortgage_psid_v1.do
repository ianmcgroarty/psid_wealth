**********************************************************************************
*Author: Hannah Kronenberg 
*Date: 11.06.2017
*Description: This file creates 
*********************************************************************************
global Data "H:\PSID\Data" 
global RAW "$Data\Raw"
global INT  "$Data\Intermediate" 
global OUT  "$Data\Output" 
global LOG  "H:\PSID\Code\logs"
global VERSION "v1"
*******************************************************
clear all
set more off

log using "$LOG/create_psid_mortgage_$version.smcl", text replace 
use "$RAW\mortgage_psid_raw.dta", clear

****************************
*Clean Data*****************
****************************

rename ER30001 famid
	label var famid "unique family id #, for each family from 1968"
rename ER30002 pnid
	label var pnid "unique person #, for each individual"

gen famidpn  = (famid*1000)+ pn

tostring famidpn, gen(famidpns)

sort famidpn


*homeowner
rename ER25028 homeowner_2005
rename ER36028 homeowner_2007
rename ER42029 homeowner_2009
rename ER47329 homeowner_2011
rename ER53029 homeowner_2013
rename ER60030 homeowner_2015

*house value
rename ER25029 hv_2005
rename ER36029 hv_2007
rename ER42030 hv_2009
rename ER47330 hv_2011
rename ER53030 hv_2013
rename ER60031 hv_2015

*mortgage 
rename ER25039 mort_2005
rename ER36039 mort_2007
rename ER42040 mort_2009
rename ER47345 mort_2011
rename ER53045  mort_2013
rename ER60046  mort_2015

*remaining prin
rename ER25042 pr_2005
rename ER36042 pr_2007
rename ER42043 pr_2009
rename ER47348 pr_2011
rename ER53048  pr_2013
rename ER60049  pr_2015

*interest
rename ER25046 mint_2005
rename ER36046 mint_2007
rename ER42047 mint_2009
rename ER47355 mint_2011
rename ER53055  mint_2013
rename ER60056  mint_2015

*mortgage type-not available for 2005
rename ER36048 mtypevar_2007
rename ER42049 mtypevar_2009
rename ER47354 mtypevar_2011
rename ER53054 mtypevar_2013
rename ER60055 mtypevar_2015

*origination year
rename ER25048 morig_2005
rename ER36049 morig_2007
rename ER42050 morig_2009
rename ER47357 morig_2011
rename ER53057 morig_2013
rename ER60058 morig_2015

*years to pay mortage 1 
rename ER25049 mtremain_2005
rename ER36050 mtremain_2007
rename ER42051 mtremain_2009
rename ER47358 mtremain_2011
rename ER53058 mtremain_2013
rename ER60059 mtremain_2015

*refinanced
rename ER25041 refi_2005
rename ER36041 refi_2007
rename ER42042 refi_2009
rename ER47347 refi_2011
rename ER53047 refi_2013
rename ER60048 refi_2015

*mothly payments mortgage 1  
rename ER25044 mpay_2005
rename ER36044 mpay_2007
rename ER42045 mpay_2009
rename ER47350 mpay_2011
rename ER53050 mpay_2013
rename ER60051 mpay_2015

*2nd mortgage 
rename ER25050 m2_2005
rename ER36051 m2_2007
rename ER42059 m2_2009
rename ER47366 m2_2011
rename ER53066 m2_2013
rename ER60067 m2_2015

*2nd mortgage type 
rename ER25051 m2type_2005
rename ER36052 m2type_2007
rename ER42060 m2type_2009
rename ER47367 m2type_2011
rename ER53067 m2type_2013
rename ER60068 m2type_2015

*2 remaining prin
rename ER25053 m2pr_2005
rename ER36054 m2pr_2007
rename ER42062 m2pr_2009
rename ER47369 m2pr_2011
rename ER53069 m2pr_2013
rename ER60070 m2pr_2015

*monthly pay m2 
rename ER25055 m2pay_2005
rename ER36056 m2pay_2007
rename ER42064 m2pay_2009
rename ER47371 m2pay_2011
rename ER53071 m2pay_2013
rename ER60072 m2pay_2015

*interest rate m2 
rename ER25057 m2int_2005
rename ER36058 m2int_2007
rename ER42066 m2int_2009
rename ER47376 m2int_2011
rename ER53076 m2int_2013
rename ER60077 m2int_2015

*mortgage 2 orig year 
rename ER25059 m2orig_2005
rename ER36061 m2orig_2007
rename ER42069 m2orig_2009
rename ER47378 m2orig_2011
rename ER53078  m2orig_2013
rename ER60079  m2orig_2015

*2nd mortgage type var-not available for 2005
rename ER36060 m2typevar_2007
rename ER42068 m2typevar_2009
rename ER47375 m2typevar_2011
rename ER53075 m2typevar_2013
rename ER60076 m2typevar_2015

*moved? 
rename ER25098 move_2005
rename ER36103 move_2007
rename ER42132 move_2009
rename ER47440 move_2011
rename ER53140 move_2013
rename ER60155 move_2015

*sold home 
rename ER26618 sell_2005
rename ER37636 sell_2007
rename ER43627 sell_2009
rename ER48972 sell_2011
rename ER54734 sell_2013
rename ER61845 sell_2015

*sold house value 
rename ER26619 sell_hv_2005
rename ER37637 sell_hv_2007
rename ER43628 sell_hv_2009
rename ER48973 sell_hv_2011
rename ER54735 sell_hv_2013
rename ER61846 sell_hv_2015

*first mortgage type 
rename ER25040 morttyp_2005
rename ER36040 morttyp_2007
rename ER42041 morttyp_2009	
rename ER47346 morttyp_2011
rename ER53046 morttyp_2013
rename ER60047 morttyp_2015

**********************************************************
*MORTGAGE VARIABLES 2009-2015
**********************************************************
*modified 
rename ER42057 mod2009  //Modified ==1
rename ER47364 mod2011
rename ER53064 mod2013 
rename ER60065 mod2015

*delinquent 
rename ER42053 delinq2009    
rename ER47360 delinq2011      //Months delinq
rename ER53060 delinq2013
rename ER60061 delinq2015

*other real estate 
rename	ER26623	otherm2005
rename	ER37641	otherm2007
rename	ER43632	otherm2009	//	W59 WTR BOUGHT OTR REAL ESTATE
rename	ER48977	otherm2011	//	W59 WTR BOUGHT OTR REAL ESTATE
rename	ER54739 otherm2013	//	W59 WTR BOUGHT OTR REAL ESTATE;
rename	ER61850 otherm2015	//	W59 WTR BOUGHT OTR REAL ESTATE;

*delinquent loan 2 
rename ER42072 m2delinq2009
rename ER47381 m2delinq2011
rename ER53081 m2delinq2013 
rename ER60082 m2delinq2015 

*foreclosure loan 1 
rename ER42054 fc2009 //WTR foreclosure Loan #1
rename ER47361 fc2011 //WTR foreclosure Loan #1
rename ER53061 fc2013 //WTR foreclosure Loan #1;
rename ER60062 fc2015 //WTR foreclosure Loan #1;


*month foreclosure 1 
rename ER42055 mo1fc2009 //Month of foreclosure Loan #1
rename ER47362 mo1fc2011 //Month of foreclosure Loan #1
rename ER53062 mo1fc2013 //Month of foreclosure Loan #1;
rename ER60063 mo1fc2015 //Month of foreclosure Loan #1;

*year foreclosure 1 
rename ER42056 yr1fc2009 //Year of foreclosure Loan #1
rename ER47363 yr1fc2011
rename ER53063 yr1fc2013
rename ER60064 yr1fc2015 //Year of foreclosure Loan #1;

*foreclosure loan 2 
rename ER42073 fc22009 //WTR foreclosure Loan #2
rename ER47382 fc22011 //WTR foreclosure Loan #2
rename ER53082 fc22013 //WTR foreclosure Loan #2;
rename ER60083  fc22015 //WTR foreclosure Loan #2;

*month foreclosure 2 
rename ER42074 mo2fc2009 //Month of foreclosure Loan #2
rename ER47383 mo2fc2011 //Month of foreclosure Loan #2
rename ER53083 mo2fc2013  //Month of foreclosure Loan #2;
rename ER60084 mo2fc2015  //Month of foreclosure Loan #2;

*year foreclosure 2 
rename ER42075 yr2fc2009 //Year of foreclosure Loan #2
rename ER47384 yr2fc2011 //Year of foreclosure Loan #2
rename ER53084 yr2fc2013 //Year of foreclosure Loan #2;
rename ER60085 yr2fc2015 //Year of foreclosure Loan #2;




















