dat<-read.csv("DMID.csv")

library (countrycode)
library (ggplot2)
countries<-dat$CCodeA
countries<-unique(countries)
countries.b<-unique(dat$CCodeB)
countries<-c(countries, countries.b)
countries<-unique(countries)

countries<-countrycode(countries, "cown", "country.name")
countries<-sort(countries)

dat$country.one<-countrycode(dat$CCodeA, "cown", "country.name")
dat$country.two<-countrycode(dat$CCodeB, "cown", "country.name")

dat$fatal.total<-dat$FatalPrA+dat$FatalPrB
dat$fatal.total[dat$fatal.total<0]<-0

#choices<-c("dat$StYear", "dat$fatal.total", "dat$StDay")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
     
     # Expression that generates a histogram. The expression is
     # wrapped in a call to renderPlot to indicate that:
     #
     #  1) It is "reactive" and therefore should be automatically
     #     re-executed when inputs change
     #  2) Its output type is a plot
     
     # Compute the formula text in a reactive expression since it is
     # shared by the output$caption and output$mpgPlot functions
     formulaText <- reactive({
          c("Militarized interstate disputes between", input$one, "and", input$two)
     })
     # Return the formula text for printing as a caption
     output$caption <- renderText({
          formulaText()
     })
  
     #graph.dat<-reactive({
     #     subset(dat, country.one==input$one()| country.two==input$one() | country.one==input$two()|country.two==input$two())
     #})
     
     #output$distPlot2 <- renderPlot({
      #    print(ggplot(data=graph.dat, aes(x=y, y=x)) + geom_line())
     #})

     ## select only rows where PRODUCT = input$product
     #dat1 <- reactive({
          #dat1[ (country.one==input$one()| country.two==input$one() & country.one==input$two()|country.two==input$two()), ] 
    # })
     
    # output$distPlot2 <- reactive({renderPlot({
       #  x    <- dat[ (country.one==input$one()| country.two==input$one() & country.one==input$two()|country.two==input$two()), ] 
     
        # bins <- seq(min(x), max(x), length.out = input$bins + 1)
    # })
          #draw the histogram with the specified number of bins
         # hist(x, breaks = bins, col = 'darkgray', border = 'white')
    # })
     
     # DATA
     
     data.r = reactive({
          #a = subset(dat, (country.one==input$one| country.two==input$one) & (country.one==input$two|country.two==input$two)) 
          a= subset(dat, (country.one==input$one & country.two==input$two) | (country.one==input$two & country.two==input$one))
          return(a)
     })
     
     
     output$myplot = renderPlot({
          
          dd<-data.r()
          s<- qplot(StYear, data=dd, geom="histogram")
          
          # ggplot with proper reference to reactive function <<data.r()>>
          #s = ggplot(dd, aes(x=dat$StYear))  +  
               
               
              # geom_line(data=dd, aes(x=StYear,y=fatal.total)
               #    ) 
               #+
               #geom_bar(data=subset(dat,country.one==input$one()| country.two==input$one() & country.one==input$two()|country.two==input$two()), aes(y=-fatal.total), stat="identity") +
               
               # lines for categories R, S: same.
              # geom_line(data=subset(dd, category=="R"), aes(y=value)) +
               #geom_line(data=subset(dd, category=="S"), aes(y=value)) +
               
               #scale_fill_manual(breaks = levels(dd$category), 
                               #  values = mycolorgenerator(length(levels(dd$category))))
          
          print(s)
     })
 })
     