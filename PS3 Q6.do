clear all
set more off

cap cd "C:\Users\bdematosmendes\Dropbox\_PhD LBS\Term 1 2022\Econometrics I\Problem Set 3"

import excel "Question 6\PS4data", sheet("data") firstrow

gen year_quarter = yq(year, quarter)
format year_quarter %tq
order year_quarter, after(quarter)

tsset year_quarter

*a)
gen C=realconsumptionofnondurables+realconsumptionofservices
gen C_percapita=C/population

reg C_percapita l.C_percapita l2.C_percapita l3.C_percapita l4.C_percapita
eststo Q6a

esttab Q6a  using "Q6a.tex", replace ///
		stats( N  r2_a    , fmt(0 3 ) layout("\multicolumn{1}{c}{@}") labels(  `"Observations"' `"Adjusted R-Squared"')) ///
		b(3) se(5) star(* 0.10 ** 0.05 *** .01) /* Keep Betas and Standard Errors with 3 digits and set significance levels for stars*/ ///
		booktabs compress l  wrap fragment varwidth(30) nonumbers nomtitles noobs nonotes  /* Other Details */ 

test L2.C_percapita=L3.C_percapita=L4.C_percapita=0


*c)
gen log_C_percapita = log(C_percapita)
gen Y_percapita=realdisposableincome/population
gen log_Y_percapita=log(Y_percapita)

gen diff_log_C_percapita = log_C_percapita-l.log_C_percapita
gen diff_log_Y_percapita=log_Y_percapita-l.log_Y_percapita

gen instrument1 = l2.diff_log_C_percapita
gen instrument2 = l3.diff_log_C_percapita
gen instrument3 = l4.diff_log_C_percapita
gen instrument4 = l5.diff_log_C_percapita

ivregress 2sls diff_log_C_percapita  (diff_log_Y_percapita= instrument1 instrument2 instrument3 instrument4), vce(robust) first
eststo Q6c

esttab Q6c  using "Q6c.tex", replace ///
		stats( N  r2_a    , fmt(0 3 ) layout("\multicolumn{1}{c}{@}") labels(  `"Observations"' `"Adjusted R-Squared"')) ///
		b(3) se(5) star(* 0.10 ** 0.05 *** .01) /* Keep Betas and Standard Errors with 3 digits and set significance levels for stars*/ ///
		booktabs compress l  wrap fragment varwidth(30) nonumbers nomtitles noobs nonotes  /* Other Details */ 

		
		
*d)
estat endogenous

estat overid
