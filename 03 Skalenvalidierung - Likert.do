/* ########################################################################
						Skalenvalidierung - Likert
#########################################################################*/

clear all
macro drop _all
capture log close
version 16.1
set more off
numlabel, add


use "C:\Users\b1065535\Desktop\Value in Crisis\Daten\VIC_ges3.dta"



/*
In diesem Do-File werden einige Code-Zeilen aus dem Sytax-File von Ulrich (2021b)
übernommen.
doi: 10.7802/2332
*/







// Ausschluss von Fällen mit zu niedriger Bearbeitungszeit
//--------------------------------------------------------

/*
Erfahrungswert für Mindestbearbeitungszeit für Likert-Skala (alle 28 Items): 
2:15 Minuten = 135 Sekunden
*/

gen time_l = 0
recode time_l (0=1) if LOIQ112>134
recode time_l (0=.) (1=.) if VICAT2_Q112A1==.	

tab time_l, m






// Itemanalysen
sum VICAT2_Q112A1-VICAT2_Q112A28 if time_l==1, detail

hist VICAT2_Q112A1 if time_l==1
hist VICAT2_Q112A1 if time_l==1
hist VICAT2_Q112A1 if time_l==1
hist VICAT2_Q112A1 if time_l==1
hist VICAT2_Q112A1 if time_l==1	//ziemlich rechtssteil
hist VICAT2_Q112A1 if time_l==1
hist VICAT2_Q112A1 if time_l==1

hist VICAT2_Q112A1 if time_l==1	//relativ rechtssteil
hist VICAT2_Q112A1 if time_l==1
hist VICAT2_Q112A1 if time_l==1	//relativ rechtssteil
hist VICAT2_Q112A1 if time_l==1
hist VICAT2_Q112A1 if time_l==1
hist VICAT2_Q112A1 if time_l==1
hist VICAT2_Q112A1 if time_l==1

hist VICAT2_Q112A1 if time_l==1
hist VICAT2_Q112A1 if time_l==1
hist VICAT2_Q112A1 if time_l==1
hist VICAT2_Q112A1 if time_l==1	//ziemlich rechtssteil
hist VICAT2_Q112A1 if time_l==1	//etwas rechtssteil
hist VICAT2_Q112A1 if time_l==1
hist VICAT2_Q112A1 if time_l==1

hist VICAT2_Q112A1 if time_l==1	//stark rechtssteil
hist VICAT2_Q112A1 if time_l==1	//same
hist VICAT2_Q112A1 if time_l==1
hist VICAT2_Q112A1 if time_l==1	//stark rechtssteil
hist VICAT2_Q112A1 if time_l==1	//ziemlich rechtssteil
hist VICAT2_Q112A1 if time_l==1
hist VICAT2_Q112A1 if time_l==1	//ziemlich rechtssteil


pwcorr VICAT2_Q112A1-VICAT2_Q112A28 if time_l==1, sig obs


// Itemschwierigkeiten
/*
Da die Bearbeitung dieses Items für die Befragten verpflichtend war und es keine Ausweichoption gab, liegen 3*767 = 2301 maximal erreichbare Punkte für jedes Item vor.
*/
recode VICAT2_Q112A1 (1=0) (2=1) (3=2) (4=3), gen(VICAT2_Q112A1_x)
tab VICAT2_Q112A1_x if time_l==1	//3*767 = 2301


foreach var in VICAT2_Q112A2 VICAT2_Q112A3 VICAT2_Q112A4 VICAT2_Q112A5 VICAT2_Q112A6 VICAT2_Q112A7 VICAT2_Q112A8 VICAT2_Q112A9 VICAT2_Q112A10 VICAT2_Q112A11 VICAT2_Q112A12 VICAT2_Q112A13 VICAT2_Q112A14 VICAT2_Q112A15 VICAT2_Q112A16 VICAT2_Q112A17 VICAT2_Q112A18 VICAT2_Q112A19 VICAT2_Q112A20 VICAT2_Q112A21 VICAT2_Q112A22 VICAT2_Q112A23 VICAT2_Q112A24 VICAT2_Q112A25 VICAT2_Q112A26 VICAT2_Q112A27 VICAT2_Q112A28 {
    recode `var' (1=0) (2=1) (3=2) (4=3), gen(`var'_x)
}


// Erreicher Wert (Summe über alle Befragten hinweg)
egen likert01 = sum(VICAT2_Q112A1_x) if time_l==1
egen likert02 = sum(VICAT2_Q112A2_x) if time_l==1
egen likert03 = sum(VICAT2_Q112A3_x) if time_l==1
egen likert04 = sum(VICAT2_Q112A4_x) if time_l==1
egen likert05 = sum(VICAT2_Q112A5_x) if time_l==1
egen likert06 = sum(VICAT2_Q112A6_x) if time_l==1
egen likert07 = sum(VICAT2_Q112A7_x) if time_l==1
egen likert08 = sum(VICAT2_Q112A8_x) if time_l==1
egen likert09 = sum(VICAT2_Q112A9_x) if time_l==1
egen likert10 = sum(VICAT2_Q112A10_x) if time_l==1
egen likert11 = sum(VICAT2_Q112A11_x) if time_l==1
egen likert12 = sum(VICAT2_Q112A12_x) if time_l==1
egen likert13 = sum(VICAT2_Q112A13_x) if time_l==1
egen likert14 = sum(VICAT2_Q112A14_x) if time_l==1
egen likert15 = sum(VICAT2_Q112A15_x) if time_l==1
egen likert16 = sum(VICAT2_Q112A16_x) if time_l==1
egen likert17 = sum(VICAT2_Q112A17_x) if time_l==1
egen likert18 = sum(VICAT2_Q112A18_x) if time_l==1
egen likert19 = sum(VICAT2_Q112A19_x) if time_l==1
egen likert20 = sum(VICAT2_Q112A20_x) if time_l==1
egen likert21 = sum(VICAT2_Q112A21_x) if time_l==1
egen likert22 = sum(VICAT2_Q112A22_x) if time_l==1
egen likert23 = sum(VICAT2_Q112A23_x) if time_l==1
egen likert24 = sum(VICAT2_Q112A24_x) if time_l==1
egen likert25 = sum(VICAT2_Q112A25_x) if time_l==1
egen likert26 = sum(VICAT2_Q112A26_x) if time_l==1
egen likert27 = sum(VICAT2_Q112A27_x) if time_l==1
egen likert28 = sum(VICAT2_Q112A28_x) if time_l==1










// Faktorenanalyse (EFAs)
//-----------------------

/*
Schrittweiser Ausschluss von Items mit zu niedrigen Faktorladungen bzw. zu
hohen Querladungen
*/


* Analyse 1
factor VICAT2_Q112A1-VICAT2_Q112A28 if time_l==1, mineigen(1) pcf
rotate, oblique promax bl(.15)
estat kmo	// kmo=0,85


* Analyse 2
factor VICAT2_Q112A1 VICAT2_Q112A2 VICAT2_Q112A3 VICAT2_Q112A4 ///
	VICAT2_Q112A5 VICAT2_Q112A6 ///
	VICAT2_Q112A8 VICAT2_Q112A9 VICAT2_Q112A10 VICAT2_Q112A11 ///
	VICAT2_Q112A12 VICAT2_Q112A14 ///
	VICAT2_Q112A15 VICAT2_Q112A16 VICAT2_Q112A17 VICAT2_Q112A18 ///
	VICAT2_Q112A19 VICAT2_Q112A20 ///
	VICAT2_Q112A22 VICAT2_Q112A23 VICAT2_Q112A24 VICAT2_Q112A25 ///
	VICAT2_Q112A26 VICAT2_Q112A27 ///
	if time_l==1, mineigen(1) pcf
rotate, oblique promax bl(.15)
estat kmo	// kmo=0,85




* Analyse 3
factor VICAT2_Q112A1 VICAT2_Q112A2 VICAT2_Q112A3 VICAT2_Q112A4 VICAT2_Q112A6 ///
	VICAT2_Q112A8 VICAT2_Q112A9 VICAT2_Q112A11 VICAT2_Q112A12 VICAT2_Q112A14 ///
	VICAT2_Q112A15 VICAT2_Q112A17 VICAT2_Q112A18 VICAT2_Q112A19 VICAT2_Q112A20 ///
	VICAT2_Q112A22 VICAT2_Q112A23 VICAT2_Q112A24 VICAT2_Q112A25 VICAT2_Q112A27 ///
	if time_l==1, mineigen(1) pcf
rotate, oblique promax bl(.15)
estat kmo	// kmo=0,82




* Analyse 4
factor VICAT2_Q112A1 VICAT2_Q112A2 VICAT2_Q112A3 VICAT2_Q112A4 VICAT2_Q112A6 ///
	VICAT2_Q112A9 VICAT2_Q112A11 VICAT2_Q112A12 VICAT2_Q112A14 ///
	VICAT2_Q112A17 VICAT2_Q112A18 VICAT2_Q112A19 VICAT2_Q112A20 ///
	VICAT2_Q112A22 VICAT2_Q112A23 VICAT2_Q112A24 VICAT2_Q112A25 ///
	if time_l==1, mineigen(1) pcf
rotate, oblique promax bl(.15)
estat kmo	// kmo=0,79


alpha VICAT2_Q112A1 VICAT2_Q112A2 VICAT2_Q112A3 VICAT2_Q112A4 VICAT2_Q112A6, detail item





* Analyse 5 (auch finale Faktorenanalyse in (Ulrich (2021))
factor VICAT2_Q112A1 VICAT2_Q112A2 VICAT2_Q112A3 VICAT2_Q112A6 ///
	VICAT2_Q112A9 VICAT2_Q112A11 VICAT2_Q112A12 VICAT2_Q112A14 ///
	VICAT2_Q112A17 VICAT2_Q112A18 VICAT2_Q112A19 VICAT2_Q112A20 ///
	VICAT2_Q112A22 VICAT2_Q112A23 VICAT2_Q112A24 VICAT2_Q112A25 ///
	if time_l==1, mineigen(1) pcf
rotate, oblique promax bl(.15)
estat kmo	// kmo=0,79


* Libertarismus
alpha VICAT2_Q112A1 VICAT2_Q112A2 VICAT2_Q112A3 VICAT2_Q112A6 if time_l==1 ///
	, detail item
//alpha=0,59

* Konservativismus
alpha VICAT2_Q112A9 VICAT2_Q112A11 VICAT2_Q112A12 VICAT2_Q112A14 if time_l==1 ///
	, detail item
//alpha=0,75

* Sozialismus
alpha VICAT2_Q112A17 VICAT2_Q112A18 VICAT2_Q112A19 VICAT2_Q112A20 if time_l==1 ///
	, detail item
//alpha=0,69

* Liberalismus
alpha VICAT2_Q112A22 VICAT2_Q112A23 VICAT2_Q112A24 VICAT2_Q112A25 if time_l==1 ///
	, detail item
//alpha=0,71



sum VICAT2_Q112A1 VICAT2_Q112A2 VICAT2_Q112A3 VICAT2_Q112A6 if time_l==1, detail
sum VICAT2_Q112A9 VICAT2_Q112A11 VICAT2_Q112A12 VICAT2_Q112A14 if time_l==1, detail
sum VICAT2_Q112A17 VICAT2_Q112A18 VICAT2_Q112A19 VICAT2_Q112A20 if time_l==1, detail
sum VICAT2_Q112A22 VICAT2_Q112A23 VICAT2_Q112A24 VICAT2_Q112A25 if time_l==1, detail



// CFA

* CFA (ohne Kovarianzen zwischen Fehlertermen)
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
	cov( NEO@1 NEO*KON NEO*LIB KON@1 SOZ@1 SOZ*NEO SOZ*KON SOZ*LIB LIB@1 LIB*KON) ///
	means( NEO@0 KON@0 SOZ@0 LIB@0) nocapslatent


estat framework, standardized format(%6.3f) compact		// Faktorladungsmatrix
estat eqgof, format(%4.3f)							// Kommunalitäten, Item-Reliabilitäten
estat gof, stats(all)
estat mindices

/*
Kennwerte ohne Kovarianzen zwischen den Fehlertermen:
- chi2: 244.35(98) -> p <.0001

- RMSEA: 0,044
- CFI: 0,939
- TLI: 0,926
- SRMR: 0,044
- CD: 0,991
*/





* Mit Kovarianzen zwischen Fehlertermen (basiert auf Modification Index)
sem (NEO -> VICAT2_Q112A1, ) (NEO -> VICAT2_Q112A2, ) ///
	(NEO -> VICAT2_Q112A3, ) (NEO -> VICAT2_Q112A6, ) ///
	(KON -> VICAT2_Q112A9, ) (KON -> VICAT2_Q112A11, ) ///
	(KON -> VICAT2_Q112A12, ) (KON -> VICAT2_Q112A14, ) ///
	(SOZ -> VICAT2_Q112A17, ) (SOZ -> VICAT2_Q112A18, ) ///
	(SOZ -> VICAT2_Q112A19, ) (SOZ -> VICAT2_Q112A20, ) ///
	(LIB -> VICAT2_Q112A22, ) (LIB -> VICAT2_Q112A23, ) ///
	(LIB -> VICAT2_Q112A24, ) (LIB -> VICAT2_Q112A25, ) ///
	if time_l==1, covstruct(_lexogenous, diagonal) standardized ///
	latent(NEO KON SOZ LIB ) ///
	cov( NEO@1 NEO*KON NEO*LIB KON@1 SOZ@1 SOZ*NEO SOZ*KON SOZ*LIB ///
	LIB@1 LIB*KON e.VICAT2_Q112A22*e.VICAT2_Q112A25) ///
	means( NEO@0 KON@0 SOZ@0 LIB@0) nocapslatent


estat framework, standardized format(%6.3f) compact		// Faktorladungsmatrix
estat eqgof, format(%4.3f)							// Kommunalitäten, Item-Reliabilitäten
estat gof, stats(all)

/*
Kennwerte ohne Kovarianzen zwischen den Fehlertermen:
- chi2: 232.62(97) -> p <.0001

- RMSEA: 0,043
- CFI: 0,944
- TLI: 0,931
- SRMR: 0,043
- CD: 0,989
*/




/*
Konfigurale, metrische und skalare Messinvarianz wurde in Ulrich (2021a) getestet.
*/








/* #############################################################################
								Konstruktvalidierung
############################################################################# */


// Berechnung der Ideology-Scores
//-------------------------------

gen ideo_d = (VICAT2_Q112A1 + VICAT2_Q112A2 + VICAT2_Q112A3 + VICAT2_Q112A6 ///
	+ VICAT2_Q112A9 + VICAT2_Q112A11 + VICAT2_Q112A12 + VICAT2_Q112A14 ///
	+ VICAT2_Q112A17 + VICAT2_Q112A18 + VICAT2_Q112A19 + VICAT2_Q112A20 ///
	+ VICAT2_Q112A22 + VICAT2_Q112A23 + VICAT2_Q112A24 + VICAT2_Q112A25) / 16
tab ideo_d, m


* Libertarismus
gen neo = ((VICAT2_Q112A1 + VICAT2_Q112A2 + VICAT2_Q112A3 + VICAT2_Q112A6) / 4) - ideo_d
lab var neo "Libertarismus-Score (zentrierter Mittelwert)"

replace neo = . if time_l!=1
tab neo


* Konservativismus
gen kon = ((VICAT2_Q112A9 + VICAT2_Q112A11 + VICAT2_Q112A12 + VICAT2_Q112A14) / 4) - ideo_d
lab var kon "Konservativismus-Score (zentrierter Mittelwert)"

replace kon = . if time_l!=1
tab kon


* Sozialismus
gen soz = ((VICAT2_Q112A17 + VICAT2_Q112A18 + VICAT2_Q112A19 + VICAT2_Q112A20) / 4) - ideo_d
lab var soz "Sozialismus-Score (zentrierter Mittelwert)"

replace soz = . if time_l!=1
tab soz


* Liberalismus
gen lib = ((VICAT2_Q112A22 + VICAT2_Q112A23 + VICAT2_Q112A24 + VICAT2_Q112A25) / 4) - ideo_d
lab var lib "Liberalismus-Score (zentrierter Mittelwert)"

replace lib = . if time_l!=1
tab lib




// Verteilung der zentrierten Mittelwerte
mean neo kon soz lib [aweight=Weight_W2]









// Korrelationen zwischen den Ideologie-Scores
twoway scatter neo kon
twoway scatter neo soz
twoway scatter neo lib

twoway scatter kon soz
twoway scatter kon lib

twoway scatter soz lib


pwcorr neo kon soz lib, sig obs
pwcorr neo kon soz lib [aweight=Weight_W2] , sig obs




// Konstruktvalidierungen
//-----------------------


* Bildung
pwcorr neo kon soz lib VIC2_Q15 [aweight=Weight_W2], sig obs

* Alter
pwcorr neo kon soz lib VIC2_Q2_Alter VIC_birthyear_ges [aweight=Weight_W2], sig obs

* Eigenes Einkommen
pwcorr neo kon soz lib VICAT2_Q30 [aweight=Weight_W2], sig obs

* HH-Einkommen
pwcorr neo kon soz lib VIC2_Q13 [aweight=Weight_W2], sig obs

* Selbsteinschätzung: soziale Position
pwcorr neo kon soz lib VICAT2_Q101 if VICAT2_Q101!=99 [aweight=Weight_W2], sig obs

* Auskommen mit HH-Einkommen
pwcorr neo kon soz lib VICAT2_Q103 if VICAT2_Q103!=9 [aweight=Weight_W2], sig obs




// Ideologische Kontrollvariablen

* Sexism (Q86)
pwcorr sexism neo kon soz lib if time_l==1 [aweight=Weight_W2], sig obs

* Selbstplatzierung
pwcorr VIC2_Q109 neo kon soz lib if time_l==1 [aweight=Weight_W2], sig obs

* Rechtfertigung von Verhaltensweisen
pwcorr VIC2_Q85A1 VIC2_Q85A2 VIC2_Q85A3 neo kon soz lib [aweight=Weight_W2], sig obs



// Wichtigkeit von Lebensbereichen
pwcorr VICAT2_Q99A1-VICAT2_Q99A9 neo kon soz lib [aweight=Weight_W2], sig obs


// Wichtigkeit von Berufsaspekten (invers!)
pwcorr VICAT2_Q92A1 neo kon soz lib if VICAT2_Q92A1!=8 [aweight=Weight_W2], sig obs
pwcorr VICAT2_Q92A2 neo kon soz lib if VICAT2_Q92A2!=8 [aweight=Weight_W2], sig obs
pwcorr VICAT2_Q92A3 neo kon soz lib if VICAT2_Q92A3!=8 [aweight=Weight_W2], sig obs
pwcorr VICAT2_Q92A4 neo kon soz lib if VICAT2_Q92A4!=8 [aweight=Weight_W2], sig obs
pwcorr VICAT2_Q92A5 neo kon soz lib if VICAT2_Q92A5!=8 [aweight=Weight_W2], sig obs
pwcorr VICAT2_Q92A6 neo kon soz lib if VICAT2_Q92A6!=8 [aweight=Weight_W2], sig obs
pwcorr VICAT2_Q92A7 neo kon soz lib if VICAT2_Q92A7!=8 [aweight=Weight_W2], sig obs
pwcorr VICAT2_Q92A8 neo kon soz lib if VICAT2_Q92A8!=8 [aweight=Weight_W2], sig obs




// Zufriedenheit mit Lebensbereichen
pwcorr VIC2_Q100A1-VIC2_Q100A5 neo kon soz lib [aweight=Weight_W2], sig obs


// Vertrauen in österreichische Institutionen
pwcorr VIC2_Q98A1 VICAT2_Q98A2 VICAT2_Q98A3 VICAT2_Q98A4 VICAT2_Q98A5 ///
	VICAT2_Q98A6 VIC2_Q98A7 VICAT2_Q98A8 VICAT2_Q98A9 VIC2_Q98A10 neo kon soz lib, ///
	sig obs


	
// Big Five Persönlichkeitsdimensionen (Vorwelle!)
pwcorr VIC1_Extraversion VIC1_Neurotizismus VIC1_Verträglichkeit ///
	VIC1_Gewissenhaftigkeit VIC1_Openness_Scale neo kon soz lib [aweight=Weight_W12], sig obs	

pwcorr VIC1_Davis_Empathie_Score neo kon soz lib [aweight=Weight_W12], sig obs
pwcorr VICAT1_Q67 neo kon soz lib if VICAT1_Q67!=5 [aweight=Weight_W12], sig obs	

	
pwcorr VIC1_Verträglichkeit VICAT2_Q99A3 [aweight=Weight_W12], sig obs
pwcorr VIC1_Verträglichkeit VICAT2_Q99A6 VICAT2_Q99A7  [aweight=Weight_W12], sig obs	
	


// Korrelation mit Schwartz-Werten
//--------------------------------

* Offenheit
pwcorr VIC2_Cself VIC2_Csti VIC2_Ched neo kon soz lib if filter_werte==1 [aweight=Weight_W2], sig obs

* Selbsttranszendenz
pwcorr VIC2_Cben VIC2_Cuni neo kon soz lib if filter_werte==1 [aweight=Weight_W2], sig obs

* Konservativismus
pwcorr VIC2_Csec VIC2_Ccon VIC2_Ctra neo kon soz lib if filter_werte==1 [aweight=Weight_W2], sig obs

* Selbstverbesserung
pwcorr VIC2_Cach VIC2_Cpow neo kon soz lib if filter_werte==1 [aweight=Weight_W2], sig obs


* Übergeordnerte Schwartz-Werte
pwcorr VIC2_selfenhancement_c VIC2_selftranscendence_c VIC2_openness_c ///
	VIC2_conservation_c neo kon soz lib if filter_werte==1 [aweight=Weight_W2], sig obs


 

 
// POLID-Scores nach Parteipräferenz
recode VICAT2_Q114 (1=1) (2=2) (3=3) (4=4) (5=5) ///
	(6=10) (7=10) ///
	(8=11) (9=11) ///
	(10=77), gen(partei)
tab partei VICAT2_Q114


reg neo i.b1.partei if time_l==1 [aw=Weight_W2]
margins partei
contrast gw.partei, asobserved

reg kon i.b1.partei if time_l==1 [aw=Weight_W2]
margins partei
contrast gw.partei, asobserved

reg soz i.b1.partei if time_l==1 [aw=Weight_W2]
margins partei
contrast gw.partei, asobserved

reg lib i.b1.partei if time_l==1 [aw=Weight_W2]
margins partei
contrast gw.partei, asobserved







save "C:\Users\b1065535\Desktop\Value in Crisis\Daten\VIC_ges4_weights.dta", replace
