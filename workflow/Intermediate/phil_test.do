clear
set maxvar 10000

global path "D:/PLevine/wealth_fafsa_test_vk/"

use"$path/psid_cleanup/data/Intermediate/wealth_finaid_psid_final.dta"

keep if age == 17 | age == 18

egen home_equity_17_18 = rmax(home_equity_f_17 home_equity_m_17 home_equity_f_18 home_equity_m_18)

egen tot_fam_income_17_18 = rmax(tot_fam_income_f_17 tot_fam_income_m_17 tot_fam_income_f_18 tot_fam_income_m_18)

egen total_wealth_equity_17_18 = rmax(total_wealth_equity_f_17 total_wealth_equity_m_17 total_wealth_equity_f_18 total_wealth_equity_m_18)