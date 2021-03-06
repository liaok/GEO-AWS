library(DT)
library(shiny)
library(GEOquery)
library(Biobase)
library(reshape2)
library(survival)
library(affy)
library(limma)

source("stripchart2.R")

shinyServer(function(input, output, session){
  
  source("server-reactives.R", local = TRUE)
  source("server-output.R", local = TRUE)
  
  observe({ 
      if (length(input$Group1Values) == 0) {
          output$selectGroupsMessage <-renderUI({HTML("<h1>Please Choose The Groups to Compare</h1>")})
          output$plot <-renderPlot({NULL})
      } else  {
          output$selectGroupsMessage <-renderText({""})
          output$plot <- renderPlot({
              x = exprInput()[selectedProbe(),]
              iv = input$selectedColumn
              m = match(as.character(iv), colnames(clinicalInput()))  # GD: change grep to match
              clinical = as.character(clinicalInput()[,m])
              selected = c(as.character(input$Group1Values))
              k = clinical%in% selected
    
              y = clinical
              y[!k] = NA
              stripchart2(x,y, col = NULL)
          })
    }
  })  # end observe
  
})