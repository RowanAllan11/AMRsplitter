# Rule .smk for removing plasmid contigs from overall assembly to generate chromosome only fasta.

rule chromosome_fasta:
    input:
        Fasta = "results/{sample}/unicycler/assembly.fasta",
        PlasFasta = "results/{sample}/gplasCC/combined.fasta"
    output:
        ContigIDs = temp("results/{sample}/gplasCC/plasmid_ids.txt"),
        ChromFasta = "results/{sample}/gplasCC/chrom.fasta"
    shell:
        """ if [ ! -s {input.PlasFasta} ]; then
                echo "No plasmid bins found for {wildcards.sample}"
                cp {input.Fasta} {output.ChromFasta}
                touch {output.ContigIDs}
            else
                grep "^>" {input.PlasFasta} | sed -E 's/>S([0-9]+).*/\\1/' > {output.ContigIDs} &&
                seqkit grep -v -f {output.ContigIDs} {input.Fasta} > {output.ChromFasta}
            fi"""

    	
        
    
