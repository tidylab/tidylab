# R Package Microservice: Core -------------------------------------------------
FROM tidylab/package:4.1.0

# Additional Packages ----------------------------------------------------------
RUN R -q -e "install_cran(c('plumber', 'httptest'), dependencies = 'Depends', upgrade = 'always')"
RUN R -q -e "install_cran(c('testthat', 'usethis', 'jsonlite', 'promises', 'future', 'httr'), dependencies = 'Depends', upgrade = 'always')"

