## Predict splicing effects of candidate variants by spliceAI
This prediction is time consuming. Therfore, we recommend that not all variants but only candidate variants (MAF < 0.01, .etc) were included for analysis.
To select variants after ANNOVAR annotation:
```
# a and b represents the column index of frequency data
awk -F "\t" '{flag=1;for(i=a;i<=b;i++){if($i>0.01){flag=0}}if(flag){print}}' annotated.txt
```
Please refer to https://github.com/illumina/SpliceAI.
