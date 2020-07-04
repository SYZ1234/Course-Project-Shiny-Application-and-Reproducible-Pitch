library(shiny)

#https://zsy1234.shinyapps.io/untitled_folder/

#library(shiny)
#runApp()

#library(rsconnect)
#deployApp()

shinyUI(fluidPage(
      titlePanel("Predicting Petal.Width"),
      sidebarLayout(
            sidebarPanel(
                  helpText("Predicting Petal.Width"),
                  helpText("Parameters:"),
                  sliderInput(inputId = "Sepal.Length",
                              label = "Sepal.Length:",
                              value = 5,
                              min = 4.3,
                              max = 7.9,
                              step = 0.1),
                  sliderInput(inputId = "Sepal.Width",
                              label = "Sepal.Width:",
                              value = 3,
                              min = 2,
                              max = 4.4,
                              step = 0.1),
                  radioButtons(inputId = "Species",
                               label = "Species:",
                               choices = c("setosa"="setosa", "versicolor"="versicolor", "virginica"="virginica"),
                               inline = TRUE)
            ),
            
            mainPanel(
                  htmlOutput("pText"),
                  htmlOutput("pred"),
                  plotOutput("Plot", width = "50%")
            )
      )
))