test_that("tidylab_packages returns character vector of package names", {
    expect_silent(out <- tidylab_packages())
    expect_type(out, "character")
    expect_true("microservices" %in% out)
})

test_that("tidylab_conflicts returns conflicted functions", {
    capture_message(out <- tidylab_conflicts())
    expect_type(out, "list")
})

test_that("tidylab_logo returns package ASCII logo", {
    expect_type(tidylab_logo(), "character")
})

test_that("tidylab_packages returns package dependencies", {
    expect_type(tidylab_packages(), "character")
})


test_that("tidylab_deps returns package dependencies", {
    skip_if_offline()
    skip_on_cran()
    withr::local_options(list(repos = "http://cran.r-project.org"))
    expect_s3_class(tidylab_deps(), "data.frame")
})
