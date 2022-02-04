library(shiny)


shinyUI(fluidPage(
    
  titlePanel("CURSO DE INVIERNO - EJEMPLO 6"),
  
 sidebarLayout(
    sidebarPanel(

      
      sliderInput("ini", 
                  "Inicio Ola:", 
                  value = 200,
                  min = 1, 
                  max = 700),
      
      sliderInput("tam", 
                  "Longitud Ola:", 
                  value = 150,
                  min = 1, 
                  max = 200),
      
      radioButtons("col", h3("Mostrar"),
                   choices = list("Casos" = "num_casos", "Hospitalizaciones" = "num_hosp",
                                  "UCI" = "num_uci", "Defunciones" = "num_def"),selected = "num_casos"),
      
      radioButtons("sex", h3("Sexo"),
                   choices = list("Todos" = "T",  "Hombre" = "H", "Mujer" = "M",
                                  "NC" = "NC"),selected = "T"),
      
      selectInput("prov", label = h3("Provincia"),
                  choices = list("ACoruna" = "C",
                                 "Alava" = "VI",
                                 "Albacete" = "AB",
                                 "Alicante" = "A",
                                 "Almeria" = "AL",
                                 "Asturias" = "O" ,
                                 "Avila" = "AV" ,
                                 "Badajoz" = "BA",
                                 "Barcelona" = "B" ,
                                 "Bizkaia" = "BI",
                                 "Burgos" = "BU",
                                 "Caceres" = "CC",
                                 "Cadiz" = "CA",
                                 "Cantabria" = "S",
                                 "Castellon" = "CS",
                                 "Ciudad Real" = "CR",
                                 "Cordoba" = "CO",
                                 "Cuenca" = "CU",
                                 "Gipuzkoa" = "SS",
                                 "Girona" = "GI",
                                 "Granada" = "GR",
                                 "Guadalajara" = "GU",
                                 "Huelva" = "H",
                                 "Huesca" = "HU",
                                 "Illes Balears" = "PM" ,
                                 "Jaen" = "J" ,
                                 "La Rioja" = "LO",
                                 "Las Palmas" = "GC" ,
                                 "Leon" = "LE",
                                 "Lleida" = "L",
                                 "Lugo" = "LU",
                                 "Madrid" = "M",
                                 "Malaga" = "MA",
                                 "Murcia" = "MU",
                                 "Navarra" = "NA",
                                 "Ourense" = "OR",
                                 "Palencia" = "P",
                                 "Pontevedra" = "PO",
                                 "Salamanca" = "SA",
                                 "Santa Cruz de Tenerife" = "TF",
                                 "Segovia" = "SG",
                                 "Sevilla" = "SE",
                                 "Soria" = "SO",
                                 "Tarragona" = "T" ,
                                 "Teruel" = "TE" ,
                                 "Toledo" = "TO",
                                 "Valencia" = "V" ,
                                 "Valladolid" = "VA",
                                 "Zamora" = "ZA",
                                 "Zaragoza" = "Z"
                                 
                  ),
                  selected = "M"),
      
      selectInput("edad", label = h3("Grupo Edad"),
                  choices = list("Todos" = "todos",
                                 "0-9" = "0-9",
                                 "10-19" = "10-19",
                                 "20-29" = "20-29",
                                 "30-39" = "30-39",
                                 "40-49" = "40-49",
                                 "50-59" = "50-59" ,
                                 "60-69" = "60-69" ,
                                 "70-79" = "70-79",
                                 "80+" = "80+" ,
                                 "NC" = "NC"
                  ),
                  selected = "todos"),
      
      checkboxGroupInput("compGrupo", 
                         h3("Comparativa"), 
                         choices = list("Barcelona" = "B",
                                        "Badajoz" = "BA",
                                        "Madrid" = "M", 
                                        "Malaga" = "MA",
                            
                                        "Valencia" = "V"),
                         selected = "B")
 
   
      
    ),
    
    mainPanel(
      tabsetPanel(type = "tabs", 
                  tabPanel("SerieTemporal", plotOutput("st", height = 800)), 
                  tabPanel("Zoom", plotOutput("zoom", height = 800)),
                  tabPanel("Comparativa", plotOutput("comp", height = 800)),
                  tabPanel("CompZOOM", plotOutput("compzoom", height = 800)),
                  tabPanel("Regresion", plotOutput("reg", height = 800)),
                  tabPanel("Residuos", plotOutput("res", height = 800)),
                  tabPanel("Mapa", plotOutput("mapa", height = 800))
                                             
        
      )
    )
  )
))
