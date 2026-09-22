#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem=40G
#SBATCH --time=02:00:00
#SBATCH --job-name=k-mer_counting
#SBATCH --mail-user=agnieszka.piatkowska@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/apiatkowska/assembly_annotation_course/read_QC/kmer_counting/output_k-mer_counting_%j.o
#SBATCH --error=/data/users/apiatkowska/assembly_annotation_course/read_QC/kmer_counting/error_k-mer_counting_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/apiatkowska/assembly_annotation_course

# Create directories
mkdir -p "$WORKDIR/read_QC/kmer_counting/RNAseq_Sha"
mkdir -p "$WORKDIR/read_QC/kmer_counting/Pa-1"

# Input files
FORWARD="$WORKDIR/input/RNAseq_Sha/ERR754081_1.fastq.gz"
REVERSE="$WORKDIR/input/RNAseq_Sha/ERR754081_2.fastq.gz"
PA1_INPUT="$WORKDIR/input/Pa-1/ERR11437314.fastq.gz"

# Output files for RNAseq_Sha
JF_Sha="$WORKDIR/read_QC/kmer_counting/RNAseq_Sha/Sha_reads.jf"
HISTO_Sha="$WORKDIR/read_QC/kmer_counting/RNAseq_Sha/Sha_reads.histo"

# Output files for Pa-1
JF_Pa1="$WORKDIR/read_QC/kmer_counting/Pa-1/Pa1_reads.jf"
HISTO_Pa1="$WORKDIR/read_QC/kmer_counting/Pa-1/Pa1_reads.histo"


echo "Starting k-mer counting for RNAseq_Sha"

# Count k-mers on RNAseq_Sha
apptainer exec \
    --bind /data \
    /containers/apptainer/jellyfish-2.2.6--0.sif \
    jellyfish count \
    -C \
    -m 21 \
    -s 5G \
    -t 4 \
    <(zcat "$FORWARD") \
    <(zcat "$REVERSE") \
    -o "$JF_Sha"

echo "k-mer counting for RNAseq_Sha finished"

# Create k-mer histogram for RNAseq_Sha
apptainer exec \
    --bind /data \
    /containers/apptainer/jellyfish-2.2.6--0.sif \
    jellyfish histo \
    -t 4 \
    "$JF_Sha" > "$HISTO_Sha"

echo "k-mer histogram for RNAseq_Sha finished"


echo "Starting k-mer counting for Pa-1"

# Count k-mers on Pa-1
apptainer exec \
    --bind /data \
    /containers/apptainer/jellyfish-2.2.6--0.sif \
    jellyfish count \
    -C \
    -m 21 \
    -s 5G \
    -t 4 \
    <(zcat "$PA1_INPUT") \
    -o "$JF_Pa1"

echo "k-mer counting for Pa-1 finished"

# Create k-mer histogram for Pa-1
apptainer exec \
    --bind /data \
    /containers/apptainer/jellyfish-2.2.6--0.sif \
    jellyfish histo \
    -t 4 \
    "$JF_Pa1" > "$HISTO_Pa1"

echo "k-mer histogram for Pa-1 finished"

echo "All k-mer counting and histogram jobs finished"

