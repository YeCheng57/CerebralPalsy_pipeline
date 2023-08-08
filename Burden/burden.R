setwd("~/CP/WES/burden/Misense/REVEL/")
LoF<-read.table("CPCTRL.REVEL75.txt",head=F,sep="\t")
genelist<-unique(LoF$V9)
p<-numeric()
or<-numeric()
h<-numeric()
l<-numeric()
num_cases = 
num_ctrl =
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
  fisher_res=fisher.test(matrix(c(cp,num_cases*2-cp,ctrl,num_ctrl*2-ctrl),2), alternative = 'greater')
  p[i]=fisher_res$p.value
  or[i]=fisher_res$estimate
  l[i]=fisher_res$conf.int[1]
  h[i]=fisher_res$conf.int[2]
}
res=cbind(p,or,l,h)









