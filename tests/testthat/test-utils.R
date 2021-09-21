test_that("tidylab packages returns character vector of package names", {
    out <- tidylab_packages()
    expect_type(out, "character")
    expect_true("microservices" %in% out)
})
