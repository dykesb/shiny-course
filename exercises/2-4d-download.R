# Load packages ----------------------------------------------------------------

library(shiny)
library(ggplot2)
library(dplyr)

# Load data --------------------------------------------------------------------

load("movies.RData")

# Define UI --------------------------------------------------------------------

ui <- fluidPage(
  sidebarLayout(
    
    sidebarPanel(
      
      radioButtons(inputId = "filetype",
                   label = "Select filetype:",
                   choices = c("csv", "tsv"),
                   selected = "csv"),
      
      checkboxGroupInput(inputId = "selected_var",
                         label = "Select variables:",
                         choices = names(movies),
                         selected = c("title"))
      
    ),
    
    mainPanel(
      HTML("Select filetype and variables, then hit 'Download data'."),
      ___("download_data", "Download data")
    )
  )
)

# Define server ----------------------------------------------------------------

server <- function(input, output, session) {
  
  # Download file
  output$___ <- ___(
    filename = function() {
      paste0("movies.", ___)
    },
    content = function(file) { 
      if(___ == "csv"){ 
        write_csv(movies %>% select(input$selected_var), file) 
      }
      if(___ == "tsv"){ 
        write_tsv(movies %>% select(input$selected_var), file) 
      }
    }
  )
  
}

# Create the Shiny app object --------------------------------------------------

shinyApp(ui = ui, server = server)
