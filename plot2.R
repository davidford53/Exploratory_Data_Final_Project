
## load source data
summarySCC<-readRDS("c:\\users\\dwight\\documents\\r_workspace\\exploratory_data_analysis\\summarySCC_PM25.rds")

source_class<-readRDS("c:\\users\\dwight\\documents\\r_workspace\\exploratory_data_analysis\\Source_Classification_code.rds")

## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
## from 1999 to 2008? Use the base plotting system to make a plot answering this question.

## get positive results for baltimore
positiveBalt<-subset(summarySCC,fips=="24510" & Emissions>0, select=c(Emissions, year))

## get sums by year
x<-tapply(positiveBalt$Emissions, as.character(positiveBalt$year),sum)

## plot results
plot(y=x,x=names(x), type="l",xlim=c(1999,2008),main="Baltimore, MD", ylab="PM25 Tons Annually", xlab="Years") 
dev.copy(png,'plot2.png')
dev.off

