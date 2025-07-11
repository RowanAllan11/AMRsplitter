# About:
We built this snakemake pipeline to benchmark the plasmid contig predictor tool GplasCC and assess its AMR gene localisation capabilities on short-read data.

The steps include:
- Quality checking the reads using `fastQC`.
- Trimming reads for adapters and low quality base pairs using `trimmomatic`.
- Assembling the reads using `unicycler`.
- Binning plasmid-predicted contigs using `gplasCC` which are removed from the unicycler assembly `fasta` file to create a chromosome only `fasta` file.
- Calling AMR genes on both the chromosome and plasmid `fasta` files using `AMRFinderPlus`.
- Collecting AMR gene totals and lists in an overall summary `csv` file for each read.

## Usage
First, the conda environments can be installed using the following command:

    snakemake --use-conda --conda-create-envs-only

Then, the workflow can be used with the default config file and 15 threads:

    snakemake --use-conda --cores 15

## Input/Output

**Input**:

* Paired-end FASTQ files stored in the data/directory. These files follow the naming format `{sample}_1.fastq.gz` and `{sample}_2.fastq.gz`.
* Sample name (without the _1 or _2 suffix) in the config.yaml file.

**Output**:

* The genome of the sample (with the plasmid sequences) in a FASTA file format in `results/{sample}/unicycler/assembly.fasta`
* The predicted chromosome contigs in a FASTA file format in `results/{sample}/gplasCC/chrom.fasta`
* The predicted plasmid contigs in a FASTA file format in `results/{sample}/gplasCC/combined.fasta`
* A table in `results/combined_amr_summary.csv` summarising the metadata on the generated FASTA files:
    - Total number of AMR genes
    - List of chromosome AMR genes
    - List of plasmid AMR genes

## Example Folder
https://github.com/RowanAllan11/Plasmid_Segregator/blob/main/example_folder.txt

# Data used for pipeline testing:
**In this project, we benchmarked 31 Salmonella enterica samples which contained integrated plasmids and SGIs contributing to chromosomal resistance.**

These genomes were sourced from the **BioProject PRJNA292661** and were annotated by:

Li, Cong et al. “Long-Read Sequencing Reveals Evolution and Acquisition of Antimicrobial Resistance and Virulence Genes in Salmonella enterica.” Frontiers in microbiology vol. 12 777817. 19 Nov. 2021, doi:10.3389/fmicb.2021.777817

The full list of samples including their true AMR gene localisation is available [here](https://github.com/RowanAllan11/AMRsplitter/blob/main/accessions/Sample_Accessions.xlsx).

## Script: Performance_Metrics.R
This script evaluates the performance of short-read AMR gene localisation which is outputted by AMRsplitter in `combined_amr_summary.csv` by comparing it against the "ground truth" data in `accessions/Sample_Accessions.xlsx`. It computes gene-level classification metrics — True Positives (TP), False Positives (FP), False Negatives (FN) — and calculates Precision, Recall and F1-score for both plasmid and chromosome AMR genes on a per-sample basis.

## Graphs
Plots were generated using code adapted from https://gitlab.com/jpaganini/ecoli-binary-classifier, the script was modified to accommodate output from the `Performance_Metrics.R` script.
