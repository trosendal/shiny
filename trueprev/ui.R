library(shiny)
library(epiR)

# Define UI for application 
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Estimate true prevalence"),
  
  # Sidebar with inputs
  sidebarPanel(
    numericInput("nunit", "Number of units tested:", 1000),
    numericInput("npos", 
                 "The number of test positive units:", 
                 value = 100),
    numericInput("confidence", 
                 "Confidence interval:", 
                 min = 0, 
                 max = 1, 
                 value = 0.95),    
    numericInput("Se", 
                "Unit sensitivity:", 
                min = 0, 
                max = 1, 
                value = 0.99),
    numericInput("Sp", 
                "Unit specificity:", 
                min = 0, 
                max = 1, 
                value = 0.99),br(),
    tableOutput("table")
  ),
  
  # Define the main panel, 2 Tabs and a checkbox that appears outside the tabs
  mainPanel(plotOutput("simple")
  )
))
