#Loads the necessary libraries for the program
library('shiny')
library('devtools')
library('quantmod')
library('ggplot2')
library('shinyapps')
library('reshape2')

#------------------------------------- Shiny App Server Starts Here ----------------------------------------#

shinyServer(function(input, output) {
  
  #Code to load data for the first stock
  dataInput1 <- reactive({
    getSymbols(input$symb1, src = "yahoo", 
               from = input$dates[1],
               to = input$dates[2],
               auto.assign = FALSE)
    
  })
  
  #Code to load data for the second stock
  dataInput2 <- reactive({
    getSymbols(input$symb2, src = "yahoo", 
               from = input$dates[1],
               to = input$dates[2],
               auto.assign = FALSE)
    
  })
  
  #Code to load data for the third stock
  dataInput3 <- reactive({
    getSymbols(input$symb3, src = "yahoo", 
               from = input$dates[1],
               to = input$dates[2],
               auto.assign = FALSE)
    
  })
  
  
  #Output for the first tap
  output$plot1 <- renderPlot({    
    chartSeries(dataInput1(), name = input$symb1, theme = chartTheme("white"), 
                type = input$ChartType)
  })
  
  #Output for the second tap
  output$plot2 <- renderPlot({    
    chartSeries(dataInput2(), name = input$symb2, theme = chartTheme("white"), 
                type = input$ChartType)
  })
  
  #Output for the third tap
  output$plot3 <- renderPlot({    
    chartSeries(dataInput3(), name = input$symb3, theme = chartTheme("white"), 
                type = input$ChartType)
  })
  
  #Output for the comparison tap
  output$plot4 <- renderPlot({
    
    #Compiles the necessary data for the stock comparison
    Comp1 <-  data.frame(date = index(dataInput1()), dataInput1(), row.names=NULL)[,c(1,7)]    
    Comp2 <-  data.frame(date = index(dataInput2()), dataInput2(), row.names=NULL)[,c(1,7)]
    Comp3 <-  data.frame(date = index(dataInput3()), dataInput3(), row.names=NULL)[,c(1,7)]
    CompFinal <-  merge(merge(Comp1, Comp2, by=1), Comp3, by=1)
    CompFinal[,2] <- (CompFinal[,2]/CompFinal[1,2])*100
    CompFinal[,3] <- (CompFinal[,3]/CompFinal[1,3])*100
    CompFinal[,4] <- (CompFinal[,4]/CompFinal[1,4])*100
    CompFinal <-  melt(CompFinal, id.vars="date")
    
    #COnstructs the ggplot with the three stock prices to be compared
    p <- ggplot(CompFinal, aes(x=date, y=value, color=variable,)) + geom_line() + 
      ggtitle("Comparison of Total Returns") + ylab("Total Return Index (base=100)") + xlab("Date")
    print(p)
  })
  
})