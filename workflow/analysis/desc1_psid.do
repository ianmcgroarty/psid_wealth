# delimit 
capture log close;

clear;

local dataloc "C:\Users\plevi\Dropbox (Personal)\wpdocs\papers\finaid_race_wealth\psid data\";
local logloc "C:\Users\plevi\Dropbox (Personal)\statprog\finaid_race_wealth\";

log using "`logloc'\desc1_psid.log", replace;

use "`dataloc'\wealth_finaid_psid_final2.dta";

gen faminccat = 1 if faminc < 75000;
replace faminccat = 2 if faminc >= 75000 & faminc < 125000;
replace faminccat = 3 if faminc >= 125000 & faminc < 200000;

label define faminclbl 1 "< $75,000" 2 "$75,000-$124,999" 3 "$125,000-$249,999";
label values faminccat faminclbl;

tab raceeth faminccat;
tab raceeth faminccat [weight=tasweight];
tab raceeth faminccat [weight=tasweight], row nofr;

tabstat faminc cash nonretinv homeeq retinv networth [weight=tasweight], by(raceeth) stat(median) format(%9.0f);
tabstat faminc cash nonretinv homeeq retinv networth [weight=tasweight] if faminccat == 1, by(raceeth) stat(median) format(%9.0f);
tabstat faminc cash nonretinv homeeq retinv networth [weight=tasweight] if faminccat == 2, by(raceeth) stat(median) format(%9.0f);
tabstat faminc cash nonretinv homeeq retinv networth [weight=tasweight] if faminccat == 3, by(raceeth) stat(median) format(%9.0f);

log close;