# build-wasm-packages

This action builds a list of R packages for WebAssembly and creates a CRAN-like repository containing the R package binaries.

This action uses the [rwasm](https://r-wasm.github.io/rwasm/) R package to build packages for WebAssembly, which must be run in Docker container `ghcr.io/r-wasm/webr:main` to ensure access to a Wasm development toolchain. By requiring the step to use Docker, the action can only be run in `ubuntu` based runners.

## Inputs

* **packages** (*required*) - A string of [R package references](https://r-lib.github.io/pkgdepends/reference/pkg_refs.html).
* **repo-path** (`_site`) - The path to the directory where the R package library filesystem image files should be saved.
  * Note: Due to limitations in GitHub Actions, the saved files can not be altered in any subsquent steps. Related: [actions/runner#434](https://github.com/actions/runner/issues/434).

## Steps

1. Install latest `r-wasm/rwasm`
2. Create the repo using `{rwasm}`
3. Copy files to the `repo-path` directory

## Usage

```yaml
jobs:
  repo:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - name: Build wasm repo
      uses: r-wasm/actions/build-cran-repo@v1
      with:
        packages: |
          cli
        repo-path: out-repo
```

Typically, the repository is then used to create a GitHub Pages site. This can be done using the [`build-and-deploy-repo`](../examples/build-and-deploy.yml) workflow example.

```yaml
on:
  push:
    branches: [main, master]
jobs:
  build-and-deploy-repo:
    uses: r-wasm/actions/.github/workflows/build-and-deploy-repo.yml@v1
    permissions:
      repository-projects: read
      pages: write
      id-token: write
```

To leverage this reusable workflow, run the following R command in the root of your GitHub repository:

```R
usethis::use_github_action(
  url = "https://raw.githubusercontent.com/r-wasm/actions/v1/examples/build-and-deploy-repo.yml"
)
```
