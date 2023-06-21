/* #############################################################################
								Korrespondenzanalyse
############################################################################# */

clear all
macro drop _all
capture log close
version 16.1
set more off
numlabel, add


use "C:\Users\b1065535\Desktop\Value in Crisis\Daten\VIC_ges4_weights.dta"




/* ###############################################
Variablenaufbereitung für die Korrespondenzanalyse
############################################### */






* eink2
tab VICAT2_Q30, m


recode VICAT2_Q30 (1=1) ///	<450
	(2=2) (3=2) (4=2) ///	450-899 Euro
	(5=3) (6=4) (7=5) (8=6) (9=7) (10=8) (11=9) ///
	(12=10) (13=10) (14=10) (15=10) (16=10) (17=10) (18=10), gen(eink2)

tab VICAT2_Q30 erwerb, m
	
recode eink2 (.=.a) if erwerb==7	//Renten-missing
recode eink2 (.=.b) if erwerb==9	//Ausbildungs-missing
recode eink2 (.=.c) if erwerb==8 	//Hausfrau/-mann-missing

tab VICAT2_Q30 eink2 if Teilnahme_W2==1, m
	
	
	
lab var eink2 "Einkommen (10 Gruppen)"
lab define eink2 1 "[1] < 450 €" ///
	2 "[2] 450 - 899 €" ///
	3 "[3] 900 - 1.124 €" ///
	4 "[4] 1.125 - 1.349 €" ///
	5 "[5] 1.350 - 1.649 €" ///
	6 "[6] 1.650 - 1.949 €" ///
	7 "[7] 1.950 - 2.249 €" ///
	8 "[8] 2.250 - 2.699 €" ///
	9 "[9] 2.700 - 3.149 €" ///
	10 "[10] 3.150 € und mehr"
lab values eink2 eink2
	
tab VICAT2_Q30 eink2, m
tab eink2 eink if Teilnahme_W2==1, m	

	
	


// hheink2
tab VIC2_Q13, m

recode VIC2_Q13 (1=1) (2=2) (3=2) (4=2) ///
	(5=3) (6=4) (7=5) (8=6) (9=7) (10=8) (11=9) ///
	(12=10) (13=11) (14=12) (15=13) ///
	(16=14) (17=14) (18=14), gen(hheink2)
	
lab var hheink2 "HH-Einkommen"
lab define hheink2 1 "[1] < 599 Euro" ///
	2 "[2] 600 - 1.124 Euro" ///
	3 "[3] 1.125 - 1.349 Euro" ///
	4 "[4] 1.350 - 1.649 Euro" ///
	5 "[5] 1.650 - 1.949 Euro" ///
	6 "[6] 1.950 - 2.249 Euro" ///
	7 "[7] 2.250 - 2.699 Euro" ///
	8 "[8] 2.700 - 3.149 Euro" ///
	9 "[9] 3.150 - 3.599 Euro" ///
	10 "[10] 3.600 - 4.049 Euro" ///
	11 "[11] 4.050 - 4.499 Euro" ///
	12 "[12] 4.500 - 5.499 Euro" ///
	13 "[13] 5.500 - 6.499 Euro" ///
	14 "[14] 6.500 oder mehr Euro"
lab values hheink2 hheink2
	
tab hheink2 hheink,m
tab VIC2_Q13 hheink2,m




// ISCO1
recode ISCO1 (-9999=.a) (9998=.b) (9999=.c)
tab ISCO1, m


// Auskommen mit HH-Einkommen
recode VICAT2_Q103 (9=.)	







	

	
	
	
	
	
// Korrespondenzanalyse (2 Dimensionen)
mca bildung hheink2 ///
	eink2 ISCO1 erwerb VICAT2_Q31 VICAT2_Q103 ///
	VIC2_Q100A4 ///
	wohn_aus nettowohn_gr VIC2_Q7 wohnrecht ///
	VIC2_Q100A3 VIC2_Q3 hhgröße kinder ///
	VIC2_Q98A10 ///
	VICAT2_Q93 if Teilnahme_W2==1, ///
	sup(sex VIC2_Q2_Alter vollzeit subj_sozPos migration) miss
screeplot
/* mcaprojection bildung hheink2 eink2 ISCO1, norm(standard) */
	
	
// Korrespondenzanalyse (3 Dimensionen)
mca bildung hheink2 ///
	eink2 ISCO1 erwerb VICAT2_Q31 VICAT2_Q103 ///
	VIC2_Q100A4 ///
	wohn_aus nettowohn_gr VIC2_Q7 wohnrecht ///
	VIC2_Q100A3 VIC2_Q3 hhgröße kinder ///
	VIC2_Q98A10 ///
	VICAT2_Q93 if Teilnahme_W2==1, ///
	sup(sex VIC2_Q2_Alter vollzeit subj_sozPos migration) miss dim(3)	
estat coordinates, norm(s)
/*
mcaprojection bildung, norm(standard)
mcaprojection eink2, norm(standard)
mcaprojection hheink2, norm(standard)
mcaprojection ISCO1, norm(standard)
mcaprojection erwerb, norm(standard)
mcaprojection VICAT2_Q31, norm(standard)
mcaprojection VICAT2_Q103, norm(standard)
mcaprojection VIC2_Q100A4, norm(standard)
mcaprojection wohn_aus, norm(standard)
mcaprojection nettowohn_gr, norm(standard)
mcaprojection VIC2_Q7, norm(standard)
mcaprojection wohnrecht, norm(standard)
mcaprojection VIC2_Q100A3, norm(standard)
mcaprojection VIC2_Q3, norm(standard)
mcaprojection hhgröße, norm(standard)
mcaprojection kinder, norm(standard)
mcaprojection VIC2_Q98A10, norm(standard)
mcaprojection VICAT2_Q93, norm(standard)
*/
	


	
	
// MCA-Plot mit id
mca bildung hheink2 ///
	eink2 ISCO1 erwerb VICAT2_Q31 VICAT2_Q103 ///
	VIC2_Q100A4 ///
	wohn_aus nettowohn_gr VIC2_Q7 wohnrecht ///
	VIC2_Q100A3 VIC2_Q3 hhgröße kinder ///
	VIC2_Q98A10 ///
	VICAT2_Q93 if Teilnahme_W2==1, ///
	sup(sex VIC2_Q2_Alter vollzeit subj_sozPos migration id) miss
/* mcaprojection bildung hheink2 eink2 ISCO1, norm(standard) */
mcaplot id
	
	
	

	
	

	
	
	

	
//------------------------------
// Erstellung der sozialen Lagen
//------------------------------


// Erstellen der ersten Lage-Variable
gen lage = .





// Lage 1 = Studenten/Lehrlinge/Azubis
replace lage = 1 if erwerb==9
replace lage = 1 if lage!=. & eink2==.b
replace lage = 1 if lage!=. & erwerb==9 & ISCO1==.a

tab lage erwerb, m





// Lage 2 [und 3] = Rentner
replace lage = 2 if erwerb==7

/*
Weil es sehr viele Rentner im Datensatz gibt (N=508), werden sie in besser-
und schlechtergestellte Rentner unterteilt.

-> Rückgriff auf Auskommen mit HH-Einkommen (mit HH-Einkommen als sekundäres Merkmal)
	Cutoff bei HH-Eink = ca. 50% der Verteilung = [8] | [9]
*/


replace lage = 3 if lage==2 & inlist(VICAT2_Q103,1,2)
replace lage = 3 if lage==2 & VICAT2_Q103==3 & inrange(hheink2,1,8)

tab lage VICAT2_Q103, m
tab hheink2 lage, m






// Lage 4 = Nichterwerbstätige
replace lage = 4 if lage==. & erwerb==6

tab ISCO1 lage, m
tab erwerb lage, m






// Lage 5 = Hausfrauen/-männer oder Karenz
replace lage = 5 if lage==. & erwerb==8







// Hilfskategorien
replace lage = 99 if inlist(erwerb,3,10)
replace lage = 98 if inlist(erwerb,1,2,4,5)


tab lage, m



// Nachtrag für Lage 1 (Studenten/Lehrlinge)
tab ISCO1 erwerb, m
replace lage = 1 if lage==99 & ISCO1==.a
replace lage = 1 if ISCO1==.a






// Lage 6 = Führungskräfte
replace lage = 6 if inlist(lage,98,99) & ISCO1==1


// Lage 7 = Akademiker
replace lage = 7 if inlist(lage,98,99) & ISCO1==2


// Lage 8 = Techniker
replace lage = 8 if inlist(lage,98,99) & ISCO1==3


// Lage 9 = Bürokräfte
replace lage = 9 if inlist(lage,98,99) & ISCO1==4


// Lage 10 = Dienstleister
replace lage = 10 if inlist(lage,98,99) & ISCO1==5


// Lage 11 = Landwirte
replace lage = 11 if inlist(lage,98,99) & ISCO1==6


// Lage 12 = Arbeiter
replace lage = 12 if inlist(lage,98,99) & inlist(ISCO1,7,8)
replace lage = 12 if lage==98 & erwerb==3


// Lage 13 = Hilfskräfte
replace lage = 13 if inlist(lage,98,99) & ISCO1==9



// Lage 14 = Sonst. Erwerbstätige
replace lage = 14 if lage==98 & inlist(erwerb,1,2,4)
replace lage = 14 if lage==99 & erwerb==10




tab ISCO1 lage,m
tab lage erwerb,m 


replace lage = 12 if lage==99 & erwerb==3
replace lage = 14 if lage==98









tab lage if Teilnahme_W2==1 [aw=Weight_W2]
tab lage if time_l==1 [aw=Weight_W2]











// #######################################################
// Prüfung auf Homogenität der Lagen & evtl. Recodierungen
// #######################################################




// Diagramm zur Abweichung vom Mittelwert
//---------------------------------------

* Bildung (z-standardisiert)
sum VIC2_Q15 if Teilnahme_W2==1 [aw=Weight_W2]
gen bildung_z = (VIC2_Q15-3.823555)/3.148005
sum bildung_z

reg bildung_z i.b1.lage if Teilnahme_W2==1 [aw=Weight_W2]
contrast gw.lage, asobserved





* HH-Einkommen (z-standardisiert)
sum VIC2_Q13 if Teilnahme_W2==1 [aw=Weight_W2]
gen hheink_z = (VIC2_Q13-8.926574)/3.827609
sum hheink_z

reg hheink_z i.b1.lage if time_l==1 [aw=Weight_W2]
contrast gw.lage, asobserved





* Einkommen (z-standardisiert)
sum VICAT2_Q30 if Teilnahme_W2==1 [aw=Weight_W2]
gen eink_z = (VICAT2_Q30-7.272158)/3.213756
sum eink_z

reg eink_z i.b1.lage if time_l==1 [aw=Weight_W2]
contrast gw.lage, asobserved





* Sorge vor Jobverlust (z-standardisiert)
sum VICAT2_Q31 if Teilnahme_W2==1 [aw=Weight_W2]
gen worry_z = (VICAT2_Q31-3.083704)/1.002123
sum worry_z

reg worry_z i.b1.lage if time_l==1 [aw=Weight_W2]
contrast gw.lage, asobserved





* Auskommen mit HH-Einkommen (z-standardisiert)
sum VICAT2_Q103 if Teilnahme_W2==1 [aw=Weight_W2]
gen auskommen_z = (VICAT2_Q103-3.339284)/1.110973
sum auskommen_z

reg auskommen_z i.b1.lage if time_l==1 [aw=Weight_W2]
contrast gw.lage, asobserved




* Zufr. Work-Life-Balance (z-standardisiert)
sum VIC2_Q100A4 if Teilnahme_W2==1 [aw=Weight_W2]
gen worklife_z = (VIC2_Q100A4-6.469862)/2.404061
sum worklife_z

reg worklife_z i.b1.lage if time_l==1 [aw=Weight_W2]
contrast gw.lage, asobserved




* Wohnraumausstattung (z-standardisiert)
sum wohn_aus if Teilnahme_W2==1 [aw=Weight_W2]
gen wohnaus_z = (wohn_aus-2.183719)/1.22827 if Teilnahme_W2==1
sum wohnaus_z

reg wohnaus_z i.b1.lage if time_l==1 [aw=Weight_W2]
contrast gw.lage, asobserved




* Nettowohnfläche (z-standardisiert)
sum nettowohn if Teilnahme_W2==1 [aw=Weight_W2]
gen nettowohn_z = (nettowohn-4.315075)/2.670283
sum nettowohn_z

reg nettowohn_z i.b1.lage if time_l==1 [aw=Weight_W2]
contrast gw.lage, asobserved





* Zufr: soz. Beziehungen (z-standardisiert)
sum VIC2_Q100A3 if Teilnahme_W2==1 [aw=Weight_W2]
gen sozbez_z = (VIC2_Q100A3-6.755713)/2.472603
sum sozbez_z

reg sozbez_z i.b1.lage if time_l==1 [aw=Weight_W2]
contrast gw.lage, asobserved




* Haushaltsgröße (z-standardisiert)
sum VIC2_Q6 if Teilnahme_W2==1 [aw=Weight_W2]
gen hhgröße_z = (VIC2_Q6-2.528177)/1.30599
sum hhgröße_z

reg hhgröße_z i.b1.lage if time_l==1 [aw=Weight_W2]
contrast gw.lage, asobserved




* Anzahl leiblicher Kinder (z-standardisiert)
sum VIC2_Q4 if Teilnahme_W2==1 [aw=Weight_W2]
gen kinder_z = (VIC2_Q4-1.182032)/1.214027
sum kinder_z

reg kinder_z i.b1.lage if time_l==1 [aw=Weight_W2]
contrast gw.lage, asobserved




* Vertrauen in ö. Institutionen (z-standardisiert)
sum trust if Teilnahme_W2==1 [aw=Weight_W2]
gen trust_z = (trust-2.642426)/0.6996868
sum trust_z

reg trust_z i.b1.lage if time_l==1 [aw=Weight_W2]
contrast gw.lage, asobserved




* Diskriminierung (z-standardisiert)
sum VICAT2_Q93 if Teilnahme_W2==1 [aw=Weight_W2]
gen diskr_z = (VICAT2_Q93-1.948431)/0.5069517
sum diskr_z

reg diskr_z i.b1.lage if time_l==1 [aw=Weight_W2]
contrast gw.lage, asobserved







// Kategoriale Variablen
tab lage VIC2_Q7 if Teilnahme_W2==1 [aw=Weight_W2], row			// Wohngebiet
tab lage VICAT2_Q10 if Teilnahme_W2==1 [aw=Weight_W2], row		// Wohnrechtsverhältnis
tab lage migration if Teilnahme_W2==1 [aw=Weight_W2], row		// Migrationshintergrund
tab lage VIC2_Q3 if Teilnahme_W2==1 [aw=Weight_W2], row			// Beziehungsstand
tab lage VIC_geschl_ges if Teilnahme_W2==1 [aw=Weight_W2], row	// Geschlecht
tab lage ISCO1 if Teilnahme_W2==1 [aw=Weight_W2], row			// ISCO


gen age = 2022 - VIC_birthyear_ges
tab age, m

mean age [aw=Weight_W2], over(lage)
mean age if Teilnahme_W2==1 [aw=Weight_W2]














// Unterteilung der ISCO-Gruppen in besser & schlechter -> Zusammenfassung?
//-------------------------------------------------------------------------

clonevar lage2 = lage

* Schlechtergestellte Techniker
replace lage2 = 81 if lage2==8 & inlist(VICAT2_Q103,1,2)
replace lage2 = 81 if lage2==8 & VICAT2_Q103==3 & inrange(hheink2,1,8)


* Schlechtergestellte Bürokräfte
replace lage2 = 91 if lage2==9 & inlist(VICAT2_Q103,1,2)
replace lage2 = 91 if lage2==9 & VICAT2_Q103==3 & inrange(hheink2,1,8)


* Schlechtergestellte Dienstleister
replace lage2 = 101 if lage2==10 & inlist(VICAT2_Q103,1,2)
replace lage2 = 101 if lage2==10 & VICAT2_Q103==3 & inrange(hheink2,1,8)


* Schlechtergestellte Arbeiter
replace lage2 = 121 if lage2==12 & inlist(VICAT2_Q103,1,2)
replace lage2 = 121 if lage2==12 & VICAT2_Q103==3 & inrange(hheink2,1,8)


tab lage2, m





// Unterschiede zwischen den höher und niedrigergestellten Gruppen

* Bildung
reg VIC2_Q15 i.b1.lage2 if Teilnahme_W2==1 [aw=Weight_W2]
margins lage2, pwcompare(group) mcompare(sidak)

* Einkommen
reg VICAT2_Q30 i.b1.lage2 if Teilnahme_W2==1 [aw=Weight_W2]
margins lage2, pwcompare(group) mcompare(sidak)

/*
Diese Trennung scheint empirisch wenig sinnvoll.
-> Verbleiben mit der Originalvariable lage
*/







// Letzte Berufe der Erwerbslosen nach Geschlecht
tab ISCO1 if lage==4 & sex==1 & time_l==1 [aw=Weight_W2]	//männlich
tab ISCO1 if lage==4 & sex==2 & time_l==1 [aw=Weight_W2]	//weiblich















save "C:\Users\b1065535\Desktop\Value in Crisis\Daten\VIC_ges5_weights.dta", replace
exit
