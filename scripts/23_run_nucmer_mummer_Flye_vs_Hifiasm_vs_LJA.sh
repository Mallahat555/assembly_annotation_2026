#!/usr/bin/env bash

#SBATCH --time=2:00:00
#SBATCH --mem=8G
#SBATCH --cpus-per-task=8
#SBATCH --job-name=mummerplot_Flye_vs_Hifiasm_vs_LJA
#SBATCH --mail-user=agnieszka.piatkowska@students.unibe.ch
#SBATCH --mail-type=END
#SBATCH --output=/data/users/apiatkowska/assembly_annotation_course/genome_compare/mummerplot/Flye_vs_Hifi_vs_LJA_Pa1/output_%j.o
#SBATCH --error=/data/users/apiatkowska/assembly_annotation_course/genome_compare/mummerplot/Flye_vs_Hifi_vs_LJA_Pa1/error_%j.e
#SBATCH --partition=pshort_el8

# Directories and container paths
WORKDIR="/data/users/apiatkowska/assembly_annotation_course"
NUCMER_OUT="$WORKDIR/genome_compare/nucmer/Flye_vs_Hifi_vs_LJA_Pa1"
MUMMERPLOT_OUT="$WORKDIR/genome_compare/mummerplot/Flye_vs_Hifi_vs_LJA_Pa1"
MUMMER_SIF=/containers/apptainer/mummer4_gnuplot.sif

# Create output directories and navigate to output folder
mkdir -p "$NUCMER_OUT"
mkdir -p "$MUMMERPLOT_OUT"
cd "$MUMMERPLOT_OUT" || exit 1

# Assemblies input LJA Hifiasm Flye paths
LJA="$WORKDIR/assemblies/LJA/LJA_Pa1/assembly.fasta"
FLYE="$WORKDIR/assemblies/flye/flye_Pa1/assembly.fasta" 
HIFIASM="$WORKDIR/assemblies/hifiasm/hifiasm_Pa1.bp.p_ctg.fa" 

echo "Starting Nucmer and Mummerplot on LJA vs Flye vs Hifiasm for Pa-1..."

# ============================================================
# 1. Flye vs Hifiasm
#
# Reference / Y-axis = Hifiasm
# Query / X-axis     = Flye
# ============================================================

echo "Running nucmer: Hifiasm vs Flye"

apptainer exec \
    --bind /data \
    "$MUMMER_SIF" \
    nucmer \
    --threads "$SLURM_CPUS_PER_TASK" \
    -p "$NUCMER_OUT/Flye_vs_Hifiasm" \
    "$HIFIASM" \
    "$FLYE"


echo "Running mummerplot: Flye vs Hifiasm"

apptainer exec \
    --bind /data \
    "$MUMMER_SIF" \
    mummerplot \
    -R "$HIFIASM" \
    -Q "$FLYE" \
    --filter \
    -t png \
    --large \
    --layout \
    --fat \
    -p "$MUMMERPLOT_OUT/Flye_vs_Hifiasm" \
    "$NUCMER_OUT/Flye_vs_Hifiasm.delta"

# ============================================================
# 2. Flye vs LJA
#
# Reference / Y-axis = LJA
# Query / X-axis     = Flye
# ============================================================

echo "Running nucmer: LJA vs Flye"

apptainer exec \
    --bind /data \
    "$MUMMER_SIF" \
    nucmer \
    --threads "$SLURM_CPUS_PER_TASK" \
    -p "$NUCMER_OUT/Flye_vs_LJA" \
    "$LJA" \
    "$FLYE"

echo "Running mummerplot: Flye vs LJA"

apptainer exec \
    --bind /data \
    "$MUMMER_SIF" \
    mummerplot \
    -R "$LJA" \
    -Q "$FLYE" \
    --filter \
    -t png \
    --large \
    --layout \
    --fat \
    -p "$MUMMERPLOT_OUT/Flye_vs_LJA" \
    "$NUCMER_OUT/Flye_vs_LJA.delta"

# ============================================================
# 3. Hifiasm vs LJA
#
# Reference / Y-axis = LJA
# Query / X-axis     = Hifiasm
# ============================================================

echo "Running nucmer: LJA vs Hifiasm"

apptainer exec \
    --bind /data \
    "$MUMMER_SIF" \
    nucmer \
    --threads "$SLURM_CPUS_PER_TASK" \
    -p "$NUCMER_OUT/Hifiasm_vs_LJA" \
    "$LJA" \
    "$HIFIASM"

echo "Running mummerplot: Hifiasm vs LJA"

apptainer exec \
    --bind /data \
    "$MUMMER_SIF" \
    mummerplot \
    -R "$LJA" \
    -Q "$HIFIASM" \
    --filter \
    -t png \
    --large \
    --layout \
    --fat \
    -p "$MUMMERPLOT_OUT/Hifiasm_vs_LJA" \
    "$NUCMER_OUT/Hifiasm_vs_LJA.delta"

echo "============================================================"
echo "Finished all three assembly comparisons."
echo "Nucmer delta files:"
echo "$NUCMER_OUT"
echo
echo "Mummerplot files:"
echo "$MUMMERPLOT_OUT"
echo "============================================================"
