CreatePlot2 <- function(createpng)
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
  
  ## Create Plot2
  plot(strptime(paste(powerdata$Date,powerdata$Time),"%d/%m/%Y %H:%M:%S"),powerdata[,3],type="l",xlab="",ylab="Global Active Power (kilowatts)")
  
  if(createpng == TRUE){
      ## Save to png
      dev.copy(png,file="plot2.png",height=480,width=480,units="px")
      dev.off()
  }
}