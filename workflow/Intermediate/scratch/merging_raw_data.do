*Author: Jessica Kiser
*Date:06.12.2018
*Description: This file merges PSID data

clear all
set more off
******************************************************************************************/

****Merging all of the raw renamed PSID data to one dataset**** 

use "Y:\PSID_Jessica\data\raw\demographics_psid_renamed.dta"

*merge with personal data*
merge 1:1 famidpn using "Y:\PSID_Jessica\data\raw\personal_psid_renamed"
assert _m == 3
drop _m

*merge with mortgage data*
merge 1:1 famidpn using "Y:\PSID_Jessica\data\raw\mortgage_psid_renamed"
assert _m == 3
drop _m

*merge with unemployment data  
merge 1:1 famidpn using "Y:\PSID_Jessica\data\raw\unemployment_psid_renamed"
assert _m == 3
drop _m 


merge 1:1 famidpn using "Y:\PSID_Jessica\data\raw\state_metro_psid_renamed"
assert _m == 3 
drop _m 

save Y:\PSID_Jessica\data\raw\merged_psid_raw.dta,replace 


