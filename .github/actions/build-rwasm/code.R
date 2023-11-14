args <- commandArgs(trailingOnly = TRUE)
# cat("\nargs:\n")
# str(args)

if (length(args) == 0) {
  stop(
    "No `packages` specified. ",
    "Please add extra argument to your Rscript call specify `packages`."
  )
}

packages <- args[1]
strip <- if (length(args) > 1) args[2] else NULL

packages <- strsplit(packages, "[[:space:],]+")[[1]]
if (is.character(strip) && strip == "NULL") strip <- NULL

# cat("\nupdated args:\n")
# str(list(packages = packages, strip = strip))

if (!require("pak", character.only = TRUE, quietly = TRUE)) install.packages("pak")
pak::pak("r-wasm/rwasm")

message("\n\nAdding packages:\n", paste("* ", packages, sep = "", collapse = "\n"))
rwasm::add_pkg(packages)
message("\n\nMaking library")
rwasm::make_vfs_library(strip = strip)

# Set outputs
cat("vfs-dir=vfs\n", file = Sys.getenv("GITHUB_OUTPUT"), sep = "", append = TRUE)
cat("repo-dir=repo\n", file = Sys.getenv("GITHUB_OUTPUT"), sep = "", append = TRUE)
