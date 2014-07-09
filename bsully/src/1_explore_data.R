setwd("bsully")
require(ProjectTemplate)
load.project()

load("data/RData/ButtleData.RData")

# These column numbers should be numeric but were coerced to strings when read in
numeric_cols <- c(5:13, 15:41, 66, 71:78)

# Wordcloud of keywords in case evaluation text
set.seed()
wordcloud(sample(case_application$case_supporting_info_text, 10000), min.freq=800, )
wordcloud(case_evaluation[,eval_recommendation_text])

head(case_application)
head(flat_data)
names(flat_data)

# Take a sample of the flat_data file to make plotting a bit quicker
set.seed(20140607)
sample_rows <- sample(nrow(flat_data), 100)
sample_data <- flat_data[sample_rows,]

ggpairs(sample_data, c("family_no_of_children", "fin_total_debt", "fin_wkly_income",
                       "granted_total_value"))

flat_data[,c()]
names(flat_data)
