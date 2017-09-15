#!/bin/bash

TITLE=AtacTest;SPECIES=hg19;
FASTQ1_1=/nethome/axy148/bioinf525/SRR891268.1.fq.gz
FASTQ1_2=/nethome/axy148/bioinf525/SRR891268.2.fq.gz
WORK=/scratch/projects/bbc/aiminy_project/$TITLE; mkdir -p $WORK; cd $WORK
bds_scr $TITLE /home/axy148/atac_dnase_pipelines/atac.bds -species $SPECIES -nth 8 -fastq1_1 $FASTQ1_1 -fastq1_2 $FASTQ1_2
