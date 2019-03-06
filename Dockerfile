FROM ubuntu:18.04

LABEL maintainer='Seth Green seth@codeocean.com'

ARG DEBIAN_FRONTEND=noninteractive
ENV RSTUDIO_VERSION=1.1.463

RUN apt-get update && apt-get install -y \
  dvipng \
  lmodern \
  pandoc \
  r-cran-devtools \
  texlive-latex-extra \
  texlive-fonts-recommended \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*


  RUN Rscript -e "devtools::install_github('crsh/papaja')"

# can Rstudio launch

# what else is needed
