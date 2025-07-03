# Rule .smk for calling AMR genes, HMRs and biocide resistance genes from the chromosome assembly.

rule amrfinderchr:
    input:
        ChromFasta = "results/{sample}/gplasCC/chrom.fasta",
        db = "resources/amrfinder_db_downloaded"
    output:
        ResGenes = "results/{sample}/amrfinder/chromosome/{sample}.tsv"
    conda:
        "../envs/Main.yaml"
    shell:
        """amrfinder -n {input.ChromFasta} \
               -o {output.ResGenes} \
               --plus \
               --organism Salmonella"""
    	
        
    
