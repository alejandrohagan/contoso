## code to prepare `order` dataset goes here
fpaR::create_data_raw()

dir <- "data-raw"

orders <- readr::read_csv(file.path(dir,"orders.csv"),name_repair = janitor::make_clean_names,show_col_types = FALSE)


order_labels <- list(
    order_key = "Unique order identifier",
    customer_key = "Unique customer identifier",
    store_key = "Unique store identifier",
    order_date = "Date when the order was placed",
    delivery_date = "Actual delivery date",
    currency_code = "Currency code (e.g., USD, EUR)"
)

# Example: Assuming 'orders' is your data frame

labelled::var_labels(orders) <- order_labels

usethis::use_data(orders, overwrite = TRUE)
