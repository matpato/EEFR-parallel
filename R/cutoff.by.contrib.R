#' @title Cutoff by Contrib
#'
#' @description cutoff.by.contrib is an alternative to Fselector cutoff.biggest.diff.
#' It selects all features that have contribution higher that an uniform contribution.
#' @param attrs a data.frame containing features weights to be sorted and selected
#' @param contrib selection factor close to 1, subsets all features with contribution > uniform contribution * contrib
#' @return featurenames subset, inverse ordered by its weights
#'

cutoff.by.contrib <- function(attrs, contrib=1){
    if(dim(attrs)[1] == 0)
        return(character(0))
    else if(dim(attrs)[1] == 1)
        return(dimnames(attrs)[[1]])
    perm = order(attrs[,1], decreasing = TRUE)
    attrs = attrs[perm, , drop = FALSE]
    #plot(attrs[,1], ylab="weights")
    minContrib = sum(attrs)/dim(attrs)[1]
    contributrs = sapply(1:(dim(attrs)[1]), function(idx) {
        attrs[idx, 1] > minContrib * contrib
    })
    return(dimnames(attrs)[[1]][contributrs])
}
