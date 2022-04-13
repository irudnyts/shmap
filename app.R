library(shiny)
library(leaflet)

ui <- fillPage(
    tags$style(type = "text/css", "html, body {width:100%; height:100%}"),
    leafletOutput("map", width = "100%", height = "100%")
    
)

server <- function(input, output, session) {

    output$map <- renderLeaflet({
        leaflet() %>%
            addProviderTiles(providers$Stamen.Toner)
    })
}

shinyApp(ui, server)
