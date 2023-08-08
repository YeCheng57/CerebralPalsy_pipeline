setwd("~/pipeline/CANOES/")
gc <- read.table("V6_hg38.gc.txt")$V2
#canoes.reads <- read.table("canoes.reads.txt")
sample.names <- read.table("id")$V1
#names(canoes.reads) <- c("chromosome", "start", "end", sample.names)
#target <- seq(1, nrow(canoes.reads))
#canoes.reads <- cbind(target, gc, canoes.reads)
#canoes.reads<-canoes.reads[!canoes.reads$chromosome%in%c('chrX','chrY'),]
#a<-as.numeric(sapply(canoes.reads$chromosome,function(x){strsplit(x,'r')[[1]][2]}))
#canoes.reads$chromosome<-a
#saveRDS(canoes.reads, 'CPdaan_canoes.RDS')
canoes.reads<-readRDS("CPdaan_canoes.RDS")
source("CANOES.R")
xcnv.list <- vector('list', length(sample.names))
for (i in 1:length(sample.names)){
  xcnv.list[[i]] <- CallCNVs(sample.names[i], canoes.reads)
  xcnvs <- do.call('rbind', xcnv.list)
  write.table(xcnvs, 'CPdaan_canoes.txt', sep="\t", quote = F)
}
#xcnvs <- do.call('rbind', xcnv.list)
#write.table(xcnvs, 'wyg_canoes.txt', sep="\t", quote = F)
