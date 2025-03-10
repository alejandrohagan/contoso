## code to prepare `store` dataset goes here
create_data_raw()

dir <- "data-raw"

store<- readr::read_csv(file.path(dir,"store.csv"),name_repair = janitor::make_clean_names,show_col_types = FALSE)

usethis::use_data(store, overwrite = TRUE)
