# Rule .smk for specifying AMRsummary.py inputs and outputs.

rule amr_summary:
    input:
        chr = "results/{sample}/amrfinder/chromosome/{sample}.tsv",
        plas = "results/{sample}/amrfinder/plasmid/{sample}.tsv"
    output:
        combined = "results/{sample}/amr_summary.csv"
    shell:
        """python scripts/AMRsummary.py {input.chr} {input.plas} {output.combined}"""


