#############################################
# Another Baseball Examples                 #
#############################################

Baseball = read.table("https://faculty.mccombs.utexas.edu/carlos.carvalho/teaching/RunsPerGame.txt",header=T)

model1 = lm(R.G ~ AVG + OBP, data=Baseball)

model2 = lm(R.G ~ SLG+ OBP,data=Baseball)

summary(model1)
summary(model2)

confint(model2)

#############################################
# Sales P1 and P2 Example                   #
#############################################

SalesData = read.csv("https://faculty.mccombs.utexas.edu/carlos.carvalho/teaching/PricesSales.csv",header=T)
names(SalesData)
attach(SalesData)

modelP1 = lm(Sales~p1)    # model with just p1
modelP2 = lm(Sales~p2)    # model with just p2
modelP1P2 = lm(Sales~p1+p2) # model with p1 and p2


plot(modelP1P2$fitted,Sales,pch=19,col="green",xlab="y.hat(MLR:p1 and p2)",ylab="y=Sales")
abline(0,1,col="blue",lwd=2)


par(mfrow=c(1,3)) # Set up a plotting window with 3 plots in one row...
plot(modelP1$fitted,Sales,pch=19,col="red",xlab="y.hat(SLR:p1)",ylab="y=Sales")
abline(0,1,col="blue",lwd=2)

plot(modelP2$fitted,Sales,pch=19,col="red",xlab="y.hat(SLR:p2)",ylab="y=Sales")
abline(0,1,col="blue",lwd=2)

plot(modelP1P2$fitted,Sales,pch=19,col="green",xlab="y.hat(MLR:p1 and p2)",ylab="y=Sales")
abline(0,1,col="blue",lwd=2)





