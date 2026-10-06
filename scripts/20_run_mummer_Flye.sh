#!/usr/bin/env bash

#SBATCH --time=00:30:00
#SBATCH --mem=8G
#SBATCH --cpus-per-task=8
#SBATCH --job-name=Flye_mummerplot
#SBATCH --mail-user=agnieszka.piatkowska@students.unibe.ch
#SBATCH --mail-type=END
#SBATCH --output=/data/users/apiatkowska/assembly_annotation_course/genome_compare/mummerplot/Flye_Pa1/output_mummerplot_Flye_Pa1_%j.o
#SBATCH --error=/data/users/apiatkowska/assembly_annotation_course/genome_compare/mummerplot/Flye_Pa1/error_mummerplot_Flye_Pa1_%j.e
#SBATCH --partition=pshort_el8

# Define directories and container path
WORKDIR="/data/users/apiatkowska/assembly_annotation_course"
OUTDIR="$WORKDIR/genome_compare/mummerplot/Flye_Pa1"
NUCMER_SIF=/containers/apptainer/mummer4_gnuplot.sif

# Create output directories and navigate to output folder
mkdir -p "$OUTDIR"
cd "$OUTDIR"

# Input Flye assembly path
Pa1_Flye_INPUT="$WORKDIR/assemblies/flye/flye_Pa1/assembly.fasta" 

# Nucmer delta file
DELTA="$WORKDIR/genome_compare/nucmer/Flye_Pa1/Flye_Pa1_vs_TAIR10.delta"

# Reference path
REF="/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa"

echo "Starting Mummerplot on Flye for Pa-1..."

# ----------------------------------------------------------------------
#    RUN MUMMERPLOT FOR FLYE WITH REFERENCE 
# ----------------------------------------------------------------------
apptainer exec \
    --bind /data \
    "$NUCMER_SIF" \
    mummerplot \
    -R "$REF" \
    -Q "$Pa1_Flye_INPUT" \
    --filter \
    -t png \
    --large \
    --layout \
    --fat \
    -p Flye_Pa1_vs_TAIR10 \
    "$DELTA"

echo "Mummrplot on Flye for Pa-1 finished."