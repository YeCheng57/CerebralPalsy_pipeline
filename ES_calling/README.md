# Calling SNP/Indels and CNVs from WES. 
#### For WGS, just remove the -L parameter from the GATK pipelines.
Files Descriptions:
> WES CNV detection, please see https://github.com/ShenLab/CANOES and https://github.com/vplagnol/ExomeDepth for more details.
> > - CANOES.R: The CANOES algrithm for CNV detection.
> > - CANOES_ReadsCounting.sh: Reads Counts generating using bedtools.
> > - callCNVS.R: calling CNVs using RD methods.
> ```
> nohup bash CANOES_ReadsCount.sh &
> nohup Rscript callCNVs.R &
> ```
> For WGS CNV detection, we used cnvnator https://github.com/abyzovlab/CNVnator
> ```
>$ ./cnvnator -root file.root -tree file.bam -chrom chr1 chr2 chr3 chr4 chr5 chr6 chr7 chr8\
chr9 chr10 chr11 chr12 chr13 chr14 chr15 chr16 chr17 chr18 chr19 chr20 chr21 chr22 chrX chrY
# Generate histogram
$ ./cnvnator -root file.root -his 1000 -fasta file_genome.fa.gz
# Calculate statistics
$ ./cnvnator -root file.root -stat 1000 
# Partition
$ ./cnvnator -root file.root -partition 1000
# Call CNVs
$ ./cnvnator -root file.root -call 1000
> ```
> SNP/Indels detection
> > - config.json: configure file indicating IO, softwares and references used for variations calling
> > - trimfastq.conf: fastq trimming
> > - precalling.conf: reads alignment, bam file sort and mark duplicates.
> > - gatk_single.conf: variants calling using gatk HaplotypeCaller, remove --ERC GVCF if only vcf file output is needed.
> We used snakemake to control the job flow due to the numberous individuals sequenced
> ```
> snakemake -np -s gatk_single.conf
> snakemake -j --cluster "sbatch -p partition -n 2 --mem=4G"
> ```

