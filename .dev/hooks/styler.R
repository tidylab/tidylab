remotes::install_cran("styler", quiet = TRUE)
style <- purrr::partial(styler::tidyverse_style, indent_by = 4)
styler::style_pkg(style = style)
