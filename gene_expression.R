library(tidyverse)
library(plyr)
library(dplyr)
library(purrr)
library(stringr)
library("TCGAutils")


reader <- function(file, dir){
  df <- read.table(file, sep='\t', skip=6, header=FALSE)
}

dire <-list.dirs(path = "Gene_Expression_Quantification/", 
                full.names = TRUE, recursive = TRUE)
dir <- sort(basename(dire))
list_dir <- dir[-length(dir)]


files <- list.files("Gene_Expression_Quantification/", 
                    recursive=TRUE, full.names=TRUE)

myfilelist <- lapply(files, reader)

f_df <- bind_cols(myfilelist[[1]][1:2],
          imap(myfilelist, \(df, i) select(df, 4)) |> bind_cols())
          
old_names <- colnames(f_df[,3:ncol(f_df)])
set_names(f_df[,3:ncol], old=c(old_names), new=c(list_dir))

write.table(f_df, "TCGA_STAD_counts.txt", sep = '\t')


UUIDtoBarcode("ae55b2d3-62a1-419e-9f9a-5ddfac356db4", from_type = "case_id")


library("TCGAutils")

UUIDtoBarcode("", from_type="file_id")
