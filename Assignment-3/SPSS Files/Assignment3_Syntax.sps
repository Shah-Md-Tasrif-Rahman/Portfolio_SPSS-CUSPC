* Encoding: UTF-8.

* /Step-1: Data loading/

GET 
  FILE='E:\Statistical Softwares\SPSS\CUSPC-SPSS\Assignments\Assignment-3\assignment3.sav'. 
DATASET NAME DataSet1 WINDOW=FRONT.

DATASET ACTIVATE DataSet1.

* /Step-2: Data Checking/

FREQUENCIES VARIABLES=mother_id low_birth_weight mother_age anc_visits wealth_index residence
/FORMAT=NOTABLE
/STATISTICS=RANGE MINIMUM MAXIMUM
/ORDER=ANALYSIS.

* No missing or impossible values exist, we can continue.

* Question 1:

* Custom Tables.
CTABLES
  /VLABELS VARIABLES=low_birth_weight residence wealth_index mother_age anc_visits DISPLAY=LABEL
  /TABLE low_birth_weight [TABLEPCT.COUNT 'Frequency, n (%)' PCT40.2] + residence 
    [TABLEPCT.COUNT 'Frequency, n (%)' PCT40.2] + wealth_index [TABLEPCT.COUNT 'Frequency, n (%)' 
    PCT40.2] + mother_age [MEAN, STDDEV, MEDIAN, MINIMUM, MAXIMUM] + anc_visits [MEAN, STDDEV, MEDIAN, 
    MINIMUM, MAXIMUM]
  /CATEGORIES VARIABLES=low_birth_weight residence wealth_index ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

* Question 2:

* H_0: The mean number of ANC visits doesn't differ between mothers living in rural and urban areas. (μ_1 = μ_2).
* H_1: The mean number of ANC visits differs between mothers living in rural and urban areas. (μ_1 ≠ μ_2).

T-TEST GROUPS=residence(0 1)
  /MISSING=ANALYSIS
  /VARIABLES=anc_visits
  /ES DISPLAY(TRUE)
  /CRITERIA=CI(.95).

* Question 3:

LOGISTIC REGRESSION VARIABLES low_birth_weight
  /METHOD=ENTER mother_age anc_visits wealth_index residence 
  /CONTRAST (wealth_index)=Indicator(1)
  /CONTRAST (residence)=Indicator(1)
  /CLASSPLOT
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).
