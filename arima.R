data <- read.csv(file = "/Users/Jing/Documents/DataScience/springboard/Capstone2/AirQualityUCI/AirQuality_processed.csv", sep = ',', header = TRUE)
#load xts
library(xts)
#view the structure of data
str(data)
#convert X to POSIXlt
t <- as.POSIXct(data$X, tz = "CEST", format = "%Y-%m-%d %H:%M:%S")
#create CO as an xts object for S1
CO <- xts(x = data$S1, order.by = t)
#plots
plot(CO)
#load astsa
install.packages("astsa")
library(astsa)
acf2(CO)
#from acf2 plots, it shows seasonal pattern
#for seasonal part, ACF tails off, PACf cuts at lags=2
#for nonseasonal part, ACF tails off, PACF cuts at lags=2 
fitCO <- sarima(CO, 2,0,0,1,0,0,24)
print(fitCO)
fit2CO <- sarima(CO, 2,0,0,1,0,1,24)
print(fit2CO)
fit3CO <- sarima(CO, 2,1,0,1,0,1,24)
print(fit3CO)
fit4CO <- sarima(CO, 1,0,0,1,0,1,24)
print(fit4CO)
fit5CO <- sarima(CO, 1,0,0,0,1,1,24)
print(fit5CO)
fit6CO <- sarima(CO, 1,0,0,1,1,1,24)
print(fit6CO)
#best so far
fit7CO <- sarima(CO, 2,0,0,1,1,1,24)
print(fit7CO)
fit8CO <- sarima(CO, 2,0,0,2,1,0,24)
print(fit8CO)
#predic with the best fitted model
sarima.for(CO, n.ahead = 24, 2,0,0,1,1,1,24)

