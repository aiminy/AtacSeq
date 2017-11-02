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

  #cmd0="module load java/1.8.0_60;export _JAVA_OPTIONS=-Xms256M -Xmx728M -XX:ParallelGCThreads=1;module unload python/2.7.3;
  #unset PYTHONPATH;
  #export PYTHONPATH=/nethome/axy148/anaconda3/envs/nothing/lib/python2.7/site-packages"

  cmd0="module load java/1.8.0_60;export _JAVA_OPTIONS=-Xms256M -Xmx728M -XX:ParallelGCThreads=1;module unload python/2.7.3"
 # unset PYTHONPATH;
#  export PYTHONPATH=/nethome/axy148/anaconda3/envs/nothing/lib/python2.7/site-packages"

  #cmd0="module load java/1.8.0_60;export _JAVA_OPTIONS=-Xms256M -Xmx728M -XX:ParallelGCThreads=1;
  #module unload python/2.7.3;
  #unset PYTHONPATH;
  #source activate python2;
  #export PYTHONPATH=/nethome/axy148/anaconda3/envs/python2/lib/python2.7/site-packages"

  cmd.gff2=paste(cmd0,cmd.gff,sep=";")

  system(cmd.gff2)

}

# R -e 'library(DoGs);library(AtacSeq);AtacSeq:::testAtacSeqNonCluster("/media/aiminyan/DATA/AtacSeq_Input","/media/aiminyan/DATA/AtacSeq_Output")'

testAtacSeqNonCluster <- function(input.fastq.dir,output)
{

  file.1 <- list.files(input.fastq.dir,pattern="*.fq.gz$",all.files = TRUE,full.names = TRUE,recursive = TRUE,include.dirs = TRUE)

  r.lib<- Sys.getenv("R_LIBS_USER")

  if (!dir.exists(dirname(output)))
  {
    dir.create(dirname(output), recursive = TRUE)
  }

  #input <- paste(file.1,collapse = " ")
  #output <- output.file.dir

  #cmd0="export PATH=/usr/bin:$PATH"

  cmd1 <- paste("sh",file.path(r.lib,"AtacSeq/bin/bash/testAtacSeq1.sh"),file.1[1],file.1[2],output,sep = " ")

  print(cmd1)

  system(cmd1)

}

CutStringByNFromEnd <- function(SequenceSampleID,n){

  SequenceSampleID2 <- lapply(SequenceSampleID,function(u,n){
    m <- nchar(u)
    ff <- strtrim(u,m-n)
    ff
  },n)

  SequenceSampleID3 <- unlist(SequenceSampleID2)

  return(SequenceSampleID3)
}

generateFq <- function(f,tm,pattern,TorC){

f1 <- f[grep(pattern = pattern,f$Sample.Name),]
f2 <- f1[which(f1$Hours==tm),]
s <- unique(f2$Sample)

x <- lapply(1:length(s),function(u,s,f2){

  v <- paste(paste0(TorC,u,"_1"),f2[which(f2$Sample==s[u]),]$fq.files[1],paste0(TorC,u,"_2"),f2[which(f2$Sample==s[u]),]$fq.files[2],sep=" ")
  v
},s,f2)

xx <- paste(do.call(c,x),collapse = " ")

xx

}

# sample.info = "~/pegasus/Project/Alejandro_AtacSeq/ATACSeq_sample_mapping.csv"
# title = "IL-2vsPBS"
# species = "mm10"
# input.fq.dir = "~/pegasus/Project/Alejandro_atac/DATA/Formatted"
# output = "~/pegasus/Project/Alejandro_AtacSeq"
#
# AtacSeq:::testAtacSeqNonCluster2(sample.info,input.fq.dir,title,species,output)
#
testAtacSeqNonCluster2 <- function(sample.info,input.fq.dir,title,species,output)
{

  f <- read.csv(sample.info)

  fq.files <- list.files(path = input.fq.dir, pattern= "*.fastq$",full.names = TRUE, recursive = TRUE)

  fq.files.2 <- cbind.data.frame(fq.files,CutStringByNFromEnd(as.character(basename(fq.files)),12),stringsAsFactors = F)

  colnames(fq.files.2)[2] =  "BaseSpace.Sample.ID"

  print(f)

  print(fq.files.2)

  ff <- merge(fq.files.2,f,by="BaseSpace.Sample.ID")

  print(ff)

  #fq1 <- ff[which((ff$Hours==16.00)&&(grep("PBS",ff$Sample.Name))),]$fq.files

  #fq2 <- ff[which((ff$Hours==16.00)&&(grep("IL2",ff$Sample.Name))),]$fq.files

  #print(fq1)

  #print(fq2)



  if (!dir.exists(dirname(output)))
  {
    dir.create(dirname(output), recursive = TRUE)
  }

cmd0 = "unset PYTHONPATH"
cmd1 = paste0("TITLE=",title)
cmd2 = paste0("SPECIES=",species)
cmd3 = paste0("WORK=",file.path(output,"$TITLE"))
cmd4 = "mkdir -p $WORK;cd $WORK"
cmd5 = "$HOME/atac_dnase_pipelines/atac.bds -species $SPECIES -nth 8"

cmd6.t = generateFq(ff,16.00,"IL2","-fastq")
cmd6.ck = generateFq(ff,16.00,"PBS","-ctl_fastq")

cmd6 = paste(cmd6.t,cmd6.ck,sep = " ")

cmd7 = "-enable_idr -auto_detect_adapter -idr_suffix -gensz mm -out_dir $WORK"
cmd8 = paste(cmd5,cmd6,cmd7)

cmd = paste(cmd0,cmd1,cmd2,cmd3,cmd4,cmd8,sep=";")

cat(cmd,"\n")

system(cmd)

#return(ff)

}
