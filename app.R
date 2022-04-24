library(shiny)
library(leaflet)
library(tidyverse)
library(shinymanager)

source("helpers.R")
source("creditentials.R")

dameges <- get_dameges()

images <- get_images()

dameges <- left_join(dameges, images)

ui <- fillPage(
  includeCSS("www/style.css"),
  leafletOutput("map", width = "100%", height = "100%")
) %>% secure_app()

server <- function(input, output, session) {
  
  res_auth <- secure_server(
    check_credentials = check_credentials(credentials)
  )
  
  output$map <- renderLeaflet({
    leaflet() %>%
      addProviderTiles(providers$Stamen) %>%
      addMarkers(
        clusterOptions = markerClusterOptions(
          iconCreateFunction=JS(set_clusters_class)
        ),
        data = dameges, 
        popup = ~ html
      )
  })
}

shinyApp(ui, server)
