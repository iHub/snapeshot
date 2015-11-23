

shinyUI(fluidPage(
  titlePanel("Snapeshot"),
    mainPanel(
      plotOutput("myplot",width=900,height=400),
      list(tags$head(tags$style("body {background-color: white; }"))
    )
  )
))