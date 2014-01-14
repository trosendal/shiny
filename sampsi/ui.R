library(shiny)

# Define UI for application that plots random distributions 
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("A sample size calculator"),
  
  # Sidebar with a slider input for number of observations
  sidebarPanel(
    numericInput("nfarms", "Number of farms in the population", 1000),
    numericInput("N_subunit", "Average herd size measured in number of units of analysis:", 25),
    numericInput("n_subunit_tested", "Number of subunits tested per farm:", 5),
    sliderInput("confidence", 
                "confidence threshhold for posterior prevalence estimate (p-value):", 
                min = 0, 
                max = 1, 
                value = 0.05),    
    sliderInput("L", 
                "desired range of confidence interval of posterior estimate (L):", 
                min = 0, 
                max = 1, 
                value = 0.1),  
    sliderInput("p", 
                "estimated among-herd prevalance:", 
                min = 0, 
                max = 1, 
                value = 0.30),
    sliderInput("p_subunit", 
                "Estimated within-herd prevalence:", 
                min = 0, 
                max = 1, 
                value = 0.50),
    sliderInput("Se", 
                "Test sensitivity:", 
                min = 0, 
                max = 1, 
                value = 0.80),
    sliderInput("Sp", 
                "Test specificity:", 
                min = 0, 
                max = 1, 
                value = 1),
    sliderInput("HSe", 
                "Herd sensitivity:", 
                min = 0, 
                max = 1, 
                value = 0.95),
    sliderInput("HSp", 
                "Herd specificity:", 
                min = 0, 
                max = 1, 
                value = 1)
  ),
  
  # Show a plot of the generated distribution
  mainPanel(
    verbatimTextOutput("summary")
  )
))
