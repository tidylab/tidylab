assign(".Rprofile", new.env(), envir = globalenv())

# .First ------------------------------------------------------------------
.First <- function(){
    try(if(testthat::is_testing()) return())

    # Package Management System
    Date <- as.character(read.dcf("DESCRIPTION", "Date"));
    URL <- if(is.na(Date)) "https://cran.rstudio.com/" else paste0("https://mran.microsoft.com/snapshot/", Date)
    options(repos = URL)
}

# .Last -------------------------------------------------------------------
.Last <- function(){
    try(if(testthat::is_testing()) return())
    try(system('docker-compose down'), silent = TRUE)
}

# Docker ------------------------------------------------------------------
.Rprofile$docker$browse_url <- function(service){
    path_script <- tempfile("system-", fileext = ".R")
    job_name <- paste("Testing", as.character(read.dcf('DESCRIPTION', 'Package')), "in a Docker Container")
    define_service <- paste0("service = c(", paste0(paste0("'",service,"'"), collapse = ", "),")")
    define_service <- if(is.null(service)) "service = NULL" else define_service
    writeLines(c(
        "source('./R/utils-DockerCompose.R')",
        define_service,
        "DockerCompose$new()$browse_url(service)"), path_script)
    .Rprofile$utils$run_script(path_script, job_name)
}

.Rprofile$docker$start <- function(service = NULL){
    path_script <- tempfile("system-", fileext = ".R")
    job_name <- paste("Testing", as.character(read.dcf('DESCRIPTION', 'Package')), "in a Docker Container")
    define_service <- paste0("service <- c(", paste0(paste0("'",service,"'"), collapse = ", "),")")
    define_service <- if(is.null(service)) "service = NULL" else define_service
    writeLines(c(
        "source('./R/utils-DockerCompose.R')",
        define_service,
        "DockerCompose$new()$start(service)"), path_script)
    .Rprofile$utils$run_script(path_script, job_name)
}

.Rprofile$docker$stop <- function(){
    path_script <- tempfile("system-", fileext = ".R")
    job_name <- paste("Testing", as.character(read.dcf('DESCRIPTION', 'Package')), "in a Docker Container")
    writeLines(c("source('./R/utils-DockerCompose.R'); DockerCompose$new()$stop()"), path_script)
    .Rprofile$utils$run_script(path_script, job_name)
}

.Rprofile$docker$restart <- function(service = NULL){
    path_script <- tempfile("system-", fileext = ".R")
    job_name <- paste("Testing", as.character(read.dcf('DESCRIPTION', 'Package')), "in a Docker Container")
    define_service <- paste0("service <- c(", paste0(paste0("'",service,"'"), collapse = ", "),")")
    define_service <- if(is.null(service)) "service = NULL" else define_service
    writeLines(c(
        "source('./R/utils-DockerCompose.R')",
        define_service,
        "DockerCompose$new()$restart(service)"), path_script)
    .Rprofile$utils$run_script(path_script, job_name)
}

.Rprofile$docker$reset <- function(){
    path_script <- tempfile("system-", fileext = ".R")
    job_name <- paste("Testing", as.character(read.dcf('DESCRIPTION', 'Package')), "in a Docker Container")
    writeLines(c("source('./R/utils-DockerCompose.R'); DockerCompose$new()$reset()"), path_script)
    .Rprofile$utils$run_script(path_script, job_name)
}

.Rprofile$docker$push <- function(service = NULL){
    path_script <- tempfile("system-", fileext = ".R")
    job_name <- paste("Pushing", service, "to Docker Hub")
    define_service <- paste0("service <- c(", paste0(paste0("'",service,"'"), collapse = ", "),")")
    define_service <- if(is.null(service)) "service = NULL" else define_service
    writeLines(c(
        "source('./R/utils-DockerCompose.R')",
        define_service,
        "DockerCompose$new()$push(service)"), path_script)
    .Rprofile$utils$run_script(path_script, job_name)
}

# pkgdown -----------------------------------------------------------------
.Rprofile$pkgdown$browse <- function(name){
    if(missing(name)){
        path <- "./docs"
        name <- "index.html"
    } else {
        path <- "./docs/articles"
        name <- match.arg(name, list.files(path, "*.html"))
    }
    try(browseURL(stringr::str_glue('{path}/{name}', path = path, name = name)))
    invisible()
}

.Rprofile$pkgdown$create <- function(){
    path_script <- tempfile("system-", fileext = ".R")
    job_name <- "Rendering Package Website"

    writeLines(c(
        "devtools::document()",
        "rmarkdown::render('README.Rmd', 'md_document')",
        "unlink(usethis::proj_path('docs'), TRUE, TRUE)",
        paste0("try(detach('package:",read.dcf("DESCRIPTION", "Package")[[1]], "', unload = TRUE, force = TRUE))"),
        "pkgdown::build_site(devel = FALSE, lazy = FALSE)"
    ), path_script)

    .Rprofile$utils$run_script(path_script, job_name)
}

.Rprofile$pkgdown$update <- function(){
    path_script <- tempfile("system-", fileext = ".R")
    job_name <- "Rendering Package Website"

    writeLines(c(
        "devtools::document()",
        "rmarkdown::render('README.Rmd', 'md_document')",
        paste0("try(detach('package:",read.dcf("DESCRIPTION", "Package")[[1]], "', unload = TRUE, force = TRUE))"),
        "pkgdown::build_site(devel = TRUE, lazy = TRUE)"
    ), path_script)

    .Rprofile$utils$run_script(path_script, job_name)
}


# Utils -------------------------------------------------------------------
.Rprofile$utils$run_script <- function(path, name){
    withr::with_envvar(
        c(TESTTHAT = "true"),
        rstudioapi::jobRunScript(
            path = path,
            name = name,
            workingDir = ".",
            importEnv = FALSE,
            exportEnv = ""
        ))
    invisible()
}

