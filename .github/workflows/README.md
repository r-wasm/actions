# r-wasm/actions Reusable workflows

This directory contains [reusable workflows](https://docs.github.com/en/actions/learn-github-actions/reusing-workflows) for use in other repositories. Workflows are stored in the `.github/workflows` directory of this repository, and can be used in other repositories by referencing the workflow file in the `uses` field of a workflow step.

Workflows whose name starts with an `_` are intended for internal use only, and should not be used in other repositories.

## List of workflows

#### [`r-wasm/actions/.github/workflows/build.yml`](https://github.com/r-wasm/actions/tree/v1/.github/workflows/build.yml)

Reusable workflow to conveniently checkout the repo, and build/upload the package via [`r-wasm/actions/build-wasm-packages`](https://github.com/r-wasm/actions/tree/v1/build-wasm-packages).

##### Usage

```yaml
on:
  push:
    branches: [main, master]
  pull_request:
    branches: [main, master]
  workflow_dispatch:

name: Build wasm R package repository

jobs:
  build:
    uses: r-wasm/actions/.github/workflows/build.yml@v1
```

To setup this file in your repository, run the following command:

```r
usethis::use_github_action(
  url = "https://raw.githubusercontent.com/r-wasm/actions/v1/examples/build-wasm-repo.yml",
  save_as = "build2.yml"
)
```
