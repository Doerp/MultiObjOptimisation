###sourcer###

#source all the necessary functions for the entire script to have a coherent structure in the project
#insert necessary functions here

#source R_Client
source("R_Client.R")
source("generationMaster.R")

input = generateInput(batchSize = 50, seed = sample(1:10000, 1))
