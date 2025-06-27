# About:
We built this snakemake pipeline to benchmark the plasmid contig predictor tool GplasCC and assess its AMR gene localisation capabilities on short-read data.

The steps include:
- Quality checking the reads using "fastQC".
- Trimming reads for adapters and low quality base pairs using "trimmomatic".
- Assembling the reads using "unicycler".
- Binning plasmid-predicted contigs using "gplasCC" which are removed from the unicycler assembly "fasta" file to create a chromosome only "fasta" file.
- Calling AMR genes on both the chromosome and plasmid "fasta" files using "AMRFinderPlus".
- Collecting AMR gene totals and lists in an overall summary "csv" file for each read.

# Quick-start guide
A complete list of the short-read datasets used in our analysis is available [here](https://..).

An example paired-end short-read sample is provided in the data/ directory and referenced in the config.yaml file. These files follow the naming format {sample}_1.fastq.gz and {sample}_2.fastq.gz, where {sample} is typically the run ID. This example can be used to test the workflow.

To run the workflow on additional samples, download the paired-end reads into the data/ directory and add the sample name without the _1 or _2 suffix to the config.yaml file.

# Example Folder
https://github.com/RowanAllan11/Plasmid_Segregator/blob/main/example_folder.txt

## Relevant folders for output:

- results/{sample}/gplasCC/chrom.fasta : chromosome FASTA file for further visualisation or annotation.
- results/{sample}/gplasCC/combined.fasta : combined plasmid FASTA for further visualisation or annotation.
- results/combined_amr_summary : AMR gene totals and lists for each sample divided into chromosome or plasmid columns.

# Thanks:

# Further Reading:

# Data used for pipeline testing:
In this project, we benchmarked 31 Salmonella enterica samples which contained integrated plasmids and SGIs contributing to chromosomal resistance.

The full list of these samples including their "CP" accession and run accession are included here.
These genomes were collected from the bioproject "" which is available on ENA and were collected from this paper:

Li, Cong et al. “Long-Read Sequencing Reveals Evolution and Acquisition of Antimicrobial Resistance and Virulence Genes in Salmonella enterica.” Frontiers in microbiology vol. 12 777817. 19 Nov. 2021, doi:10.3389/fmicb.2021.777817
