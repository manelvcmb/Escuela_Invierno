library(pacman)

p_load(tidyr, dplyr, readr, shiny, ggplot2, mapSpain, scales)


covidDF = read_csv('https://cnecovid.isciii.es/covid19/resources/casos_hosp_uci_def_sexo_edad_provres.csv')

pathToData = "C:/Users/Manel/Documents/PROYECTOS/R_PROYECTOS/MATGEN/Datos/casos_hosp_uci_def_sexo_edad_provres.csv"

write.csv(covidDF, pathToData, row.names = FALSE)







