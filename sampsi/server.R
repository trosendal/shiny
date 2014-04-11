library(shiny)
library(epiR)
library(knitr)
library(shinyAce)

# Define server logic required to generate and plot a random distribution
shinyServer(function(input, output) {
   
  output$simple <- renderPrint({
    quant <- 1 - (input$confidence/2)
    z <- qnorm(quant, mean = 0, sd = 1)
    tmp1<-((z/input$L)^2)*(input$p*(1-input$p))
    frac1<-tmp1/input$nfarms
    sampsi<-round(tmp1, digits=0)
    sampsi_b<-round(tmp1/(1+(tmp1-1)/input$nfarms), digits=0)
    
    if (frac1>0.1){
      cat("Because you are required to sample more than 10% of the population this sample size is adjusted for a finite population. You will need to sample",sampsi_b, "herds to be", (1-input$confidence)*100, "% confident to estimate the prevelence within", 100*input$L, "% of the true prevalence, given the design prevalence of", input$p*100, "%")
    } else {
      cat("You will need to sample",sampsi, "herds to be", (1-input$confidence)*100, "% confident to estimate the prevelence within", 100*input$L, "% of the true prevalence, given the design prevalence of", input$p*100, "%")
    }
  })
  output$adjusted <- renderPrint({
    quant <- 1 - (input$confidence/2)
    z <- qnorm(quant, mean = 0, sd = 1)
    
    tmpa<-((z/input$L)^2)*
          ((input$HSe*input$p+(1-input$HSp)*(1-input$p))*
          (1-input$HSe*input$p-(1-input$HSp)*(1-input$p)))/
          ((input$HSe+input$HSp-1)^2)
    sampsi_adjusted<-round(tmpa, digits = 0)
    frac1<-tmpa/input$nfarms
    sampsi_adjusted_hf<-round(tmpa/(1+(tmpa-1)/input$nfarms), digits=0)
    
    if (frac1>0.1){
      cat("If the HSe is",input$HSe,"and the HSp is",input$HSp,"You will need to sample",sampsi_adjusted_hf, "herds; this is adjusted for a finite population.")
    } else {
      cat("If the HSe is",input$HSe,"and the HSp is",input$HSp,"You will need to sample",sampsi_adjusted, "herds.")
    }
  })
  output$testcar <- renderPrint({
    quant <- 1 - (input$confidence/2)
    z <- qnorm(quant, mean = 0, sd = 1)
    
    if (input$n_subunit_tested/input$N_subunit>0.1) {
      HSe_calc <- 1- (1- (input$n_subunit_tested*input$Se/input$N_subunit))^(input$p_subunit*input$N_subunit)
    }else{
      HSe_calc <- 1- (1-input$p_subunit*input$Se)^input$n_subunit_tested
    }
    temp<-((z/input$L)^2)*
      ((HSe_calc*input$p+(1-input$HSp)*(1-input$p))*(1-HSe_calc*input$p-(1-input$HSp)*(1-input$p)))/
      ((HSe_calc+input$HSp-1)^2)
    sampsi_adjusted2<-round(temp, digits = 0)
    fraction<-temp/input$nfarms
    sampsi_adjusted3<-round(temp/(1+(temp-1)/input$nfarms), digits=0)
   
    if (fraction>0.1){
      cat("Assuming a Se of",input$Se,", an average herd size of",input$N_subunit,
          ", and that",input$n_subunit_tested," units were collected per herd, then",sampsi_adjusted3,
          "herds should be included in the study. This estimate was adjusted for a finite population siz")
    } else {
      cat("Assuming a Se of",input$Se,", an average herd size of",input$N_subunit,
          ", and that",input$n_subunit_tested," units were collected per herd, then",sampsi_adjusted2,
          "herds should be included in the study.")
    }
    
  })
  
  output$downloadPDF <-
    downloadHandler(filename = "report.pdf",
                    content = function(file){
                      # generate PDF
                      knit2pdf("report.Rnw")
                      
                      # copy pdf to 'file'
                      file.copy("report.pdf", file)
                      
                      # delete generated files
                      file.remove("report.pdf", "report.tex",
                                  "report.aux", "report.log")
                      
                      # delete folder with plots
                      unlink("figure", recursive = TRUE)
                    },
                    contentType = "application/pdf"
    )
  
  output$epiR_a<- renderPrint({
    sampsi<-epi.simplesize(N = input$nfarms, Vsq = NA, Py = input$p,
                           epsilon.r = (input$L/input$p), method = "proportion",
                           conf.level = (1-input$confidence))
    cat("This calculation is a little different than the first sample size in the 'Method 1' tab. You will need to sample",sampsi, "herds. This sample size is adjusted for a finite population size if the sample size is greater than 10% of the population")
  })
  
})

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
