library(shiny)
library(leaflet)
library(tidyverse)

dameges <- tibble(
    type = c("school", "school"),
    name = c("School #17", "School #35"),
    latitude = c(50.02146036833384, 49.936112353184306), 
    longitude = c(36.32800614300417, 36.251797616496205)
)

ui <- fillPage(
    includeCSS("www/style.css"),
    leafletOutput("map", width = "100%", height = "100%")
    
)

server <- function(input, output, session) {

    output$map <- renderLeaflet({
        leaflet() %>%
            # addProviderTiles(providers$Stamen) %>% 
            addProviderTiles(providers$OpenStreetMap) %>% 
            addMarkers(
                data = dameges, 
                popup = ~ name
            )
    })
}

shinyApp(ui, server)
