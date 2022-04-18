library(shiny)
library(leaflet)
library(tidyverse)

source("helpers.R")

dameges <- get_dameges()

images <- get_images()

dameges <- left_join(dameges, images)

ui <- fillPage(
  includeCSS("www/style.css"),
  leafletOutput("map", width = "100%", height = "100%")
  
)

server <- function(input, output, session) {
  
  output$map <- renderLeaflet({
    leaflet() %>%
      addProviderTiles(providers$Stamen) %>% 
      # addProviderTiles(providers$OpenStreetMap) %>% 
      addMarkers(
        clusterOptions = markerClusterOptions(),
        data = dameges, 
        popup = ~ html
      )
  })
}

shinyApp(ui, server)
