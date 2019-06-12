###sourcer###

#source all the necessary functions for the entire script to have a coherent structure in the project
#insert necessary functions here

#source R_Client
source("R_Client.R")
source("generationMaster.R")
source("visMaster.R")
install.packages("plot3D")
library(plot3D)
install.packages("plot3Drgl")
library("plot3Drgl")
library(httr)
library(htmltools)
library(jsonlite)
