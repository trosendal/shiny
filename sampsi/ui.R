library(shiny)
library(epiR)
library(knitr)

# Define UI for application that plots random distributions 
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("A sample size calculator for among-herd prevalence estimates"),
  
  # Sidebar with a slider input for number of observations
  sidebarPanel(
    textInput("disease_name", "Name of the disease:", "Scary Disease-x!"),
    numericInput("nfarms", "Number of farms in the population", 1000),
    numericInput("N_subunit", "Average herd size measured in number of units of analysis:", 25),
    numericInput("n_subunit_tested", "Number of subunits tested per farm:", 5),
    numericInput("confidence", 
                "confidence threshhold for posterior prevalence estimate (p-value):", 
                min = 0, 
                max = 1, 
                value = 0.05),    
    numericInput("L", 
                "desired range of confidence interval of posterior estimate (L):", 
                min = 0, 
                max = 1, 
                value = 0.1),  
    numericInput("p", 
                "estimated among-herd prevalance:", 
                min = 0, 
                max = 1, 
                value = 0.30),
    numericInput("p_subunit", 
                "Estimated within-herd prevalence:", 
                min = 0, 
                max = 1, 
                value = 0.50),
    numericInput("Se", 
                "Test sensitivity:", 
                min = 0, 
                max = 1, 
                value = 0.80),
    numericInput("HSe", 
                "Herd sensitivity:", 
                min = 0, 
                max = 1, 
                value = 0.95),
    numericInput("HSp", 
                "Herd specificity:", 
                min = 0, 
                max = 1, 
                value = 1)
  ),
  
  # Show a plot of the generated distribution
  mainPanel(
    includeHTML("block1.html"), verbatimTextOutput("simple"),
    includeHTML("block2.html"), verbatimTextOutput("adjusted"),
    includeHTML("block2.html"), verbatimTextOutput("testcar"), 
    downloadButton("downloadPDF", "Download shiny PDF report")
  )
))
