## code to prepare `logo` dataset goes here
logo <- readLines(usethis::proj_path("data-raw", "ascii-art.txt"))
usethis::use_data(logo, overwrite = TRUE)
