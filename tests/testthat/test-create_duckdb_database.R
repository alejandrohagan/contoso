# tests/testthat/test-create_contoso_duckdb.R

describe("create_contoso_duckdb()", {


        skip_if_not_installed("DBI")
        skip_if_not_installed("duckdb")
        skip_if_not_installed("dplyr")
        skip_if_not_installed("dbplyr")
        skip_on_cran()
        skip_on_ci()

        result <- create_contoso_duckdb(db_dir = "in_memory", size = "100K")

        expected_names <- c("sales","product","customer","store","fx","date","orders","orderrows")

        expect_true(all(expected_names %in% names(result)))
        expect_setequal(names(result), expected_names)

        expect_true(all(vapply(result, inherits, logical(1), what = "tbl_lazy")))

    })
