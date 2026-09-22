#!/bin/bash

#SBATCH --time=00:05:00
#SBATCH --mem=1G
#SBATCH --cpus-per-task=1
#SBATCH --job-name=generate_soft_links
#SBATCH --partition=pibu_el8
#SBATCH --output=../input/generate_soft_links_%j.out
#SBATCH --error=../input/generate_soft_links_%j.e

#Create input directory and don't complain if it aready exists
mkdir -p ../input

# put soft links to ../input directory
# Whole genome PacBio HiFi reads for accession for user apiatkowska is Pa-1
ln -s /data/courses/assembly-annotation-course/raw_data/Pa-1 ../input/
# Whole transcriptome Illumina RNAseq for accession RNAseq_Sha for all users
ln -s /data/courses/assembly-annotation-course/raw_data/RNAseq_Sha ../input


