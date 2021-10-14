#' @title Get N random Samples
#'
#' @description Get N random row indexes subsets
#' @param nRows dataset number of rows
#' @param size dataset partition number of rows
#' @param iterations number of partitions (N)
#' @return N dataset row indexes partitions
#'


getNRandomsRowsSubsets<-function(nRows, size, iterations){
    randomRowsN<-{}
    nIterations <- iterations
    for( i in 1:nIterations){
        randomRowsN<-rbind(randomRowsN,c(sample(nRows, size)))
    }
    return(randomRowsN)
}
