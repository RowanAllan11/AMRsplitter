# Rule .smk for calling AMR genes, HMRs and biocide resistance genes from the chromosome assembly.

rule amrfinderplas:
    input:
        PlasFasta = "results/{sample}/gplasCC/combined.fasta",
        db = "resources/amrfinder_db_downloaded"
    output:
        PlasGenes = "results/{sample}/amrfinder/plasmid/{sample}.tsv"
    conda:
        "../envs/Main.yaml"
    shell:
        """amrfinder -n {input.PlasFasta} \
               -o {output.PlasGenes} \
               --plus \
               --organism Salmonella"""
    	
        
    
