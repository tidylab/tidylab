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
