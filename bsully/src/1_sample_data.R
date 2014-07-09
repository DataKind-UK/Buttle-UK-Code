setwd("bsully")
require(ProjectTemplate)
load.project()


# Sample data -------------------------------------------------------------
fact_tables_dir <- "data/fact_tables/"
fact_tables <- list.files(fact_tables_dir)
fact_tables_names <- gsub(".csv", "", fact_tables)

# function to sample datatable
sample_buttle <- function(buttledata, nrows = 10000) {
  set.seed(20140607)
  buttledata[sample(nrow(buttledata), nrows),]
}

# apply function to every datatable
sample_tables_list <- lapply(fact_tables_list, sample_buttle)

# move datatables to global env
foreach(i=1:length(fact_tables_names)) %do% {
  assign(str_c("sample_", fact_tables_names[i]), 
         sample_tables_list[[i]], envir = .GlobalEnv)
}
