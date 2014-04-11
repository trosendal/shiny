library(shiny)
library(epiR)
library(shinyAce)

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
  mainPanel(plotOutput("simple"),
            checkboxInput("showSourceCode", 'label' = "Show shiny source code?", 'value' = TRUE)
            , conditionalPanel(
              condition = "input.showSourceCode == true"
              , sourceCode
            )
  )
))
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