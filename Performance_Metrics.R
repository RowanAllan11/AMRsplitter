# Rowan Allan
# June 2025

# Combining the AMR gene localisation data from the snakemake pipeline with the known chromosome and plasmid AMR gene content from the accession spreadsheets. This script uses multiset comparison logic, employing table() and pmin()/pmax() to compute TP, FP and FN counts.

# Load Packages
library(readxl)
library(dplyr)
library(stringr)
library(writexl)

# Load the output from the snakemake pipeline.
sr <- read.csv("results/combined_amr_summary.csv")

# Input name of file containing list of AMR genes in "ground-truth" location corresponding to samples run in the snakemake pipeline e.g. SGI_Accessions.xlsx.
hybrid <- read_excel("accessions/Sample_Accessions.xlsx")

# Function to convert a spaced string to a trimmed list.
parse_genes <- function(gene_string) {
  if (is.na(gene_string)) return(character(0))
  unlist(strsplit(gene_string, " "))
}

# Parse genes from the plasmid and chromosomal columns in both input files.
sr$Plasmid_AMR_genes <- lapply(sr$Plas_AMR_genes, parse_genes)
sr$Chromosomal_AMR_genes <- lapply(sr$Chr_AMR_genes, parse_genes)
hybrid$Plasmid_AMR_genes <- lapply(hybrid$Plas_AMR_genes, parse_genes)
hybrid$Chromosomal_AMR_genes <- lapply(hybrid$Chr_AMR_genes, parse_genes)

# Align rows by sample ID.
hybrid <- hybrid[match(sr$assemblyID, hybrid$assemblyID), ]

# Function for assigning true positives, false positives and false negatives to genes.
metrics <- function(sr_genes, hyb_genes) {
  sr_table <- table(sr_genes) 
  hyb_table <- table(hyb_genes)
  all_genes <- union(names(sr_table), names(hyb_table))
  
  sr_counts <- as.integer(sr_table[all_genes])
  hyb_counts <- as.integer(hyb_table[all_genes])
  
  # Replace NAs with 0 for missing genes.
  sr_counts[is.na(sr_counts)] <- 0
  hyb_counts[is.na(hyb_counts)] <- 0
  
  TP <- sum(pmin(sr_counts, hyb_counts)) # True positives - overlapping gene occurrences in the SR data with hybrid.
  FP <- sum(pmax(sr_counts - hyb_counts, 0)) # False positives - counts extra genes found in SR not found in hybrid.
  FN <- sum(pmax(hyb_counts - sr_counts, 0)) # False negatives - counts genes found in hybrid which aren't found in SR.
  
  return(c(TP = TP, FP = FP, FN = FN))
}

# Precision function.
precision <- function(tp, fp) {
  if ((tp + fp) == 0) return(NA)
  tp / (tp + fp)
}

# Recall function.
recall <- function(tp, fn) {
  if ((tp + fn) == 0) return(NA)
  tp / (tp + fn)
}

# F1 function.
f1_score <- function(precision, recall) {
  if (is.na(precision) | is.na(recall) | (precision + recall) == 0) return(NA)
  2 * (precision * recall) / (precision + recall)
}

# Function wrapper.
get_metrics <- function(tp, fp, fn) {
  prec <- precision(tp, fp)
  rec <- recall(tp, fn)
  f1 <- f1_score(prec, rec)
  
  return(list(Precision = prec, Recall = rec, F1_Score = f1))
}

# Metrics and get_metrics functions can be used on chromosomal and plasmidic gene lists to generate a results csv.

# Results dataframe headers
results <- data.frame(Sample_ID = sr$assemblyID, Plasmid_TP = integer(nrow(sr)), Plasmid_FP = integer(nrow(sr)), Plasmid_FN = integer(nrow(sr)), Plasmid_Precision = numeric(nrow(sr)), Plasmid_Recall = numeric(nrow(sr)), Plasmid_F1 = numeric(nrow(sr)), Chrom_TP = integer(nrow(sr)), Chrom_FP = integer(nrow(sr)), Chrom_FN = integer(nrow(sr)), Chrom_Precision = numeric(nrow(sr)), Chrom_Recall = numeric(nrow(sr)), Chrom_F1 = numeric(nrow(sr))
)

# Loop over each sample.
for (i in 1:nrow(sr)) {
  sr_plas <- sr$Plasmid_AMR_genes[[i]]
  sr_chrom <- sr$Chromosomal_AMR_genes[[i]]
  hyb_plas <- hybrid$Plasmid_AMR_genes[[i]]
  hyb_chrom <- hybrid$Chromosomal_AMR_genes[[i]]
  
  # Calculate metrics for plasmid genes.
  plas_metrics <- metrics(sr_plas, hyb_plas)
  plas_scores <- get_metrics(plas_metrics["TP"], plas_metrics["FP"], plas_metrics["FN"])
  
  # Calculate metrics for chromosomal genes.
  chrom_metrics <- metrics(sr_chrom, hyb_chrom)
  chrom_scores <- get_metrics(chrom_metrics["TP"], chrom_metrics["FP"], chrom_metrics["FN"])
  
  # Store results in dataframe.
  results[i, 2:13] <- c(plas_metrics, plas_scores, chrom_metrics, chrom_scores)
}

print(results)

# Save to CSV
write.csv(results, "overall_metrics.csv", row.names = FALSE)