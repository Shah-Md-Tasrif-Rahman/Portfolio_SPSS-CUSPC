
# Assignment 3

## Overview
This project uses a dataset of a maternal and child health survey containing information on 400 mothers who had recently given birth, including the child's birth weight status (Normal or low weight), mother's age, number of antenatal care (ANC) visits during pregnancy, household wealth index, and place of residence.

*Note: The original dataset was provided as a .sav file and is included in the `SPSS Files` directory.*

## Research Question
1. Test whether the mean number of ANC visits differs between mothers living in rural and urban areas. State the null and alternative hypotheses, then run Independent-Samples T Test with anc_visits as the Test Variable and residence as the Grouping Variable (Define Groups: 0 and 1). Use Levene’s test to decide which row to read, complete Table 2, and write a one-sentence conclusion in APA style.

2. Fit a binary logistic regression predicting low birth weight from mother’s age, number of ANC visits, wealth index and residence. Explain the relationships between the independent variables and low birth weight.

## Variables

| Variable | Label | Values / Units | Measure |
|----------|-------|----------------|---------|
| mother_id | Mother identification number | Integer ID | Nominal |
| low_birth_weight | Baby born with low birth weight | 0 = Normal (≥2500 g); 1 = Low (<2500 g) | Nominal |
| mother_age | Mother’s age | Years | Scale |
| anc_visits | Number of antenatal care (ANC) visits during pregnancy | Count | Scale |
| wealth_index | Household wealth index | 1 = Poor; 2 = Middle; 3 = Rich | Ordinal |
| residence | Place of residence | 0 = Rural; 1 = Urban | Nominal |

## Results

#### Descriptive statistics

| Variable | Level / statistic | Percentage (%) | Mean (SD) | Median | Minimum | Maximum |
|----------|------------------|-----------------:|----------:|-------:|--------:|--------:|
| Low birth weight | Normal (≥2500 g) | 76.25% | — | — | — | — |
|  | Low (<2500 g) | 23.75% | — | — | — | — |
| Residence | Rural | 61.00% | — | — | — | — |
|  | Urban | 39.00% | — | — | — | — |
| Wealth index | Poor | 42.25% | — | — | — | — |
|  | Middle | 40.50% | — | — | — | — |
|  | Rich | 17.25% | — | — | — | — |
| Mother’s age (years) |  | — | 25.97 (4.70) | 26 | 16 | 39 |
| ANC visits |  | — | 4.64 (2.07) | 5 | 0 | 11 |

#### Group statistics for ANC visits by residence

| Residence group | n | Mean | Std. Deviation | Std. Error Mean |
|----------------|--:|-----:|---------------:|----------------:|
| Rural | 244 | 3.9713 | 1.88212 | 0.12049 |
| Urban | 156 | 5.6923 | 1.91637 | 0.15343 |

#### Independent-samples t-test results

| Independent-samples t-test statistic | Value |
|--------------------------------------|------:|
| Levene’s Test for Equality of Variances - F | .131 |
| Levene’s Test P-value | .717 |
| t | -8.857 |
| df | 398 |
| P-value | < .001 |
| Mean difference (Urban - Rural) | -1.721 |
| Std. error difference | 0.19431 |
| 95% Confidence Interval | [-2.10301, -1.33899] |

#### Omnibus tests of regression model coefficients

|| Chi-square | df | Sig. |
|------|-----------:|---:|:-----|
| Step | 50.129 | 5 | < .001 |
| Block | 50.129 | 5 | < .001 |
| Model | 50.129 | 5 | < .001 |

#### Binary logistic regression model summary

| -2 Log likelihood | Cox & Snell R Square | Nagelkerke R Square |
|------------------:|---------------------:|--------------------:|
| 388.416ᵃ | .118 | .177 |

a. Estimation terminated at iteration number 5 because parameter estimates changed by less than .001.

#### Hosmer and Lemeshow test

| Chi-square | df | Sig. |
|-----------:|---:|-----:|
| 5.653 | 8 | .686 |

#### Logistic regression coefficients

| Predictor | Estimate (B) | SE | Odds ratio [Exp(B)] | 95% CI for OR | p-value |
|-----------|-------------:|---:|------------------:|---------------|:-------:|
| Mother’s age | -.064 | .028 | .938 | [.888, .990] | .021 |
| ANC visits | -.244 | .070 | .783 | [.682, .899] | < .001 |
| Wealth index: Poor | — reference — | | | | |
| Wealth index: Middle | -.727 | .274 | .483 | [.282, .827] | .008 |
| Wealth index: Rich | -.923 | .434 | .397 | [.170, .929] | .033 |
| Residence: Rural | — reference — | | | | |
| Residence: Urban | -.656 | .311 | .519 | [.282, .955] | .035 |
| Constant | 2.126 | .787 | 8.378 | | .007 |

*Binary logistic regression predicting low birth weight (1 = Low).

## Visualizations
No visualizations were required for this project, so none are included.

## Conclusion
- **For the 1st research question**, in the independent-samples t-test:

H<sub>0</sub>: The mean number of ANC visits does not differ between mothers living in rural and urban areas. (μ<sub>1</sub> = μ<sub>2</sub>)

H<sub>1</sub>: The mean number of ANC visits differs between mothers living in rural and urban areas. (μ<sub>1</sub> ≠ μ<sub>2</sub>).

Then, an independent-samples t-test was conducted to compare the mean number of ANC visits between mothers living in rural and urban areas. There was a `significant difference` in the mean number of ANC visits for mothers living in rural areas `(M = 3.9713, SD = 1.88212)` and mothers living in urban areas `(M = 5.6923, SD = 1.91637)`, `t(398) = -8.857, p = < .001, d = 1.89553`.

- **For the 2nd research question**, a binary logistic regression was conducted to examine whether mother’s age, number of antenatal care (ANC) visits, household wealth index, and place of residence predicted whether the baby was born with low birth weight (1 = low, 0 = normal). Poor wealth status and rural residence were used as the reference categories for the categorical predictors.

`The overall model was statistically significant`, `χ²(5) = 50.129, p < .001, with a Nagelkerke R² of .177`, indicating that the model provided a pseudo-R² of `17.7%`. The `Hosmer–Lemeshow test was not significant`, `χ²(8) = 5.653, p = .686`, indicating `no evidence of lack of fit`.

Maternal age was significantly associated with low birth weight, `B = -0.064, SE = 0.028, OR = 0.938, 95% CI [0.888, 0.990], p = .021`, such that each additional year of maternal age was associated with a 6.2% decrease in the odds of low birth weight. ANC visits were also significantly associated with low birth weight, `B = -0.244, SE = 0.070, OR = 0.783, 95% CI [0.682, 0.899], p < .001`; each additional ANC visit was associated with a 21.7% decrease in the odds of low birth weight. Compared with mothers from poor households, those from middle-wealth households had 51.7% lower odds of low birth weight, `OR = 0.483, 95% CI [0.282, 0.827], p = .008`, while those from rich households had 60.3% lower odds, `OR = 0.397, 95% CI [0.170, 0.929], p = .033`. Finally, urban residence was associated with lower odds of low birth weight compared with rural residence, `OR = 0.519, 95% CI [0.282, 0.955], p = .035`. Overall, `greater maternal age, more ANC visits, higher household wealth, and urban residence were associated with lower odds of low birth weight.`

## Full Report

[View the HTML report](use the modified github link here using htmlpreview.github.io)

[View the PDF report](./Final%20Output/Assignment3_Shah%20Md.%20Tasrif%20Rahman.pdf)
