/* -- earlier code --*/
stcox i.huq010, basesurv(s0)
matrix define mat = r(table)
matrix list mat 
matrix mat = mat'
svmat mat
preserve 
keep mat*
drop if missing(mat1)
rename (mat1 mat2 mat3 mat4 mat5 mat6 mat7 mat8 mat9)(b se z p ll ul df crit eform)
g x=_n
replace b=log(b)
replace ll=log(ll)
replace ul=log(ul)
twoway (scatter b x) || ///
       (rcap ll ul x, ///
	       yline(0, lcol(lime)) ///
		   ylab( ///
		       -2.08 "0.125" ///
			   -1.39 "0.25" ///
			   -.69 "0.5" ///
			     0 "1"  ///
			   .69 "2" ///
			   1.39 "4" ///
			   2.08 "8" ///
			   2.78 "16") ///
		   legend(off)  ///
		xlab( ///
           1 "$legend1" ///
		   2 "$legend2" ///
		   3 "$legend3" ///
		   4 "$legend4" ///
		   5 "$legend5") ///
	   xti("Self-Reported Health") ///
	   	   ) 
graph export semipara_unadj.png, replace 
graph save semipara_unadj.gph, replace 
restore 