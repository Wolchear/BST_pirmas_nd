library(limma)
library(metan)
library(edgeR)
library(ggplot2)
library(tximport)

counts_SRR8985047 <- read.table("../Documents/GitHub/BST_pirmas_nd/SRR8985047.txt", header=TRUE, row.names=1)
counts_SRR8985048 <- read.table("../Documents/GitHub/BST_pirmas_nd/SRR8985048.txt", header=TRUE, row.names=1)
counts_SRR8985051 <- read.table("../Documents/GitHub/BST_pirmas_nd/SRR8985051.txt", header=TRUE, row.names=1)
counts_SRR8985052 <- read.table("../Documents/GitHub/BST_pirmas_nd/SRR8985052.txt", header=TRUE, row.names=1)

counts_SRR8985052_subset <- subset(counts_SRR8985052, select=-c(Chr,Length,Start, End, Strand))
counts_SRR8985051_subset <- subset(counts_SRR8985051, select=-c(Chr,Length,Start, End, Strand))
counts_SRR8985048_subset <- subset(counts_SRR8985048, select=-c(Chr,Length,Start, End, Strand))
counts_SRR8985047_subset <- subset(counts_SRR8985047, select=-c(Chr,Length,Start, End, Strand))

counts_salmon_SRR8985047 <- read.table("../Documents/GitHub/BST_pirmas_nd/SRR8985047/quant.genes.sf", header=TRUE, row.names=1)
counts_salmon_SRR8985048 <- read.table("../Documents/GitHub/BST_pirmas_nd/SRR8985048/quant.genes.sf", header=TRUE, row.names=1)
counts_salmon_SRR8985051 <- read.table("../Documents/GitHub/BST_pirmas_nd/SRR8985051/quant.genes.sf", header=TRUE, row.names=1)
counts_salmon_SRR8985052 <- read.table("../Documents/GitHub/BST_pirmas_nd/SRR8985052/quant.genes.sf", header=TRUE, row.names=1)

subset_salmon_SRR8985047 <- subset(counts_salmon_SRR8985047, select=-c(EffectiveLength,Length,TPM))
subset_salmon_SRR8985048 <- subset(counts_salmon_SRR8985048, select=-c(EffectiveLength,Length,TPM))
subset_salmon_SRR8985051 <- subset(counts_salmon_SRR8985051, select=-c(EffectiveLength,Length,TPM))
subset_salmon_SRR8985052 <- subset(counts_salmon_SRR8985052, select=-c(EffectiveLength,Length,TPM))

cor_matrix <- cbind(counts_SRR8985052_subset, counts_SRR8985051_subset, 
             counts_SRR8985048_subset, counts_SRR8985047_subset,
             subset_salmon_SRR8985047,subset_salmon_SRR8985048,
             subset_salmon_SRR8985051,subset_salmon_SRR8985052)
corrl<-corr_coef(cor_matrix)

plot(corrl)

