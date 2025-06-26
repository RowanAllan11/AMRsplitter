# 🧬 Salmonella Assembly Workflow Notes

## 📅 Date: 2025-05-14

1. Designed short read workflow for initial assembly using tools like trimmomatic and unicycler. (BASE ENV).
2. Tested AMRFinder on hybrid dataset (required prokka installation).
3. Downsampling the short read data set using seqtk to test it on pipeline.
4. Investigating the presence of replicons present on contigs/plasmids visible in the bandage assembly using plamidfinder. Perhaps hybrid assemblies have an advantage over short read assemblies because of their better spatial resolvement?? Need to investigate. Better resolved assemblies can detect whether AMR genes are present on the chromosome or plasmids.

## 📅 Date: 2025-05-15

1. Find a way to quantify the detection of different assemblies for calling SPIs, AMR genes, plasmids and replicons.
2. Keep coding the SR workflow and compare different downsampled assemblies.

## 📅 Date: 2025-05-16

1. Add MLST to workflow potentially (helps identify genotype), however using EnteroBase and pathogen watch may be more helpful and could provide global context. Need to investigate.
2. Okay so my thinking now is that AMR genes have to be one of the most important parts of an assembly. After curating the list of AMR genes from ABRicate, focus on the genes which are most clinically relevant. Different databases like VFDB, CARD, ResFinder give descriptions on the genes.
Next its important to investigate gene context, is it on a chromosome or plasmid? This is where assembly quality could become very important.
Next is alignment with reference alleles to detect variants or mutations, higher accuracy base called assemblies would be advantageous. Certain variants can alter resistance strength (pointfinder)
Now evaluate the epidemiological significance. Compare the isolates AMR profile with publicly available genomes from similar sequences, see if your exact AMR gene variants appear in other clinical, environmental or outbreak strains. Could potentially track it to a known resistant lineage.
(maybe pathogen watch and enterobase could be useful)

## 📅 Date: 2025-05-19

1. Look into using platon for identifying plasmid contigs and compare between assemblies.
2. Also compare which assemblies are better at mapping genes to plasmid contigs.
3. Keep testing assembler, using range of different quality reads

## 📅 Date: 2025-05-20

Recap from yesterday: So platon identifies plasmid contigs like how bandage does, potentially could be useful for workflow. I also pulled the D23580 ref assembly and compared it with my own assembly from high quality D23580 fastq reads. It assembled very well demonstrating that my assembler can handle high quality reads.
Objectives for today:
1. Test assembler with low quality reads. Maybe have a look at a few other tools.
2. Also test long read assembler.
3. Look into statistical testing.

## 📅 Date: 2025-05-21

Recap: Begun filling out an excel sheet documenting all 8 typhimurium strains including their amr gene detection, replicons and assembly stats. Benchmarking against a ST34 reference assembly
Objectives:
1. Begin scripting lR workflow.
2. Test on different quality assemblies.
3. Assemble corresponding long read sequences and document results in the excel sheet to compare.

## 📅 Date: 2025-05-26

Recap: Figured out a workflow to call SNPs of assemblies using a chromosomal only reference
Objectives:
1. Call SNPs from reference reads and compare to assembly results.
2. Depending on results begin scripting SRworkflow to include this SNP calling.

## 📅 Date: 2025-05-29

Currently: Three scripts which all output to one .csv file. SRworkflow which outputs abricate genes and replicon contigs which potentially detects plasmid AMR genes. A plasflow workflow which takes the fasta assembly and splits it up and detects plasmid AMR genes that way. 

## 📅 Date: 2025-05-30

Currently: Started filling up summary .csv files with the downsampled short and long reads and now with the full depth reads.
Objectives:
1. Create the hybrid assembly script
2. Look into implementing a faastqc step
3. Configure scripts for github, look into .yaml files, .yml files or requirements, refactor the scripts

## 📅 Date: 2025-06-03

Currently: Hybrid assembler is almost ready, finish off script and run to fill up csv sheet and use as benchmark against current collected data.
Objectives: 
1. Speak to professor today, describe project and have questions

## 📅 Date: 2025-06-05

Recap: Hybrid assembly is completed, however plasflow in SR assembly is inaccurate.
Objectives:
1. Script SR assembly in snakemake and test new tools like plasmer instead.
2. Need to figure out a way to overlap the csv files to make sure the genes they are detecting are the same.