# delimit 
capture log close;

clear;

local dataloc "C:\Users\plevi\Dropbox (Personal)\wpdocs\papers\finaid_race_wealth\psid data\";
local logloc "C:\Users\plevi\Dropbox (Personal)\statprog\finaid_race_wealth\";

log using "`logloc'\reg1_psid.log", replace;

use "`dataloc'\wealth_finaid_psid_final2.dta";

drop if homeeq > 1000000; *drop missings;
drop if retinv > 1000000;   *drop missings;
*keep if efc < 30000;
keep if faminc < 150000 & networth < 500000;

replace efc = efc/10000;
replace faminc = faminc/10000;
replace retinv = retinv/10000;
replace homeeq = homeeq/10000;
replace nw_counted = nw_counted/10000;

regress enrolled_by_19 faminc nw_counted [weight=tasweightave];
est store e_model1;
regress enrolled_by_19 faminc nw_counted homeeq retinv [weight=tasweightave];
est store e_model2;
regress enrolled_by_19 black hispanic other [weight=tasweightave];
est store e_model3;
regress enrolled_by_19 faminc nw_counted black hispanic other [weight=tasweightave];
est store e_model4;
regress enrolled_by_19 faminc nw_counted homeeq retinv black hispanic other [weight=tasweightave];
est store e_model5;


di _newline "**** SUMMARY OF RESULTS   ***";
estout e_model1 e_model2 e_model3 e_model4 e_model5,
cells(b(fmt(%8.3f)) se(fmt(%8.3f) par))
prefoot("") postfoot("") varwidth(24) modelwidth(14)
keep(faminc nw_counted homeeq retinv black hispanic other) 
order(faminc nw_counted homeeq retinv black hispanic other);

log close;