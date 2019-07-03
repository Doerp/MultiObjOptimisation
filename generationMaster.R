#'@description generate data and request responses from api to build dataframes
#'@author: Felix
#'@param fun: function that needs to be approximated
#'@param endpoint: endpoint that will be used
#'@param batchSize: batchSize of observations to be requested from the API; default = 50
generateDataFrames = function(endpoint = "api-test2D", batchSize = 50, loops = 1, base, token, dimensions = 2, sample = "intelligent"){
        outDf = data.frame()
        if(sample == "random") {
                
                for(loop in 1:loops){
                        
                        input = generateInput(batchSize, seed = sample(1:10000, size = 1), dimensions = dimensions)
                        print(input)
                        
                        if(dimensions == 3){
                                output = cbind(input,
                                               func1 = apirequest(input = input[,1:3], func = 1, endpoint = endpoint, base = base, token = token),
                                               func2 = apirequest(input = input[,1:3], func = 2, endpoint = endpoint, base = base, token = token))
                        }
                        
                        else{
                                output = cbind(input,
                                               func1 = apirequest(input = input[,1:2], func = 1, endpoint = endpoint, base = base, token = token),
                                               func2 = apirequest(input = input[,1:2], func = 2, endpoint = endpoint, base = base, token = token))
                        }
                        
                        outDf = rbind(outDf, output)
                }
                
                return(outDf)
                
        }
        
        if(sample == "intelligent") {
                
                #generate initial sample. Uniform from space with random arrangement
                
                input = generateInput(batchSize, seed = sample(1:10000, size = 1), dimensions = dimensions)
                input$seed = NULL
                
                if(dimensions == 3){
                        
                        #request initial sample
                        output = cbind(input,
                                       func1 = apirequest(input = input[,1:3], func = 1, endpoint = endpoint, base = base, token = token),
                                       func2 = apirequest(input = input[,1:3], func = 2, endpoint = endpoint, base = base, token = token))
                        
                        for(i in 1:loops){
                                iteration = intelligentSample(output = output, endpoint = endpoint, token = token, base = base, dimensions = dimensions)
                                output = rbind(output, iteration)
                                #vis
                                if(i %in% seq(1, 1000, by = 10)) {
                                        visualiseDatapoints(dataframe = output, dimensions = dimensions, mode = "all")
                                        Sys.sleep(15)
                                }
                        }
                }
                
                else{
                        #request initial sample
                        output = cbind(input,
                                       func1 = apirequest(input = input[,1:2], func = 1, endpoint = endpoint, base = base, token = token),
                                       func2 = apirequest(input = input[,1:2], func = 2, endpoint = endpoint, base = base, token = token))
                        
                        for(i in 1:loops){
                                iteration = intelligentSample(output = output, endpoint = endpoint, token = token, base = base, dimensions = dimensions)
                                output = rbind(output, iteration)
                                #vis
                                if(i %in% seq(1, 1000, by = 10)) {
                                        visualiseDatapoints(dataframe = output, dimensions = dimensions, mode = "all")
                                        Sys.sleep(15)
                                }
                        }
                }
                return(output)
                
        }
        

}

<<<<<<< HEAD

####only for use with adaptive sampling does not work####
=======
####only for use if adaptive sampling does not work####
>>>>>>> c20e8c5c7783db92ea3f676a2412382d92d2fcb4
#' @description generate hypercube input variables for api requests [-5:5]
#' @author: Felix
#' @param batchSize: Size of df to be generated
#' @param mode: how do are these samples generated
generateInput = function(batchSize = 50, seed, dimensions) {
        print(paste("generating random sample with seed" , seed))
        seed = seed
        set.seed(seed)
        
        if(dimensions == 3){
                x1 = sample(seq(-5, 5, by = 0.2))
                x2 = sample(seq(-5, 5, by = 0.2))
                x3 = sample(seq(-5, 5, by = 0.2))
                
                input = data.frame(x1 = x1[1:50], x2 = x2[1:50], x3 = x3[1:50], seed = seed)
        }
        else{
                x1 = sample(seq(-5, 5, by = 0.2))
                x2 = sample(seq(-5, 5, by = 0.2))
                
                input = data.frame(x1 = x1[1:50], x2 = x2[1:50], seed = seed)
        }
        
        return(input)
}

<<<<<<< HEAD
  return(input)
}


#' @description generate hypercube grid as basis for adaptive sampling  [-5:5]
#' @author: Niclas
#' @param stepSize: Size of the steps for the initial grid df to be generated
generateGrid = function(lowerBound = -5, upperBound = 5, stepSize = 0.1, dimensions) {
  
  if(dimensions == 3){
    x1 = seq(lowerBound, upperBound, by = stepSize)
    x2 = seq(lowerBound, upperBound, by = stepSize)
    x3 = seq(lowerBound, upperBound, by = stepSize)
    input = expand.grid(x1,x2,x3)
    colnames(input) <- c("x1","x2","x3")
    
    print(paste("generating initial grid of length" , nrow(input)))
    
  }
  else{
    x1 = seq(lowerBound, upperBound, by = stepSize)
    x2 = seq(lowerBound, upperBound, by = stepSize)
    input = expand.grid(x1,x2)
    colnames(input) <- c("x1","x2")
    
    print(paste("generating initial grid of length" , nrow(input)))
    
  }
  
  return(input)
}


#'@description generate initial grid with responses from api to enable efficient sampling
#'@author: Niclas
#'@param fun: function that needs to be approximated
#'@param endpoint: endpoint that will be used
#'@param batchSize: batchSize of observations to be requested from the API; default = 50
generateInputGrid = function(endpoint, base, token, dimensions){
  outDf = data.frame()
  
  #fill dataframe with request and reponse data
  input = generateGrid(lowerBound = -5, upperBound = 5, stepSize = 2, dimensions)
  
  if(dimensions == 3){
    output = cbind(input,
                   func1 = apirequest(input = input[,1:3], func = 1, endpoint = endpoint, base = base, token = token),
                   func2 = apirequest(input = input[,1:3], func = 2, endpoint = endpoint, base = base, token = token))
  }
  
  else{
    output = cbind(input,
                   func1 = apirequest(input = input[,1:2], func = 1, endpoint = endpoint, base = base, token = token),
                   func2 = apirequest(input = input[,1:2], func = 2, endpoint = endpoint, base = base, token = token))
  }
  outDf = rbind(outDf, output)
  return(outDf)
}
=======
intelligentSample = function(output, endpoint, base, token, dimensions){
        
        if(dimensions == 3) {
                #fit function to dataframe for function1
                f1 = lm(func1 ~ x1 + x2 + x3, data = output)
                #calculate confidence intervals
                conf = as.data.frame(predict(f1, newdata = output[,1:3], interval = "confidence"))
                #select highest intervals, select input points
                output$high = abs(conf$lwr - conf$upr)
                sel1 = dplyr::arrange(output, desc(high))[1:10,]
                #fit function to dataframe for function 2
                f2 = lm(func2 ~ x1 + x2 + x3, data = output)
                #calculate confidence intervals
                conf = as.data.frame(predict(f2, newdata = output[,1:3], interval = "confidence"))
                #select highest intervals, select input points
                output$high = abs(conf$lwr - conf$upr)
                sel2 = dplyr::arrange(output, desc(high))[1:10,]
                input = as.data.frame(sapply(rbind(sel1[,1:3],sel2[,1:3]), jitter))   
                #check for values out of bounds (-5,5) - even though Api allows for requests out of bounds?
                input = input[input$x1 <= 5 & input$x1 >= -5 & input$x2 <= 5 & input$x2 >= -5 & input$x3 <= 5 & input$x3 >= -5, ]
                #request top 20 most varied predictions of both functions
                iteration = cbind(input,
                                  func1 = apirequest(input = input[,1:3], func = 1, endpoint = endpoint, base = base, token = token),
                                  func2 = apirequest(input = input[,1:3], func = 2, endpoint = endpoint, base = base, token = token))  
        }
        
        else{
                #fit function to dataframe for function1
                f1 = lm(func1 ~ x1 + x2, data = output)
                #calculate confidence intervals
                conf = as.data.frame(predict(f1, newdata = output[,1:2], interval = "confidence"))
                #select highest intervals, select input points
                output$high = abs(conf$lwr - conf$upr)
                sel1 = dplyr::arrange(output, desc(high))[1:10,]
                #fit function to dataframe for function 2
                f2 = lm(func2 ~ x1 + x2, data = output)
                #calculate confidence intervals
                conf = as.data.frame(predict(f2, newdata = output[,1:2], interval = "confidence"))
                #select highest intervals, select input points
                output$high = abs(conf$lwr - conf$upr)
                sel2 = dplyr::arrange(output, desc(high))[1:10,]
                input = as.data.frame(sapply(rbind(sel1[,1:2],sel2[,1:2]), jitter))   
                #check for values out of bounds (-5,5) - even though Api allows for requests out of bounds?
                input = input[input$x1 <= 5 & input$x1 >= -5 & input$x2 <= 5 & input$x2 >= -5, ]
                #request top 20 most varied predictions of both functions
                iteration = cbind(input,
                                  func1 = apirequest(input = input[,1:2], func = 1, endpoint = endpoint, base = base, token = token),
                                  func2 = apirequest(input = input[,1:2], func = 2, endpoint = endpoint, base = base, token = token))
        }
        
        return(iteration)
}
>>>>>>> c20e8c5c7783db92ea3f676a2412382d92d2fcb4
