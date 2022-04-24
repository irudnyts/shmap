library(shiny)
library(leaflet)
library(tidyverse)
library(shinymanager)
library(shinythemes)

source("helpers.R")
source("creditentials.R")

dameges <- get_dameges()

images <- get_images()

dameges <- left_join(dameges, images)

ui <- fillPage(
  includeCSS("www/style.css"),
  leafletOutput("map", width = "100%", height = "100%"), 
  absolutePanel(
    fixed = TRUE,
    draggable = TRUE,
    top = 60,
    left = "auto",
    right = 20,
    bottom = "auto",
    width = 330,
    height = "auto",
    wellPanel(
      textOutput("name")
    )
  ),
  theme = shinytheme("slate")
) %>% secure_app(
  theme = shinytheme("slate")
)

server <- function(input, output, session) {
  
  res_auth <- secure_server(
    check_credentials = check_credentials(credentials)
  )
  
  output$map <- renderLeaflet({
    leaflet() %>%
      addProviderTiles(providers$Stamen) %>%
      addMarkers(
        clusterOptions = markerClusterOptions(
          iconCreateFunction = JS(set_clusters_class),
          showCoverageOnHover = FALSE
        ),
        icon = list(
          iconUrl = 'pin.png',
          iconSize = c(60, 60)
        ),
        data = dameges, 
        popup = ~ html, 
        layerId = ~ object_id
      )
  })
  
  output$name <- renderText({
    req(input$map_marker_click)
    input$map_marker_click$id
  })
}

shinyApp(ui, server)
