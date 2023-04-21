#if [ ! -f ../../references/gencode.vM9.transcripts.fa ];
#then
#gunzip ../../references/gencode.vM9.transcripts.fa.gz
#fi

#if [ ! -d ../../references/transc_index];
#then
#mkdir ../../references/transc_index
#fi

dir="../../references/transc_index"
#if [ ! -f $dir/complete_ref_lens.bin || ! -f $dir/ctg_offsets.bin || ! -f $dir/duplicate_clusters.tsv || ! -f $dir/pos.bin|| ! -f $dir/rank.bin || ! -f $dir/ref_indexing.log || ! -f $dir/refseq.bin || ! -f $dir/mphf.bin  || ! -f $dir/ctable.bin || ! -f $dir/refAccumLengths.bin || ! -f $dir/reflengths.bin || ! -f $dir/seq.bin];
#then
#echo "SOME FILES ARE MISSING"
#salmon index -t ../../references/gencode.vM9.transcripts.fa -i $dir
#fi

       

# Data QC 
#threads=6
#1) FASTQC analysis on each of FASTQC files.
##outputs= ../../outputs/raw_data/
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

#gffread -E ../../references/gencode.vM9.chr_patch_hapl_scaff.basic.annotation.gtf -o  ../../references/transcripts.gtf
deduplicatedBam="../../outputs/deduplicatedBam"
pathForStringTie="../../outputs/stringTie"
#stringtie --merge $pathForStringTie/SRR8985047/SRR8985047.gtf $pathForStringTie/SRR8985048/SRR8985048.gtf $pathForStringTie/SRR8985051/SRR8985051.gtf $pathForStringTie/SRR8985052/SRR8985052.gtf -o ../../reference/merge.gtf -c 3


for i in ../../inputs/trimmed/*_1_val_1.fq.gz
do
R1=$i
R2="../../inputs/trimmed/$(basename $i _1_val_1.fq.gz)_2_val_2.fq.gz"
salmon quant -i $dir -l A -1 $R1 -2 $R2 -o ../../outputs/salmonQa/$(basename $R1 _1_val_1.fq.gz) --validateMappings --geneMap ../../reference/merge.gtf
done