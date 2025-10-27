## code to prepare `product` dataset goes here

dir <- "data-raw"

product <- readr::read_csv(file.path(dir,"product.csv"),name_repair = janitor::make_clean_names,show_col_types = FALSE)

product_labels <- list(
    product_key = "Unique product identifier",
    product_code = "Product code",
    product_name = "Name of the product",
    manufacturer = "Manufacturer of the product",
    brand = "Brand of the product",
    color = "Color of the product",
    weight_unit = "Unit of measurement for weight",
    weight = "Weight of the product",
    cost = "Cost to produce or purchase the product",
    price = "Selling price of the product",
    category_key = "Unique category identifier",
    category_name = "Name of the product category",
    sub_category_key = "Unique sub-category identifier",
    sub_category_name = "Name of the product sub-category"
)

labelled::var_label(product) <- product_labels

usethis::use_data(product, overwrite = TRUE)
