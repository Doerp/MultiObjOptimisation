Svm_model = function(df){
        
input1 = df[c('x1','x2','func1')]
input1 = data.frame(scale(input1))  


input2 = df[c('x1','x2','func2')]
input2 = data.frame(scale(input2)) 

train_task1 = makeRegrTask(id = 'train', data = input1, target = 'func1' )
train_task2 = makeRegrTask(id = 'train', data = input2, target = 'func2' )


svm_learner = makeLearner(cl = 'regr.ksvm')

ctrl = makeTuneControlGrid()

rdesc = makeResampleDesc("CV", iters = 5L)

discrete_ps = makeParamSet(
        makeDiscreteParam("C", values = c(1.5, 2.0,2.5,3.0,3.5,4.0)),
        makeDiscreteParam("sigma", values = c(0.5, 1.0, 1.5, 2.0))
)

res1 = tuneParams("regr.ksvm", task = train_task1, resampling =
                         rdesc,
                 par.set = discrete_ps, control = ctrl)

res2 = tuneParams("regr.ksvm", task = train_task2, resampling =
                          rdesc,
                  par.set = discrete_ps, control = ctrl)


lrn1 = setHyperPars(makeLearner("regr.ksvm"), par.vals = res1$x)
lrn2 = setHyperPars(makeLearner("regr.ksvm"), par.vals = res2$x)


mod1 = train(learner = lrn1 ,task = train_task1)
mod2 = train(learner = lrn2 ,task = train_task2)



pred1 = predict(object = mod1,train_task1)
pred2 = predict(object = mod1,train_task2)



new_pred1 = pred1$data$response
new_pred2 = pred2$data$response


df = data.frame(new_pred1, new_pred2)


return(df)

}


