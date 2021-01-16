
# a plot of sales by year, where we can filter by the genre, publisher and console of interest

# a plot of critic and user reviews over time showing where critics agree and disagree, we can then filter by genre, publisher and console of interest
library(shiny)



shinyUI(fluidPage(
    sidebarLayout(
        
# Sidebar - top stats, 5 wellpanels
        sidebarPanel(
# top seller
            wellPanel(
                ...
            ),
# Total sales this year
            wellPanel(
                ...
            ),
# Most popular genre for critics
            wellPanel(
                ...
            ),
# Most popular genre for users
            wellPanel(
                ...
            ),
# Highest rated title ever (combine user and critic)
            wellPanel(
                ...
            ),
# end sidebar panel    
        ),

# main panel - 3 rows
        mainPanel(
# row one - dropdowns
            fluidRow(
# genre dropdown
                selectInput(
                    label = "Genre",
                    choices = list_genre,
                    multiple = T,
                    selected = list_genre
                ),
# platform dropdown
                selectInput(
                    label = "Platform",
                    choices = list_platform,
                    multiple = T,
                    selected = list_platform
                ),
# publisher dropdown
                selectInput(
                    label = "Publisher",
                    choices = list_publisher,
                    multiple = T,
                    selected = list_publisher
                ),

                
            )
            
# row two - 2 x graphs, 6 cols each
            
# row three - plot of num games published each year - for visual more than info
        )
    )
))
