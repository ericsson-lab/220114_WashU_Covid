# Title: Process initial data
# Author: zlmg2b
# Date: Sat Jan 15 19:08:28 2022
# --------------
# Author: zlmg2b
# Date: 1/15/2022
# Modification: completed
# --------------

library(tidyverse)
library(readxl)
library(qiime2R)


## Goals:
## -- DONE: Phylum level per ASV (Human & Mouse)

## Set wd to data 
setwd("data/")
getwd()

# Read in TaxonomyQZA file
taxonomy.qza <- read_qza(file = "taxonomy/taxonomy.qza")

# Extract taxonomy from taxonomy.qza
# Filter down to Feature.ID, Taxon
# Parse Taxonomy with qiime2R::parse_taxonomy()
# Keep phylum
taxonomy.phylum <- taxonomy.qza$data %>% 
  select(Feature.ID, Taxon) %>% 
  parse_taxonomy() %>% 
  select(Phylum) %>% 
  rownames_to_column(var = "Feature.ID")
write_tsv(taxonomy.phylum, file = "taxonomy/taxonomy.phylum.tsv")



