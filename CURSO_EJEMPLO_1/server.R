library(shiny)
library(tidyr)
library(dplyr)


pathToData = "C:/Users/Manel/Documents/PROYECTOS/R_PROYECTOS/MATGEN/Datos/casos_hosp_uci_def_sexo_edad_provres.csv"

casosDF = read.csv(pathToData)


shinyServer(function(input, output, session) {
  
  passData <- reactive({
    
  })
  
  
  
  output$st <- renderPlot({
    passData()
    
    prov <- input$prov
    sex  <- input$sex
    edad <- input$edad
    col  <- as.integer(input$col)

    selecDF <- filter(casosDF, provincia_iso == prov & sexo == sex & grupo_edad == edad)
    
    plot( selecDF[,4+col], lwd = 2, col = 'black', type = 'l', xlab = "Dia", ylab = "Numero de Casos")
    
    
  })
  
 
  
  session$onSessionEnded(function() {
    stopApp()
  })
  
  
  
})
