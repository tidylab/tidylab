
<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- https://github.com/tidylab/tidylab -->

# `tidylab` <img src="https://raw.githubusercontent.com/tidylab/tidylab/master/pkgdown/logo.png" align="right" height="50"/>

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/tidylab)](https://CRAN.R-project.org/package=tidylab)
[![R build
status](https://github.com/tidylab/tidylab/workflows/R-CMD-check/badge.svg)](https://github.com/tidylab/tidylab/actions)
[![codecov](https://codecov.io/gh/tidylab/tidylab/branch/master/graph/badge.svg?token=U6FL5N32FL)](https://app.codecov.io/gh/tidylab/tidylab)

<!-- badges: end -->

## Overview

`tidylab` is a set of packages that work in harmony because they share
common software design principles – domain driven design (ddd) and
microservice architecture. The **tidylab** package is designed to make
it easy to install and load core packages from the tidylab in a single
command.

## Installation

``` r
# Install from CRAN
install.packages("tidylab")
# Or the development version from GitHub
# install.packages("remotes")
remotes::install_github("tidylab/tidylab")
```

## Usage

`library(tidylab)` will load the core tidylab packages:

-   [decorators](https://tidylab.github.io/decorators/), for extending
    the behaviour of a function without explicitly modifying it.
-   [microservices](https://tidylab.github.io/microservices/), for
    breaking down a monolithic application to a suite of services.
-   [usethat](https://tidylab.github.io/usethat/), for automating
    repetitive tasks that arise during analytic project setup and
    development.

You also get a condensed summary of conflicts with other packages you
have loaded:

``` r
library(tidylab)
#> -- Attaching packages ----------------------------------------- tidylab 0.0.1 --
#> v decorators    0.1.0     v R6P           0.2.2
#> v microservices 0.1.2     v usethat       0.3.0
#> Warning: package 'usethat' was built under R version 4.1.1
#> 
```

You can see conflicts created later with `tidylab_conflicts()`:

``` r
library(MASS)
tidylab_conflicts()
```

And you can check that all tidylab packages are up-to-date with
`tidylab_update()`:

``` r
tidylab_update()
#> The following packages are out of date:
#>  * broom (0.4.0 -> 0.4.1)
#>  * DBI   (0.4.1 -> 0.5)
#>  * Rcpp  (0.12.6 -> 0.12.7)
#> Update now?
#> 
#> 1: Yes
#> 2: No
```
