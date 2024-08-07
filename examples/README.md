# r-wasm/actions Examples

This directory contains example workflows that call `r-wasm/actions`'s [reusable workflows](https://docs.github.com/en/actions/learn-github-actions/reusing-workflows). Workflows should be stored in the `.github/workflows` directory of your repository.

## Examples

### [deploy-cran-repo.yml](https://github.com/r-wasm/actions/tree/main/examples/deploy-cran-repo.yml)

On a push to the `main` branch on GitHub, it builds a CRAN-like repository for R WebAssembly and deploys the repo to GitHub Pages ([in beta](https://github.com/actions/upload-pages-artifact)).

Great for groups and organizations using a meta GitHub repo to create a centralized R WebAssembly CRAN-like repository.  Similar to CRAN, only the latest published repository version will persist.

#### Steps

1. Checkout the GitHub repository
2. Build the repository with `r-wasm/actions/build-cran-repo`
3. Deploy the repository to GitHub pages with `actions/upload-pages-artifact`

#### Inputs available

* **packages** (`'packages'`) - A string of [R package references](https://r-lib.github.io/pkgdepends/reference/pkg_refs.html). If an empty value is provided (default), the workflow will read `./packages` file for the R package references.
* **compress** (`false`) - Compress Emscripten VFS images. Defaults to `false`. Loading compressed VFS images requires at least version 0.4.1 of webR.

#### Usage

To leverage this reusable workflow, run the following R command in the root of your GitHub repository:

```R
usethis::use_github_action(
  url = "https://raw.githubusercontent.com/r-wasm/actions/v2/examples/deploy-cran-repo.yml"
)
```

### [release-file-system-image.yml](https://github.com/r-wasm/actions/tree/main/examples/release-file-system-image.yml)

On a published GitHub release, it builds a WebAssembly file image and adds the files to a GitHub release.

This is typically used within R packages to build and release a WebAssembly R package library image of your package and its dependencies. Because the assets are tied to a release, they will never be overwritten are are stable over time.

#### Steps

1. Checkout the GitHub repository
2. Build the library image with `r-wasm/actions/build-cran-repo`
3. Add the library image to the release with `svenstaro/upload-release-action`

#### Inputs available

* **packages** (`'.'`) - A string of [R package references](https://r-lib.github.io/pkgdepends/reference/pkg_refs.html).
* **strip** (`NULL`) - An R expression evaluating to [a character vector of directories](https://r-wasm.github.io/rwasm/reference/make_library.html#details) to remove when building the WebAssembly R package library image. To achieve a smaller bundle size, it is recommended to set `strip` to `c("demo", "doc", "examples", "help", "html", "include", "tests", "vignette")`.
* **compress** (`false`) - Compress Emscripten VFS images. Defaults to `false`. Loading compressed VFS images requires at least version 0.4.1 of webR.


#### Usage

To leverage this reusable workflow, run the following R command in the root of your GitHub repository:

```R
usethis::use_github_action(
  url = "https://raw.githubusercontent.com/r-wasm/actions/v2/examples/release-file-system-image.yml"
)
```
