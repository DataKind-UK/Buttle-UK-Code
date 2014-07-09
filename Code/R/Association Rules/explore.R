# Association rules
install.packages("arules")
library(arules)

# Load evaluation data
caseEval <- read.csv(file="/Users/herveschnegg/Desktop/ButtleUKDataFINAL/fact_tables/case_evaluation.csv", header=TRUE, stringsAsFactors=FALSE)

# Load case application to retrieve dates
caseApplication <- read.csv(file="/Users/herveschnegg/Desktop/ButtleUKDataFINAL/fact_tables/case_application.csv", header=TRUE, stringsAsFactors=FALSE)
caseApplication <- caseApplication[, c("case_id", "family_id", "case_application_date")]
caseApplication$case_application_date <- strptime(x=caseApplication$case_application_date, format="%d/%m/%Y")

# Load reasons lookup
reasonsLU <- read.csv(file="/Users/herveschnegg/Desktop/ButtleUKDataFINAL/ReasonsLookup.csv", header=TRUE, stringsAsFactors=FALSE)

# Take columns of interest from evaluation
caseEvalSub <- caseEval[, c("case_id", "eval_approval_reason_main", "eval_approval_reason_2", "eval_approval_reason_3", "eval_approval_reason_4")]

# Build dataset with all columns
caseReasons <- merge(x=caseApplication, y=caseEvalSub, by="case_id")

allReasons <- unique(c(caseReasons$eval_approval_reason_main, caseReasons$eval_approval_reason_2, caseReasons$eval_approval_reason_3, caseReasons$eval_approval_reason_4))
allReasons <- allReasons[allReasons != ""]
