# Instruction for setting and using AtacSeq pipeline

* Install some required tools
```{}
# install the following software

# Anaconda3
# Download Anaconda 4.4.0 For Linux for Python 3.6 version from https://www.anaconda.com/download/
# After downkloading, run the following:
bash Anaconda3-4.4.0-Linux-x86_64.sh

# To use Python3.6 you installed locally, you need to unload default python/2.7.3 firstly
module unload python/2.7.3

# Other required software
conda install -c bioconda cutadapt
conda install -c bioconda sambamba
conda install -c conda-forge -c bioconda samtools bzip2
conda install -c bioconda picard
conda install -c bioconda idr
#pip install --upgrade --force-reinstall numpy
conda install -c conda-forge numpy

# To install pysam in your current conda environment, type:

# add channels
conda config --add channels r
conda config --add channels bioconda
conda config --add channels conda-forge

# list available channels
# less ~/.condarc

conda install pysam

```

# Test environment
```{r} 
module rm python/2.7.3
conda install -c conda-forge -c bioconda samtools bzip2
conda install htslib
```

* To install
```{r}
R -e 'library(devtools);install_github("aiminy/AtacSeq")'
```

* To install genome data for a specific genome(hg19) 
```{r}
R -e 'library(DoGs);library(AtacSeq);AtacSeq:::submitJob("hg19","/scratch/projects/bbc/aiminy_project/AtacSeq")'

```

* To check if atac is installed
```{r}
#change to /nethome/axy148/atac_dnase_pipelines directory, and check
bds atac.bds
```

* To test
```{r}
# On cluster
R -e 'library(DoGs);library(AtacSeq);AtacSeq:::submitJob4testAtacSeq0()'

#On local linux machine
R -e 'library(DoGs);library(AtacSeq);AtacSeq:::testAtacSeqNonCluster("/media/aiminyan/DATA/AtacSeq_Input","/media/aiminyan/DATA/AtacSeq_Output")'

sample.info = "~/pegasus/Project/Alejandro_AtacSeq/ATACSeq_sample_mapping.csv"
title = "IL-2vsPBS"
species = "mm10"
input.fq.dir = "~/pegasus/Project/Alejandro_atac/DATA/Formatted"
output = "~/pegasus/Project/Alejandro_AtacSeq"

R -e 'library(DoGs);library(AtacSeq);AtacSeq:::testAtacSeqNonCluster2(sample.info,input.fq.dir,title,species,output)'
```
