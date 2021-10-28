*******************************************************************************
**# Preamble
*******************************************************************************

clear 
set more off

global path "D:/Ian"

// Set the year we want to use as our inflation adjusted base year
global cpi_adjustment_year 2017

// Import data 
use "$path/psid_cleanup/data/intermediate/wealth_finaid_psid_final.dta", clear

tab year
bysort famidpns: gen num_famid_obs = _n 
tab num_famid_obs 

*******************************************************************************
**# CPI Data & Inflation Program
	* Merge in the core cpi data (based on calendar year) 
	* create a program to systematically adjust for inflation
*******************************************************************************/

// Merge in cpi data (see inflation_adjust_program.do)
	cap drop cpi_year
	rename year cpi_year 
	
	merge m:1 cpi_year using "$path/psid_cleanup/data/cpi_data.dta"
		tab cpi_year _merge
		drop if _merge != 3
		drop _merge
		rename cpi_year year 
		rename cpi calendar_cpi
		
		sum calendar_cpi if year == $cpi_adjustment_year
		

// Create the inflation program
	* ABOUT: put in the name of the variable you want to adjust and the year dollars
	* you want to adjust to. get out the variable name _cpiYEAR. Ex, I want:
	* money_var in 2010 dollars, 'cpi_adj_program money_var 2010' returns money_var_cpi2010
	
	cap program drop cpi_adj_program
	program cpi_adj_program
		* having calendar_cpi here keeps the reference value consistent
		qui sum calendar_cpi if year == `2'
		cap drop `1'_cpi`2'
		gen `1'_cpiadj = `1' * r(mean) /`3'
		end
		
*******************************************************************************
**# Normal Inflation Adjustments
// - Trying our function out on real data 
*******************************************************************************/ 

// desired variables to adjust
	local cpi_adj_vars value_sl
	
	foreach var of varlist `cpi_adj_vars' {
		cpi_adj_program `var' $cpi_adjustment_year calendar_cpi
	}

	tabstat value_sl value_sl_cpiadj, by(year) statistics(count mean )

	
*******************************************************************************
**# Age Inflation Adjustments 
	* The problem is that the data is wide, so for example we have:
   * home_value_f_16 - the home value when the father was 16, thus
   * the value is constant for each year. I need to make the adjustment on the AGE
   * year not the calendar year. 

*******************************************************************************/
 
// Define the local variables
	local parent_titles m f 
	local grandparent_title mm mf ff fm

	local cpi_age_vars_mf ///
		home_value mortgage1 mortgage2 biz_farm_worth val_stocks ira_annuity savings ///
		val_debt_sl val_inheritance1 val_inheritance2 val_inheritance3 tot_pension ///
		home_equity total_wealth_equity tot_fam_income biz_farm_debt biz_farm_netval

	local cpi_age_vars_granparents 	total_wealth_equity
		
// Run the Loop over all the variables for parents 
	forvalues age = 16/19 {

		// merge the cpi on the appropriate age year 
			gen cpi_year = birth_year + `age'
				merge m:1 cpi_year using "$path/psid_cleanup/data/cpi_data.dta"
					drop if _merge != 3
					drop _merge cpi_year
		
		// Run the inflation adjustment program 
			foreach pt of local parent_titles {
				foreach var of local cpi_age_vars_mf {
					
					cpi_adj_program `var'_`pt'_`age' $cpi_adjustment_year  cpi
												
					// make sure you got them all with this 
						*drop `var'_`pt'_`age' `var'_`pt'_`age'_cpiadj

			}		
		}
	}


// Run the Loop over all the variables Grandparents
	forvalues age = 16/24{

		// merge the cpi on the appropriate age year 
			gen cpi_year = birth_year + `age'
				merge m:1 cpi_year using "$path/psid_cleanup/data/cpi_data.dta"
					drop if _merge != 3
					drop _merge cpi_year
		
		// Run the inflation adjustment program 
			foreach pt of local grandparent_title {
				foreach var of local cpi_age_vars_granparents {
					
					cpi_adj_program `var'_`pt'_`age' $cpi_adjustment_year  cpi
					
					// make sure you got them all with this 
						* drop `var'_`pt'_`age' `var'_`pt'_`age'_cpiadj

						
			}		
		}
	}
		
sort famidpns year
		
stop varbleble sums
















*****************************
**# Variable sums and such 
*****************************/
	
// general variables 
	hist year // these are even
	hist birth_year
	hist age
	tab age, m

* I wonder if couple status of father is always = to couple status of monther? 

// Interview variables
	cap drop dup 
		bysort famidpn year: gen dup = cond(_N==1,0,_n)
		tab dup // these are are unique ids
		drop dup 
	
	cap drop dup
		bysort int_num_f: gen dup = cond(_N==1,0,_n) if int_num_f != . & int_num_f != 0
		tab dup
	** QUESTION: are 0s different from . 
		* oh it looks like int_num 0 just means that they were not interviewed that year but are in the data 
		* Missing means that they weren't in the data. 
	** QUESTION: 
	br if int_num_f == 8471 
	br if inlist(famidpn, 2119184,2119183,377030,377031)
		sort  famidpn year
		* So I think it is clear that int_num_f is not unique across years only within a year
		* next 377030 doesn't live at home, but 377031 does. 

		stop
use "$path/psid_cleanup/data/raw/fam_ids_int_f.dta", clear
br if famidpn_f == inlist(2119184,2119183,377030,377031)
br
