# Container image that runs your code
FROM ghcr.io/r-wasm/webr:main

# Needed to be able to adjust files after running Dockerfile
# Related: https://github.com/actions/runner/issues/434
USER root

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY code.R /code.R

# Code file to execute when the docker container starts up (`entrypoint.sh`)
# ENTRYPOINT [ "/bin/bash", "-l", "-c" ]
ENTRYPOINT [ "Rscript" ]
