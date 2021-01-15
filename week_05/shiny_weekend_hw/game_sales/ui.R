
# a plot of sales by year, where we can filter by the genre, publisher and console of interest

# a plot of critic and user reviews over time showing where critics agree and disagree, we can then filter by genre, publisher and console of interest

# Total sales this year
# Most popular genre for critics
# Most popular genre for users
# Highest rated title ever (combine user and critic)


library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot")
        )
    )
))
