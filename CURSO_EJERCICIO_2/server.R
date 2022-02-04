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
    
    ini  <- input$ini
    tam  <- input$tam
    fin = ini + tam

    selecDF1 <- filter(casosDF, provincia_iso == prov1 & sexo == sex & grupo_edad == edad)
    selecDF2 <- filter(casosDF, provincia_iso == prov2 & sexo == sex & grupo_edad == edad)
    
    plot(  selecDF1[,4+col], lwd = 1, col = 'black', type = 'l', xlab = "Dia", ylab = "Numero de Casos")
    lines( selecDF2[,4+col], lwd = 1, col = 'blue')
    
    abline(v = ini, col = "blue", lty = 2)
    abline(v = fin, col = "blue", lty = 2)
    
    text(ini, max(selecDF1[ini:fin,4+col])-10, selecDF1[ini,4])
    text(fin, max(selecDF1[ini:fin,4+col])-10, selecDF1[fin,4])
  })
  
  
  output$zoom <- renderPlot({
    passData()
    
    prov1 <- input$prov1
    prov2 <- input$prov2
    sex  <- input$sex
    edad <- input$edad
    col  <- as.integer(input$col)
    
    ini  <- input$ini
    tam  <- input$tam
    fin = ini + tam
    
    selecDF1 <- filter(casosDF, provincia_iso == prov1 & sexo == sex & grupo_edad == edad)
    selecDF2 <- filter(casosDF, provincia_iso == prov2 & sexo == sex & grupo_edad == edad)
    
    plot( ini:fin, selecDF1[ini:fin,4+col], lwd = 1, col = 'black', type = 'l', xlab = "Dia", ylab = "Numero de Casos")
    lines(ini:fin, selecDF2[ini:fin,4+col], lwd = 1, col = 'blue')
    
    abline(v = ini, col = "blue", lty = 2)
    abline(v = fin, col = "blue", lty = 2)
    
    text(ini, max(selecDF1[ini:fin,4+col])-10, selecDF1[ini,4])
    text(fin, max(selecDF1[ini:fin,4+col])-10, selecDF1[fin,4])
    
  })
  
 
  
  session$onSessionEnded(function() {
    stopApp()
  })
  
  
  
})
