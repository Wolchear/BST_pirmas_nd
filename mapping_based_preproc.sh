#!/bin/sh

#1)
pathToGenomeIndex="../../references"
indexGenomeFilesBasename="genome_index"
filesExists=0
haveToBe=8
for i in 1 2 3 4 5 6 7 8
do
echo $pathToGenomeIndex/$indexGenomeFilesBasename"."$i".ht2"
    if [ -f $pathToGenomeIndex/$indexGenomeFilesBasename"."$i".ht2" ]; 
    then
    filesExists=$(($filesExists+1))
    fi
done
echo $filesExists

if [ $filesExists -eq $haveToBe ]
then
    echo "You have all files"
else
echo $pathToGenomeIndex/$indexGenomeFilesBasename
gunzip $pathToGenomeIndex/GRCm38.p4.genome.fa.gz
hisat2-build $pathToGenomeIndex/GRCm38.p4.genome.fa  $pathToGenomeIndex/$indexGenomeFilesBasename
fi
## Data QC 

#1) FASTQC analysis on each of FASTQC files.
#threads=8
#outputs= ../../outputs/raw_data/
#mkdir -p ../../outputs/raw_data/
#fastqc -t $threads ../../inputs/* -o $outputs


#2) Generate MultiQc for '1' samples
#multiqc /home/bioinformatikai/HW2/outputs/raw_data/*1_fastqc* -o /home/bioinformatikai/HW2/outputs/raw_data/

#3) + 4)
#mkdir -p ../../inputs/trimmed
#for i in ../../inputs/*1.fastq.gz
#do
#R1=$i
#R2="../../inputs/$(basename $R1 1.fastq.gz)2.fastq.gz"
#trim_galore -paired $R1 $R2 --fastqc -o ../../inputs/trimmed/ --length 20 -q 20 --stringency 3 
#done
#echo "All samples are trimmed"

#multiqc /home/bioinformatikai/HW2/inputs/trimmed/*1_fastqc* -o/home/bioinformatikai/HW2/code/BST_pirmas_nd


#Mapping
#1)
path="../../inputs/trimmed"
pathForMapped="../../outputs/mapped"
pathForUnMapped="../../outputs/unmapped"
pathForSam="../../outputs/samFiles"
for i in $path/*_1_val_1.fq.gz
do
R1=$i
R2="$path/$(basename $R1 _1_val_1.fq.gz)_2_val_2.fq.gz"
echo "$pathForSam/$(basename $R1 _1_val_1.fq.gz).sam"
hisat2 -x $pathToGenomeIndex/$indexGenomeFilesBasename --dta -1 $R1 -2 $R2 -S "$pathForSam/$(basename $R1 _1_val_1.fq.gz).sam"
done


for i in $pathForSam/*.sam
do
echo $i
#samtools view -bS $i -@ 6| samtools sort -@ 6 -o "$pathForMapped/$(basename$i).bam"
#samtools index "$pathForMapped/$(basename$i).bam"
done
echo "Mapping is done"

