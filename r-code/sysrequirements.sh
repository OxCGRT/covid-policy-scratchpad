#!/bin/bash
sudo apt-get install libcurl4-openssl-dev
sudo apt install -y libudunits2-0 libudunits2-dev
sudo apt install libgdal-dev
Rscript -e 'install.packages("remotes")'
Rscript -e 'remotes::install_cran(c("tidyr", "tidyverse", "dplyr", "ggplot2", "scales", "tidyverse", "lubridate", "here", "curl", "readr", "writexl", "openxlsx", "sf", "ggthemes", "zoo", "rgeos", "janitor"))'
