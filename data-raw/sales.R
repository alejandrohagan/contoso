## code to prepare `sales` dataset goes here

## code to prepare `customer` dataset goes here
fpaR::create_data_raw()

dir <- "data-raw"

sales <- readr::read_csv(file.path(dir,"sales.csv"),name_repair = janitor::make_clean_names,show_col_types = FALSE) |>
    dplyr::mutate(
        gross_revenue=quantity*unit_price
        ,net_revenue=quantity*net_price
        ,unit_discount=unit_price-net_price
        ,discounts=unit_discount*quantity
        ,cogs=unit_cost*quantity
        ,margin=net_revenue-cogs
        ,unit_margin=margin/quantity
    )

sales_labels <- list(
    order_key = "Unique order identifier",
    line_number = "Line number of the order",
    order_date = "Date when the order was placed",
    delivery_date = "Expected delivery date",
    customer_key = "Unique customer identifier",
    store_key = "Unique store identifier",
    product_key = "Unique product identifier",
    quantity = "Quantity of products ordered",
    unit_price = "Price per unit of the product",
    net_price = "Total price after discounts",
    unit_cost = "Cost per unit of the product",
    currency_code = "Currency code (e.g., USD)",
    exchange_rate = "Exchange rate to USD",
    gross_revenue = "unit_price multiplied by quantity (calculated column)",
    net_revenue   = "net_price multiplied by quantity (calculated column)",
    unit_discount     = "unit_price minus net_price (calculated column)",
    discounts= "unit_discount multiplied by quantity (calculated column)",
    cogs="unit_cost multiplied by quantity (calculated column)",
    margin = "net_revenue minus cogs (calculated column)",
    unit_margin = "margin divided by quantity (calculated column)"
)

labelled::var_label(sales) <- sales_labels

usethis::use_data(sales, overwrite = TRUE)
