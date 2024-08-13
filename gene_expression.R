library(tidyverse)
library(plyr)
library(dplyr)
library(purrr)
library(stringr)


reader <- function(f){
  df <- read.table(f, sep='\t', skip=6, header=FALSE)
  colnames(df)[4] <- str_replace(basename(f), ".rna_seq.augmented_star_gene_counts.tsv", "")
  df
}

files <- list.files("Gene_Expression_Quantification/", 
                    recursive=TRUE, full.names=TRUE)

myfilelist <- lapply(files, reader)


f_df <- bind_cols(myfilelist[[1]][1:2],
          imap(myfilelist, \(df, i) select(df, 4)) |> bind_cols())

write.table(f_df, "TCGA_STAD_counts.txt", sep = '\t')
