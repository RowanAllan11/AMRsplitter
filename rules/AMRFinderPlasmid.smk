# Rule .smk for calling AMR genes, HMRs and biocide resistance genes from the chromosome assembly.

rule amrfinderplas:
    input:
        PlasFasta = "results/{sample}/gplasCC/combined.fasta"
    output:
        PlasGenes = "results/{sample}/amrfinder/plasmid/{sample}.tsv"
    shell:
        """amrfinder -n {input.PlasFasta} \
               -o {output.PlasGenes} \
               --plus \
               --organism Salmonella"""
    	
        
    
