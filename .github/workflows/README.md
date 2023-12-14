# r-wasm/actions Reusable workflows

This directory contains [reusable workflows](https://docs.github.com/en/actions/learn-github-actions/reusing-workflows) for use in other repositories. Workflows are stored in the `.github/workflows` directory of this repository, and can be used in other repositories by referencing the workflow file in the `uses` field of a workflow step.

Workflows whose name starts with an `_` are for internal use only and should not be used by other repositories.

## Reusable workflows

### [deploy-cran-repo.yml](https://github.com/r-wasm/actions/tree/main/.github/workflows/deploy-cran-repo.yml)

Builds a CRAN-like repository for R WebAssembly and deploys the repo to GitHub Pages ([in beta](https://github.com/actions/upload-pages-artifact)).

Great for groups and organizations using a meta GitHub repo to create a centralized R WebAssembly CRAN-like repository.  Similar to CRAN, only the latest published repository version will persist.

#### Steps

1. Checkout the GitHub repository
2. Build the repository with `r-wasm/actions/build-cran-repo`
3. Deploy the repository to GitHub pages with `actions/upload-pages-artifact`

#### Inputs

* **packages** (`'packages'`) - A string of [R package references](https://r-lib.github.io/pkgdepends/reference/pkg_refs.html). If an empty value is provided (default), the workflow will read `./packages` file for the R package references.

#### Usage

To leverage this reusable workflow, run the following R command in the root of your GitHub repository:

```R
usethis::use_github_action(
  url = "https://raw.githubusercontent.com/r-wasm/actions/v1/examples/deploy-cran-repo.yml"
)
```


### [release-file-system-image.yml](https://github.com/r-wasm/actions/tree/main/.github/workflows/release-file-system-image.yml)

Builds a [WebAssembly file image](https://docs.r-wasm.org/webr/latest/mounting.html)  and adds the files to a GitHub release.

This is typically used within R packages to build and release a WebAssembly R package library image of your package and its dependencies. Because the assets are tied to a release, they will never be overwritten are are stable over time.

#### Steps

1. Checkout the GitHub repository
2. Build the library image with `r-wasm/actions/build-cran-repo`
3. Add the library image to the release with `svenstaro/upload-release-action`

#### Inputs

* **packages** (`'.'`) - A string of [R package references](https://r-lib.github.io/pkgdepends/reference/pkg_refs.html). In addition to `packages` value, any R packages listed in `Config/Needs/wasm` in the `DESCRIPTION` file will automatically be added to the list.
* **strip** (`NULL`) - An R expression evaluating to [a character vector of directories](https://r-wasm.github.io/rwasm/reference/make_library.html#details) to remove when building the WebAssembly R package library image. To achieve a smaller bundle size, it is recommended to set `strip` to `c("demo", "doc", "examples", "help", "html", "include", "tests", "vignette")`.

#### Usage

To leverage this reusable workflow, run the following R command in the root of your GitHub repository:

```R
usethis::use_github_action(
  url = "https://raw.githubusercontent.com/r-wasm/actions/v1/examples/release-file-system-image.yml"
)
```
