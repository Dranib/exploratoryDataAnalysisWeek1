rm(list=ls())
library(dplyr)
library(lubridate)
# load data
# there are 2075260 observations on 9 variables
data<-read.table("household_power_consumption.txt",sep=";",header = TRUE)
#transform data lists into appropriate class (date, hours,numeric)
dataClean<-mutate(data,Date=dmy(Date))%>%mutate(Time=hms(Time))
# transfrom the other columns in Numeric
dataClean<-mutate(dataClean,Global_active_power=as.numeric(Global_active_power),Global_reactive_power=as.numeric(Global_reactive_power),Voltage=as.numeric(Voltage),Global_intensity=as.numeric(Global_intensity),Sub_metering_1=as.numeric(Sub_metering_1),Sub_metering_2=as.numeric(Sub_metering_2),Sub_metering_3=as.numeric(Sub_metering_3))

head(dataClean)
summary(dataClean)
# use understandable names for dubmeters
# names(dataClean)[7:9]<-c("Kitchen","Laundry","Electric")

# subset on relevant dates 2007-02-01 and 2007-02-02
dataClean<-subset(dataClean,Date>=ymd("2007-02-01") & Date<=ymd("2007-02-02") )
# dataClean2<-subset(dataClean,dataClean$Sub_metering_1>0)
png("Plot4.png", width = 480, height = 480)

#create 4 graphs 2 by 2
par(mfrow=c(2,2))

# top left
with(dataClean,plot(Date+Time,Global_active_power,ylab="Global Active Power (kilowatt)",type="l",xlab=""))

# top right
with(dataClean,plot(Date+Time,Voltage,ylab="Voltage",type="l",xlab="datetime"))


# bottom left

with(dataClean,plot(Date+Time,c(Sub_metering_1),ylab="Energy sub metering",type="l",xlab=""))
with(dataClean,lines(Date+Time,c(Sub_metering_2),col="red"))
with(dataClean,lines(Date+Time,c(Sub_metering_3),col="blue"))
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=rep(1,3))


# bottom right
with(dataClean,plot(Date+Time,Global_reactive_power,ylab="Global_reactive_power",type="l",xlab="datetime"))

dev.off()
