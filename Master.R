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

#Generate train-test split for model training and tuning
split = split(dataframe)
train1 = as.data.frame(split[1])
test1 = as.data.frame(split[2])
train2 = as.data.frame(split[3])
test2 = as.data.frame(split[4])

#Train surrogate models for both functions including hyperparameter tuning
xgboost = XGBoostModel(train1, train2)
rf = rfModel(train1, train2)
svm = svmModel(train1, train2)
knn = knnModel(train1, train2)
#install_tensorflow(version = "1.12")
ann = kerasModel(train1, train2)

#Define Resampling strategy (default)
rdesc.cv = makeResampleDesc("CV", iters = 5)

#Benchmark models on both surrogate models
lrns1 = list(xgboost[[1]], rf[[1]], svm[[1]], knn[[1]])
task1 = makeRegrTask(data=test1, target="func1")
bmr1 = benchmark(lrns1, task1, rdesc.cv, measures = list(mse, rsq))
print(bmr1)
#plotBMRBoxplots(bmr1)

lrns2 = list(xgboost[[2]], rf[[2]], svm[[2]], knn[[2]])
task2 = makeRegrTask(data=test2, target="func2")
bmr2 = benchmark(lrns2, task2, rdesc.cv, measures = list(mse, rsq))
print(bmr2)
#plotBMRBoxplots(bmr2)

#Compare results
rmat1 = convertBMRToRankMatrix(bmr1)
print(rmat1)
rmat2 = convertBMRToRankMatrix(bmr2)
print(rmat2)
