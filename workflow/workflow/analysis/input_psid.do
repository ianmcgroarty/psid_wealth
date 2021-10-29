# delimit 
capture log close;

clear;

local dataloc "C:\Users\plevi\Dropbox (Personal)\wpdocs\papers\finaid_race_wealth\psid data\";
local logloc "C:\Users\plevi\Dropbox (Personal)\statprog\finaid_race_wealth\";

log using "`logloc'\input_psid.log", replace;

use "`dataloc'\wealth_finaid_psid_final.dta";

sort famidpn;
egen tasweightave = mean(tas_weight), by(famidpn);
replace tasweight = int(tasweight);
keep if famidpn ~= famidpn[_n-1];


gen parmarried17_18 = couple_status_f_17 == 1 | couple_status_f_18 == 1 |
     couple_status_m_17 == 1 | couple_status_m_18 == 1;
replace parmarried17_18 = . if 
     couple_status_f_17 == . & couple_status_f_18 == . &
     couple_status_m_17 == . & couple_status_m_18 == .;
	 

local incasscat tot_fam_income total_wealth_equity ira_annuity home_equity savings val_stocks; 

foreach x in `incasscat' {;

gen `x'_17_18m = `x'_m_18;
replace `x'_17_18m = `x'_m_17 if `x'_17_18m == .;
replace `x'_17_18m = `x'_m_16 if `x'_17_18m == .;
replace `x'_17_18m = `x'_m_19 if `x'_17_18m == .;
gen `x'_17_18f = `x'_f_18;
replace `x'_17_18f = `x'_f_17 if `x'_17_18f == .;
replace `x'_17_18f = `x'_f_16 if `x'_17_18f == .;
replace `x'_17_18f = `x'_f_19 if `x'_17_18f == .;
sum `x'_17_18m `x'_17_18f;

egen `x'_17_18 = rmax(`x'_17_18m `x'_17_18f) if parmarried17_18 == 0;
replace `x'_17_18 = `x'_17_18m if parmarried17_18 == 1;
};

replace tot_fam_income_17_18 = 0 if tot_fam_income_17_18 < 0;
replace ira_annuity_17_18 = 0 if ira_annuity_17_18 < 0;
replace home_equity_17_18 = 0 if home_equity_17_18 < 0;
replace home_equity_17_18 = . if home_equity_17_18 > 2000000;
replace val_stocks_17_18 = 0 if val_stocks_17_18 < 0;
replace savings_17_18 = 0 if savings_17_18 < 0;
replace total_wealth_equity_17_18 = 0 if total_wealth_equity_17_18 < 0;

rename tot_fam_income_17_18 faminc;
rename savings_17_18 cash;
rename val_stocks_17_18 stocksbonds;
rename ira_annuity_17_18 retinv;
rename home_equity_17_18 homeeq;
rename total_wealth_equity_17_18 networth;
rename ethrace raceeth;

gen nw_counted = networth - homeeq - retinv;
gen nonretinv = networth - retinv - homeeq - cash;
replace nonretinv = 0 if nonretinv < 0;
gen simplenw  = cash + nonretinv;
gen efchat = -10000 + .28*faminc + .067*simplenw;

save "`dataloc'\wealth_finaid_psid_final2.dta", replace;

log close;

