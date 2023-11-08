# build-wasm-packages

This action can be used to build a list of R packages for WebAssembly, create an R package library, and build a CRAN-like repository containing the R package binaries.

This action uses the [rwasm](https://r-wasm.github.io/rwasm/) R package to build packages for WebAssembly, which must be run in an environment with access to a Wasm development toolchain. The simplest way to ensure the availability of such a toolchain is to run the action in the development Docker container provided by webR: `ghcr.io/r-wasm/webr:main`. See the Usage section below for an example of this kind of set-up.

## Inputs

* **packages** (`'packages'`) - A file path to a text file containing a list of [R package references](https://r-lib.github.io/pkgdepends/reference/pkg_refs.html).
* **upload-image** (`true`) - Should the R package library filesystem image be uploaded as an artifact?
* **upload-repo** (`true`) - Should the R package repository be uploaded as an artifact?
* **strip** (`NULL`) - An R expression evaluating to a character vector of directories to strip when building the R package library image. Only the R package library is affected, the R package repository remains unchanged.

## Usage

Given the amount of boilerplate and the non-traditional use of `container` required for the workflow, it is recommended to use the reusable [build.yml](.github/workflows/build.yml) workflow file provided by this repository.

```yaml
jobs:
  build:
    uses: r-wasm/actions/.github/workflows/build.yml@v1
    with:
      upload-image: true
      upload-repo: false
      strip: c("demo", "doc", "examples", "help")
```

The workflow example above is equivalent to the following:

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    container: ghcr.io/r-wasm/webr:main
    steps:
    - uses: actions/checkout@v3
    - name: Build wasm packages
      uses: r-wasm/actions/build-wasm-packages@v1
      with:
        upload-image: true
        upload-repo: false
        strip: c("demo", "doc", "examples", "help")
```
