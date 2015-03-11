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


t0 = Sys.time()
res <- Slicer('kisumu', 1000, csv=TRUE)
t1 = Sys.time() - t0

t1


