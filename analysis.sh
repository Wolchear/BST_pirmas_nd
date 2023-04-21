#!/bin/sh

pathTOGeneExpression="../../outputs/geneExpression"
deduplicatedBam="../../outputs/deduplicatedBam"
pathForStringTie="../../outputs/stringTie"
pathToGenomeIndex="../../references"
for i in $deduplicatedBam/*.bam
do
basename=$(basename $i _deduplicated.bam)
if [ ! -d $pathTOGeneExpression/$basename ];
then
   mkdir -p "$pathTOGeneExpression/$basename"
    echo "Buvo sukurta $pathTOGeneExpression/$basename"
fi
echo "featureCounts for $pathForStringTie/$basename/$basename.gtf"
featureCounts -p -a "$pathToGenomeIndex/gencode.vM9.chr_patch_hapl_scaff.basic.annotation.gtf" -o "$pathTOGeneExpression/$basename/$basename.txt" -t gene -g gene_id $i
done
