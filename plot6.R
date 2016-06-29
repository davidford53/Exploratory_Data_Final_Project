## Load source files

summarySCC<-readRDS("c:\\users\\dwight\\documents\\r_workspace\\exploratory_data_analysis\\summarySCC_PM25.rds")


source_class<-readRDS("c:\\users\\dwight\\documents\\r_workspace\\exploratory_data_analysis\\Source_Classification_code.rds")


## Compare emissions from motor vehicle sources in Baltimore City 
## with emissions from motor vehicle sources in 
## Los Angeles County, California (fips == "06037"). 
## Which city has seen greater changes over time in motor vehicle emissions?

## 24510 is Baltimore, 06037 is Los Angeles
## Filter down to get numbers for each locale, where emissions are greater than 0
positive<-subset(summarySCC, Emissions>0 & fips=="24510" | fips=="06037", select=c(SCC,Emissions, year, fips))

## Merge the two data sources
pos_merge<-merge(x=positive, y=source_class, by="SCC")
 
## to get the motor vehicle numbers, filter on the EI.Sector field for the word Mobile
mobile<-grep("Mobile", pos_merge$EI.Sector, ignore.case=TRUE)

## subset down to only the columns needed for final calcs
motorVehicle<-subset(pos_merge[mobile,],Emissions>0 , select=c(Emissions, year, fips))
 
## Total the emissions for each year, by local
x<-tapply(motorVehicle$Emissions, INDEX=list(motorVehicle$year, motorVehicle$fips),sum)

## Give descriptive names to locales
colnames(x)<-c("LA Cty","Baltimore")

## plot two side-by-side graphs
par(mfrow=c(1,2))

plot(y=subset(x, select=c(1)),x=rownames(x), type="l",xlim=c(1999,2008),main="Los Angeles Cty", ylab="Vehicle PM25 tons Annually", xlab="Years") 

plot(y=subset(x, select=c(2)), x=rownames(x), type ="l", xlim=c(1999,2008),main="Baltimore, MD", ylab="", xlab="Years")




dev.copy(png,'plot6.png')
dev.off
