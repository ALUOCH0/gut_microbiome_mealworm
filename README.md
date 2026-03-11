
#Project Name: Gut microbiome analysis of mealworm( ONT sequenecs ) 

This project analyses the gut microbiome of Tenebrio molitor (mealworm) across their developmental lifecycle using Oxford Nanopore Technology 16S sequencing data. The workflow has been implemented using the QIIME2 ONT compatible pipeline (q2ONT) to process long reads sequences ,quality control , cluster sequences and assign taxonomy using the SILVA 138 reference databases. The pipeine aims to generate microbial community profiles that enables comparison of microbiome composition across different mealworm developmental stages.
         
# Requirements
 conda(miniconda 26.1.1)
 q2cli version 2023.5.1
 Trimomantic version 0.40
 Porechop version 0.24
 Nanoplot  
 SILVA 138 reference database 

# Workflow

1. **01_qc.sh** – Perform quality control on raw FASTQ files.
2. **02_import.sh** – Import sequences into QIIME2 artifacts.
3. **03_derep.sh** – Dereplicate sequences.
4. **04_chimera.sh** – Detect and remove chimeric sequences.
5. **05_cluster.sh** – Cluster sequences into representative OTUs/ASVs.
6. **06_taxonomy.sh** – Classify sequences using the SILVA 138 database.
7. **07_export.sh** – Export results for downstream analysis.
