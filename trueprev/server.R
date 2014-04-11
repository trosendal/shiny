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

# Define server logic required to generate and plot a random distribution
shinyServer(function(input, output) {
   
  output$simple <- renderPlot({
    CP<-epi.prev(input$npos, input$nunit, se=input$Se,
                 sp=input$Sp, conf.level=input$confidence, method = "c-p")
    ST<-epi.prev(input$npos, input$nunit, se=input$Se,
                 sp=input$Sp, conf.level=input$confidence, method = "sterne")
    BL<-epi.prev(input$npos, input$nunit, se=input$Se,
                 sp=input$Sp, conf.level=input$confidence, method = "blaker")
    WL<-epi.prev(input$npos, input$nunit, se=input$Se,
                 sp=input$Sp, conf.level=input$confidence, method = "wilson")
    temp<-data.frame(t(matrix(unlist(append(CP, values=c(ST, BL, WL))), nrow=3)))
    rownames(temp)<-c("cp_ap", "cp_tr","st_ap", "st_tr", "bl_ap", "bl_tr", "wl_ap", "wl_tr")
    colnames(temp)<-c("point", "low", "high")
    temp<-temp[c(2,4,6,8),]
    temp$x=(1:(nrow(temp)))
    par(mar=c(2,9,3,1))
    title <-"Adjusted prevalence with\nconfidence intervals using 4 methods"
    
    plot(x=temp$point,y=as.factor(c(1,2,3,4)), col="blue", xlim=c(0,1),
         main=title, cex=3, xlab="Adjusted prevalence", pch='|', ylab="", yaxt='n')
    
    for (i in 1:nrow(temp)){
      lines(x=c(temp$low[i],temp$high[i]), y=c(i,i), lwd=3, col='red', lend=1)
    }
    grid()
    axis(side=2, at=temp$x, labels=c("Cloppper-Pearson","Sterne","Blaker","Wilson"), las=2)
    
    points(x=temp$low,y=1:4, pch='|', col='red', cex=2)
    points(x=temp$high,y=1:4, pch='|', col='red', cex=2)
    })

  output$table <- renderTable({
    CP<-epi.prev(input$npos, input$nunit, se=input$Se,
                 sp=input$Sp, conf.level=input$confidence, method = "c-p")
    ST<-epi.prev(input$npos, input$nunit, se=input$Se,
                 sp=input$Sp, conf.level=input$confidence, method = "sterne")
    BL<-epi.prev(input$npos, input$nunit, se=input$Se,
                 sp=input$Sp, conf.level=input$confidence, method = "blaker")
    WL<-epi.prev(input$npos, input$nunit, se=input$Se,
                 sp=input$Sp, conf.level=input$confidence, method = "wilson")
    temp<-data.frame(t(matrix(unlist(append(CP, values=c(ST, BL, WL))), nrow=3)))
    rownames(temp)<-c("Cloppper-Pearson\nApparent prevalence", "Cloppper-Pearson\nActual prevalence",
                      "Sterne Apparent\nprevalence", "Sterne Actual\nprevalence",
                      "Blaker Apparent\nprevalence", "Blaker Actual\nprevalence",
                      "Wilson Apparent\nprevalence", "Wilson Actual\nprevalence")
    colnames(temp)<-c("value", "Lower CI", "Upper CI")
    temp
  })
})