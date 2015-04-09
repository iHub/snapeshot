'
Script    : database
Created   : February, 2014
Author(s) : iHub Research
Version   : v1.0
License   : Apache License, Version 2.0
'

# extract tweets from database
GetText <- function(keyword, number, db.table='tweet_data') {
  # fetch text column from a db query result
    
  sql <-paste("SELECT * FROM ",db.table," WHERE [text] like '%",keyword,"%' LIMIT ", number,"", sep="")
      
  return(GetQuery(sql)['text'])
}

# create temporary table
CreateTempTable <- function(data, table.name='intermediate', conn=db.conn) {
  if(dbExistsTable(conn, table.name)) {
    dbRemoveTable(conn, table.name)
  } else {
    dbWriteTable(conn, table.name, data)
  }
  
  return(table.name)
}

# subset data from database
SubsetDb <- function(assoc_words, event, table.name='intermediate') {
  df = data.frame()
  for (rn in rownames(assoc_words)) {
    qry_str = paste("SELECT * FROM ", table.name, " WHERE [text] like '%", 
                    event, "%'","AND [text] like '% ", rn, "%'" ,sep="")
    df_tmp <- GetQuery(qry_str)
    df <-rbind(df,df_tmp)
  }
  return(df)
}


GetQuery <- function(query, conn=db.conn) {
  # run a query on a database connection and return the result
  # Args: query : sql statement, conn : database connection
  
  return(dbGetQuery(conn, query)) 
}

