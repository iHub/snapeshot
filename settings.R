'
Script    : settings
Created   : February, 2015
Author(s) : iHub Research
Version   : v2.0
License   : Apache License, Version 2.0
'

# set working directory
setwd('/Users/hp/Desktop/slicer/')

# define global constants
kMaxLevenshteinDistance <- 20

# setup sqlite database
db.drv <- dbDriver('SQLite')
db.conn <- dbConnect(db.drv,'twitter2.sqlite')

