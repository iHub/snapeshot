'
Script    : main
Created   : February, 2015
Author(s) : iHub Research
Version   : v1.0
License   : Apache License, Version 2.0
'
#load pre-defined scripts
source('slice.R')
source('libraries.R')
source('settings.R')
source('slice.R')
source('score.R')

#load
library(TTR)
t0 = Sys.time()
res <- Slicer('raila',1000, csv=FALSE)
t1 = Sys.time() - t0
t1

#sentiment score
raila = as.data.frame(res)

for (i in 1:nrow(raila))
{
  raila$sentiment_1[i] = score(as.character(raila$res[i]))
}

#================================================================================
t0 = Sys.time()
r <- Slicer('uhuru',1000, csv=FALSE)
t1 = Sys.time() - t0
t1


#sentiment score
uhuru = as.data.frame(r)

for (i in 1:nrow(uhuru))
{
  uhuru$sentiment_2[i] = score(as.character(uhuru$r[i]))
}

