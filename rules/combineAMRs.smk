# Rule .smk for running combine_summaries python script which combines all of the AMR summary csvs into a single master csv for downstream metric analysis.

rule combine_amr_summaries:
    input:
        Summaries = expand("results/{sample}/amr_summary.csv", sample=SAMPLES)
    output:
        Output = "results/combined_amr_summary.csv"
    conda:
        "../envs/Main.yaml"
    shell:
        "python scripts/combine_summaries.py {input.Summaries}"

