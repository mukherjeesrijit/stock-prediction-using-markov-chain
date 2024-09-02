# Stock Market Prediction Using Markov Chain

## Authors

- **Srijit Mukherjee**: Developed the algorithm and wrote the code
- **Pranjal Verma**: Applied the code on market data and reported the results

## Introduction

This project models stock market movements as a discrete state and discrete time Markov chain process. Daily stock data is used to estimate the transition probability matrix. Based on historical data, the behavior of stocks is analyzed to determine if their current movements align with expectations. The project also explores the significance of parameters by examining the best and worst stock market performances.

## Mathematical Formulation

A stock price is modeled as a real-valued continuous random variable \( X_t \) changing with time \( t \). To analyze the data, \( (X_t, X_{t-1}) \) is converted into a discrete random variable \( Y_t \) using the following definition:

**Equation 1:**

$$
Y_t =  \begin{cases}       
1 \text{ (up)} & X_t \geq 1.005 X_{t-1} \\
-1 \text{ (down)} & X_t \leq 1.005 X_{t-1} \\
0 \text{ (same)} & \text{otherwise}
\end{cases}
$$

The random variables \( Y_t \) are considered at discrete time points \( t_0 = 0, t_1 = 1, t_2 = 2, \cdots \).

## Assumptions

1. **Markov Property:** The stock price depends only on the recent past.
   $$P(Y_{n+1}=s \mid Y_{0}=y_{0}, Y_{1}=y_{1}, \ldots, Y_{n}=y_{n}) = P(Y_{n+1}=s \mid Y_{n}=y_{n})$$

2. **Time Homogeneity:** The transition probabilities remain constant over time.
   $$P(Y_{n+1}=j \mid Y_{n}=i) = P(Y_{1}=j \mid Y_{0}=i) = p_{ij}$$

## Transition Probability

The transition probability \( p_{ij} \) from state \( i \) to state \( j \) is represented in a transition matrix:

$$
\begin{array}{cccc}
& 1 \text{ (up)} & 0 \text{ (same)} & -1 \text{ (down)} \\
1 & p_{1,1} & p_{1,0} & p_{1,-1} \\
0 & p_{0,1} & p_{0,0} & p_{0,-1} \\
-1 & p_{-1,1} & p_{-1,0} & p_{-1,-1}
\end{array}
$$

## Data

Historical stock price data for \( n \) days is used. The values \( Y_0 = y_0, Y_1 = y_1, \cdots, Y_{n-1} = y_{n-1} \) are derived from the historical data.

## Estimation of Transition Probabilities

The transition probabilities \( \hat{p_{ij}} \) are estimated using:

$$
\hat{p_{ij}} = \frac{n_{ij}}{\sum_{i} n_{ij}}
$$

where \( n_{ij} \) is the number of times the stock transitions from state \( i \) to state \( j \).

## Steady State Probabilities

Steady state probabilities are calculated to understand the long-term behavior of the stock market. Stocks with higher probabilities in the "up" state are considered better performing.

## Exploratory Data Analysis

### Top 10 Best Performing Stocks

The steady state probabilities for the top 10 performing stocks are analyzed. The following table shows the probabilities:

$$
\begin{array}{cccc}
& 1 (\text{up}) & 0 (\text{same}) & -1 (\text{down}) \\
\text{Brightcom Groups} & 0.5369 & 0.1066 & 0.3566 \\
\text{Tata Tele} & 0.5241 & 0.0979 & 0.3780 \\
\text{RattanIndia Infra} & 0.5451 & 0.0779 & 0.3770 \\
\text{Adani Gas} & 0.4596 & 0.1960 & 0.3444 \\
\text{Saregama India} & 0.4659 & 0.2011 & 0.3330 \\
\text{Adani Transmission} & 0.5218 & 0.1306 & 0.3477 \\
\text{JSW Energy} & 0.4715 & 0.2004 & 0.3282 \\
\text{Borosil Renewables} & 0.4181 & 0.1272 & 0.4547 \\
\text{CG Power and Industrial Ltd.} & 0.5079 & 0.1267 & 0.3654 \\
\text{Trident Ltd.} & 0.4596 & 0.1581 & 0.3823 \\
\text{Average} & 0.4850 & 0.1370 & 0.3610
\end{array}
$$

### Bottom 10 Worst Performing Stocks

The steady state probabilities for the bottom 10 performing stocks are analyzed. The following table shows the probabilities:

$$
\begin{array}{cccc}
& 1 (\text{up}) & 0 (\text{same}) & -1 (\text{down}) \\
\text{AstraZeneca} & 0.2213 & 0.3893 & 0.3893 \\
\text{Alembic Pharma} & 0.3320 & 0.3072 & 0.3609 \\
\text{Granules India} & 0.3969 & 0.2049 & 0.3982 \\
\text{Biocon} & 0.3297 & 0.3221 & 0.3481 \\
\text{CreditAccess Grameen} & 0.3279 & 0.2541 & 0.4180 \\
\text{Aurobindo Pharma} & 0.3318 & 0.3008 & 0.3674 \\
\text{AmaraRaja Batteries} & 0.3156 & 0.3607 & 0.3238 \\
\text{Bayer Cropsc.} & 0.3288 & 0.3190 & 0.3522 \\
\text{Bandhan Bank} & 0.3837 & 0.2082 & 0.4082 \\
\text{Jubilant Life} & 0.3374 & 0.2520 & 0.4106 \\
\text{Average} & 0.3250 & 0.2870 & 0.3640
\end{array}
$$

## Predictive Data Analysis

A prediction model is applied to 30 random Indian companies' stock prices over 227 days. Predictions are compared with actual results for Day 228, the average of Day 228 and 229, and the average of the next 7 days.

## Conclusion

The algorithm achieves a prediction accuracy of 50% for the next day and the average of the next two days. For the average over the next week, accuracy is around 46.7%. This indicates that even a 50% prediction accuracy is considered effective for stock market investments.

The analysis provides insights into which stocks are likely to perform well or poorly based on steady state probabilities.

## Code Example

```r
stockname = read.csv("COMPANYNAME.csv")
data = as.numeric(unlist(stockname))
difference = diff(data)
d = 100*(difference/data[-length(data)]) # Relative difference
# D = abs(d) # Percentage change
# sorted = sort(D) # Sort
# We take top 0.5% change as same 
# Hit...
