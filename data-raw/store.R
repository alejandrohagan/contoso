## code to prepare `store` dataset goes here

dir <- "data-raw"

store<- readr::read_csv(file.path(dir,"store.csv"),name_repair = janitor::make_clean_names,show_col_types = FALSE)


store_labels <- list(
    store_key = "Unique store identifier",
    store_code = "Store code",
    geo_area_key = "Geographical area identifier",
    country_code = "Country code (e.g., US, UK)",
    country_name = "Country name",
    state = "State or region",
    open_date = "Date when the store opened",
    close_date = "Date when the store closed (if applicable)",
    description = "Description of the store",
    square_meters = "Total square footage of the store",
    status = "Current status of the store (e.g., Closed, Restructured, NA for open)"
)

labelled::var_label(store) <- store_labels

usethis::use_data(store, overwrite = TRUE)
