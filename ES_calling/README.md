# Calling SNP/Indels and CNVs from WES. 
#### For WGS, just remove the -L parameter from the GATK pipelines.
Files Descriptions:
> CNV detection, please see https://github.com/ShenLab/CANOES for more details.
> > - CANOES.R: The CANOES algrithm for CNV detection.
> > - CANOES_ReadsCounting.sh: Reads Counts generating using bedtools.
> > - callCNVS.R: calling CNVs using RD methods.
> ```
> nohup bash CANOES_ReadsCount.sh &
> nohup Rscript callCNVs.R &
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

