#############################################################################################
### This file load data relative to the electric power consumption 
### for the period covering 2007-02-01 and 2007-02-02.
### Different electrical quantities and some sub-metering values are available.
### Four line graphs as a function of weekdays are then generated:
### 1. A line graph of the global active power (upper-left);
### 2. A three-line graph of submetering 1, 2, and 3 (lower-left);
### 3. A line graph of the voltage (upper-right);
### 4. A line graph of the global reactive power (lower-tight).
### The four graphs are saved in a PNG file of 480 pixels x 480 pixels.
#############################################################################################

## Loading the data for 2007-02-01 and 2007-02-02 only.
filename <- "household_power_consumption.txt"
neededDate <- grep("^(1/2/2007|2/2/2007)", readLines(filename))
colname <- colnames(read.table(filename, 
                               nrow = 1, 
                               sep=";", 
                               header = TRUE)
                    )
ElectricPowerConsumption <- as.data.frame(read.table(filename, 
                                                     skip = neededDate[1]-2, 
                                                     nrows = length(neededDate), 
                                                     header=TRUE, 
                                                     sep=";", 
                                                     col.names = colname)
                                          )
rm("neededDate","colname","filename") # Remove non-needed variables

# Merge the date and time variables together into a new variable DateTime
library(dplyr)
library(lubridate)
ElectricPowerConsumption <- mutate(ElectricPowerConsumption,
                                   DateTime = paste(Date,Time),
                                   DateTime = dmy_hms(DateTime)
                                   )

## Making four line graphs as a function of weekdays
library(datasets)
par(mfcol = c(2, 2), mar = c(4.5, 4, 4, 1.5), oma = c(0, 1, 0, 0.5)) 
with(airquality, {
                  # 1. A line graph of the global active power (upper-left)
                  plot(ElectricPowerConsumption$DateTime,ElectricPowerConsumption$Global_active_power, # Data
                       type="n", # Does not produce any points
                       main = "", # title
                       xlab = "", # x axis name
                       ylab = "Global Active Power", # y axis name
                       cex.lab=0.75, cex.axis=0.75, # text font
                       )
                  lines(ElectricPowerConsumption$DateTime, ElectricPowerConsumption$Global_active_power,type="l")

                  ### 2. A three-line graph of submetering 1, 2, and 3 (lower-left);
                  plot(ElectricPowerConsumption$DateTime,ElectricPowerConsumption$Sub_metering_1, # Data
                       type="n", # Does not produce any points
                       main = "", # title
                       xlab = "", # x axis name
                       ylab = "Energy sub metering", # y axis name
                       cex.lab=0.75, cex.axis=0.75, # text font
                       ) # Margin size
                  lines(ElectricPowerConsumption$DateTime, ElectricPowerConsumption$Sub_metering_1, type = "l", col = "black")
                  lines(ElectricPowerConsumption$DateTime, ElectricPowerConsumption$Sub_metering_2, type = "l", col = "red")
                  lines(ElectricPowerConsumption$DateTime, ElectricPowerConsumption$Sub_metering_3, type = "l", col = "blue")
                  legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=c(1.25,1.25,1.25), col = c("black", "red", "blue"),cex = .70, bty = "n")
                  
                  ### 3. A line graph of the voltage (upper-right);
                  plot(ElectricPowerConsumption$DateTime,ElectricPowerConsumption$Voltage, # Data
                       type="n", # Does not produce any points
                       main = "", # title
                       xlab = "", # x axis name
                       ylab = "", # y axis name
                      cex.axis=0.75 # text font
                       ) # Margin size
                  lines(ElectricPowerConsumption$DateTime, ElectricPowerConsumption$Voltage, type = "l", col = "black")
                  mtext(side = 1, text = "datetime", line = 2.5, cex = 0.6)
                  mtext(side = 2, text = "Voltage", line = 2.5, cex = 0.6)
                  
                  ### 4. A line graph of the global reactive power (lower-tight).
                  plot(ElectricPowerConsumption$DateTime,ElectricPowerConsumption$Global_reactive_power, # Data
                       type="n", # Does not produce any points
                       main = "", # title
                       xlab = "", # x axis name
                       ylab = "", # y axis name
                       cex.axis=0.75, # text font
                  ) 
                  lines(ElectricPowerConsumption$DateTime, ElectricPowerConsumption$Global_reactive_power, type = "l", col = "black")
                  mtext(side = 1, text = "datetime", line = 2.5, cex = 0.6)
                  mtext(side = 2, text = "Global_reactive_power", line = 2.5, cex = 0.6)
                  
})

## Saving the 4 displayed graphs as "plot4.png" with a total width of 480 pixels and a total height of 480 pixels.
dev.copy(png, file = "plot4.png", width=480, height=480) # Copy the active plot to a PNG file
dev.off() # Turn off plot display
