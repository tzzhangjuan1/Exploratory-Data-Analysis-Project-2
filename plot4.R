# read files in R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# merge NEI and SCC dataframe by SCC
NEISCC<-merge(NEI,SCC,by.x="SCC",by.y="SCC")

# subset from NEISCC based on "EI.Sector" variable that uses "Coal" as column
subNEISCC<-subset(NEISCC,grepl("Coal",NEISCC$EI.Sector))
dim(subNEISCC)

# use tapply to calculate PM2.5 emission sum of each year, retruns a small data array save in subNEISCCsum
subNEISCCsum <- tapply(subNEISCC$Emissions,subNEISCC$year,sum)
subNEISCCsum
year<-names(subNEISCCsum)        #use subEmiSum colum names as x-axis

# generate "plot4.png" file
png(file="plot4.png", width=480, height=480)
        plot(subNEISCCsum~year,xlab="year",type="b", ylab="PM2.5 emission sum/year",main = "Total PM2.5 Emissions of Each Year ~ Coal",pch=20,lty = 1, lwd=2,col="red")
dev.off()