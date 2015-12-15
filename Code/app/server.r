library (shiny)
library (rworldmap)
library (countrycode)

dat<-read.csv("NMC.csv")
dat$milex[dat$milex<0]<-0
dat$country<- countrycode(dat$ccode, "cown", "iso3c")


# Join data frame 'comb_mdata' to the map
sPDF <- joinCountryData2Map(dat, joinCode='NAME', nameJoinColumn='country')

# Generate the Map 
output$mPlot <- renderPlot({
     mapParams <- mapPolys(sPDF, nameColumnToPlot='Wt_Score', mapRegion='world',
                           missingCountryCol='dark grey', numCats=10, 
                           colourPalette=c('green4','green1','greenyellow','yellow','yellow2','orange','coral','red','red3','red4'),
                           addLegend=TRUE,
                           oceanCol='light blue')
     mtext("[Grey Color: No Data Available]",side=1,line=-1)
})
     
