rm(list=ls())
Data = read.table("https://faculty.mccombs.utexas.edu/carlos.carvalho/teaching/SalaryData.txt",header=T)
attach(Data)

plot(Gender,Salary,col=4,lwd=1.5,main="Salary Data")

plot(YrHired,Salary,xlab="Year Hired")
points(YrHired[Gender=="Male"],Salary[Gender=="Male"],col=4,pch=19)
points(YrHired[Gender=="Female"],Salary[Gender=="Female"],col=2,pch=19)

model1 = lm(Salary~Gender,data=Data)

model2 = lm(Salary~Gender+YrHired,data=Data)
plot(YrHired,Salary,xlab="Year Hired")
abline(coef=model2$coef[c(1,3)],col=2,lwd=2)
points(YrHired[Gender=="Female"],Salary[Gender=="Female"],col=2,pch=19)
abline(coef=c(model2$coef[1]+model2$coef[2],model2$coef[3]),col=4,lwd=2)
points(YrHired[Gender=="Male"],Salary[Gender=="Male"],col=4,pch=19)


model3 = lm(Salary~Gender*YrHired,data=Data) 
plot(YrHired,Salary,xlab="Year Hired")
abline(coef=model3$coef[c(1,3)],col=2,lwd=2)
points(YrHired[Gender=="Female"],Salary[Gender=="Female"],col=2,pch=19)
abline(coef=c(model3$coef[1]+model3$coef[2],model3$coef[3]+model3$coef[4]),col=4,lwd=2)
points(YrHired[Gender=="Male"],Salary[Gender=="Male"],col=4,pch=19)





Exp = 95-YrHired

model4 = lm(Salary~Gender+Exp)
model5 = lm(Salary~Gender+Gender*Exp)

plot(Exp,Salary,xlab="Experience")
abline(coef=model4$coef[c(1,3)],col=2,lwd=2)
points(Exp[Gender=="Female"],Salary[Gender=="Female"],col=2,pch=19)
abline(coef=c(model4$coef[1]+model4$coef[2],model4$coef[3]),col=4,lwd=2)
points(Exp[Gender=="Male"],Salary[Gender=="Male"],col=4,pch=19)

plot(Exp,Salary,xlab="Experience")
abline(coef=model5$coef[c(1,3)],col=2,lwd=2)
points(Exp[Gender=="Female"],Salary[Gender=="Female"],col=2,pch=19)
abline(coef=c(model5$coef[1]+model5$coef[2],model5$coef[3]+model5$coef[4]),col=4,lwd=2)
points(Exp[Gender=="Male"],Salary[Gender=="Male"],col=4,pch=19)




### Housing example...

Data_MidCity = read.csv("https://faculty.mccombs.utexas.edu/carlos.carvalho/teaching/MidCity.csv",header=T)
attach(Data_MidCity)

Price = Price/1000
SqFt = SqFt/1000


MidCity = lm(Price~as.factor(Nbhd)+SqFt)
