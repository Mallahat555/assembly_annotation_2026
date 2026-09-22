#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem=8G
#SBATCH --time=02:00:00
#SBATCH --job-name=fastqc
#SBATCH --mail-user=agnieszka.piatkowska@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/apiatkowska/assembly_annotation_course/read_QC/fastqc/output_fastqc_%j.o
#SBATCH --error=/data/users/apiatkowska/assembly_annotation_course/read_QC/fastqc/error_fastqc_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/apiatkowska/assembly_annotation_course

# Output directories
mkdir -p "$WORKDIR/read_QC/fastqc/Pa-1"
mkdir -p "$WORKDIR/read_QC/fastqc/RNAseq_Sha"

# Run FastQC on Pa-1
apptainer exec \
    --bind /data \
    /containers/apptainer/fastqc-0.12.1.sif \
    fastqc \
    --threads "$SLURM_CPUS_PER_TASK" \
    --outdir "$WORKDIR/read_QC/fastqc/Pa-1" \
    "$WORKDIR/input/Pa-1/"*.fastq.gz 

echo "Starting FastQC for RNAseq_Sha"
    
# Run FastQC on RNAseq_Sha
apptainer exec \
    --bind /data \
    /containers/apptainer/fastqc-0.12.1.sif \
    fastqc \
    --threads "$SLURM_CPUS_PER_TASK" \
    --outdir "$WORKDIR/read_QC/fastqc/RNAseq_Sha" \
    "$WORKDIR/input/RNAseq_Sha/"*.fastq.gz 

echo "FastQC finished"
