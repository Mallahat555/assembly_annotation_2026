#!/usr/bin/env bash

#SBATCH --time=00:30:00
#SBATCH --mem=8G
#SBATCH --cpus-per-task=8
#SBATCH --job-name=Hifiasm_nucmer
#SBATCH --mail-user=agnieszka.piatkowska@students.unibe.ch
#SBATCH --mail-type=END
#SBATCH --output=/data/users/apiatkowska/assembly_annotation_course/genome_compare/nucmer/Hifiasm_Pa1/output_evaluation_nucmer_Hifiasm_Pa1_%j.o
#SBATCH --error=/data/users/apiatkowska/assembly_annotation_course/genome_compare/nucmer/Hifiasm_Pa1/error_evaluation_nucmer_Hifiasm_Pa1_%j.e
#SBATCH --partition=pshort_el8

# Define directories and container path
WORKDIR="/data/users/apiatkowska/assembly_annotation_course"
OUTDIR="$WORKDIR/genome_compare/nucmer/Hifiasm_Pa1"
NUCMER_SIF=/containers/apptainer/mummer4_gnuplot.sif

# Create output directories and navigate to output folder
mkdir -p "$OUTDIR"
cd "$OUTDIR"

# Input Hifiasm assembly path
Pa1_Hifiasm_INPUT="$WORKDIR/assemblies/hifiasm/hifiasm_Pa1.bp.p_ctg.fa" 

# Reference path
REF="/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa"

echo "Starting Nucmer on Hifiasm for Pa-1..."

# ----------------------------------------------------------------------
#    RUN NUCMER FOR HIFIASM WITH REFERENCE 
# ----------------------------------------------------------------------
apptainer exec \
    --bind /data \
    "$NUCMER_SIF" \
    nucmer \
    "$REF" \
    "$Pa1_Hifiasm_INPUT" \
    --prefix=Hifiasm_Pa1_vs_TAIR10 \
    --breaklen 1000 \
    --mincluster 1000 

echo "Nucmer evaluation on Hifiasm for Pa-1 finished."