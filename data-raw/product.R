## code to prepare `product` dataset goes here
fpaR::create_data_raw()

dir <- "data-raw"

product <- readr::read_csv(file.path(dir,"product.csv"),name_repair = janitor::make_clean_names,show_col_types = FALSE)

usethis::use_data(product, overwrite = TRUE)
