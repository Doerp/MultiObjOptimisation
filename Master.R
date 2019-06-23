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
dataframe = generateDataFrames(endpoint = endpoint, batchSize = batchSize, loops = 100, base = base, 
                               token = token, dimensions = dimensions)

#visualise these datapoints in a 3D explorable space. 
visualiseDatapoints(dataframe = dataframe, dimensions = dimensions, mode = "all")

fn = prepareFunction()

#data is very much different in the two functions. Can we normalise them? I don't think so, right?

#try sequential models?








output_svm = Svm_model(df = dataframe)

output_keras = kerasModel(df = dataframe)


rsq_1 = cor(x = dataframe$func1,output_keras$pred_1)^2

rsq_2 = cor(x = dataframe$func2,output_keras$pred_2)^2

r_sqd <- function(actual , response){
        
       tss = sum((mean(actual) - actual)^2)
       rss = sum((actual - response)^2)
       
       print(tss)
       print(rss)
       
       rsq = 1-(rss/tss)
       
       return(rsq)
        
}

rsq_1
rsq_2

?scale

data.frame(scale(dataframe))


#respone of func1 is dependent on x2
ggplot(data = data.frame(scale(dataframe)), mapping = aes(x = x2, y = func1)) + geom_point()

ggplot(data = data.frame(scale(dataframe)), mapping = aes(x = x1, y = func1)) + geom_point()


#respone of func2 is dependent on x1
ggplot(data = data.frame(scale(dataframe)), mapping = aes(x = x1, y = func2)) + geom_point()



head(output_keras)
head(output_svm)


ggplot(data = output_keras , mapping = aes(x = pred_1 , y = pred_2)) + geom_point()

ggplot(data = output_svm , mapping = aes(x = new_pred1 , y = new_pred2)) + geom_point()
