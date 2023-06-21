/* ##########################################################################
						Skalenvalidierung - Differential
########################################################################## */

clear all
macro drop _all
capture log close
version 16.1
set more off
numlabel, add


use "C:\Users\b1065535\Desktop\Value in Crisis\Daten\VIC_ges2.dta"





// Ausschluss von Fällen mit zu niedriger Bearbeitungszeit
//--------------------------------------------------------

/*
Erfahrungswert für Mindestbearbeitungszeit für Differntial-Skala: 
2:30 Minuten = 150 Sekunden
*/

gen time_diff = 0
recode time_diff (0=1) if LOIQ111 >149

tab time_diff, m






// Itemanalysen
sum VICAT2_Q111A1-VICAT2_Q111A14 if time_diff, detail


hist VICAT2_Q111A1 if time_diff==1		//Etwas rechtslastig
hist VICAT2_Q111A2 if time_diff==1		//Ziemlich linkslastig
hist VICAT2_Q111A3 if time_diff==1	
hist VICAT2_Q111A4 if time_diff==1
hist VICAT2_Q111A5 if time_diff==1
hist VICAT2_Q111A6 if time_diff==1
hist VICAT2_Q111A7 if time_diff==1		//Recht rechtslastig

hist VICAT2_Q111A8 if time_diff==1		//Fast gleichmäßig
hist VICAT2_Q111A9 if time_diff==1
hist VICAT2_Q111A10 if time_diff==1		//Etwas linkslastig
hist VICAT2_Q111A11 if time_diff==1
hist VICAT2_Q111A12 if time_diff==1		//Eher linkslastig
hist VICAT2_Q111A13 if time_diff==1
hist VICAT2_Q111A14 if time_diff==1

/*
Meiner Meinung nach sind alle Items für die Faktorenanalyse geeignet.
*/












// Faktorenanalyse (mind. 135 Sekunden)
//----------------

/*
Im Folgenden werden zwischen den Modellen immer die Items ausgeschlossen,
die zu niedrige Ladungen auf ihren theoretisch angemessenen Faktor bzw. zu
hohe Querladungen aufweisen.
*/

* Analyse 1
factor VICAT2_Q111A1-VICAT2_Q111A14 if time_diff==1, mineigen(1) pcf
rotate, oblique promax bl(.15)
estat kmo	// kmo=0,77

/*
Nur 383 gültige Fälle bleiben übrig.
*/




* Analyse 2
factor VICAT2_Q111A1 VICAT2_Q111A2 VICAT2_Q111A3 VICAT2_Q111A4 ///
	VICAT2_Q111A6 VICAT2_Q111A7 ///
	VICAT2_Q111A8 VICAT2_Q111A9 VICAT2_Q111A10 VICAT2_Q111A11 VICAT2_Q111A12 ///
	VICAT2_Q111A13 VICAT2_Q111A14 ///
	if time_diff==1, mineigen(1) pcf
rotate, oblique promax bl(.15)
estat kmo	// kmo=0,77






* Analyse 3
factor VICAT2_Q111A1 VICAT2_Q111A2 VICAT2_Q111A3 VICAT2_Q111A6 VICAT2_Q111A7 ///
	VICAT2_Q111A8 VICAT2_Q111A9 VICAT2_Q111A10 VICAT2_Q111A11 VICAT2_Q111A12 ///
	VICAT2_Q111A14 ///
	if time_diff==1, mineigen(1) pcf
rotate, oblique promax bl(.15)
estat kmo	// kmo=0,71


/*
3 Achsen:
	1) Ökomonische Ideologie
	2) Sozialkulturelle Ideologie
	3) Konformismus vs. Freiheit (zusätzliche Ebene)
*/

* 1) Ökonomisch (alpha = 0,66)
alpha VICAT2_Q111A1 VICAT2_Q111A3 VICAT2_Q111A6 VICAT2_Q111A7 if time_diff==1, detail item

* 2) Sozialkulturell (alpha = 0,62)
alpha VICAT2_Q111A2 VICAT2_Q111A9 VICAT2_Q111A12 VICAT2_Q111A14 if time_diff==1, detail item
// Ohne q111a2 ist die Subskala besser (alpha=0,63)


* 3) Konformismus vs. Freiheit (alpha=0,58)
alpha VICAT2_Q111A8 VICAT2_Q111A10 VICAT2_Q111A11 if time_diff==1, detail item







* Analyse 4
factor VICAT2_Q111A3 VICAT2_Q111A6 VICAT2_Q111A7 ///
	VICAT2_Q111A9 VICAT2_Q111A12 VICAT2_Q111A14 ///
	VICAT2_Q111A8 VICAT2_Q111A10 VICAT2_Q111A11 ///
	if time_diff==1, mineigen(1) pcf
rotate, oblique promax bl(.15)
estat kmo	// kmo=0,69


* 1) Ökonomisch (alpha = 0,64)
alpha VICAT2_Q111A3 VICAT2_Q111A6 VICAT2_Q111A7 if time_diff==1, detail item

* 2) Sozialkulturell (alpha = 0,63)
alpha VICAT2_Q111A9 VICAT2_Q111A12 VICAT2_Q111A14 if time_diff==1, detail item

* 3) Konformismus vs. Freiheit (alpha=0,58)
alpha VICAT2_Q111A8 VICAT2_Q111A10 VICAT2_Q111A11 if time_diff==1, detail item








// Alternativ-Lösung
factor VICAT2_Q111A1 VICAT2_Q111A3 VICAT2_Q111A6 VICAT2_Q111A7 ///
	VICAT2_Q111A9 VICAT2_Q111A12 VICAT2_Q111A14 ///
	VICAT2_Q111A8 VICAT2_Q111A10 VICAT2_Q111A11 ///
	if time_diff==1, mineigen(1) pcf
rotate, oblique promax bl(.15)
estat kmo	// kmo=0,71

* 1) Ökonomisch (alpha = 0,66)
alpha VICAT2_Q111A1 VICAT2_Q111A3 VICAT2_Q111A6 VICAT2_Q111A7 if time_diff==1, detail item

* 2) Sozialkulturell (alpha = 0,63)
alpha VICAT2_Q111A9 VICAT2_Q111A12 VICAT2_Q111A14 if time_diff==1, detail item

* 3) Konformismus vs. Freiheit (alpha=0,58)
alpha VICAT2_Q111A8 VICAT2_Q111A10 VICAT2_Q111A11 if time_diff==1, detail item













/* #############################################################################
					Konstruktvalidierungen - Differential
############################################################################# */


// Berechnung der Ideologie-Scores


* Ökonomische Ideologie
gen oekIdeo = (VICAT2_Q111A1 + VICAT2_Q111A3 + VICAT2_Q111A6 + VICAT2_Q111A7) / 4

lab var oekIdeo "Ökonomische Ideologie (Libertär <-> Marxistisch)"
lab define oekIdeo 1 "[1] Libertär" 5 "[5] Marxistisch"
lab values oekIdeo oekIdeo

replace oekIdeo = . if time_diff!=1
tab oekIdeo



* Sozialkulturelle Ideologie
gen sozIdeo = (VICAT2_Q111A9 + VICAT2_Q111A12 + VICAT2_Q111A14) / 3

lab var sozIdeo "Soziale Ideologie (Liberal <-> Konservativ)"
lab define sozIdeo 1 "[1] Liberal" 5 "[5] Konservativ"
lab values sozIdeo sozIdeo

replace sozIdeo = . if time_diff!=1
tab sozIdeo



* Freiheit vs. Konformismus
gen freedom = (VICAT2_Q111A8 + VICAT2_Q111A10 + VICAT2_Q111A11) / 3

lab var freedom "Freiheits-Ideologie (Freiheit <-> Konformismus)"
lab define freedom 1 "[1] Freiheit" 5 "[5] Konformismus"
lab values freedom freedom

replace freedom = . if time_diff!=1
tab freedom





* Korrelationen zwischen den Ideologie-Achsen
pwcorr oekIdeo sozIdeo freedom if time_diff==1, sig obs




* Mittelwerte der Ideologie-Achsen
mean oekIdeo sozIdeo freedom if time_diff==1





* Parteipräferenz
mean oekIdeo sozIdeo freedom if VICAT2_Q114==1		// ÖVP
mean oekIdeo sozIdeo freedom if VICAT2_Q114==2		// SPÖ
mean oekIdeo sozIdeo freedom if VICAT2_Q114==3		// FPÖ
mean oekIdeo sozIdeo freedom if VICAT2_Q114==4		// NEOS
mean oekIdeo sozIdeo freedom if VICAT2_Q114==5		// GRÜNE
mean oekIdeo sozIdeo freedom if VICAT2_Q114==9		// Nichtwähler





* Konstruktvalidierungen
pwcorr oekIdeo sozIdeo freedom VIC2_Q15, sig obs
pwcorr oekIdeo sozIdeo freedom VICAT2_Q30, sig obs
pwcorr oekIdeo sozIdeo freedom VIC2_Q109, sig obs
pwcorr oekIdeo sozIdeo freedom sexism, sig obs
pwcorr oekIdeo sozIdeo freedom VIC2_Q85A1 VIC2_Q85A2 VIC2_Q85A3, sig obs
 



/*
Die Fallzahlen sind zu niedrig, um später sinnvolle Vergleiche zwischen
sozialen Lagen zu ziehen.

Deswegen wird diese Differential-Version ab diesem Punkt nicht weiter verfolgt.
*/











save "C:\Users\b1065535\Desktop\Value in Crisis\Daten\VIC_ges3.dta", replace
exit

