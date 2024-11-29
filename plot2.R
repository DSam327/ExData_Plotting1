# Load the data.table package
library(data.table)

# Read the dataset, handling missing values
dataset <- fread("household_power_consumption.txt", na.strings = "?")

# Convert 'Global_active_power' to numeric
dataset$Global_active_power <- as.numeric(dataset$Global_active_power)

# Combine Date and Time into a single POSIXct column
dataset$dateTime <- as.POSIXct(paste(dataset$Date, dataset$Time), format = "%d/%m/%Y %H:%M:%S")

# Subset data for the specified date range
filtered_data <- dataset[dataset$dateTime >= as.POSIXct("2007-02-01") & dataset$dateTime < as.POSIXct("2007-02-03")]

# Save the plot to a PNG file
png("plot2.png", width = 480, height = 480)

# Generate the line plot
plot(
  filtered_data$dateTime,
  filtered_data$Global_active_power,
  type = "l",
  xlab = "",
  ylab = "Global Active Power (kilowatts)"
)

# Close the PNG device
dev.off()
