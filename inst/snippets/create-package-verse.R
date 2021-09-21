path <- usethis::proj_path("inst", "files")
fs::dir_delete(path)
dir.create(path, recursive = TRUE)

pkgs <- sort(c("usethat", "R6P", "microservices", "decorators"))

pkgverse::pkgverse(pkg = "tidylab", pkgs = pkgs, keep = path, install_if = FALSE)

fs::file_copy(
    file.path(path, "tidylab", "R", "verse.R"),
    usethis::proj_path("R", "verse.R"),
    overwrite = TRUE
)

old_desc <- desc::description$new(usethis::proj_path("DESCRIPTION"))
new_desc <- desc::description$new(file.path(path, "tidylab", "DESCRIPTION"))


purrr::map(pkgs, old_desc$set_dep, type = "Imports")
deps <- dplyr::distinct(dplyr::bind_rows(new_desc$get_deps(), old_desc$get_deps()))
old_desc$set_deps(deps)$write()

fs::dir_delete(path)
