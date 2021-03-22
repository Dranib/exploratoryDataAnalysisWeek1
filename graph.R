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
names(dataClean)[7:9]<-c("Kitchen","Laundry","Electric")

# subset on relevant dates 2007-02-01 and 2007-02-02
dataClean<-subset(dataClean,Date>=ymd("2007-02-01") & Date<=ymd("2007-02-02") )

