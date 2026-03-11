#!/bin/bash
#SBATCH --job-name=q2_taxonomy
#SBATCH --output=/home/maluoch/gut_microbiome_mealworm/logs/taxonomy_%j.out
#SBATCH --error=/home/maluoch/gut_microbiome_mealworm/logs/taxonomy_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=200G
#SBATCH --partition=debug

# ==============================================================================
# ==============================================================================
# Move to the project directory
cd /home/maluoch/gut_microbiome_mealworm

# Load conda
source /opt/apps/qiime2/conda/etc/profile.d/conda.sh

# Activate QIIME2 environment
conda activate qiime2-2023.5

# Ensure log directory exists
mkdir -p logs

echo "Starting Taxonomy Classification: $(date)"

# Run classifier
qiime feature-classifier classify-sklearn \
  --i-classifier reference/silva-138-99-nb-classifier.qza \
  --i-reads results/05.seqs-clusters.qza \
  --p-n-jobs 8 \
  --o-classification results/06.taxonomy.qza

echo "Classification complete: $(date)"
echo "=========== completed successfully ============="

