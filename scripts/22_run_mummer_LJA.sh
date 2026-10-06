#!/usr/bin/env bash

#SBATCH --time=00:30:00
#SBATCH --mem=8G
#SBATCH --cpus-per-task=8
#SBATCH --job-name=LJA_mummerplot
#SBATCH --mail-user=agnieszka.piatkowska@students.unibe.ch
#SBATCH --mail-type=END
#SBATCH --output=/data/users/apiatkowska/assembly_annotation_course/genome_compare/mummerplot/LJA_Pa1/output_mummerplot_LJA_Pa1_%j.o
#SBATCH --error=/data/users/apiatkowska/assembly_annotation_course/genome_compare/mummerplot/LJA_Pa1/error_mummerplot_LJA_Pa1_%j.e
#SBATCH --partition=pshort_el8

# Define directories and container path
WORKDIR="/data/users/apiatkowska/assembly_annotation_course"
OUTDIR="$WORKDIR/genome_compare/mummerplot/LJA_Pa1"
NUCMER_SIF=/containers/apptainer/mummer4_gnuplot.sif

# Create output directories and navigate to output folder
mkdir -p "$OUTDIR"
cd "$OUTDIR"

# Input LJA assembly path
Pa1_LJA_INPUT="$WORKDIR/assemblies/LJA/LJA_Pa1/assembly.fasta"

# Nucmer delta file
DELTA="$WORKDIR/genome_compare/nucmer/LJA_Pa1/LJA_Pa1_vs_TAIR10.delta"

# Reference path
REF="/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa"

echo "Starting Mummerplot on LJA for Pa-1..."

# ----------------------------------------------------------------------
#    RUN MUMMERPLOT FOR LJA WITH REFERENCE 
# ----------------------------------------------------------------------
apptainer exec \
    --bind /data \
    "$NUCMER_SIF" \
    mummerplot \
    -R "$REF" \
    -Q "$Pa1_LJA_INPUT" \
    --filter \
    -t png \
    --large \
    --layout \
    --fat \
    -p LJA_Pa1_vs_TAIR10 \
    "$DELTA"

echo "Mummerplot on LJA for Pa-1 finished."