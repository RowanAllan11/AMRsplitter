rule combine_amr_summaries:
    input:
        Summaries = expand("results/{sample}/amr_summary.csv", sample=SAMPLES)
    output:
        Output = "results/combined_amr_summary.csv"
    shell:
        "python scripts/combine_summaries.py {input.Summaries}"

