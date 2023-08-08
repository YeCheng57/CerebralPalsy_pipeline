library(ExomeDepth)
V6<-read.table("Path_to_V6_bed")
V6.GRanges <- GenomicRanges::GRanges(seqnames = V6$chromosome,IRanges::IRanges(start=V6$start,end=V6$end),names = V6$name)
bamfile<-read.table("bamList", head=F, stringsA=F)$V1
counts <- getBamCounts(bed.frame=V6.GRanges, bam.file=bamfile,
                        include.chr=F, referenceFasta="path_to_reference.fasta")
counts<- as(counts, 'data.frame')
counts.mat<-as.matrix(counts[, grep(names(counts), pattern='*.bam')])
for(i in 1:ncol(counts.mat)){
        my.choice <- select.reference.set(test.counts=counts.mat[,i],
                                        reference.counts=counts.mat[,-i],
                                        bin.length=(counts$end-counts$start)/1000,
                                        n.bins.reduced=10000)
        my.reference.selected <- apply(X=counts.mat[, my.choice$reference.choice, drop=F],
                                MAR=1,FUN=sum)
        all.exons <- new('ExomeDepth', test=counts.mat[,i], reference=my.reference.selected, formula='cbind(test, reference)~1')
        all.exons<-CallCNVs(x=all.exons, transition.probability=10^-4,
                        chromosome=counts$chromosome,start=counts$start, end=counts$end, name=counts$exon)
        output.file <-paste('Exome_',i,'.csv', sep='')
        write.csv(file = output.file, x = all.exons@CNV.calls, row.names = FALSE)
}
