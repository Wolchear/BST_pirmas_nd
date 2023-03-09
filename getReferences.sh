#!/bin/sh

#1) the reference genome in FASTA format (9mm)
wget -P../../references https://hgdownload.soe.ucsc.edu/goldenPath/mm9/bigZips/mm9.fa.gz

#2)eference transcriptome in FASTA format
wget -P../../references https://hgdownload.soe.ucsc.edu/goldenPath/mm9/bigZips/refMrna.fa.gz

#3) GTF file
wget -P../../references  https://hgdownload.soe.ucsc.edu/goldenPath/mm9/bigZips/genes/mm9.refGene.gtf.gz


#4) raw FASTQ files
wget -P ../../inputs ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR898/007/SRR8985047/SRR8985047_1.fastq.gz
wget -P ../../inputs ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR898/007/SRR8985047/SRR8985047_2.fastq.gz
wget -P ../../inputs ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR898/008/SRR8985048/SRR8985048_1.fastq.gz
wget -P ../../inputs ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR898/008/SRR8985048/SRR8985048_2.fastq.gz
wget -P ../../inputs ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR898/001/SRR8985051/SRR8985051_1.fastq.gz
wget -P ../../inputs ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR898/001/SRR8985051/SRR8985051_2.fastq.gz
wget -P ../../inputs ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR898/002/SRR8985052/SRR8985052_1.fastq.gz
wget -P ../../inputs ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR898/002/SRR8985052/SRR8985052_2.fastq.gz
