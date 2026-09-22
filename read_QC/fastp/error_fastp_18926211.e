Detecting adapter sequence for read1...
No adapter detected for read1

Read1 before filtering:
total reads: 476430
total bases: 8104213674
Q20 bases: 7990086582(98.5918%)
Q30 bases: 7837306226(96.7066%)

Read1 after filtering:
total reads: 476430
total bases: 8104213674
Q20 bases: 7990086582(98.5918%)
Q30 bases: 7837306226(96.7066%)

Filtering result:
reads passed filter: 476430
reads failed due to low quality: 0
reads failed due to too many N: 0
reads with adapter trimmed: 0
bases trimmed due to adapters: 0

Duplication rate (may be overestimated since this is SE data): 0.00629683%

JSON report: /data/users/apiatkowska/assembly_annotation_course/read_QC/fastp/Pa-1/fastp_Pa-1.json
HTML report: /data/users/apiatkowska/assembly_annotation_course/read_QC/fastp/Pa-1/fastp_Pa-1.html

/usr/local/bin/fastp --thread 4 --in1 /data/users/apiatkowska/assembly_annotation_course/input/Pa-1/ERR11437314.fastq.gz --out1 /data/users/apiatkowska/assembly_annotation_course/read_QC/fastp/Pa-1/ERR11437314.fastq.gz --disable_quality_filtering --disable_length_filtering --html /data/users/apiatkowska/assembly_annotation_course/read_QC/fastp/Pa-1/fastp_Pa-1.html --json /data/users/apiatkowska/assembly_annotation_course/read_QC/fastp/Pa-1/fastp_Pa-1.json 
fastp v0.24.1, time used: 329 seconds
Read1 before filtering:
total reads: 22620680
total bases: 2284688680
Q20 bases: 2016311482(88.2532%)
Q30 bases: 1740798381(76.1941%)

Read2 before filtering:
total reads: 22620680
total bases: 2284688680
Q20 bases: 2046996125(89.5963%)
Q30 bases: 1848457564(80.9063%)

Read1 after filtering:
total reads: 20352421
total bases: 2043758461
Q20 bases: 1874041401(91.6958%)
Q30 bases: 1630733821(79.7909%)

Read2 after filtering:
total reads: 20352421
total bases: 2043758461
Q20 bases: 1933320289(94.5963%)
Q30 bases: 1764232283(86.3229%)

Filtering result:
reads passed filter: 40704842
reads failed due to low quality: 4536276
reads failed due to too many N: 242
reads failed due to too short: 0
reads with adapter trimmed: 2131136
bases trimmed due to adapters: 24329968

Duplication rate: 6.60611%

Insert size peak (evaluated by paired-end reads): 135

JSON report: /data/users/apiatkowska/assembly_annotation_course/read_QC/fastp/RNAseq_Sha/fastp_RNAseq_Sha.json
HTML report: /data/users/apiatkowska/assembly_annotation_course/read_QC/fastp/RNAseq_Sha/fastp_RNAseq_Sha.html

/usr/local/bin/fastp --thread 4 --in1 /data/users/apiatkowska/assembly_annotation_course/input/RNAseq_Sha/ERR754081_1.fastq.gz --in2 /data/users/apiatkowska/assembly_annotation_course/input/RNAseq_Sha/ERR754081_2.fastq.gz --out1 /data/users/apiatkowska/assembly_annotation_course/read_QC/fastp/RNAseq_Sha/ERR754081_1.fastq.gz --out2 /data/users/apiatkowska/assembly_annotation_course/read_QC/fastp/RNAseq_Sha/ERR754081_2.fastq.gz --html /data/users/apiatkowska/assembly_annotation_course/read_QC/fastp/RNAseq_Sha/fastp_RNAseq_Sha.html --json /data/users/apiatkowska/assembly_annotation_course/read_QC/fastp/RNAseq_Sha/fastp_RNAseq_Sha.json 
fastp v0.24.1, time used: 87 seconds
