.onAttach <- function(lib, pkg,...){#nocov start
    options(
        usethis.quiet = TRUE
    )

    try(
        packageStartupMessage(
            paste(
                "\n\033[44m\033[37m",
                "\nBuild all docker images with:",
                "\n.Rprofile$docker$reset()",
                "\n.Rprofile$docker$start()",
                "\n\033[39m\033[49m",
                sep="")
        )
    )
}#nocov end
