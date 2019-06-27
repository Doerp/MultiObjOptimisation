#'@description generate data and request responses from api to build dataframes
#'@author: Felix
#'@param fun: function that needs to be approximated
#'@param endpoint: endpoint that will be used
#'@param batchSize: batchSize of observations to be requested from the API; default = 50
generateDataFrames = function(endpoint = "api-test2D", batchSize = 50, loops = 1, base, token, dimensions = 2, sample = "adaptive"){
  outDf = data.frame()
  
  #fill dataframe with request and reponse data
  for(loop in 1:loops){
    
    if(sample == "random") {
      input = generateInput(batchSize, seed = sample(1:10000, size = 1), dimensions = dimensions)
      
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
    }
    
    else{ 
      
        break
    
      }
    
    outDf = rbind(outDf, output)
  }
  return(outDf)
}


####only for use with adaptive sampling does not work####
#' @description generate hypercube input variables for api requests [-5:5]
#' @author: Felix
#' @param batchSize: Size of df to be generated
#' @param mode: how do are these samples generated
generateInput = function(batchSize = 50, seed, dimensions) {
  print(paste("generating sample with seed" , seed))
  seed = seed
  set.seed(seed)
    
  if(dimensions == 3){
    x1 = sample(seq(-5, 5, by = 0.01))
    x2 = sample(seq(-5, 5, by = 0.01))
    x3 = sample(seq(-5, 5, by = 0.01))
    
    input = data.frame(x1 = x1[1:50], x2 = x2[1:50], x3 = x3[1:50], seed = seed)
  }
  else{
    x1 = sample(seq(-5, 5, by = 0.01))
    x2 = sample(seq(-5, 5, by = 0.01))
    
    input = data.frame(x1 = x1[1:50], x2 = x2[1:50], seed = seed)
  }

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
