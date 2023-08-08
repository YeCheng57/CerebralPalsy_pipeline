## Gene-level Burden Analysis
File Description:
> - SelectLoF.py: Select candidate LoF (frameshift, stopgain, canonical splicing variants) from annotate annovar file.
> - SelectMissense.py: Select candidate Missense from annotate annovar file.
> - burden.R: Perform gene-based burden analysis (Fisher exact test)
```
python SelectLoF.py -h
python SelectMissense.py -h
```
Common filter: allele frequency, genotype quality, allele depth, GenomicSuperDups, VAF

For missense variants, we using REVEL model (REVEL > 0.75 as candidate) in our analysis. However, the CADD, M-CAP, SIFT, PolyPhen2, MutationTaster could also be included and these results could be compared.
We only including burden analysis while SKAT, SKAT-O, .etc are coming soon.
