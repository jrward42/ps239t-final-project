library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
     
     # Expression that generates a histogram. The expression is
     # wrapped in a call to renderPlot to indicate that:
     #
     #  1) It is "reactive" and therefore should re-execute automatically
     #     when inputs change
     #  2) Its output type is a plot
     
     output$distPlot <- renderPlot({
          dat   <- read.csv("DMID/DMID.csv")
          dat$Aname<- countrycode(dat$CCodeA, "cown", "country.name", warn= FALSE)
          x<- dat$Aname
          bins <- seq(min(x), max(x), length.out = input$bins + 1)
          
          # draw the histogram with the specified number of bins
          hist(x, breaks = bins, col = 'skyblue', border = 'black')
     })
})