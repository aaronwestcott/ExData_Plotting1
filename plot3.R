fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL,"householdpower_consumption.zip")
#unzip the file

#read in the data file and prepare the columns for use.
#convert the date field to first and then filter 
#on the desired dates to speed up the processing.

#Many of the columns are read in as 'factor' types. To ensure
#that the data is correct a conversion to text was necessary
#before a conversion to numeric
#
data<-read.table("household_power_consumption.txt",header=TRUE, sep=";")
data$Date<-as.Date(data$Date, "%d/%m/%Y")
data.sub<-subset(data, Date=="2007-02-01" | Date=="2007-02-02")
data.sub$Day <- weekdays(as.Date(data.sub$Date))

#convert columns to numeric
data.sub$Global_active_power<-as.character(data.sub$Global_active_power)
data.sub$Global_active_power<-as.numeric(data.sub$Global_active_power)

data.sub$Global_reactive_power<-as.character(data.sub$Global_reactive_power)
data.sub$Global_reactive_power<-as.numeric(data.sub$Global_reactive_power)

data.sub$Sub_metering_1<-as.character(data.sub$Sub_metering_1)
data.sub$Sub_metering_1<-as.numeric(data.sub$Sub_metering_1)

data.sub$Sub_metering_1<-as.character(data.sub$Sub_metering_2)
data.sub$Sub_metering_1<-as.numeric(data.sub$Sub_metering_2)

data.sub$Sub_metering_1<-as.character(data.sub$Sub_metering_3)
data.sub$Sub_metering_1<-as.numeric(data.sub$Sub_metering_3)

data.sub$Voltage<-as.character(data.sub$Voltage)
data.sub$Voltage<-as.numeric(data.sub$Voltage)

#open the graphics device
#dev.copy did not work as well as the direct png() device
png(filename = "plot3.png", width = 480, height = 480, units = "px")


#graph 3
data.sub$DateTime<-as.POSIXct(paste(data.sub$Date, data.sub$Time), format="%Y-%m-%d %H:%M:%S")
with(data.sub, plot(DateTime, Sub_metering_3, main="", type="n",xlab="", ylab="Energy Sub Metering", yaxt="n", ylim=c(0,40)))
ticks<-c(0,10,20,30)
axis(2,at=ticks,labels=ticks)
lines(data.sub$DateTime,data.sub$Sub_metering_1)
lines(data.sub$DateTime,data.sub$Sub_metering_2, col="red")
lines(data.sub$DateTime,data.sub$Sub_metering_3, col="blue")

legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lty=1)

dev.off()