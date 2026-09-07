* Encoding: UTF-8.

PRESERVE.
SET DECIMAL DOT.

* Since I messed up while generating the output of my first assignment, I'll be properly segmenting my code so that the final output is clean and reproducible using whatever syntax I used during data analysis.

* /Step-1: Data loading/

GET DATA  /TYPE=TXT
  /FILE="E:\Statistical Softwares\SPSS\CUSPC-SPSS\Class-7\salary regression data.csv"
  /ENCODING='UTF8'
  /DELIMITERS=","
  /QUALIFIER='"'
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /DATATYPEMIN PERCENTAGE=95.0
  /VARIABLES=
  employee_id AUTO
  age AUTO
  education_years AUTO
  experience_years AUTO
  training_hours AUTO
  region AUTO
  annual_salary_k AUTO
  /MAP.
RESTORE.
CACHE.
EXECUTE.
DATASET NAME DataSet1 WINDOW=FRONT.

* /Step-2: Data labelling/

VARIABLE LABELS
    employee_id 'Anonymised employee identifier'
    age 'Age at time of extract (Years)'
    education_years 'Total years of completed formal education (Years)'
    experience_years 'Total years of professional work experience (Years)'
    training_hours 'Company-funded training received in the last 12 months (Hours)'
    region 'Office location type (Urban/Suburban/Rural)'
    annual_salary_k 'Gross annual salary (USD thousands)'.
EXECUTE.

VARIABLE LEVEL employee_id (NOMINAL).
EXECUTE.

* /Step-3: Data Checking/

DATASET ACTIVATE DataSet1.
FREQUENCIES VARIABLES=employee_id age education_years experience_years training_hours region 
    annual_salary_k
  /FORMAT=NOTABLE
  /STATISTICS=RANGE MINIMUM MAXIMUM
  /ORDER=ANALYSIS.

FREQUENCIES VARIABLES=region
  /ORDER=ANALYSIS.

* All 250 observations are present in the given dataset, and no impossible values were found. We can safely proceed to the next steps of analysis.

* /Task 1/
.
* Custom Tables.
CTABLES
  /VLABELS VARIABLES=age education_years experience_years training_hours annual_salary_k 
    DISPLAY=LABEL
  /TABLE age [COUNT 'Complete cases (n)' F40.0, MINIMUM, MAXIMUM, MEAN, MEDIAN, STDDEV] + 
    education_years [COUNT 'Complete cases (n)' F40.0, MINIMUM, MAXIMUM, MEAN, MEDIAN, STDDEV] + 
    experience_years [COUNT 'Complete cases (n)' F40.0, MINIMUM, MAXIMUM, MEAN, MEDIAN, STDDEV] + 
    training_hours [COUNT 'Complete cases (n)' F40.0, MINIMUM, MAXIMUM, MEAN, MEDIAN, STDDEV] + 
    annual_salary_k [COUNT 'Complete cases (n)' F40.0, MINIMUM, MAXIMUM, MEAN, MEDIAN, STDDEV]
  /CRITERIA CILEVEL=95.

* /Task 2/

* /Graph-2a/

* Chart Builder.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=annual_salary_k MISSING=LISTWISE REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE
  /FRAME OUTER=NO INNER=NO
  /GRIDLINES XAXIS=NO YAXIS=YES
  /STYLE GRADIENT=NO.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: annual_salary_k=col(source(s), name("annual_salary_k"))
  GUIDE: axis(dim(1), label("Gross annual salary (USD thousands)"))
  GUIDE: axis(dim(2), label("Frequency"))
  GUIDE: text.title(label("Histogram of Gross annual salary (USD thousands)"))
  ELEMENT: interval(position(summary.count(bin.rect(annual_salary_k))), 
    shape.interior(shape.square))
END GPL.

* /Graph-2b/

* Chart Builder.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=region COUNT()[name="COUNT"] MISSING=LISTWISE 
    REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE
  /FRAME OUTER=NO INNER=NO
  /GRIDLINES XAXIS=NO YAXIS=YES
  /STYLE GRADIENT=NO.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: region=col(source(s), name("region"), unit.category())
  DATA: COUNT=col(source(s), name("COUNT"))
  GUIDE: axis(dim(1), label("Office location type (Urban/Suburban/Rural)"))
  GUIDE: axis(dim(2), label("Percent"))
  GUIDE: text.title(label("Bar chart of Office location type (Urban/Suburban/Rural)"))
  SCALE: linear(dim(2), include(0))
  ELEMENT: interval(position(summary.percent(region*COUNT, base.all(acrossPanels()))), 
    shape.interior(shape.square))
END GPL.

* /Graph-2c/

* Chart Builder.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=region annual_salary_k MISSING=LISTWISE 
    REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE
  /FRAME OUTER=NO INNER=NO
  /GRIDLINES XAXIS=NO YAXIS=YES
  /STYLE GRADIENT=NO.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: region=col(source(s), name("region"), unit.category())
  DATA: annual_salary_k=col(source(s), name("annual_salary_k"))
  DATA: id=col(source(s), name("$CASENUM"), unit.category())
  COORD: transpose()
  GUIDE: axis(dim(1), label("Office location type (Urban/Suburban/Rural)"))
  GUIDE: axis(dim(2), label("Gross annual salary (USD thousands)"))
  GUIDE: text.title(label("Boxplot of Gross annual salary (USD thousands) split by Office location type (Urban/Suburban/Rural)"))
  SCALE: linear(dim(2), include(0))
  ELEMENT: schema(position(bin.quantile.letter(region*annual_salary_k)), label(id))
END GPL.

* /Graph-2d_1/

* Chart Builder.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=education_years annual_salary_k MISSING=LISTWISE 
    REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE
  /FITLINE TOTAL=YES SUBGROUP=NO
  /FRAME OUTER=NO INNER=NO
  /GRIDLINES XAXIS=NO YAXIS=YES
  /STYLE GRADIENT=NO.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: education_years=col(source(s), name("education_years"))
  DATA: annual_salary_k=col(source(s), name("annual_salary_k"))
  GUIDE: axis(dim(1), label("Total years of completed formal education (Years)"))
  GUIDE: axis(dim(2), label("Gross annual salary (USD thousands)"))
  GUIDE: text.title(label("Scatter Plot of Gross annual salary (USD thousands) by Total years of ",
    "completed formal education (Years)"))
  ELEMENT: point(position(education_years*annual_salary_k))
END GPL.

* /Graph-2d_2/

* Chart Builder.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=experience_years annual_salary_k MISSING=LISTWISE 
    REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE
  /FITLINE TOTAL=YES SUBGROUP=NO
  /FRAME OUTER=NO INNER=NO
  /GRIDLINES XAXIS=NO YAXIS=YES
  /STYLE GRADIENT=NO.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: experience_years=col(source(s), name("experience_years"))
  DATA: annual_salary_k=col(source(s), name("annual_salary_k"))
  GUIDE: axis(dim(1), label("Total years of professional work experience (Years)"))
  GUIDE: axis(dim(2), label("Gross annual salary (USD thousands)"))
  GUIDE: text.title(label("Scatter Plot of Gross annual salary (USD thousands) by Total years of ",
    "professional work experience (Years)"))
  ELEMENT: point(position(experience_years*annual_salary_k))
END GPL.

* /Graph-2d_3/

* Chart Builder.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=training_hours annual_salary_k MISSING=LISTWISE 
    REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE
  /FITLINE TOTAL=YES SUBGROUP=NO
  /FRAME OUTER=NO INNER=NO
  /GRIDLINES XAXIS=NO YAXIS=YES
  /STYLE GRADIENT=NO.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: training_hours=col(source(s), name("training_hours"))
  DATA: annual_salary_k=col(source(s), name("annual_salary_k"))
  GUIDE: axis(dim(1), label("Company-funded training received in the last 12 months (Hours)"))
  GUIDE: axis(dim(2), label("Gross annual salary (USD thousands)"))
  GUIDE: text.title(label("Scatter Plot of Gross annual salary (USD thousands) by Company-funded ",
    "training received in the last 12 months (Hours)"))
  ELEMENT: point(position(training_hours*annual_salary_k))
END GPL.

* /Task 3/

* /Main Table/

CORRELATIONS
  /VARIABLES=age education_years experience_years training_hours annual_salary_k
  /PRINT=TWOTAIL NOSIG FULL
  /MISSING=PAIRWISE.
 
* /Correlation Matrix/

CORRELATIONS
  /VARIABLES=age education_years experience_years training_hours annual_salary_k
  /PRINT=TWOTAIL NOSIG LOWER
  /MISSING=PAIRWISE.

OUTPUT MODIFY
  /SELECT TABLES
  /IF COMMANDS=["Correlations(LAST)"]
    SUBTYPES=["Correlations"]
  /TABLECELLS SELECT=[SIGNIFICANCE COUNT]
             SELECTDIMENSION=ROWS
             APPLYTO=ROW
             HIDE=YES
/TABLECELLS
      SELECT=[TITLE]
      REPLACE="Pearson Correlation Matrix"
 /TABLECELLS
    SELECT=["CORRELATION"]
    SELECTDIMENSION=ROWS
    APPLYTO=ROWHEADER
    HIDE=YES.

* /Task 4/

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS CI(95) R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT annual_salary_k
  /METHOD=ENTER education_years experience_years training_hours.

* Comment-1: These three factors (formal education, years of professional work experience, and hours of company-funded training) together account for 56.1% of the variation in salary, which we found from the value of R square.
* Comment-2: The estimated change in annual salary associated with one additional year of education, holding experience and training constant is 1895 USD on average.
* Comment-3: The estimated change in annual salary associated with one additional year of experience, holding year of education and training constant is 1217 USD on average.
* Comment-4: From regression analysis, we can see that the estimated change in annual salary associated with one additional hour of company-funded training, holding other factors constant is 76 USD on average.
* For this specific factor, t(246) = 2.604, p = .010, which is statistically significant at 5% level of significance.
* Thus we can conclude that, even though the increase in salary for one additional hour of company-funded training isn't that much compared to one unit of change in other factors, it's still statistically significant.
* Which means the money currently spent on training is associated with measurably higher pay.


SAVE OUTFILE='E:\Statistical Softwares\SPSS\CUSPC-SPSS\Assignments\Assignment-2\Assignment-2_Dataset.sav'
  /COMPRESSED.
