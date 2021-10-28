/*

Name: Veronika Konovalova
Project: Wealth and FAFSA 
Description: cleaning and stitching together all years of TA data
Last Updated: 5/13/21

*/

forval i = 2005(2)2017 {
do /share/cfi-dubravka/wealth_fafsa/workflow/Raw/TA`i'.do, clear
}

