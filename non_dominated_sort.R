
fast_non_dominated_sort = function(values1,values2){
        
        values1 = dataframe$func1[1:20]
        values2 = dataframe$func2[1:20]
        
        S= replicate(length(values1), list())

        front = list(list())
        
        n = replicate(length(values1),0)
        
        rank = replicate(length(values1),0)
        
        
        '%!in%' <- function(x,y)!('%in%'(x,y))
        
        
        for (p in 1:length(values1)) {
               
                p=1
                
               # S[p] = list()
               # n[p] = 0

                for(q in 1:length(values1)+1){
                        
                        q=2
                        
                        values1[p]
                        values1[q]
                        
                        if ((values1[p] > values1[q] & values2[p] > values2[q]) | (values1[p] >= values1[q] & values2[p] > values2[q]) | (values1[p] > values1[q] & values2[p] >= values2[q])){
                                print("hi")
                                if (q %!in% S[p]){
                                        print("hi")
                                        S[p] = append(S[p],q)    
                                }
                        }
                                
                        else if((values1[q] > values1[p] & values2[q] > values2[p]) | (values1[q] >= values1[p] & values2[q] > values2[p]) | (values1[q] > values1[p] & values2[q] >= values2[p])){
                              
                                n[p] = n[p] + 1                                
                        }
                }
                if(n[p]==0){
                        rank[p] = 0
                        if (p %!in% front[1])
                                front= append(x = front[1],values = p)
                        
                }
                       
        }
        
        front
        print("outside")
        i = 1
        while(length(front[i]) != 0){
                print("hi")
                Q=list()
                
                for (p in front[i]){
                        for(q in S[p]){
                                n[q] =n[q] - 1 
                                if( n[q]==0){
                                        rank[q]=i+1
                                        if(q %!in% Q){
                                                Q=append(Q,q)  
                                        }
                                               
                                }
                                       
                        }
                }
                i = i+1
                front=append(front,Q)
        }
        
        list.remove(front,length(front))  
        return(front)
        }

