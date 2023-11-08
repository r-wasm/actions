# GitHub Actions for working with R and WebAssembly
![r-wasm actions](https://github.com/r-wasm/actions/actions/workflows/testing.yml/badge.svg)

This repository stores GitHub Actions associated with R WebAssembly tasks, which can be used in CI. It also has a number of example workflows which use these actions.

## Releases and tags

We use major version tags to mark breaking changes in these actions. For the current version, please use the `v1` tag, e.g.:

```
- uses: r-wasm/actions/build-wasm-packages@v1
```

## List of actions

* [r-wasm/actions/build-wasm-packages](https://github.com/r-wasm/actions/tree/v1/build-wasm-packages) - Build a list of R packages for WebAssembly, create an R library, and build a CRAN-like repository containing the R package binaries.

* [r-wasm/actions/download-wasm-artifacts](https://github.com/r-wasm/actions/tree/v1/download-wasm-artifacts) - Download GitHub Actions artifacts previously uploaded by `r-wasm/actions/build-wasm-packages`.

## Other GitHub Actions for R projects

* [r-lib/actions](https://github.com/r-lib/actions) - GitHub Actions for the R community
* [quarto-dev/quarto-actions](https://github.com/quarto-dev/quarto-actions) - Quarto related actions: install, render, publish

## Examples

See the [r-wasm/actions/examples](https://github.com/r-wasm/actions/tree/v1/examples) directory for example workflows using these actions.
