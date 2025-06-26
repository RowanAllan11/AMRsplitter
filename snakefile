configfile: "config.yaml"

SAMPLES = config["samples"]

include: "rules/main.smk"
include: "rules/gplasCC.smk"
include: "rules/ChromFasta.smk"
include: "rules/AMRFinder.smk"
include: "rules/AMRFinderPlasmid.smk"
include: "rules/AMRsummariser.smk"
include: "rules/combineAMRs.smk"

rule all:
    input:
        expand("results/{sample}/fastqc/{sample}_1_fastqc.html", sample=SAMPLES),
        expand("results/{sample}/unicycler/assembly.fasta", sample=SAMPLES),
        expand("results/{sample}/gplasCC/chrom.fasta", sample=SAMPLES),
        expand("results/{sample}/amrfinder/chromosome/{sample}.tsv", sample=SAMPLES),
        expand("results/{sample}/amrfinder/plasmid/{sample}.tsv", sample=SAMPLES),
        expand("results/{sample}/amr_summary.csv", sample=SAMPLES),
        expand("results/combined_amr_summary.csv")
        



