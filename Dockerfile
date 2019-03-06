FROM ubuntu:18.04

LABEL maintainer='Seth Green seth@codeocean.com'

ARG DEBIAN_FRONTEND=noninteractive
ENV RSTUDIO_VERSION=1.1.463

RUN apt-get update && apt-get install -y \
  ca-certificates \
  curl \
  dvipng \
  gdebi-core \
  lmodern \
  pandoc \
  r-cran-devtools \
  texlive-latex-extra \
  texlive-fonts-recommended && \
  rm -rf /var/lib/apt/lists/*


# This installs Rstudio server
RUN curl https://download2.rstudio.org/rstudio-server-${RSTUDIO_VERSION}-amd64.deb -o rstudio.deb && \
  mkdir -p /etc/rstudio/ && \
  echo server-app-armor-enabled=0 > /etc/rstudio/rserver.conf && \
  gdebi -n rstudio.deb && \
  rm rstudio.deb  && \
  && apt-get purge -y --autoremove --gdebi-core

  RUN Rscript -e "devtools::install_github('crsh/papaja')"

    #library(devtools); \
    #  options(unzip = 'internal', repos = 'http://cran.cnr.berkeley.edu'); \
    #  Sys.setenv(TAR = '/bin/tar'); \

# can Rstudio launch

# what else is needed
