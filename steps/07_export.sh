#!/bin/bash
#SBATCH --job-name=q2_export
#SBATCH --output=/home/maluoch/gut_microbiome_mealworm/logs/export_%j.out
#SBATCH --error=/home/maluoch/gut_microbiome_mealworm/logs/export_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=32G
#SBATCH --partition=debug

# ==============================================================================
# Move to project directory
# ==============================================================================

cd /home/maluoch/gut_microbiome_mealworm

# Load conda
source /opt/apps/qiime2/conda/etc/profile.d/conda.sh

# Activate QIIME2 environment
conda activate qiime2-2023.5

cd /home/maluoch/gut_microbiome_mealworm/results    #directory where the input files are located
mkdir -p logs
mkdir -p exported

echo "Starting EXPORT step"
echo "====================================="

# ==============================================================================
# Export Feature Table
# ==============================================================================

echo "Exporting feature table..."

qiime tools export \
  --input-path 05.table-clusters.qza \
  --output-path exported

echo "Converting BIOM table to TSV..."           #converts BIOM to tsv 

biom convert \
-i exported/feature-table.biom \
-o exported/feature-table.tsv \
--to-tsv


# ==============================================================================
# Export Representative Sequences
# ==============================================================================

echo "Exporting representative sequences..."

qiime tools export \
  --input-path 05.seqs-clusters.qza \
  --output-path exported

# ==============================================================================
# Export Taxonomy
# ==============================================================================

echo "Exporting taxonomy..."

qiime tools export \
  --input-path 06.taxonomy.qza \
  --output-path exported

echo  "=========================Export completed successfully======================"

