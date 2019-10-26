
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

## Plot 3
with(t, {
  plot(Sub_metering_1~dateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Save as .png file
dev.copy(png,"./figure/plot3.png", width=480, height=480)
dev.off()
