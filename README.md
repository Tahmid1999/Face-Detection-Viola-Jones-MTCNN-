# Face-Detection (Viola-Jones & MTCNN)
## Introduction 
The Viola–Jones object detection framework is an object detection framework which provide robust and competitive object 
detection rates in real-time proposed in 2001 by Paul Viola and Michael Jones. Even though it can be trained to detect a variety 
of object classes, it was motivated mainly by the task of face detection. This face detection framework is capable of processing 
images extremely rapidly and achieving high detection rates. There are three main stages of face detection framework.

1. Integral Image
2. Adaboost Algorithm
3. Cascading

Multi-task Cascaded Convolutional Neural Networks (MTCNN) is a method of face detection and alignment based on deep convolution neural network that is to say, this 
method can accomplish the task of face detection and alignment at the same time.Compared with the traditional method, 
MTCNN has better performance, can accurately locate the face,and the speed is also faster, in addition, MTCNN can also 
detect in real time. MTCNN consists of three neural network cascades, namely P-Net, R-Net, and O-Net. In order to achieve 
face recognition on a unified scale, the original image should be scaled to different scales to form an image pyramid before 
using these networks. 

In this program, I developed a  GUI to see a comparative performance between these two algorithms of face detection. It is interesting because viola-jones is an image processing-based algorithm. On the other hand, MTCNN is a CNN-based algorithm. So it will be interesting. 

## How to run the program 

Your machine should be installed with MatLab. To check this program with your webcam you may need to add on "MATLAB Support Package for USB Webcams" MATLAB Support Package for USB Webcams - File Exchange - MATLAB Central (mathworks.com). 
Then run "MyGUI.m" file with MatLab. 
