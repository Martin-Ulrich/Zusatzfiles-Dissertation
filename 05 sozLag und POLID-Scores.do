/*##############################################################################
			Zusammenhang zwischen sozialer Lage und Ideologie-Scores
##############################################################################*/

clear all
macro drop _all
capture log close
version 16.1
set more off
numlabel, add


use "C:\Users\b1065535\Desktop\Value in Crisis\Daten\VIC_ges5_weights.dta"




// Ideologische Struktur Österreichs
mean neo kon soz lib if time_l==1 [aw=Weight_W2]










// Verteilung der sozialen Lagen

tab lage
tab lage [aw=Weight_W2]

tab lage if time_l==1
tab lage if time_l==1 [aw=Weight_W2]









// POLID-Werte nach lage
reg neo i.b1.lage if time_l==1 [aw=Weight_W2]
margins lage
contrast gw.lage, asobserved
pwcompare lage, asobserved pv ci mcomp(sidak)

reg kon i.b1.lage if time_l==1 [aw=Weight_W2]
margins lage
contrast gw.lage, asobserved
pwcompare lage, asobserved pv ci mcomp(sidak)

reg soz i.b1.lage if time_l==1 [aw=Weight_W2]
margins lage
contrast gw.lage, asobserved
pwcompare lage, asobserved pv ci mcomp(sidak)

reg lib i.b1.lage if time_l==1 [aw=Weight_W2]
margins lage
contrast gw.lage, asobserved
pwcompare lage, asobserved pv ci mcomp(sidak)


// Test: Ist das obige Vorgehen äquivalent zur oneway ANOVA?
oneway neo lage [aw=Weight_W2] if time_l==1, sidak
oneway kon lage [aw=Weight_W2] if time_l==1, sidak
oneway soz lage [aw=Weight_W2] if time_l==1, sidak
oneway lib lage [aw=Weight_W2] if time_l==1, sidak
/*
Die oneway ANOVA erzielt dieselben Ergebnisse -> Die Verfahren sind äquivalent.
*/







// Korrelation zwischen Alter und Konservativismus je nach Lage
pwcorr kon soz VIC2_Q2_Alter VIC_birthyear_ges if time_l==1 & lage==1 [aw=Weight_W2], sig obs
pwcorr kon soz VIC2_Q2_Alter VIC_birthyear_ges if time_l==1 & lage==2 [aw=Weight_W2], sig obs
pwcorr kon soz VIC2_Q2_Alter VIC_birthyear_ges if time_l==1 & lage==3 [aw=Weight_W2], sig obs
pwcorr kon soz VIC2_Q2_Alter VIC_birthyear_ges if time_l==1 & lage==4 [aw=Weight_W2], sig obs
pwcorr kon soz VIC2_Q2_Alter VIC_birthyear_ges if time_l==1 & lage==5 [aw=Weight_W2], sig obs
pwcorr kon soz VIC2_Q2_Alter VIC_birthyear_ges if time_l==1 & lage==6 [aw=Weight_W2], sig obs
pwcorr kon soz VIC2_Q2_Alter VIC_birthyear_ges if time_l==1 & lage==7 [aw=Weight_W2], sig obs
pwcorr kon soz VIC2_Q2_Alter VIC_birthyear_ges if time_l==1 & lage==8 [aw=Weight_W2], sig obs
pwcorr kon soz VIC2_Q2_Alter VIC_birthyear_ges if time_l==1 & lage==9 [aw=Weight_W2], sig obs
pwcorr kon soz VIC2_Q2_Alter VIC_birthyear_ges if time_l==1 & lage==10 [aw=Weight_W2], sig obs
pwcorr kon soz VIC2_Q2_Alter VIC_birthyear_ges if time_l==1 & lage==11 [aw=Weight_W2], sig obs
pwcorr kon soz VIC2_Q2_Alter VIC_birthyear_ges if time_l==1 & lage==12 [aw=Weight_W2], sig obs
pwcorr kon soz VIC2_Q2_Alter VIC_birthyear_ges if time_l==1 & lage==13 [aw=Weight_W2], sig obs
pwcorr kon soz VIC2_Q2_Alter VIC_birthyear_ges if time_l==1 & lage==14 [aw=Weight_W2], sig obs







// Korrelation zwischen den POLID-Scores nach Lage
pwcorr neo kon soz lib if lage==1 [aw=Weight_W2], sig obs
pwcorr neo kon soz lib if lage==2 [aw=Weight_W2], sig obs
pwcorr neo kon soz lib if lage==3 [aw=Weight_W2], sig obs
pwcorr neo kon soz lib if lage==4 [aw=Weight_W2], sig obs
pwcorr neo kon soz lib if lage==5 [aw=Weight_W2], sig obs
pwcorr neo kon soz lib if lage==6 [aw=Weight_W2], sig obs
pwcorr neo kon soz lib if lage==7 [aw=Weight_W2], sig obs
pwcorr neo kon soz lib if lage==8 [aw=Weight_W2], sig obs
pwcorr neo kon soz lib if lage==9 [aw=Weight_W2], sig obs
pwcorr neo kon soz lib if lage==10 [aw=Weight_W2], sig obs
pwcorr neo kon soz lib if lage==11 [aw=Weight_W2], sig obs
pwcorr neo kon soz lib if lage==12 [aw=Weight_W2], sig obs
pwcorr neo kon soz lib if lage==13 [aw=Weight_W2], sig obs
pwcorr neo kon soz lib if lage==14 [aw=Weight_W2], sig obs




// Korrelation zwischen Sorge über Umwelt & POLID-Werten
pwcorr VICAT2_Q88 neo kon soz lib if time_l==1 & VICAT2_Q88!=9 [aw=Weight_W2], sig obs











// Interne ideologische Homogenität der sozialen Lagen
mean neo kon soz lib [aw=Weight_W2]
mean neo [aw=Weight_W2], over(lage)
mean kon [aw=Weight_W2], over(lage)
mean soz [aw=Weight_W2], over(lage)
mean lib [aw=Weight_W2], over(lage)







// Geschlecht
mean neo kon soz lib [aw=Weight_W2], over(sex)
tab sex if time_l==1 [aw=Weight_W2]


reg neo i.b1.sex if time_l==1 [aw=Weight_W2]
reg kon i.b1.sex if time_l==1 [aw=Weight_W2]
reg soz i.b1.sex if time_l==1 [aw=Weight_W2]
reg lib i.b1.sex if time_l==1 [aw=Weight_W2]





// Wissenschaftszweige der Akademiker
tab VICAT2_Q16 [aw=Weight_W2]
tab VICAT2_Q16 if lage==7 [aw=Weight_W2]
tab VICAT2_Q16 if lage==7 & time_l==1 [aw=Weight_W2]

mean neo kon soz lib [aw=Weight_W2], over(VICAT2_Q16)










// Bivariate Analysen

* ökonomische Bedürfnisse
pwcorr neo kon soz lib VIC2_Q15 VICAT2_Q30 VIC2_Q13 ///
	if time_l==1 [aw=Weight_W2], sig obs

* wohlfahrtsstaatliche Bedürfnisse
pwcorr neo kon soz lib VICAT2_Q31 VICAT2_Q103 VIC2_Q100A4 wohn_aus nettowohn ///
	if time_l==1 [aw=Weight_W2], sig obs

* soziale Bedürfnisse
pwcorr neo kon soz lib VIC2_Q100A3 VIC2_Q98A10 kinder hhgröße ///
	if time_l==1 [aw=Weight_W2], sig obs

* passive Merkmale
pwcorr neo kon soz lib subj_sozPos VIC_birthyear_ges ///
	if time_l==1 [aw=Weight_W2], sig obs	
	
	
	
	

// Zufriedenheit mit sozialen Beziehungen nach sozialer Lage
reg VIC2_Q100A4 i.b1.lage if time_l==1 [aw=Weight_W2]
margins lage
contrast gw.lage, asobserved

/*
Es sind v.a. die bessergestellten Rentner, die mit ihrer Work-Life-Balance
zufrieden sind.
Unzufrieden sind dagegen v.a. die Erwerbslosen und Arbeiter.
*/
	
	

	
	
	

// Kategoriale Variablen
//----------------------

* ISCO
tab ISCO1 if time_l==1

reg neo i.b1.ISCO1 if time_l==1 [aw=Weight_W2]
pwcompare ISCO1, asobserved pv ci mcomp(sidak)

reg kon i.b1.ISCO1 if time_l==1 [aw=Weight_W2]
pwcompare ISCO1, asobserved pv ci mcomp(sidak)

reg soz i.b1.ISCO1 if time_l==1 [aw=Weight_W2]
pwcompare ISCO1, asobserved pv ci mcomp(sidak)

reg lib i.b1.ISCO1 if time_l==1 [aw=Weight_W2]
pwcompare ISCO1, asobserved pv ci mcomp(sidak)
	

	
	

	
* erwerb
tab erwerb if time_l==1

reg neo i.b1.erwerb if time_l==1 [aw=Weight_W2]
margins erwerb
contrast gw.erwerb, asobserved

reg kon i.b1.erwerb if time_l==1 [aw=Weight_W2]
margins erwerb
contrast gw.erwerb, asobserved

reg soz i.b1.erwerb if time_l==1 [aw=Weight_W2]
margins erwerb
contrast gw.erwerb, asobserved

reg lib i.b1.erwerb if time_l==1 [aw=Weight_W2]
margins erwerb
contrast gw.erwerb, asobserved	
	
	

	
* Wohnrechtsverhältnis
tab wohnrecht if time_l==1

reg neo i.b1.wohnrecht if time_l==1 [aw=Weight_W2]
margins wohnrecht
pwcompare wohnrecht, asobserved pv ci mcomp(sidak)

reg kon i.b1.wohnrecht if time_l==1 [aw=Weight_W2]
margins wohnrecht
pwcompare wohnrecht, asobserved pv ci mcomp(sidak)

reg soz i.b1.wohnrecht if time_l==1 [aw=Weight_W2]
margins wohnrecht
pwcompare wohnrecht, asobserved pv ci mcomp(sidak)

reg lib i.b1.wohnrecht if time_l==1 [aw=Weight_W2]
margins wohnrecht
pwcompare wohnrecht, asobserved pv ci mcomp(sidak)
	

	
* Beziehungsstatus
tab VIC2_Q3 if time_l==1

reg neo i.b1.VIC2_Q3 if time_l==1 [aw=Weight_W2]
margins VIC2_Q3
contrast gw.VIC2_Q3, asobserved
pwcompare VIC2_Q3, asobserved pv ci mcomp(sidak)

reg kon i.b1.VIC2_Q3 if time_l==1 [aw=Weight_W2]
margins VIC2_Q3
contrast gw.VIC2_Q3, asobserved
pwcompare VIC2_Q3, asobserved pv ci mcomp(sidak)

reg soz i.b1.VIC2_Q3 if time_l==1 [aw=Weight_W2]
margins VIC2_Q3
contrast gw.VIC2_Q3, asobserved
pwcompare VIC2_Q3, asobserved pv ci mcomp(sidak)

reg lib i.b1.VIC2_Q3 if time_l==1 [aw=Weight_W2]
margins VIC2_Q3
contrast gw.VIC2_Q3, asobserved	
pwcompare VIC2_Q3, asobserved pv ci mcomp(sidak)


mean age [aw=Weight_W2] if time_l==1, over(VIC2_Q3)
mean age [aw=Weight_W2] if time_l==1




* Diskriminierungen
tab VICAT2_Q93 if time_l==1

reg neo i.b1.VICAT2_Q93 if time_l==1 [aw=Weight_W2]
margins VICAT2_Q93
contrast gw.VICAT2_Q93, asobserved
pwcompare VICAT2_Q93, asobserved pv ci mcomp(sidak)

reg kon i.b1.VICAT2_Q93 if time_l==1 [aw=Weight_W2]
margins VICAT2_Q93
contrast gw.VICAT2_Q93, asobserved
pwcompare VICAT2_Q93, asobserved pv ci mcomp(sidak)

reg soz i.b1.VICAT2_Q93 if time_l==1 [aw=Weight_W2]
margins VICAT2_Q93
contrast gw.VICAT2_Q93, asobserved
pwcompare VICAT2_Q93, asobserved pv ci mcomp(sidak)

reg lib i.b1.VICAT2_Q93 if time_l==1 [aw=Weight_W2]
margins VICAT2_Q93
contrast gw.VICAT2_Q93, asobserved
pwcompare VICAT2_Q93, asobserved pv ci mcomp(sidak)	
	


	

	
* Geschlecht
tab sex if time_l==1

reg neo i.b1.sex if time_l==1 [aw=Weight_W2]
margins sex	

reg kon i.b1.sex if time_l==1 [aw=Weight_W2]
margins sex

reg soz i.b1.sex if time_l==1 [aw=Weight_W2]
margins sex

reg lib i.b1.sex if time_l==1 [aw=Weight_W2]
margins sex
	

	
	
	
	
* Migrationshintergrund
tab migration if time_l==1

reg neo i.b1.migration if time_l==1 [aw=Weight_W2]
margins migration
contrast gw.migration, asobserved
pwcompare migration, asobserved pv ci mcomp(sidak)

reg kon i.b1.migration if time_l==1 [aw=Weight_W2]
margins migration
contrast gw.migration, asobserved
pwcompare migration, asobserved pv ci mcomp(sidak)

reg soz i.b1.migration if time_l==1 [aw=Weight_W2]
margins migration
contrast gw.migration, asobserved
pwcompare migration, asobserved pv ci mcomp(sidak)

reg lib i.b1.migration if time_l==1 [aw=Weight_W2]
margins migration
contrast gw.migration, asobserved		
pwcompare migration, asobserved pv ci mcomp(sidak)







	
* Wohngebiet
tab VIC2_Q7 if time_l==1
pwcorr neo kon soz lib if VIC2_Q7==1 [aw=Weight_W2], obs sig
pwcorr neo kon soz lib if VIC2_Q7==2 [aw=Weight_W2], obs sig
pwcorr neo kon soz lib if VIC2_Q7==3 [aw=Weight_W2], obs sig
pwcorr neo kon soz lib if VIC2_Q7==4 [aw=Weight_W2], obs sig
pwcorr neo kon soz lib if VIC2_Q7==5 [aw=Weight_W2], obs sig	
	
mean neo kon soz lib [aw=Weight_W2], over(VIC2_Q7)	
	
	
reg neo i.b1.VIC2_Q7 if time_l==1 [aw=Weight_W2]
contrast gw.VIC2_Q7, asobserved
pwcompare VIC2_Q7, asobserved pv ci mcomp(sidak)

reg kon i.b1.VIC2_Q7 if time_l==1 [aw=Weight_W2]
contrast gw.VIC2_Q7, asobserved
pwcompare VIC2_Q7, asobserved pv ci mcomp(sidak)

reg soz i.b1.VIC2_Q7 if time_l==1 [aw=Weight_W2]
contrast gw.VIC2_Q7, asobserved
pwcompare VIC2_Q7, asobserved pv ci mcomp(sidak)

reg lib i.b1.VIC2_Q7 if time_l==1 [aw=Weight_W2]
contrast gw.VIC2_Q7, asobserved
pwcompare VIC2_Q7, asobserved pv ci mcomp(sidak)


tab ISCO1 VIC2_Q7 [aw=Weight_W2], row
tab ISCO2 VIC2_Q7 [aw=Weight_W2], row




// Zusammenhang zwischen Wohnsituation (4 Variablen) und POLID (Abb. 44)
pwcorr nettowohn VICAT2_Q11 kinder hhgröße neo kon soz lib if time_l==1 [aw=Weight_W2], sig obs
pwcorr nettowohn VICAT2_Q11 kinder hhgröße [aw=Weight_W2], sig obs













// Regressionsanalysen
//--------------------


/*
Aufbau der Modelle: nach Hradils Aufteilung in verschiedene Bedürfnisse

Modell 1: Ökonomisch
Modell 2: Wohlfahrtsstaatlich
Modell 3: Wohn(um)weltbedingungen
Modell 4: Sozial
Modell 5: Demografie
*/



// Variablenaufbereitung für die Regressionen
//-------------------------------------------	
	
	
tab ISCO1, m
recode ISCO1 (.a=99) (.b=99) (.c=99), gen(ISCO1_gr)
tab ISCO1 ISCO1_gr, m


recode eink2 (1=1) (2=1) (3=1) (4=2) (5=2) ///
	(6=3) (7=3) (8=4) (9=4) (10=4) ///
	(.a=97) (.b=98) (.c=99), gen(eink2_gr)
tab eink2 eink2_gr, m

tab eink2_gr erwerb, m
replace eink2_gr = 100 if erwerb==6 & eink2_gr==.





tab eink2_gr if time_l==1
tab erwerb if time_l==1


recode erwerb (1=1) (2=1) (3=1) ///
	 (4=2) (5=3) (6=4) (7=5) (8=6) (9=7) (10=8), gen(erwerb2)
tab erwerb erwerb2




gen erwerb3 = 0 if Teilnahme_W2==1
* Angestellt
replace erwerb3 = 11 if inlist(eink2_gr,1,2) & erwerb2==1
replace erwerb3 = 12 if inlist(eink2_gr,3,4) & erwerb2==1

* Selbstständig
replace erwerb3 = 21 if inlist(eink2_gr,1,2) & erwerb2==2
replace erwerb3 = 22 if inlist(eink2_gr,3,4) & erwerb2==2

* Kurzarbeit
replace erwerb3 = 31 if erwerb2==3

* Nicht erwerbstätig
replace erwerb3 = 40 if erwerb2==4

* Rente
replace erwerb3 = 51 if inlist(eink2_gr,1,2) & erwerb2==5
replace erwerb3 = 52 if inlist(eink2_gr,3,4) & erwerb2==5
replace erwerb3 = 53 if erwerb2==5 & erwerb3==0

* Hausfrauen/-männer (& Karenz)
replace erwerb3 = 60 if erwerb2==6

* In Ausbildung
replace erwerb3 = 71 if inlist(eink2_gr,1,2,3,4) & erwerb2==7
replace erwerb3 = 72 if inlist(eink2_gr,97,98,99) & erwerb2==7

* Sonstiges
replace erwerb3 = 80 if erwerb2==8


tab erwerb3 if Teilnahme_W2==1, m
tab erwerb3 if time_l==1
tab erwerb3 erwerb, m
list id erwerb3 VICAT2_Q30 erwerb if erwerb3==0 & Teilnahme_W2==1
tab erwerb3 eink2_gr, m


lab define erwerb3 ///
	11 "Angestellte (u Median)" 12 "Angestellte (ü Median)" ///
	21 "Selbstständig (u Median)" 22 "Selbstständig (ü Median)" ///
	31 "Kurzarbeit" ///
	40 "Erwerbslose" ///
	51 "Rentner (u Median)" 52 "Rentner (ü Median)" 53 "Rentner (o. Einkommen)" ///
	60 "Homemakers / Karenz" 80 "Sonstiges" ///
	71 "Stud/Azubis (o. Einkommen)" 72 "Stud/Azubis (m. Einkommne)"
lab values erwerb3 erwerb3

tab erwerb3 if time_l==1







recode VICAT2_Q31 (.=99) (1=4) (2=3) (3=2) (4=1) , gen(sorge)
tab VICAT2_Q31 sorge, m






* Gültiges Sample festlegen
gen sample = 1
replace sample = . if time_l!=1
replace sample = . if erwerb3==0
replace sample = . if VICAT2_Q103==.
replace sample = . if wohnrecht==.
replace sample = . if sex==.
replace sample = . if VICAT2_Q101==99
tab sample, m



tab erwerb3 if sample==1
tab sorge if sample==1



* Korrelation zwischen Haushalts- und persönlichem Einkommen
pwcorr VIC2_Q13 VICAT2_Q30 [aweight=Weight_W2], sig obs




// Libertarismus

* Modell 1
reg neo i.b1.hheink i.b40.erwerb3 i.b1.bildung i.b1.ISCO1_gr ///
	if sample==1 [aweight=Weight_W2]
estimates store neo_1

* Modell 2
reg neo i.b1.hheink i.b40.erwerb3 i.b1.bildung i.b1.ISCO1_gr ///
	i.b0.vollzeit VICAT2_Q103 VIC2_Q100A4 ///
	if sample==1 [aweight=Weight_W2]
estimates store neo_2

* Modell 3
reg neo i.b1.hheink i.b40.erwerb3 i.b1.bildung i.b1.ISCO1_gr ///
	i.b0.vollzeit VICAT2_Q103 VIC2_Q100A4 ///
	wohn_aus nettowohn i.b1.VIC2_Q7 i.b1.wohnrecht ///
	if sample==1 [aweight=Weight_W2]
estimates store neo_3

* Modell 4
reg neo i.b1.hheink i.b40.erwerb3 i.b1.bildung i.b1.ISCO1_gr ///
	i.b0.vollzeit VICAT2_Q103 VIC2_Q100A4 ///
	wohn_aus nettowohn i.b1.VIC2_Q7 i.b1.wohnrecht ///
	VIC2_Q100A3 i.b1.VIC2_Q3 hhgröße kinder ///
	if sample==1 [aweight=Weight_W2]
estimates store neo_4

* Modell 5
reg neo i.b1.hheink i.b40.erwerb3 i.b1.bildung i.b1.ISCO1_gr ///
	i.b0.vollzeit VICAT2_Q103 VIC2_Q100A4 ///
	wohn_aus nettowohn i.b1.VIC2_Q7 i.b1.wohnrecht ///
	VIC2_Q100A3 i.b1.VIC2_Q3 hhgröße kinder ///
	i.b1.sex VIC_birthyear_ges i.b0.migration i.b2.VICAT2_Q93 ///
	if sample==1 [aweight=Weight_W2]
estimates store neo_5


* Modell 6
reg neo i.b1.hheink i.b40.erwerb3 i.b1.bildung i.b1.ISCO1_gr ///
	i.b0.vollzeit VICAT2_Q103 VIC2_Q100A4 ///
	wohn_aus nettowohn i.b1.VIC2_Q7 i.b1.wohnrecht ///
	VIC2_Q100A3 i.b1.VIC2_Q3 hhgröße kinder ///
	i.b1.sex VIC_birthyear_ges i.b0.migration i.b2.VICAT2_Q93 VICAT2_Q101 trust ///
	if sample==1 [aweight=Weight_W2]
estimates store neo_6



cd "C:\Users\b1065535\Desktop\Volltext - Diss\POLID-Korrelationen - aweights\Regressionstabellen"
esttab neo_1 neo_2 neo_3 neo_4 neo_5 neo_6 using neo2.rtf, b(2) se(2) r2 ///
	label onecell compress star(+ 0.1 * 0.05 ** 0.01 *** 0.001) ///
	mtitles ("Modell 1.1" "Modell 1.2" "Modell 1.3" "Modell 1.4" "Modell 1.5" "Modell 1.6") replace






// Konservativismus

* Modell 1
reg kon i.b1.hheink i.b40.erwerb3 i.b1.bildung i.b1.ISCO1_gr ///
	if sample==1 [aweight=Weight_W2]
estimates store kon_1

* Modell 2
reg kon i.b1.hheink i.b40.erwerb3 i.b1.bildung i.b1.ISCO1_gr ///
	i.b0.vollzeit VICAT2_Q103 VIC2_Q100A4 ///
	if sample==1 [aweight=Weight_W2]
estimates store kon_2

* Modell 3
reg kon i.b1.hheink i.b40.erwerb3 i.b1.bildung i.b1.ISCO1_gr ///
	i.b0.vollzeit VICAT2_Q103 VIC2_Q100A4 ///
	wohn_aus nettowohn i.b1.VIC2_Q7 i.b1.wohnrecht ///
	if sample==1 [aweight=Weight_W2]
estimates store kon_3

* Modell 4
reg kon i.b1.hheink i.b40.erwerb3 i.b1.bildung i.b1.ISCO1_gr ///
	i.b0.vollzeit VICAT2_Q103 VIC2_Q100A4 ///
	wohn_aus nettowohn i.b1.VIC2_Q7 i.b1.wohnrecht ///
	VIC2_Q100A3 i.b1.VIC2_Q3 hhgröße kinder ///
	if sample==1 [aweight=Weight_W2]
estimates store kon_4

* Modell 5
reg kon i.b1.hheink i.b40.erwerb3 i.b1.bildung i.b1.ISCO1_gr ///
	i.b0.vollzeit VICAT2_Q103 VIC2_Q100A4 ///
	wohn_aus nettowohn i.b1.VIC2_Q7 i.b1.wohnrecht ///
	VIC2_Q100A3 i.b1.VIC2_Q3 hhgröße kinder ///
	i.b1.sex VIC_birthyear_ges i.b0.migration i.b2.VICAT2_Q93 ///
	if sample==1 [aweight=Weight_W2]
estimates store kon_5


* Modell 6
reg kon i.b1.hheink i.b40.erwerb3 i.b1.bildung i.b1.ISCO1_gr ///
	i.b0.vollzeit VICAT2_Q103 VIC2_Q100A4 ///
	wohn_aus nettowohn i.b1.VIC2_Q7 i.b1.wohnrecht ///
	VIC2_Q100A3 i.b1.VIC2_Q3 hhgröße kinder ///
	i.b1.sex VIC_birthyear_ges i.b0.migration i.b2.VICAT2_Q93 VICAT2_Q101 trust ///
	if sample==1 [aweight=Weight_W2]
estimates store kon_6


cd "C:\Users\b1065535\Desktop\Volltext - Diss\POLID-Korrelationen - aweights\Regressionstabellen"
esttab kon_1 kon_2 kon_3 kon_4 kon_5 kon_6 using kon2.rtf, b(2) se(2) r2 ///
	label onecell compress star(+ 0.1 * 0.05 ** 0.01 *** 0.001) ///
	mtitles ("Modell 2.1" "Modell 2.2" "Modell 2.3" "Modell 2.4" "Modell 2.5" "Modell 2.6") replace


	
	
	
	
	
// Sozialismus

* Modell 1
reg soz i.b1.hheink i.b40.erwerb3 i.b1.bildung i.b1.ISCO1_gr ///
	if sample==1 [aweight=Weight_W2]
estimates store soz_1

* Modell 2
reg soz i.b1.hheink i.b40.erwerb3 i.b1.bildung i.b1.ISCO1_gr ///
	i.b0.vollzeit VICAT2_Q103 VIC2_Q100A4 ///
	if sample==1 [aweight=Weight_W2]
estimates store soz_2

* Modell 3
reg soz i.b1.hheink i.b40.erwerb3 i.b1.bildung i.b1.ISCO1_gr ///
	i.b0.vollzeit VICAT2_Q103 VIC2_Q100A4 ///
	wohn_aus nettowohn i.b1.VIC2_Q7 i.b1.wohnrecht ///
	if sample==1 [aweight=Weight_W2]
estimates store soz_3

* Modell 4
reg soz i.b1.hheink i.b40.erwerb3 i.b1.bildung i.b1.ISCO1_gr ///
	i.b0.vollzeit VICAT2_Q103 VIC2_Q100A4 ///
	wohn_aus nettowohn i.b1.VIC2_Q7 i.b1.wohnrecht ///
	VIC2_Q100A3 i.b1.VIC2_Q3 hhgröße kinder ///
	if sample==1 [aweight=Weight_W2]
estimates store soz_4

* Modell 5
reg soz i.b1.hheink i.b40.erwerb3 i.b1.bildung i.b1.ISCO1_gr ///
	i.b0.vollzeit VICAT2_Q103 VIC2_Q100A4 ///
	wohn_aus nettowohn i.b1.VIC2_Q7 i.b1.wohnrecht ///
	VIC2_Q100A3 i.b1.VIC2_Q3 hhgröße kinder ///
	i.b1.sex VIC_birthyear_ges i.b0.migration i.b2.VICAT2_Q93 ///
	if sample==1 [aweight=Weight_W2]
estimates store soz_5


* Modell 6
reg soz i.b1.hheink i.b40.erwerb3 i.b1.bildung i.b1.ISCO1_gr ///
	i.b0.vollzeit VICAT2_Q103 VIC2_Q100A4 ///
	wohn_aus nettowohn i.b1.VIC2_Q7 i.b1.wohnrecht ///
	VIC2_Q100A3 i.b1.VIC2_Q3 hhgröße kinder ///
	i.b1.sex VIC_birthyear_ges i.b0.migration i.b2.VICAT2_Q93 VICAT2_Q101 trust ///
	if sample==1 [aweight=Weight_W2]
estimates store soz_6


cd "C:\Users\b1065535\Desktop\Volltext - Diss\POLID-Korrelationen - aweights\Regressionstabellen"
esttab soz_1 soz_2 soz_3 soz_4 soz_5 soz_6 using soz2.rtf, b(2) se(2) r2 ///
	label onecell compress star(+ 0.1 * 0.05 ** 0.01 *** 0.001) ///
	mtitles ("Modell 3.1" "Modell 3.2" "Modell 3.3" "Modell 3.4" "Modell 3.5" "Modell 3.6") replace
	
	
	
	
	
	
	
	
// Liberalismus

* Modell 1
reg lib i.b1.hheink i.b40.erwerb3 i.b1.bildung i.b1.ISCO1_gr ///
	if sample==1 [aweight=Weight_W2]
estimates store lib_1

* Modell 2
reg lib i.b1.hheink i.b40.erwerb3 i.b1.bildung i.b1.ISCO1_gr ///
	i.b0.vollzeit VICAT2_Q103 VIC2_Q100A4 ///
	if sample==1 [aweight=Weight_W2]
estimates store lib_2

* Modell 3
reg lib i.b1.hheink i.b40.erwerb3 i.b1.bildung i.b1.ISCO1_gr ///
	i.b0.vollzeit VICAT2_Q103 VIC2_Q100A4 ///
	wohn_aus nettowohn i.b1.VIC2_Q7 i.b1.wohnrecht ///
	if sample==1 [aweight=Weight_W2]
estimates store lib_3

* Modell 4
reg lib i.b1.hheink i.b40.erwerb3 i.b1.bildung i.b1.ISCO1_gr ///
	i.b0.vollzeit VICAT2_Q103 VIC2_Q100A4 ///
	wohn_aus nettowohn i.b1.VIC2_Q7 i.b1.wohnrecht ///
	VIC2_Q100A3 i.b1.VIC2_Q3 hhgröße kinder ///
	if sample==1 [aweight=Weight_W2]
estimates store lib_4

* Modell 5
reg lib i.b1.hheink i.b40.erwerb3 i.b1.bildung i.b1.ISCO1_gr ///
	i.b0.vollzeit VICAT2_Q103 VIC2_Q100A4 ///
	wohn_aus nettowohn i.b1.VIC2_Q7 i.b1.wohnrecht ///
	VIC2_Q100A3 i.b1.VIC2_Q3 hhgröße kinder ///
	i.b1.sex VIC_birthyear_ges i.b0.migration i.b2.VICAT2_Q93 ///
	if sample==1 [aweight=Weight_W2]
estimates store lib_5


* Modell 6
reg lib i.b1.hheink i.b40.erwerb3 i.b1.bildung i.b1.ISCO1_gr ///
	i.b0.vollzeit VICAT2_Q103 VIC2_Q100A4 ///
	wohn_aus nettowohn i.b1.VIC2_Q7 i.b1.wohnrecht ///
	VIC2_Q100A3 i.b1.VIC2_Q3 hhgröße kinder ///
	i.b1.sex VIC_birthyear_ges i.b0.migration i.b2.VICAT2_Q93 VICAT2_Q101 trust ///
	if sample==1 [aweight=Weight_W2]
estimates store lib_6



cd "C:\Users\b1065535\Desktop\Volltext - Diss\POLID-Korrelationen - aweights\Regressionstabellen"
esttab lib_1 lib_2 lib_3 lib_4 lib_5 lib_6 using lib2.rtf, b(2) se(2) r2 ///
	label onecell compress star(+ 0.1 * 0.05 ** 0.01 *** 0.001) ///
	mtitles ("Modell 4.1" "Modell 4.2" "Modell 4.3" "Modell 4.4" "Modell 4.5" "Modell 4.6") replace
	
	
	
	
	
	
	
	
	
	

	
	
// Multikollinearitätscheck
//-------------------------
quietly reg neo i.b1.hheink i.b40.erwerb3 i.b1.bildung i.b1.ISCO1_gr ///
	i.b0.vollzeit VICAT2_Q103 VIC2_Q100A4 ///
	wohn_aus nettowohn i.b1.VIC2_Q7 i.b1.wohnrecht ///
	VIC2_Q100A3 i.b1.VIC2_Q3 hhgröße kinder ///
	i.b1.sex VIC_birthyear_ges i.b0.migration i.b2.VICAT2_Q93 VICAT2_Q101 trust ///
	if sample==1
vif

quietly reg kon i.b1.hheink i.b40.erwerb3 i.b1.bildung i.b1.ISCO1_gr ///
	i.b0.vollzeit VICAT2_Q103 VIC2_Q100A4 ///
	wohn_aus nettowohn i.b1.VIC2_Q7 i.b1.wohnrecht ///
	VIC2_Q100A3 i.b1.VIC2_Q3 hhgröße kinder ///
	i.b1.sex VIC_birthyear_ges i.b0.migration i.b2.VICAT2_Q93 VICAT2_Q101 trust ///
	if sample==1
vif

quietly reg soz i.b1.hheink i.b40.erwerb3 i.b1.bildung i.b1.ISCO1_gr ///
	i.b0.vollzeit VICAT2_Q103 VIC2_Q100A4 ///
	wohn_aus nettowohn i.b1.VIC2_Q7 i.b1.wohnrecht ///
	VIC2_Q100A3 i.b1.VIC2_Q3 hhgröße kinder ///
	i.b1.sex VIC_birthyear_ges i.b0.migration i.b2.VICAT2_Q93 VICAT2_Q101 trust ///
	if sample==1
vif

quietly reg lib i.b1.hheink i.b40.erwerb3 i.b1.bildung i.b1.ISCO1_gr ///
	i.b0.vollzeit VICAT2_Q103 VIC2_Q100A4 ///
	wohn_aus nettowohn i.b1.VIC2_Q7 i.b1.wohnrecht ///
	VIC2_Q100A3 i.b1.VIC2_Q3 hhgröße kinder ///
	i.b1.sex VIC_birthyear_ges i.b0.migration i.b2.VICAT2_Q93 VICAT2_Q101 trust ///
	if sample==1
vif

/*
Kein VIF-Wert über 10
*/
	
	
	
	
	
	
	
	
// Im Fließtext erwähnte weitere Auswertungen
//-------------------------------------------

	
* Wissenschaftszweige der Akademisch gebildeten
tab VICAT2_Q16 bildung if sample==1	 [aweight=Weight_W2], col
mean neo if sample==1 [aweight=Weight_W2], over(VICAT2_Q16)
mean kon if sample==1 [aweight=Weight_W2], over(VICAT2_Q16)	
mean soz if sample==1 [aweight=Weight_W2], over(VICAT2_Q16)
mean lib if sample==1 [aweight=Weight_W2], over(VICAT2_Q16)


* Herkunftsländer der Migranten erster Generation
tab VICAT2_Q37 if migration==1 & sample==1 [aweight=Weight_W2]



	
* Anteil der BA-Studenten bei den Pflichtschulabsolventen im gültigen Sample
tab erwerb if sample==1 & bildung==1 [aweight=Weight_W2]


	
* Korrelation zwischen Liberalismus und Impfverweigerung
pwcorr lib VICAT2_Q59 if time_l==1 [aweight=Weight_W2], sig obs
pwcorr lib VICAT2_Q59 if sample==1 [aweight=Weight_W2], sig obs



* Unterschiedliches Institutionsvertrauen nach sozioökon. Pos.
reg trust i.b1.eink2_gr if sample==1 [aweight=Weight_W2]
margins eink2_gr

reg VICAT2_Q59 i.b1.eink2_gr if sample==1 [aweight=Weight_W2]
margins eink2_gr	
	

* Korrelation zwischen Einkommen und Impfverweigerung bzw. Institutionsvertrauen
pwcorr VICAT2_Q30 VICAT2_Q59 if sample==1 [aweight=Weight_W2], sig obs
pwcorr VICAT2_Q30 trust if sample==1 [aweight=Weight_W2], sig obs	
	
	
	
* Wohnrechtsverhältnis * Beziehungsstatus
tab VIC2_Q3 wohnrecht [aweight=Weight_W2], row
	
	





exit



