*******************************************************************************
**# Preamble
*******************************************************************************

clear 
set more off

global path "D:/Ian"

// Set the year we want to use as our inflation adjusted base year
global cpi_adjustment_year 2017

*******************************************************************************
**# Create CPI Data 
*******************************************************************************/
clear 
set obs 20
gen id = _n 
gen cpi_year = id + 1999


* Source https://www.minneapolisfed.org/about-us/monetary-policy/inflation-calculator/consumer-price-index-1913-
	gen cpi = 0.0
		replace cpi = 255.7 if cpi_year == 2018
		replace cpi = 251.1 if cpi_year == 2018
		replace cpi = 245.1 if cpi_year == 2017
		replace cpi = 240   if cpi_year == 2016
		replace cpi = 237   if cpi_year == 2015
		replace cpi = 236.7 if cpi_year == 2014
		replace cpi = 233   if cpi_year == 2013
		replace cpi = 229.6 if cpi_year == 2012
		replace cpi = 224.9 if cpi_year == 2011
		replace cpi = 218.1 if cpi_year == 2010
		replace cpi = 214.5 if cpi_year == 2009
		replace cpi = 215.3 if cpi_year == 2008
		replace cpi = 207.3 if cpi_year == 2007
		replace cpi = 201.6 if cpi_year == 2006
		replace cpi = 195.3 if cpi_year == 2005
		replace cpi = 188.9 if cpi_year == 2004
		replace cpi = 184   if cpi_year == 2003
		replace cpi = 179.9 if cpi_year == 2002
		replace cpi = 177.1 if cpi_year == 2001
		replace cpi = 172.2 if cpi_year == 2000

save "$path/psid_cleanup/data/cpi_data.dta", replace

*******************************************************************************
**# Beta Test Program 
*******************************************************************************/
clear
set obs 20
gen id = _n
gen year = id + 1999
gen dollar_amount = 1000
gen euro_amount = dollar_amount * 1.1


/* you may wonder why I go through the hassle of creating a cpi_year and then 
renaming and droping. 
well it is so that I can merge the cpi data onto any data I want 
with out having to rename the cpi dataset each time. 
*/ 

gen cpi_year = year 
merge 1:1 cpi_year using "$path/psid_cleanup/data/cpi_data.dta"
tab cpi_year _merge
drop _merge

cap drop year 
rename cpi_year year 


local ref_year_cpi = 218.1
gen dollar_amount_adj10 = dollar_amount * `ref_year_cpi'/cpi

*line dollar_amount_adj year 

cap program drop xyz
program xyz
	qui sum cpi if year == `2'
	cap drop `1'_cpi`2'
	gen `1'_cpi`2' = `1' * r(mean) /cpi
	end
	
xyz dollar_amount 2010
xyz dollar_amount 2017
sum dollar_amount dollar_amount_adj dollar_amount_cpi2010 dollar_amount_cpi2017

twoway (line dollar_amount year) ///
 (line dollar_amount_cpi2010 year) ///
 (line dollar_amount_cpi2017 year)
 
foreach var of varlist dollar_amount euro_amount {
    xyz `var' 2012
}

sum dollar_amount_cpi2012 euro_amount_cpi2012




*******************************************************************************
**# CPI Data & Inflation Program
	* Merge in the core cpi data (based on calendar year) 
	* create a program to systematically adjust for inflation
*******************************************************************************/

// Import data 
	use "$path/psid_cleanup/data/intermediate/wealth_finaid_psid_final.dta", clear

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
		gen `1'_cpi = `1' * r(mean) /`3'
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

	tabstat value_sl value_sl_cpi, by(year) statistics(count mean )

	
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
						*drop `var'_`pt'_`age' `var'_`pt'_`age'_cpi

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
						* drop `var'_`pt'_`age' `var'_`pt'_`age'_cpi

						
			}		
		}
	}
	
sort famidpns year

	
*save "$path/psid_cleanup/data/wealth_finaid_psid_inf_adj.dta"	, replace 

