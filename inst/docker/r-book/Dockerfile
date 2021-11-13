# R Package Development: Book --------------------------------------------------
FROM tidylab/package:4.1.2

# Additional Packages ----------------------------------------------------------
RUN R -q -e "install_cran('tidyverse', dependencies = TRUE)"
RUN R -q -e "update_packages(upgrade  = 'always')"

RUN R -q -e "install_cran(c('devtools', 'testthat', 'roxygen2', 'bookdown'))"
RUN R -q -e "install_cran(('tinytex')); tinytex::install_tinytex()"
RUN R -q -e "install_cran(('webshot')); webshot::install_phantomjs()"
