args <- commandArgs(trailingOnly = TRUE)
cat("\nargs:\n")
str(args)

if (length(args) == 0) {
  stop(
    "No `packages` specified. ",
    "Please add extra argument to your Rscript call specify `packages`."
  )
}

# https://docs.github.com/en/actions/creating-actions/creating-a-docker-container-action#accessing-files-created-by-a-container-action
# > When a container action runs, it will automatically map the default working directory (GITHUB_WORKSPACE) on the runner with the /github/workspace directory on the container. Any files added to this directory on the container will be available to any subsequent steps in the same job.
base_dir <- "/github/workspace"
# Used for outputs
out_dir_path <- "_rwasm/vfs"
repo_dir_path <- "_rwasm/repo"
# Make local paths that are mapped to the container
out_dir <- file.path(base_dir, out_dir_path)
repo_dir <- file.path(base_dir, repo_dir_path)
if (!dir.exists(out_dir)) dir.create(out_dir, recursive = TRUE)
if (!dir.exists(repo_dir)) dir.create(repo_dir, recursive = TRUE)

packages <- args[1]
strip <- if (length(args) > 1) args[2] else NULL

packages <- strsplit(packages, "[[:space:],]+")[[1]]
if (is.character(strip) && strip == "NULL") strip <- NULL

cat("\nupdated args:\n")
str(list(packages = packages, strip = strip))

if (!require("pak", character.only = TRUE, quietly = TRUE)) install.packages("pak")
pak::pak("r-wasm/rwasm")

message("\n\nAdding packages:\n", paste("* ", packages, sep = "", collapse = "\n"))
rwasm::add_pkg(packages)
# # https://github.com/r-wasm/rwasm/issues/4
# rwasm::add_pkg(packages, repo_dir = repo_dir)
message("\n\nMaking library")
rwasm::make_vfs_library(
  # # https://github.com/r-wasm/rwasm/issues/4
  # out_dir = out_dir,
  # repo_dir = repo_dir,
  strip = strip
)

# Copy after the fact
file.copy("repo", repo_dir, recursive = TRUE, overwrite = TRUE)
file.copy("vfs", out_dir, recursive = TRUE, overwrite = TRUE)

dir(base_dir, recursive = TRUE, all.files = TRUE)

# Set outputs
cat("vfs-dir=", out_dir_path, "\n", file = Sys.getenv("GITHUB_OUTPUT"), sep = "", append = TRUE)
cat("repo-dir=", repo_dir_path, "\n", file = Sys.getenv("GITHUB_OUTPUT"), sep = "", append = TRUE)
