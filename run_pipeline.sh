#!/bin/bash
set -e #Exit immediately if a command  exists with a non  zero status 

set -o pipefail  #failure in the pipeline returns the error code of the failed command 

source config.sh   #Load environment variables and paths

mkdir -p logs results

echo "===================================================="
echo "Starting Pipeline: $PROJECT_NAME"
echo "Target Species:    $SPECIES"
echo "Timestamp:         $(date)"
echo "===================================================="

# Execute the 8-step pipeline
bash 01_qc.sh         2>&1 | tee logs/01_qc.log
bash 02_import.sh     2>&1 | tee logs/02_import.log
bash 03_derep.sh      2>&1 | tee logs/03_derep.log
bash 04_chimera.sh    2>&1 | tee logs/04_chimera.log
bash 05_cluster.sh    2>&1 | tee logs/05_cluster.log
bash 06_phylogeny.sh  2>&1 | tee logs/06_phylogeny.log
bash 07_taxonomy.sh   2>&1 | tee logs/07_taxonomy.log
bash 08_export.sh     2>&1 | tee logs/08_export.log

echo "===================================================="
echo "Pipeline completed successfully at $(date)"
echo "===================================================="
