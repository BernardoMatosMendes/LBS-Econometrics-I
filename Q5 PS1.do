clear all
set more off

cap cd "C:\Users\bdematosmendes\Dropbox\_PhD LBS\Term 1 2022\Econometrics I\Problem Set 1"
use "PS1.dta", clear

***Question 5, Problem Set 1***

rename w0 wage
rename ed0 education 
rename a0 age
label variable wage "Wage"
label variable education "Education"
label variable age "Age"



*a*
gen experience=age-(education+6)
gen log_wage=log(wage)
gen experience_sq=experience^2
label variable experience "Experience"
label variable experience_sq "Experience Squared"

reg log_wage education experience experience_sq
eststo Q5a

esttab Q5a using "Q5a.tex", replace ///
		stats( N  r2_a    , fmt(0 3 ) layout("\multicolumn{1}{c}{@}") labels(  `"Observations"' `"Adjusted R-Squared"')) ///
		b(3) se(5) star(* 0.10 ** 0.05 *** .01) /* Keep Betas and Standard Errors with 3 digits and set significance levels for stars*/ ///
		booktabs compress l  wrap fragment varwidth(30) nonumbers nomtitles noobs nonotes  /* Other Details */ 
		
		
*b*
predict y_hat
label variable y_hat "Fitted Values"

reg log_wage education experience y_hat
eststo Q5b

esttab Q5b using "Q5b.tex", replace ///
		stats( N  r2_a    , fmt(0 3 ) layout("\multicolumn{1}{c}{@}") labels(  `"Observations"' `"Adjusted R-Squared"')) ///
		b(3) se(5) star(* 0.10 ** 0.05 *** .01) /* Keep Betas and Standard Errors with 3 digits and set significance levels for stars*/ ///
		booktabs compress l  wrap fragment varwidth(30) nonumbers nomtitles noobs nonotes  /* Other Details */ 
		
		
		
*c*
reg log_wage education experience_sq
eststo Q5c1
predict resid_log_wage, residuals
label variable resid_log_wage "Partialled Out Log(wage)"

reg experience education experience_sq
eststo Q5c2
predict resid_experience, residuals
label variable resid_experience "Partialled Out Experience"


esttab Q5c1 Q5c2 using "Q5c12.tex", replace ///
		stats( N  r2_a    , fmt(0 3 ) layout("\multicolumn{1}{c}{@}" "\multicolumn{1}{c}{@}") labels(  `"Observations"' `"Adjusted R-Squared"')) ///
		b(3) se(5) star(* 0.10 ** 0.05 *** .01) /* Keep Betas and Standard Errors with 3 digits and set significance levels for stars*/ ///
		booktabs compress l  wrap fragment varwidth(30) nonumbers nomtitles noobs nonotes  /* Other Details */ 

		
reg resid_log_wage resid_experience
eststo Q5c3

esttab Q5c3 using "Q5c3.tex", replace ///
		stats( N  r2_a    , fmt(0 3 ) layout("\multicolumn{1}{c}{@}") labels(  `"Observations"' `"Adjusted R-Squared"')) ///
		b(3) se(5) star(* 0.10 ** 0.05 *** .01) /* Keep Betas and Standard Errors with 3 digits and set significance levels for stars*/ ///
		booktabs compress l  wrap fragment varwidth(30) nonumbers nomtitles noobs nonotes  /* Other Details */ 



*d*
reg log_wage resid_experience
eststo Q5d

esttab Q5d using "Q5d.tex", replace ///
		stats( N  r2_a    , fmt(0 3 ) layout("\multicolumn{1}{c}{@}") labels(  `"Observations"' `"Adjusted R-Squared"')) ///
		b(3) se(5) star(* 0.10 ** 0.05 *** .01) /* Keep Betas and Standard Errors with 3 digits and set significance levels for stars*/ ///
		booktabs compress l  wrap fragment varwidth(30) nonumbers nomtitles noobs nonotes  /* Other Details */ 








