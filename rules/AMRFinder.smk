# Rule .smk for calling AMR genes, HMRs and biocide resistance genes from the chromosome assembly.

rule amrfinderchr:
    input:
        ChromFasta = "results/{sample}/gplasCC/chrom.fasta"
    output:
        ResGenes = "results/{sample}/amrfinder/chromosome/{sample}.tsv"
    shell:
        """amrfinder -n {input.ChromFasta} \
               -o {output.ResGenes} \
               --plus \
               --organism Salmonella"""
    	
        
    
