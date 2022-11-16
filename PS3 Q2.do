clear all
set more off

cap cd "C:\Users\bdematosmendes\Dropbox\_PhD LBS\Term 1 2022\Econometrics I\Problem Set 3"

import excel "Nerlove1963\Nerlove1963.xlsx", sheet("Sheet1") firstrow

foreach var of varlist *{
	gen log_`var'=log(`var')
}

label variable log_Cost "Log Total Cost"
label variable log_output "Log Output"
label variable log_Plabor "Log PL"
label variable log_Pcapital "Log PK"
label variable log_Pfuel "Log PF"

gen log_output_sq=log_output^2
label variable log_output_sq "Log Output Squared"


*a)
reg log_Cost log_output log_Plabor log_Pcapital log_Pfuel 
eststo Q2a1

reg log_Cost log_output log_output_sq log_Plabor log_Pcapital log_Pfuel 
eststo Q2a2

esttab Q2a1 Q2a2 using "Q2a.tex", replace ///
		stats( N  r2_a    , fmt(0 3 ) layout("\multicolumn{1}{c}{@}") labels(  `"Observations"' `"Adjusted R-Squared"')) ///
		b(3) se(5) star(* 0.10 ** 0.05 *** .01) /* Keep Betas and Standard Errors with 3 digits and set significance levels for stars*/ ///
		booktabs compress l  wrap fragment varwidth(30) nonumbers nomtitles noobs nonotes  /* Other Details */ 
		
		
		
*b)
sum log_output, d


