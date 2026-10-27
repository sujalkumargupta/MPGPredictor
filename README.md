# Car Fuel Efficiency (MPG) Predictor

Course Project for **Developing Data Products** (Coursera / Johns Hopkins).

## The app
A Shiny application that predicts a car's fuel efficiency in miles per gallon
from three inputs:

- **Weight** (slider, in 1000 lbs)
- **Horsepower** (slider)
- **Transmission** (radio buttons: Automatic / Manual)

Two checkboxes control what is drawn on the plot.

`server.R` fits the linear regression `mpg ~ wt + hp + am` on the built-in
`mtcars` dataset and, reactively, returns:

- the predicted MPG and the equivalent km per litre
- a 95% prediction interval
- a plot placing the user's car among the 32 cars in the dataset
- the full model summary (Model details tab)

Full user documentation is in the **"How to use"** tab inside the app.

- **Live app:** https://sujalkumargupta.shinyapps.io/MPGPredictor/
- **Pitch presentation (RPubs):** http://rpubs.com/sujalkumargupta/MPGPitch

## Files
| File | Purpose |
|---|---|
| `MPGPredictor/ui.R` | User interface (inputs, tabs, documentation) |
| `MPGPredictor/server.R` | Model fitting and reactive calculations |
| `MPGPitch/MPGPitch.Rpres` | 5-slide R Presenter pitch with embedded R code |

## Run locally
```r
install.packages("shiny")
shiny::runApp("MPGPredictor")
```
