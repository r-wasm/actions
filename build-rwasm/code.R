args <- commandArgs(trailingOnly = TRUE)
# cat("\nargs:\n")
# str(args)

if (length(args) == 0) {
  stop("No args supplied to Rscript. ")
}

image_path <- args[1]
repo_path <- args[2]

if (!nzchar(image_path) && !nzchar(repo_path)) {
  stop("At least one of `image-path` or `repo-path` should be `true`.")
}


# https://docs.github.com/en/actions/creating-actions/creating-a-docker-container-action#accessing-files-created-by-a-container-action
# > When a container action runs, it will automatically map the default working directory (GITHUB_WORKSPACE) on the runner with the /github/workspace directory on the container. Any files added to this directory on the container will be available to any subsequent steps in the same job.
# local_rwasm_dir <- "_rwasm"
# gha_dir <- file.path("/github/workspace", local_rwasm_dir)

gha_dir <- file.path("/github/workspace")

packages <- args[3]
strip <- args[4]

packages <- strsplit(packages, "[[:space:],]+")[[1]]
if (is.character(strip) && strip == "NULL") strip <- NULL

copy_folder <- function(from_path, to_sub_path) {
  # Quit if no path to copy to
  if (!nzchar(to_sub_path)) {
    return()
  }
  message("\nCopying ", from_path, " to ", to_sub_path)
  to_path <- file.path(gha_dir, to_sub_path)
  if (!dir.exists(to_path)) {
    dir.create(to_path, recursive = TRUE)
  }
  file.copy(
    dir(from_path, full.names = TRUE),
    to_path,
    recursive = TRUE,
    overwrite = TRUE
  )
}

cat("\nArgs:\n")
str(list(image_path = image_path, repo_path = repo_path, packages = packages, strip = strip))

if (!require("pak", character.only = TRUE, quietly = TRUE)) install.packages("pak")
if (!require("withr", character.only = TRUE, quietly = TRUE)) install.packages("withr")

# Use the temp directory to not pollute the local action
# Future: Could set output of library once resolved: https://github.com/r-wasm/rwasm/issues/4
withr::local_dir(tempdir())

# If GITHUB_PAT isn't found, use GITHUB_TOKEN
withr::local_envvar(list(
  "GITHUB_PAT" = Sys.getenv("GITHUB_PAT", Sys.getenv("GITHUB_TOKEN"))
))

# Install rwasm (after PAT is set)
pak::pak(c("r-wasm/rwasm"))

message("\n\nAdding packages:\n", paste("* ", packages, sep = "", collapse = "\n"))
rwasm::add_pkg(packages)

message("\n\nMaking library")
rwasm::make_vfs_library(strip = strip)

# Copy files to original location.
copy_folder("vfs", image_path)
copy_folder("repo", repo_path)