#!/bin/bash
#SBATCH -J bedtools
#SBATCH -p protein
#SBATCH -N 1
#SBATCH --cpus-per-task=2
#SBATCH -t 10-00:00:00
#SBATCH --mem=10G

bedtools multicov -bams `cat bamlist` -bed b -q 20 >>canoes.reads.txt
