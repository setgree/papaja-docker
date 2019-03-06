# papaja-docker

## What I have:
a dockerfile for running `papaja` (I think)

## What I want
A dockerfile for running a remote Rstudio instance

## The problem
Is two-fold
* The Rocker/Rstudio image is a bit abstract for me (pulls from a lot of layers whose innards I'm not familiar with)
* I want to start from Ubuntu 18.04 (where I know the most)
 For reasons unclear (to me) `dpkg` isn't working for installing Rstudio though it did in Ubuntu:16.04; `gdebi` worked but `gdebi` is big and I want to optimize that.


## Scratch
`docker run -d -p 8787:8787 setgree/papaja_docker`

Visit localhost:8787 in your browser and log in with username:password as rstudio:rstudio.
