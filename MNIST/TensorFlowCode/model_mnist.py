# initialisation :
import tensorflow as tf
from tensorflow import keras

import numpy as np
import matplotlib.pyplot as plt
import sys,os
from importlib import reload


x_train = str()
y_train = str()
X_test = str()
y_test = str()
model = keras.models.Sequential()

"""-----------récupérer les données :--------------"""
def getData():
    global x_train
    global y_train
    global x_test
    global y_test
    (x_train, y_train), (x_test, y_test) = keras.datasets.mnist.load_data()


"""-----------Resize des données :--------------"""
def resize_data():
    global x_train
    global y_train
    global x_test
    global y_test
    #befor resize :
    print("=============> befor resize :")
    print("x_train : ",x_train.shape) #afficher nbr des images + les dimentions des images (pexil*pexil,nbr couch color)
    print("y_train : ",y_train.shape)
    print("x_test  : ",x_test.shape)
    print("y_test  : ",y_test.shape)

    x_train = x_train.reshape(-1,28,28,1)
    x_test  = x_test.reshape(-1,28,28,1)

    #after resise :
    print("=============> after resize :")
    print("x_train : ",x_train.shape)
    print("y_train : ",y_train.shape)
    print("x_test  : ",x_test.shape)
    print("y_test  : ",y_test.shape)




"""-----------préparer les données :(normalisation) :--------------"""
def normalization_data():
    global x_train
    global y_train
    global x_test
    global y_test
    print('Before normalization : Min={}, max={}'.format(x_train.min(),x_train.max()))

    xmax=x_train.max()
    x_train = x_train / xmax # pour avoir les nbr dans l'image entre 0 et 1
    x_test  = x_test  / xmax

    print('After normalization  : Min={}, max={}'.format(x_train.min(),x_train.max()))



"""-----------have a look :--------------"""
def displayImg():
    global x_train
    global y_train
    print(y_train[1])
    plt.imshow(x_train[1], cmap=plt.cm.binary)
    plt.show()


"""-----------build the model :--------------"""
def BuildModel():
    """---------------------------------- Convolution (C) --------------------------------"""
    #=>convolution 1:
    model.add(keras.layers.Conv2D(filters=64, kernel_size = (3,3), activation="relu", input_shape=(28,28,1)))
    model.add(keras.layers.Conv2D(filters=64, kernel_size = (3,3), activation="relu"))
    #=>pooling & Normalization 1:
    model.add(keras.layers.MaxPooling2D(pool_size=(2,2)))
    model.add(keras.layers.BatchNormalization())
    #=>convolution 2:
    model.add(keras.layers.Conv2D(filters=128, kernel_size = (3,3), activation="relu"))
    model.add(keras.layers.Conv2D(filters=128, kernel_size = (3,3), activation="relu"))
    #=> pooling & Normalization 2:
    model.add(keras.layers.MaxPooling2D(pool_size=(2,2)))
    model.add(keras.layers.BatchNormalization())
    #=>convolution 3:
    model.add(keras.layers.Conv2D(filters=256, kernel_size = (3,3), activation="relu"))
    #=>pooling 3:
    model.add(keras.layers.MaxPooling2D(pool_size=(2,2)))

    """---------------------------------- neural network (NN) --------------------------------"""
    #=>regrouper tout les images dans une plat (flatten)
    model.add(keras.layers.Flatten())
    model.add(keras.layers.BatchNormalization())
    #=>add 512 neuron avec une fonction d'activation relu:
    model.add(keras.layers.Dense(512,activation="relu"))
    #=>out put avec 10 neuron avec une fonction d'activation softmax(calculer le proba de chaque neuron)
    model.add(keras.layers.Dense(10,activation="softmax"))



"""-----------compile :--------------"""
def compileModel():
    global model
    model.summary()
    model.compile(optimizer='adam',
                loss='sparse_categorical_crossentropy',
                metrics=['accuracy'])



"""-----------train the model :--------------""" 
def trainModel():
    global x_train
    global y_train
    global x_test
    global y_test
    global model
    history = model.fit(  x_train, y_train,
                        batch_size      = 64,
                        epochs          = 10,
                        verbose         = 1,
                        validation_data = (x_test, y_test)
                    )


"""-----------evaluation :--------------""" 
def evaluation():
    global x_test
    global y_test
    global model
    #-> final loss & accuracy:
    score = model.evaluate(x_test, y_test, verbose=0)
    print('Test loss     :', score[0])
    print('Test accuracy : ',score[1])
    print("\n======================== save Model =====================")
    model.save("model")


"""-----------prediction : (on utilisans data de test)--------------""" 
def getPredectTest():
    global model
    global x_test
    # print(x_test[8:9])
    # prediction = model.predict(x_test[8:9])
    # print(prediction)
    prediction = model.predict(x_test)
    print(prediction)

if __name__=="__main__":
    print("\n======================== get Data =====================")
    getData()
    print("\n======================== resize data =====================")
    resize_data()
    print("\n======================== Normalization =====================")
    normalization_data()
    print("\n======================== Build Model =====================")
    #displayImg()
    BuildModel()
    print("\n======================== compile Model =====================")
    compileModel()
    print("\n======================== train Model =====================")
    trainModel()
    print("\n======================== evaluate Model =====================")
    evaluation()
    #getPredectTest()
