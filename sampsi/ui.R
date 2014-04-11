## Copyright (C) 2014  Thomas Rosendal
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, version 2 of the License.
##
## The program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

library(shiny)
library(epiR)
library(knitr)
library(shinyAce)

###Format the source code to display

sourceCode <- list(  # or save this in global.R
  aceEditor("ui"
            , value = paste(readLines("ui.R"), collapse="\n")
            , mode = "r"
            , theme = "ambience"
            , height = "100px"
            , readOnly = TRUE
  ), br(),
  aceEditor("server"
            , value = paste(readLines("server.R"), collapse="\n")
            , mode = "r"
            , theme = "ambience"
            , height = "100px"
            , readOnly = TRUE
  )
)



# Define UI for application 
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("A sample size calculator for among-herd prevalence estimates"),
  
  # Sidebar with inputs
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
  
  # Define the main panel, 2 Tabs and a checkbox that appears outside the tabs
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
    checkboxInput("showSourceCode", 'label' = "Show shiny source code?", 'value' = TRUE)
    , conditionalPanel(
      condition = "input.showSourceCode == true"
      , sourceCode
    )
  )
))