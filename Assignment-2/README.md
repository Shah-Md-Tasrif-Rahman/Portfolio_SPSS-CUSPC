
# Assignment 2

## Overview
This project uses a dataset of a fictional technology services company (Nexus Solutions Ltd.), which contains sample data of 250 employees, their age, education and experience years, company-funded training time, region, and their gross annual salary.

## Research Question
There is an upcoming board meeting to be held where a few decisions are to be made:
1. Whether to pay the employees to take formal training related to their responsibilities, so that the employees can become more productive and earn more. If evidence shows that having formal training increases employees’ pay then the company will invest on the employees.

2. The board also want to know whether employees with more experience and formal education are earning more in the company.

## Variables

|Variable|Description|Unit|Level|
|:---|:---|:---|:---|
|employee_id|Anonymised employee identifier|—|Nominal|
|age|Age at time of extract|Years|Scale|
|education_years|Total years of completed formal education|Years|Scale|
|experience_years|Total years of professional work experience|Years|Scale|
|training_hours|Company-funded training received in the last 12 months|Hours|Scale|
|region|Office location type|Urban/Suburban/Rural|Nominal|
|annual_salary_k|Gross annual salary|USD thousands|Scale|

## Results

#### Descriptive statistics

| Variable | Complete cases (n) | Minimum | Maximum | Mean | Median | Standard Deviation |
|----------|-------------------:|--------:|--------:|-----:|-------:|-------------------:|
| Age at time of extract (Years) | 250 | 22 | 46 | 30 | 30 | 6 |
| Total years of completed formal education (Years) | 250 | 10.1 | 21.7 | 16.1 | 16.3 | 2.3 |
| Total years of professional work experience (Years) | 250 | .0 | 19.6 | 7.7 | 7.7 | 4.9 |
| Company-funded training received in the last 12 months (Hours) | 250 | 0 | 75 | 31 | 31 | 15 |
| Gross annual salary (USD thousands) | 250 | 37.2 | 87.4 | 61.8 | 61.7 | 10.1 |

#### Pearson correlation matrix

| Variable | Age at time of extract (Years) | Total years of completed formal education (Years) | Total years of professional work experience (Years) | Company-funded training received in the last 12 months (Hours) | Gross annual salary (USD thousands) |
|----------|:------------------------------:|:-------------------------------------------------:|:---------------------------------------------------:|:--------------------------------------------------------------:|:-----------------------------------:|
| Age at time of extract (Years) | -- | | | | |
| Total years of completed formal education (Years) | .420** | -- | | | |
| Total years of professional work experience (Years) | .785** | .007 | -- | | |
| Company-funded training received in the last 12 months (Hours) | .098 | -.031 | .126* | -- | |
| Gross annual salary (USD thousands) | .624** | .425** | .609** | .173** | -- |

**. Correlation is significant at the 0.01 level (2-tailed).

*. Correlation is significant at the 0.05 level (2-tailed).

#### Regression model summary

| R | R Square | Adjusted R Square | Std. Error of the Estimate |
|:---:|:---------:|:------------------:|:---------------------------:|
| .749ᵃ | .561 | .555 | 6.7495 |

a. Predictors: (Constant), Company-funded training received in the last 12 months (Hours), Total years of completed formal education (Years), Total years of professional work experience (Years)

#### Regression coefficients

| Predictor | B | Std. Error | Beta | t | Sig. | 95% CI Lower Bound | 95% CI Upper Bound |
|----------|---:|-----------:|-----:|---:|:----:|-------------------:|-------------------:|
| (Constant) | 19.541 | 3.266 | | 5.983 | < .001 | 13.108 | 25.974 |
| Total years of completed formal education (Years) | 1.895 | .189 | .425 | 10.038 | < .001 | 1.523 | 2.267 |
| Total years of professional work experience (Years) | 1.217 | .088 | .592 | 13.899 | < .001 | 1.044 | 1.389 |
| Company-funded training received in the last 12 months (Hours) | .076 | .029 | .111 | 2.604 | .010 | .018 | .133 |

a. Dependent Variable: Gross annual salary (USD thousands)

## Visualizations

#### Gross annual salary distribution
![Gross_annual_salary_histogram](./Graphs%20and%20tables/Gross_annual_salary_histogram.png)

#### Office location distribution bar chart
![Office_location_barplot](./Graphs%20and%20tables/Office_location_barplot.png)

#### Salary by office location boxplot
![Boxplot](./Graphs%20and%20tables/Boxplot.png)

#### Salary and training hours scatter plot
![Salary_vs_training_scatterplot](./Graphs%20and%20tables/Salary_vs_training_scatterplot.png)

## Conclusion
For the regression model, these three factors (formal education, years of professional work
experience, and hours of company-funded training) together account for `56.1% of the variation` in salary, which we found from the value of R square. And, we can see that the estimated change in annual salary associated with one additional hour of company-funded training, holding other factors constant is `76 USD on average`. For this specific factor, `t(246) = 2.604, p = .010`, which is `statistically significant at 5% level of significance`.

- For the **1st research question**, we can conclude that, even though the increase in salary for one additional hour of company-funded training isn't that much compared to one unit of change in other factors, it's still statistically significant. Which means the money currently spent on training is associated with measurably higher pay. **Based on this evidence, the company may consider continuing or expanding its training investment, although a causal assessment would require further analysis.**

- For the **2nd research question**, from the regression model, the estimated change in annual salary associated with one additional year of education, holding experience and training constant is `1895 USD on average`, and the estimated change in annual salary associated with one additional year of experience, holding year of education and training constant is `1217 USD on average`. **So this means that higher levels of formal education and professional experience are positively associated with salary in this sample.**

## Full Report

[View the HTML report](use the modified github link here using htmlpreview.github.io)

[View the PDF report](./Final%20Output/assignment2_output_Shah_Md._Tasrif_Rahman.pdf)
