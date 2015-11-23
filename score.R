
'
Script      : Score
Created     : March, 2015
Author(s)   : iHub Research
Version     : v1.0
License     : Apache License, Version 2.0

Description : compute the sentiment of sentence(s)
'
source('sentiment.R')

#load required library
library(tm)
library(stringr)
library(plyr)

sentence = 'KaleSING political leaders led by Kipchumba Murkomen are begging Raila Odinga to save William\nRuto from the Icc!... http://t.co/cyDPDZHJdS'
score <-function(sentence)
{
  c = ComputeSentimentScore(sentence)
  
  d <- strsplit(removeWords(x = as.character(c[1]),words = stopwords(kind = 'SMART')),split = ' ')[[1]]
  d <- d[!d%in%""]
  
  if(c[2] == 0 & c[3] == 0){
    neutral_score = 0.5
    return(neutral_score)
  }
  
  if(c[2] == c[3])
  {
    cc = as.numeric(c[2]) + as.numeric(c[3])
    scored = cc/length(d)
    return(scored)
  }
  if(c[2] > c[3]){
    negative_score = as.numeric(c[2])/length(d)
    return(negative_score)
  }
  
  else{
    if(c[3] > c[2]){
      positive_score = as.numeric(c[3])/length(d)
      if(positive_score < 0.5){
        positive_score = 1 - positive_score
        return(positive_score)
      } else{
        return(positive_score)
      }
    }
  }
}