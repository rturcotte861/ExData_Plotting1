#############################################################################################
### This file load data relative to the electric power consumption 
### for the period covering 2007-02-01 and 2007-02-02.
### Different electrical quantities and some sub-metering values are available.
### A line graph of the global active power as a function of weekdays is then generated.
### The line graph is saved in a PNG file of 480 pixels x 480 pixels.
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

## Making the line graph of the global active power as a function of weekday.
library(datasets)
par(mfcol = c(1, 1), mar = c(5,6,4,4)) # Set space for one graph
plot(ElectricPowerConsumption$DateTime,ElectricPowerConsumption$Global_active_power, # Data
     type="n", # Does not produce any points
     main = "", # title
     xlab = "", # x axis name
     ylab = "Global Active Power (kilowatts)", # y axis name
     cex.lab=0.75, cex.axis=0.75, # text font
     )
lines(ElectricPowerConsumption$DateTime, ElectricPowerConsumption$Global_active_power,type="l")

## Saving the line graph as "plot2.png" with a width of 480 pixels and a height of 480 pixels.
dev.copy(png, file = "plot2.png", width=480, height=480) # Copy the active plot to a PNG file
dev.off() # Turn off plot display