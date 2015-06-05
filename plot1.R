#############################################################################################
### This file load data relative to the electric power consumption 
### for the period covering 2007-02-01 and 2007-02-02.
### Different electrical quantities and some sub-metering values are available.
### An histogram of the global active power is then generated.
### The histogram is saved in a PNG file of 480 pixels x 480 pixels.
#############################################################################################
 
## Loading the data for 2007-02-01 and 2007-02-02 only.
filename <- "household_power_consumption.txt"
neededDate <- grep("^(1/2/2007|2/2/2007)", readLines(filename)) # Location of needed Data
colname <- colnames(read.table(filename, nrow = 1, sep=";", header = TRUE)) # Variable names
ElectricPowerConsumption <- as.data.frame(read.table(filename, 
                                                     skip = neededDate[1]-2, 
                                                     nrows = length(neededDate), 
                                                     header=TRUE, 
                                                     sep=";", 
                                                     col.names = colname)
                                          )
rm("neededDate","colname","filename") # Remove non-needed variables


## Plotting histogram of the global active power
library(datasets)
par(mfcol = c(1, 1), mar = c(5,6,4,4)) # Set space for one graph
hist(ElectricPowerConsumption$Global_active_power, 
     main = "Global Active Power", # title
     xlab = "Global Active Power (kilowatts)", # x axis name
     cex.lab=0.75, cex.axis=0.75, cex.main=0.9, # text font
     col = "red") # Histogram color


## Saving the histogram as "plot1.png" with a width of 480 pixels and a height of 480 pixels.
dev.copy(png, file = "plot1.png", width=480, height=480) # Copy the active plot to a PNG file
dev.off() # Turn off plot display