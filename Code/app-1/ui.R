library(shiny)


# Define UI for application that draws a histogram
shinyUI(fluidPage(
     
     # Application title
     titlePanel("Jessica's Project!"),
     
     # Sidebar with a slider input for the number of bins
     sidebarLayout(
          sidebarPanel(
               postion="right",
               sliderInput("bins",
                           "Number of bins:",
                           min = 1,
                           max = 50,
                           value = 30)
          ),
          
          # Show a plot of the generated distribution
          mainPanel(
               h1 ("This is a first level title"),
               plotOutput("distPlot"),
               h6 ("This is a sixth level title", align="center")
               
          )
     )
))