kerasModel = function(train1, train2){
        
        #Fit model to input shape    
        if(ncol(train1) == 3){
                
                X_1 = as.matrix(train1[,c('x1','x2')]) 
                y_1 = train1$func1
                
                X_2 = as.matrix(train2[,c('x1','x2')])
                y_2 = train2$func2
                
                #Initializing Model for function 1
                mod1 <- keras_model_sequential()
                mod1 %>% 
                        layer_dense(units = 512, activation = 'relu', input_shape=c(2)) %>% # Layer with 512 neurons
                        layer_batch_normalization() %>% # Batch normalization increases training speed
                        layer_dropout(rate = 0.4) %>% # drop_out to prevent overfitting
                        layer_dense(units = 256, activation = 'relu') %>% # Layer with 256 neurons
                        layer_batch_normalization() %>% # 
                        layer_dropout(rate = 0.4) %>% 
                        layer_dense(units = 1, activation = 'linear') # The last layer need to be dense (fully connected) with ten neuron and a Linear activation function
                
                #Initializing Model for function 2
                mod2 <- keras_model_sequential()
                mod2 %>% 
                        layer_dense(units = 512, activation = 'relu', input_shape=c(2)) %>% # Layer with 512 neurons
                        layer_batch_normalization() %>% # Batch normalization increases training speed
                        layer_dropout(rate = 0.4) %>% # drop_out to prevent overfitting
                        layer_dense(units = 256, activation = 'relu') %>% # Layer with 256 neurons
                        layer_batch_normalization() %>% 
                        layer_dropout(rate = 0.4) %>% 
                        layer_dense(units = 1, activation = 'linear') # The last layer need to be dense (fully connected) with ten neuron and a Linear activation function
                
        }
        
        else{
                
                X_1 = as.matrix(train1[,c("x1","x2","x3")]) 
                y_1 = train1$func1
                
                X_2 = as.matrix(train2[,c("x1","x2","x3")])
                y_2 = train2$func2
                
                #Initializing Model for function 1
                mod1 <- keras_model_sequential()
                mod1 %>% 
                        layer_dense(units = 512, activation = 'relu', input_shape=c(3)) %>% # Layer with 512 neurons
                        layer_batch_normalization() %>% # Batch normalization increases training speed
                        layer_dropout(rate = 0.4) %>% # drop_out to prevent overfitting
                        layer_dense(units = 256, activation = 'relu') %>% # Layer with 256 neurons
                        layer_batch_normalization() %>% # 
                        layer_dropout(rate = 0.4) %>% 
                        layer_dense(units = 1, activation = 'linear') # The last layer need to be dense (fully connected) with ten neuron and a Linear activation function
                
                #Initializing Model for function 2
                mod2 <- keras_model_sequential()
                mod2 %>% 
                        layer_dense(units = 512, activation = 'relu', input_shape=c(3)) %>% # Layer with 512 neurons
                        layer_batch_normalization() %>% # Batch normalization increases training speed
                        layer_dropout(rate = 0.4) %>% # drop_out to prevent overfitting
                        layer_dense(units = 256, activation = 'relu') %>% # Layer with 256 neurons
                        layer_batch_normalization() %>% 
                        layer_dropout(rate = 0.4) %>% 
                        layer_dense(units = 1, activation = 'linear') # The last layer need to be dense (fully connected) with ten neuron and a Linear activation function
        }
        

        #Compile both models
        mod1 %>% compile(
                optimizer = 'adam', # Using Adam_optimizer as Optimization
                loss = 'mean_squared_error',
                metrics = list('mse')
        )
        
        mod2 %>% compile(
                optimizer = 'adam', # Using Adam_optimizer as Optimization
                loss = 'mean_squared_error',
                metrics = list('mse')
        )
        
        #Fit both models
        mod1 %>% fit(
                x = X_1,
                y = y_1,
                validation_split = 0.2, 
                epochs = 50, # Number of epochs. Can be changed
                batch_size = 128,
                shuffle=T,
                verbose=2
        )
        
        mod2 %>% fit(
                x = X_2,
                y = y_2,
                validation_split = 0.2,
                epochs = 50, # Number of epochs. Can be changed
                batch_size = 128,
                shuffle=T,
                verbose=2
        )
        
        #pred1 = predict(object = mod1 , x = X_1)
        #pred2 = predict(object = mod2 , x = X_2)
        
        #df = data.frame(pred1, pred2)

return(list(mod1, mod2))
}
