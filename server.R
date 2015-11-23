
library(shiny)
library(ggplot2)


shinyServer(
  function(input, output) {
    output$myplot <- renderPlot({
       g <-ggplot(bind, aes(index_1)) + 
        xlab("Time")+
        ylab("Sentiment Score")+
        geom_line(aes(y = sentiment_1,color="Red")) + 
        geom_line(aes(y = sentiment_2,color="Green")) + 
        theme_solarized(light=FALSE) + 
        scale_colour_solarized("yellow")+
        theme(text=element_text(size=16, family="Arial"))+
        ggtitle('The Heartbeat of the Crowd\n')
       print(g)
    })
  }
)