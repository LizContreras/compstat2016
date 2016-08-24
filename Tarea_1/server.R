library(shiny)
library(datasets)
library(ggplot2)
#install.packages("cowplot")
library("cowplot")

shinyServer(function(input, output) {
  
  u <- reactive(runif(input$n))
  x <- reactive((1/input$lambda)*log(1/(1-u())))

  output$distPlot <- renderPlot({
    # generate bins based on input$bins from ui.R
    # x    <- faithful[, 2]
    # bins <- seq(min(x), max(x), length.out = input$bins + 1)
    # draw the histogram with the specified number of bins
    hist(x(), breaks = 50, freq= FALSE, fill=I("blue"), col=I("blue"))
    
  })
  
  output$summary <- renderPrint({
   summary(x())
  })
  
  output$pvalK <- renderPrint({
    require(vcd)
    require(MASS)
    # data generation
    # estimate the parameters
    fit2 <- fitdistr(x(), "exponential")
    # goodness of fit test
    ks.test(x(), "pexp", fit2$estimate) 
  })
  output$table <- renderTable({
    data.frame(x())
  })
  output$pvalChi <- renderPrint({
    require(vcd)
    require(MASS)
    breaks <- c(seq(0,10,by=1))
    
    O <- table(cut(x(),breaks=breaks))
    p <- diff(pexp(breaks))
    chisq.test(O,p=p, rescale.p=T)
  })
  
  
  output$tabla <- renderDataTable({
    data <- as.data.frame(cbind(x(),u()))
    names(data) <- c("X","Acumulada")
    data  
  })
  
  
  
})