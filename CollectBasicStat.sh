#!/bin/sh                                                      

#1)
zcat ../../references/GRCm38.p4.genome.fa.gz | grep -c ">"


#2)
R2=0
for i in ../../inputs/*.fastq.gz
do
R1=$i
R3=$(zcat $R1|wc -l)/4|bc
R2=$R2+$R3
done
R4=$R2/8
echo "$R4"

#3)
zcat ../../references/gencode.vM9.chr_patch_hapl_scaff.basic.annotation.gtf.gz | grep -w "gene" | grep -w "protein_coding"| wc -l