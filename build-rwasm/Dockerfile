# Container image that runs your code
FROM ghcr.io/r-wasm/webr:main

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY code.R /code.R

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT [ "Rscript" ]
# ENTRYPOINT [ "/bin/bash", "-l", "-c" ]
