
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

## To Plot Global Active Power Histagram Plot.
## hist(t$Global_active_power, main="Global Active Power", xlab = "Global Active Power (KW)", col="red")
## Plot2
plot(t$Global_active_power~t$dateTime, type="l", ylab="Global Active Power (KW)", xlab="")

## Save as .png file
dev.copy(png,"./figure/plot2.png", width=480, height=480)
dev.off()
