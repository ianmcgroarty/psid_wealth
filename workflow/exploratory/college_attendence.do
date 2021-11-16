use "$path/psid_cleanup/data/raw/tas_psid_renamed.dta" , clear

local college_vars int_num  grad_college ever_attend_college in_college current_attend_college /// 
	yr_enroll_most_rec_college  yr_attend_most_rec_college degree_most_rec_college    ///
	yr_enroll_earlier_college   yr_attend_earlier_college  degree_earlier_college  ///
	why_stop_college_mr why_stop_college_earlierv ///
	tot_credit_hrs_college_one enrollment_status ///
	gpa_college_one gpa_most_rec_college gpa_college_two gpa_earlier_college



reshape long `college_vars'  , i(famidpns) j(year)
 keep famidpns  year int_num* `college_vars'
 
 order famidpns  year int_num* `college_vars'
 stop


// Only want college degrees
	tab degree_most_rec_college , m 
	** honestly this is basically useless but I'll still use it for identifying graduate degrees where possible. 
	
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

// Clean up a bit 
	drop min_enroll_earlier min_attend_earlier min_enroll_mr min_attend_mr ///
	max_enroll_earlier max_attend_earlier max_enroll_mr max_attend_mr 
	*yr_enroll_earlier_college yr_attend_earlier_college 
	*yr_enroll_most_rec_college yr_attend_most_rec_college

	/* GOAL: Simplify to one enroll and attend - honestly not worth it. 
		gen year_enrolled_in_college = . 
		gen year_last_attend_college = . 
		
		  // if there is only one college 
			replace year_enrolled_in_college  = yr_enroll_first_college if (yr_enroll_first_college == yr_enroll_second_college) & (yr_attend_first_college == yr_attend_second_college)
			replace year_last_attend_college  = yr_attend_first_college if (yr_enroll_first_college == yr_enroll_second_college) & (yr_attend_first_college == yr_attend_second_college)
	*/ 		


	// years in college +1 because 2009-2009 is kind of one year 
	gen years_in_first_college = (yr_attend_first_college - yr_enroll_first_college) + 1
	gen years_in_second_college = (yr_attend_second_college - yr_enroll_second_college) + 1


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
		

	*gen enrolled_oneyear_ormore_college = 0 
	*	replace enrolled_oneyear_ormore_college = 1 if years_in_first_college >= 1
	*	replace enrolled_oneyear_ormore_college = 1 if years_in_second_college >= 1
	*	replace enrolled_oneyear_ormore_college = . if years_in_first_college ==.

		
	gen enrolled_oneyear_ormore_college = 0
		// same school - first school  
		replace enrolled_oneyear_ormore_college = 1 if (yr_enroll_first_college + 1) <= yr_attend_first_college 
		
		// first school didn't work out
		*replace enrolled_oneyear_later = 1 if (yr_enroll_second_college + 1) < yr_attend_second_college 
		
		replace enrolled_oneyear_ormore_college = . if yr_enroll_first_college == . & yr_enroll_second_college ==. 
		replace enrolled_oneyear_ormore_college = . if enrolled_by_19 == 0
	

/* Here is what Phil Described for persistence 
if you enrolled in X for the first time 
and enrolled in X+1

started by age 19 
look at the year they started 
were they enrolled a year later. 
were you enrolled in the following year. 	

are you enrolled in anything in this wave and then the next wave
 


gen enrolled_oneyear_ormore_college= 0
	// same school - first school  
	replace enrolled_oneyear_ormore_college = 1 if (yr_enroll_first_college + 1) < yr_attend_first_college 
	

	// first school didn't work out
	replace enrolled_oneyear_ormore_college = 1 if (yr_enroll_second_college + 1) < yr_attend_second_college 
	
	replace enrolled_oneyear_ormore_college = . if yr_enroll_first_college == . & yr_enroll_second_college ==. 
	

gen enrolled_this_and_next_wave = 0 
	replace enrolled_this_and_next_wave = 1 if current_attend_college == 1 & attend_college_next_wave ==1
	
*** We talked about this 10/29 and we want to see if they have more than 1 year of college. (see above) 
*/

// Graduate 2yr or 4yr degree 
	tab enrollment_status

	gen grad_2yr_degree = 0
		replace grad_2yr_degree = . if yr_enroll_first_college == . 
		replace grad_2yr_degree  = 1 if enrollment_status == 5
		replace grad_2yr_degree = 1 if grad_college == 1	
		
	bysort famidpns: egen max_grad_2yr_degree = max(grad_2yr_degree)
		

	gen grad_4yr_degree = 0
		replace grad_4yr_degree = . if yr_enroll_first_college == . 
		replace grad_4yr_degree = 1 if grad_college == 2
		replace grad_4yr_degree  = 1 if enrollment_status == 6
		** I'm going to assume that if they have a graduate degree they have a college 4 year degree
		replace grad_4yr_degree  = 1 if inlist(enrollment_status, 6, 7, 11)
		
	bysort famidpns: egen max_grad_4yr_degree = max(grad_4yr_degree)

	gen max_grad_2yr_or_4yr_degree =0 
		replace max_grad_2yr_or_4yr_degree = 1 if max_grad_2yr_degree == 1
		replace max_grad_2yr_or_4yr_degree = 1 if max_grad_4yr_degree == 1
		
	** Look into did they graduate and consitency with enrollment 
		tab max_grad_2yr_or_4yr_degree enrolled_oneyear_ormore_college , m 
		** looks pretty good, 210 people with graduate but no enrollment is not great. but very small. 
		
	
// Never Enrolled in College? 
	gen never_enrolled_college = 0 
		replace never_enrolled_college = 1 if yr_enroll_first_college == . 
	tab degree_earlier_college if never_enrolled_college  == 1, m 
	tab degree_most_rec_college if never_enrolled_college  == 1, m 
	tab ever_attend_college if never_enrolled_college  == 1
	tab grad_college if never_enrolled_college  == 1
		** There are some weird people but mostly seems okay


	
// Last year observed 
	gen survey_year = year if int_num != . 
	bysort famidpns: egen last_year_surveyed = max(survey_year)

	gen enrollment_status_last_year = enrollment_status if year == last_year_surveyed
	bysort famidpns: egen max_enrollment_status_last_year  = max(enrollment_status_last_year)

	
// Questions/Checks

* I want to do the best I can what happened to their college 
** Question: If they didn't graduate what happened? 

	tab yr_attend_second_college if max_grad_4yr_degree != 1 & max_grad_2yr_degree != 1 & never_enrolled_college != 1

	sort famidpns year
	tab max_enrollment_status_last_year , m 
	tab max_enrollment_status_last_year last_year_surveyed if max_grad_4yr_degree != 1 & max_grad_2yr_degree != 1 & never_enrolled_college != 1, m 
	* Seems like most are either enrolled (last we observed them) or dropped out (some college)

	*br  if max_grad_4yr_degree != 1 & max_grad_2yr_degree != 1 & never_enrolled_college != 1

** Question: If they graduate, would they ever "ungraduate" 
	tab max_enrollment_status_last_year max_grad_4yr_degree , m 
	*br if max_grad_4yr_degree == 1 & inlist(max_enrollment_status_last_year, 2,3,4)
		* Seems to be so but who knows why, its pretty rare too 
	
save "$path/psid_cleanup/data/intermediate/college_attendence_intermediate.dta" , replace 

	
	