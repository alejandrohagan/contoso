## code to prepare `orderrows` dataset goes here

dir <- "data-raw"

orderrows <- readr::read_csv(file.path(dir,"orderrows.csv"),name_repair = janitor::make_clean_names,show_col_types = FALSE)


orderrows_labels <- list(
    order_key = "Unique order identifier",
    line_number = "Line number of the order",
    product_key = "Unique product identifier",
    quantity = "Quantity of the product ordered",
    unit_price = "Price per unit of the product",
    net_price = "Total price for the line item after any discounts",
    unit_cost = "Cost per unit of the product"
)
labelled::var_label(orderrows) <- orderrows_labels



usethis::use_data(orderrows, overwrite = TRUE)
