## load source data

summarySCC<-readRDS("c:\\users\\dwight\\documents\\r_workspace\\exploratory_data_analysis\\summarySCC_PM25.rds")


source_class<-readRDS("c:\\users\\dwight\\documents\\r_workspace\\exploratory_data_analysis\\Source_Classification_code.rds")


## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad)
## variable, which of these four sources have seen decreases in emissions from 1999-2008 
## for Baltimore City? Which have seen increases in emissions from 1999-2008? 

##Use the ggplot2 plotting system to make a plot answer this question.
library(ggplot2)

## get positive data from baltimore
positiveBalt<-subset(summarySCC,fips=="24510" & Emissions>0, select=c(type, Emissions, year))

ggplot(data=positiveBalt, aes(x=year,y=log10(Emissions)))+geom_point()+facet_grid(.~type)+geom_smooth(method=lm)+theme(axis.text.x=element_text(angle=90, hjust=1, vjust=0.5))


dev.copy(png,'plot3.png')
dev.off

