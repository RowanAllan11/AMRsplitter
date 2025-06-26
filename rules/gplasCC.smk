# Rule .smk for gplasCC. Involves launching the gplasCC conda environment and running the program which can output multiple .fasta files.

rule gplasCC:
    input:
        GFA = "results/{sample}/unicycler/assembly.gfa"
    output:
        PlasFasta = "results/{sample}/gplasCC/combined.fasta"
    conda:
        "../envs/gplasCC.yaml"
        
# There is no output directory option for gplasCC, therefore the directory must be created and entered 

    shell:
        """mkdir -p results/{wildcards.sample}/gplasCC &&
            cd results/{wildcards.sample}/gplasCC &&
            gplas -i ../../../{input.GFA} -s Salmonella_enterica -n {wildcards.sample} &&
            cat results/{wildcards.sample}_bin_*.fasta > combined.fasta || touch combined.fasta"""
        
# Cat combines all the individual plasmid bins into a single fasta file
