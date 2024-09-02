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
