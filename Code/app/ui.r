shinyServer(function(input, output) {

mainPanel(
     tabsetPanel(id="tp",
                 tabPanel("Map View", plotOutput("mPlot", height="560px", width="950px")),
                 sliderInput("year", label = h3("Select Year"),
                             min = 1816, max = 2007, value = 1)
                 )
)
     
})