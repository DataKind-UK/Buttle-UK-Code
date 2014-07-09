#### load data
#load("/Users/herveschnegg/Dropbox/Backup/Private/Projects/ML/DataKind/DataDive2014/Buttle_GH/tcarette/data/termDocMatrix_InDebtApproved.RData")
library("data.table", lib.loc="/usr/local/Cellar/r/3.0.3/R.framework/Versions/3.0/Resources/library")

data.dir="~/Documents/Codes/ButtleUK/tcarette/data"

segVar="InDebtApproved"
#segVar="MissingPending"

load(file.path(data.dir,paste("termDocMatrix_keywords_",segVar,".RData",sep="")))
load(file.path(data.dir,paste("keyword_count_",segVar,".RData", sep="")))

library(tm)

#hs <- findAssocs(tdm, c("family", "debt"), 0.1)
#correlationMatrix <- findAssocs(tdm, tdm$dimnames$Terms, 0.1)
#correlationMatrix <- findAssocs(tdm, c("fami"), 0.1)

d=tdm$nrow
pb <- txtProgressBar(min = 0, max = d, style = 3)
corrM <- data.table(i=integer(0),j=integer(0),v=numeric(0))
for (i in 1:d) {
    setTxtProgressBar(pb, i)
    for (j in 1:d) {
      nzel1 <- tdm$j[tdm$i==i]
      nzel2 <- tdm$j[tdm$i==j]
      for (k in nzel1) {
          if ( any(grepl(k,nzel2))) {
          corrM <- rbind(corrM,
                         data.table(i=i,
                                    j=j,
                                    v=tdm$v[k]*sum(tdm$v[nzel2[grep(k,nzel2)]])
                                    )
                         )
        }
      }
    }
}
close(pb)
