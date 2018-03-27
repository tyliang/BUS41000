## Section 3 
###################################


## We are starting linear regression... the main function that we
# will use over and over again is lm, which stands for "linear model"   


### House Data 
###############

Data = read.table("https://faculty.mccombs.utexas.edu/carlos.carvalho/teaching/housedata.txt",header=T) # read in the data...

names(Data)

attach(Data) # allow us to freely use the names inside of Data 

plot(Size,Price)

plot(Size,Price,pch=19,col=4) 
## I just changed some characteristics of the plot

lm(Price~Size) ## run a regression

model = lm(Price~Size) ## Save the all the regression output into the variable "model"

names(model)
summary(model)


#############################################################

#############################################
# Baseball Examples                         #
#############################################

DataBaseball = read.table("https://faculty.mccombs.utexas.edu/carlos.carvalho/teaching/RunsPerGame.txt",header=T)
attach(DataBaseball)

summary(League)


modelAVG = lm(R.G ~ AVG)

modelSLG = lm(R.G ~ SLG)

modelOBP = lm(R.G ~ OBP)

summary(modelAVG)


plot(AVG,R.G,pch=19,cex=1.5,xlab="AVG",ylab = "Runs per Game")
abline(modelAVG$coef[1],modelAVG$coef[2],col=2,lwd=2)

plot(SLG,R.G,pch=19,cex=1.5,xlab="SLG",ylab = "Runs per Game")
abline(modelSLG$coef[1],modelSLG$coef[2],col=2,lwd=2)

plot(OBP,R.G,pch=19,cex=1.5,xlab="OBP",ylab = "Runs per Game")
abline(modelOBP$coef[1],modelOBP$coef[2],col=2,lwd=2)

## Confidence intervals...

confint(model)

confint(model,level=0.95)

confint(model,level=0.99)

confint(model,level=0.75)

### Making predictions

Xfuture <- data.frame(Size=seq(0,8,by=0.01))


Future1 = predict(model, Xfuture, interval = "prediction",se.fit=T)
Future2 = predict(model, Xfuture, interval = "prediction",se.fit=T,level=0.99)


plot(Size,Price,xlim=c(0,8),ylim=range(Future1$fit),pch=19,cex.lab=1.3)
abline(lsfit(Size,Price),lwd=2,col=2)
lines(Xfuture$Size,Future1$fit[,2],col=4,lwd=2,lty=2)
lines(Xfuture$Size,Future1$fit[,3],col=4,lwd=2,lty=2)



