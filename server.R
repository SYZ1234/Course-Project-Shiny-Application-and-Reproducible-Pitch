library(shiny)
library(dplyr)
library(ggplot2)

# 1st step: pass inches to cm
data(iris)
gf <- iris
gf <- gf %>% mutate(Sepal.Length=Sepal.Length*2.54,
                    Sepal.Width=Sepal.Width*2.54,
                    Petal.Width=Petal.Width*2.54)

# linear model
model1 <- lm(Petal.Width ~ Sepal.Length + Sepal.Width + Species, data=gf)

shinyServer(function(input, output) {
      output$pText <- renderText({
            paste("Sepal.Length is",
                  strong(round(input$Sepal.Length, 1)),
                  "cm, and Sepal.Width is",
                  strong(round(input$Sepal.Width, 1)),
                  "cm, then:")
      })
      output$pred <- renderText({
            df <- data.frame(Sepal.Length=input$Sepal.Length,
                             Sepal.Width=input$Sepal.Width,
                             Species=factor(input$Species, levels=levels(gf$Species)))
            Petal.Width <- predict(model1, newdata=df)
            Species <- ifelse(
                  input$Species=="setosa",
                  "versicolor",
                  "virginica"
            )
            paste0(em(strong(Species)),
                   "'s predicted height is going to be around ",
                   em(strong(round(Petal.Width))),
                   " cm"
            )
      })
      output$Plot <- renderPlot({
            Species <- ifelse(
                  input$Species=="setosa",
                  "versicolor",
                  "virginica"
            )
            df <- data.frame(Sepal.Length=input$Sepal.Length,
                             Sepal.Width=input$Sepal.Width,
                             Species=factor(input$Species, levels=levels(gf$Species)))
            Petal.Width <- predict(model1, newdata=df)
            yvals <- c("Sepal.Length", Species, "Sepal.Width")
            df <- data.frame(
                  x = factor(yvals, levels = yvals, ordered = TRUE),
                  y = c(input$Sepal.Length, Species, input$Sepal.Width))
            ggplot(df, aes(x=x, y=y, color=c("black", "black", "black"), fill=c("black", "black", "black"))) +
                  geom_bar(stat="identity", width=0.5) +
                  xlab("") +
                  ylab("Petal length (cm)") +
                  theme_minimal() +
                  theme(legend.position="none")
      })
})