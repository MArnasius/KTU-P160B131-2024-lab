library(shiny)
library(tidyverse)

ui <- fluidPage(
  titlePanel("Veiklos sritis: 494100"),
  sidebarLayout(
    sidebarPanel(
      selectizeInput("kodas",
                     "Pasirinkite įmonę iš sąrašo",
                     choices = NULL),
      
    ),
    mainPanel(
      
      plotOutput("plot")
    )
  )
)

server <- function(input, output, session) {
  data <- readRDS("../data/494100.rds")
  # padarymas, kad nerodytu imoniu, kuriu duomenu nera.
  data=data %>% filter(is.na(avgWage)==FALSE)
  
  updateSelectizeInput(session, "kodas", choices = data$name , server = TRUE)
  
  
   output$plot <- renderPlot(
     data %>%
       filter(name == input$kodas) %>%
     ggplot(aes(x = ym(month), y = avgWage)) +
     geom_point(col = 'blue') +
     geom_line(col = 'yellow') +
     labs(x = "Mėnesis", y = "Vid. atlygis")
     )
  }
shinyApp( ui = ui, server = server )
  
