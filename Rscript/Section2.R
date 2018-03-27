###
library(tidyquant)



### Function to get returns from Yahoo Finance...
##########################################################

get_returns <- function(stock.symbol,from="2007-01-01",to="2016-12-31",period="monthly") {
    stock.symbol %>%
        tq_get(get  = "stock.prices",
               from = from,
               to   = to ) %>%
        tq_transmute(select     = adjusted, 
                     mutate_fun = periodReturn, 
                     type       = "arithmetic", 
                     period     = period)
}



### Portfolio function (2 assets)
#################################
port = function(w1,w2,m1,m2,s1,s2,rho){
	
	cov = rho*s1*s2
	v1 = s1^2
	v2 = s2^2
	
	ss = sqrt((w1^2)*v1 + (w2^2)*v2 + 2*w1*w2*cov)
	mm = w1*m1 + w2*m2
	
	return(list(mm=mm,ss=ss))
	}




#### Getting data on VTI and VGLT

VTI = get_returns("VTI",from="2012-01-01",to="2017-07-31")
VGLT = get_returns("VGLT",from="2012-01-01",to="2017-07-31") 

m = c(mean(VTI$monthly.returns),mean(VGLT$monthly.returns)) 
v = c(var(VTI$monthly.returns),var(VGLT$monthly.returns)) 
s = sqrt(v)
rho = cor(VTI$monthly.returns,VGLT$monthly.returns)



weights=seq(0,1,by=0.01)
M = length(weights)

ef = matrix(0,M,2)
for(i in 1:M){
	
	aux = port(weights[i],1-weights[i],m[1],m[2],s[1],s[2],rho)
	ef[i,1] = aux$mm
	ef[i,2] = aux$ss
	}


sr = ef[,1]/ef[,2]
ind = which.max(sr)
weights[ind] ### optimal weight on VTI!!


plot(ef[,2]*100,ef[,1]*100,type='b',col=4,xlab="Standard Deviation",ylab="Average Return")
text(s[1]*100,m[1]*100,"VTI",col=2,cex=1.5)
text(s[2]*100,m[2]*100,"VGLT",col=2,cex=1.5)
points(s[1]*100,m[1]*100,pch=19,col=2)
points(s[2]*100,m[2]*100,pch=19,col=2)





###### Now a function for any two stocks...
maxSR = function(stock1="VTI",stock2="VGLT",from="2012-01-01",to="2016-12-31",period="monthly"){

ret1 = get_returns(stock1,from=from,to=to)
ret2 = get_returns(stock2,from=from,to=to) 

m = c(mean(ret1$monthly.returns),mean(ret2$monthly.returns)) 
v = c(var(ret1$monthly.returns),var(ret2$monthly.returns)) 
s = sqrt(v)
rho = cor(ret1$monthly.returns,ret2$monthly.returns)

weights=seq(0,1,by=0.01)
M = length(weights)

ef = matrix(0,M,2)
for(i in 1:M){
	
	aux = port(weights[i],1-weights[i],m[1],m[2],s[1],s[2],rho)
	ef[i,1] = aux$mm
	ef[i,2] = aux$ss
	}


sr = ef[,1]/ef[,2]
ind = which.max(sr)
optw = weights[ind] 


plot(ef[,2]*100,ef[,1]*100,type='b',col=4,xlab="Standard Deviation",ylab="Average Return")
text(s[1]*100,m[1]*100,stock1,col=2,cex=1.5)
text(s[2]*100,m[2]*100,stock2,col=2,cex=1.5)
points(s[1]*100,m[1]*100,pch=19,col=2)
points(ef[ind,2]*100,ef[ind,1]*100,col="magenta",pch=19,cex=2)
return(list(ef=ef,optimal=optw))

}


maxSR("C","AMZN",from="2010-01-01",to="2017-09-01")

###################################
## Sampling Distribution Simulation
###################################

X = VTI$monthly.returns*100
Xbar = mean(X)
sig = sd(X)
n = length(X)
M = 1000

xbar.i = rep(0,M)
for(i in 1:M){
	
	xbar.i[i] = mean(sample(X,size=n,replace=TRUE))

}

stderror = sqrt(sig^2/n)

quantile(xbar.i,c(0.025,0.975))

lower = Xbar-2*stderror
upper = Xbar+2*stderror

hist(xbar.i,prob=T)
lines(seq(0,2.3,by=0.01),dnorm(seq(0,2.3,by=0.01),Xbar,stderror),col="green",lwd=2)
segments(lower,.4,upper,.4,col=2,lwd=2,lty=1)
text(lower,0.43,round(lower,2),col=2,cex=1.5)
text(upper,0.43,round(upper,2),col=2,cex=1.5)




### Let's go back to the retirement example:

SP500 = get_returns("^GSPC",from="1950-01-01",to="2016-12-31",period="yearly")
m = mean(SP500$yearly.returns)*100 
s = sd(SP500$yearly.returns)*100

M = 1000
t = 20

s.e = sqrt(s^2/dim(SP500)[1])
mus = rnorm(M*t,m,s.e)
ret = matrix(rnorm(M*t,mus,s),t,M)
fac = 1+ ret/100
tot = apply(fac,2,prod)

ex = mean(tot)
med = median(tot)

sum(tot>1.02^t)/M ## Probability of beating a fixed income investment.



plot(density(tot,bw=0.6),main="Total wealth in 20 years",xlab="$$",ylab="",lwd=2)
abline(v=ex,lwd=2,lty=2,col=2)
abline(v=med,lwd=2,lty=2,col=4)
legend(11,0.2,c(paste("mean","(",round(ex,2),")"),paste("median","(",round(med,2),")")),col=c(2,4),lwd=c(2,2),lty=c(2,2))















