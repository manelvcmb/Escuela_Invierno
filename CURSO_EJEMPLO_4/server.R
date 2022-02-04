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
    
    
    selecDF <- filter(casosDF, provincia_iso == prov)
    
    if (edad!="todos"){
      selecDF <- filter(selecDF, grupo_edad == edad)
      
    }

    if (sex!="T"){
      selecDF <- filter(selecDF, sexo == sex)
      
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
    
    
    selecDF <- filter(casosDF, provincia_iso == prov )
    
    if (edad!="todos"){
      selecDF <- filter(selecDF, grupo_edad == edad)
      
    }
    
    if (sex != "T"){
      selecDF <- filter(selecDF, sexo == sex)
      
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
  
  
  
  
  output$compzoom <- renderPlot({
    passData()
    
    prov <- input$prov
    sex  <- input$sex
    edad <- input$edad
    col  <- input$col
    cl   <- input$compGrupo
    
    ini  <- input$ini
    tam  <- input$tam
    fin = ini + tam
    

    
    selecDF <- casosDF[ which(casosDF$provincia_iso %in% as.list(cl)==TRUE), ]
    
    
    if (edad!="todos"){
      selecDF <- filter(selecDF, grupo_edad == edad)
      
    }
    
    if (sex != "T"){
      selecDF <- filter(selecDF, sexo == sex)
      
    }
    
    selecDF <- aggregate(x = selecDF[col],
                         FUN = sum,
                         by = list(Prov =  selecDF$provincia_iso , fecha = selecDF$fecha))
    
    
    colnames(selecDF) <- c("Prov", "fecha", "dato")
    
    ggplot(selecDF) + aes(fecha, dato,  group = Prov, color = dato) + 
      geom_line(lwd = 1) +
      theme_gray() +
      theme(legend.position = 'none') + 
      scale_color_gradient(high = 'darkorange', low = 'darkblue') + 
      facet_wrap(vars(Prov)) 
    
  })
  
  
  
  output$comp <- renderPlot({
    passData()
    
    prov <- input$prov
    sex  <- input$sex
    edad <- input$edad
    col  <- input$col
    
    ini  <- input$ini
    tam  <- input$tam
    fin = ini + tam
    
    
    
    selecDF <- casosDF
    
    
    if (edad!="todos"){
      selecDF <- filter(selecDF, grupo_edad == edad)
      
    }
    
    if (sex != "T"){
      selecDF <- filter(selecDF, sexo == sex)
      
    }
    
    selecDF <- aggregate(x = selecDF[col],
                         FUN = sum,
                         by = list(Prov =  selecDF$provincia_iso , fecha = selecDF$fecha))
    
    
    colnames(selecDF) <- c("Prov", "fecha", "dato")
    
    ggplot(selecDF) + aes(fecha, dato,  group = Prov, color = dato) + 
      geom_line(lwd = 1) +
      theme_gray() +
      theme(legend.position = 'none') + 
      scale_color_gradient(high = 'darkorange', low = 'darkblue') + 
      facet_wrap(vars(Prov)) 
    
  })
  
  
  
  
 
  
  session$onSessionEnded(function() {
    stopApp()
  })
  
  
  
})
