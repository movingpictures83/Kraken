library(optparse)
library(stringr)

source("RIO.R")

dyn.load(paste("RPluMA", .Platform$dynlib.ext, sep=""))
source("RPluMA.R")


input <- function(infile) {
  pfix = prefix()
  if (length(pfix) != 0) {
     prefix <- paste(pfix, "/", sep="")
  }
   parameters <<- readParameters(infile)
   samplex <<- parameters['samplex', 2]
   #fq1 <<- paste(prefix, parameters['fq1', 2], sep="")
   fq1 <<- parameters['fq1', 2]
   if ("fq2" %in% rownames(parameters)){
   fq2 <<- parameters['fq2', 2]
   #fq2 <<- paste(prefix, parameters['fq2', 2], sep="")
   }
   ncbi_blast_path <<- parameters['ncbi_blast_path', 2]
   Kraken2Uniq_path <<- parameters['Kraken2Uniq', 2]
   kraken_database_path <<- parameters['kraken_database_path', 2]
}


run <- function() {}

output <- function(outfile) {

   out_path <<- outfile
str = "";
print(c(ncbi_blast_path))
# run Kraken
   if ("fq2" %in% rownames(parameters)){
str = paste0(str,
             'export PATH=$PATH:', c(ncbi_blast_path), ' \n\n',
             Kraken2Uniq_path, ' \\\n',
             '--db ', kraken_database_path, ' \\\n',
             '--threads 24 \\\n',
             '--paired \\\n',
             '--use-names \\\n',
             '--report-minimizer-data \\\n',
             '--classified-out ', paste0(out_path, samplex), '#.fq', ' \\\n',
             '--output ', paste0(out_path, samplex, '.kraken.output.txt'), ' \\\n',
             '--report ', paste0(out_path, samplex, '.kraken.report.txt'), ' \\\n',#,
             paste0(fq1, ' \\\n'),
             paste0(fq2, '\n\n')
)
   }
   else{
str = paste0(str,
             'export PATH=$PATH:', c(ncbi_blast_path), ' \n\n',
             Kraken2Uniq_path, ' \\\n',
             '--db ', kraken_database_path, ' \\\n',
             '--threads 24 \\\n',
             '--use-names \\\n',
             '--report-minimizer-data \\\n',
             '--classified-out ', paste0(out_path, samplex), '#.fq', ' \\\n',
             '--output ', paste0(out_path, samplex, '.kraken.output.txt'), ' \\\n',
             '--report ', paste0(out_path, samplex, '.kraken.report.txt'), ' \\\n',#,
             paste0(fq1, ' \\\n')
)
   }
print(str)
system(str)
}
