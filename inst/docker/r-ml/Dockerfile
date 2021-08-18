# R for Machine Learning -------------------------------------------------------
FROM tidylab/package:4.1.1

# Additional Packages ----------------------------------------------------------
RUN R -q -e "install_cran(c('devtools', 'testthat', 'covr', 'roxygen2', 'pkgdown'))"
RUN R -q -e "install_cran(c('forecast', 'feasts', 'fable', 'fabletools'))"
RUN R -q -e "install_cran('tidymodels', dependencies = TRUE)"
RUN R -q -e "install_cran('mlr3learners', dependencies = TRUE)"
RUN R -q -e "install_github('mlr-org/mlr3extralearners@v0.4.3', dependencies = TRUE)"
RUN R -q -e "install_cran('mlr3verse', dependencies = TRUE)"
