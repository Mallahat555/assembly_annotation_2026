#!/usr/bin/env bash

#SBATCH --time=00:30:00
#SBATCH --mem=8G
#SBATCH --cpus-per-task=8
#SBATCH --job-name=Hifiasm_mummerplot
#SBATCH --mail-user=agnieszka.piatkowska@students.unibe.ch
#SBATCH --mail-type=END
#SBATCH --output=/data/users/apiatkowska/assembly_annotation_course/genome_compare/mummerplot/Hifiasm_Pa1/output_mummerplot_Hifiasm_Pa1_%j.o
#SBATCH --error=/data/users/apiatkowska/assembly_annotation_course/genome_compare/mummerplot/Hifiasm_Pa1/error_mummerplot_Hifiasm_Pa1_%j.e
#SBATCH --partition=pshort_el8

# Define directories and container path
WORKDIR="/data/users/apiatkowska/assembly_annotation_course"
OUTDIR="$WORKDIR/genome_compare/mummerplot/Hifiasm_Pa1"
NUCMER_SIF=/containers/apptainer/mummer4_gnuplot.sif

# Create output directories and navigate to output folder
mkdir -p "$OUTDIR"
cd "$OUTDIR"

# Input Flye assembly path
Pa1_Hifiasm_INPUT="$WORKDIR/assemblies/hifiasm/hifiasm_Pa1.bp.p_ctg.fa" 

# Nucmer delta file
DELTA="$WORKDIR/genome_compare/nucmer/Hifiasm_Pa1/Hifiasm_Pa1_vs_TAIR10.delta"

# Reference path
REF="/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa"

echo "Starting Mummerplot on Hifiasm for Pa-1..."

# ----------------------------------------------------------------------
#    RUN MUMMERPLOT FOR Hifiasm WITH REFERENCE 
# ----------------------------------------------------------------------
apptainer exec \
    --bind /data \
    "$NUCMER_SIF" \
    mummerplot \
    -R "$REF" \
    -Q "$Pa1_Hifiasm_INPUT" \
    --filter \
    -t png \
    --large \
    --layout \
    --fat \
    -p Hifiasm_Pa1_vs_TAIR10 \
    "$DELTA"

echo "Mummrplot on Hifiasm for Pa-1 finished."