#!/usr/bin/env bash

#SBATCH --time=02:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=8
#SBATCH --job-name=flye_Quast_evaluation
#SBATCH --mail-user=agnieszka.piatkowska@students.unibe.ch
#SBATCH --mail-type=END
#SBATCH --output=/data/users/apiatkowska/assembly_annotation_course/assemblies_evaluation/Quast/Quast_flye_Pa1/output_evaluation_Quast_flye_Pa1_%j.o
#SBATCH --error=/data/users/apiatkowska/assembly_annotation_course/assemblies_evaluation/Quast/Quast_flye_Pa1/error_evaluation_Quast_flye_Pa1_%j.e
#SBATCH --partition=pshort_el8

# Define directories and container path
WORKDIR="/data/users/apiatkowska/assembly_annotation_course"
OUT_PREFIX="$WORKDIR/assemblies_evaluation/Quast/Quast_flye_Pa1"
QUAST_SIF="/containers/apptainer/quast_5.2.0.sif"

# Create output directories and navigate to output folder
mkdir -p "$OUT_PREFIX"
cd "$OUT_PREFIX"

# Input flye assembly path
Pa1_flye_INPUT="$WORKDIR/assemblies/flye/flye_Pa1/assembly.fasta" 

# Reference and annotation paths
REF="/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa"
GFF="/data/courses/assembly-annotation-course/references/TAIR10_GFF3_genes.gff"

echo "Starting QUAST evaluation on flye for Pa-1..."

# ----------------------------------------------------------------------
# 1. RUN QUAST WITH REFERENCE AND ANNOTATION
# ----------------------------------------------------------------------
apptainer exec \
    --bind /data \
    "$QUAST_SIF" \
    quast.py \
    "$Pa1_flye_INPUT" \
    -r "$REF" \
    --features "$GFF" \
    --eukaryote \
    --threads "$SLURM_CPUS_PER_TASK" \
    --labels "Flye_Pa1" \
    -o "$OUT_PREFIX/quast_with_reference"

# ----------------------------------------------------------------------
# 2. RUN QUAST WITHOUT REFERENCE (UNASSISTED)
# ----------------------------------------------------------------------
apptainer exec \
    --bind /data \
    "$QUAST_SIF" \
    quast.py \
    "$Pa1_flye_INPUT" \
    --eukaryote \
    --est-ref-size 135000000 \
    --threads "$SLURM_CPUS_PER_TASK" \
    --labels "Flye_Pa1" \
    -o "$OUT_PREFIX/quast_without_reference"

echo "QUAST evaluation on flye for Pa-1 finished."