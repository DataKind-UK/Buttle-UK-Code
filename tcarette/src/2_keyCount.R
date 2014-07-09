setwd("~/Documents/Codes/ButtleUK")
library("data.table", lib.loc="/usr/local/Cellar/r/3.0.3/R.framework/Versions/3.0/Resources/library")
library("tm", lib.loc="/usr/local/Cellar/r/3.0.3/R.framework/Versions/3.0/Resources/library")
library("stringr", lib.loc="/usr/local/Cellar/r/3.0.3/R.framework/Versions/3.0/Resources/library")
library("plyr", lib.loc="/usr/local/Cellar/r/3.0.3/R.framework/Versions/3.0/Resources/library")

data.dir <- "ButtleUKDataFINAL/flat_file/"
list.files(data.dir)

keyw <- read.csv("jargon.csv",colClasses="character")
matchKey <- str_c(tolower(str_replace(keyw$k,"\\.\\.*"," ")),collapse="|")
#matchKey <- str_c(tolower(keyw),collapse="|")

vars <- names(read.csv(file.path(data.dir,"buttle_uk_ads.csv"),nrows=1))
v <- rep("NULL",length(vars))
######### Ad Hoc code SELECT
selected <- c("case_supporting_info_text","fin_total_debt","fin_total_debt_yn","eval_decision")
#########
tmp<-str_c(tolower(str_replace(selected,"\\.\\.*"," ")),collapse="|")
v[grepl(tmp,vars)] <- "character"  # because fread 
case <- fread(file.path(data.dir,"buttle_uk_ads.csv"), colClasses=v)
######### Ad Hoc code LOGIC
# Set debt variable to FALSE if either debt_yn == "t" or debt >= 0
case$tmp[case$fin_total_debt == "" & case$fin_total_debt_yn == ""] <- "Missing"
case$tmp[case$fin_total_debt_yn == "f" | case$fin_total_debt == 0 ] <- "NoDebt"
case$tmp[case$fin_total_debt > 0  | case$fin_total_debt_yn == "t"] <- "InDebt"
# empty eval_decision to Pending
case[[selected[4]]][case[[selected[4]]] == ""] <- "Pending"
segVar <- as.factor(paste(case$tmp,case[[selected[4]]],sep=""))
#########
for ( dec in levels(segVar) ) {

  txt <- case$case_supporting_info_text[segVar==dec]
  txt <- tolower(txt[txt!=""])
  txt <- llply(str_match_all(txt,matchKey),function(x) str_c(x,collapse=" "))
  txtnum <- laply(txt, function(x) {
      i=0
      bid <- x
      bidprev <- x
      for ( k in tolower(keyw$k) ) {
        i <- i+1
        for (n in 1:50) {  # fast and dirty way to be sure all occurences of k are replaced
          bid<-gsub(paste(" ",k," |^",k," | ",k,"$|^",k,"$",sep=""),paste("",i,""),bid)
          if(bidprev == bid ) break
          bidprev <- bid
        }
      }
      return(bid)
    })
  print(paste("Number of non-empty communication for (segVar =",dec,"), =",length(txtnum)))
  #mycorpus <- Corpus(VectorSource(sample(txt,1000)))
  mycorpus <- Corpus(VectorSource(txtnum))
  tdm <- TermDocumentMatrix(mycorpus)

  wCnt <- apply(as.matrix(tdm), 1, sum)
  wCnt <- wCnt[order(wCnt, decreasing=TRUE)]

  save.data.dir <- "tcarette/data/"
  save(wCnt,file=paste(save.data.dir,"keyword_count_",dec,".RData",sep=""))
  save(tdm,file=paste(save.data.dir,"termDocMatrix_keywords_",dec,".RData",sep=""))
  write.csv(wCnt,file=paste(save.data.dir,"keyword_count_",dec,".csv",sep=""))
}
