#
# server.R -- Car Fuel Efficiency (MPG) Predictor
# Developing Data Products -- Course Project
#
library(shiny)

data(mtcars)

# Fit the model once, when the app starts
fit <- lm(mpg ~ wt + hp + am, data = mtcars)

shinyServer(function(input, output, session) {

    # Reactive: build a one-row data frame from the user's inputs
    newCar <- reactive({
        data.frame(wt = input$wt,
                   hp = input$hp,
                   am = as.numeric(input$am))
    })

    # Reactive: prediction with 95% prediction interval
    prediction <- reactive({
        predict(fit, newdata = newCar(), interval = "prediction", level = 0.95)
    })

    output$predMpg <- renderText({
        paste0(sprintf("%.1f", prediction()[1, "fit"]), " miles per gallon")
    })

    output$predKmpl <- renderText({
        # 1 mile per US gallon = 0.425144 km per litre
        paste0("That is about ", sprintf("%.1f", prediction()[1, "fit"] * 0.425144),
               " km per litre.")
    })

    output$predInterval <- renderText({
        p <- prediction()
        paste0("95% prediction interval: ", sprintf("%.1f", max(p[1, "lwr"], 0)),
               " to ", sprintf("%.1f", p[1, "upr"]), " MPG.")
    })

    output$mpgPlot <- renderPlot({
        p <- prediction()
        plot(mtcars$wt, mtcars$mpg,
             type = "n",
             xlim = c(1.5, 5.5), ylim = c(0, 40),
             xlab = "Weight (1000 lbs)", ylab = "Miles per gallon",
             main = "Your car (red) compared with the mtcars dataset")

        if (input$showCars) {
            points(mtcars$wt, mtcars$mpg, pch = 16, col = "grey55", cex = 1.3)
        }

        if (input$showLine) {
            wtGrid <- seq(1.5, 5.5, by = 0.05)
            lineData <- data.frame(wt = wtGrid, hp = input$hp,
                                   am = as.numeric(input$am))
            lines(wtGrid, predict(fit, newdata = lineData), col = "#1f6f8b", lwd = 2)
        }

        points(input$wt, p[1, "fit"], pch = 18, col = "red", cex = 3)

        legend("topright", bty = "n",
               legend = c("Cars in dataset", "Model line", "Your car"),
               pch = c(16, NA, 18), lty = c(NA, 1, NA), lwd = c(NA, 2, NA),
               col = c("grey55", "#1f6f8b", "red"))
    })

    output$modelSummary <- renderPrint({
        summary(fit)
    })
})
