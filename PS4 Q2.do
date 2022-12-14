clear all
set more off

cap cd "C:\Users\bdematosmendes\Dropbox\_PhD LBS\Term 1 2022\Econometrics I\Problem Set 4"
use "Question 2\ccapm.dta"

*a)
gen lcratio=cratio[_n-1]
gen lrrate=rrate[_n-1]
gen le=e[_n-1]

gmm ({beta=1}*cratio^(-{gamma=1})*(rrate)-1), instruments(lcratio lrrate le)

*b)
gen time=[_n]
gmm ({beta=1}*cratio^(-{gamma=1})*(rrate)-1), instruments(lcratio lrrate le) wmatrix(hac ba 5)

*c)
test /beta=0.98