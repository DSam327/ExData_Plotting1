# Load the required library
library(data.table)

# Set the working directory
setwd("~/Desktop/datasciencecoursera/4_Exploratory_Data_Analysis/project/data")

# Load the dataset and handle missing values
data <- fread("household_power_consumption.txt", na.strings = "?")

# Convert 'Global_active_power' to numeric
data$Global_active_power <- as.numeric(data$Global_active_power)

# Create a POSIXct 'dateTime' column by combining 'Date' and 'Time'
data$dateTime <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")

# Filter data for the target dates
subset_data <- data[data$dateTime >= as.POSIXct("2007-02-01") & data$dateTime < as.POSIXct("2007-02-03")]

# Save the plot as a PNG image
png(filename = "plot3.png", width = 480, height = 480)

# Generate the plot for energy sub-metering
plot(
  subset_data$dateTime,
  subset_data$Sub_metering_1,
  type = "l",
  xlab = "",
  ylab = "Energy sub metering"
)
lines(subset_data$dateTime, subset_data$Sub_metering_2, col = "red")
lines(subset_data$dateTime, subset_data$Sub_metering_3, col = "blue")

# Add a legend to the plot
legend(
  "topright",
  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
  col = c("black", "red", "blue"),
  lty = 1,
  lwd = 1
)

# Close the PNG device
dev.off()
