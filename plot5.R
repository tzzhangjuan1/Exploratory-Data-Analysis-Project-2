# read files in R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# merge NEI and SCC dataframe by SCC
NEISCC<-merge(NEI,SCC,by.x="SCC",by.y="SCC")

#subset from NEISCC the data from Baltimore City, fips=="24510"
subNEISCC<-subset(NEISCC,fips=="24510")
# subset from subNEISCC based on "EI.Sector" variable that uses "Mobile" as column
subNEISCC_Vehicles<-subset(subNEISCC,grepl("Vehicles",subNEISCC$EI.Sector))

# use tapply to calculate PM2.5 emission sum of each year, retruns a small data array save in subNEISCCsum
subNEISCC_Vehicles_sum<- tapply(subNEISCC_Vehicles$Emissions,subNEISCC_Vehicles$year,sum)
subNEISCC_Vehicles_sum
year<-names(subNEISCC_Vehicles_sum)        #use subEmiSum colum names as x-axis

# generate "plot5.png" file
png(file="plot5.png", width=550, height=480)
        plot(subNEISCC_Vehicles_sum~year,xlab="year",type="b", ylab="PM2.5 emission sum/year",main = "Total PM2.5 Emissions per Year ~ Motor Vehicles in Baltimore City",pch=19,lty = 1, lwd=2,col="darkgreen")
dev.off()        
        