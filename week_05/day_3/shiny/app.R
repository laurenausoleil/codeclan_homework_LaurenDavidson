library(shiny)
library(tidyverse)
library(shinythemes)

medals <- read_csv("data/olympics_overall_medals.csv")

ui <- fluidPage(
    theme = shinytheme("yeti"),
    
    tabsetPanel(
 # Dashboard panel       
        tabPanel("Dashboard",
    
            # Title
            titlePanel(tags$b("Five country medal comparison")),
            
            # Row One
            fluidRow(5,
                    
                    selectInput(
                        "season",
                        "What season would you like to explore?",
                        c("Summer", "Winter")
                    ),
                    
                    selectInput(
                        "medal",
                        "What medals are you interested in?",
                        c("Gold", "Silver", "Bronze")
                    )
                    
            ),
            
            # Row two
                fluidRow(
                    plotOutput("medal")
                )
        ),
# Details panel
        tabPanel("Details",
                 br(),
                 "Lots of details here",
                 br(),
                 br(),
                tags$a("Here is a link to the data", href = "https://www.Olympic.org/")
        )
    )
)


server <- function(input, output) {
    
    output$medal <- renderPlot({
        
        medals %>%
            filter(team %in% c("United States",
                               "Soviet Union",
                               "Germany",
                               "Italy",
                               "Great Britain")) %>%
            filter(medal == input$medal) %>%
            filter(season == input$season) %>%
            ggplot() +
            aes(x = team, y = count) +
            geom_col()
    })
    
}

# Run the application 
shinyApp(ui = ui, server = server)