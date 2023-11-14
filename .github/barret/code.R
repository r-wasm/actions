args <- commandArgs(trailingOnly = TRUE)
cat("\nargs:\n")
str(args)

if (length(args) == 0) {
  stop(
    "No `packages` specified. ",
    "Please add extra argument to your Rscript call specify `packages`."
  )
}

base_dir <- "/github/workspace/_rwasm"
if (!dir.exists(base_dir)) dir.create(base_dir, recursive = TRUE)

packages <- args[1]
strip <- if (length(args) > 1) args[2] else NULL

packages <- strsplit(packages, "[[:space:],]+")[[1]]
if (strip == "NULL") strip <- NULL

cat("\nupdated args:\n")
str(list(packages = packages, strip = strip))

if (!require("pak", character.only = TRUE, quietly = TRUE)) install.packages("pak")
pak::pak("r-wasm/rwasm")
rwasm::add_pkg(packages)
rwasm::make_vfs_library(
  # https://docs.github.com/en/actions/creating-actions/creating-a-docker-container-action#accessing-files-created-by-a-container-action
  # > When a container action runs, it will automatically map the default working directory (GITHUB_WORKSPACE) on the runner with the /github/workspace directory on the container. Any files added to this directory on the container will be available to any subsequent steps in the same job.
  out_dir = file.path(base_dir, "vfs"),
  repo_dir = file.path(base_dir, "repo"),
  strip = strip
)
