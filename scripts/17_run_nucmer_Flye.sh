#!/usr/bin/env bash

#SBATCH --time=00:30:00
#SBATCH --mem=8G
#SBATCH --cpus-per-task=8
#SBATCH --job-name=Flye_nucmer
#SBATCH --mail-user=agnieszka.piatkowska@students.unibe.ch
#SBATCH --mail-type=END
#SBATCH --output=/data/users/apiatkowska/assembly_annotation_course/genome_compare/nucmer/Flye_Pa1/output_evaluation_nucmer_Flye_Pa1_%j.o
#SBATCH --error=/data/users/apiatkowska/assembly_annotation_course/genome_compare/nucmer/Flye_Pa1/error_evaluation_nucmer_Flye_Pa1_%j.e
#SBATCH --partition=pshort_el8

# Define directories and container path
WORKDIR="/data/users/apiatkowska/assembly_annotation_course"
OUTDIR="$WORKDIR/genome_compare/nucmer/Flye_Pa1"
NUCMER_SIF=/containers/apptainer/mummer4_gnuplot.sif

# Create output directories and navigate to output folder
mkdir -p "$OUTDIR"
cd "$OUTDIR"

# Input Flye assembly path
Pa1_Flye_INPUT="$WORKDIR/assemblies/flye/flye_Pa1/assembly.fasta" 

# Reference path
REF="/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa"

echo "Starting Nucmer on Flye for Pa-1..."

# ----------------------------------------------------------------------
#    RUN NUCMER FOR FLYE WITH REFERENCE 
# ----------------------------------------------------------------------
apptainer exec \
    --bind /data \
    "$NUCMER_SIF" \
    nucmer \
    "$REF" \
    "$Pa1_Flye_INPUT" \
    --prefix=Flye_Pa1_vs_TAIR10 \
    --breaklen 1000 \
    --mincluster 1000 

echo "Nucmer evaluation on Flye for Pa-1 finished."