# This rule involves quality checking, trimming and assembling the listed samples.

rule fastqc:
    input:
        Forward = "data/{sample}_1.fastq.gz",
        Reverse = "data/{sample}_2.fastq.gz"
    output:
        ForwardQC = "results/{sample}/fastqc/{sample}_1_fastqc.html",
        ReverseQC = "results/{sample}/fastqc/{sample}_2_fastqc.html"
    conda:
        "../envs/Main.yaml"
    shell:
        """fastqc {input.Forward} {input.Reverse} \
            --outdir results/{wildcards.sample}/fastqc"""

# Parameters for trimmomatic are specified in config.yaml. Unpaired reads are also removed.

rule trimmomatic:
    input:
        Forward = "data/{sample}_1.fastq.gz",
        Reverse = "data/{sample}_2.fastq.gz"
    output:
        Forward_paired = temp("results/{sample}/trimmomatic/{sample}_1P.fastq.gz"),
        Forward_unpaired = temp("results/{sample}/trimmomatic/{sample}_1U.fastq.gz"),
        Reverse_paired = temp("results/{sample}/trimmomatic/{sample}_2P.fastq.gz"),
        Reverse_unpaired = temp("results/{sample}/trimmomatic/{sample}_2U.fastq.gz")
    params:
        adapters= config["params"]["trimmomatic"]["adapters"],
        options= config["params"]["trimmomatic"]["options"]
    conda:
        "../envs/Main.yaml"
    shell:
        """trimmomatic PE -threads {threads} \
            {input.Forward} {input.Reverse} \
            {output.Forward_paired} {output.Forward_unpaired} \
            {output.Reverse_paired} {output.Reverse_unpaired} \
            {params.options}"""

# Unicycler in short read assembly mode.
            
rule unicycler:
    input:
        Forward_Paired = "results/{sample}/trimmomatic/{sample}_1P.fastq.gz",
        Reverse_Paired = "results/{sample}/trimmomatic/{sample}_2P.fastq.gz"
    output:
        Fasta = "results/{sample}/unicycler/assembly.fasta",
        GFA = "results/{sample}/unicycler/assembly.gfa"
    params:
        threads = config["params"]["unicycler"]["threads"]
    threads: config["params"]["unicycler"]["threads"]
    conda:
        "../envs/Main.yaml"
    shell:
        """unicycler -1 {input.Forward_Paired} \
                  -2 {input.Reverse_Paired} \
                  -o results/{wildcards.sample}/unicycler \
                  --threads {params.threads}"""


