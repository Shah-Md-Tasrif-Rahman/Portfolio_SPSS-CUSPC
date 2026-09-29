* Encoding: UTF-8.

* /Step-1: Data loading/

PRESERVE.
SET DECIMAL DOT.

GET DATA  /TYPE=TXT
  /FILE="E:\Statistical Softwares\SPSS\CUSPC-SPSS\Assignments\Final Project\telco_data.csv"
  /ENCODING='UTF8'
  /DELIMITERS=","
  /QUALIFIER='"'
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /DATATYPEMIN PERCENTAGE=95.0
  /VARIABLES=
  customerID AUTO
  gender AUTO
  SeniorCitizen AUTO
  Partner AUTO
  Dependents AUTO
  tenure AUTO
  PhoneService AUTO
  MultipleLines AUTO
  InternetService AUTO
  OnlineSecurity AUTO
  OnlineBackup AUTO
  DeviceProtection AUTO
  TechSupport AUTO
  StreamingTV AUTO
  StreamingMovies AUTO
  Contract AUTO
  PaperlessBilling AUTO
  PaymentMethod AUTO
  MonthlyCharges AUTO
  TotalCharges AUTO
  Churn AUTO
  /MAP.
RESTORE.
CACHE.
EXECUTE.
DATASET NAME DataSet1 WINDOW=FRONT.


SAVE OUTFILE='E:\Statistical Softwares\SPSS\CUSPC-SPSS\Assignments\Final Project\Final_Project.sav'
  /COMPRESSED.

* /Step-2: Initial data Checking/

DATASET ACTIVATE DataSet1.
FREQUENCIES VARIABLES=customerID gender SeniorCitizen Partner Dependents tenure PhoneService 
    MultipleLines InternetService OnlineSecurity OnlineBackup DeviceProtection TechSupport StreamingTV 
    StreamingMovies Contract PaperlessBilling PaymentMethod MonthlyCharges TotalCharges Churn
  /FORMAT=NOTABLE
  /STATISTICS=RANGE MINIMUM MAXIMUM
  /ORDER=ANALYSIS.

* /Step-3: Fixing "SPSS failing to find missing value properly" issue/

MISSING VALUES gender Partner InternetService StreamingTV  (' ').

* Checking again if things are okay or not

DATASET ACTIVATE DataSet1.
FREQUENCIES VARIABLES=customerID gender SeniorCitizen Partner Dependents tenure PhoneService 
    MultipleLines InternetService OnlineSecurity OnlineBackup DeviceProtection TechSupport StreamingTV 
    StreamingMovies Contract PaperlessBilling PaymentMethod MonthlyCharges TotalCharges Churn
  /FORMAT=NOTABLE
  /STATISTICS=RANGE MINIMUM MAXIMUM
  /ORDER=ANALYSIS.

* /Step-4: Checking or fixing duplicate observations/

DATASET ACTIVATE DataSet1.
* Identify Duplicate Cases.
SORT CASES BY customerID(A).
MATCH FILES
  /FILE=*
  /BY customerID
  /FIRST=PrimaryFirst
  /LAST=PrimaryLast.
DO IF (PrimaryFirst).
COMPUTE  MatchSequence=1-PrimaryLast.
ELSE.
COMPUTE  MatchSequence=MatchSequence+1.
END IF.
LEAVE  MatchSequence.
FORMATS  MatchSequence (f7).
COMPUTE  InDupGrp=MatchSequence>0.
SORT CASES InDupGrp(D).
MATCH FILES
  /FILE=*
  /DROP=PrimaryFirst InDupGrp MatchSequence.
VARIABLE LABELS  PrimaryLast 'Indicator of each last matching case as Primary'.
VALUE LABELS  PrimaryLast 0 'Duplicate Case' 1 'Primary Case'.
VARIABLE LEVEL  PrimaryLast (ORDINAL).
FREQUENCIES VARIABLES=PrimaryLast.
EXECUTE.

* No duplicates exist, splendid.

* /Step-4: Data labelling/

VARIABLE LABELS
    customerID        "Unique identifier for each customer"
    gender            "Customer gender: Male/Female"
    SeniorCitizen     "Indicates if the customer is a senior citizen (0 = No, 1 = Yes)"
    Partner           "Whether the customer has a partner"
    Dependents        "Whether the customer has dependents"
    tenure            "Number of months the customer has stayed with the company"
    PhoneService      "Whether the customer has phone service"
    MultipleLines     "Whether the customer has multiple lines"
    InternetService   "Customer's internet service provider (DSL, Fiber optic, No)"
    OnlineSecurity    "Whether the customer has online security"
    OnlineBackup      "Whether the customer has online backup"
    DeviceProtection  "Whether the customer has device protection"
    TechSupport       "Whether the customer has tech support"
    StreamingTV       "Whether the customer has streaming TV"
    StreamingMovies   "Whether the customer has streaming movies"
    Contract          "Type of contract: Month-to-month, One year, Two year"
    PaperlessBilling  "Whether the customer uses paperless billing"
    PaymentMethod     "Payment method (e.g., Electronic check, Mailed check, etc.)"
    MonthlyCharges    "Monthly charges"
    TotalCharges      "Total charges to date"
    Churn             "Whether the customer has left the company (Yes/No)".
EXECUTE.

VALUE LABELS
    SeniorCitizen
        0 "No"
        1 "Yes".

VALUE LABELS
    Churn
        "No" "Customer retained"
        "Yes" "Customer churned".

EXECUTE.

* Things are okay now, we can move onto any required furthur procressing and analysis.

SAVE OUTFILE='E:\Statistical Softwares\SPSS\CUSPC-SPSS\Assignments\Final Project\Final_Project.sav'
  /COMPRESSED.

* /Task-1: Table-1/

* Custom Tables.
CTABLES
  /VLABELS VARIABLES=gender SeniorCitizen Partner Dependents tenure PhoneService MultipleLines 
    InternetService OnlineSecurity OnlineBackup DeviceProtection TechSupport StreamingTV 
    StreamingMovies Contract PaperlessBilling PaymentMethod MonthlyCharges TotalCharges Churn 
    DISPLAY=LABEL
  /TABLE gender [COUNT 'Frequency' F40.0, TABLEPCT.COUNT 'Percentage' PCT40.2] + SeniorCitizen 
    [COUNT 'Frequency' F40.0, TABLEPCT.COUNT 'Percentage' PCT40.2] + Partner [COUNT 'Frequency' F40.0, TABLEPCT.COUNT 'Percentage' PCT40.2] + Dependents 
    [COUNT 'Frequency' F40.0, TABLEPCT.COUNT 'Percentage' PCT40.2] + tenure [MEAN, STDDEV, MEDIAN, 
    MINIMUM, MAXIMUM] + PhoneService [COUNT 'Frequency' F40.0, TABLEPCT.COUNT 'Percentage' PCT40.2] + 
    MultipleLines [COUNT 'Frequency' F40.0, TABLEPCT.COUNT 'Percentage' PCT40.2] + InternetService 
    [COUNT 'Frequency' F40.0, TABLEPCT.COUNT 'Percentage' PCT40.2] + OnlineSecurity [COUNT 'Frequency' 
    F40.0, TABLEPCT.COUNT 'Percentage' PCT40.2] + OnlineBackup [COUNT 'Frequency' F40.0, TABLEPCT.COUNT 
    'Percentage' PCT40.2] + DeviceProtection [COUNT 'Frequency' F40.0, TABLEPCT.COUNT 'Percentage' 
    PCT40.2] + TechSupport [COUNT 'Frequency' F40.0, TABLEPCT.COUNT 'Percentage' PCT40.2] + StreamingTV 
    [COUNT 'Frequency' F40.0, TABLEPCT.COUNT 'Percentage' PCT40.2] + StreamingMovies [COUNT 'Frequency' 
    F40.0, TABLEPCT.COUNT 'Percentage' PCT40.2] + Contract [COUNT 'Frequency' F40.0, TABLEPCT.COUNT 
    'Percentage' PCT40.2] + PaperlessBilling [COUNT 'Frequency' F40.0, TABLEPCT.COUNT 'Percentage' 
    PCT40.2] + PaymentMethod [COUNT 'Frequency' F40.0, TABLEPCT.COUNT 'Percentage' PCT40.2] + 
    MonthlyCharges [MEAN, STDDEV, MEDIAN, MINIMUM, MAXIMUM] + TotalCharges [MEAN, STDDEV, MEDIAN, 
    MINIMUM, MAXIMUM] + Churn [COUNT 'Frequency' F40.0, TABLEPCT.COUNT 'Percentage' PCT40.2]
  /CATEGORIES VARIABLES=gender Partner Dependents PhoneService MultipleLines InternetService 
    OnlineSecurity OnlineBackup DeviceProtection TechSupport StreamingTV StreamingMovies Contract 
    PaperlessBilling PaymentMethod ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CATEGORIES VARIABLES=SeniorCitizen Churn ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

* /Task-2: Testing research questions/

* /RQ-1: Is customer tenure associated with customer churn?/

* Testing normality

EXAMINE VARIABLES=tenure BY Churn
  /PLOT BOXPLOT HISTOGRAM NPPLOT
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.

* Data deviates from normality, moving to non-parametric tests

RECODE Churn ('No'=0) ('Yes'=1) INTO Churn_recoded.
VALUE LABELS Churn_recoded
    0 'No'
    1 'Yes'.
EXECUTE.

NPAR TESTS
  /M-W= tenure BY Churn_recoded(0 1)
  /STATISTICS=DESCRIPTIVES QUARTILES
  /MISSING ANALYSIS.

* /RQ-2: Are contract type and customer churn associated?/

DATASET ACTIVATE DataSet1.
CROSSTABS
  /TABLES= Churn BY Contract
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ PHI 
  /CELLS=COUNT COLUMN 
  /COUNT ROUND CELL
  /BARCHART.
OUTPUT MODIFY
  /SELECT TABLES
  /IF COMMANDS=["Crosstabs(LAST)"] SUBTYPES=["Crosstabulation"]
  /TABLE PIVOT=[R1,C1].
OUTPUT MODIFY
  /SELECT TABLES
  /IF COMMANDS=["Crosstabs(LAST)"] SUBTYPES=["Crosstabulation"]
  /TABLECELLS SELECT=[PERCENT] APPLYTO=COLUMNHEADER REPLACE="%"
  /TABLECELLS SELECT=[COUNT] APPLYTO=COLUMNHEADER REPLACE="N".

* /RQ-3: Which customer characteristics are associated with the odds of customer churn?/

LOGISTIC REGRESSION VARIABLES Churn_recoded
  /METHOD=ENTER tenure MonthlyCharges Contract TechSupport InternetService PaymentMethod 
  /CONTRAST (InternetService)=Indicator
  /CONTRAST (TechSupport)=Indicator(1)
  /CONTRAST (Contract)=Indicator(1)
  /CONTRAST (PaymentMethod)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

* Due to redundancies (in predictor variables), degrees of freedom have been reduced for one or more variables (from 11 df to 10 df).
* Now we'll test two reduced models to see which one is more usable.

* Model-1 (Uses InternetService):

LOGISTIC REGRESSION VARIABLES Churn_recoded
  /METHOD=ENTER tenure MonthlyCharges PaymentMethod Contract InternetService 
  /CONTRAST (Contract)=Indicator(1)
  /CONTRAST (InternetService)=Indicator
  /CONTRAST (PaymentMethod)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

* H-L test is significant, thus this model is rejected.

* Model-2 (Uses TechSupport):

LOGISTIC REGRESSION VARIABLES Churn_recoded
  /METHOD=ENTER tenure MonthlyCharges PaymentMethod Contract TechSupport 
  /CONTRAST (Contract)=Indicator(1)
  /CONTRAST (TechSupport)=Indicator(1)
  /CONTRAST (PaymentMethod)=Indicator(1)
  /PRINT=GOODFIT CI(95)
  /CRITERIA=PIN(0.05) POUT(0.10) ITERATE(20) CUT(0.5).

* H-L test isn't significant, thus this model is accepted as final model.

* /Task-3: Graphs/

* /G-1/

* Chart Builder.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=Churn COUNT()[name="COUNT"] MISSING=LISTWISE 
    REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE
  /FRAME OUTER=NO INNER=NO
  /GRIDLINES XAXIS=NO YAXIS=YES
  /STYLE GRADIENT=NO.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: Churn=col(source(s), name("Churn"), unit.category())
  DATA: COUNT=col(source(s), name("COUNT"))
  GUIDE: axis(dim(1), label("Whether the customer has left the company (Yes/No)"))
  GUIDE: axis(dim(2), label("Percent"))
  GUIDE: text.title(label("Churn status percentage bar chart"))
  SCALE: cat(dim(1), include("No", "Yes"))
  SCALE: linear(dim(2), include(0))
  ELEMENT: interval(position(summary.percent(Churn*COUNT, base.all(acrossPanels()))), 
    shape.interior(shape.square))
END GPL.

* /G-2/

* Chart Builder.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=tenure Churn MISSING=LISTWISE REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE
  /COLORCYCLE COLOR1(95,195,56), COLOR2(215,0,51), COLOR3(159,24,83), COLOR4(250,77,86), 
    COLOR5(87,4,8), COLOR6(25,128,56), COLOR7(0,45,156), COLOR8(238,83,139), COLOR9(178,134,0), 
    COLOR10(0,157,154), COLOR11(1,39,73), COLOR12(138,56,0), COLOR13(165,110,255), 
    COLOR14(236,230,208), COLOR15(69,70,71), COLOR16(92,202,136), COLOR17(208,83,52), 
    COLOR18(204,127,228), COLOR19(225,188,29), COLOR20(237,75,75), COLOR21(28,205,205), 
    COLOR22(92,113,72), COLOR23(225,139,14), COLOR24(9,38,114), COLOR25(90,100,94), COLOR26(155,0,0), 
    COLOR27(207,172,227), COLOR28(150,145,145), COLOR29(63,235,124), COLOR30(105,41,196)
  /FRAME OUTER=NO INNER=NO
  /GRIDLINES XAXIS=NO YAXIS=YES
  /STYLE GRADIENT=NO.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: tenure=col(source(s), name("tenure"))
  DATA: Churn=col(source(s), name("Churn"), unit.category())
  GUIDE: axis(dim(1), label("Number of months the customer has stayed with the company"))
  GUIDE: axis(dim(2), label("Frequency Percent"))
  GUIDE: legend(aesthetic(aesthetic.color.interior), label("Whether the customer has left the ",
    "company (Yes/No)"))
  GUIDE: text.title(label("Tenure histogram (Split by churn status)"))
  SCALE: cat(aesthetic(aesthetic.color.interior), include(
"No", "Yes"))
  ELEMENT: interval.stack(position(summary.percent.count(bin.rect(tenure), 
    base.all(acrossPanels()))), color.interior(Churn), shape.interior(shape.square))
END GPL.

* /G-3/

* Chart Builder.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=Churn tenure MISSING=LISTWISE REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE
  /FRAME OUTER=NO INNER=NO
  /GRIDLINES XAXIS=NO YAXIS=YES
  /STYLE GRADIENT=NO.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: Churn=col(source(s), name("Churn"), unit.category())
  DATA: tenure=col(source(s), name("tenure"))
  DATA: id=col(source(s), name("$CASENUM"), unit.category())
  GUIDE: axis(dim(1), label("Whether the customer has left the company (Yes/No)"))
  GUIDE: axis(dim(2), label("Number of months the customer has stayed with the company"))
  GUIDE: text.title(label("Tenure by Churn boxplot"))
  SCALE: cat(dim(1), include("No", "Yes"))
  SCALE: linear(dim(2), include(0))
  ELEMENT: schema(position(bin.quantile.letter(Churn*tenure)), label(id))
END GPL.

* /G-4/

* Chart Builder.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=Contract COUNT()[name="COUNT"] Churn MISSING=LISTWISE 
    REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE
  /COLORCYCLE COLOR1(215,0,51), COLOR2(95,195,56), COLOR3(159,24,83), COLOR4(250,77,86), 
    COLOR5(87,4,8), COLOR6(25,128,56), COLOR7(0,45,156), COLOR8(238,83,139), COLOR9(178,134,0), 
    COLOR10(0,157,154), COLOR11(1,39,73), COLOR12(138,56,0), COLOR13(165,110,255), 
    COLOR14(236,230,208), COLOR15(69,70,71), COLOR16(92,202,136), COLOR17(208,83,52), 
    COLOR18(204,127,228), COLOR19(225,188,29), COLOR20(237,75,75), COLOR21(28,205,205), 
    COLOR22(92,113,72), COLOR23(225,139,14), COLOR24(9,38,114), COLOR25(90,100,94), COLOR26(155,0,0), 
    COLOR27(207,172,227), COLOR28(150,145,145), COLOR29(63,235,124), COLOR30(105,41,196)
  /FRAME OUTER=NO INNER=NO
  /GRIDLINES XAXIS=NO YAXIS=YES
  /STYLE GRADIENT=NO.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: Contract=col(source(s), name("Contract"), unit.category())
  DATA: COUNT=col(source(s), name("COUNT"))
  DATA: Churn=col(source(s), name("Churn"), unit.category())
  COORD: rect(dim(1,2), transpose())
  GUIDE: axis(dim(1), label("Type of contract: Month-to-month, One year, Two year"))
  GUIDE: axis(dim(2), label("Percent"))
  GUIDE: legend(aesthetic(aesthetic.color.interior), label("Whether the customer has left the ",
    "company (Yes/No)"))
  GUIDE: text.title(label("Stacked bar chart of contract type by churn status"))
  SCALE: cat(dim(1), reverse())
  SCALE: linear(dim(2), include(0))
  SCALE: cat(aesthetic(aesthetic.color.interior), reverse(), include(
"No", "Yes"))
  ELEMENT: interval.stack(position(Contract*COUNT), color.interior(Churn), 
    shape.interior(shape.square))
END GPL.

* /G-5/

* Chart Builder.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=PaymentMethod COUNT()[name="COUNT"] Churn 
    MISSING=LISTWISE REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE
  /COLORCYCLE COLOR1(215,0,51), COLOR2(95,195,56), COLOR3(159,24,83), COLOR4(250,77,86), 
    COLOR5(87,4,8), COLOR6(25,128,56), COLOR7(0,45,156), COLOR8(238,83,139), COLOR9(178,134,0), 
    COLOR10(0,157,154), COLOR11(1,39,73), COLOR12(138,56,0), COLOR13(165,110,255), 
    COLOR14(236,230,208), COLOR15(69,70,71), COLOR16(92,202,136), COLOR17(208,83,52), 
    COLOR18(204,127,228), COLOR19(225,188,29), COLOR20(237,75,75), COLOR21(28,205,205), 
    COLOR22(92,113,72), COLOR23(225,139,14), COLOR24(9,38,114), COLOR25(90,100,94), COLOR26(155,0,0), 
    COLOR27(207,172,227), COLOR28(150,145,145), COLOR29(63,235,124), COLOR30(105,41,196)
  /FRAME OUTER=NO INNER=NO
  /GRIDLINES XAXIS=NO YAXIS=YES
  /STYLE GRADIENT=NO.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: PaymentMethod=col(source(s), name("PaymentMethod"), unit.category())
  DATA: COUNT=col(source(s), name("COUNT"))
  DATA: Churn=col(source(s), name("Churn"), unit.category())
  COORD: rect(dim(1,2), transpose())
  GUIDE: axis(dim(1), label("Payment method (e.g., Electronic check, Mailed check, etc.)"))
  GUIDE: axis(dim(2), label("Percent"))
  GUIDE: legend(aesthetic(aesthetic.color.interior), label("Whether the customer has left the ",
    "company (Yes/No)"))
  GUIDE: text.title(label("Stacked bar chart of payment method by churn status"))
  SCALE: cat(dim(1), reverse())
  SCALE: linear(dim(2), include(0))
  SCALE: cat(aesthetic(aesthetic.color.interior), reverse(), include(
"No", "Yes"))
  ELEMENT: interval.stack(position(PaymentMethod*COUNT), color.interior(Churn), 
    shape.interior(shape.square))
END GPL.

* /G-6/

* Chart Builder.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=InternetService COUNT()[name="COUNT"] Churn 
    MISSING=LISTWISE REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE
  /COLORCYCLE COLOR1(215,0,51), COLOR2(95,195,56), COLOR3(159,24,83), COLOR4(250,77,86), 
    COLOR5(87,4,8), COLOR6(25,128,56), COLOR7(0,45,156), COLOR8(238,83,139), COLOR9(178,134,0), 
    COLOR10(0,157,154), COLOR11(1,39,73), COLOR12(138,56,0), COLOR13(165,110,255), 
    COLOR14(236,230,208), COLOR15(69,70,71), COLOR16(92,202,136), COLOR17(208,83,52), 
    COLOR18(204,127,228), COLOR19(225,188,29), COLOR20(237,75,75), COLOR21(28,205,205), 
    COLOR22(92,113,72), COLOR23(225,139,14), COLOR24(9,38,114), COLOR25(90,100,94), COLOR26(155,0,0), 
    COLOR27(207,172,227), COLOR28(150,145,145), COLOR29(63,235,124), COLOR30(105,41,196)
  /FRAME OUTER=NO INNER=NO
  /GRIDLINES XAXIS=NO YAXIS=YES
  /STYLE GRADIENT=NO.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: InternetService=col(source(s), name("InternetService"), unit.category())
  DATA: COUNT=col(source(s), name("COUNT"))
  DATA: Churn=col(source(s), name("Churn"), unit.category())
  COORD: rect(dim(1,2), transpose())
  GUIDE: axis(dim(1), label("Customer's internet service provider (DSL, Fiber optic, No)"))
  GUIDE: axis(dim(2), label("Percent"))
  GUIDE: legend(aesthetic(aesthetic.color.interior), label("Whether the customer has left the ",
    "company (Yes/No)"))
  GUIDE: text.title(label("Stacked bar chart of customer's internet service by churn status"))
  SCALE: linear(dim(2), include(0))
  SCALE: cat(aesthetic(aesthetic.color.interior), reverse(), include(
"No", "Yes"))
  ELEMENT: interval.stack(position(InternetService*COUNT), color.interior(Churn), 
    shape.interior(shape.square))
END GPL.

SAVE OUTFILE='E:\Statistical Softwares\SPSS\CUSPC-SPSS\Assignments\Final Project\Final_Project.sav'
  /COMPRESSED.
