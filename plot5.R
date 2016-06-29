## Load data from two sources

summarySCC<-readRDS("c:\\users\\dwight\\documents\\r_workspace\\exploratory_data_analysis\\summarySCC_PM25.rds")


source_class<-readRDS("c:\\users\\dwight\\documents\\r_workspace\\exploratory_data_analysis\\Source_Classification_code.rds")

## How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

## Baltimore and positive data only
positive<-subset(summarySCC, Emissions>0 & fips=="24510", select=c(SCC,Emissions, year))

## merge with Source Class
pos_merge<-merge(x=positive, y=source_class, by="SCC")

## narrow it down to Mobile sources, i.e. vehicles
mobile<-grep("Mobile", pos_merge$EI.Sector, ignore.case=TRUE)

## narrow down columns returned.
motorVehicle<-subset(pos_merge[mobile,],Emissions>0 , select=c(Emissions, year))

## get sums by year
x<-as.data.frame(tapply(motorVehicle$Emissions, motorVehicle$year, sum))

## add year column as rownames not working as vector source
x<-cbind(x,year=rownames(x))

## rename columns
colnames(x)<-c("Emissions","year")

plot(y=x$Emissions,x=as.numeric(x$year), type="l",main="Motor Vehicle - Baltimore, MD", ylab="PM25 tons Annually", xlab="Years") 

dev.copy(png,'plot5.png')
dev.off
