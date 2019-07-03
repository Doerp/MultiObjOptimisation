

head(dataframe)

index = function(a,list1){
        for(i in 1:length(list1)){
                if(list1[i]==a){
                        return(i)
                }
        }
        
        return(-1)
}

sort_by_values = function(list1,values){
        sorted_list=list()
        while (length(sorted_list) != length(list1)) {
                if(index(a = min(values), values) %in%  list1){
                        sorted_list = c(sorted_list,index(a = min(values), values))
                }
                values[index(a = min(values), values)] = Inf
        }
}


crowding_distance = function(values1, values2, front){
        distance = list()
        for (i in 1:length(front)) {
                distance = c(distance,0)
        }
        sorted1 = sort_by_values(list1 = front, values = values1)
        sorted2 = sort_by_values(list1 = front, values = values2)
        
        distance[1] = 99999999999
        distance[length(front)] = 99999999999
        
        for (k in 1:length(front)) {
                distance[k] = distance[k]+ (values1[sorted1[k+1]] - values2[sorted1[k-1]])/(max(values1)-min(values1))
        }
        
        for (k in 1:length(front)) {
                distance[k] = distance[k]+ (values1[sorted2[k+1]] - values2[sorted2[k-1]])/(max(values2)-min(values2))
        }
        
        return(distance)
                
}



crossover = function(a,b){
        r = runif(n = 1,min = 0,max = 1)
        if(r > 0.5){
                return(mutation((a+b)/2))
        }
        else{
                return(mutation((a-b)/2))
        }
               
}


mutation = function(output){
        r = runif(n = 1,min = 0,max = 1)
        if(r > 0.5){
              output = output + rnorm(n = 1,mean = 0,sd = 1)

        }
        return(mutation((a+b)/2))
}



pop_size = 20
max_gen = 921

min_x=-5
max_x=5

length(dataframe$func1[1:20])

install.packages("reticulate")

library(reticulate)
source('non_dominated_sort.R')

use_python("/usr/local/bin/python")

source_python(file = 'nsga.py')

head(dataframe)

fast_non_dominated_sort(dataframe$func1[1:20],dataframe$func2[1:20])


fast_non_dominated_sort(values1 = dataframe$func1[1:20],dataframe$func2[1:20])

source_py

library(ecr)


