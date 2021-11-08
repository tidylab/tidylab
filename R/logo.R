
#' The tidylab logo, using ASCII or Unicode characters
#'
#' Use [crayon::strip_style()] to get rid of the colors.
#'
#' @param unicode Whether to use Unicode symbols. Default is `TRUE`
#'   on UTF-8 platforms.
#'
#' @md
#' @export
#' @return (`tidylab_logo`) ASCII art of the Tidylab logo.
#' @examples
#' tidylab_logo()
tidylab_logo <- function(unicode = l10n_info()$`UTF-8`) {
    logo <- logo

    hexa <- c("*", ".", "o", "*", ".", "*", ".", "o", ".", "*")
    if (unicode) hexa <- c("*" = "\u2b22", "o" = "\u2b21", "." = ".")[hexa]

    cols <- c(
        "red", "yellow", "green", "magenta", "cyan",
        "yellow", "green", "white", "magenta", "cyan"
    )

    col_hexa <- purrr::map2(hexa, cols, ~ crayon::make_style(.y)(.x))

    for (i in 0:9) {
        pat <- paste0("\\b", i, "\\b")
        logo <- sub(pat, col_hexa[[i + 1]], logo)
    }

    structure(crayon::blue(logo), class = "tidylab_logo")
}
