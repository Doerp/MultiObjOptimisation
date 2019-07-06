maxCrowdingDistance = function(dataframe, dimensions){
        
        #Source python script for optimization
        use_python("/usr/local/bin/python")
        source_python('nsga.py')
        
        #Execute python function to identify points that maximize crowding distance
        indices = exec(dataframe$func1, dataframe$func2)
        indices = c(unlist(indices))

        #Apply 1 to every index - In Python indexing starts from 0 but in R it starts from 1
        indices = sapply(indices , function(x){
                x = x+1
        })
        
        if(dimensions == 2){
                output = dataframe[indices,]
        }
        
        if(dimensions == 3){
                output = dataframe[indices,]
        }
        
        return(output)
}


mutation = function(output){
        r = rnorm(n = nrow(output),mean = 0,sd = 1)
        
        
        for (i in 1:length(r)) {
                if(r[i] > 0.6 ){
                        while(1){
                                new  = output[i,c('x1')] + rnorm(n = 1,mean = 0,sd = 0.5)
                                if(new <=5 & new >=-5){
                                        output[i,c('x1')] = new
                                        if(dim(output)[2] == 3){
                                        output[i,c('x3')] = new   
                                        }
                                        break;
                                }
                                
                        }      
                        
                }else if (r[i] < -0.4){
                        
                        while(1){
                                new  = output[i,c('x2')] + rnorm(n = 1,mean = 0,sd = 0.5)
                                if(new <=5 & new >=-5){
                                        output[i,c('x2')] = new
                                        break;
                                }
                                
                        }
                        
                }else{
                        
                        
                        while(1){
                                new1  = output[i,c('x1')] + rnorm(n = 1,mean = 0,sd = 0.5)
                                new2  = output[i,c('x2')] + rnorm(n = 1,mean = 0,sd = 0.5)
                                if(dim(output)[2]==3){
                                        new3  = output[i,c('x3')] + rnorm(n = 1,mean = 0,sd = 0.5)
                                        
                                }
                                
                                if(new1 <=5 & new1 >=-5){
                                        output[i,c('x1')] = new1
                                        break;
                                }
                                if(new2 <=5 & new2 >=-5){
                                        output[i,c('x2')] = new2
                                        break;
                                }
                                if(dim(output)[2]==3){
                                        if(new3 <=5 & new3 >=-5){
                                        output[i,c('x2')] = new2
                                        break;
                                        }
                                }
                                
                        }

                        
                }
        }
        
        return(output)
}



#op = dataframe[indices,c("x1","x2")]



#ggplot(data = op , mapping = aes(x = x1 , y = x2)) + geom_point()
#ggplot(data = op1 , mapping = aes(x = x1 , y = x2)) + geom_point()

