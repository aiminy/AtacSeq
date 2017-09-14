# Instruction for setting and using AtacSeq pipeline

* Install some required tools
```{}
# install Anaconda3
bash Anaconda3-4.4.0-Linux-x86_64.sh
```

* To install
```{r}
R -e 'library(devtools);install_github("aiminy/AtacSeq")'
```

* To use
```{r}
R -e 'library(DoGs);library(AtacSeq);AtacSeq:::submitJob("hg19","/scratch/projects/bbc/aiminy_project/AtacSeq")'
```
