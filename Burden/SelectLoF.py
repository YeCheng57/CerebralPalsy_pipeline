import os
import sys
import argparse
parser=argparse.ArgumentParser(description="Select candidate variations from annovar txt")
parser.add_argument('--annovar','-a',help='path to annotated text file [annovar]',required=True)
parser.add_argument('--frequency','-f',help='the threshold of allele frequency',required=False,default=0.0001)
parser.add_argument('--VAF_threshold',help='the variant allele frequency threshold to be heterzygote', required=False, default=0.25)
parser.add_argument('--splicing_index','-s', help = 'the column indicate the effect of splicing', required=False, default=6)
parser.add_argument('--exon_index','-e',help='the column indicating the exonic function', required=False, default=9)
parser.add_argument('--genomic_superdups','-g', help='the column indication the annotation of genomic superdups database', required=False, default=18)
parser.add_argument('--phast100','-p', help='the column indicating the annotation of phastConsElements100way', required=False, default=16)
parser.add_argument('--heterozygote','-H',help='the column indicating the heterzygous or homozygous status', required=False, default=195)
parser.add_argument('--quality','-q',help='the column indicating the variation quality', required=False, default=196)
parser.add_argument('--quality_threshold','-qt',help='the threshold the variation quality', required=False, default=30)
args=parser.parse_args()

try:
    f = open(args.annovar,'r')
except IOError as e:
    print(e)
for line in f:
    info = line.strip().split("\t")
    if info[args.splicing_index]=="splicing" or info[args.exon_index] in ('frameshift deletion', 'frameshift insertion', 'stopgain'):#LoF
        flag = 1
        for i in range(23,46): #frequency
            if info[i]!="." and float(info[i])>float(args.frequency):
                flag=0
                break
        if info[args.genomic_superdups]!=".":
            flag=0
            continue
        if float(info[args.quality])<float(args.quality_threshold):
            flag=0
            continue
        gt = info[-1].split(":")
        if float(gt[2])<10:
            flag = 0
            continue
        if float(gt[3])<60:
            flag=0
            continue
        if info[args.heterozygote]=='0.5':
            ad = gt[1].split(",")
            try:
                if float(ad[1])/float(gt[2])<float(args.VAF_threshold):
                    flag = 0
            except:
                continue
        if ',' in info[202]:
            flag = 0
            continue
        if flag:
            print(line.strip())