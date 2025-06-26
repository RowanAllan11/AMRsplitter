# About:
I built this snakemake pipeline to benchmark the plasmid contig predictor tool GplasCC and assess its AMR gene localisation capabilities on short read data.

The steps are:
- Quality checks the reads using "fastQC".
- Trims reads for adapters and low quality base pairs using "trimmomatic".
- Assembles the reads using "unicycler".
- Bins plasmid-predicted contigs using "gplasCC" which are removed from the unicycler assembly "fasta" file to create a chromosome only "fasta" file.
- AMR genes are called on both the chromosome and plasmid "fasta" files using "AMRFinderPlus".
- AMR gene totals and lists are collected in an overall summary "csv" file for each read.

# Example Folder
https://github.com/RowanAllan11/Plasmid_Segregator/blob/main/example_folder.txt

## Relevant folders for output:

- results/{sample}/gplasCC/chrom.fasta : chromosome FASTA file for further visualisation or annotation.
- results/{sample}/gplasCC/combined.fasta : combined plasmid FASTA for further visualisation or annotation.
- results/combined_amr_summary : AMR gene totals and lists for each sample divided into chromosome or plasmid columns.

# Thanks:

# Further Reading:

# Data used for pipeline testing:
Li, Cong et al. “Long-Read Sequencing Reveals Evolution and Acquisition of Antimicrobial Resistance and Virulence Genes in Salmonella enterica.” Frontiers in microbiology vol. 12 777817. 19 Nov. 2021, doi:10.3389/fmicb.2021.777817
