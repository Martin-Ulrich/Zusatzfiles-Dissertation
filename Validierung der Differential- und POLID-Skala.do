/* ########################################################################
	Validierung der Differential- und Likert-Version im VIC2-Datensatz
	
	Dieses Do-File greift auf Syntax von Ulrich (2021b) zurück (doi: 10.7802/2332).
	
	Datenquelle: Aschauer, Wolfgang / Seymer, Alexander / Ulrich, Martin / 
		Kreuzberger, Markus / Höllinger, Franz / Eder, Anja / Hadler, Max / 
		Bacher, Johann / Prandner, Dimitri (2021): Values in Crisis Austria – 
		Wave 1 and Wave 2 combined (SUF edition), AUSSDA. https://doi.org/10.11587/6YQASY
	
#########################################################################*/


* STATA-Version
version 16.1


clear all
macro drop _all
capture log close
set more off
numlabel, add



* Daten aufrufen
use "C:\Users\b1065535\Desktop\Value in Crisis\Daten\VIC_W1_W2.dta", clear




// Aufteilung der Befragten auf die beiden Skala-Versionen
tab Teilnahme_W2 VICAT2_Q111A1, m







// Differential-Version
//---------------------

/*
Die Items zur Ideologie-Skala befinden sich in Variablenblock Q112 (VICAT2_Q111A1 bis VICAT2_Q111A14).
*/


/*
Erfahrungswert für Mindestbearbeitungszeit für Differntial-Skala: 
2:30 Minuten = 150 Sekunden
*/

gen time_diff = 0
recode time_diff (0=1) if LOIQ111 >149

tab time_diff, m

tab VICAT2_Q111A1 if time_diff==1, m






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


















// Likert-Version
//---------------




/*
Die Items zur Ideologie-Skala befinden sich in Variablenblock Q112 (VICAT2_Q112A1 bis VICAT2_Q112A28).
*/





// Bearbeitungszeit für die Ideologie-Skala
//-----------------------------------------

/*
Erfahrungswert für Mindestbearbeitungszeit für Likert-Skala (28 Items): 
2:15 Minuten = 135 Sekunden
*/

gen time_l = 0
recode time_l (0=1) if LOIQ112>134
recode time_l (0=.) (1=.) if VICAT2_Q112A1==.	
/*
Die Befragten waren gezwungen, etwas anzugeben.
-> Missings auf der Likert-Skala kommen nur dann zustande, wenn sie die
Skala nicht erhalten haben.
*/

tab time_l, m





// Durchschnittliche Bearbeitungszeit (28 Items)

mean LOIQ112 if time_l==1	//369,0834 Sekunden
/*
369,0834 / 28 = 13,1815 Sekunden pr Item

-> 16 Items brauchen also geschätzt 210,904 Sekunden.
-> Geschätzte mittlere Bearbeitungszeit: 3,5 Minuten
*/










// Explorative Faktorenanalyse (mit allen 767 Fällen)
//---------------------------------------------------

factor VICAT2_Q112A1 VICAT2_Q112A2 VICAT2_Q112A3 VICAT2_Q112A6  ///
	VICAT2_Q112A9 VICAT2_Q112A11 VICAT2_Q112A12 VICAT2_Q112A14 ///
	VICAT2_Q112A17 VICAT2_Q112A18 VICAT2_Q112A19 VICAT2_Q112A20 ///
	VICAT2_Q112A22 VICAT2_Q112A23 VICAT2_Q112A24 VICAT2_Q112A25 ///
	if time_l==1, pcf mineigen(1)
	
* Promax Rotation (Tabelle 3)
rotate, oblique promax bl(.15)
estat kmo

* Faktorwerte berechnen
predict pc1 pc2 pc3 pc4

* Hauptkomponentenkorrelationsmatrix
correlate pc1 pc2 pc3 pc4 if time_l==1






// Cronbach's Alpha
//-----------------

* alle 767 Fälle
alpha VICAT2_Q112A1 VICAT2_Q112A2 VICAT2_Q112A3 VICAT2_Q112A6 if time_l==1
alpha VICAT2_Q112A9 VICAT2_Q112A11 VICAT2_Q112A12 VICAT2_Q112A14 if time_l==1
alpha VICAT2_Q112A17 VICAT2_Q112A18 VICAT2_Q112A19 VICAT2_Q112A20 if time_l==1
alpha VICAT2_Q112A22 VICAT2_Q112A23 VICAT2_Q112A24 VICAT2_Q112A25 if time_l==1











// Konfirmatorische Faktorenanalyse
//---------------------------------


* CFA
sem (NEO -> VICAT2_Q112A1, ) (NEO -> VICAT2_Q112A2, ) ///
	(NEO -> VICAT2_Q112A3, ) (NEO -> VICAT2_Q112A6, ) ///
	(KON -> VICAT2_Q112A9, ) (KON -> VICAT2_Q112A11, ) ///
	(KON -> VICAT2_Q112A12, ) (KON -> VICAT2_Q112A14, ) ///
	(SOZ -> VICAT2_Q112A17, ) (SOZ -> VICAT2_Q112A18, ) ///
	(SOZ -> VICAT2_Q112A19, ) (SOZ -> VICAT2_Q112A20, ) ///
	(LIB -> VICAT2_Q112A22, ) (LIB -> VICAT2_Q112A23, ) ///
	(LIB -> VICAT2_Q112A24, ) (LIB -> VICAT2_Q112A25, ) ///
	if time_l==1, ///
	covstruct(_lexogenous, diagonal) standardized latent(NEO KON SOZ LIB ) ///
	cov( NEO@1 NEO*KON NEO*SOZ KON@1 SOZ@1 SOZ*KON LIB@1 LIB*NEO LIB*KON LIB*SOZ) ///
	means( NEO@0 KON@0 SOZ@0 LIB@0) nocapslatent


estat gof, stats(all)
estat mindices

/*
Kennwerte ohne Kovarianzen zwischen den Fehlertermen:
- RMSEA: 0,044
- CFI: 0,939
- TLI: 0,926
- SRMR: 0,044
- CD: 0,991
*/









// CFA mit Kovarianzen zwischen Fehlertermen
//------------------------------------------

sem (NEO -> VICAT2_Q112A1, ) (NEO -> VICAT2_Q112A2, ) ///
	(NEO -> VICAT2_Q112A3, ) (NEO -> VICAT2_Q112A6, ) ///
	(KON -> VICAT2_Q112A9, ) (KON -> VICAT2_Q112A11, ) ///
	(KON -> VICAT2_Q112A12, ) (KON -> VICAT2_Q112A14, ) ///
	(SOZ -> VICAT2_Q112A17, ) (SOZ -> VICAT2_Q112A18, ) ///
	(SOZ -> VICAT2_Q112A19, ) (SOZ -> VICAT2_Q112A20, ) ///
	(LIB -> VICAT2_Q112A22, ) (LIB -> VICAT2_Q112A23, ) ///
	(LIB -> VICAT2_Q112A24, ) (LIB -> VICAT2_Q112A25, ) ///
	if time_l==1, ///
	covstruct(_lexogenous, diagonal) standardized latent(NEO KON SOZ LIB ) ///
	cov( NEO@1 NEO*KON NEO*SOZ KON@1 SOZ@1 SOZ*KON LIB@1 LIB*NEO LIB*KON LIB*SOZ ///
	e.VICAT2_Q112A22*e.VICAT2_Q112A25) ///
	means( NEO@0 KON@0 SOZ@0 LIB@0) nocapslatent


estat gof, stats(all)

/*
Kennwerte ohne Kovarianzen zwischen den Fehlertermen:
- RMSEA: 0,043
- CFI: 0,944
- TLI: 0,931
- SRMR: 0,043
- CD: 0,989
*/













// Testen der Messinvarianz
//-------------------------

// Konfigurale Messinvarinaz

* Geschlecht
sem (NEO -> VICAT2_Q112A1, ) (NEO -> VICAT2_Q112A2, ) ///
	(NEO -> VICAT2_Q112A3, ) (NEO -> VICAT2_Q112A6, ) ///
	(KON -> VICAT2_Q112A9, ) (KON -> VICAT2_Q112A11, ) ///
	(KON -> VICAT2_Q112A12, ) (KON -> VICAT2_Q112A14, ) ///
	(SOZ -> VICAT2_Q112A17, ) (SOZ -> VICAT2_Q112A18, ) ///
	(SOZ -> VICAT2_Q112A19, ) (SOZ -> VICAT2_Q112A20, ) ///
	(LIB -> VICAT2_Q112A22, ) (LIB -> VICAT2_Q112A23, ) ///
	(LIB -> VICAT2_Q112A24, ) (LIB -> VICAT2_Q112A25, ) ///
	if time_l==1 & VIC_geschl_ges!=3, group(VIC_geschl_ges) gin(none)  ///
	covstruct(_lexogenous, diagonal) standardized ///
	latent(NEO KON SOZ LIB ) ///
	cov( NEO@1 NEO*KON NEO*LIB KON@1 SOZ@1 SOZ*NEO SOZ*KON SOZ*LIB ///
	LIB@1 LIB*KON e.VICAT2_Q112A22*e.VICAT2_Q112A25) ///
	means( NEO@0 KON@0 SOZ@0 LIB@0) nocapslatent

estat gof, stats(all)




* Alter
gen age = 2021 - VIC_birthyear_ges

gen age2 = .
replace age2 = 1 if time_l==1 & inrange(age,15,49)
replace age2 = 2 if time_l==1 & inrange(age,50,99)
tab age age2, m


sem (NEO -> VICAT2_Q112A1, ) (NEO -> VICAT2_Q112A2, ) ///
	(NEO -> VICAT2_Q112A3, ) (NEO -> VICAT2_Q112A6, ) ///
	(KON -> VICAT2_Q112A9, ) (KON -> VICAT2_Q112A11, ) ///
	(KON -> VICAT2_Q112A12, ) (KON -> VICAT2_Q112A14, ) ///
	(SOZ -> VICAT2_Q112A17, ) (SOZ -> VICAT2_Q112A18, ) ///
	(SOZ -> VICAT2_Q112A19, ) (SOZ -> VICAT2_Q112A20, ) ///
	(LIB -> VICAT2_Q112A22, ) (LIB -> VICAT2_Q112A23, ) ///
	(LIB -> VICAT2_Q112A24, ) (LIB -> VICAT2_Q112A25, ) ///
	if time_l==1, group(age2) gin(none)  ///
	covstruct(_lexogenous, diagonal) standardized ///
	latent(NEO KON SOZ LIB ) ///
	cov( NEO@1 NEO*KON NEO*LIB KON@1 SOZ@1 SOZ*NEO SOZ*KON SOZ*LIB ///
	LIB@1 LIB*KON e.VICAT2_Q112A22*e.VICAT2_Q112A25) ///
	means( NEO@0 KON@0 SOZ@0 LIB@0) nocapslatent

estat gof, stats(all)









* Bildung
tab VIC2_Q15		// wird in "unter AHS" und "AHS oder höher" aufgeteilt

gen edu = 0
replace edu = 1 if inrange(VIC2_Q15,1,4)
replace edu = 2 if inrange(VIC2_Q15,5,13)
tab edu VIC2_Q15, m


sem (NEO -> VICAT2_Q112A1, ) (NEO -> VICAT2_Q112A2, ) ///
	(NEO -> VICAT2_Q112A3, ) (NEO -> VICAT2_Q112A6, ) ///
	(KON -> VICAT2_Q112A9, ) (KON -> VICAT2_Q112A11, ) ///
	(KON -> VICAT2_Q112A12, ) (KON -> VICAT2_Q112A14, ) ///
	(SOZ -> VICAT2_Q112A17, ) (SOZ -> VICAT2_Q112A18, ) ///
	(SOZ -> VICAT2_Q112A19, ) (SOZ -> VICAT2_Q112A20, ) ///
	(LIB -> VICAT2_Q112A22, ) (LIB -> VICAT2_Q112A23, ) ///
	(LIB -> VICAT2_Q112A24, ) (LIB -> VICAT2_Q112A25, ) ///
	if time_l==1, group(edu) gin(none)  ///
	covstruct(_lexogenous, diagonal) standardized ///
	latent(NEO KON SOZ LIB ) ///
	cov( NEO@1 NEO*KON NEO*LIB KON@1 SOZ@1 SOZ*NEO SOZ*KON SOZ*LIB ///
	LIB@1 LIB*KON e.VICAT2_Q112A22*e.VICAT2_Q112A25) ///
	means( NEO@0 KON@0 SOZ@0 LIB@0) nocapslatent

estat gof, stats(all)













// Metrische Messinvarinaz

* Geschlecht
sem (NEO -> VICAT2_Q112A1, ) (NEO -> VICAT2_Q112A2, ) ///
	(NEO -> VICAT2_Q112A3, ) (NEO -> VICAT2_Q112A6, ) ///
	(KON -> VICAT2_Q112A9, ) (KON -> VICAT2_Q112A11, ) ///
	(KON -> VICAT2_Q112A12, ) (KON -> VICAT2_Q112A14, ) ///
	(SOZ -> VICAT2_Q112A17, ) (SOZ -> VICAT2_Q112A18, ) ///
	(SOZ -> VICAT2_Q112A19, ) (SOZ -> VICAT2_Q112A20, ) ///
	(LIB -> VICAT2_Q112A22, ) (LIB -> VICAT2_Q112A23, ) ///
	(LIB -> VICAT2_Q112A24, ) (LIB -> VICAT2_Q112A25, ) ///
	if time_l==1 & VIC_geschl_ges!=3, group(VIC_geschl_ges) gin(mcoef)  ///
	covstruct(_lexogenous, diagonal) standardized ///
	latent(NEO KON SOZ LIB ) ///
	cov( NEO@1 NEO*KON NEO*LIB KON@1 SOZ@1 SOZ*NEO SOZ*KON SOZ*LIB ///
	LIB@1 LIB*KON e.VICAT2_Q112A22*e.VICAT2_Q112A25) ///
	means( NEO@0 KON@0 SOZ@0 LIB@0) nocapslatent

estat gof, stats(all)












* Alter
sem (NEO -> VICAT2_Q112A1, ) (NEO -> VICAT2_Q112A2, ) ///
	(NEO -> VICAT2_Q112A3, ) (NEO -> VICAT2_Q112A6, ) ///
	(KON -> VICAT2_Q112A9, ) (KON -> VICAT2_Q112A11, ) ///
	(KON -> VICAT2_Q112A12, ) (KON -> VICAT2_Q112A14, ) ///
	(SOZ -> VICAT2_Q112A17, ) (SOZ -> VICAT2_Q112A18, ) ///
	(SOZ -> VICAT2_Q112A19, ) (SOZ -> VICAT2_Q112A20, ) ///
	(LIB -> VICAT2_Q112A22, ) (LIB -> VICAT2_Q112A23, ) ///
	(LIB -> VICAT2_Q112A24, ) (LIB -> VICAT2_Q112A25, ) ///
	if time_l==1, group(age2) gin(mcoef)  ///
	covstruct(_lexogenous, diagonal) standardized ///
	latent(NEO KON SOZ LIB ) ///
	cov( NEO@1 NEO*KON NEO*LIB KON@1 SOZ@1 SOZ*NEO SOZ*KON SOZ*LIB ///
	LIB@1 LIB*KON e.VICAT2_Q112A22*e.VICAT2_Q112A25) ///
	means( NEO@0 KON@0 SOZ@0 LIB@0) nocapslatent

estat gof, stats(all)










* Bildung
sem (NEO -> VICAT2_Q112A1, ) (NEO -> VICAT2_Q112A2, ) ///
	(NEO -> VICAT2_Q112A3, ) (NEO -> VICAT2_Q112A6, ) ///
	(KON -> VICAT2_Q112A9, ) (KON -> VICAT2_Q112A11, ) ///
	(KON -> VICAT2_Q112A12, ) (KON -> VICAT2_Q112A14, ) ///
	(SOZ -> VICAT2_Q112A17, ) (SOZ -> VICAT2_Q112A18, ) ///
	(SOZ -> VICAT2_Q112A19, ) (SOZ -> VICAT2_Q112A20, ) ///
	(LIB -> VICAT2_Q112A22, ) (LIB -> VICAT2_Q112A23, ) ///
	(LIB -> VICAT2_Q112A24, ) (LIB -> VICAT2_Q112A25, ) ///
	if time_l==1, group(edu) gin(mcoef)  ///
	covstruct(_lexogenous, diagonal) standardized ///
	latent(NEO KON SOZ LIB ) ///
	cov( NEO@1 NEO*KON NEO*LIB KON@1 SOZ@1 SOZ*NEO SOZ*KON SOZ*LIB ///
	LIB@1 LIB*KON e.VICAT2_Q112A22*e.VICAT2_Q112A25) ///
	means( NEO@0 KON@0 SOZ@0 LIB@0) nocapslatent

estat gof, stats(all)
















// Skalare Messinvarinaz

* Geschlecht
sem (NEO -> VICAT2_Q112A1, ) (NEO -> VICAT2_Q112A2, ) ///
	(NEO -> VICAT2_Q112A3, ) (NEO -> VICAT2_Q112A6, ) ///
	(KON -> VICAT2_Q112A9, ) (KON -> VICAT2_Q112A11, ) ///
	(KON -> VICAT2_Q112A12, ) (KON -> VICAT2_Q112A14, ) ///
	(SOZ -> VICAT2_Q112A17, ) (SOZ -> VICAT2_Q112A18, ) ///
	(SOZ -> VICAT2_Q112A19, ) (SOZ -> VICAT2_Q112A20, ) ///
	(LIB -> VICAT2_Q112A22, ) (LIB -> VICAT2_Q112A23, ) ///
	(LIB -> VICAT2_Q112A24, ) (LIB -> VICAT2_Q112A25, ) ///
	if time_l==1 & VIC_geschl_ges!=3, group(VIC_geschl_ges) gin(mcoef mcons)  ///
	covstruct(_lexogenous, diagonal) standardized ///
	latent(NEO KON SOZ LIB ) ///
	cov( NEO@1 NEO*KON NEO*LIB KON@1 SOZ@1 SOZ*NEO SOZ*KON SOZ*LIB ///
	LIB@1 LIB*KON e.VICAT2_Q112A22*e.VICAT2_Q112A25) ///
	means( NEO@0 KON@0 SOZ@0 LIB@0) nocapslatent

estat gof, stats(all)











* Alter
sem (NEO -> VICAT2_Q112A1, ) (NEO -> VICAT2_Q112A2, ) ///
	(NEO -> VICAT2_Q112A3, ) (NEO -> VICAT2_Q112A6, ) ///
	(KON -> VICAT2_Q112A9, ) (KON -> VICAT2_Q112A11, ) ///
	(KON -> VICAT2_Q112A12, ) (KON -> VICAT2_Q112A14, ) ///
	(SOZ -> VICAT2_Q112A17, ) (SOZ -> VICAT2_Q112A18, ) ///
	(SOZ -> VICAT2_Q112A19, ) (SOZ -> VICAT2_Q112A20, ) ///
	(LIB -> VICAT2_Q112A22, ) (LIB -> VICAT2_Q112A23, ) ///
	(LIB -> VICAT2_Q112A24, ) (LIB -> VICAT2_Q112A25, ) ///
	if time_l==1, group(age2) gin(mcoef mcons)  ///
	covstruct(_lexogenous, diagonal) standardized ///
	latent(NEO KON SOZ LIB ) ///
	cov( NEO@1 NEO*KON NEO*LIB KON@1 SOZ@1 SOZ*NEO SOZ*KON SOZ*LIB ///
	LIB@1 LIB*KON e.VICAT2_Q112A22*e.VICAT2_Q112A25) ///
	means( NEO@0 KON@0 SOZ@0 LIB@0) nocapslatent

estat gof, stats(all)








* Bildung
sem (NEO -> VICAT2_Q112A1, ) (NEO -> VICAT2_Q112A2, ) ///
	(NEO -> VICAT2_Q112A3, ) (NEO -> VICAT2_Q112A6, ) ///
	(KON -> VICAT2_Q112A9, ) (KON -> VICAT2_Q112A11, ) ///
	(KON -> VICAT2_Q112A12, ) (KON -> VICAT2_Q112A14, ) ///
	(SOZ -> VICAT2_Q112A17, ) (SOZ -> VICAT2_Q112A18, ) ///
	(SOZ -> VICAT2_Q112A19, ) (SOZ -> VICAT2_Q112A20, ) ///
	(LIB -> VICAT2_Q112A22, ) (LIB -> VICAT2_Q112A23, ) ///
	(LIB -> VICAT2_Q112A24, ) (LIB -> VICAT2_Q112A25, ) ///
	if time_l==1, group(edu) gin(mcoef mcons)  ///
	covstruct(_lexogenous, diagonal) standardized ///
	latent(NEO KON SOZ LIB ) ///
	cov( NEO@1 NEO*KON NEO*LIB KON@1 SOZ@1 SOZ*NEO SOZ*KON SOZ*LIB ///
	LIB@1 LIB*KON e.VICAT2_Q112A22*e.VICAT2_Q112A25) ///
	means( NEO@0 KON@0 SOZ@0 LIB@0) nocapslatent

estat gof, stats(all)


















// Berechnung und Verteilung der Ideologie-Scores
//-----------------------------------------------
gen ideo_d = (VICAT2_Q112A1 + VICAT2_Q112A2 + VICAT2_Q112A3 + VICAT2_Q112A6 ///
	+ VICAT2_Q112A9 + VICAT2_Q112A11 + VICAT2_Q112A12 + VICAT2_Q112A14 ///
	+ VICAT2_Q112A17 + VICAT2_Q112A18 + VICAT2_Q112A19 + VICAT2_Q112A20 ///
	+ VICAT2_Q112A22 + VICAT2_Q112A23 + VICAT2_Q112A24 + VICAT2_Q112A25) / 16
tab ideo_d, m

	
gen neo = ((VICAT2_Q112A1 + VICAT2_Q112A2 + VICAT2_Q112A3 + VICAT2_Q112A6) / 4) - ideo_d
lab var neo "Libertarismus-Score (zentrierter Mittelwert)"
tab neo, m


gen kon = ((VICAT2_Q112A9 + VICAT2_Q112A11 + VICAT2_Q112A12 + VICAT2_Q112A14) / 4) - ideo_d
lab var kon "Konservativismus-Score (zentrierter Mittelwert)"
tab kon, m


gen soz = ((VICAT2_Q112A17 + VICAT2_Q112A18 + VICAT2_Q112A19 + VICAT2_Q112A20) / 4) - ideo_d
lab var soz "Marxismus-Score (zentrierter Mittelwert)"
tab soz, m


gen lib = ((VICAT2_Q112A22 + VICAT2_Q112A23 + VICAT2_Q112A24 + VICAT2_Q112A25) / 4) - ideo_d
lab var lib "Liberalismus-Score (zentrierter Mittelwert)"
tab lib, m


// Verteilung der Ideologie-Scores
sum neo kon soz lib if time_l==1, detail
sum neo kon soz lib if time_l==1

// Korrelation der Ideologie-Scores
pwcorr neo kon soz lib, obs sig









* Restliche Itemkennwerte (M, SD, Kurtosis, etc.)
foreach var in VICAT2_Q112A1 VICAT2_Q112A2 VICAT2_Q112A3 VICAT2_Q112A6 ///
	VICAT2_Q112A9 VICAT2_Q112A11 VICAT2_Q112A12 VICAT2_Q112A14 ///
	VICAT2_Q112A17 VICAT2_Q112A18 VICAT2_Q112A19 VICAT2_Q112A20 ///
	VICAT2_Q112A22 VICAT2_Q112A23 VICAT2_Q112A24 VICAT2_Q112A25 {
		sum `var' if time_l==1, detail
}


















// Konstruktvalidierungen
//-----------------------

* Links-Rechts-Platzierung
pwcorr VIC2_Q109 neo kon soz lib if time_l==1, sig obs		//N=767


* Sexismus
recode VIC2_Q86A1 VIC2_Q86A2 VIC2_Q86A3 (1=4) (2=3) (3=2) (4=1)
gen sexism = (VIC2_Q86A1 + VIC2_Q86A2 + VIC2_Q86A3)/3
lab var sexism "Sexism-Score (Q86 - Mittelwert)"
tab sexism, m

pwcorr sexism neo kon soz lib if time_l==1, sig			//N=767


/* Rechtfertigung von Verhaltensweisen
Q85A1: Homosexualität
Q85A2: Abtreibung
Q85A3: Scheidung
*/
pwcorr VIC2_Q85A1 VIC2_Q85A2 VIC2_Q85A3 neo kon soz lib if time_l==1, sig		//N=767







// Korrelation mit den Schwartz-Werten
//------------------------------------

* übergeordnet
pwcorr VIC2_selfenhancement_c neo kon soz lib if time_l==1, sig
pwcorr VIC2_selftranscendence_c neo kon soz lib if time_l==1, sig
pwcorr VIC2_openness_c neo kon soz lib if time_l==1, sig
pwcorr VIC2_conservation_c neo kon soz lib if time_l==1, sig

* einzelne Werte
pwcorr VIC2_Csec VIC2_Ccon VIC2_Ctra VIC2_Cben VIC2_Cuni VIC2_Cself ///
	VIC2_Csti VIC2_Ched VIC2_Cach VIC2_Cpow neo kon soz lib if time_l==1, sig

	








// Korrelationen der Ideologie-Scores untereinander
pwcorr neo kon soz lib if time_l==1, sig		//N=767





// POLID-Scores nach Partei

tab VICAT2_Q114, m
recode VICAT2_Q114 (1=1) (2=2) (3=3) (4=4) (5=5) ///
	(6=6) (7=6) ///
	(8=7) (9=7) , gen(partei)

tab VICAT2_Q114 partei, m




// Abweichung vom Sampledurchschnitt

* Gewichtung der Daten
svyset Weight_W2 [pweight=Weight_W2]


svy: reg neo i.b1.partei if time_l==1
contrast gw.partei, asobserved

svy: reg kon i.b1.partei if time_l==1
contrast gw.partei, asobserved

svy: reg soz i.b1.partei if time_l==1
contrast gw.partei, asobserved

svy: reg lib i.b1.partei if time_l==1
contrast gw.partei, asobserved




















save "C:\Users\b1065535\Desktop\Value in Crisis\Daten\VIC_W1_W2_new.dta", replace
exit


