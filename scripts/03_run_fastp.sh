#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem=8G
#SBATCH --time=02:00:00
#SBATCH --job-name=fastp
#SBATCH --mail-user=agnieszka.piatkowska@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/apiatkowska/assembly_annotation_course/read_QC/fastp/output_fastp_%j.o
#SBATCH --error=/data/users/apiatkowska/assembly_annotation_course/read_QC/fastp/error_fastp_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/apiatkowska/assembly_annotation_course

# Output directories
mkdir -p "$WORKDIR/read_QC/fastp/Pa-1"
mkdir -p "$WORKDIR/read_QC/fastp/RNAseq_Sha"

# input data for Pa-1 PacBIO
INPUT_DATA="$WORKDIR/input/Pa-1/ERR11437314.fastq.gz"
# input data for RNAseq_Sha Illumina
FORWARD="$WORKDIR/input/RNAseq_Sha/ERR754081_1.fastq.gz"
REVERSE="$WORKDIR/input/RNAseq_Sha/ERR754081_2.fastq.gz"

echo "Starting Fastp for Pa-1"

# Run Fastp on Pa-1, NO filtering
apptainer exec \
    --bind /data \
    /containers/apptainer/fastp_0.24.1.sif\
    fastp \
    --thread 4 \
    --in1 "$INPUT_DATA"\
    --out1  "$WORKDIR/read_QC/fastp/Pa-1/ERR11437314.fastq.gz" \
    --disable_quality_filtering \
    --disable_length_filtering \
    --html "$WORKDIR/read_QC/fastp/Pa-1/fastp_Pa-1.html" \
    --json "$WORKDIR/read_QC/fastp/Pa-1/fastp_Pa-1.json"
    
    

echo "Starting Fastp for RNAseq_Sha"
    
# Run Fastp on RNAseq_Sha trimming and filtering
apptainer exec \
    --bind /data \
    /containers/apptainer/fastp_0.24.1.sif \
    fastp \
    --thread 4 \
    --in1 "$FORWARD" \
    --in2 "$REVERSE" \
    --out1 "$WORKDIR/read_QC/fastp/RNAseq_Sha"/ERR754081_1.fastq.gz \
    --out2 "$WORKDIR/read_QC/fastp/RNAseq_Sha"/ERR754081_2.fastq.gz \
    --html "$WORKDIR/read_QC/fastp/RNAseq_Sha/fastp_RNAseq_Sha.html" \
    --json "$WORKDIR/read_QC/fastp/RNAseq_Sha/fastp_RNAseq_Sha.json"
   
echo "Fastp finished"
