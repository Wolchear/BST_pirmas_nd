#!/bin/sh                                                      

#1) Calculate (and print to the screen) the number of sequences in your reference genome 
echo "Number of seqnces from GRCm38.p4.genome.fa.gz:  "
zcat ../../references/GRCm38.p4.genome.fa.gz | grep -c ">"


#2) Calculate (and print to the screen) the number of reads in each sample. 
R2=0
for i in ../../inputs/*.fastq.gz
do
R1=$i
R3=$(zcat $R1|wc -l)/4|bc
echo "number of read in sample $i : $R3"
R2=$R2+$R3
done
R4=$R2/8
echo "$R4"


#3)Calculate the number of protein-coding genes in your genome. 
zcat ../../references/gencode.vM9.chr_patch_hapl_scaff.basic.annotation.gtf.gz | grep -w "gene" | grep -w "protein_coding"| wc -l

#trim_galore --length 20 --illumina SRR8985047_1_fastq.gz -o ../

#multiqc --ignore /home/bioinformatikai/HW2/outputs/raw_data/SRR8985047_2_fastqc.html /home/bioinformatikai/HW2/outputs/raw_data

 #multiqc --ignore  SRR8985047_2_fastqc.html /home/bioinformatikai/HW2/outputs/raw_data
 #cp multiqc_report_4.html ../../code/BST_pirmas_nd
