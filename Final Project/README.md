
# Final Project

## Overview
This project uses a [modified Telco Customer Churn dataset (initially provided by IBM)](https://www.kaggle.com/datasets/jethwaaatmik/telco-customer-churn-dataset/) to examine patterns associated with whether a customer has left the company (customer churn). The raw CSV file contained 7,043 customer records with 21 variables, including demographic characteristics, service variables, contract and payment information, continuous variables related to charges, and the binary churn outcome.

## Research Question and Hypotheses
1.  **(Primary)**: Is customer tenure associated with customer churn?
    -   H<sub>0</sub>: The distributions of customer tenure are the same for customers who were retained and customers who churned.
    -   H<sub>1</sub>: The distributions of customer tenure differ between customers who were retained and customers who churned.
2.  Are contract type and customer churn associated?
    -   H<sub>0</sub>: Contract type and customer churn are independent.
    -   H<sub>1</sub>: Contract type and customer churn are not independent, thus are associated.
3.  Which customer characteristics are associated with the odds of customer churn?
    -   H<sub>0</sub>: None of the selected customer characteristics is associated with the odds of customer churn; all corresponding regression coefficients are zero.
    -   H<sub>1</sub>: At least one selected customer characteristic is associated with the odds of customer churn; at least one regression coefficient differs from zero.

## Methods

#### Dataset Selection

This dataset was chosen because it meets all the criteria given for this project which are as follows:

-   At least 6 usable variables, with a mix of categorical and continuous types.
-   At least 150 cases (rows).
-   Contains one binary/categorical outcome suitable for logistic regression, and at least one continuous variable suitable for a t-test/ANOVA and for correlation or linear regression.
-   Publicly available and properly citable. Should not contain any personally identifying information such as phone number, name, etc.
-   Some realistic data issues to clean (missing values, inconsistent coding, or duplicates) that will help demonstrate data cleaning skill.

#### Data Management and Cleaning

The raw CSV file was imported directly into SPSS and preserved as the source data. During the initial inspection, blank string values in gender, Partner, InternetService, and StreamingTV were not initially treated by SPSS as missing observations. These blank strings were therefore declared as user-missing values in SPSS. Numeric missing values already imported as system-missing were retained.

The dataset was checked for duplicate observations. No duplicate cases were identified, thus no records were removed for duplication.

All 7,043 observations were retained in the final dataset; individual analyses used the available cases required for their respective variables.

The variable “Churn” was recoded into a binary analysis variable, with 0 representing retained customers and 1 representing churned customers. Categorical variables were defined with appropriate value labels and measurement levels.

#### Statistical Analysis

Descriptive statistics were produced for the available variables. Categorical variables were summarized using frequencies and percentages, whereas continuous variables were summarized using the mean, standard deviation, median, minimum, and maximum.

For the first or primary research question, customer tenure distributions were examined within churn groups using histograms, Q-Q plots, and normality tests. Because the distributions departed from normality, a Mann-Whitney U test was used to compare tenure between retained and churned customers.

For the second research question, a Pearson chi-square test of independence was used to examine the association between contract type and customer churn. Cramer's V was reported as effect-size measure, and expected cell counts were checked.

For the third research question, binary logistic regression was used with Churn as the dependent/target variable. Churn was recoded into a usable binary variable for this process. Predictors were selected based on their relevance to the target variable and their representation of different aspects of the customer relationship.

The initial model included the predictors: tenure, MonthlyCharges, Contract, TechSupport, InternetService, and PaymentMethod. This model was specified with 11 expected predictor degrees of freedom. SPSS identified redundancy among the categorical predictors and reduced the estimable degrees of freedom to 10. Two reduced models were therefore examined to solve this issue, retaining either InternetService or TechSupport.

The model retaining InternetService showed evidence of lack of fit according to the Hosmer-Lemeshow test, `χ²(8) = 17.656, p = .024`. The model retaining TechSupport showed no statistically significant evidence of lack of fit, `χ²(8) = 11.632, p = .168`. The latter was therefore selected as the final model. The final binary logistic regression model included the predictors: tenure, MonthlyCharges, PaymentMethod, Contract, and TechSupport.

Relevant graphs were produced accordingly to support the research questions.

## Variables

| **Variable** | **Description** | **Unit** | **Measure** |
| --- | --- | --- | --- |
| customerID | Unique identifier for each customer |     | Nominal |
| gender | Customer gender: Male/Female |     | Nominal |
| SeniorCitizen | Indicates if the customer is a senior citizen (0 = No, 1 = Yes) |     | Nominal |
| Partner | Whether the customer has a partner |     | Nominal |
| Dependents | Whether the customer has dependents |     | Nominal |
| tenure | Number of months the customer has stayed with the company | Months | Scale |
| PhoneService | Whether the customer has phone service |     | Nominal |
| MultipleLines | Whether the customer has multiple lines |     | Nominal |
| InternetService | Customer's internet service provider (DSL, Fiber optic, No) |     | Nominal |
| OnlineSecurity | Whether the customer has online security |     | Nominal |
| OnlineBackup | Whether the customer has online backup |     | Nominal |
| DeviceProtection | Whether the customer has device protection |     | Nominal |
| TechSupport | Whether the customer has tech support |     | Nominal |
| StreamingTV | Whether the customer has streaming TV |     | Nominal |
| StreamingMovies | Whether the customer has streaming movies |     | Nominal |
| Contract | Type of contract: Month-to-month, One year, Two year |     | Nominal |
| PaperlessBilling | Whether the customer uses paperless billing |     | Nominal |
| PaymentMethod | Payment method (e.g., Electronic check, Mailed check, etc.) |     | Nominal |
| MonthlyCharges | Monthly charges | USD | Scale |
| TotalCharges | Total charges to date | USD | Scale |
| Churn | Whether the customer has left the company (Yes/No) |     | Nominal |

## Results

#### Descriptive statistics

| **Variable** | **Category** | **n** | **%** | **Mean (SD)** | **Median** | **Minimum** | **Maximum** |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Customer gender | Female | 3,091 | 49.12 |     |     |     |     |
|     | Male | 3,202 | 50.88 |     |     |     |     |
| Indicates if the customer is a senior citizen (0 = No, 1 = Yes) | No  | 5,901 | 83.79 |     |     |     |     |
|     | Yes | 1,142 | 16.21 |     |     |     |     |
| Whether the customer has a partner | No  | 3,115 | 51.55 |     |     |     |     |
|     | Yes | 2,928 | 48.45 |     |     |     |     |
| Whether the customer has dependents | No  | 4,933 | 70.04 |     |     |     |     |
|     | Yes | 2,110 | 29.96 |     |     |     |     |
| Number of months the customer has stayed with the company |     |     |     | 32.5 (24.5) | 29.0 | 0.0 | 72.0 |
| Whether the customer has phone service | No  | 682 | 9.68 |     |     |     |     |
|     | Yes | 6,361 | 90.32 |     |     |     |     |
| Whether the customer has multiple lines | No  | 3,390 | 48.13 |     |     |     |     |
|     | No phone service | 682 | 9.68 |     |     |     |     |
|     | Yes | 2,971 | 42.18 |     |     |     |     |
| Customer's internet service provider | DSL | 2,082 | 34.45 |     |     |     |     |
|     | Fiber optic | 2,660 | 44.02 |     |     |     |     |
|     | No  | 1,301 | 21.53 |     |     |     |     |
| Whether the customer has online security | No  | 3,498 | 49.67 |     |     |     |     |
|     | No internet service | 1,526 | 21.67 |     |     |     |     |
|     | Yes | 2,019 | 28.67 |     |     |     |     |
| Whether the customer has online backup | No  | 3,088 | 43.84 |     |     |     |     |
|     | No internet service | 1,526 | 21.67 |     |     |     |     |
|     | Yes | 2,429 | 34.49 |     |     |     |     |
| Whether the customer has device protection | No  | 3,095 | 43.94 |     |     |     |     |
|     | No internet service | 1,526 | 21.67 |     |     |     |     |
|     | Yes | 2,422 | 34.39 |     |     |     |     |
| Whether the customer has tech support | No  | 3,473 | 49.31 |     |     |     |     |
|     | No internet service | 1,526 | 21.67 |     |     |     |     |
|     | Yes | 2,044 | 29.02 |     |     |     |     |
| Whether the customer has streaming TV | No  | 2,199 | 39.67 |     |     |     |     |
|     | No internet service | 1,198 | 21.61 |     |     |     |     |
|     | Yes | 2,146 | 38.72 |     |     |     |     |
| Whether the customer has streaming movies | No  | 2,785 | 39.54 |     |     |     |     |
|     | No internet service | 1,526 | 21.67 |     |     |     |     |
|     | Yes | 2,732 | 38.79 |     |     |     |     |
| Type of contract | Month-to-month | 3,875 | 55.02 |     |     |     |     |
|     | One year | 1,473 | 20.91 |     |     |     |     |
|     | Two year | 1,695 | 24.07 |     |     |     |     |
| Whether the customer uses paperless billing | No  | 2,872 | 40.78 |     |     |     |     |
|     | Yes | 4,171 | 59.22 |     |     |     |     |
| Payment method | Bank transfer (automatic) | 1,544 | 21.92 |     |     |     |     |
|     | Credit card (automatic) | 1,522 | 21.61 |     |     |     |     |
|     | Electronic check | 2,365 | 33.58 |     |     |     |     |
|     | Mailed check | 1,612 | 22.89 |     |     |     |     |
| Monthly charges |     |     |     | 64.88 (30.10) | 70.55 | 18.25 | 118.60 |
| Total charges to date |     |     |     | 2283.30 (2266.77) | 1397.48 | 18.80 | 8684.80 |
| Whether the customer has left the company | Customer retained | 5,174 | 73.46 |     |     |     |     |
|     | Customer churned | 1,869 | 26.54 |     |     |     |     |

#### Missing Data Summary

| **Variable** | **Missing (n)** | **Missing (%)** |
| --- | --- | --- |
| gender | 750 | 10.65 |
| Partner | 1,000 | 14.20 |
| tenure | 2,500 | 35.50 |
| InternetService | 1,000 | 14.20 |
| StreamingTV | 1,500 | 21.30 |
| MonthlyCharges | 1,500 | 21.30 |
| TotalCharges | 11  | 0.16 |

*Note.* Missing (%) represents the percentage of observations with missing data for each variable.

#### Tests of Normality for Customer Tenure by Churn Status

| **Customer Status** | ***n*** | **Kolmogorov-Smirnov *D*** | ***p*** | **Shapiro-Wilk *W*** | ***p*** |
| --- | --- | --- | --- | --- | --- |
| Customer retained | 3,352 | .094 | < .001 | .917 | < .001 |
| Customer churned | 1,191 | .185 | < .001 | .831 | < .001 |

*Note.* Dependent variable: Number of months the customer has stayed with the company. The Kolmogorov-Smirnov test uses the Lilliefors significance correction. For both retained and churned customers, the Kolmogorov-Smirnov and Shapiro-Wilk tests were statistically significant (*p* < .001), indicating deviations from normality.

#### Mann-Whitney U Test Comparing Customer Tenure by Churn Status

| **Churn status** | ***n*** | **Mean rank** |
| --- | --- | --- |
| Customer retained | 3,352 | 2,546.27 |
| Customer churned | 1,191 | 1,500.08 |
| Mann–Whitney *U* |     | 1,076,759 |
| *z* |     | −23.656 |
| *p* |     | < .001 |

*Note.* The dependent variable was customer tenure (number of months the customer stayed with the company), and the grouping variable was churn status.

#### Association Between Contract Type and Customer Churn Status

| **Customer Status** | **Month-to-month** | **One year** | **Two year** | **Total** |
| --- | --- | --- | --- | --- |
| Customer retained n (%) | 2,220 (57.3) | 1,307 (88.7) | 1,647 (97.2) | 5,174 (73.5) |
| Customer churned n (%) | 1,655 (42.7) | 166 (11.3) | 48 (2.8) | 1,869 (26.5) |
| Total n (%) | 3,875 (100.0) | 1,473 (100.0) | 1,695 (100.0) | 7,043 (100.0) |

| **Test Statistic** | **Value** |
| --- | --- |
| Pearson **χ²** | 1184.597 |
| df  | 2   |
| *N*   | 7,043 |
| *p*   | < .001 |
| Cramer's *V* | .410 |

*Note.* Customer churn status and contract type were significantly associated, χ²(2, *N* = 7,043) = 1184.597, *p* < .001, and** Cramer's *V* = .410.

#### Binary Logistic Regression Model Statistics

| **Statistic** | **Value** |
| --- | --- |
| Omnibus χ² (df) | 1291.125 (9), *p* < .001 |
| -2 Log Likelihood | 3936.103 |
| Cox & Snell *R²* | .247 |
| Nagelkerke *R²* | .362 |
| Hosmer-Lemeshow χ² (df) | 11.632 (8), *p* = .168 |
| Classification Accuracy | 79.2% |

*Note.* χ² = chi-square test statistic. Cox & Snell and Nagelkerke values represent pseudo-R² measures. The non-significant Hosmer-Lemeshow test provided no evidence of lack of fit. Classification accuracy represents the percentage of cases correctly classified using a cutoff value of .500. Classification performance was higher for customers who did not churn (89.6%) than for customers who churned (49.9%).

#### Regression Coefficients

| **Predictor** | ***B*** | **SE** | **Wald χ²** | **df** | ***p*** | **OR** | **95% CI for OR** |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Number of months the customer has stayed with the company | \-0.029 | 0.003 | 133.258 | 1   | < .001 | 0.971 | \[0.966, 0.976\] |
| Monthly charges | 0.022 | 0.002 | 95.177 | 1   | < .001 | 1.022 | \[1.017, 1.026\] |
| Payment method (Reference: Bank transfer \[automatic\]) |     |     | 32.633 | 3   | < .001 |     |     |
| Credit card (automatic) | \-0.049 | 0.137 | 0.127 | 1   | .721 | 0.952 | \[0.728, 1.246\] |
| Electronic check | 0.412 | 0.112 | 13.483 | 1   | < .001 | 1.510 | \[1.212, 1.881\] |
| Mailed check | \-0.120 | 0.136 | 0.781 | 1   | .377 | 0.887 | \[0.679, 1.158\] |
| Type of contract (Reference: Month-to-month) |     |     | 95.580 | 2   | < .001 |     |     |
| One year | \-0.869 | 0.124 | 49.299 | 1   | < .001 | 0.419 | \[0.329, 0.534\] |
| Two year | \-1.797 | 0.212 | 71.909 | 1   | < .001 | 0.166 | \[0.109, 0.251\] |
| Whether the customer has tech support (Reference: No) |     |     | 26.076 | 2   | < .001 |     |     |
| No internet service | \-0.466 | 0.174 | 7.142 | 1   | .008 | 0.628 | \[0.446, 0.883\] |
| Yes | \-0.470 | 0.102 | 21.078 | 1   | < .001 | 0.625 | \[0.511, 0.764\] |
| Constant | \-1.277 | 0.184 | 47.933 | 1   | < .001 | 0.279 |     |

*Note.* B = logistic regression model coefficient; SE = standard error; OR = odds ratio (Exp(B)); CI = confidence interval. Reference categories were **Bank transfer (automatic)** for payment method, **Month-to-month** for contract type, and **No** for tech support.

#### Binary Logistic Regression Model Selection

| **Model** | **Modification** | **H-L test χ²** | **df** | **p** | **Model Status** |
| --- | --- | --- | --- | --- | --- |
| Initial model | None | 5.454 | 8   | .708 | **Redundancy detected in predictors** |
| InternetService retained | TechSupport removed | 17.656 | 8   | .024 | **Evidence of lack of fit** |
| TechSupport retained | InternetService removed | 11.632 | 8   | .168 | **Final model retained** |

*Note.* Model selection was based on redundancy diagnostics and Hosmer-Lemeshow goodness-of-fit tests. The final model retained the variables: tenure, MonthlyCharges, PaymentMethod, Contract, and TechSupport. A non-significant Hosmer-Lemeshow test indicated adequate model fit.

## Visualizations

#### Distribution of customer churn status
![Churn_status_bar_chart](./Graphs%20and%20tables/Churn_status_bar_chart.png)

#### Distribution of customer tenure split by churn status
![Tenure_histogram](./Graphs%20and%20tables/Tenure_histogram.png)

#### Customer tenure boxplot
![Tenure_by_churn_boxplot](./Graphs%20and%20tables/Tenure_by_churn_boxplot.png)

#### Churn status by contract type
![Contract_type_by_churn](./Graphs%20and%20tables/Contract_type_by_churn.png)

#### Churn status by payment method
![Payment_method_by_churn](./Graphs%20and%20tables/Payment_method_by_churn.png)

#### Churn status by internet service type
![Internet_service_by_churn](./Graphs%20and%20tables/Internet_service_by_churn.png)

## Conclusion

The first research question examined the association between customer tenure and churn. The Mann-Whitney U test showed a statistically significant difference in tenure distributions between retained and churned customers. This finding suggests that **churned customers had substantially shorter tenure distributions than retained customers.**

The second research question examined the relationship between contract type and churn. **A significant association was found between the two variables**, `χ²(2, N = 7,043) = 1184.597, p <  .001, Cramer’s V = .410`. The observed churn rates differed considerably across contract categories: 42.7% among month-to-month customers, 11.3% among one-year customers, and 2.8% among two-year customers. These results indicate that churn status varied substantially across contract types. However, because this analysis is observational, these results indicate an association rather than a causal effect of contract type on churn.

The third research question examined several customer characteristics associated with the odds of churn using binary logistic regression. The final model included tenure, MonthlyCharges, PaymentMethod, Contract, and TechSupport and was statistically significant, `χ²(9) = 1291.125, p  < .001`. The model had a Nagelkerke pseudo-R² of .362, while the Hosmer-Lemeshow test was non-significant, `χ²(8) = 11.632, p = .168`, providing no evidence of lack of fit. **Tenure, MonthlyCharges, contract type, TechSupport, and one PaymentMethod (Electronic check) showed statistically significant associations with odds of customer churn.** In particular, longer tenure was associated with lower odds of churn, whereas higher MonthlyCharges were associated with higher odds of churn. Compared with month-to-month contracts, both one-year and two-year contracts were associated with lower estimated odds of churn. And compared to Bank transfer (automatic), only the Electronic check category was associated with significantly higher estimated odds of churn.

The findings from these three research questions are broadly consistent with one another. The descriptive statistics and inferential results indicate that customer relationship duration and contractual characteristics are closely related to churn status, while the logistic regression shows that several characteristics remain associated with churn when considered together.

Overall, the analysis provides evidence that customer tenure, contract type, services, billing, and payment characteristics are associated with customer churn in this dataset.

**Some limitations of this study are as follows:**

1.  The regression analysis included only 4,543 of the 7,043 observations because of missing tenure values, meaning that 35.5% of the records were not included in the multivariable regression analysis, which may affect the representativeness of the regression estimates.
2.  The dataset contains intentionally introduced missing values by the dataset author, so its data structure may not represent naturally occurring customer data.
3.  Although the binary logistic regression model correctly classified 79.2% of cases overall, it correctly identified retained customers more often (89.6%) than churned customers (49.9%). Therefore, overall accuracy alone does not represent performance equally across the two outcome groups.

## Full Report

[View the HTML report](https://htmlpreview.github.io/?https://github.com/Shah-Md-Tasrif-Rahman/Portfolio_SPSS-CUSPC/blob/main/Final%20Project/Final%20Output/Final%20Output.html)

[View the PDF report](./Final%20Output/Final%20Output.pdf)