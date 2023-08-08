setwd("~/CP/WES/burden/Misense/REVEL/")
gl<-read.table("~/CP/WES/burden/genelist")$V1
LoF<-read.table("CP1578_m6_CT2028.REVEL75.txt",head=F,sep="\t")
LoF<-LoF[LoF$V9%in%gl,]
res<-character()
genelist=unique(LoF$V9)
for (i in genelist) {
  gene=LoF[LoF$V9==i,]
  if("CP"%in%gene$V1){
    cp=sum(gene[gene$V1=="CP","V197"])*2
  }else{
    cp=0
  }
  if("CTRL"%in%gene$V1){
    ctrl=sum(gene[gene$V1=="CTRL","V197"])*2
  }else{
    ctrl=0
  }
  if(ctrl==0){
    res[gene$V9]=gene$V9
  }
}

LoF<-LoF[LoF$V1=="CTRL",]
a<-table(LoF$V9,LoF$V2)
a<-rowSums(a)==0



LoF_counts<-table(LoF$V12)
LoF_counts[LoF_counts>=3]
splicing_counts<-table(LoF$V10)
LoF1<-LoF[!LoF$V12%in%names(LoF_counts[LoF_counts>=3])[2:865],]
LoF2<-LoF1[!LoF1$V10%in%names(splicing_counts[splicing_counts>=3])[2:247],]
genelist<-unique(LoF$V9)
p<-numeric()
or<-numeric()
h<-numeric()
l<-numeric()
for (i in genelist) {
  gene=LoF[LoF$V9==i,]
  if("CP"%in%gene$V1){
    cp=sum(gene[gene$V1=="CP","V13"])*2
  }else{
    cp=0
  }
  if("CTRL"%in%gene$V1){
    ctrl=sum(gene[gene$V1=="CTRL","V13"])*2
  }else{
    ctrl=0
  }
  fisher_res=fisher.test(matrix(c(cp,1572*2-cp,ctrl,2028*2-ctrl),2), alternative = 'greater')
  p[i]=fisher_res$p.value
  or[i]=fisher_res$estimate
  l[i]=fisher_res$conf.int[1]
  h[i]=fisher_res$conf.int[2]
}
res=cbind(p,or,l,h)
write.table(res,"CP1578NotInCtrl_revel75.txt",quote = F)

library(readxl)









