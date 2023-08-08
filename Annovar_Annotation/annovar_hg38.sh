#!/bin/bash
swd=/home/u19111510023/software/ANNOVAR
help(){
	cat << EOF
Annovar.sh -- 
Usage:bash dir_to_this_script -i vcf [ -o out_prefix -v genome_version -h]
Option:
	-i	input vcf file
	-o	output prefix[default: myanno]
	-v	genome version[default: hg38]
	-h	help document
Authors:Ting Wang
EOF
}
while getopts "i:o:v:h" opt;do
	case $opt in
		i)
			vcf=$OPTARG
			;;
		o)
			out=$OPTARG
			;;
		v)
			version=$OPTARG
			;;
		h)
			help
			exit 0
			;;
	esac
done
if [ $# -eq 0 ];then
	help
	exit 2
fi
if [ ! -r $vcf ];then
	echo $vcf not readable
fi
if [ -z $out ];then
	out="myanno"
fi
if [ -z $version ];then
	version="hg38"
fi
$swd/table_annovar.pl $vcf $swd/$version -buildver $version -out $out -remove -protocol refGene,ensGene,phastConsElements100way,cytoBand,genomicSuperDups,wgRna,gwasCatalog,dgvMerged,avsnp150,ALL.sites.2015_08,EAS.sites.2015_08,AFR.sites.2015_08,AMR.sites.2015_08,EUR.sites.2015_08,SAS.sites.2015_08,gnomad211_exome,dbscsnv11,dbnsfp42a,clinvar_20221231,gene4denovo201907,intervar_20180118 -operation g,g,r,r,r,r,r,r,f,f,f,f,f,f,f,f,f,f,f,f,f -nastring . -vcfinput -thread 6
