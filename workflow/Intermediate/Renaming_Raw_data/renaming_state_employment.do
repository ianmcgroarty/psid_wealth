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
use "$raw\hpi_ur_psid",clear

rename state_code fips_state
rename state_abbr state_

****taking the avg. of hpi over the 4 qtrs. by state 
collapse (mean) hpi_state unemplr_state, by(state_ year)

gen fips_state=""
	replace fips_state = "1" if state_ == "AL"
	replace fips_state = "2" if state_ == "AK"
	replace fips_state = "5" if state_ == "AR"
	replace fips_state = "4" if state_ == "AZ"
	replace fips_state = "6" if state_ == "CA"
	replace fips_state = "8" if state_ == "CO"
	replace fips_state = "9" if state_ == "CT"
	replace fips_state = "11" if state_ == "DC"
	replace fips_state = "10" if state_ == "DE"
	replace fips_state = "12" if state_ == "FL"
	replace fips_state = "13" if state_ == "GA"
	replace fips_state = "15" if state_ == "HI"
	replace fips_state = "19" if state_ == "IA"
	replace fips_state = "16" if state_ == "ID"
	replace fips_state = "17" if state_ == "IL"
	replace fips_state = "18" if state_ == "IN"
	replace fips_state = "20" if state_ == "KS"
	replace fips_state = "21" if state_ == "KY"
	replace fips_state = "22" if state_ == "LA"
	replace fips_state = "25" if state_ == "MA"
	replace fips_state = "24" if state_ == "MD"
	replace fips_state = "23" if state_ == "ME"
	replace fips_state = "26" if state_ == "MI"
	replace fips_state = "27" if state_ == "MN"
	replace fips_state = "29" if state_ == "MO"
	replace fips_state = "28" if state_ == "MS"
	replace fips_state = "30" if state_ == "MT"
	replace fips_state = "37" if state_ == "NC"
	replace fips_state = "38" if state_ == "ND"
	replace fips_state = "31" if state_ == "NE"
	replace fips_state = "33" if state_ == "NH"
	replace fips_state = "34" if state_ == "NJ"
	replace fips_state = "35" if state_ == "NM"
	replace fips_state = "32" if state_ == "NV"
	replace fips_state = "39" if state_ == "OH"
	replace fips_state = "40" if state_ == "OK"
	replace fips_state = "41" if state_ == "OR"
	replace fips_state = "42" if state_ == "PA"
	replace fips_state = "44" if state_ == "RI"
	replace fips_state = "45" if state_ == "SC"
	replace fips_state = "46" if state_ == "SD"
	replace fips_state = "47" if state_ == "TN"
	replace fips_state = "48" if state_ == "TX"
	replace fips_state = "49" if state_ == "UT"
	replace fips_state = "51" if state_ == "VA"
	replace fips_state = "50" if state_ == "VT"
	replace fips_state = "53" if state_ == "WA"
	replace fips_state = "55" if state_ == "WI"
	replace fips_state = "54" if state_ == "WV"
	replace fips_state = "56" if state_ == "WY"
	replace fips_state = "36" if state_ == "NY"

destring (fips_state), replace
sort (fips_state)

 
save "$raw\state_unemployment_raw.dta", replace

use "$raw\state_metro_psid_raw.dta"
 
**merging with other hpi state data so I can merge all of that with DO-ALL file
merge m:1 fips_state year using "$raw\state_unemployment_raw.dta"

drop _merge 
drop if year == 2006 | year == 2008 | year == 2010 | year ==2012 |year == 2014

*reshaping to wide so I can merge this with all psid data and reshape all together
reshape wide ///
fips_state ///
hpi_state /// 
unemplr_state /// 
metro_ ///
state_ , i(famidpn) j(year) 

save "$raw\state_unemployment_renamed.dta", replace
