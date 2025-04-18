% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{orderrows}
\alias{orderrows}
\title{Order Rows Data from the Contonso Dataset}
\format{
A data frame with 7 columns:
\describe{
  \item{order_key}{\code{double} Unique identifier for the order to which the item belongs.}
  \item{line_number}{\code{double} Line number within the order, identifying each product line.}
  \item{product_key}{\code{double} Unique identifier for the product in the order row.}
  \item{quantity}{\code{double} The quantity of the product ordered.}
  \item{unit_price}{\code{double} The price per unit of the product.}
  \item{net_price}{\code{double} The total net price for the product, considering any applicable discounts.}
  \item{unit_cost}{\code{double} The cost per unit of the product.}
}
}
\source{
https://github.com/sql-bi/Contoso-Data-Generator-V2-Data/releases/tag/ready-to-use-data
}
\usage{
orderrows
}
\description{
This dataset contains detailed information about the individual items (rows) within each order in the Contonso dataset. It includes
details such as the product, quantity, pricing, and cost of each item in an order. This dataset is useful for analyzing the breakdown
of order components and individual product sales.
}
\keyword{datasets}
