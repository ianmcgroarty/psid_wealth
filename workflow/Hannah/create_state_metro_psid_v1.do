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

log using "$LOG/create_psid_state_metro_$version.smcl", text replace 
*Clean HPI Data*****************
********************************
import delimited H:\PSID\Data\Untouched\HPI_AT_state.csv, clear 
	rename v1 state_ 
	rename v2 year
	rename v3 qtr
	rename v4 hpi 
	
collapse (mean) hpi, by(state_ year)
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
destring(fips_state), replace 
save H:\PSID\Data\Raw\hpi_fhfa_raw.dta, replace

use "$RAW\state_metro_psid_raw.dta", clear

rename ER30001 famid
	label var famid "unique family id #, for each family from 1968"
rename ER30002 pnid
	label var pnid "unique person #, for each individual"

gen famidpn  = (famid*1000)+ pn

tostring famidpn, gen(famidpns)

sort famidpn

*states
	rename ER25004 state_2005
	rename ER36004 state_2007
	rename ER42004 state_2009 
	rename ER47304 state_2011 
	rename ER53004 state_2013
	rename ER60004 state_2015

*Metro 
	rename ER28043A metro_2005 //05
	rename ER41033A metro_2007 //07
	rename ER46975A metro_2009 //09
	rename ER52399A metro_2011 //11
	rename ER58216 metro_2013 //13
	rename ER65452 metro_2015 //15


***********************************************************
*Reshape
***********************************************************
	drop ER*

reshape long ///
	state_ ///
	metro_ , i(famidpn) j(year)


order famidpns famidpn famid pn year

rename state_ fips_state 


xtset famidpn year 
bys famidpns: replace fips_state = fips_state[_n-1] if fips_state[_n-1] != . & fips_state==.
bys famidpns: replace metro_ = metro_[_n-1] if metro_[_n-1] != . & metro_==.

merge m:1 fips_state  year using "$RAW\hpi_fhfa_raw.dta"
drop if _merge==2
drop _merge 






