# GitHub Actions for working with R and WebAssembly

![r-wasm actions](https://github.com/r-wasm/actions/actions/workflows/_testing.yml/badge.svg)

This repository stores GitHub actions and [reusable workflows](https://docs.github.com/en/actions/using-workflows/reusing-workflows) associated with R WebAssembly tasks, which can be used in CI. It also has a number of example workflows which use these actions.

## Releases and tags

We use major version tags to mark breaking changes in these actions. For the current version, please use the `v1` tag, e.g.:

```yaml
jobs:
  deploy-cran-repo:
    uses: r-wasm/actions/.github/workflows/deploy-cran-repo.yml@v1
```

## Reusable workflows

* [`r-wasm/actions/.github/workflows/deploy-cran-repo.yml`](https://github.com/r-wasm/actions/tree/main/.github/workflows#deploy-cran-repo.yml) - Reusable workflow that will build a CRAN-like repository for R WebAssembly and deploys the repo to GitHub pages ([in beta](https://github.com/actions/upload-pages-artifact)). Great for groups and organizations using a meta GitHub repo to create a centralized R WebAssembly CRAN-like repository. Similar to CRAN, users do not need to download every package and only the latest published repository version will persist.


* [r-wasm/actions/.github/workflows/release-image.yml](https://github.com/r-wasm/actions/tree/main/.github/workflows#release-image.yml) - Reusable workflow that builds a [WebAssembly file image](https://docs.r-wasm.org/webr/latest/mounting.html) and adds the files to a GitHub release. This is typically used within R packages to build and release a Wasm R package library image of your package and its dependencies. Because the assets are tied to a release, they will never be overwritten are are stable over time.

For more documentation about these worfklows, please see the [reusable workflow readme](https://github.com/r-wasm/actions/tree/main/.github/workflows).



## Actions

* [`r-wasm/actions/build-file-system-image`](https://github.com/r-wasm/actions/tree/main/build-file-system-image) - Builds a R package into an WebAssembly file image. This is useful for [mounting a Wasm R package library](https://docs.r-wasm.org/webr/latest/mounting.html) directory in a container using only two files.

* [`r-wasm/actions/build-cran-repo`](https://github.com/r-wasm/actions/tree/main/build-wasm-packages) - Build a set of R packages for WebAssembly in a CRAN-like repository containing the R package binaries.

## Examples

See the [r-wasm/actions/examples](https://github.com/r-wasm/actions/tree/main/examples) directory for example workflows using these actions and workflows.

## Other GitHub Actions for R projects

* [r-lib/actions](https://github.com/r-lib/actions) - GitHub Actions for the R community
* [quarto-dev/quarto-actions](https://github.com/quarto-dev/quarto-actions) - Quarto related actions: install, render, publish
