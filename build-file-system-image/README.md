# build-file-system-image

This action builds a list of R packages for WebAssembly and creates WebAssembly file image containing an R package library.

This action uses the [rwasm](https://r-wasm.github.io/rwasm/) R package to build packages for WebAssembly, which must be run in Docker container `ghcr.io/r-wasm/webr:main` to ensure access to a Wasm development toolchain. By requiring the step to use Docker, the action can only be run in `ubuntu` based runners.

## Inputs

* **packages** (`file::.`) - A string of [R package references](https://r-lib.github.io/pkgdepends/reference/pkg_refs.html).
  *
* **image-path** (`.`) - The path to the directory where the R package library filesystem image files should be saved.
  * Note: Due to limitations in GitHub Actions, the saved files can not be altered in any subsquent steps. Related: [actions/runner#434](https://github.com/actions/runner/issues/434).
* **strip** (`NULL`) - An R expression evaluating to a character vector of directories to strip when building the R package library image. Only the R package library is affected, the R package repository remains unchanged.

## Steps

1. Install latest `r-wasm/rwasm`
2. Create the WebAssembly file image using `{rwasm}`
3. Copy files to `image-path` directory

## Usage

```yaml
jobs:
  image:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3

    - name: Build wasm image
      uses: ./build-file-system-image

    # Use `library.data` and `library.js.metadata` files in `./_site` directory
    # to create a GitHub Pages site.
```

To add the library image files to any GitHub release as assets files, use the [`release-filesystem-image`](../examples/release-filesystem-image.yml) workflow example.

```yaml
on:
  release:
    types: [ published ]
jobs:
  release-filesystem-image:
    uses: r-wasm/actions/.github/workflows/release-filesystem-image.yml@v1
    permissions:
      contents: write
      repository-projects: read
    with:
      strip: c("demo", "doc", "examples", "help", "html", "include", "tests", "vignette")
```

To leverage this reusable workflow, run the following R command in the root of your GitHub repository:

```R
usethis::use_github_action(
  url = "https://raw.githubusercontent.com/r-wasm/actions/v1/examples/release-filesystem-image.yml"
)
```
