#!/bin/bash
# ==============================================================================
# PROJECT CONFIGURATION
# ==============================================================================

# Project  directory 
PROJECT_DIR="/home/maluoch/gut_microbiome_mealworm"

# Folder paths
FASTQ_DIR="$PROJECT_DIR/raw_fastq"
RESULTS_DIR="$PROJECT_DIR/results"
STEPS_DIR="$PROJECT_DIR/steps"
LOGS_DIR="$PROJECT_DIR/logs"

# Reference files 
REFERENCE_SEQS="$PROJECT_DIR/reference/silva-138-99-seqs.qza"
CLASSIFIER="$PROJECT_DIR/reference/silva-138-99-nb-classifier.qza"

# ==============================================================================
# COMPUTATIONAL RESOURCES & PARAMETERS
# ==============================================================================

# Clustering percentage identity
CLUSTER_IDENTITY=0.85

# ==============================================================================
# QIIME 2 ENVIRONMENT
# ==============================================================================
# Path to your Conda installation
CONDA_INSTALL_PATH="$HOME/anaconda3"
ENV_NAME="qiime2-2023.5"

#threads 
THREADS=1


# ==============================================================================

# Length filtering
MIN_LENGTH=500
MAX_LENGTH=1500
