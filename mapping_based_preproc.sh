#!/bin/sh

#1)

## Data QC 

#1) FASTQC analysis on each of FASTQC files.
#threads=8
#outputs= ../../outputs/raw_data/
#mkdir -p ../../outputs/raw_data/
#fastqc -t $threads ../../inputs/* -o $outputs


#2) Generate MultiQc for '1' samples
#multiqc /home/bioinformatikai/HW2/outputs/raw_data/*1_fastqc* -o /home/bioinformatikai/HW2/outputs/raw_data/

#3) + 4)
mkdir -p ../../inputs/trimmed
for i in ../../inputs/*1.fastq.gz
do
R1=$i
R2="../../inputs/$(basename $R1 1.fastq.gz)2.fastq.gz"
trim_galore -paired $R1 $R2 --fastqc -o ../../inputs/trimmed/ --length 20 -q 20 --stringency 3 
done
echo "All samples are trimmed"

#multiqc /home/bioinformatikai/HW2/inputs/trimmed/*1_fastqc* -o/home/bioinformatikai/HW2/code/BST_pirmas_nd
