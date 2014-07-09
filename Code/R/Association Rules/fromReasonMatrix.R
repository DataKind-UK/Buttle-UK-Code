# Association rules
install.packages("arules")
library(arules)

dataFilesFolder <- "/Users/herveschnegg/Desktop/ButtleUKDataFINAL/"

# Load reason matrix into df...
reasonDf <- read.csv(file=paste0(dataFilesFolder, "ReasonsMatrix.csv"), header=TRUE, stringsAsFactors=FALSE)

# ...transform to a matrix...
reasonMatrix <- as.matrix(reasonDf[,2:32])

# ...convert as transactions...
transactions <- as(reasonMatrix, "transactions")

# transactions summary
summary(transactions)

itemFrequencyPlot(transactions)

rules <- apriori(transactions,
                 parameter = list(supp = 0.01, conf = 0.05,
                     target = "rules"))

inspect(rules)

write.csv(as(rules, "data.frame"), paste0(dataFilesFolder, "association_rules_reasons.csv"))
