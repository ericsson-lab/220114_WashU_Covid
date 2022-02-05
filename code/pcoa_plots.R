# Title: Human/Mouse PCoAs
# Author: zlmg2b
# Date: Sat Jan 15 21:41:35 2022
# --------------
# Author: zlmg2b
# Date:
# Modification:
# --------------

library(ggtext)
library(tidyverse)
library(readxl)
library(RColorBrewer)
library(qiime2R)
library(cowplot)

library(vegan)


## Goals:
## -- Plot PCoAs for human/mouse studies

build_pcoa_mouse <- function(pcoa_results) {
  
  hull <- pcoa_results$data$Vectors %>%
    select(SampleID, PC1, PC2) %>% 
    inner_join(., metadata, by = "SampleID") %>% 
    filter(Source == "Mouse") %>% 
    # select relevant columns, leaving out Eartag
    select(SampleID, PC1, PC2, Day, Dilution) %>% 
    filter(Day == 28) %>% 
    group_by(Dilution) %>%
    slice(chull(PC1, PC2))
  
  
  pcoa_results$data$Vectors %>%
    select(SampleID, PC1, PC2) %>% 
    left_join(metadata) %>% 
    filter(Day == 28) %>% 
    ggplot(aes(x=PC1, y=PC2, color = Dilution, shape = Dilution)) +
    geom_point(alpha=0.6, size = 2) + #alpha controls transparency and helps when points are overlapping
    geom_polygon(data = hull,
                 aes(fill = Dilution,
                     color = Dilution),
                 alpha = 0.3,
                 show.legend = FALSE) +
    labs(x = c(paste("PCo1 - ",round(pcoa_results$data$Eigvals$PC1, 2), "%", sep = "")),
         y = c(paste("PCo2 - ",round(pcoa_results$data$Eigvals$PC2, 2), "%", sep = ""))) +
    theme_q2r() +
    theme(axis.text = element_text(color = "black", size = 10,
                                   family = "sans", face = "bold"),
          axis.title = element_text(color = "black", size = 12, 
                                    family = "sans", face = "bold"),
          legend.text = element_text(color = "black", size = 8,
                                     family = "sans", face = "bold"),
          legend.title = element_text(color = "black", size = 10,
                                      family = "sans", face = "bold")) 
}

build_pcoa_human <- function(pcoa_results) {
  
  hull <- pcoa_results$data$Vectors %>%
    select(SampleID, PC1, PC2) %>% 
    inner_join(., metadata, by = "SampleID") %>% 
    filter(Source == "Mouse") %>% 
    # select relevant columns, leaving out Eartag
    select(SampleID, PC1, PC2, Day, Dilution) %>% 
    filter(Day == 28) %>% 
    group_by(Dilution) %>%
    slice(chull(PC1, PC2))
  
  
  pcoa_results$data$Vectors %>%
    select(SampleID, PC1, PC2) %>% 
    left_join(metadata) %>% 
    filter(Day == 28) %>% 
    ggplot(aes(x=PC1, y=PC2, color = Dilution, shape = Dilution)) +
    geom_point(alpha=0.6, size = 2) + #alpha controls transparency and helps when points are overlapping
    geom_polygon(data = hull,
                 aes(fill = Dilution,
                     color = Dilution),
                 alpha = 0.3,
                 show.legend = FALSE) +
    labs(x = c(paste("PCo1 - ",round(pcoa_results$data$Eigvals$PC1, 2), "%", sep = "")),
         y = c(paste("PCo2 - ",round(pcoa_results$data$Eigvals$PC2, 2), "%", sep = ""))) +
    theme_q2r() +
    theme(axis.text = element_text(color = "black", size = 10,
                                   family = "sans", face = "bold"),
          axis.title = element_text(color = "black", size = 12, 
                                    family = "sans", face = "bold"),
          legend.text = element_text(color = "black", size = 8,
                                     family = "sans", face = "bold"),
          legend.title = element_text(color = "black", size = 10,
                                      family = "sans", face = "bold")) 
}


setwd("data/")
getwd()

metadata <- read_tsv("metadata.txt")

jaccard_pcoa <- read_qza("core-metrics-results_42487/jaccard_pcoa_results.qza")
j_pcoa_mouse <- build_pcoa_mouse(jaccard_pcoa) + ggtitle("Jaccard")

bc_pcoa <- read_qza("core-metrics-results_42487/bray_curtis_pcoa_results.qza")
bc_pcoa_mouse <- build_pcoa_mouse(bc_pcoa) + ggtitle("Bray Curtis")


## Plot mouse data
leg <- get_legend(j_pcoa_mouse)

prow <- plot_grid(j_pcoa_mouse + theme(legend.position = "none",
                                 title = element_text(color = "black",
                                                      face = "bold")),
                  bc_pcoa_mouse + theme(legend.position = "none",
                                  title = element_text(color = "black",
                                                       face = "bold")),
                  labels = "AUTO",
                  hjust = 0)

plot_grid(prow, leg, rel_widths = c(3,0.3))

ggsave("plots/pcoa/mouse_d28_bc_j_pcoa_no-stats.tiff", 
       dpi = 600, bg = "white")


metadata <- read_tsv("metadata.txt")


jaccard_pcoa$data$Vectors %>%
  select(SampleID, PC1, PC2) 
  inner_join(., metadata, by = "SampleID") %>% 
  count(Source)
  # select relevant columns, leaving out Eartag
  select(SampleID, PC1, PC2, Day, Dilution) %>% 
  filter(Day == 28) %>% 
  group_by(Dilution) %>%
  slice(chull(PC1, PC2))




