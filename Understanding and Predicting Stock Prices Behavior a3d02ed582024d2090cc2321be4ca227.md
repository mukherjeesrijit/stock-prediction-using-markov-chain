# Understanding and Predicting Stock Prices Behavior using Markov Chain

Authors: 

- Srijit Mukherjee (developed the algorithm, and wrote the code)
- Pranjal Verma (applied the code on market data, and reported the results),

# Theory

## Introduction

Here, the stock market movement is modelled as a discrete state and discrete time markov chain process. I take daily data to get an estimate of the unknown paramaters of the transition probability matrix. Then, based on the past data, I try to understand whether the behaviour of the stock is behaving as expected by taking the recent data. I also explore the meaning of the parameters based on the data of the best and the worst stock market movements.

## Mathematical Formulation

I model a single stock price as a real valued continuous random variable $X_t$ which is changing with time $t.$

I will convert $(X_t,X_{t-1})$ into a discrete random variable in the following manner.

Define the following **equation 1**

$$
Y_t =  \begin{cases}       1 (up) & X_t \geq 1.005 X_{t-1} \\
      -1 (down)& X_t \leq 1.005 X_{t-1} \\
      0(same)& otherwise 
   \end{cases}
$$

A real valued discrete random variable $Y_t$ is formed which is changing with time $t.$

I will consider the random variables $Y_t$ at discrete time points $t_0 = 0, t_1 = 1, t_2 = 2, \cdots$

## Assumptions

I have assumed the following conditions on the random variables $Y_0, Y_1, Y_2, Y_3, \cdots$

- $P\left(Y_{n+1}=s \mid Y_{0}=y_{0}, Y_{1}=y_{1}, \ldots, Y_{n}=y_{n}\right)=P\left(Y_{n+1}=s \mid Y_{n}=y_{n}\right)$

The first condition means, that the stock price is dependent on the just recent past only. This is known as Markov Property.

- $P\left(Y_{n+1}=j \mid Y_{n}=i\right)=P\left(Y_{1}=j \mid Y_{0}=i\right)$ = $p_{ij}$

The second condition means that over the change of the stock market from one state to another on an average remains same all over the time. This is known as time homogenous property.

## Transition Probability

$p_{ij}$, as defined above is called the Transition Probability from $i \rightarrow j$. Considering all the probabilities, I can represent them in a matrix called Transition Matrix.

$$
\begin{array}{cccc}
& 1   & 0   & -1 \\
1 & p_{1,1} & p_{1,0} & p_{1,-1} \\
0 & p_{0,1} & p_{0,0} & p_{0,-1} \\
-1 & p_{-1,1}  & p_{-1,0}   & p_{-1,-1}   \\

\end{array}
$$

## Data

Now, I have taken data of past $n$ days on stock market prices, $X_0 = x_0, X_1 = x_1, X_2 = x_2, X_3 = x_3, \cdots, X_n = x_n$. 

From the definition [here](https://www.notion.so/010c18de3dbc448d8d8cb0d283ef5a14?pvs=21), I derive the values $Y_0 = y_0, Y_1 = y_1, Y_2 = y_2, Y_3 = y_3, \cdots, Y_{n-1} = y_{n-1}$.

## Estimation of the transition probabilities

Among these $Y_i$'s, I count the following:

$n_{ij}$ = number of $k$'s for which $Y_k$ goes from $i$ to $j$ in $Y_{k+1}$.

An estimate of $p_{ij}$, $\hat{p_{ij}}$ is given as $\frac{n_{ij}}{\sum_{i} n_{ij}}$, i.e. what proportion of times, $i \rightarrow j$ as the stock got out of state $i$.⁍

## Steady State Probabilities

Finally, the steady state probabilities of the stock market movement in the state space is calculated. Based on this, the long term behaviour of the stock market is understood. The steady state probabilities give an idea of how much a stock market movement is gonna stay in which state.

A stock market with more "Up" probability is expected to behave well than a stock market with more "Down" probability. 

A stock is predicted to be in a state based on which probability is the largest.

Let's explore that by certain examples.

# Exploratory Data Analysis 1

I analyze one year performance of certain stocks, and estimate the steady state probabilities. I try to understand the behaviour of the top 10 best and worst performing stocks, and whether it is matching with our intuition or not.

## Top 10 Best Performing Stocks

The top 10 best performing stocks are taken according to the [Economic Times](https://economictimes.indiatimes.com/).

Their steady state probabilities are given below. Let's try to understand.

$$
\begin{array}{cccc}
& 1 (\text{up})   & 0 (\text{same})   & -1 (\text{down}) \\
\text{Brightcom Groups} & \text{0.5368852} & \text{0.1065574} & \text{0.3565574} \\
\text{Tata Tele} & \text{0.5240686} & \text{0.09793022} & \text{0.3780012} \\

\text{RattanIndia Infra} & \text{0.545082}  & \text{0.07786885}   & \text{0.3770492}   \\

\text{Adani Gas} & \text{0.4596381}  & \text{0.1959862}   & \text{0.3443757}   \\

\text{Saregama India} & \text{0.4658994}  & \text{0.2010683}   & \text{0.3330323}   \\

\text{Adani Transmission} & \text{0.5217554}  & \text{0.1305535}   & \text{0.347691}   \\

\text{JSW Energy} &\text{0.4714983}  & \text{0.2003513}   & \text{0.3281505}   \\

\text{Borosil Renewables} & \text{0.4180799}  & \text{0.1271866}   & \text{0.4547335}   \\

\text{CG Power and Industrial Ltd.} & \text{0.507933}  & \text{0.1267109}   & \text{0.3653561}   \\

\text{Trident Ltd.} & \text{0.4596253}  & \text{0.158112}   & \text{0.3822627}  \\

\text{Average} & 
\text{0.485}  & 
\text{0.137}   & 
\text{0.361}  \\
\end{array}
$$

## Bottom 10 Worst Performing Stocks

The bottom 10 worst performing stocks are taken according to the [Economic Times](https://economictimes.indiatimes.com/).

Their steady state probabilities are given below. Let's try to understand.

$$
\begin{array}{cccc}
& 1 (\text{up})   & 0 (\text{same})   & -1 (\text{down}) \\
\text{AstraZeneca} & \text{0.2213115} & \text{0.3893443} & \text{0.3893443} \\
\text{Alembic Pharma} & \text{0.3319516} & \text{0.307185} & \text{0.3608635} \\
\text{Granules India} & \text{0.3968601}  & \text{0.2049129}   & \text{0.398227}   \\
\text{Biocon} & \text{0.3297225}  & \text{0.3221336}   & \text{0.348144}   \\
\text{CreditAccess Grameen} & \text{0.3278689}  & \text{0.2540984}   & \text{0.4180328}   \\
\text{Aurobindo Pharma} & \text{0.331836}  & \text{0.3007704}   & \text{0.3673936}   \\
\text{AmaraRaja Battries} &\text{0.3155738}  & \text{0.3606557}   & \text{0.3237705}   \\

\text{Bayer Cropsc.} & \text{0.3288216}  & \text{0.3189919}   & \text{0.3521865}   \\
\text{Bandhan Bank} & \text{0.3836735}  & \text{0.2081633}   & \text{0.4081633}   \\
\text{Jubilant Life} & \text{0.3373984}  & \text{0.2520325}   & \text{0.4105691}  \\

\text{Average} & 
\text{0.325}  & 
\text{0.287}   & 
\text{0.364}  \\
\end{array}
$$

## Observations

I get a really good observation. In both the worst performing stock markets and good performing stock markets, the down state has almost same stable state probabilities. The thing that is really making the difference is the distribution of the probabilities in the up state and the same state.

Good Stocks tend to be in the "up" zone more, relative to the same zone.

Bad Stocks tend to remain "neutral" zone, where they are equally distributed.

# Predictive Data Analysis 2

I have taken 30 random Indian companies's stock prices, and used 227 days as data to get an idea of the steady state behaviour, and predicted the outcome, based on the maximum probability in the steady state space.

I try to predict and see the prediction correctness based on the Day 228, Average of Day 228 and 229, and Average of the next 7 days.

## Behaviour of 30 Indian Companies' Stock Prices

$$
\begin{array}{ccccc}
& \text{Predicted}   & \text{Day 228}   & \text{Avg Next 2 Days} & \text{Avg 7 days} \\

\text{ACC} & \text{Up} & \text{Up} & \text{Up} & \text{Up} \\
\text{Adani Enterprise} & \text{Up} & \text{Up} & \text{Up} & \text{Up} \\

\text{Dabur} & \text{Same}  & \text{Same}   & \text{Same} & \text{Down}  \\
\text{Asian Paints} & \text{Up}  & \text{Down}   & \text{Down} & \text{Down}  \\
\text{Bajaj Finance} & \text{Up} &  \text{Up}   & \text{Up} & \text{Up}  \\

\text{Bajaj Finserv} & \text{Up}  & \text{Up}   & \text{Up} & \text{Up}  \\
\text{Britannia} & \text{Same}  & \text{Down}   & \text{Down}  & \text{Up} \\
\text{Dr Reddy} & \text{Up}  & \text{Down}   & \text{Down}  & \text{Down} \\

\text{GMR Infra} & \text{Down} & \text{Down} & \text{Down} & \text{Base}\\
\text{Grasim} & \text{Up} & \text{Up} & \text{Up} & \text{Up}\\
\text{HAL} & \text{Up}  & \text{Up}   & \text{Same} & \text{Down} \\
\text{HCL} & \text{Up}  & \text{Up}  & \text{Up}  & \text{Up} \\
\text{HDFC Bank} & \text{Up}  & \text{Down}   & \text{Same}  & \text{Down} \\
\text{Hindustan Unilever} & \text{Same}  & \text{Up}   & \text{Same}  & \text{Up} \\
\text{Infosys} & \text{Up}  & \text{Same}   & \text{Same}  & \text{Up} \\

\text{ITC} & \text{Same}  & \text{Down}   & \text{Down} & \text{Down}  \\
\text{Kotak Mahindra Bank} & \text{Up}  & \text{Same}   & \text{Up}  & \text{Up} \\
\text{LNT} & \text{Up}  & \text{Up}   & \text{Up} & \text{Up}  \\

\text{Mahindra and Mahindra} & \text{Up} & \text{Down} & \text{Down} & \text{Down}\\
\text{Marico} & \text{Same} & \text{Up} & \text{Up} & \text{Up}\\
\text{Page industries} & \text{Up}  & \text{Down}   & \text{Down}  & \text{Down} \\
\text{Pi industries} & \text{Up}  & \text{Up}   & \text{Up}   & \text{Up}\\
\text{Saregama} & \text{Up}  & \text{Down}   & \text{Up}  & \text{Up}\\
\text{Pidilite} & \text{Same}  & \text{Same}  & \text{Down} & \text{Down} \\
\text{Reliance} & \text{Same}  & \text{Down}   & \text{Down} & \text{Down}  \\

\text{Sun Pharma} & \text{Up}  & \text{Up}   & \text{Up} & \text{Up}  \\
\text{TCS} & \text{Up}  & \text{Down}  & \text{Down}  & \text{Same} \\
\text{TISCO- Tata Steel} & \text{Up}  & \text{Up}   & \text{Base}  & \text{Down} \\
\text{Vedanta} & \text{Up}  & \text{Up}   & \text{Up}  & \text{Up} \\
\text{Wipro} & \text{Up}  & \text{Down}  & \text{Down} & \text{Up}  \\

\end{array}
$$

## Observations

You can observe that this algorithm has predicted correctly 50% of the times for the next day and the average of the next two days based on 9.5 months of data. While it decreased a bit to 46.7% when I observe the average behaviour over the next week.

# Conclusion

It is told that if you know an algorithm in which you can predict the movement of stock atleast 51%, you will be a billionaire, because one can invest a lot of money and with 1% increase, the profit margin can be really high. So, if one gets a 50% predictability, then the algorithm is a fair and good algorithm.  I get a good idea of the behaviour of the best and worst behaving stocks, based on the stable state probabilities.

Now, given a stock, I can understand which stock I can safely invest in, and which stock not to invest in, so that the stock behaves good in the long run.

$$
\begin{array}{cccc}
&  \text{UP}   & \text{SAME}   &  \text{DOWN} \\
\text{UP} & \text{p}_{up,up} & \text{p}_{up,same} & \text{p}_{up,down} \\

\text{SAME} & \text{p}_{same,up}  & \text{p}_{same,same}   & \text{p}_{same,down}   \\

\text{DOWN} & \text{p}_{down,up}  & \text{p}_{down,same}   & \text{p}_{down,down}   \\

\end{array}
$$

```r
stockname = read.csv("COMPANYNAME.csv")
data = as.numeric(unlist(stockname))
difference = diff(data)
d = 100*(difference/data[-length(data)]) #relative difference
# D = abs(d) #percentage change
# sorted = sort(D) #sort
#We take top 0.5% change as same 
#hit = sorted[ceiling(0.1*length(D))] #top 10% mark of data
#Three states
# U (+1) - more positive than 0.5% increase
# S (0) - within 0.5% change
# D (-1) - more negative than 0.5% decrease
# U -> D : number of changes/total number of days
c = NULL
for (i in 1:length(d))
{
  if (d[i] > 0.5)
  {
    c[i] = 1
  }
  
  if (d[i] < -0.5)
  {
    c[i] = -1
  }
  
  if (d[i] < 0.5 &d[i] > -0.5)
  {
    c[i] = 0
  }
}
# {U,S,D}
# 
# U->U, U->S, U->D
# S->U, S->S, S->D
# D->U, D->S, D->D
# 
# UU = 0,1 = y = 4
# US = -1,1 = -x+y = 3
# UD = -2,1 = -2x+y = 2
# SU = 1,0 = x = 1
# SS = 0,0 = 0
# SD = -1,0 = -x = -1
# DU = +2,-1 = 2x-y = -2
# DS = 1,-1 = x-y = -3
# DD = 0,-1 = -y = -4
# 
# c
# diff(c)
x = 1
y = 4
a = c[-length(c)]*y
b = diff(c)*x
main = a+b
UU = sum(main == 4)
US = sum(main == 3)
UD = sum(main == 2)
SU = sum(main == 1)
SS = sum(main == 0)
SD = sum(main == -1)
DU = sum(main == -2)
DS = sum(main == -3)
DD = sum(main == -4)

numbers = c(UU,US,UD,SU,SS,SD,DU,DS,DD)
transition_matrix = c(UU/sum(numbers[1:3]),US/sum(numbers[1:3]),UD/sum(numbers[1:3]),
                      SU/sum(numbers[4:6]),SS/sum(numbers[4:6]),SD/sum(numbers[4:6]),
                      DU/sum(numbers[7:9]),DS/sum(numbers[7:9]),DD/sum(numbers[7:9]))
#state space
State = c("Up", "Same", "Down")
#transition matrix
ZoneTransition = matrix (transition_matrix, 
                         nrow=3, byrow=T, dimnames = list(State, State))
library(markovchain)
library(diagram)
#Diagram
plotmat(ZoneTransition, pos =c(1,2), lwd=1, box.lwd =1, cex.txt =0.5, box.size =0.1,
        box.type = "circle", box.prop =0.5, box.col = "light yellow", arr.length =.1, arr.width =.1,
        arr.type = "curved", self.cex =.4, self.shifty =-.01, self.shiftx=.13, main = "Transition Diagram")
#?plotmat
#creating the markov chain
StockMarket <- new("markovchain", states = State, byrow = T, transitionMatrix = ZoneTransition, name = "Driver Movement")
steadyStates(StockMarket)
v0 = c(⅓,⅓,⅓ )
v1 = v0*StockMarket
v1
v2 = v1*StockMarket
v2
v3 = v0*(Activity^3)
v3
```