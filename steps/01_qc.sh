#!/bin/bash

# Trims reads using Trimmomatic and stores QC outputs

source config.sh

# Create QC output directories
mkdir -p results/01_QC
mkdir -p results/01_QC/fastqc_post_trim
mkdir -p results/summary_QC

# Move to the folder containing raw FASTQ files
cd raw_fastq || { echo "Directory not found: raw_fastq"; exit 1; }

# Loop through each FASTQ file and perform trimming
for file in *.fastq.gz; do
    echo "Trimming $file ..."
    trimmomatic SE -threads "$THREADS" -phred33 \
        "$file" \
        "../results/01_QC/${file%.fastq.gz}_trimmed.fastq" \
        MINLEN:"$MIN_LENGTH" CROP:"$MAX_LENGTH"
done

# Run NanoPlot on trimmed files
echo "======================================================"
echo "Running NanoPlot on trimmed reads ..."
echo "===================================================="

~/.conda/envs/qiime2-2023.5/bin/NanoPlot -t "$THREADS" \
         -o ../results/01_QC/nanoplot_post_trim \
         --fastq ../results/01_QC/*_trimmed.fastq

echo "QC and trimming completed. Check results/01_QC/nanoplot_post_trim for NanoPlot Report"

