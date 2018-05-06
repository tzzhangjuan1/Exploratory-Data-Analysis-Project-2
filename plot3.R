# read files in R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#subset from NEI the data from Baltimore City, fips=="24510"
subNEI<-subset(NEI,fips=="24510")

#use dplyr to group by year and type --> then sum Emission
library(dplyr)
GroupedNEI <- group_by(subNEI,year,type)
Summary <- summarise(GroupedNEI,sumEmission=sum(Emissions))

#use ggplot2 to print the plot, x-axis is year, y-axis is sumEmission, 4 pannels based on type group
library(ggplot2)
png(file="plot3.png", width=1000, height=480)
        g <- ggplot(Summary,aes(year,sumEmission))
        p <- g + geom_point()+ geom_line() +facet_grid(.~type)+labs(title="Total PM2.5 Emissions of Each Year/type ~ Baltimore City")+labs(y = "PM2.5 emission sum")+ 
                theme(plot.title = element_text(hjust=0.5))
        print(p)
dev.off()




