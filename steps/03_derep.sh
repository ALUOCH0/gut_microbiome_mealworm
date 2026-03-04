#!/bin/bash
source config.sh

# Initialize Conda for the script
source ~/miniconda3/etc/profile.d/conda.sh
conda activate $QIIME_ENV

echo "===================================================="
echo "Starting VSEARCH Dereplication"
echo "Input: results/02.import.qza"
echo "===================================================="

# dereplicate-sequences collapses 100% identical reads
qiime vsearch dereplicate-sequences \
  --i-sequences results/02.import.qza \
  --o-dereplicated-table results/03.derep-table.qza \
  --o-dereplicated-sequences results/03.derep-seqs.qza

if [ $? -eq 0 ]; then
    echo "----------------------------------------------------"
    echo "SUCCESS: Dereplication complete."
    echo "Generating visualization summaries..."
    
    # Generate a summary of the feature table (counts per sample)
    qiime feature-table summarize \
      --i-table results/03.derep-table.qza \
      --o-visualization results/03.derep-table.qzv
      
    # Generate a summary of the sequences (lengths and stats)
    qiime feature-table tabulate-seqs \
      --i-data results/03.derep-seqs.qza \
      --o-visualization results/03.derep-seqs.qzv
else
    echo "ERROR: Dereplication failed."
    exit 1
fi

echo "============ Completed  succesfully=========="
