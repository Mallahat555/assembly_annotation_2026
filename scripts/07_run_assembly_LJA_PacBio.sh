#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=assembly_LJA
#SBATCH --mail-user=agnieszka.piatkowska@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/apiatkowska/assembly_annotation_course/assemblies/LJA/output_assembly_LJA_%j.o
#SBATCH --error=/data/users/apiatkowska/assembly_annotation_course/assemblies/LJA/error_assembly_LJA_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/apiatkowska/assembly_annotation_course

# Create directory
mkdir -p "$WORKDIR/assemblies/LJA/LJA_Pa1"

# Input directory for LJA Pa-1
Pa1_INPUT="$WORKDIR/input/Pa-1/ERR11437314.fastq.gz"

# Output directory for LJA Pa-1
Pa1_OUTPUT="$WORKDIR/assemblies/LJA/LJA_Pa1"

echo "Starting LJA assembly for Pa-1"

# Assembly LJA Pa-1
apptainer exec \
    --bind /data \
    /containers/apptainer/lja-0.2.sif \
    lja \
    --reads "$Pa1_INPUT" \
    -o "$Pa1_OUTPUT" \
    -t 16 \
    --diploid 

echo "LJA assembly for Pa-1 finished"

