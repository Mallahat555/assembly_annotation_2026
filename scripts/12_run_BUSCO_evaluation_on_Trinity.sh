#!/usr/bin/env bash

#SBATCH --time=2:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=8
#SBATCH --job-name=trinity_evaluation
#SBATCH --mail-user=agnieszka.piatkowska@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/apiatkowska/assembly_annotation_course/assemblies_evaluation/trinity_Pa1/output_evaluation_trinity_Pa1_%j.o
#SBATCH --error=/data/users/apiatkowska/assembly_annotation_course/assemblies_evaluation/trinity_Pa1/error_evaluation_trinity_Pa1_%j.e
#SBATCH --partition=pshort_el8

WORKDIR=/data/users/apiatkowska/assembly_annotation_course
OUT_PREFIX="$WORKDIR/assemblies_evaluation/trinity_Pa1"

# Create directories
mkdir -p "$OUT_PREFIX"
mkdir -p "$OUT_PREFIX/BUSCO_downloads"

cd "$OUT_PREFIX"

# Input directory for trinity Pa-1 assembly
Pa1_trinity_INPUT="$WORKDIR/assemblies/trinity/trinity_RNAseq_Sha.Trinity.fasta" 

# Download path for Busco
DOWNLOAD="$OUT_PREFIX/BUSCO_downloads"

echo "Starting trinity assembly evaluation for Pa-1"

# Run assembly evaluation for trinity on Pa-1  
apptainer exec \
    --bind /data \
    /containers/apptainer/busco_5.7.1.sif \
    busco \
    -i "$Pa1_trinity_INPUT" \
    -o "Busco_trinity_Pa-1" \
    --out_path "$OUT_PREFIX" \
    --lineage brassicales_odb10 \
    --mode transcriptome \
    --cpu "$SLURM_CPUS_PER_TASK"\
    --download_path "$DOWNLOAD"
    
echo "Trinity assembly evaluation for Pa-1 finished"











