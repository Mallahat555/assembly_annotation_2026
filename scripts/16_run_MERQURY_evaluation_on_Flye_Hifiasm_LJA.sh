#!/usr/bin/env bash

#SBATCH --time=02:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=merqury_all_assemblies
#SBATCH --mail-user=agnieszka.piatkowska@students.unibe.ch
#SBATCH --mail-type=END
#SBATCH --output=/data/users/apiatkowska/assembly_annotation_course/assemblies_evaluation/Merqury/output_merqury_%j.o
#SBATCH --error=/data/users/apiatkowska/assembly_annotation_course/assemblies_evaluation/Merqury/error_merqury_%j.e
#SBATCH --partition=pshort_el8

# ----------------------------------------------------------------------
# DIRECTORIES & CONTAINER SETUP
# ----------------------------------------------------------------------
WORKDIR="/data/users/apiatkowska/assembly_annotation_course"
OUT_DIR="$WORKDIR/assemblies_evaluation/Merqury"
MERQURY_SIF="/containers/apptainer/merqury_1.3.sif"

# Create main output directory
mkdir -p "$OUT_DIR"
cd "$OUT_DIR"

# Input Reads (adjust file path/extension if necessary for your HiFi dataset)
READS="$WORKDIR/input/Pa-1/ERR11437314.fastq.gz"  

# Input Assemblies
FLYE_ASM="$WORKDIR/assemblies/flye/flye_Pa1/assembly.fasta" 
HIFI_ASM="$WORKDIR/assemblies/hifiasm/hifiasm_Pa1.bp.p_ctg.fa"
LJA_ASM="$WORKDIR/assemblies/LJA/LJA_Pa1/assembly.fasta" 

# K-mer size for Arabidopsis thaliana (~135 Mb genome size)
K=21
cd "$OUT_DIR"
MERYL_DB="read_db.meryl"
MERYL_DB_PATH="/data/users/apiatkowska/assembly_annotation_course/assemblies_evaluation/Merqury/read_db.meryl"

echo "=========================================================="
echo "Starting Meryl k-mer DB build and Merqury evaluations..."
echo "=========================================================="

# ----------------------------------------------------------------------
# STEP 1: PREPARE MERYL DB FROM READS
# ----------------------------------------------------------------------
if [ ! -d "$MERYL_DB" ]; then
    echo "[1/4] Building Meryl database ($K-mer DB) from reads..."
    apptainer exec --bind /data "$MERQURY_SIF" \
        meryl count threads=$SLURM_CPUS_PER_TASK k=$K "$READS" output "$MERYL_DB"
else
    echo "[1/4] Meryl database already exists at $MERYL_DB, skipping build step."
fi

# ----------------------------------------------------------------------
# STEP 2: EVALUATE FLYE ASSEMBLY
# ----------------------------------------------------------------------
echo "[2/4] Running Merqury on Flye assembly..."
mkdir -p "$OUT_DIR/flye" && cd "$OUT_DIR/flye"
apptainer exec --bind /data "$MERQURY_SIF" \
    env MERQURY="/usr/local/share/merqury" \
    merqury.sh "$MERYL_DB_PATH" "$FLYE_ASM" flye_merqury

# ----------------------------------------------------------------------
# STEP 3: EVALUATE HIFIASM ASSEMBLY
# ----------------------------------------------------------------------
echo "[3/4] Running Merqury on Hifiasm assembly..."
mkdir -p "$OUT_DIR/hifiasm" && cd "$OUT_DIR/hifiasm"
apptainer exec --bind /data "$MERQURY_SIF" \
    env MERQURY="/usr/local/share/merqury" \
    merqury.sh "$MERYL_DB_PATH" "$HIFI_ASM" hifiasm_merqury

# ----------------------------------------------------------------------
# STEP 4: EVALUATE LJA ASSEMBLY
# ----------------------------------------------------------------------
echo "[4/4] Running Merqury on LJA assembly..."
mkdir -p "$OUT_DIR/lja" && cd "$OUT_DIR/lja"
apptainer exec --bind /data "$MERQURY_SIF" \
    env MERQURY="/usr/local/share/merqury" \
    merqury.sh "$MERYL_DB_PATH" "$LJA_ASM" lja_merqury

echo "=========================================================="
echo "All Merqury evaluations finished successfully!"
echo "=========================================================="