
# bsub -P bbc -J "AtacSeq" -o %J.AtacSeq.log -e %J.AtacSeq.err -W 72:00 -n 32 -q parallel -R 'rusage[mem= 16000 ] span[ptile= 16 ]' -u aimin.yan@med.miami.edu R -e 'library(AtacSeq);AtacSeq:::installAtacSeq("hg19","/scratch/projects/bbc/aiminy_project/AtacSeq")'

installAtacSeq <- function(genome,DATA.DIR)
{

  if(!dir.exists(DATA.DIR)){dir.create(DATA.DIR,recursive = TRUE)}

  cmd0= "bash ~/atac_dnase_pipelines/install_genome_data.sh"
  cmd1= paste0(cmd0,genome,DATA.DIR,seperate=" ")
  system(cmd1)

}
