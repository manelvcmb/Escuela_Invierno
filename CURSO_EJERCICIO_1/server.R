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
    
    prov1 <- input$prov1
    prov2 <- input$prov2
    sex  <- input$sex
    edad <- input$edad
    col  <- as.integer(input$col)

    selecDF1 <- filter(casosDF, provincia_iso == prov1 & sexo == sex & grupo_edad == edad)
    selecDF2 <- filter(casosDF, provincia_iso == prov2 & sexo == sex & grupo_edad == edad)
    
    plot( selecDF1[,4+col], lwd = 1, col = 'black', type = 'l', xlab = "Dia", ylab = "Numero de Casos")
    lines(selecDF2[,4+col], lwd = 1, col = 'blue')
    
  })
  
 
  
  session$onSessionEnded(function() {
    stopApp()
  })
  
  
  
})
