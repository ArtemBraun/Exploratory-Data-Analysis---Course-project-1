library(dplyr)

# downloading data file
Url_data <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
File_data <- "exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists(File_data)) {
        download.file(Url_data, File_data, mode = "wb")
}

# extracting zip file
data_name <- "household_power_consumption.zip"
if (!file.exists(data_name)) {
        unzip(File_data)
}

# reading data file
power_data <- read.table("household_power_consumption.txt", header = TRUE, na.strings ="?", nrows = 75000, sep = ";")

#transforming date and time to a usable format 
power_data$Date <- strptime(power_data$Date, format = "%d/%m/%Y")
power_data$Date <- as.Date (power_data$Date, tz = FALSE)
power_data <- mutate(power_data, Weekdays = weekdays(Date, abbreviate = TRUE))

#subsetting data to a required interval
power_data <- subset(power_data, Date >= "2007-02-01" & Date <= "2007-02-02")

#additional transforming date and time to a usable format 
power_data$Date <- as.character(power_data$Date)
power_data <- mutate(power_data, Date_time = paste(Date, Time, sep = " "))
power_data$Date <- as.Date (power_data$Date, tz = FALSE)
power_data$Date_time <- as.POSIXlt(power_data$Date_time, format = "%Y-%m-%d %H:%M:%S")


#plotting
plot(power_data$Date_time, power_data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
points(power_data$Date_time, power_data$Sub_metering_2, type = "l", col = "red")
points(power_data$Date_time, power_data$Sub_metering_3, type = "l", col = "blue")
legend("topright", lwd = 2, col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#saving PNG file
dev.copy(png, file = "Plot3.png")

dev.off()
