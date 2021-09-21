make_email <- function(to, package) {
  name <- gsub(" <.*>", "", to)

  body <- glue::glue("
  Dear {name},

  Your package, {package}, lists the tidylab in either Depends,
  Imports, or Suggests in the DESCRIPTION file. This is a bad idea because,
  in short, the tidylab is a set of packages designed for interactive data
  analysis, and it includes a very large number (>80) of direct and indirect
  dependencies, most of which your package probably doesn't use.

  Instead of depending on the entire tidylab, please import from, suggest,
  or depend on the packages in the tidylab that you actually use. This
  will make your package faster to install and will head off potential
  problems down the road.

  Thanks!

  Hadley
  ")

  get("gm_mime", asNamespace("gmailr"))(
    from = "hadley@rstudio.com",
    to = to,
    subject = glue::glue('{package} and the tidylab'),
    body = body
  )
}

tidylab_dependency_dissuade <- function() {
  pkgs <- tools::package_dependencies("tidylab",
    which = c("Depends", "Imports", "Suggests"),
    reverse = TRUE
  )[[1]]

  db <- tools::CRAN_package_db()
  maintainers <- db$Maintainer[match(pkgs, db$Package)]

  emails <- purrr::map2(maintainers, pkgs, make_email)
  purrr::walk(emails, ~ try(get("gm_send_message", asNamespace("gmailr"))(.x)))
}

# gm_auth_configure(path = "path/to/oauth.json")
# tidylab_dependency_dissuade()
