#!/bin/bash
#SBATCH --job-name=q2_cluster
#SBATCH --output=/home/maluoch/gut_microbiome_mealworm/logs/cluster_%j.out
#SBATCH --error=/home/maluoch/gut_microbiome_mealworm/logs/cluster_%j.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --time=12:00:00
#SBATCH --partition=debug

# ==============================================================================
# SETUP ENVIRONMENT
# ==============================================================================
# Move to the project directory
cd /home/maluoch/gut_microbiome_mealworm

# Load configuration variables
source config.sh

# Initialize Conda and activate the environment using the variable from config.sh
source $(conda info --base)/etc/profile.d/conda.sh
conda activate $ENV_NAME

mkdir -p logs

# ==============================================================================
# RUN CLUSTERING
# ==============================================================================
echo "Starting Open-Reference Clustering: $(date)"
echo "Using QIIME2 version: $(qiime --version)"

# Define Input/Output paths based on variables from config.sh
INPUT_TABLE="results/04.table-nonchimeric.qza"
INPUT_SEQS="results/04.seqs-nonchimeric.qza"

# Check if input files exists
if [ ! -f "$INPUT_TABLE" ]; then
    echo "Error: $INPUT_TABLE not found!"
    exit 1
fi

# Execute Clustering
qiime vsearch cluster-features-open-reference \
  --i-table "$INPUT_TABLE" \
  --i-sequences "$INPUT_SEQS" \
  --i-reference-sequences "$REFERENCE_SEQS" \
  --p-perc-identity $CLUSTER_IDENTITY \
  --p-threads $THREADS \
  --o-clustered-table "results/05.table-clusters.qza" \
  --o-clustered-sequences "results/05.seqs-clusters.qza" \
  --o-new-reference-sequences "results/05.new-ref-seqs.qza"

echo "Clustering Finished: $(date)"
