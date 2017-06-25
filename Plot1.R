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

#transforming date to a usable format 
power_data$Date <- strptime(power_data$Date, format = "%d/%m/%Y")
power_data$Date <- as.Date (power_data$Date, tz = FALSE)

#subsetting data to a required interval
power_data <- subset(power_data, Date >= "2007-02-01" & Date <= "2007-02-02")

#plotting
hist(power_data$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = 2)

#saving PNG file
dev.copy(png, file = "Plot1.png")
dev.off()
