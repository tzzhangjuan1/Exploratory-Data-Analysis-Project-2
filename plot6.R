# read files in R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# merge NEI and SCC dataframe by SCC
NEISCC<-merge(NEI,SCC,by.x="SCC",by.y="SCC")

#subset from NEISCC the data from Baltimore City and Los Angeles, fips=="24510"and "06037"
subNEISCC<-subset(NEISCC,fips=="24510")
subNEISCC2<-subset(NEISCC,fips=="06037")

# subset from subNEISCC based on "EI.Sector" variable that uses "Mobile" as column
subNEISCC_Vehicles<-subset(subNEISCC,grepl("Vehicles",subNEISCC$EI.Sector))
subNEISCC2_Vehicles<-subset(subNEISCC2,grepl("Vehicles",subNEISCC2$EI.Sector))

# use tapply to calculate PM2.5 emission sum of each year, retruns a small data array save in subNEISCCsum
subNEISCC_Vehicles_sum<- tapply(subNEISCC_Vehicles$Emissions,subNEISCC_Vehicles$year,sum)
subNEISCC2_Vehicles_sum<- tapply(subNEISCC2_Vehicles$Emissions,subNEISCC2_Vehicles$year,sum)
subNEISCC_Vehicles_sum
subNEISCC2_Vehicles_sum
year<-names(subNEISCC_Vehicles_sum)        #use subEmiSum colum names as x-axis

# generate "plot6.png" file
png(file="plot6.png", width=800, height=480)
        par(mfrow=c(1,2))
        plot(subNEISCC_Vehicles_sum~year,type="b",pch=19,lty = 1, lwd=2,col="purple",main = "Baltimore City",xlab="year",ylab="PM2.5 emission sum ~ Motor Vehicles")
        plot(subNEISCC2_Vehicles_sum~year,type="b",pch=19,lty = 1, lwd=2,col="purple",main = "Los Angeles",xlab="year",ylab="PM2.5 emission sum ~ Motor Vehicles")
dev.off()  

