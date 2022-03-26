# R Package Development: Robyn -------------------------------------------------
FROM tidylab/package:4.1.2

RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing \
       apt-utils ed libnlopt-dev libv8-dev libclang-dev ccache libxt-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/

# Install prophet --------------------------------------------------------------
RUN R -q -e "install_cran('V8')"
RUN R -q -e "install_cran('extraDistr')"
RUN R -q -e "install_cran('RcppParallel')"
RUN R -q -e "install_cran('rstan')"
RUN R -q -e "install_cran('rstantools')"
RUN R -q -e "install_cran('BH')"
RUN R -q -e "install_cran('RcppEigen')"
RUN R -q -e "install_cran('prophet')"

# Install Imports --------------------------------------------------------------
RUN R -q -e "install_cran('data.table')"
RUN R -q -e "install_cran('doParallel')"
RUN R -q -e "install_cran('doRNG')"
RUN R -q -e "install_cran('dplyr')"
RUN R -q -e "install_cran('foreach')"
RUN R -q -e "install_cran('ggplot2')"
RUN R -q -e "install_cran('ggridges')"
RUN R -q -e "install_cran('glmnet')"
RUN R -q -e "install_cran('lares')"
RUN R -q -e "install_cran('lubridate')"
RUN R -q -e "install_cran('minpack.lm')"
RUN R -q -e "install_cran('nloptr')"
RUN R -q -e "install_cran('patchwork')"
RUN R -q -e "install_cran('reticulate')"
RUN R -q -e "install_cran('rPref')"
RUN R -q -e "install_cran('stringr')"
RUN R -q -e "install_cran('tidyr')"
