#!/bin/sh                                                      

#1)
$(gunzip ../../references/GRCm38.p4.genome.fa.gz)
echo $(grep -v ">" ../../references/GRCm38.p4.genome.fa | grep -E -o "G|C|T|A|N" | wc -l)

#2)
R2=0
for i in ../../inputs/*.fastq.gz
do
R1=$i
R3=$(cat $R1|wc -l)/4|bc
R2=$R2+$R3
done
R4=$R2/8
echo "$R4"
