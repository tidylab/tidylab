# R Package Microservice: Core -------------------------------------------------
FROM tidylab/package:4.1.0

# Additional Packages ----------------------------------------------------------
RUN R -q -e "install_cran(c('testthat', 'usethis', 'pkgload'), dependencies = 'Depends', upgrade = 'always')"
RUN R -q -e "install_cran(c('plumber', 'httptest'), dependencies = TRUE, upgrade = 'always')"
RUN R -q -e "install_cran(c('jsonlite', 'promises', 'future', 'httr'), dependencies = 'Depends', upgrade = 'always')"

