# R Package Development: Core --------------------------------------------------
FROM rocker/tidyverse:4.0.5

# Setup ------------------------------------------------------------------------
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    libcurl4-openssl-dev \
    libssl-dev \
	libxt-dev \
    libxml2-dev \
    libcairo2-dev \
    libsqlite-dev \
    libmariadbd-dev \
    libmariadbclient-dev \
    libpq-dev \
	libsodium-dev \
    libssh2-1-dev \
    libsasl2-dev \
    libsqliteodbc \
    libharfbuzz-dev libfribidi-dev \
    libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev \
    unixodbc-dev \
    git \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Configure RStudio Server -----------------------------------------------------
ARG R_REPOS=\'https://mran.microsoft.com/snapshot/2021-03-31\'
RUN touch .env .Rprofile
RUN echo "options(repos = ${R_REPOS})" >> .Rprofile
RUN R -q -e "if(!require(remotes)) install.packages('remotes')"
RUN echo "require(remotes)" >> .Rprofile

# Additional Packages ----------------------------------------------------------
RUN R -q -e "install_cran(c('devtools', 'testthat', 'covr', 'roxygen2', 'pkgdown'))"

RUN R -q -e "install_cran('tidyverse', dependencies = TRUE)"
RUN R -q -e "install_cran('tidymodels', dependencies = TRUE)"
RUN R -q -e "install_cran('mlr3verse', dependencies = TRUE)"
RUN R -q -e "update_packages(upgrade  = 'always')"

RUN R -q -e "install_cran(c('forecast', 'feasts', 'fable', 'fabletools'))"
RUN R -q -e "install_cran(c('ranger', 'lightgbm', 'xgboost', 'e1071'))"
