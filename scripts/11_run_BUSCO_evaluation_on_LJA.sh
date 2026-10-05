#!/usr/bin/env bash

#SBATCH --time=00:20:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=8
#SBATCH --job-name=LJA_evaluation
#SBATCH --mail-user=agnieszka.piatkowska@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/apiatkowska/assembly_annotation_course/assemblies_evaluation/LJA_Pa1/output_evaluation_LJA_Pa1_%j.o
#SBATCH --error=/data/users/apiatkowska/assembly_annotation_course/assemblies_evaluation/LJA_Pa1/error_evaluation_LJA_Pa1_%j.e
#SBATCH --partition=pshort_el8

WORKDIR=/data/users/apiatkowska/assembly_annotation_course
OUT_PREFIX="$WORKDIR/assemblies_evaluation/LJA_Pa1"

# Create directories
mkdir -p "$OUT_PREFIX"
mkdir -p "$OUT_PREFIX/BUSCO_downloads"

cd "$OUT_PREFIX"

# Input directory for LJA Pa-1 assembly
Pa1_LJA_INPUT="$WORKDIR/assemblies/LJA/LJA_Pa1/assembly.fasta" 

# Download path for Busco
DOWNLOAD="$OUT_PREFIX/BUSCO_downloads"

echo "Starting LJA assembly evaluation for Pa-1"

# Run assembly evaluation for LJA on Pa-1  
apptainer exec \
    --bind /data \
    /containers/apptainer/busco_5.7.1.sif \
    busco \
    -i "$Pa1_LJA_INPUT" \
    -o "Busco_LJA_Pa-1" \
    --out_path "$OUT_PREFIX" \
    --lineage brassicales_odb10 \
    --mode genome \
    --cpu "$SLURM_CPUS_PER_TASK"\
    --download_path "$DOWNLOAD"
    
echo "LJA assembly evaluation for Pa-1 finished"











