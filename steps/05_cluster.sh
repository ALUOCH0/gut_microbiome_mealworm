#!/bin/bash

# Load configuration
source config.sh

# Conda activation for scripts
source $(conda info --base)/etc/profile.d/conda.sh
conda activate $QIIME_ENV

echo "============================================"
echo "Starting Step Open-Reference Clustering"
echo "============================================"

# Validation file names  
if [ ! -f "results/04.table-nonchimeric.qza" ]; then
    echo "Error: Input file 'results/04.table-nonchimeric.qza' not found!"
    exit 1
fi

# Run Clustering
echo " Running the clusters......"
qiime vsearch cluster-features-open-reference \
  --i-table results/04.table-nonchimeric.qza \
  --i-sequences results/04.seqs-nonchimeric.qza \
  --i-reference-sequences $REFERENCE_SEQS \
  --p-perc-identity $CLUSTER_IDENTITY \
  --p-threads $THREADS \
  --o-clustered-table results/05.table-clusters.qza \
  --o-clustered-sequences results/05.seqs-clusters.qza \
  --o-new-reference-sequences results/05.new-ref-seqs.qza

echo "==============Completed successfully================"
