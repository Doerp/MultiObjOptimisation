Svm_model = function(df){
        
        
        df=dataframe
        
input1 = df[c('x1','x2','func1')]
input1 = data.frame(scale(input1))  # Standardizing the data
 

input2 = df[c('x1','x2','func2')]
input2 = data.frame(scale(input2)) # Standardizing the data

train_task1 = makeRegrTask(id = 'train1', data = input1, target = 'func1' )
train_task2 = makeRegrTask(id = 'train2', data = input2, target = 'func2' )


ctrl = makeTuneControlGrid()

# Creating 5- fold Cross Validation
rdesc = makeResampleDesc("CV", iters = 5L)

# Creating a Discrete Parameter set to 'c' and 'sigma' values
discrete_ps1 = makeParamSet(
        makeDiscreteParam("C", values = c(1.5, 2.0,2.5,3.0,3.5)),
        makeDiscreteParam("sigma", values = c(0.5, 1.0, 1.5, 2.0))
)

#Fine Tuning the Model based on 'c' and 'sigma' values
res1 = tuneParams("regr.ksvm", task = train_task1, resampling =
                         rdesc,
                 par.set = discrete_ps1, control = ctrl)

discrete_ps2 = makeParamSet(
        makeDiscreteParam("C", values = c(4.0,4.5,5.0,5.5,6.0)),
        makeDiscreteParam("sigma", values = c(0.5, 1.0, 1.5))
)

#Fine Tuning the Model based on 'c' and 'sigma' values
res2 = tuneParams("regr.ksvm", task = train_task2, resampling =
                          rdesc,
                  par.set = discrete_ps2, control = ctrl)

# setting the parameter for SVM model which is selected as best from fine tuning
lrn1 = setHyperPars(makeLearner("regr.ksvm"), par.vals = res1$x)

# setting the parameter for SVM model which is selected as best from fine tuning
lrn2 = setHyperPars(makeLearner("regr.ksvm"), par.vals = res2$x)


mod1 = train(learner = lrn1 ,task = train_task1)
mod2 = train(learner = lrn2 ,task = train_task2)



pred1 = predict(object = mod1,train_task1)
pred2 = predict(object = mod2,train_task2)



new_pred1 = pred1$data$response
new_pred2 = pred2$data$response

l1 = list(mod1, mod2)

# Creating the dataframe with predicting the response varaiables using our models
#df = data.frame(new_pred1, new_pred2) 
return(l1)

return(df)

}


