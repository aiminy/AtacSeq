# Instruction for setting and using AtacSeq pipeline

* Install some required tools
```{}
# install Anaconda3
# Download Anaconda 4.4.0 For Linux for Python 3.6 version from https://www.anaconda.com/download/
# After downkloading, run the following:
bash Anaconda3-4.4.0-Linux-x86_64.sh
module unload python/2.7.3
conda install -c bioconda cutadapt
```

* To install
```{r}
R -e 'library(devtools);install_github("aiminy/AtacSeq")'
```

* To test
```{r}
 R -e 'library(DoGs);library(AtacSeq);AtacSeq:::submitJob4testAtacSeq0()'
```

* To use
```{r}
R -e 'library(DoGs);library(AtacSeq);AtacSeq:::submitJob("hg19","/scratch/projects/bbc/aiminy_project/AtacSeq")'
#change to /nethome/axy148/atac_dnase_pipelines directory, and check
bds atac.bds
```

