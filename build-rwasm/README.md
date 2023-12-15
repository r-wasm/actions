# build-rwasm

This action builds a list of R packages for WebAssembly, creates a WebAssembly file image containing an R package library, and creates a CRAN-like repository containing the R package binaries.

This action uses the [rwasm](https://r-wasm.github.io/rwasm/) R package to build packages for WebAssembly, which must be run in Docker container `ghcr.io/r-wasm/webr:main` to ensure access to a Wasm development toolchain. By requiring the step to use Docker, the action can only be run in `ubuntu` based runners.

## Inputs

* **packages** (`.`) - A string of [R package references](https://r-lib.github.io/pkgdepends/reference/pkg_refs.html).
* **repo-path** (`_site`) - Directory where the CRAN-like repository should be saved.
  * Note: Due to limitations in GitHub Actions, the saved files can not be altered in any subsequent steps. Related: [actions/runner#434](https://github.com/actions/runner/issues/434).
* **image-path** (`.`) - Directory where the R package library filesystem image should be saved.
* **strip** (`NULL`) - An R expression evaluating to [a character vector of directories](https://r-wasm.github.io/rwasm/reference/make_library.html#details) to remove when building the WebAssembly R package library image. To achieve a smaller bundle size, it is recommended to set `strip` to `c("demo", "doc", "examples", "help", "html", "include", "tests", "vignette")`.

## Steps

1. Install latest `r-wasm/rwasm`
2. Create the repo using `{rwasm}`
2. Create the WebAssembly file image using `{rwasm}`
3. Copy files to `repo-path` and `image-path` directory

## Usage

```yaml
jobs:
  image:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4

    - name: Build wasm image
      uses: ./build-file-system-image

    # Use `library.data` and `library.js.metadata` files in `./_site` directory
    # to create a GitHub Pages site.
```

```yaml
jobs:
  repo:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    - name: Build wasm packages
      uses: r-wasm/actions/build-rwasm@v1
      with:
        packages: |
          cli
  
    # Use `library.data` and `library.js.metadata` files or repository files
    # in `./_site` directory to create a GitHub Pages site.
```

To add the library image files to any GitHub release as assets files, use the [`release-file-system-image`](../examples/release-file-system-image.yml) workflow example.

The resulting CRAN-like repository can be used to create a GitHub Pages site using the [`deploy-cran-repo`](../examples/deploy-cran-repo.yml) workflow example. The package repository could alternatively be deployed to other static storage hosting in subsequent steps.
