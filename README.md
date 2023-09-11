## Introduction

**splitspliceleaderpe** is a bioinformatics best-practice analysis pipeline for Split paired-end read files in two according to presence of splice leader in the first read..

The pipeline is built using [Nextflow](https://www.nextflow.io) and used [nf-core](https://nf-co.re/) templates.

The [SL.Oikopleura_diocia.arch](./SL.Oikopleura_diocia.arch) file gives a example of architecture file for the splice leader of _Oikopleura dioica_:

```
tagdust -1 S:ACTCATCCCATTTTTGAGTCCGATTTCGATTGTCTAACAG -2 R:N
tagdust -1 R:N
```

## Pipeline summary

TBD

## Pipeline test

The pipeline can be tested with a command like:

```
nextflow run ./main.nf --input input.test.csv -profile yourProfile -w path/to/your/scratch/area --arch SL.Oikopleura_diocia.arch --rrna OKIrRNA.fa
```

The main output files are in `results/tagdust/`.  Reads with no splice leader
are saved in `*_SL_un_READ*` and reads with splice leader in `*_SL_READ*`.
