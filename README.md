# assembly_annotation_2026
Repository for the genome and transcriptome annotation course in Bern University


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

All input reads can be found on IBU cluster of University of Bern here:
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

To test scripts run them on partition #SBATCH --partition=pshort_el8

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
    
    5. Assemblies:

        5.1 Whole genome assably using flye v_2.9.5. : 
                For flye documentation: https://github.com/mikolmogorov/Flye/blob/flye/docs/USAGE.md
                sbatch 05_run_assambly_flye_PacBio.sh

        5.2 Whole genome assably using hifiasm:
                For hifiasm documentation: https://github.com/chhylp123/hifiasm
                sbatch 06_run_assambly_hifiasm_PacBio.sh

                # Convert GFA to FASTA in terminal
                go to the folder where your gfa file with is with cd and run:
                awk '/^S/{print ">"$2;print $3}' hifiasm_Pa1.bp.p_ctg.gfa > hifiasm_Pa1.bp.p_ctg.fa

        5.3 Whole genome assably using LJA:
                For LJA documentation: https://github.com/AntonBankevich/LJA/blob/main/docs/lja_manual.md
                sbatch 07_run_assambly_LJA_PacBio.sh

        5.4 Whole TRANSCRIPTOME assably using Trinity
                For trinity documentation: https://github.com/trinityrnaseq/trinityrnaseq/wiki
                sbatch 08_run_assambly_Trinity_Illumina.sh

    6. Quality Control of Assemblies 
    
        6.1 with Busco v_5.7.1. :
            For Busco documentation go: https://busco.ezlab.org/busco_userguide.html#running-busco

            6.1.1 Run Busco with Flye
                    sbatch 09_run_BUSCO_evaluation_on_Flye.sh

            6.1.2 Run Busco with hifiasm
                    sbatch 10_run_BUSCO_evaluation_on_Hifiasm.sh

            6.1.3 Run Busco with LJA
                    sbatch 11_run_BUSCO_evaluation_on_LJA.sh

            6.1.4 Run Busco with Trinity
                    sbatch 12_run_BUSCO_evaluation_on_Trinity.sh
    
        6.2 with Quast v_5.2.0. (with and without the reference):
            For Quast documentation go: https://quast.sourceforge.net/docs/manual.html#sec2

            6.2.1 Run Busco with Flye
                    sbatch

            6.2.2 Run Busco with hifiasm
                    sbatch

            6.2.3 Run Busco with LJA
                    sbatch

            6.2.4 Run Busco with Trinity
                    sbatch

        6.3 with MERQURY v_1.3. :


#TODO Plot BUSCO RESULTS https://busco.ezlab.org/busco_userguide.html#plotting-the-results



/data/users/apiatkowska/assembly_annotation_course/assemblies_evaluation/Merqury/flye/flye_merqury.assembly.spectra-cn.fl.png
[text](assemblies_evaluation/Merqury/flye/flye_merqury.qv)
[text](assemblies_evaluation/Merqury/flye/flye_merqury.completeness.stats)