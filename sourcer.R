###sourcer###

#source all the necessary functions for the entire script to have a coherent structure in the project


#Install necessary packages
pkgs <-c('plot3D','ecr','ggplot2','reticulate','plot3Drgl',"roxygen2", "httr", "jsonlite", "htmltools", "kknn", "mlr", "keras", "tensorflow", "sf", "PrevMap", "randomForest", "xgboost", "data.table")

for(p in pkgs) {
  if(p %in% rownames(installed.packages()) == FALSE) {install.packages(p)}  
}

for(p in pkgs) {
  suppressPackageStartupMessages(library(p, quietly=TRUE, character.only=TRUE))
}
rm('p','pkgs')  

#insert necessary functions here

#install_keras()
source("R_Client.R")
source("generationMaster.R") 
source("visMaster.R")
source("supportvector.R")
source("keras.R")
source("xgboost.R")
source("rf.R")
source("knn.R")
source("multiOptimization.R")
#source("evolutionMaster.R") deprecated: is not needed. Misunderstanding of the task

#Source python for optimization purposes
use_python("/usr/local/bin/python")
source_python('nsga.py')
