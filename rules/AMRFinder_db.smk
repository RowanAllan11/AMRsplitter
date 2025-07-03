# Rule .smk for downloading AMRFinder ncbi db.

rule amrfinder_db:
    output:
        db = "resources/amrfinder_db_downloaded"
    conda:
        "../envs/Main.yaml"
    shell:
        """amrfinder -u
           touch {output.db}"""
    	
        
    
