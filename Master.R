###Master###
source("sourcer.R")
base="optim.uni-muenster.de:5000/"
token="866de98d0d47426e92cc0e3394df5f07"

endpoint = "api-test2D"
dimensions = 2
batchSize = 50
MU = 30L; LAMBDA = 5L; MAX.ITER = 200L
algos = c("SVM", "XGB", "RF", "ANN", "KNN")

#all operations of the data take place here
#no external data may be generated - functional proramming; all data need to be returned to the master layer

#import data and build dataframe for observations and the two target variables. 
dataframe = generateDataFrames(endpoint = endpoint, batchSize = batchSize, loops = 20, base = base, 
                               token = token, dimensions = dimensions, sample = "random")

#visualise these datapoints in a 3D explorable space. 
visualiseDatapoints(dataframe = dataframe, dimensions = dimensions, mode = "all")

#create surrogate models for both functions (returns df as well as models)
svm = svmModel(dataframe)
keras = kerasModel(dataframe)