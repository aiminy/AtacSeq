installAtacSeq <- function(genome,DATA.DIR)
{

  if(!dir.exists(DATA.DIR)){dir.create(DATA.DIR,recursive = TRUE)}

  cmd0= "bash ~/atac_dnase_pipelines/install_genome_data.sh"
  cmd1= paste(cmd0,genome,DATA.DIR,collapse = " ")
  print(cmd1)

  system(cmd1)

}

#R -e 'library(DoGs);library(AtacSeq);AtacSeq:::submitJob("hg19","/scratch/projects/bbc/aiminy_project/AtacSeq")'

submitJob <- function(genome,DATA.DIR){

  #Sys.setenv(JAVA_HOME='/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.45.x86_64/jre/lib/amd64/server')

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
