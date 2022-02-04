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

    ini  <- input$ini
    tam  <- input$tam
    fin = ini + tam
    
    
    selecDF <- filter(casosDF, provincia_iso == prov & sexo == sex & grupo_edad == edad)
    
    plot( selecDF[,4+col], lwd = 2, col = 'black', type = 'l', xlab = "Dia", ylab = "Numero de Casos")
    
    abline(v = ini, col = "blue", lty = 2)
    abline(v = fin, col = "blue", lty = 2)

    text(ini, max(selecDF[,4+col])-10, selecDF[ini,4])
    text(fin, max(selecDF[,4+col])-10, selecDF[fin,4])

  })
  
  
  output$zoom <- renderPlot({
    passData()
    
    prov <- input$prov
    sex  <- input$sex
    edad <- input$edad
    col  <- as.integer(input$col)
    
    ini  <- input$ini
    tam  <- input$tam
    fin = ini + tam
    
    selecDF <- filter(casosDF, provincia_iso == prov & sexo == sex & grupo_edad == edad)
    
    plot( ini:fin, selecDF[ini:fin,4+col], lwd = 2, col = 'black', type = 'l', xlab = "Dia", ylab = "Numero de Casos")
    abline(v = ini, col = "blue", lty = 2)
    abline(v = fin, col = "blue", lty = 2)
    
    text(ini, max(selecDF[ini:fin,4+col])-10, selecDF[ini,4])
    text(fin, max(selecDF[ini:fin,4+col])-10, selecDF[fin,4])
    
  })
  
  
  
  
 
  
  session$onSessionEnded(function() {
    stopApp()
  })
  
  
  
})
