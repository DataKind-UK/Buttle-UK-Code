require(ProjectTemplate)
load.project()


# Load data ---------------------------------------------------------------

data_dir <- "data/"
flat_file_dir <- "data/flat_file/"
fact_tables_dir <- "data/fact_tables/"

flat_file <- list.files(flat_file_dir)
fact_tables <- list.files(fact_tables_dir)

flat_data <- fread(file.path(flat_file_dir, flat_file))
flat_data
View(flat_data
)

# Add all the fact tables to a list
fact_tables_list <- vector(mode="list", length = length(fact_tables))
for(i in 1:length(fact_tables_list)) {
  fact_tables_list[[i]] <- fread(file.path(fact_tables_dir, fact_tables[i]))
}

# Save data as an R workspace for easy access later
# save(flat_data, fact_tables_list, file = "data/RData/ButtleData.RData")

fact_tables_names <- gsub(".csv", "", fact_tables)

foreach(i=1:length(fact_tables_names)) %do% {
  assign(fact_tables_names[i], fact_tables_list[[i]], envir = .GlobalEnv)
}

