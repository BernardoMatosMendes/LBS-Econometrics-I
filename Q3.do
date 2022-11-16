clear all
set more off

cap cd "C:\Users\bdematosmendes\Dropbox\_PhD LBS\Term 1 2022\Econometrics I\Problem Set 3"

import excel "Question 3\wage.xlsx", sheet("Sheet1") firstrow

gen aux=1

*d)
*Standard Test
gen log_wage=log(wage)
sdtest log_wage, by(male)

*Alternative tets
egen sd_male=sd(log_wage) if male==1
bysort aux: egen sdmale_aux = min(sd_male)
drop sd_male
rename sdmale_aux sd_male
gen var_male=sd_male^2

egen sd_female=sd(log_wage) if male==0
bysort aux: egen sdfemale_aux = min(sd_female)
drop sd_female
rename sdfemale_aux sd_female
gen var_female=sd_female^2

sum log_wage if male==1
gen n1=r(N)

sum log_wage if male==0
gen n0=r(N)

sum log_wage,d
gen k=r(kurtosis)

gen T=((n0*n1)/(n0+n1))^0.5 * (log (var_female) - log(var_male))

gen teststat=T/sqrt(k-1)

