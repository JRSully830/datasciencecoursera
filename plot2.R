library(graphics);library(grDevices)

##Read in data file
DataDir <- "C:\\Users\\julienjohn13\\My Documents\\Data Science Courses\\Data\\"
infile <- paste(DataDir,"houseconsump.txt",sep="")
housCons <- read.table(infile,sep=";",stringsAsFactors=FALSE,skip=0,header=TRUE)

## transform fields
##housCons$Date <- as.Date(housCons$Date,format="%d/%m/%Y")

housCons$Datetime <- paste(housCons$Date,housCons$Time)
housCons$Datetime2 <- strptime(housCons$Datetime,format="%d/%m/%Y %H:%M:%S")
housCons$Date <- as.Date(housCons$Date,format="%d/%m/%Y")
housCons$Global_active_power <- as.numeric(housCons$Global_active_power)
housCons$Global_reactive_power <- as.numeric(housCons$Global_reactive_power)
housCons$Voltage <- as.numeric(housCons$Voltage)
housCons$Global_intensity <- as.numeric(housCons$Global_intensity)
housCons$Sub_metering_1 <- as.numeric(housCons$Sub_metering_1)
housCons$Sub_metering_2 <- as.numeric(housCons$Sub_metering_2)
housCons$Sub_metering_3 <- as.numeric(housCons$Sub_metering_3)

 ##Split out data for 2 days
housCons2 <- subset(housCons,Date=="2007-02-01"|Date=="2007-02-02",na.rm=TRUE)
 
## plot linegraph
 with(housCons2,plot(Datetime2,Global_active_power,type="n",
                     ylab="Global Active Power (kilowatts)",xlab=""))
     with(housCons2,lines(Datetime2,Global_active_power,type="l"))

 ## Copy to png file 
dev.copy(png,paste0(DataDir,"plot2.png"),width=480,height=480)
dev.off()
