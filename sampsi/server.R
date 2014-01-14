library(shiny)

# Define server logic required to generate and plot a random distribution
shinyServer(function(input, output) {
   
  # Expression that generates a plot of the distribution. The expression
  # is wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should be automatically 
  #     re-executed when inputs change
  #  2) Its output type is a plot 
  #
    
  output$summary <- renderPrint({
    cat(input$nfarms)
    cat(input$p)
    cat(input$confidence)
    cat(input$L)
    cat(input$HSe)
    cat(input$HSp)
    cat(input$Se)
    cat(input$SP)
    cat(input$N_subunit)
    cat(input$n_subunit_tested)
    cat(input$p_subunit)
  })
  
})
