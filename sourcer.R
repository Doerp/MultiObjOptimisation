###sourcer###

#source all the necessary functions for the entire script to have a coherent structure in the project

<<<<<<< HEAD
#Install necessary packages
pkgs <-c('plot3D','ecr','ggplot2','reticulate','plot3Drgl',"roxygen2", "httr", "jsonlite", "htmltools", "mlr", "keras", "sf", "PrevMap")
=======
pkgs <-c('plot3D','ecr','ggplot2','reticulate','plot3Drgl',"roxygen2", "httr", "jsonlite", "htmltools", "mlr", "keras", "dplyr")
>>>>>>> c20e8c5c7783db92ea3f676a2412382d92d2fcb4
for(p in pkgs) {
  if(p %in% rownames(installed.packages()) == FALSE) {install.packages(p)}  
}

for(p in pkgs) {
  suppressPackageStartupMessages(library(p, quietly=TRUE, character.only=TRUE))
}
rm('p','pkgs')  

<<<<<<< HEAD
#insert necessary functions here
install_keras()
=======
#install_keras()
>>>>>>> c20e8c5c7783db92ea3f676a2412382d92d2fcb4
source("R_Client.R")
source("generationMaster.R") 
source("visMaster.R")
source("SVM.R")
source("ann.R")
#source("evolutionMaster.R") deprecated: is not needed. Misunderstanding of the task
