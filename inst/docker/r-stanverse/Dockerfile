# R Package Development: Stan --------------------------------------------------
FROM tidylab/package:4.1.3

RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing \
       apt-utils ed libnlopt-dev libv8-dev libclang-dev ccache libxt-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/

# Install rstan ----------------------------------------------------------------
ENV R_REMOTES_NO_ERRORS_FROM_WARNINGS=false
RUN R -q -e "install_cran('matrixStats')"
RUN R -q -e "install_cran('V8')"
RUN R -q -e "install_cran('RcppEigen')"
RUN R -q -e "install_cran('rstan')"

RUN R -q -e "install_cran('sass')"
RUN R -q -e "install_cran('httpuv')"
RUN R -q -e "install_cran('igraph')"
RUN R -q -e "install_cran('minqa')"
RUN R -q -e "install_cran('bayesplot')"
RUN R -q -e "install_cran('lme4')"
RUN R -q -e "install_cran('rstantools')"
RUN R -q -e "install_cran('shinystan')"
RUN R -q -e "install_cran('rstanarm')"
ENV R_REMOTES_NO_ERRORS_FROM_WARNINGS=true
