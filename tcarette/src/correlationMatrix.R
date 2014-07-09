#### load data
#load("/Users/herveschnegg/Dropbox/Backup/Private/Projects/ML/DataKind/DataDive2014/Buttle_GH/tcarette/data/termDocMatrix_InDebtApproved.RData")
load("/Users/herveschnegg/Dropbox/Backup/Private/Projects/ML/DataKind/DataDive2014/Buttle_GH/tcarette/data/termDocMatrix_MissingPending.RData")
load("/Users/herveschnegg/Dropbox/Backup/Private/Projects/ML/DataKind/DataDive2014/Buttle_GH/tcarette/data/word_count_MissingPending.RData")

library(tm)
library(Matrix)

#hs <- findAssocs(tdm, c("aim", "alcohol"), 0.1)
#correlationMatrix <- findAssocs(tdm, tdm$dimnames$Terms, 0.1)
#correlationMatrix <- findAssocs(tdm, c("fami"), 0.1)

tdmSparse <- Matrix(tdm, sparse=TRUE, ncol=tdm$ncol)
rownames(tdmSparse) <- tdm$dimnames$Terms
colnames(tdmSparse) <- tdm$dimnames$Docs

sparse.cor <- function(x){
    n <- nrow(x)
    m <- ncol(x)
    ii <- unique(x@i)+1 # rows with a non-zero element

    Ex <- colMeans(x)
    nozero <- as.vector(x[ii,]) - rep(Ex,each=length(ii)) # colmeans

    covmat <- ( crossprod(matrix(nozero,ncol=m)) + crossprod(t(Ex))*(n-length(ii))
               )/(n-1)
    sdvec <- sqrt(diag(covmat))
    covmat/crossprod(t(sdvec))
}

correlationMatrix <- sparse.cor(x=tdmSparse)

correlationMatrix <- Reduce(x=lapply(X=tdm$dimnames$Terms,
                                     FUN=function(x) {findAssocs(tdm, x, 0)}),
                            f=cbind)
for (i in 1:length(tdm$i)) {
    for (j in 1:length(tdm$j)) {
        if () {
        }
    }
}
