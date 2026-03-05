#!/bin/bash
#SBATCH --job-name=q2_taxonomy
#SBATCH --output=/home/maluoch/gut_microbiome_mealworm/logs/taxonomy_%j.out
#SBATCH --error=/home/maluoch/gut_microbiome_mealworm/logs/taxonomy_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=120G
#SBATCH --partition=debug

# ==============================================================================
# ==============================================================================
# Move to the project directory
cd /home/maluoch/gut_microbiome_mealworm

# Load configuration variables
source config.sh

# Initialize Conda and activate the environment using the variable from config.sh
source $(conda info --base)/etc/profile.d/conda.sh
conda activate $ENV_NAME

# Ensure log directory exists
mkdir -p logs

echo "Starting Taxonomy Classification: $(date)"

# Run classifier
qiime feature-classifier classify-sklearn \
  --i-classifier reference/silva-138-99-nb-classifier.qza \
  --i-reads results/05.seqs-clusters.qza \
  --p-n-jobs 16 \
  --o-classification results/06.taxonomy.qza

echo "Classification complete: $(date)"
echo "=========== completed successfully ============="

