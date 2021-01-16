#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
# sales plot
    output$sales <- renderPlot({
        
    })
    
# reviews plot
    output$reviews <- renderPlot({
        
    })
    
# numbers plot
    output$numbers <- renderPlot(
        sales %>% 
            filter(year > 1995) %>% 
            ggplot() +
            aes(x = year) +
            geom_histogram() +
            theme_linedraw()
    )

# end shiny server and function
})
