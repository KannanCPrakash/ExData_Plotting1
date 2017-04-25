CreatePlot3 <- function(createpng)
{
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  
  ## Download Zip file
  download.file(fileURL, "data/Power.zip")
  
  ## Uncompress the downloaded file
  unzip("data/Power.zip",exdir="data")
  
  ## Read only one row to get header
  headerframe <- read.table("data/household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", nrows=1)
  
  ## From Previous analysis we know that the dates 2007-02-01 and 2007-02-02 
  ## starts from Row 66637 and the total number of rows is 2880
  ## To optimize reading, lets skip the other rows
  powerdata <- read.table("data/household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", nrows=2880, skip=66636)
  
  ## Partial reading from txt file does not update header
  ## Assign header from headere frame
  names(powerdata) = names(headerframe)
  
  ## Create Plot3
  ## Create Empty Plot
  with(powerdata, plot(strptime(paste(powerdata$Date,powerdata$Time),"%d/%m/%Y %H:%M:%S"),powerdata[,7],type="n", xlab="",ylab="Energy sub metering"))
  
  ## Create Sub Metering 1
  with(powerdata, points(strptime(paste(powerdata$Date,powerdata$Time),"%d/%m/%Y %H:%M:%S"),powerdata[,7],type="l"))
  
  ## Create Sub Metering 2
  with(powerdata, points(strptime(paste(powerdata$Date,powerdata$Time),"%d/%m/%Y %H:%M:%S"),powerdata[,8],type="l",col="orangered"))
  
  ## Create Sub Metering 3
  with(powerdata, points(strptime(paste(powerdata$Date,powerdata$Time),"%d/%m/%Y %H:%M:%S"),powerdata[,9],type="l",col="blue"))
  
  ## Create Legend
  legend("topright",col=c("black","orangered","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3") ,lwd=c(2.5,2.5,2.5))
  
  if(createpng == TRUE){
      ## Save to png
      dev.copy(png,file="plot3.png",height=480,width=480,units="px")
      dev.off()
  }
}