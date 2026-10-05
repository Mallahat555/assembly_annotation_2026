#!/usr/bin/env bash

#SBATCH --time=02:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=8
#SBATCH --job-name=hifiasm_Quast_evaluation
#SBATCH --mail-user=agnieszka.piatkowska@students.unibe.ch
#SBATCH --mail-type=END
#SBATCH --output=/data/users/apiatkowska/assembly_annotation_course/assemblies_evaluation/Quast/Quast_hifiasm_Pa1/output_evaluation_Quast_hifiasm_Pa1_%j.o
#SBATCH --error=/data/users/apiatkowska/assembly_annotation_course/assemblies_evaluation/Quast/Quast_hifiasm_Pa1/error_evaluation_Quast_hifiasm_Pa1_%j.e
#SBATCH --partition=pshort_el8

# Define directories and container path
WORKDIR="/data/users/apiatkowska/assembly_annotation_course"
OUT_PREFIX="$WORKDIR/assemblies_evaluation/Quast/Quast_hifiasm_Pa1"
QUAST_SIF="/containers/apptainer/quast_5.2.0.sif"

# Create output directories and navigate to output folder
mkdir -p "$OUT_PREFIX"
cd "$OUT_PREFIX"

# Input hifiasm assembly path
Pa1_hifiasm_INPUT="$WORKDIR/assemblies/hifiasm/hifiasm_Pa1.bp.p_ctg.fa" 

# Reference and annotation paths
REF="/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa"
GFF="/data/courses/assembly-annotation-course/references/TAIR10_GFF3_genes.gff"

echo "Starting QUAST evaluation on hifiasm for Pa-1..."

# ----------------------------------------------------------------------
# 1. RUN HIFIASM WITH REFERENCE AND ANNOTATION
# ----------------------------------------------------------------------
apptainer exec \
    --bind /data \
    "$QUAST_SIF" \
    quast.py \
    "$Pa1_hifiasm_INPUT" \
    -r "$REF" \
    --features "$GFF" \
    --eukaryote \
    --threads "$SLURM_CPUS_PER_TASK" \
    --labels "Hifiasm_Pa1" \
    -o "$OUT_PREFIX/quast_with_reference"

# ----------------------------------------------------------------------
# 2. RUN HIFIASM WITHOUT REFERENCE (UNASSISTED)
# ----------------------------------------------------------------------
apptainer exec \
    --bind /data \
    "$QUAST_SIF" \
    quast.py \
    "$Pa1_hifiasm_INPUT" \
    --eukaryote \
    --est-ref-size 135000000 \
    --threads "$SLURM_CPUS_PER_TASK" \
    --labels "Hifiasm_Pa1" \
    -o "$OUT_PREFIX/quast_without_reference"

echo "QUAST evaluation on hifiasm for Pa-1 finished."