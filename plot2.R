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

globalActivePower <- (as.numeric(data2$Global_active_power))/1000
datetime <- strptime(paste(data2$Date, data2$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")

png("plot2.png",height=480, width=480)
plot(datetime, globalActivePower, type="l", xlab = "", ylab = "Global Active Power (in kilowatts)")
dev.off()
