# download-wasm-artifacts

This action can be used to download previously built GitHub Action artifacts consisting of a wasm friendly R package library and/or a CRAN-like repository containing the R package binaries.

## Inputs

* **repo-path** (`''`) - Path to download the R package repository artifact to.
* **image-path** (`''`) - Path to download the R package library filesystem image artifact to.

## Usage

```yaml
jobs:
  build:
    uses: r-wasm/actions/.github/workflows/build.yml@v1
    with:
      upload-image: true
      upload-repo: false
  deploy:
    name: Deploy to GitHub pages
    needs: build
    runs-on: ubuntu-latest
    permissions:
      pages: write
      id-token: write
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    steps:
      - uses: actions/checkout@v3
      - name: Download wasm artifacts
        uses: r-wasm/actions/download-wasm-artifacts@v1
        with:
          repo-path: _site
          image-path: _site
      - name: Upload Pages artifact
        uses: actions/upload-pages-artifact@v2
      - name: Deploy to GitHub Pages
        uses: actions/deploy-pages@v2
```
