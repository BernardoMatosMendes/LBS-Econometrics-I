clear all
set more off

cap cd "C:\Users\bdematosmendes\Dropbox\_PhD LBS\Term 1 2022\Econometrics I\Problem Set 2"
use "PS1.dta", clear

***Question 2, Problem Set 2***

rename w0 wage
rename ed0 education 
rename a0 age
label variable wage "Wage"
label variable education "Education"
label variable age "Age"

gen experience=age-(education+6)
gen log_wage=log(wage)
label variable experience "Experience"


*Unrestricted Model*
reg log_wage i.education i.experience
local SSR_u=e(rss)

		
*Restricted Model*
reg log_wage education experience
local SSR_r=e(rss)

*Compute F test*
gen F=((`SSR_r'-`SSR_u')/(39-3))/((`SSR_u')/(1500-39))