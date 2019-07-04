


mutation = function(output){
        r = rnorm(n = dim(output)[1],mean = 0,sd = 1)
        
        
        for (i in 1:length(r)) {
                if(r[i] > 0.6 ){
                        print(i)
                       while(1){
                               new  = output[i,c('x1')] + rnorm(n = 1,mean = 0,sd = 1)
                               if(new <=5 & new >=-5){
                                       output[i,c('x1')] = new
                                       break;
                               }
                       
                       }      
                       }
                        
                }else if (r[i] < -0.4){
                        
                        while(1){
                                new  = output[i,c('x2')] + rnorm(n = 1,mean = 0,sd = 1)
                                if(new <=5 & new >=-5){
                                        output[i,c('x2')] = new
                                        break;
                                }
                                
                        }
                        
                }else{
                        
                        
                        while(1){
                                new1  = output[i,c('x1')] + rnorm(n = 1,mean = 0,sd = 1)
                                new2  = output[i,c('x2')] + rnorm(n = 1,mean = 0,sd = 1)
                                if(new1 <=5 & new1 >=-5){
                                        output[i,c('x1')] = new1
                                        break;
                                }
                                if(new2 <=5 & new2 >=-5){
                                        output[i,c('x2')] = new2
                                        break;
                                }
                                
                        }
                        output[i,c('x2')]  = output[i,c('x2')] + r[i]
                        output[i,c('x1')]  = output[i,c('x1')] + r[i]
                }
        }
        
        
        
        #df[,c("x1","x2")] + rnorm(n = dim(df[,c("x1","x2")])[1],mean = 0,sd = 1)
        
        
        return(output)
}




install.packages("reticulate")

library(reticulate)

use_python("/usr/local/bin/python")

source_python('nsga.py')



indices = exec(dataframe$func1[1:1000], dataframe$func2[1:1000])

indices = c(unlist(indices))

indices

indices = sapply(indices , function(x){
        x = x+1
})

indices

dataframe

mu

df = dataframe[indices,c("x1","x2")]

df

df1 = mutation(output = df)








