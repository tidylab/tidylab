
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `tidylab` Packages Infrastructure

<!-- badges: start -->
<!-- badges: end -->

<div class="alert alert-warning">

Please do not install this package. It has no utility outside the
`tidylab` ecosystem.

</div>

## Docker Images

Build a specific docker image by running

    .Rprofile$docker$start(<service-name>)

The available services are

| Service Name     | Description                                      |
|------------------|--------------------------------------------------|
| `r-package`      | Docker image for building R packages.            |
| `r-project`      | Docker image for building R projects.            |
| `r-ml`           | Docker image for building machine learning in R. |
| `r-book`         | Docker image for authoring books in R.           |
| `r-microservice` | Docker image for deploying microservices in R.   |

For example, to build the `r-package` service run

    .Rprofile$docker$start("r-package")
