/*##############################################################################
							Variablenaufbereitung
##############################################################################*/

clear all
macro drop _all
capture log close
version 16.1
set more off
numlabel, add


use "C:\Users\b1065535\Desktop\Value in Crisis\Daten\VIC_W1_W2.dta"




* ID
rename ID_U0 id



* Geschlecht
tab VIC_geschl_ges, m

recode VIC_geschl_ges (3=.), gen(sex)

lab define sex 1 "männlich" 2 "weiblich"
lab values sex sex
tab sex, m




* Alter
tab VIC_birthyear_ges, m
/* 
Für einige der Befragten sind nur Jahreszeiträume angegeben.
*/
tab VIC2_Q2_Alter, m



* Offene Antworten: Wohnrecht
tab VICAT2_Q10, m
recode VICAT2_Q10 (3=.), gen(wohnrecht)
tab wohnrecht, m




* Migrationshintergrund
tab VICAT2_Q37		//Geburtsland Befragter
tab VICAT2_Q38		//Geburtsland Vater
tab VICAT2_Q39		//Geburtsland Mutter


gen migration = .
replace migration = 0 if VICAT2_Q37==1 & VICAT2_Q38==1 ///
	& VICAT2_Q39==1

replace migration = 1 if VICAT2_Q37!=1

replace migration = 2 if VICAT2_Q37==1 & VICAT2_Q38!=1
replace migration = 2 if VICAT2_Q37==1 & VICAT2_Q39!=1


lab var migration "Migrationshintergrund"
lab define migration 0 "[0] Kein Migrationshintergrund" ///
	1 "[1] Migrationshintergrund 1. Generation" ///
	2 "[2] Migrationshintergrund 2. Generation"
lab values migration migration
	
tab migration, m


* Überprüfen der Codierung
list migration VICAT2_Q37 VICAT2_Q38 VICAT2_Q39






* Nettowohnfläche
tab VICAT2_Q11, m		//m2 gruppiert
tab VIC2_Q6, m

gen nettowohn = VICAT2_Q11 / VIC2_Q6
tab nettowohn, m
mean nettowohn	// Durchschnitt: 50 bis 59 m2 pro Person im HH

tab nettowohn

gen nettowohn_gr = .
replace nettowohn_gr = 1 if inrange(nettowohn,0,1.857143)
replace nettowohn_gr = 2 if inrange(nettowohn,2,2.285714)
replace nettowohn_gr = 3 if inrange(nettowohn,2.3,2.75)
replace nettowohn_gr = 4 if inrange(nettowohn,2.8,3)
replace nettowohn_gr = 5 if inrange(nettowohn,3.142857,3.5)
replace nettowohn_gr = 6 if inrange(nettowohn,3.6,4)
replace nettowohn_gr = 7 if inrange(nettowohn,4.2,5)
replace nettowohn_gr = 8 if inrange(nettowohn,5.25,6)
replace nettowohn_gr = 9 if inrange(nettowohn,6.3,7.4)
replace nettowohn_gr = 10 if inrange(nettowohn,7.5,23)

tab nettowohn_gr if Teilnahme_W2==1, m
list id VICAT2_Q11 VIC2_Q6 nettowohn if Teilnahme_W2==1 & nettowohn_gr==.


* Fälle, die irgendiwe durchs Raster fielen
replace nettowohn_gr = 6 if ///
	inlist(id,97396,217395,1160110,1359436,2180187,2412947,2635740,2872134, ///
	3064003,3070442,3171463,3227147)

replace nettowohn_gr = 4 if ///
	inlist(id,134631,589135,983911,1481091,1666345,2456149,2600901,2696079,3133704)

replace nettowohn_gr = 7 if inlist(id,1676716,2845088,3373286)


tab nettowohn_gr




* HH-Größe
tab VIC2_Q6

recode VIC2_Q6 (1=1) (2=2) (3=3) (4=4) (5=5) (6=5) (7=5), gen(hhgröße)

lab define hhgröße 5 "5 oder mehr"
lab values hhgröße hhgröße

tab hhgröße, m





* Anzahl leiblicher Kinder
tab VIC2_Q4, m


recode VIC2_Q4 (0=0) (1=1) (2=2) (3=3) (4=4) (5=4), gen(kinder)

lab define kinder 4 "4 oder mehr"
lab values kinder kinder

tab kinder, m








* Ausstattung des Wohnorts
tab VICAT2_Q12A1	//Balkon
tab VICAT2_Q12A2	//Terasse(n)
tab VICAT2_Q12A3	//Garten
tab VICAT2_Q12A4	//Park in der Nähe
tab VICAT2_Q12A5	//Grünflächen in der Nähe
tab VICAT2_Q12A6	//Nichts davon


gen wohn_aus = 0
replace wohn_aus = wohn_aus + 1 if VICAT2_Q12A1==1
replace wohn_aus = wohn_aus + 1 if VICAT2_Q12A2==1
replace wohn_aus = wohn_aus + 1 if VICAT2_Q12A3==1
replace wohn_aus = wohn_aus + 1 if VICAT2_Q12A4==1
replace wohn_aus = wohn_aus + 1 if VICAT2_Q12A5==1

tab wohn_aus, m

list id wohn_aus VICAT2_Q12A1 VICAT2_Q12A2 VICAT2_Q12A3 VICAT2_Q12A4 ///
	VICAT2_Q12A5

lab var wohn_aus "Anzahl der Ausstattungen des Wohnraums"





* Einkommen - Quartile
tab VICAT2_Q30, m

tab VICAT2_Q30
recode VICAT2_Q30  (1=1) (2=1) (3=1) (4=1) (5=1) ///
	(6=2) (7=2) ///
	(8=3) (9=3) ///
	(10=4) (11=4) (12=4) (13=4) (14=4), gen(eink)

lab define eink 1 "1. Quartil (bis 1.124 Euro)" 2 "2. Quartil (1.125 - 1.649 Euro)" ///
	3 "3. Quartil (1.650 - 2.249 Euro)" 4 "4. Quartil (ab 2.249 Euro)"
lab values eink eink

tab eink
tab eink, m



* HH-Einkommen - Quartile
tab VIC2_Q13, m

tab VIC2_Q13  if Teilnahme_W2==1
recode VIC2_Q13 (1=1) (2=1) (3=1) (4=1) (5=1) (6=1) ///
	(7=2) (8=2) (9=2) ///
	(10=3) (11=3) ///
	(12=4) (13=4) (14=4) (15=4) (16=4) (17=4), gen(hheink)

lab define hheink 1 "1. Quartil (bis 1.649 Euro)" ///
	2 "2. Quartil (1.650 - 2.699 Euro)" ///
	3 "3. Quartil (2.700 - 3.599 Euro)" ///
	4 "4. Quartil (ab 3.600 Euro)"
lab values hheink hheink

tab hheink
tab hheink, m





* Bildungsgruupen
tab VIC2_Q15, m


recode VIC2_Q15  (1=1)	/// Pflichtschule
	(2=2) (3=2)			/// Abgeschlossene Lehre
	(4=3)				/// Berufsb. mittlere Schule
	(5=4)				/// Allgemeinb. höhere Schule
	(6=5)				/// Berufsb. höhere Schule
	(7=6) (8=6) (9=6) (10=6) (11=6) (12=6) (13=6)	///(Fach)Hochschulabschluss
	, gen(bildung)

	
lab define bildung 1 "Pflichtschule" ///
	2 "Abgeschlossene Lehre" ///
	3 "Berufsb. mittlere Schule" ///
	4 "Allgemb. höhere Schule" ///
	5 "Berufsb. höhere Schule" ///
	6 "(Fach)Hochschulabschluss"
lab values bildung bildung
	
tab bildung, m











* Erwerbssituation
tab VICAT2_Q26, m

recode VICAT2_Q26  (1=1) (2=2) (3=3) (4=4) (5=8) (6=5) (7=5) ///
	(8=3) (9=6) (10=6) (11=6) (12=7) (13=7) (14=8) ///
	(15=9) (16=9) (17=10), gen(erwerb)


lab define erwerb  1 "[1] Angestellt: öfftl. Dienst" ///
	2 "[2] Angestellt: Privatwirtsch." ///
	3 "[3] Angestellt: Arbeiter" ///
	4 "[4] Selbstständig" ///
	5 "[5] Momentan Kurzarbeit" ///
	6 "[6] Nicht erwerbstätig" ///
	7 "[7] Rente" ///
	8 "[8] Hausfrau/-mann / Karenz" ///
	9 "[9] In Ausbildung" ///
	10 "[10] Sonstiges"
lab values erwerb erwerb


tab erwerb VICAT2_Q26 , m
tab erwerb, m



* Vollzeit/Teilzeit
tab VICAT2_Q29, m 

gen vollzeit = 1
replace vollzeit = 0 if inrange(VICAT2_Q29,1,4)

tab vollzeit, m




* Vertrauen in demokratische Institutionen
tab VIC2_Q98A10, m
recode VIC2_Q98A10 (1=4) (2=3) (3=2) (4=1), gen(trust)

tab trust, m



* Sexismus-Score (Q86)
recode VIC2_Q86A1 VIC2_Q86A2 VIC2_Q86A3 (1=4) (2=3) (3=2) (4=1)
gen sexism = (VIC2_Q86A1 + VIC2_Q86A2 + VIC2_Q86A3)/3
lab var sexism "Sexism-Score (Q86 - Mittelwert)"
tab sexism, m





* Selbsteinschätzung: Soziale Position
tab VICAT2_Q101

recode VICAT2_Q101 (1=1) (2=1) (3=1) ///
	(4=2) (5=2) ///
	(6=3) (7=3) ///
	(8=4) (9=4) (10=4) ///
	(99=5), gen(subj_sozPos)
tab VICAT2_Q101 subj_sozPos, m

lab define subj_sozPos  1 "[1] Unten" ///
	2 "[2] Untere Mitte" ///
	3 "[3] Obere Mitte" ///
	4 "[4] Oben" ///
	5 "[5] Weiß nicht"
lab values subj_sozPos subj_sozPos

tab subj_sozPos
















save "C:\Users\b1065535\Desktop\Value in Crisis\Daten\VIC_ges2.dta", replace
exit
