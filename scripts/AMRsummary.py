import sys
import pandas as pd
import csv

if __name__ == "__main__":

    # Inputs chromosome and plasmid AMRFinder .tsvs
    amrfinderchr = sys.argv[1]
    amrfinderplas = sys.argv[2]
    summary_output = sys.argv[3]

    # Containers
    chr_amr_genes = []
    plas_amr_genes = []

    # Parse chromosome AMRFinder .tsv
    chr_df = pd.read_csv(amrfinderchr, sep="\t", dtype=str, comment="#")
    for _, row in chr_df.iterrows():
        gene_type = row["Element subtype"]
        gene_name = row["Gene symbol"]
        gene_scope = row["Scope"]
        if gene_type == "AMR" and gene_scope == "core":
            chr_amr_genes.append(gene_name)

    # Parse plasmid AMRFinder .tsv
    plas_df = pd.read_csv(amrfinderplas, sep="\t", dtype=str, comment="#")
    for _, row in plas_df.iterrows():
        gene_type = row["Element subtype"]
        gene_name = row["Gene symbol"]
        gene_scope = row["Scope"]
        if gene_type == "AMR" and gene_scope == "core":
            plas_amr_genes.append(gene_name)

    # Generate summary
    total_chr = len(chr_amr_genes)
    total_plas = len(plas_amr_genes)
    total_amr = total_chr + total_plas
    assembly_id = amrfinderchr.split("/")[-1].split(".")[0]

    # Write summary
    summary_df = pd.DataFrame([{
        "assemblyID": assembly_id,
        "Total_AMR_genes": total_amr,
        "Total_Chr": total_chr,
        "Total_Plas": total_plas,
        "Chr_AMR_genes": " ".join(chr_amr_genes),
        "Plasmid_AMR_genes": " ".join(plas_amr_genes)
    }])

    summary_df.to_csv(summary_output, index=False)
