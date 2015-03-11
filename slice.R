'
Script      : Slicer
Created     : February, 2015
Author(s)   : iHub Research
Version     : v1.0
License     : Apache License, Version 2.0

Description : the slicer slices data fetched from the DB and returns the ones 
              highly relevant to keyword given.
'
# load pre-defined scripts
source('database.R')
source('util.R')


# define slicer function
Slicer <-function(keyword, number, csv=FALSE, db.table='tweet_data') {
  # ==========================================================================
  #            slice data from database based on keyword
  #
  # Args:
  #   keyword (string)  : keyword to be searched for. Data containing keyword
  #                       is retrieved from database.
  #   number (integer)  : limit of database rows to fetch
  #   csv (boolean)     : switch for csv output
  #   db.table (string) : name of database table from which to fetch data
  #
  # Returns:
  #   data (data.frame) : if CSV option is FALSE
  #   None              :  if CSV option is TRUE, data is written out to file
  # ==========================================================================
  
  # load data from database
  sql <-paste("SELECT * FROM ", db.table, " WHERE [text] like '%", keyword, 
              "%' LIMIT ", number, "", sep="")
  data <- GetQuery(sql)
  
  # get text column
  text.data <- data['text']
  
  
  # create temporary db table to hold text data
  temp.table <- CreateTempTable(text.data)
  
  # create term document matrix
  tdm <- CreateTdm(data$text)
  
  # find associations for keyword
  corr.limit <- GetLowerCorrLimit(text.data, factor=1.0)
  associations <- findAssocs(tdm, keyword, corr.limit)
  
  # query database for associated words
  assoc.df = SubsetDb(associations, keyword, table.name=temp.table)
  
  # filter duplicate entries
  data = FilterDuplicates(assoc.df$text)
  
  # clean up
  dbRemoveTable(db.conn, temp.table)
  
  # save data to file if specified else return data
  if (csv) {
    write.csv(data, sprintf("%s.csv", keyword), row.names=FALSE)
  } else {
    return(data)
  }
   
}
