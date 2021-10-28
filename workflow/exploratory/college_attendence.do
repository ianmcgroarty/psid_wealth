use "$path/psid_cleanup/data/raw/tas_psid_renamed.dta" , clear

local college_vars int_num  grad_college ever_attend_college in_college current_attend_college /// 
	yr_enroll_most_rec_college  yr_attend_most_rec_college degree_most_rec_college    ///
	yr_enroll_earlier_college   yr_attend_earlier_college  degree_earlier_college  ///
	why_stop_college_mr why_stop_college_earlierv ///
	tot_credit_hrs_college_one enrollment_status


reshape long `college_vars'  , i(famidpns) j(year)
 keep famidpns  year int_num* `college_vars'

// Only want college degrees
	tab degree_most_rec_college , m 
	** honestly this is basically useless so I'm not going to use it. 
	
	replace yr_enroll_most_rec_college = . if degree_most_rec_college >2 & degree_most_rec_college < 95 
	replace yr_attend_most_rec_college = . if degree_most_rec_college >2 & degree_most_rec_college < 95 
	
	replace yr_enroll_earlier_college = . if degree_earlier_college >2 & degree_earlier_college < 95 
	replace yr_attend_earlier_college = . if degree_earlier_college >2 & degree_earlier_college < 95 


// Kick of the bad values
	replace yr_enroll_earlier_college =. if yr_enroll_earlier_college < 1970 | yr_enroll_earlier_college > 2050
	replace yr_attend_earlier_college =. if yr_attend_earlier_college < 1970 | yr_attend_earlier_college > 2050

	replace yr_enroll_most_rec_college =. if yr_enroll_most_rec_college < 1970 | yr_enroll_most_rec_college > 2050
	replace yr_attend_most_rec_college =. if yr_attend_most_rec_college < 1970 | yr_attend_most_rec_college > 2050

// Get consitency in which college is which 
	bysort famidpns: egen min_enroll_earlier = min(yr_enroll_earlier_college) 
	bysort famidpns: egen min_attend_earlier = min(yr_attend_earlier_college) 
	bysort famidpns: egen min_enroll_mr = min(yr_enroll_most_rec_college) 
	bysort famidpns: egen min_attend_mr = min(yr_attend_most_rec_college) 

	bysort famidpns: egen max_enroll_earlier = max(yr_enroll_earlier_college) 
	bysort famidpns: egen max_attend_earlier = max(yr_attend_earlier_college) 
	bysort famidpns: egen max_enroll_mr = max(yr_enroll_most_rec_college) 
	bysort famidpns: egen max_attend_mr = max(yr_attend_most_rec_college) 

	egen yr_enroll_first_college = rowmin(min_enroll_earlier min_enroll_mr)
	egen yr_enroll_second_college = rowmax(max_enroll_earlier max_enroll_mr)
	
	egen yr_attend_first_college  = rowmin(min_attend_earlier min_attend_mr)
	egen yr_attend_second_college = rowmax(max_attend_earlier max_attend_mr)
	
drop min_enroll_earlier min_attend_earlier min_enroll_mr min_attend_mr ///
max_enroll_earlier max_attend_earlier max_enroll_mr max_attend_mr 
*yr_enroll_earlier_college yr_attend_earlier_college 
*yr_enroll_most_rec_college yr_attend_most_rec_college

/* GOAL: Simplify to one enroll and attend 
	gen year_enrolled_in_college = . 
	gen year_last_attend_college = . 
	
	  // if there is only one college 
		replace year_enrolled_in_college  = yr_enroll_first_college if (yr_enroll_first_college == yr_enroll_second_college) & (yr_attend_first_college == yr_attend_second_college)
		replace year_last_attend_college  = yr_attend_first_college if (yr_enroll_first_college == yr_enroll_second_college) & (yr_attend_first_college == yr_attend_second_college)
*/ 		


// years in college 
gen years_in_first_college = yr_attend_first_college - yr_enroll_first_college
gen years_in_second_college = yr_attend_second_college - yr_enroll_second_college


// Redo the attend college 
sort famidpns year
cap drop current_attend_college 

gen current_attend_college = 0 
	replace current_attend_college  = 1 if year >= yr_enroll_first_college & year <= yr_attend_first_college 
	replace current_attend_college  = 1 if year >= yr_enroll_second_college & year <= yr_attend_second_college 
	replace current_attend_college  = . if yr_enroll_second_college == . & yr_enroll_second_college ==.
	
gen attend_college_next_wave = 0
	replace attend_college_next_wave  = 1 if year+2 >= yr_enroll_first_college & year+2 <= yr_attend_first_college 
	replace attend_college_next_wave  = 1 if year+2 >= yr_enroll_second_college & year+2 <= yr_attend_second_college
	replace attend_college_next_wave  = . if yr_enroll_second_college == . & yr_enroll_second_college ==.
	replace attend_college_next_wave  = . if year+2 >= 2019
	
	




/* Here is what Phil Described for persistence 
if you enrolled in X for the first time 
and enrolled in X+1

started by age 19 
look at the year they started 
were they enrolled a year later. 
were you enrolled in the following year. 	

are you enrolled in anything in this wave and then the next wave

*/ 

gen enrolled_oneyear_later = 0
	// same school - first school  
	replace enrolled_oneyear_later = 1 if (yr_enroll_first_college + 1) < yr_attend_first_college 
	
	// first school didn't work out
	replace enrolled_oneyear_later = 1 if (yr_enroll_second_college + 1) < yr_attend_second_college 
	
	replace enrolled_oneyear_later = . if yr_enroll_first_college == . & yr_enroll_second_college ==. 
	

gen enrolled_this_and_next_wave = 0 
	replace enrolled_this_and_next_wave = 1 if current_attend_college == 1 & attend_college_next_wave ==1

	
	
	
	
	