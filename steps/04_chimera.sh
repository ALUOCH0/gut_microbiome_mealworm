#!/bin/bash

source config.sh

# Initialize Conda
source ~/miniconda3/etc/profile.d/conda.sh
conda activate $QIIME_ENV


echo "Checking reference file: $REFERENCE_SEQS"

if [ ! -f "$REFERENCE_SEQS" ]; then
    echo "ERROR: Reference file not found at $REFERENCE_SEQS"
    echo "Please check if the file exists in your 'reference' folder."
    exit 1
fi

echo "===================================================="
echo "Starting Chimera Detection (UCHIME-ref)"
echo "Input Table: results/03.derep-table.qza"
echo "Reference Database: $REFERENCE_SEQS"
echo "===================================================="

# Runing  the chimera detection

qiime vsearch uchime-ref \
  --i-table results/03.derep-table.qza \
  --i-sequences results/03.derep-seqs.qza \
  --i-reference-sequences "$REFERENCE_SEQS" \
  --output-dir results/04_chimera_results \
  --p-threads $THREADS

#  Filtering  out the chimeras
echo "Filtering out chimeras from table and sequences..."

qiime feature-table filter-features \
  --i-table results/03.derep-table.qza \
  --m-metadata-file results/04_chimera_results/nonchimeras.qza \
  --o-filtered-table results/04.table-nonchimeric.qza

qiime feature-table filter-seqs \
  --i-data results/03.derep-seqs.qza \
  --m-metadata-file results/04_chimera_results/nonchimeras.qza \
  --o-filtered-data results/04.seqs-nonchimeric.qza

if [ $? -eq 0 ]; then
    echo "SUCCESS: Chimera removal complete."
    qiime feature-table summarize \
      --i-table results/04.table-nonchimeric.qza \
      --o-visualization results/04.table-nonchimeric.qzv
else
    echo "ERROR: Chimera step failed."
    exit 1
fi
echo "================== completed successfuly==================="
