# read files in R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#subset from NEI the data from Baltimore City, fips=="24510"
subNEI<-subset(NEI,fips=="24510")

#use tapply to calculate PM2.5 emission sum of each year, retruns a small data array save in EmiSum
subEmiSum<-tapply(subNEI$Emissions,subNEI$year,sum)
subEmiSum
year<-names(subEmiSum)   #use subEmiSum colum names as x-axis

# generate "plot2.png" file
png(file="plot2.png", width=480, height=480)
        plot(subEmiSum~year,xlab="year",type="b", ylab="PM2.5 emission sum/year",main = "Total PM2.5 Emissions of Each Year ~ Baltimore City",pch=20,lty = 2, lwd=2,col="blue")
dev.off()