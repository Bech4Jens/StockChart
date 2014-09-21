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
      helpText("Choose the tickers of the stocks that you would like to chart"),
      
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
        tabPanel("Comparison", plotOutput("plot4")),
      h3("Documentation"), 
helpText("StockChart allows you graphically to investigate three different stock prices - just 
input the a ticker symbol from Yahoo Finance in one of the three boxes below. You can also 
customize the time period in the date-input boxes, and the selector box allows you to choose the type 
of graph. The first 3 tabs on the main panel show the actual stock prices along with trading volumes, whereas
               the 'Comparison' tab will allow you to compare the absolute returns of the various stocks."),
      helpText("In order to run the app on your computer, you will need to download and install 
               three packages besides the Shiny applications: quantmod, reshape2 and ggplot2. quantmod is the
               core of the application and facilitates easy download and charting of individual stock prices.
               The various widgets allows you to adjust the time period and the type of chart, i.e.
               line, matchstick, bar and candlestick. However, do note that only the 'line' chart
               is availible for the comparison chart. Also note that the comparison chart requires that
               you list three stocks, otherwise it will produce an error. If you only want to compare
               two stocks, then just dublicate one of the stock tickers."),
      helpText("All you'll need to get started is to type the stock ticker into the text boxes and the
               application will automatically update the charts. You can easely google the stock tickers
               of individual companies, but some examples include Visa 'V', Coca-Cola 'KO', 'IBM', and
               Goldman Sachs 'GS'. You can then browse between different stocks by clicking on the 
               various taps. Enjoy...")
              )
  )
)))