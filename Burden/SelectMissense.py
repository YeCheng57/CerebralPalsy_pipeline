import os
import sys
import argparse
parser=argparse.ArgumentParser(description="Select candidate variations from annovar txt")
parser.add_argument('--annovar','-a',help='path to annotated text file [annovar]',required=True)
parser.add_argument('--frequency','-f',help='the threshold of allele frequency',required=False,default=0.0001)
parser.add_argument('--VAF_threshold',help='the variant allele frequency threshold to be heterzygote', required=False, default=0.25)
parser.add_argument('--missense_index','-e',help='the column indicating the exonic function', required=False, default=9)
parser.add_argument('--genomic_superdups','-g', help='the column indication the annotation of genomic superdups database', required=False, default=18)
parser.add_argument('--phast100','-p', help='the column indicating the annotation of phastConsElements100way', required=False, default=16)
parser.add_argument('--heterozygote','-H',help='the column indicating the heterzygous or homozygous status', required=False, default=195)
parser.add_argument('--quality','-q',help='the column indicating the variation quality', required=False, default=196)
parser.add_argument('--quality_threshold','-qt',help='the threshold the variation quality', required=False, default=30)
parser.add_argument('--revel','-re',help='the column indicating REVEL', required=False, default=90)
parser.add_argument('--revel_threshold','-rt',help='the threshold the REVEL phred score', required=False, default=0.75)
parser.add_argument('--cadd','-ca',help='the column indicating CADD', required=False, default=119)
parser.add_argument('--cadd_threshold','-ct',help='the threshold the CADD phred score', required=False, default=10)
parser.add_argument('--MCAP','-m',help='the column indicating M-CAP', required=False, default=88)
parser.add_argument('--SIFT','-s',help='the column indicating SIFT', required=False, default=50)
parser.add_argument('--Poly2HDIV','-pd',help='the column indicating Polyphen2HDIV', required=False, default=56)
parser.add_argument('--Poly2HVAR','-pv',help='the column indicating Polyphen2HVAR', required=False, default=59)
parser.add_argument('--MutationTaster','-mu',help='the column indicating MutationTaster', required=False, default=65)
parser.add_argument('--MissenseModel','-mm', help = 'the model used on missense mutations, s:SIFT, r: REVEL, c:CADD, m:MCAP', required=True, default='r')
args=parser.parse_args()

try:
    f = open(args.annovar,'r')
except IOError as e:
    print(e)
for line in f:
    info = line.strip().split("\t")
    if info[args.missense_index] =='nonsynonymous SNV':#LoF
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
        if args.MissenseModel=='c':
                if flag and info[args.cadd]!="." and float(info[args.cadd])>=float(args.cadd_threshold):
                        print(line.strip())
        elif args.MissenseModel=='r':
                if flag and info[args.revel]!="." and float(info[args.revel])>=float(args.revel_threshold):
                        print(line.strip())
        elif args.MissenseModel=='s':
                if flag and info[args.SIFT]=="D" and info[args.Poly2HDIV]=="D" and info[args.Poly2HVAR]=="D" and info[args.MutationTaster]=="D":
                        print(line.strip())
        elif args.MissenseModel == 'm':
                if flag and info[args.MCAP]=="D":
                        print(line.strip())
