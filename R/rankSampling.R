#' @title Rank Sampling
#'
#' @description Calculates Feature Ranking List sorted by its relevance
#' @param weights of features list for each metric function for each dataset sample
#' @param featuresNames to be ranked
#' @param weightPerGroup of eachrank
#' @param cutOff : 0 (all features), k (k most ranked features), -1 (automatic k calculation)
#' @return rank subset of features ordered by its relevance
#'


calculateRankSampling <- function(weights, featuresNames,weightPerGroup, cutOff=-1){
    rank<-matrix(ncol=1,nrow=length(featuresNames), dimnames= list(featuresNames,c("Weight")))
    rownames(rank)<-featuresNames
    rank<- apply(rank,c(1,2),function(x){x=0})
    for(i in 1:nrow(weights)){
        auxt<-as.data.frame(t(weights[i,]))
        auxt <- auxt[sample(row.names(auxt), nrow(auxt)), , drop=FALSE]
        aux<-cutoff.k(auxt,nrow(auxt)) #cutoff.biggest.diff
        for( j in 1:length(aux)){
            rank[aux[j],1]<-rank[aux[j],1]+weightPerGroup[j]
        }
    }
    if( cutOff == -1){
        rank <- cutoff.by.contrib(data.frame(rank), 0.99)
        return (rank)
    }else{
        if( cutOff > nrow(rank) |  cutOff < 1  ){
            cutOff<-nrow(rank)
        }
    rank<-cutoff.k(data.frame(rank),cutOff)
    return (rank)
    }
}
