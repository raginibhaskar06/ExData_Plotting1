
## Reading File contents
t <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Converting Char Date field to Type Date
t$Date <- as.Date(t$Date, "%d/%m/%Y")

## Filter only the data between from Feb. 1, 2007 to Feb. 2, 2007
t <- subset(t,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Dropping incomplete observations.
t <- t[complete.cases(t),]

## Merge Date and Time Colums as one column
dateTime <- paste(t$Date, t$Time)

## assiging the Name
dateTime <- setNames(dateTime, "DateTime")

## Dropping Date and Time fields from frame
t <- t[ ,!(names(t) %in% c("Date","Time"))]

## Adding DateTime field to Frame
t <- cbind(dateTime, t)

## Format DateTime Fields to POSIXct
t$dateTime <- as.POSIXct(dateTime)

## Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(t, {
  plot(Global_active_power~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~dateTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~dateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

## Save as .png file
dev.copy(png,"./figure/plot4.png", width=480, height=480)
dev.off()  
