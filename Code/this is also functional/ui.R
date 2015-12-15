dat<-read.csv("DMID/DMID.csv")

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


library(shiny)


# Define UI for application that draws a histogram
shinyUI(fluidPage(
     
     # Application title
     titlePanel("Dyadic Miitarized Interstate Dispute Viewer"),
     
     # Sidebar with a slider input for the number of bins
     sidebarLayout(
          sidebarPanel(
               postion="right",
              # sliderInput("bins",
                          # "Number of bins:",
                          # min = 1,
                         #  max = 50,
                          # value = 30),
              h3("Help text"),
              helpText("Select two countries,", 
                       "to view a count of their disputes",
                       "between 1993-2001."),
              #selectInput("x", "Select X Axis", choices = choices, selected= dat$StYear),
               selectInput("one", "Country One", 
                           choices = countries, selected="United States"),
              selectInput("two", "Country Two", 
                          choices = countries, selected= "Canada")

          
          ),
          
          # Show a plot of the generated distribution
          mainPanel(
               plotOutput("myplot"),
               h6 ("Year", align="center"),
               h3(textOutput("caption")),
               tableOutput("view")
            
               
          ))
     )
)