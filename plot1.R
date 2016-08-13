library(graphics);library(grDevices)

##Read in data file
DataDir <- "C:\\Users\\julienjohn13\\My Documents\\Data Science Courses\\Data\\"
infile <- paste(DataDir,"houseconsump.txt",sep="")
housCons <- read.table(infile,sep=";",stringsAsFactors=FALSE,skip=0,header=TRUE)

## transform fields
housCons$Date <- as.Date(housCons$Date,format="%d/%m/%Y")
##housCons$Time <- strptime(housCons$Time,format="%H:%M:%S")
housCons$Global_active_power <- as.numeric(housCons$Global_active_power)
housCons$Global_reactive_power <- as.numeric(housCons$Global_reactive_power)
housCons$Voltage <- as.numeric(housCons$Voltage)
housCons$Global_intensity <- as.numeric(housCons$Global_intensity)
housCons$Sub_metering_1 <- as.numeric(housCons$Sub_metering_1)
housCons$Sub_metering_2 <- as.numeric(housCons$Sub_metering_2)
housCons$Sub_metering_3 <- as.numeric(housCons$Sub_metering_3)

 ##Split out 2 data for 2 days
housCons2 <- subset(housCons,Date=="2007-02-01"|Date=="2007-02-02",na.rm=TRUE)
 
## plot histogram
 with(housCons2,hist(Global_active_power,col="Dark Orange",
        xlab="Global Active Power (kilowatts)",main="Global Active Power"))

 ## Copy to png file 
dev.copy(png,paste0(DataDir,"plot1.png"),width=480,height=480)
dev.off()
