
package_version <- function(x) {
    version <- as.character(unclass(utils::packageVersion(x))[[1]])

    if (length(version) > 3) {
        version[4:length(version)] <- crayon::red(as.character(version[4:length(version)]))
    }
    paste0(version, collapse = ".")
}

#' Conflicts between the tidylab and other packages
#'
#' This function lists all the conflicts between packages in the tidylab
#' and other packages that you have loaded.
#'
#' If dplyr is one of the select packages, then the following four conflicts
#' are deliberately ignored: \code{intersect}, \code{union}, \code{setequal},
#' and \code{setdiff} from dplyr. These functions make the base equivalents
#' generic, so shouldn't negatively affect any existing code.
#'
#' @export
#' @examples
#' tidylab_conflicts()
tidylab_conflicts <- function() {
    envs <- purrr::set_names(search())
    objs <- invert(lapply(envs, ls_env))

    conflicts <- purrr::keep(objs, ~ length(.x) > 1)

    pkg_names <- paste0("package:", tidylab_packages())
    conflicts <- purrr::keep(conflicts, ~ any(.x %in% pkg_names))

    conflict_funs <- purrr::imap(conflicts, confirm_conflict)
    conflict_funs <- purrr::compact(conflict_funs)

    structure(conflict_funs, class = "tidylab_conflicts")
}

tidylab_conflict_message <- function(x) {
    if (length(x) == 0) {
        return("")
    }

    header <- cli::rule(
        left = crayon::bold("Conflicts"),
        right = "tidylab_conflicts()"
    )

    pkgs <- x %>% purrr::map(~ gsub("^package:", "", .))
    others <- pkgs %>% purrr::map(`[`, -1)
    other_calls <- purrr::map2_chr(
        others, names(others),
        ~ paste0(crayon::blue(.x), "::", .y, "()", collapse = ", ")
    )

    winner <- pkgs %>% purrr::map_chr(1)
    funs <- format(paste0(crayon::blue(winner), "::", crayon::green(paste0(names(x), "()"))))
    bullets <- paste0(
        crayon::red(cli::symbol$cross), " ", funs,
        " masks ", other_calls,
        collapse = "\n"
    )

    paste0(header, "\n", bullets)
}

#' @export
print.tidylab_conflicts <- function(x, ..., startup = FALSE) {
    cli::cat_line(tidylab_conflict_message(x))
}

#' @importFrom purrr %>%
confirm_conflict <- function(packages, name) {
    # Only look at functions
    objs <- packages %>%
        purrr::map(~ get(name, pos = .)) %>%
        purrr::keep(is.function)

    if (length(objs) <= 1) {
          return()
      }

    # Remove identical functions
    objs <- objs[!duplicated(objs)]
    packages <- packages[!duplicated(packages)]
    if (length(objs) == 1) {
          return()
      }

    packages
}

ls_env <- function(env) {
    x <- ls(pos = env)
    if (identical(env, "package:dplyr")) {
        x <- setdiff(x, c("intersect", "setdiff", "setequal", "union"))
    }
    x
}

#' Update tidylab packages
#'
#' This will check to see if all tidylab packages (and optionally, their
#' dependencies) are up-to-date, and will install after an interactive
#' confirmation.
#'
#' @param recursive If \code{TRUE}, will also check all dependencies of
#'   tidylab packages.
#' @export
#' @return No return value, called for side effects.
#' @examples
#' \dontrun{
#' tidylab_update()
#' }
tidylab_update <- function(recursive = FALSE) {
    deps <- tidylab_deps(recursive)
    behind <- dplyr::filter(deps, behind)

    if (nrow(behind) == 0) {
        cli::cat_line("All tidylab packages up-to-date")
        return(invisible())
    }

    cli::cat_line("The following packages are out of date:")
    cli::cat_line()
    cli::cat_bullet(
        format(behind$package), " (", behind$local, " -> ", behind$cran, ")"
    )

    cli::cat_line()
    cli::cat_line("Start a clean R session then run:")

    pkg_str <- paste0(deparse(behind$package), collapse = "\n")
    cli::cat_line("install.packages(", pkg_str, ")")

    invisible()
}

#' List all tidylab dependencies
#'
#' @param recursive If \code{TRUE}, will also list all dependencies of
#'   tidylab packages.
#' @export
#' @return (`tibble`) A table with package dependencies.
tidylab_deps <- function(recursive = FALSE) {
    pkgs <- utils::available.packages()
    deps <- tools::package_dependencies("tidylab", pkgs, recursive = recursive)

    pkg_deps <- unique(sort(unlist(deps)))

    base_pkgs <- c(
        "base", "compiler", "datasets", "graphics", "grDevices", "grid",
        "methods", "parallel", "splines", "stats", "stats4", "tools", "tcltk",
        "utils"
    )
    pkg_deps <- setdiff(pkg_deps, base_pkgs)

    cran_version <- lapply(pkgs[pkg_deps, "Version"], base::package_version)
    local_version <- lapply(pkg_deps, utils::packageVersion)

    behind <- purrr::map2_lgl(cran_version, local_version, `>`)

    tibble::tibble(
        package = if (is.null(pkg_deps)) character(0) else pkg_deps,
        cran = cran_version %>% purrr::map_chr(as.character),
        local = local_version %>% purrr::map_chr(as.character),
        behind = behind
    )
}

msg <- function(..., startup = FALSE) {
    packageStartupMessage(text_col(...))
}

text_col <- function(x) {
    # If RStudio not available, messages already printed in black
    if (!rstudioapi::isAvailable()) {
        return(x)
    }

    if (!rstudioapi::hasFun("getThemeInfo")) {
        return(x)
    }

    theme <- rstudioapi::getThemeInfo()

    if (isTRUE(theme$dark)) crayon::white(x) else crayon::black(x)
}

#' List all packages in the tidylab
#'
#' @param include_self Include tidylab in the list?
#' @export
#' @return (`character`) The names of the imported packages.
#' @examples
#' tidylab_packages()
tidylab_packages <- function(include_self = TRUE) { # nocov start
    raw <- utils::packageDescription("tidylab")$Imports
    imports <- strsplit(raw, ",")[[1]]
    parsed <- gsub("^\\s+|\\s+$", "", imports)
    names <- vapply(strsplit(parsed, "\\s+"), "[[", 1, FUN.VALUE = character(1))

    if (include_self) {
        names <- c(names, "tidylab")
    }

    names
} # nocov end

invert <- function(x) {
    if (length(x) == 0) {
        return()
    }
    stacked <- utils::stack(x)
    tapply(as.character(stacked$ind), stacked$values, list)
}

.onAttach <- function(...) {
    needed <- core[!is_attached(core)]
    if (length(needed) == 0) {
          return()
      }

    crayon::num_colors(TRUE)
    tidylab_attach()

    if (!"package:conflicted" %in% search()) {
        x <- tidylab_conflicts()
        msg(tidylab_conflict_message(x), startup = TRUE)
    }
}

is_attached <- function(x) {
    paste0("package:", x) %in% search()
}
