#!/bin/bash
source config.sh

# Initialize Conda for the script
source ~/home/aluoc/miniconda3/condabin/conda
conda activate $QIIME_ENV

INPUT_DIR="results/01_QC"

echo "===================================================="
echo "Preparing files for QIIME 2 Casava Import..."
echo "===================================================="

#  Compress files to .gz 
if ls $INPUT_DIR/*.fastq >/dev/null 2>&1; then
    echo "Compressing .fastq files to .fastq.gz..."
    gzip $INPUT_DIR/*.fastq
fi

# Renaming the files to match strict Casava format
# Pattern: SampleName_S1_L001_R1_001.fastq.gz
echo "Renaming files to Casava format..."
for file in $INPUT_DIR/*.fastq.gz; do
    
    path=$(dirname "$file")
    filename=$(basename "$file")
    
    # Extract the barcode ID
    sample_id=$(echo "$filename" | cut -d'_' -f1)
    
    new_name="${sample_id}_S1_L001_R1_001.fastq.gz"
    
    if [ "$filename" != "$new_name" ]; then
        mv "$file" "$path/$new_name"
        echo "Renamed: $filename -> $new_name"
    fi
done

echo "----------------------------------------------------"
echo "Starting QIIME 2 Import..."

qiime tools import \
  --type 'SampleData[SequencesWithQuality]' \
  --input-path $INPUT_DIR \
  --input-format CasavaOneEightSingleLanePerSampleDirFmt \
  --output-path results/02.import.qza

if [ $? -eq 0 ]; then
    echo "SUCCESS: Data imported to results/02.import.qza"
else
    echo "ERROR: Import failed."
    exit 1
fi

echo "Generating quality summary visualization..."
qiime demux summarize \
  --i-data results/02.import.qza \
  --o-visualization results/02.import.qzv

echo "======== Completed successfuly=========="
