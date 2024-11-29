# Load necessary library
library(data.table)

# Load data and handle missing values
data <- fread("household_power_consumption.txt", na.strings = "?")

# Convert 'Global_active_power' to numeric
data$Global_active_power <- as.numeric(data$Global_active_power)

# Convert 'Date' to Date format
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# Subset data for the required date range
subset_data <- data[data$Date >= as.Date("2007-02-01") & data$Date <= as.Date("2007-02-02")]

# Create a PNG device for the histogram
png(filename = "plot1.png", width = 480, height = 480)

# Generate histogram
hist(
  subset_data$Global_active_power,
  main = "Global Active Power",
  xlab = "Global Active Power (kilowatts)",
  ylab = "Frequency",
  col = "red"
)

# Close the PNG device
dev.off()
