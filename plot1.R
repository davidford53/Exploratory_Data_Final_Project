## Load source files

summarySCC<-readRDS("c:\\users\\dwight\\documents\\r_workspace\\exploratory_data_analysis\\summarySCC_PM25.rds")

source_class<-readRDS("c:\\users\\dwight\\documents\\r_workspace\\exploratory_data_analysis\\Source_Classification_code.rds")

## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, 
## make a plot showing the total PM2.5 emission from all sources 
## for each of the years 1999, 2002, 2005, and 2008.

## get positive data and specific Emissions and year columns from data
positive<-subset(summarySCC[,c(4,6)], Emissions>0)

## Get sum by year
x<-tapply(positive$Emissions, as.character(positive$year),sum)

## plot results, divide emissions by one million to make results readable
plot(y=x/1000000,x=names(x), type="l",xlim=c(1999,2008),ylab="PM25 Millions of Tons Annually", xlab="Years") 
dev.copy(png,'plot1.png')
dev.off

