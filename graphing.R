

'
Script    : Visualizer
Created   : November 21, 2015
Author(s) : iHub Research
Version   : v1.0
License   : Apache License, Version 2.0

'


#===========================================================================================
mov_average <-(SMA(x = raila$sentiment_1,n = 20))
mov = as.data.frame(mov_average[21:length(mov_average)])
mov$index = 1:nrow(mov)

colnames(mov) <-c('sentiment_1','index_1')

g <-ggplot(mov, aes(x=mov$index,y=mov$sentiment,color='factor(rating)')) + geom_line()
g
#=========================================================================================

mov_average_1 <-(SMA(x = uhuru$sentiment_2,n = 20))
mov_1 = as.data.frame(mov_average_1[21:length(mov_average_1)])
mov_1$index = 1:nrow(mov_1)

colnames(mov_1) <-c('sentiment_2','index_2')

#merge
bind <- cbind(mov[1:(nrow(mov) - (nrow(mov) - nrow(mov_1))),],mov_1)

#========================================================================================
library(ggthemes)
library(extrafont)

#get fonts
font_import(pattern="[A/a]rial")
font_import(pattern="[C/c]omic")

#load fonts
loadfonts(device="win")

ggplot(bind, aes(index_1)) + 
  xlab("Time")+
  ylab("Sentiment Score")+
  geom_line(aes(y = sentiment_1,color="Red",size=1)) + 
  geom_line(aes(y = sentiment_2,color="Green",size=1)) + 
  theme_solarized(light=FALSE) + 
  scale_colour_solarized("yellow")+
  ggtitle("The Heartbeat of the Crowd\n")+
  theme(text=element_text(size=16, family="Arial"))

ggsave('graphics.png',width = 4, height = 5)
