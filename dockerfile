FROM ubuntu:16.04
MAINTAINER Seth Green <seth@codeocean.com>

ENV R_BASE_VERSION 3.5.0
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
	&& locale-gen en_US.utf8 \
  && /usr/sbin/update-locale LANG=en_US.UTF-8

# R and apt-get dependencies

RUN echo "deb http://archive.linux.duke.edu/cran/bin/linux/ubuntu xenial/" >> /etc/apt/sources.list \
  && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9 \
  && apt-get update \
  && apt-get install -y r-base-dev=$R_VERSION \
  && apt-get install -y --no-install-recommends \
    ed \
    less \
    locales \
    vim-tiny \
    ca-certificates\
    fonts-texgyre \
    curl \
    git \
    unzip \ # now dependencies for papaja
    pandoc \
    texlive \
    texlive-publishers \
    texlive-fonts-extra \
    texlive-latex-extra \
    texlive-humanities \
    lmodern \
    libxml2-dev \
    libcairo2-dev \
    libssh2-1-dev \
    libudunits2-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    libxml2-dev \
    libcairo2-dev \
    libsqlite-dev \
    libmariadbd-dev \
    libmariadb-client-lgpl-dev \
    libpq-dev \
    libssh2-1-dev \
  && rm -rf /var/lib/apt/lists/*

# Set R environment variables/configure libraries
RUN echo "options(repos = c(CRAN = 'https://cran.rstudio.com/'), download.file.method = 'libcurl')" >> /etc/R/Rprofile.site \
  && echo "options(Ncpus = parallel::detectCores())" >> /etc/R/Rprofile.site \
  && mkdir -p /usr/local/lib/R/site-library \
  && chown root:staff /usr/local/lib/R/site-library \
  && chmod g+wx /usr/local/lib/R/site-library \
  && echo "R_LIBS_USER='/usr/local/lib/R/site-library'" >> /etc/R/Renviron \
  && echo "R_LIBS=\${R_LIBS-'/usr/local/lib/R/site-library:/usr/local/lib/R/library:/usr/lib/R/library'}" >> /etc/R/Renviron \
  && rm -rf /var/lib/apt/lists/*

# Install packages
R -e "install.packages(c('tidyverse','dplyr','ggplot2','devtools','formatR','remotes', 'rmarkdown'), dependencies=c('Depends','Imports','LinkingTo'))"
R -e "devtools::install_github('crsh/papaja')"

CMD ["R"]
