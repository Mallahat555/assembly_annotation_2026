The instructions for this practical can be found here: 
        https://docs.pages.bioinformatics.unibe.ch/assembly-annotation-course/Assembly/

Raw data are coming from these 2 publications:

        1. Qichao Lian et al. A pan-genome of 69 Arabidopsis thaliana 
            accessions reveals a conserved genome structure throughout 
            the global species range. Nature Genetics. 2024;56:982-991. 
            Available from: https://www.nature.com/articles/s41588-024-01715-9

        2. Jiao WB, Schneeberger K. Chromosome-level assemblies of multiple 
            Arabidopsis genomes reveal hotspots of rearrangements with altered 
            evolutionary dynamics. Nature Communications. 2020;11:1–10. 
            Available from: http://dx.doi.org/10.1038/s41467-020-14779-y

All input reads can be found here:
    /data/courses/assembly-annotation-course/raw_data

Whole genome PacBio HiFi reads for accession for user apiatkowska is:
    Pa-1

        Input reads for user apiatkowska:
            /data/courses/assembly-annotation-course/raw_data/Pa-1

            file name is: 
                         ERR11437314.fastq.gz

Whole transcriptome Illumina RNAseq for accession RNAseq_Sha for all users:

        Input reads for all users:
            /data/courses/assembly-annotation-course/raw_data/RNAseq_Sha
            
            fine names are:
                         ERR754081_1.fastq.gz
                         ERR754081_2.fastq.gz

To get a list of all available software/versions type module avail
To load a specific module (e.g. FastQC) type module load FastQC/0.11.9-Java-11

Lest start the analysys:
    1. Create soft links to Pa-1 and RNA_seq RNAseq_Sha directories:

        Either in Terminal and create your own input directory:
            ln -s /data/courses/assembly-annotation-course/raw_data/Pa-1 ./
            ln -s /data/courses/assembly-annotation-course/raw_data/RNAseq_Sha ./

        Or submitt the job and have directories created outomatically:
            sbatch 01_generate_soft_link.sh

    2. Run FastQC:
        sbatch 02_run_fastQC.sh
            this creates separate output directories for Pa-1 and RNAseq_Sha under read_QC/FastQC

    3. Run fastp
        sbatch 03_run_fastp.sh
                        
    4. Run kmer counting
        sbatch 04_run_kmer_counting.sh