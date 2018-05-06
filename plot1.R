setwd("~/Desktop/coursera/course 4")
url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
path<-getwd()
download.file(url, destfile=file.path(path, "PM2.5 data.zip"), method="curl") 
unzip(zipfile = "PM2.5 data.zip")

# read files in R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#use tapply to calculate PM2.5 emission sum of each year, retruns a small data array save in EmiSum
EmiSum<-tapply(NEI$Emissions,NEI$year,sum)
EmiSum                # read EmiSum
year<-names(EmiSum)   #use EmiSum colum names as x-axis

# generate "plot1.png" file
png(file="plot1.png", width=480, height=480)
        plot(EmiSum~year,xlab="year",type="b", ylab="PM2.5 emission sum/year",main = "Total PM2.5 Emissions of Each Year",pch=20,lty = 2, lwd=2)
dev.off()
