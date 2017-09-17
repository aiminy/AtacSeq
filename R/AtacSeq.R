# if not runnning using bsub:
#
# R -e 'library(DoGs);library(AtacSeq);AtacSeq:::installAtacSeq("hg19","/scratch/projects/bbc/aiminy_project/AtacSeq")'
#
installAtacSeq <- function(genome,DATA.DIR)
{

  if(!dir.exists(DATA.DIR)){dir.create(DATA.DIR,recursive = TRUE)}

  #export PYTHONPATH=~/miniconda3/lib/python3.6;

  cmd0= "bash ~/atac_dnase_pipelines/install_genome_data.sh"
  cmd1= paste(cmd0,genome,DATA.DIR,collapse = " ")
  print(cmd1)

  system(cmd1)

}

#R -e 'library(DoGs);library(AtacSeq);AtacSeq:::submitJob("hg19","/scratch/projects/bbc/aiminy_project/AtacSeq")'

submitJob <- function(genome,DATA.DIR){

  if (!dir.exists(DATA.DIR))
  {
    dir.create(DATA.DIR, recursive = TRUE)
  }

  job.name <- "AtacSeq"

  Rfun1 <- 'library(AtacSeq);re <- AtacSeq:::installAtacSeq('

  Rinput <- paste0('\\"',genome,'\\",',
                   '\\"',DATA.DIR,'\\"')
  Rfun2 <- ')'

  Rfun <-paste0(Rfun1,Rinput,Rfun2)

  cmd.gff <- DoGs:::createBsubJobArrayRfun(Rfun,job.name,wait.job.name=NULL)

  system(cmd.gff)

}

testAtacSeq <- function(input.file.dir,output.file.dir)
{

  file.1 <- list.files(input.bam.dir,pattern=".bam$",all.files = TRUE,full.names = TRUE,recursive = TRUE,include.dirs = TRUE)

  r.lib<- Sys.getenv("R_LIBS_USER")

  if (!dir.exists(dirname(output.file.dir)))
  {
    dir.create(dirname(output.file.dir), recursive = TRUE)
  }

  input <- paste(file.1,collapse = " ")
  output <- output.file.dir

  cmd1 <- paste("sh",file.path(r.lib,"AtacSeq/bin/bash/testAtacSeq.sh"),input,output,sep = " ")

  print(cmd1)

  system(cmd1)

}

#R -e 'library(DoGs);library(AtacSeq);AtacSeq:::submitJob("hg19","/scratch/projects/bbc/aiminy_project/AtacSeq")'

submitJob4testAtacSeq <- function(input.file.dir,output.file.dir){

  job.name <- "RunAtac"

  Rfun1 <- 'library(AtacSeq);re <- AtacSeq:::testAtacSeq('

  Rinput <- paste0('\\"',input.file.dir,'\\",',
                   '\\"',output.file.dir,'\\"')
  Rfun2 <- ')'

  Rfun <-paste0(Rfun1,Rinput,Rfun2)

  cmd.gff <- DoGs:::createBsubJobArrayRfun(Rfun,job.name,wait.job.name=NULL)

  system(cmd.gff)

}


testAtacSeq0 <- function()
{

  #file.1 <- list.files(input.bam.dir,pattern=".bam$",all.files = TRUE,full.names = TRUE,recursive = TRUE,include.dirs = TRUE)

  r.lib<- Sys.getenv("R_LIBS_USER")

  #if (!dir.exists(dirname(output.file.dir)))
  #{
  #  dir.create(dirname(output.file.dir), recursive = TRUE)
  #
  #}

  #input <- paste(file.1,collapse = " ")
  #output <- output.file.dir

  #cmd0="export PATH=/usr/bin:$PATH"

  cmd1 <- paste("sh",file.path(r.lib,"AtacSeq/bin/bash/testAtacSeq.sh"),sep = " ")

  print(cmd1)

  system(cmd1)

}

#R -e 'library(DoGs);library(AtacSeq);AtacSeq:::submitJob4testAtacSeq0()'

submitJob4testAtacSeq0 <- function(){

  job.name <- "RunAtac"

  Rfun1 <- 'library(AtacSeq);re <- AtacSeq:::testAtacSeq0()'

  #Rinput <- paste0('\\"',input.file.dir,'\\",',
         #          '\\"',output.file.dir,'\\"')
  #Rfun2 <- ')'

  Rfun <- Rfun1

  cmd.gff <- DoGs:::createBsubJobArrayRfun(Rfun,job.name,wait.job.name=NULL)

  #cmd0="module load java/1.8.0_60;export _JAVA_OPTIONS=-Xms256M -Xmx728M -XX:ParallelGCThreads=1;module unload python/2.7.3;export PYTHONPATH=/nethome#/axy148/anaconda3/lib/python3.6/site-packages:$PYTHONPATH"

  cmd0="module load java/1.8.0_60;export _JAVA_OPTIONS=-Xms256M -Xmx728M -XX:ParallelGCThreads=1;
  module unload python/2.7.3;
  unset PYTHONPATH;
  source activate python2;
  export PYTHONPATH=/nethome/axy148/anaconda3/envs/python2/lib/python2.7/site-packages"

  cmd.gff2=paste(cmd0,cmd.gff,sep=";")

  system(cmd.gff2)

}

