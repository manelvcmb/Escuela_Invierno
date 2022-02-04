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
    col  <- input$col

    ini  <- input$ini
    tam  <- input$tam
    fin = ini + tam
    
    
    selecDF <- filter(casosDF, provincia_iso == prov & sexo == sex)
    
    if (edad!="todos"){
      selecDF <- filter(selecDF, grupo_edad == edad)
      
    }
    
    selecDF <- aggregate(x = selecDF[col],
                         FUN = sum,
                         by = list(fecha = selecDF$fecha))
    
    plot( selecDF[[col]], lwd = 2, col = 'black', type = 'l', xlab = "Dia", ylab = col)
    
    abline(v = ini, col = "blue", lty = 2)
    abline(v = fin, col = "blue", lty = 2)

     text(ini, max(selecDF[[col]])-10, selecDF$fecha[ini])
     text(fin, max(selecDF[[col]])-10, selecDF$fecha[fin])

  })
  
  
  output$zoom <- renderPlot({
    passData()
    
    prov <- input$prov
    sex  <- input$sex
    edad <- input$edad
    col  <- input$col
    
    ini  <- input$ini
    tam  <- input$tam
    fin = ini + tam
    
    
    selecDF <- filter(casosDF, provincia_iso == prov & sexo == sex)
    
    if (edad!="todos"){
      selecDF <- filter(selecDF, grupo_edad == edad)
      
    }
    
    selecDF <- aggregate(x = selecDF[col],
                         FUN = sum,
                         by = list(fecha = selecDF$fecha))
    
    plot( ini:fin, selecDF[ini:fin,2], lwd = 2, col = 'black', type = 'l', xlab = "Dia", ylab = "Numero de Casos")
    abline(v = ini, col = "blue", lty = 2)
    abline(v = fin, col = "blue", lty = 2)
    
    text(ini, max(selecDF[ini:fin,2])-10, selecDF[ini,1])
    text(fin, max(selecDF[ini:fin,2])-10, selecDF[fin,1])
    
  })
  
  
  
  
 
  
  session$onSessionEnded(function() {
    stopApp()
  })
  
  
  
})
