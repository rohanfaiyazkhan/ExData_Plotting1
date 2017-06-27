filename <- "exdata_data_household_power_consumption.zip"
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

## download the file if it is not already downloaded
if(!file.exists(filename)){
  download.file(url, destfile = filename)
}

## unzip the file it is not already unzipped
if(!file.exists("household_power_consumption.txt")){
  unzip(filename)
}

data<-read.table("household_power_consumption.txt", sep=";", header=TRUE)
data2 <- data[data$Date %in% c("1/2/2007","2/2/2007"),]
datetime <- strptime(paste(data2$Date, data2$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")
voltage <- as.numeric(data2$Voltage)
Sub_metering_1 <- as.numeric(data2$Sub_metering_1)
Sub_metering_2 <- as.numeric(data2$Sub_metering_2)
Sub_metering_3 <- as.numeric(data2$Sub_metering_3)
globalActivePower <- (as.numeric(data2$Global_active_power))/1000
globalReactivePower <- (as.numeric(data2$Global_reactive_power))

png("plot4.png",width=480, height=480)
par(mfcol = c(2,2))
plot(datetime, globalActivePower, type="l", xlab = "", ylab = "Global Active Power (in kilowatts)")

plot(datetime, Sub_metering_1, type="l", xlab = "", ylab = "Energy Sub Metering")
lines(datetime, Sub_metering_2, type="l", col="red")
lines(datetime, Sub_metering_3, type="l", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=2, lty=1, col=c('black','red','blue'))

plot(datetime, voltage, type="l", xlab="datetime", ylab="Voltage")

plot(datetime, globalReactivePower, type="l", xlab="datetime", ylab="Global_Reactive_Power")
dev.off()