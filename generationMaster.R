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