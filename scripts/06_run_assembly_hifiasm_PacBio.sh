#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=assembly_hifiasm
#SBATCH --mail-user=agnieszka.piatkowska@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/apiatkowska/assembly_annotation_course/assemblies/hifiasm/output_assembly_hifiasm_%j.o
#SBATCH --error=/data/users/apiatkowska/assembly_annotation_course/assemblies/hifiasm/error_assembly_hifiasm_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/apiatkowska/assembly_annotation_course

# Create directory
mkdir -p "$WORKDIR/assemblies/hifiasm/hifiasm_Pa1"

# Input directory for hifiasm Pa-1
Pa1_INPUT="$WORKDIR/input/Pa-1/ERR11437314.fastq.gz"

# Output directory for hifiasm Pa-1
Pa1_OUTPUT="$WORKDIR/assemblies/hifiasm/hifiasm_Pa1"

echo "Starting hifiasm assembly for Pa-1"

# Assembly hifiasm Pa-1
apptainer exec \
    --bind /data \
    /containers/apptainer/hifiasm_0.25.0.sif \
    hifiasm \
    -o "$Pa1_OUTPUT" \
    -t 16 \
    "$Pa1_INPUT"

echo "Hifiasm assembly for Pa-1 finished"

