#' @title Sample features weights
#'
#' @description for each sample calculate feature weights based on functionTouse metrics
#' @param dataset original
#' @param RandomRows N subset index rows
#' @param functionToUse statistical function to use as relevancy metric of each feature
#' @param features list of features names
#' @return N x M list of weights
#' @import future.apply
#' @importFrom future plan
#'

calculateWeightsSampling<-function(dataset, RandomRows, functionToUse, features){
    weightsIG<-{}
    fnames=colnames(dataset)
    plan("multisession")
    #seed <- .Random.seed
    weights <- future_apply(RandomRows, 1, function(x){subsetAllData <- dataset[x, features]; as.matrix(functionToUse(class~., subsetAllData))}, future.seed = TRUE)
    #.Random.seed <- seed
    plan("sequential")
    weightsIG <- as.data.frame(t(weights))
    colnames(weightsIG) <- fnames[!(fnames %in% c("class"))]
    return (weightsIG)
}
