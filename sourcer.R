###sourcer###

#source all the necessary functions for the entire script to have a coherent structure in the project
#insert necessary functions here

#source R_Client
source("R_Client.R")
source("generationMaster.R")
source("visMaster.R")
source("evolutionMaster.R")
install.packages("plot3D")
install.packages("ecr")
library(ecr)
library(plot3D)
install.packages("plot3Drgl")
install.packages("roxygen2")
library(roxygen2)
library(plot3Drgl)
install.packages("httr")
install.packages("htmltools")
install.packages("jsonlite")
library(httr)
library(htmltools)
library(jsonlite)
