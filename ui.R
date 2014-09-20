#Loads the necessary libraries for the program
library('shiny')
library('devtools')
library('quantmod')
library('ggplot2')
library('shinyapps')
library('reshape2')

#------------------------------------- Shiny App UI Starts Here ----------------------------------------#

shinyUI(fluidPage(
  titlePanel("Stock Price Graphs"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("The following application lets allows you graphically to investigate three different stock
prices - just input the a ticker symbol from Yahoo Finance in one of the three boxes below. You can also 
customize the time period in the date-input boxes, and the selector box allows you to choose the type 
of graph. The first 3 tabs on the main panel show the actual stock prices along with trading volumes, whereas
 the 'Comparison' tab will allow you to compare the absolute returns of the various stocks."),
      
      #Creates the input boxes for the stock tickers
      textInput("symb1", "Stock Ticker 1", "SPY"),
      textInput("symb2", "Stock Ticker 2", "SPY"),
      textInput("symb3", "Stock Ticker 3", "SPY"),
      
      #Allows the user to define the range of the dates
      dateRangeInput("dates", 
                     "Date range",
                     start = "2013-01-01", 
                     end = as.character(Sys.Date())),
      
      #Allows the user to select the type of charts for the individual stock prices
      selectInput("ChartType", label = "Chart Type", 
                  choices = c("Line" = "line", "Bars" = "bars",
                              "Matchsticks" = "matchsticks",
                              "Candlesticks" = "candlesticks"))
      
    ),
    
    mainPanel(
      #Constructs the various tabs including 
      tabsetPanel(
        tabPanel("Stock 1", plotOutput("plot1")),
        tabPanel("Stock 2", plotOutput("plot2")),
        tabPanel("Stock 3", plotOutput("plot3")),
        tabPanel("Comparison", plotOutput("plot4"))
      )
              )
  )
))