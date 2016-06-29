## load data sources

summarySCC<-readRDS("c:\\users\\dwight\\documents\\r_workspace\\exploratory_data_analysis\\summarySCC_PM25.rds")

source_class<-readRDS("c:\\users\\dwight\\documents\\r_workspace\\exploratory_data_analysis\\Source_Classification_code.rds")

## Across the United States, how have emissions from 
## coal combustion-related sources changed from 1999-2008?

## get rows with positive emissions
positive<-subset(summarySCC, Emissions>0, select=c(SCC,Emissions, year))

## merge with lookup table
pos_merge<-merge(x=positive, y=source_class, by="SCC")

## look for all rows with "coal" in them
coal<-grep("[C,c]oal",pos_merge$EI.Sector, ignore.case=TRUE)

## get all rows with coal, and subset the columns returned
coalBurning <-subset(pos_merge[coal,], select=c(Emissions, year))

## get sums by year.
x<-tapply(coalBurning$Emissions, as.character(coalBurning$year),sum)

## plot results
plot(y=x,x=names(x), type="l",xlim=c(1999,2008),main="Coal Burning - All US", ylab="PM25 Tons Annually", xlab="Years") 
dev.copy(png,'plot4.png')
dev.off

