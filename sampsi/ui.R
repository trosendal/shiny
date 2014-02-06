sourceCode <- list(  # or save this in global.R
  aceEditor("ui"
            , value = paste(readLines("ui.R"), collapse="\n")
            , mode = "r"
            , theme = "ambience"
            , height = "400px"
            , readOnly = TRUE
  ), br(),
  aceEditor("server"
            , value = paste(readLines("server.R"), collapse="\n")
            , mode = "r"
            , theme = "ambience"
            , height = "400px"
            , readOnly = TRUE
  )
)



library(shiny)
library(epiR)
library(knitr)
library(shinyAce)

# Define UI for application that plots random distributions 
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("A sample size calculator for among-herd prevalence estimates"),
  
  # Sidebar with a slider input for number of observations
  sidebarPanel(
    textInput("disease_name", "Name of the disease:", "Scary Disease-x!"),
    numericInput("nfarms", "Number of farms in the population", 1000),
    numericInput("p", 
                 "Estimated among-herd prevalance:", 
                 min = 0, 
                 max = 1, 
                 value = 0.30),
    numericInput("confidence", 
                 "Confidence threshhold for posterior prevalence estimate (p-value):", 
                 min = 0, 
                 max = 1, 
                 value = 0.05),    
    numericInput("L", 
                 "Desired range of confidence interval of posterior estimate (L):", 
                 min = 0, 
                 max = 1, 
                 value = 0.1),  
    numericInput("N_subunit", "Average herd size measured in number of units of analysis:", 25),
    numericInput("n_subunit_tested", "Number of subunits tested per farm:", 5),

    numericInput("p_subunit", 
                "Estimated within-herd prevalence:", 
                min = 0, 
                max = 1, 
                value = 0.50),
    numericInput("HSe", 
                "Herd sensitivity:", 
                min = 0, 
                max = 1, 
                value = 0.95),
    numericInput("HSp", 
                "Herd specificity:", 
                min = 0, 
                max = 1, 
                value = 1),
    numericInput("Se", 
                 "Test sensitivity:", 
                 min = 0, 
                 max = 1, 
                 value = 0.80)
  ),
  
  # Show a plot of the generated distribution
  mainPanel(
    tabsetPanel(
      tabPanel("Method 1", 
               includeHTML("block1.html"), verbatimTextOutput("simple"),
               includeHTML("block2.html"), verbatimTextOutput("adjusted"),
               includeHTML("block3.html"), verbatimTextOutput("testcar"),
               downloadButton("downloadPDF", "Download this as a PDF report")),
      tabPanel("EpiR package",
               includeHTML("blockepi1.html"),verbatimTextOutput("epiR_a"))
    ),
    checkboxInput("showSourceCode", 'label' = "Show shiny source code?", 'value' = FALSE)
    , conditionalPanel(
      condition = "input.showSourceCode == true"
      , sourceCode
    )
  )
))
