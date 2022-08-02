
use "C:\Users\welcome\Dropbox\My PC (LAPTOP-E0CLJDR9)\Desktop\Sir work\new data\twin_ study_Paul.dta" 
log using twins_study_data, append
merge 1:1 studyno using  "C:\Users\welcome\Dropbox\My PC (LAPTOP-E0CLJDR9)\Desktop\Sir work\new data\twins_study_ps.dta"
ed if _merge ==2
keep if _merge ==3
save merge_twins_study
drop _merge
save "merge_twins_study.dta", replace
ttest mage  , by(Zygo_PP )
ttest fage  , by(Zygo_PP )
tab sex Zygo_PP , col chi2
save "merge_twins_study.dta", replace
ren  SPECRE1S SPECLES1
ren SPECRE2S SPECRES2
ren IOPRE1IO IOPREIO1
ren IOPRE2IO IOPREIO2
ren ANTCHAML ANTCHAML1
ren ANTCHAMR ANTCHAMR2
ren CORNEALL CORNEALL1
ren CORNEALR CORNEALR2
ren HT1HEIGH HTHEIGH1
ren  HTHEIGH1 HT1HEIGH
ren KERATODL KERATODL1
ren KERATODR KERATODR2
ren KERATONL KERATONL1
ren KERATONR KERATONR2
ren AMP1AMPL AMPAMPL1
ren AMP2AMPL AMPAMPL2
ren IOPLE1IO IOPLEIO1
ren IOPLE2IO IOPLEIO2
ren PHY1FACI  PHYFACI1
ren PHY2FACI PHYFACI2
ren bwt3 bw3t
ren hc3 h3c
ren len3 le3n
reshape long AXLENRE ANTCHAM STEACUT  IOPREIO  CORNEAL BIRTHWT KERATOD KERATON PHYFACI AXLENLE iodmp bwt  len hc length , i(studyno ) j(twins)
save reshape_74_new
order studyno twins Zygo_PP mage fage sex bwt BIRTHWT
save "reshape_74_new.dta", replace
tab bwt
replace bwt =. if bwt ==0
save "reshape_74_new.dta", replace

gen bwt_kg=bwt/1000
gen  lbw=bwt_kg >2.5
label variable zyg " 0 DZ 1 MZ "
regress bwt_kg  zyg, vce(cluster studyno)
tab lbw Zygo_PP ,col  chi2






tab Zygo_PP
gen zyg = 1 if Zygo_PP =="MZ"
replace zyg = 0 if Zygo_PP  == "DZ"
tab zyg
regress AMPAMPL zyg
h regress
regress AMPAMPL zyg, vce(cluster studyno)



