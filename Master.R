###Master###
setwd("C:/Users/felix/Google Drive/Master/WWU/Data Analytics 2/MultObjOptimisation")
source("sourcer.R")
base="optim.uni-muenster.de:5000/"
token="866de98d0d47426e92cc0e3394df5f07"
batchSize=50

dimensions = 2
if(dimensions == 3){
        endpoint = "api-test3D"
}
if(dimensions == 2) {
        endpoint = "api-test2D"
}

#import data and build dataframe for observations and the two target variables. 
dataframe = generateDataFrames(endpoint = endpoint, batchSize = batchSize, loops = 20, base = base, 
                               token = token, dimensions = dimensions, sample = "intelligent")

#visualise these datapoints in a 3D explorable space. 
visualiseDatapoints(dataframe = dataframe, dimensions = dimensions, mode = "all")

#Generate train-test split for model training and tuning
split = split(df = dataframe, dimensions = dimensions)
train1 = as.data.frame(split[1])
test1 = as.data.frame(split[2])
train2 = as.data.frame(split[3])
test2 = as.data.frame(split[4])

#Train surrogate models for both functions including hyperparameter tuning and receive predictions on the test set
#install_tensorflow(version = "1.12")
ann = kerasModel(train1, train2, test1, test2, dimensions = dimensions)
xgboost = XGBoostModel(train1, train2, test1, test2)
rf = rfModel(train1, train2, test1, test2)
svm = svmModel(train1, train2, test1, test2)
knn = knnModel(train1, train2, test1, test2)

#Create data frame for comparing the different models
surrogate1 = assessPerformance(ann, knn, svm, xgboost, rf, surrogate = 1)
surrogate2 = assessPerformance(ann, knn, svm, xgboost, rf, surrogate = 2)

#Use best-performing surrogate models to predict the whole hypercube
if(dimensions == 3){
        grid = generateGrid(stepSize = 0.5, dimensions = dimensions)
}
if(dimensions == 2) {
        grid = generateGrid(stepSize = 0.1, dimensions = dimensions)
}

#Needs automation, algorithms are choosen manually and hardcoded!
surrogate1Pred = predict(surrogate1, newdata = grid)
surrogate2Pred = predict(surrogate2, newdata = grid)

grid$func1 <- surrogate1Pred$data$response
grid$func2 <- surrogate2Pred$data$response

#Visualize both surrogate models
visualiseDatapoints(dataframe = grid, dimensions = dimensions, mode = "func1")
visualiseDatapoints(dataframe = grid, dimensions = dimensions, mode = "func2")


# #Define Resampling strategy (default)
# rdesc = makeResampleDesc("CV", iters = 10)
# 
# #Benchmark mlr models on both surrogate models
# lrns1 = list(xgboost[[3]], rf[[3]], svm[[3]], knn[[3]])
# task1 = makeRegrTask(data=test1, target="func1")
# bmr1 = benchmark(lrns1, task1, rdesc, measures = list(mse, rsq))
# print(bmr1)
# #plotBMRBoxplots(bmr1)
# 
# lrns2 = list(xgboost[[4]], rf[[4]], svm[[4]], knn[[4]])
# task2 = makeRegrTask(data=test2, target="func2")
# bmr2 = benchmark(lrns2, task2, rdesc, measures = list(mse, rsq))
# print(bmr2)
# #plotBMRBoxplots(bmr2)
# 
# #Compare the benchmark results
# rmat1 = convertBMRToRankMatrix(bmr1)
# print(rmat1)
# rmat2 = convertBMRToRankMatrix(bmr2)
# print(rmat2)
