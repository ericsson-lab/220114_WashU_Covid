# Title: ANCOM Analysis
# Author: zlmg2b
# Date: Sat Jan 15 19:26:06 2022
# --------------
# Author: zlmg2b
# Date:
# Modification:
# --------------

library(tidyverse)
library(readxl)

## Goals: 
## -- Format metadata for ACNOM Analysis
## -- Split human and mouse
## -- Split mouse data up into last timepoint no dose vs dose

## set wd to data directory
setwd("data/")
getwd()

## ---- MOUSE -----
## Filter metadata down to Mouse samples
read_tsv("metadata.txt") %>% 
  filter(Source == "Mouse") %>% 
  # select relevant columns, leaving out Eartag
  select(SampleID, Day, Dilution, Source) %>% 
  # filter down to day 28
  filter(Day == 28) %>% 
  count(Dilution)


## ---- HUMAN ----
## Filter metadta down to Human sample
read_tsv("metadata.txt") %>% 
  filter(Source == "Human") %>% 
  select(SampleID, Cohort, Gender, Designation)



