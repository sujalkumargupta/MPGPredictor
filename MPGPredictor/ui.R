#
# ui.R -- Car Fuel Efficiency (MPG) Predictor
# Developing Data Products -- Course Project
#
library(shiny)

shinyUI(fluidPage(

    titlePanel("Car Fuel Efficiency (MPG) Predictor"),

    sidebarLayout(
        sidebarPanel(
            h4("1. Describe your car"),

            sliderInput("wt", "Weight (in 1000 lbs):",
                        min = 1.5, max = 5.5, value = 3.0, step = 0.1),

            sliderInput("hp", "Gross horsepower:",
                        min = 50, max = 340, value = 120, step = 5),

            radioButtons("am", "Transmission type:",
                         choices = c("Automatic" = 0, "Manual" = 1),
                         selected = 0, inline = TRUE),

            h4("2. Choose what to show"),

            checkboxInput("showCars", "Show the 32 cars from the dataset on the plot",
                          value = TRUE),

            checkboxInput("showLine", "Show the model's prediction line",
                          value = TRUE),

            hr(),
            helpText("Results update automatically as you move the sliders.",
                     "Open the 'How to use' tab for full instructions.")
        ),

        mainPanel(
            tabsetPanel(
                tabPanel("Prediction",
                    br(),
                    h3("Predicted fuel efficiency"),
                    h2(textOutput("predMpg"), style = "color:#1f6f8b;"),
                    textOutput("predKmpl"),
                    textOutput("predInterval"),
                    br(),
                    plotOutput("mpgPlot", height = "380px")
                ),

                tabPanel("Model details",
                    br(),
                    p("The prediction comes from a multiple linear regression",
                      "fitted on the built-in R dataset", code("mtcars"), ":"),
                    code("mpg ~ wt + hp + am"),
                    br(), br(),
                    verbatimTextOutput("modelSummary")
                ),

                tabPanel("How to use",
                    br(),
                    h3("What does this app do?"),
                    p("It estimates how many miles per gallon (MPG) a car will",
                      "give, based on three simple facts about the car:",
                      "its weight, its horsepower and its transmission type."),

                    h3("Step-by-step instructions"),
                    tags$ol(
                        tags$li(strong("Weight:"), " move the first slider to your",
                                " car's weight in thousands of pounds",
                                " (e.g. 3.0 = 3000 lbs ≈ 1360 kg)."),
                        tags$li(strong("Horsepower:"), " move the second slider to",
                                " the engine's horsepower."),
                        tags$li(strong("Transmission:"), " pick Automatic or Manual."),
                        tags$li(strong("Read the result:"), " the 'Prediction' tab",
                                " shows the predicted MPG, the same value in km",
                                " per litre, and a 95% prediction interval",
                                " (the range the true value is likely to fall in)."),
                        tags$li(strong("Plot:"), " the red point is your car. Grey",
                                " points are the real cars in the dataset. The",
                                " blue line shows how MPG changes with weight",
                                " for your chosen horsepower and transmission.",
                                " Use the two checkboxes to show or hide them."),
                        tags$li(strong("Model details:"), " this tab shows the",
                                " regression summary for curious users.")
                    ),

                    h3("How is the prediction calculated?"),
                    p("Every time you change an input, server.R plugs your values",
                      "into a linear regression model fitted on the",
                      code("mtcars"), "dataset (32 cars from 1973-74 road",
                      "tests by Motor Trend magazine) and returns the result."),

                    h3("Tips"),
                    tags$ul(
                        tags$li("Heavier cars and more powerful engines give lower MPG."),
                        tags$li("Values far outside the dataset (e.g. very light",
                                " cars with huge horsepower) are extrapolations",
                                " and less reliable.")
                    )
                )
            )
        )
    )
))
