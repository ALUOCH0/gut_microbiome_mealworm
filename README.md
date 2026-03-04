
##Project Name: Gut microbiome analysis of mealworm( ONT sequences)
 
##project overview 
This project analyses the gut microbiome of mealworms across their lifecycle using Oxford Nanopore Technologies (ONT) sequencing using the #q2ONT pipeline .
 
##The project structure 
gut_microbiome_mealworm/              #the parent project folder 
│
├── config.sh
├── raw_fastq/                 # Raw Nanopore FASTQ files (82 barcodes)
├── reference/                 # SILVA reference database
│   ├── silva-138-99-seqs.qza
│   └── silva-138-99-nb-classifier.qza
├── steps/                     # Pipeline scripts
│   ├── 01_qc.sh
│   ├── 02_import.sh
│   ├── 03_derep.sh
│   ├── 04_chimera.sh
│   ├── 05_cluster.sh
│   ├── 06_taxonomy.sh
│   └── 07_export.sh
│
├── results/                   # Generated outputs
├── logs/                      # SLURM job logs (.out / .err)
│
└── Readme.md     #documentation of the workflow 
         
## Requirements
 conda(miniconda 26.1.1)
 q2cli version 2023.5.1
 Trimomantic version 0.40
 Porechop version 0.24
 Nanoplot  
 SILVA 138 reference database 

## Workflow

1. **01_qc.sh** – Perform quality control on raw FASTQ files.
2. **02_import.sh** – Import sequences into QIIME2 artifacts.
3. **03_derep.sh** – Dereplicate sequences.
4. **04_chimera.sh** – Detect and remove chimeric sequences.
5. **05_cluster.sh** – Cluster sequences into representative OTUs/ASVs.
6. **06_taxonomy.sh** – Classify sequences using the SILVA 138 database.
7. **07_export.sh** – Export results for downstream analysis.
