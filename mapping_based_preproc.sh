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
# Data QC 
threads=6
#1) FASTQC analysis on each of FASTQC files.
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

#5)MultiQC for all samples
#multiqc /home/bioinformatikai/HW2/inputs/trimmed/*_fastqc* -o /home/bioinformatikai/HW2/outputs/multiQC/trimmed/
#multiqc /home/bioinformatikai/HW2/outputs/raw_data/*_fastqc* -o /home/bioinformatikai/HW2/outputs/multiQC/notTrimmed/


#Mapping
#1)
path="../../inputs/trimmed"
pathForMapped="../../outputs/mapped"
pathForUnMapped="../../outputs/unmapped"
pathForSam="../../outputs/samFiles"
deduplicatedBam="../../outputs/deduplicatedBam"
sortedBam="../../outputs/sortedBam"
pathFixmatedBam="../../outputs/fixmateBam"
#for i in $path/*_1_val_1.fq.gz
#do
#R1=$i
#R2="$path/$(basename $R1 _1_val_1.fq.gz)_2_val_2.fq.gz"
#echo "$pathForSam/$(basename $R1 _1_val_1.fq.gz).sam"
#hisat2 -x $pathToGenomeIndex/$indexGenomeFilesBasename --dta -1 $R1 -2 $R2 -S "$pathForSam/$(basename $R1 _1_val_1.fq.gz).sam"
#done


for i in $pathForSam/*.sam
do

echo "samtools for $i"
samtools view -F 4 -bS $i -@ 7 | samtools sort -@ 7 -n -o "$sortedBam/$(basename $i .sam)_Nsorted.bam"
done
echo "Mapping is done"

for i in $sortedBam/*bam
do
echo "index for $i"
samtools index -b $i -o "$pathForMapped/"
done

for i in $sortedBam/*bam
do
echo "fixmate for $i"
samtools fixmate -m -@ 6 -O BAM  $i "$pathFixmatedBam/$(basename $i Nsorted.bam)fixmated.bam"
done

for i in $pathFixmatedBam/*bam
do
echo "Sorting for $i"
samtools sort -@ 6 -o "$sortedBam/$(basename $i _fixmated.bam)_Osorted.bam" $i
done


for i in $sortedBam/*_Osorted.bam
do
echo "$deduplicatedBam/$(basename $i Osorted.bam)deduplicated.bam"
samtools markdup -r $i "$deduplicatedBam/$(basename $i Osorted.bam)deduplicated.bam"
done

for i in $deduplicatedBam/*bam
do
echo "index for $i"
samtools index -b $i 
done

gunzip ../../references/gencode.vM9.chr_patch_hapl_scaff.basic.annotation.gtf.gz
pathForStringTie="../../outputs/stringTie"
for i in $deduplicatedBam/*.bam
do
echo "stringTie for $i"
if [ ! -d "$pathForStringTie/$(basename $i _deduplicated.bam)" ];
then
   mkdir -p "$pathForStringTie/$(basename $i _deduplicated.bam)"
    echo "Buvo sukurta $pathForStringTie/$(basename $i _deduplicated.bam)"
fi
echo "stringTie for $i"
stringtie -e -B -G ../../references/gencode.vM9.chr_patch_hapl_scaff.basic.annotation.gtf -o "$pathForStringTie/$(basename $i _deduplicated.bam)/$(basename $i _deduplicated.bam).gtf" $i
echo " saved to $pathForStringTie/$(basename $i _deduplicated.bam)/$(basename $i _deduplicated.bam).gtf"
done

resultsPawth="../../results"
sample47="SRR8985047_deduplicated.bam"
sample48="SRR8985048_deduplicated.bam"
sample51="SRR8985051_deduplicated.bam"
sample52="SRR8985052_deduplicated.bam"
multiBamSummary bins  --bamfiles "$deduplicatedBam/$sample47" "$deduplicatedBam/$sample48" "$deduplicatedBam/$sample51" "$deduplicatedBam/$sample52" --outFileName "$resultsPawth/mappend.npz" --binSize 1000 -p 4 --outRawCounts "$resultsPawth/raw_counts.tsv"

plotCorrelation -in "$resultsPawth/mappend.npz"  -c pearson --whatToPlot heatmap  -o "$resultsPawth/mapped_data_heatmap_person.pdf" --plotNumbers
plotCorrelation -in "$resultsPawth/mappend.npz" -c spearman  --whatToPlot heatmap -o "$resultsPawth/mapped_data_heatmap_spearman.pdf" --plotNumbers

plotPCA -in "$resultsPawth/mappend.npz" -o "$resultsPawth/mapped_data_heatmap_Pca.pdf"