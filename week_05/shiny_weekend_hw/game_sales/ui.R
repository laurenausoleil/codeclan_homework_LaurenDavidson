
# a plot of sales by year, where we can filter by the genre, publisher and console of interest

# a plot of critic and user reviews over time showing where critics agree and disagree, we can then filter by genre, publisher and console of interest
library(shiny)

shinyUI(fluidPage(
    sidebarLayout(
        
# Sidebar - top stats, 5 wellpanels
        sidebarPanel(
# top seller
            wellPanel(
              top_seller
            ),
# Total sales this year
            wellPanel(
                sales_2016
            ),
# Most popular genre for critics
            wellPanel(
                top_genre_critics
            ),
# Most popular genre for users
            wellPanel(
                top_genre_users
            ),
# Highest rated title ever (combine user and critic)
            wellPanel(
                top_rated
            )
# end sidebar panel    
        ),

# main panel - 3 rows
        mainPanel(
# row one - dropdowns
            fluidRow(
# genre dropdown
                multiInput(inputId = "genre", 
                           label = "Genre", 
                           choices = list_genre, 
                           selected = ,
                           options = list(
                               enable_search = FALSE,
                               non_selected_header = "Options",
                               selected_header = "Selected"
                           )
                ),
# platform dropdown
                multiInput(inputId = "platform", 
                           label = "Platform", 
                           choices = list_platform, 
                           selected = ,
                           options = list(
                               enable_search = FALSE,
                               non_selected_header = "Options",
                               selected_header = "Selected"
                           )
                ),
# publisher dropdown
                multiInput(inputId = "publisher", 
                           label = "Publisher", 
                           choices = list_publisher, 
                           selected = ,
                           options = list(
                               enable_search = FALSE,
                               non_selected_header = "Options",
                               selected_header = "Selected"
                           )
                )
# end row one     
            ),
            
# row two - 2 x graphs, 6 cols each
            fluidRow(
# column one, graph sales
                column(6,
                    plotOutput("sales")
                ),
# column two, graph reviews
                column(6,
                    plotOutput("reviews")
                )
# end row two
            ),
# row three - plot of num games published each year - for visual more than info
            fluidRow(
                plotOutput("numbers",
                           width = "300%",
                           height = "100px")
# end row three                
            )
# end main panel
        )
# end sidebar layout
    )
# end shinyUI and fluidpage
))
