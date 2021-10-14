#' @title Enhanced Ensemble Features Ranking
#'
#' @description Takes a dataset and outputs a features name list inversely ordered by relevance
#' @param dataset dataset with numerial features and binary categorical class, named 'class'
#' @param ... optional parameters: \cr
#' nRows - number of rows of each dataset partition, 10 default value \cr
#' nTries - number of runs, ncol(dataset) / 2, default value \cr
#' cutOff - = n (selects n features); =0 (selects all features); =-1 (automatic selecion) default \cr
#' methods - list of filter functions (ensemble) for feature evaluation, default list(gain.ratio,symmetrical.uncertainty,chi.squared, random.forest.importance)
#' @import FSelector
#' @export
#' @return features names list inversely ordered by relevance
#' @examples \dontrun{
#' }
#' data(allDataProbe)
#' library(FSelector)
#' set.seed(134)
#' nRows=nrow(allDataProbe)/2
#' methods <- list(gain.ratio,chi.squared)
#' features <- ensemble.features.ranking(allDataProbe, nRows=nRows,
#' nTries=20, cutOff= -1, methods=methods)
#' print(features)
#'

ensemble.features.ranking <- function(dataset, ... ){
    argList<-list(...)
    if(is.null(argList$methods) ){
        methods<-list(gain.ratio,symmetrical.uncertainty,chi.squared, random.forest.importance)
    }else{
        methods<-argList$methods
    }
    if(is.null(argList$cutOff)){
        cutOff <- -1
    }else{
        cutOff<-argList$cutOff
    }
    if(is.null(argList$nRows)){
        nRows <- nrow(dataset)/2
    }else{
        nRows<-argList$nRows
    }
    if(is.null(argList$nTries)){
        nTries <- 10
    }else{
        nTries<-argList$nTries
    }
    randomRowsN<-getNRandomsRowsSubsets(nrow(dataset),nRows,nTries)
    n<-ncol(dataset)
    weightPerGroup<-c(n:1)
    weightPerGroup<-floor(weightPerGroup*sqrt(weightPerGroup)/sqrt(n)) #Hcg, add no linearity
    weightsList<-{}
    weightsEns<- lapply(methods, function(filter){calculateWeightsSampling(dataset, randomRowsN, filter, c(1:ncol(dataset)))})

    for( i in 1:length(methods)){
        weightsList<-rbind(weightsList,as.data.frame(weightsEns[i]))
    }
    RankEns<-calculateRankSampling(weightsList,
                                   colnames(dataset[,!(colnames(dataset) %in% c('class'))]),
                                   weightPerGroup,cutOff)
    return(RankEns)
}


