'
Script    : util
Created   : February, 2015
Author(s) : iHub Research
Version   : v2.0
License   : Apache License, Version 2.0
'
CreateTdm <- function(text.data, stopwords='english', 
                      removePunctuation=TRUE, tolower=TRUE) {
  # create corpus
  corpus <-Corpus(VectorSource(text.data))
  
  # create term document matrix 
  tdm <-TermDocumentMatrix(corpus, 
                           control=list(removePunctuation=removePunctuation, 
                                        stopwords=stopwords, tolower=tolower))
  
  return(tdm)
}

FilterDuplicates <- function(text.data) {
  # filter exact duplicates
  text.data <- unique(as.vector(text.data))
  
  # use fuzzy string matching to remove text with similar patterns
  
  # create container for holding indices to remove
  index.to.remove <- c()
  
  
  # find similar String Distance Metric
  for (i in 1:length(text.data)) {
    for (j in 1:length(text.data)) {

      # calculate levenshtein dist
      lv.dist <- stringdist(text.data[i], text.data[j], method='lv')

      # avoid redundancy
      if (i !=j & i-j>=0 ){

      # get index if it's less than max lv distance
      if(length(lv.dist) == 0){
        next # skip iteration is lv.dist is null
        
      } else if (lv.dist <= 140 - nchar(RemoveLink(text.data[i])) & lv.dist != 0) {
        index.to.remove <- rbind(i, index.to.remove)
      }
    }
  }
}
     
  
  # remove indices
  if(length(index.to.remove) != 0) {
    text.data <- text.data[-c(index.to.remove)]
  }
  
  return(text.data)
}

GetLowerCorrLimit <- function(text.data, factor=1.0) {
  # compute optimal lower correlation  limit
  tokens = MC_tokenizer(text.data)
  tokens.unique.len = length(unique(tokens))
  corr.limit = tokens.unique.len / length(tokens) * factor
  
  return(corr.limit)
}

RemoveLink <-function(text){
  text = gsub("http.*", "", text)
  return(text)
}
