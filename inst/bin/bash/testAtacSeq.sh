#!/bin/bash

module unload python/2.7.3
unset PYTHONPATH
source activate python2
export PYTHONPATH=/nethome/axy148/anaconda3/envs/python2/lib/python2.7/site-packages:$PYTHONPATH
#export PYTHONPATH=/nethome/axy148/anaconda3/lib/python3.6/site-packages:$PYTHONPATH

TITLE=AtacTest2;SPECIES=hg19;
FASTQ1_1=/nethome/axy148/bioinf525/SRR891268.1.fq.gz
FASTQ1_2=/nethome/axy148/bioinf525/SRR891268.2.fq.gz
WORK=/scratch/projects/bbc/aiminy_project/$TITLE; mkdir -p $WORK; cd $WORK
bds /nethome/axy148/atac_dnase_pipelines/atac.bds -species $SPECIES -nth 8 -fastq1_1 $FASTQ1_1 -fastq1_2 $FASTQ1_2 -out_dir $WORK
