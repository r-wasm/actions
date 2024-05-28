ARG WEBR_IMAGE=ghcr.io/r-wasm/webr:main

# Container image that runs your code
FROM $WEBR_IMAGE

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY code.R /code.R

# TODO: Remove this workaround for r-wasm/webr#422 when no longer needed
RUN if [ -d "/root/R/x86_64-pc-linux-gnu-library" ]; then find /root/R/x86_64-pc-linux-gnu-library -maxdepth 2 -wholename '*/pak' -exec rm -rf {} \; ; fi
RUN /opt/R/current/bin/R -q -e 'install.packages("pak", lib = .Library)'

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT [ "Rscript" ]
# ENTRYPOINT [ "/bin/bash", "-l", "-c" ]
