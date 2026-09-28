#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=assembly_transcriptome_trinity
#SBATCH --mail-user=agnieszka.piatkowska@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/apiatkowska/assembly_annotation_course/assemblies/trinity/output_assembly_trinity_%j.o
#SBATCH --error=/data/users/apiatkowska/assembly_annotation_course/assemblies/trinity/error_assembly_trinity_%j.e
#SBATCH --partition=pibu_el8

# Whole transcriptome assembly

WORKDIR=/data/users/apiatkowska/assembly_annotation_course

# load trinity module
module load Trinity/2.15.1-foss-2021a

# Create directory
mkdir -p "$WORKDIR/assemblies/trinity/trinity_RNAseq_Sha"

# Input directories for trinity RNA_Sha
FORWARD="$WORKDIR/input/RNAseq_Sha/ERR754081_1.fastq.gz"
REVERSE="$WORKDIR/input/RNAseq_Sha/ERR754081_2.fastq.gz"

# Output directory for trinity RNA_Sha
RNAseq_Sha_OUTPUT="$WORKDIR/assemblies/trinity/trinity_RNAseq_Sha"

echo "Starting trinity assembly for RNAseq_Sha"

# Assembly Trinity for RNAseq_Sha 
Trinity \
--max_memory 64G \
--seqType fq \
--left "$FORWARD" \
--right "$REVERSE" \
--CPU "$SLURM_CPUS_PER_TASK" \
--output "$RNAseq_Sha_OUTPUT"

echo "Trinity assembly for RNAseq_Sha finished"