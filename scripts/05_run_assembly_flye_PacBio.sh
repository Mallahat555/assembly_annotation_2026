#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=assembly_flye
#SBATCH --mail-user=agnieszka.piatkowska@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/apiatkowska/assembly_annotation_course/assemblies/flye/output_assembly_flye_%j.o
#SBATCH --error=/data/users/apiatkowska/assembly_annotation_course/assemblies/flye/error_assembly_flye_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/apiatkowska/assembly_annotation_course

# Create directory
mkdir -p "$WORKDIR/assemblies/flye/flye_Pa1"

# Input directory for flye Pa-1
Pa1_INPUT="$WORKDIR/input/Pa-1/ERR11437314.fastq.gz"

# Output directory for flye Pa-1
Pa1_OUTPUT="$WORKDIR/assemblies/flye/flye_Pa1"

echo "Starting flye assembly for Pa-1"

# Run flye on Pa-1  
apptainer exec \
    --bind /data \
    /containers/apptainer/flye_2.9.5.sif  \
    flye \
    --pacbio-hifi "$Pa1_INPUT" \
    --out-dir "$Pa1_OUTPUT" \
    --threads  16 


echo "flye assembly for Pa-1 finished"

