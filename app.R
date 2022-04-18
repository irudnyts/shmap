library(shiny)
library(leaflet)
library(tidyverse)

dameges <- tibble(
    type = c("school", "school"),
    name = c("School #17", "School #35"),
    latitude = c(50.02146036833384, 49.936112353184306), 
    longitude = c(36.32800614300417, 36.251797616496205)
)

dameges[1, 2] <- '
<div class="scroll-container">
  <div class="gridscroll">
      <img src="/schools/17/1.jpg">
      <img src="/schools/17/2.jpg">
      <img src="/schools/17/3.jpg">
      <img src="/schools/17/4.jpg">
      <img src="/schools/17/5.jpg">
      <img src="/schools/17/6.jpg">
      <img src="/schools/17/7.jpg">
  </div>
</div>
'

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
