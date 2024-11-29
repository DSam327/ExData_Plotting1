# Load required library
library(data.table)

# Load dataset and handle missing values
data <- fread("household_power_consumption.txt", na.strings = "?")

# Convert 'Global_active_power' to numeric
data$Global_active_power <- as.numeric(data$Global_active_power)

# Combine 'Date' and 'Time' into a POSIXct datetime column
data$dateTime <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")

# Filter for the required date range
filtered_data <- data[data$dateTime >= as.POSIXct("2007-02-01") & data$dateTime < as.POSIXct("2007-02-03")]

# Save the plots as a PNG image
png(filename = "plot4.png", width = 480, height = 480)

# Configure the plotting layout
par(mfrow = c(2, 2))

# Plot 1: Global Active Power
plot(
  filtered_data$dateTime,
  filtered_data$Global_active_power,
  type = "l",
  xlab = "",
  ylab = "Global Active Power"
)

# Plot 2: Voltage
plot(
  filtered_data$dateTime,
  filtered_data$Voltage,
  type = "l",
  xlab = "datetime",
  ylab = "Voltage"
)

# Plot 3: Energy Sub Metering
plot(
  filtered_data$dateTime,
  filtered_data$Sub_metering_1,
  type = "l",
  xlab = "",
  ylab = "Energy sub metering"
)
lines(filtered_data$dateTime, filtered_data$Sub_metering_2, col = "red")
lines(filtered_data$dateTime, filtered_data$Sub_metering_3, col = "blue")
legend(
  "topright",
  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
  col = c("black", "red", "blue"),
  lty = 1,
  bty = "n",
  cex = 0.5
)

# Plot 4: Global Reactive Power
plot(
  filtered_data$dateTime,
  filtered_data$Global_reactive_power,
  type = "l",
  xlab = "datetime",
  ylab = "Global Reactive Power"
)

# Close the PNG device
dev.off()
