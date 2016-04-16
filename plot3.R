library(graphics);library(grDevices)

##Read in data file
DataDir <- "C:\\Users\\julienjohn13\\My Documents\\Data Science Courses\\Data\\"
infile <- paste(DataDir,"houseconsump.txt",sep="")
housCons <- read.table(infile,sep=";",stringsAsFactors=FALSE,skip=0,header=TRUE)

## transform fields
#housCons$Date <- as.Date(housCons$Date,format="%d/%m/%Y")

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
 
#open png device
png(paste0(DataDir,"plot3.png"),type="windows")

## plot linegraph with legend to png device directly
     with(housCons2,plot(Datetime2,Sub_metering_1,type="n",mar=c(5,4,4,1),
                         ylab="Energy Sub Metering",xlab=""))
     with(housCons2,lines(Datetime2,Sub_metering_1,type="l",col="black"))
     with(housCons2,lines(Datetime2,Sub_metering_2,type="l",col="red"))
     with(housCons2,lines(Datetime2,Sub_metering_3,type="l",col="blue"))
     legend("topright",col=c("black","red","blue"),lty=1,cex=.8,
            legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
     
     
 ## close device
dev.off()
