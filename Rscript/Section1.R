#S&P500 Probabilities
######################################
m = 6
s = 15

pnorm(0,m,s)    ## Pr(SP500 < 0)

qnorm(0.02,m,s) ## Pr(SP500 < ?) = 0.02

#S&P500 Simulation
######################################


M = 1000
t = 20


ret = matrix(rnorm(M*t,m,s),t,M)
fac = 1+ ret/100
tot = apply(fac,2,prod)

ex = mean(tot)
med = median(tot)

sum(tot>1.02^t)/M ## Probability of beating a fixed income investment.

plot(density(tot,bw=0.6),main="Total wealth in 20 years",xlab="$$",ylab="",lwd=2)
abline(v=ex,lwd=2,lty=2,col=2)
abline(v=med,lwd=2,lty=2,col=4)
legend(11,0.2,c(paste("mean","(",round(ex,2),")"),paste("median","(",round(med,2),")")),col=c(2,4),lwd=c(2,2),lty=c(2,2))








