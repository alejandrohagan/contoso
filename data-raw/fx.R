## code to prepare `fx` dataset goes here
fpaR::create_data_raw()

dir <- "data-raw"

fx <- readr::read_csv(file.path(dir,"currencyexchange.csv"),name_repair = janitor::make_clean_names,show_col_types = FALSE)


fx_labels <- list(
    date = "Date of the exchange rate",
    from_currency = "Currency being exchanged from",
    to_currency = "Currency being exchanged to",
    exchange = "Exchange rate between the two currencies"
)

# Example: Assuming 'exchange_data' is your data frame
var_labels(fx) <- fx_labels


usethis::use_data(fx, overwrite = TRUE)
