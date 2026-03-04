#!/bin/bash

PROJECT_NAME="Gut microbiome analysis of mealworm"
SPECIES="Tenebrio molitor"
THREADS=8

# Input data
FASTQ_DIR="raw_fastq"

# Reference files 
REFERENCE_SEQS="reference/silva-138-99-seqs.qza"
CLASSIFIER="reference/silva-138-99-nb-classifier.qza"

# QIIME2 environment
QIIME_ENV="qiime2-2023.5"

# Clustering identity
CLUSTER_IDENTITY=0.85

# Length filtering
MIN_LENGTH=500
MAX_LENGTH=1500
