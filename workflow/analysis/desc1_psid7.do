# delimit 
capture log close;

clear;

local dataloc "C:\Users\plevi\Dropbox (Personal)\wpdocs\papers\finaid_race_wealth\psid data\";
local logloc "C:\Users\plevi\Dropbox (Personal)\statprog\finaid_race_wealth\";

log using "`logloc'\desc1_psid7.log", replace;

use "`dataloc'\wealth_finaid_psid_final6.dta";

keep if cds97_result == 1;

gen faminccat = 1 if tot_fam_income_at_15_18 < 75000;
replace faminccat = 2 if tot_fam_income_at_15_18 >= 75000 & tot_fam_income_at_15_18 < 125000;
replace faminccat = 3 if tot_fam_income_at_15_18 >= 125000 & tot_fam_income_at_15_18 < 250000;
replace faminccat = 4 if tot_fam_income_at_15_18 >= 250000 & tot_fam_income_at_15_18 ~= .;

label define faminclbl 1 "< $75,000" 2 "$75,000-$124,999" 3 "$125,000-$249,999" 4 "$250,000+";
label values faminccat faminclbl;

rename tot_fam_income_at_15_18 faminc;
rename total_wealth_equity_at_15_18 networth;
rename val_stocks_at_15_18 nonretinv;
rename savings_at_15_18 cash;
rename home_equity_at_15_18 homeeq;
rename ira_annuity_at_15_18 retinv;
gen counted_assets = networth - homeeq - retinv;
gen uncounted_assets = homeeq + retinv;
rename completed_college_at_23 compcoll23;
rename completed_college_at_24 compcoll24;

gen any_sl_debt_at_19_20 = sl_debt_at_19_20 > 0;
replace any_sl_debt_at_19_20 = . if sl_debt_at_19_20 == .;

gen parchgdebt = val_all_debt_at_23_24 - val_all_debt_at_15_18; 

gen parents_married = couple_status_at_15_18 <= 3;

gen efchat = .28*faminc + .058*(cash + nonretinv) - 10000;
replace efchat = 0 if efchat < 0;

tab ethrace faminccat, mis;
tab ethrace faminccat [aweight=avg_tas_long_weight];
tab ethrace faminccat [aweight=avg_tas_long_weight], row nofr;

* Median values of financial attributes for all and by income;

local finchar "faminc cash nonretinv homeeq retinv networth counted_assets uncounted_assets";
local sldebtat "sl_debt_at_17_18 sl_debt_at_19_20 sl_debt_at_21_22 sl_debt_at_23_24";

tabstat `finchar' [aweight=avg_tas_long_weight], by(ethrace) stat(median) format(%9.0f);
tabstat `finchar' [aweight=avg_tas_long_weight] if faminccat == 1, by(ethrace) stat(median) format(%9.0f);
tabstat `finchar' [aweight=avg_tas_long_weight] if faminccat == 2, by(ethrace) stat(median) format(%9.0f);
tabstat `finchar' [aweight=avg_tas_long_weight] if faminccat == 3, by(ethrace) stat(median) format(%9.0f);

* Mean values of financial attributes for all and by income;

tabstat `finchar' [aweight=avg_tas_long_weight], by(ethrace) stat(mean) format(%9.0f);
tabstat `finchar' [aweight=avg_tas_long_weight] if faminccat == 1, by(ethrace) stat(mean) format(%9.0f);
tabstat `finchar' [aweight=avg_tas_long_weight] if faminccat == 2, by(ethrace) stat(mean) format(%9.0f);
tabstat `finchar' [aweight=avg_tas_long_weight] if faminccat == 3, by(ethrace) stat(mean) format(%9.0f);

tab ethrace faminccat [aweight=avg_tas_long_weight], mis sum(grad_hs_by_19) noobs nost nofr;
tab (ethrace faminccat) [aweight=avg_tas_long_weight], mis sum(enrolled_by_19) noobs nost nofr;
tab (ethrace faminccat) [aweight=avg_tas_long_weight] if grad_hs_by_19 == 1, mis sum(enrolled_by_19) noobs nost nofr;

tab ethrace any_sl if enrolled_by_19 == 1 [aweight=avg_tas_long_weight], row nofr;
tab ethrace if any_sl_debt_at_19_20 == 1 [aweight=avg_tas_long_weight], sum(sl_debt_at_19_20);

tabstat `sldebtat' [aweight=avg_tas_long_weight]  if enrolled_by_19 == 1, by(ethrace) stat(mean) format(%9.0f);
tabstat `sldebtat' [aweight=avg_tas_long_weight]  if enrolled_by_19 == 1 & faminccat == 1, by(ethrace) stat(mean) format(%9.0f);
tabstat `sldebtat' [aweight=avg_tas_long_weight]  if enrolled_by_19 == 1 & faminccat == 2, by(ethrace) stat(mean) format(%9.0f);
tabstat `sldebtat' [aweight=avg_tas_long_weight]  if enrolled_by_19 == 1 & faminccat == 3, by(ethrace) stat(mean) format(%9.0f);

gen efchat_1000 = efchat/1000;
gen efchat_sq = efchat_1000^2;
gen efchat_cub = efchat_1000^3;
gen uncounted_assets_1000 = uncounted_assets/1000;
gen uncounted_assets_sq = uncounted_assets_1000^2;
gen uncounted_assets_cub = uncounted_assets_1000^3;

gen networth_le100k = networth <= 100000 & networth > 0;
gen networth_100k_200k = networth <= 200000 & networth > 100000;
gen networth_200k_300k = networth <= 300000 & networth > 200000;
gen networth_300k_400k = networth <= 400000 & networth > 300000;
gen networth_gt400k = networth >= 400000 & networth ~= .;

gen counted_assets_le100k = counted_assets <= 100000 & counted_assets > 0;
gen counted_assets_100k_200k = counted_assets <= 200000 & counted_assets > 100000;
gen counted_assets_200k_300k = counted_assets <= 300000 & counted_assets > 200000;
gen counted_assets_gt300k = counted_assets >= 300000 & counted_assets ~= .;

gen uncounted_assets_le100k = uncounted_assets <= 100000 & uncounted_assets > 0;
gen uncounted_assets_100k_200k = uncounted_assets <= 200000 & uncounted_assets > 100000;
gen uncounted_assets_200k_300k = uncounted_assets <= 300000 & uncounted_assets > 200000;
gen uncounted_assets_gt300k = uncounted_assets >= 300000 & uncounted_assets ~= .;



gen sat2 = college_age_sat_equivalent;
gen tooksat = college_age_sat_equivalent ~= .;
replace sat2 = 0 if sat2 == .;

gen faminc_sq = faminc^2;
gen faminc_cub = faminc^3;
gen networth_sq = networth^2;
gen networth_cub = networth^3;

drop if faminc == .;
gen mom_age_birth_mis = age_m_at_birth == .;
replace age_m_at_birth = 0 if age_m_at_birth == .;
gen age_m_at_birth_sq = age_m_at_birth^2;
gen mom_educ_mis = educ_mother == .;
replace educ_mother = 0 if educ_mother == .;


replace max_grad_2yr_or_4yr_degree = . if enrolled_by_19 == 0;
replace max_grad_4yr_degree = . if enrolled_by_19 == 0;

tab year, gen(yrdv);

local outcomes "enrolled_by_19 enrolled_oneyear_ormore_college max_grad_2yr_or_4yr_degree max_grad_4yr_degree";

*weighted regressions;

foreach y in `outcomes' {;
regress `y' black hispanic other [pweight=avg_tas_long_weight] if grad_hs_by_19;
regress `y' black hispanic other faminc faminc_sq faminc_cub counted_assets_le100k counted_assets_100k_200k counted_assets_200k_300k counted_assets_gt300k age_m_at_birth age_m_at_birth_sq mom_age_birth_mis educ_mother mom_educ_mis [pweight=avg_tas_long_weight] if grad_hs_by_19;
regress `y' black hispanic other faminc faminc_sq faminc_cub counted_assets_le100k counted_assets_100k_200k counted_assets_200k_300k counted_assets_gt300k uncounted_assets_le100k uncounted_assets_100k_200k uncounted_assets_200k_300k uncounted_assets_gt300k age_m_at_birth age_m_at_birth_sq mom_age_birth_mis educ_mother mom_educ_mis [pweight=avg_tas_long_weight] if grad_hs_by_19;

};

*unweighted regressions;

foreach y in `outcomes' {;
regress `y' black hispanic other if grad_hs_by_19;
regress `y' black hispanic other faminc faminc_sq faminc_cub counted_assets_le100k counted_assets_100k_200k counted_assets_200k_300k counted_assets_gt300k age_m_at_birth age_m_at_birth_sq mom_age_birth_mis educ_mother mom_educ_mis if grad_hs_by_19;
regress `y' black hispanic other faminc faminc_sq faminc_cub counted_assets_le100k counted_assets_100k_200k counted_assets_200k_300k counted_assets_gt300k uncounted_assets_le100k uncounted_assets_100k_200k uncounted_assets_200k_300k uncounted_assets_gt300k age_m_at_birth age_m_at_birth_sq mom_age_birth_mis educ_mother mom_educ_mis if grad_hs_by_19;
};


local outcomes2 "sl_debt_at_19_20 sl_debt_at_21_22 sl_debt_at_23_24 parchgdebt"; 

foreach y in `outcomes2' {;
regress `y' black hispanic other if enrolled_by_19 == 1 [weight=avg_tas_long_weight];
regress  `y' black hispanic other faminc faminc_sq faminc_cub counted_assets_le100k counted_assets_100k_200k counted_assets_200k_300k counted_assets_gt300k if enrolled_by_19 == 1 [pweight=avg_tas_long_weight];
regress `y' black hispanic other faminc faminc_sq faminc_cub counted_assets_le100k counted_assets_100k_200k counted_assets_200k_300k counted_assets_gt300k uncounted_assets_le100k uncounted_assets_100k_200k uncounted_assets_200k_300k uncounted_assets_gt300k age_m_at_birth educ_mother sat2 tooksat if enrolled_by_19 == 1 [weight=avg_tas_long_weight];
};


log close;
