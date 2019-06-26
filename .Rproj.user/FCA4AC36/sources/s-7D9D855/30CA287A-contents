
kerasModel <-function(df){
        
#install_keras()
        
input1 = df[c('x1','x2','func1')]
input1 = data.frame(scale(input1))  # Standardizing the data

input2 = dataframe[c('x1','x2','func2')]
input2 = data.frame(scale(input2))   # Standardizing the data


X_1 =as.matrix(input1[,c('x1','x2')]) 
y_1 = input1$func1

X_2 =as.matrix(input2[,c('x1','x2')])
y_2 = input2$func2

#initializing Model for function 1
model <- keras_model_sequential()
model %>% 
        layer_dense(units = 512, activation = 'relu', input_shape=c(2)) %>% # Layer with 512 neurons
        layer_batch_normalization() %>% # Batch normalization increases training speed
        layer_dropout(rate = 0.4) %>% # drop_out to prevent overfitting
        layer_dense(units = 256, activation = 'relu') %>% # Layer with 256 neurons
        layer_batch_normalization() %>% # 
        layer_dropout(rate = 0.4) %>% 
        layer_dense(units = 1, activation = 'linear') # The last layer need to be dense (fully connected) with ten neuron and a Linear activation function

#initializing Model for function 2
model1 <- keras_model_sequential()
model1 %>% 
        layer_dense(units = 512, activation = 'relu', input_shape=c(2)) %>% # Layer with 512 neurons
        layer_batch_normalization() %>% # Batch normalization increases training speed
        layer_dropout(rate = 0.4) %>% # drop_out to prevent overfitting
        layer_dense(units = 256, activation = 'relu') %>% # Layer with 256 neurons
        layer_batch_normalization() %>% 
        layer_dropout(rate = 0.4) %>% 
        layer_dense(units = 1, activation = 'linear') # The last layer need to be dense (fully connected) with ten neuron and a Linear activation function



model %>% compile(
        optimizer = 'adam', # Using Adam_optimizer as Optimization
        loss = 'mean_squared_error',
        metrics = list('mse')
)

model1 %>% compile(
        optimizer = 'adam', # Using Adam_optimizer as Optimization
        loss = 'mean_squared_error',
        metrics = list('mse')
)


model %>% fit(
        x = X_1,
        y = y_1,
        validation_split = 0.2, 
        epochs = 50, # Number of epochs. Can be changed
        batch_size = 128,
        shuffle=T,
        verbose=2
)


model1 %>% fit(
        x = X_2,
        y = y_2,
        validation_split = 0.2,
        epochs = 50, # Number of epochs. Can be changed
        batch_size = 128,
        shuffle=T,
        verbose=2
)


pred_1 = predict(object = model , x = X_1)
pred_2 = predict(object = model1 , x = X_2)

df = data.frame(pred_1, pred_2)

return(df)
}
