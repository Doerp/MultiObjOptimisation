svmModel = function(train1, train2, test1, test2){
        
        train_task1 = makeRegrTask(id = "train", data = train1, target = "func1")
        train_task2 = makeRegrTask(id = "train", data = train2, target = "func2")
        
        svm_learner = makeLearner(cl = 'regr.ksvm')
        
        #Define how to search through the parameter set
        #ctrl = makeTuneControlRandom(maxit=5)
        ctrl = makeTuneControlGrid()
        
        # Creating 5- fold Cross Validation
        rdesc = makeResampleDesc("CV", iters = 5L)
        
        # Creating a Discrete Parameter set to 'c' and 'sigma' values
        discrete_ps = makeParamSet(
                makeDiscreteParam("C", values = c(1.5, 2.0,2.5,3.0,3.5,4.0)),
                makeDiscreteParam("sigma", values = c(0.5, 1.0, 1.5, 2.0))
        )
        
        #Fine Tuning the Model based on 'c' and 'sigma' values
        res1 = tuneParams("regr.ksvm", task = train_task1, resampling = rdesc,
                         par.set = discrete_ps, control = ctrl)
        res2 = tuneParams("regr.ksvm", task = train_task2, resampling = rdesc,
                          par.set = discrete_ps, control = ctrl)
        
        # setting the parameter for SVM model which is selected as best from fine tuning
        lrn1 = setHyperPars(makeLearner("regr.ksvm"), par.vals = res1$x)
        lrn2 = setHyperPars(makeLearner("regr.ksvm"), par.vals = res2$x)
        
        #Retrain models based on optimal hyperparamsets
        mod1 = mlr::train(learner = lrn1, task = train_task1)
        mod2 = mlr::train(learner = lrn2, task = train_task2)
        
        #Predict the targets in the test data
        pred1 = predict(mod1, newdata = test1)
        perf1 = performance(pred=pred1, measures=list(mse))
        pred2 = predict(mod2, newdata = test2)
        perf2 = performance(pred=pred2, measures=list(mse))
        
        #Creating one dataframe with predictions for both functions
        #new_pred1 = pred1$data$response
        #new_pred2 = pred2$data$response
        
        #df = data.frame(new_pred1, new_pred2)
        
        return(list(mod1, mod2, perf1, perf2))
}