## code to prepare `date` dataset goes here
fpaR::create_data_raw()


dir <- "data-raw"

date <- readr::read_csv(file.path(dir,"date.csv"),name_repair = janitor::make_clean_names,show_col_types = FALSE)


usethis::use_data(date, overwrite = TRUE)
