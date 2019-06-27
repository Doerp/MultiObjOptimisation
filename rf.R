rfModel = function(df){
        
        #Access and standardize data
        input1 = df[c("x1","x2","func1")]
        input1 = data.frame(scale(input1))  # Standardizing the data
        
        input2 = df[c("x1","x2","func2")]
        input2 = data.frame(scale(input2)) # Standardizing the data
        
        #Create train/test split for training algorithms
        ids1 = sample(1:nrow(input1), size=nrow(input1)*0.8, replace = FALSE)
        train1 = input1[ids1,]
        test1 = input1[-ids1,]
        
        ids2 = sample(1:nrow(input2), size=nrow(input2)*0.8, replace = FALSE)
        train2 = input2[ids2,]
        test2 = input2[-ids2,]
        
        #Create XGBoost learner
        train_task1 = makeRegrTask(id = 'train', data = train1, target = 'func1')
        train_task2 = makeRegrTask(id = 'train', data = train2, target = 'func2')
        
        rf_learner = makeLearner(cl = "regr.randomForest")
        
        #Creating 5-fold Cross Validation
        rdesc = makeResampleDesc("CV", iters = 5L)
        
        #Creating a parameter set for the XGBoost learner
        rf_params <- makeParamSet(
                # The number of trees in the model (each one built sequentially)
                makeIntegerParam("ntree", lower = 300, upper = 700),
                # Number of observations in the terminal nodes
                makeIntegerParam("nodesize", lower = 1, upper = 10),
                # Number of variables to be selected at a node split
                makeIntegerParam("mtry", lower = 2, upper = 10)
        )
        
        #Define how to search through the parameter set
        ctrl = makeTuneControlRandom(maxit=5L)
        #ctrl = makeTuneControlGrid()
        
        #Fine Tuning the Models for both functions based on param set
        res1 = tuneParams("regr.randomForest", task = train_task1, resampling = rdesc,
                          par.set = rf_params, control = ctrl)
        res2 = tuneParams("regr.randomForest", task = train_task2, resampling = rdesc,
                          par.set = rf_params, control = ctrl)
        
        #Setting the parameter for XGBooster which is selected as best from fine tuning
        lrn1 = setHyperPars(makeLearner("regr.randomForest"), par.vals = res1$x)
        lrn2 = setHyperPars(makeLearner("regr.randomForest"), par.vals = res2$x)
        
        #Retrain models based on optimal hyperparamsets
        mod1 = mlr::train(learner = lrn1, task = train_task1)
        mod2 = mlr::train(learner = lrn2, task = train_task2)
        
        #Predict the targets in the initial train task
        pred1 = predict(mod1, newdata = test1)
        print(performance(pred=pred1, measures=list(mse)))
        pred2 = predict(mod2, newdata = test2)
        print(performance(pred=pred2, measures=list(mse)))
        
        #Creating one dataframe with predictions for both functions
        new_pred1 = pred1$data$response
        new_pred2 = pred2$data$response
        
        df = data.frame(new_pred1, new_pred2)
        
        return(df)
        return(mod1)
        return(mod2)        
}