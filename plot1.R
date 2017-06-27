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
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data2 <- data[data$Date %in% as.Date(c("2007-02-01","2007-02-02")),]
globalActivePower <- (as.numeric(data2$Global_active_power))/1000

png("plot1.png",height=480, width=480)
hist(globalActivePower, xlab = "Global active power (kilowatts)", col="red")
dev.off()