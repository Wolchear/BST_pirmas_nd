#!/bin/sh

#1)

## Data QC 

#1) FASTQC analysis on each of FASTQC files.
threads=8
outputs= ../../outputs/raw_data/
mkdir -p ../../outputs/raw_data/
fastqc -t $threads ../../inputs/* -o $outputs


#2) Generate MultiQc for '1' samples
#multiqc $outputs/*1_fastqc.html

#3)cp SRR8985047_1_trimmed_fastqc.html ../code/BST_pirmas_nd