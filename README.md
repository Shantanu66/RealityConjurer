# Reality Conjurer

# Description:
A cross platform application for mobile devices built using Flutter framework
which conjures the real-life or reality images corresponding to the sketches
drawn by the user.
It has a built in sketch pad interface and a easy to use UI.
It basically uses a GAN nueral network/model called pix2pix algorithm.Pix2Pix algorithm
basically generates a mapping of one image to another using a refernce image
It basically trains the model to generate the image using the refernce image.
to give the final output image of the given sketch
We basically created a combined image of size(256x256)/standard size
in which the left half is a sketch and the right half is the the image output that we want/or
refernce image.
We create various types of images using cars,trees,faces,animals,etc to represent our collection
We then train the image in our neural network to make the mapping and train the model
the more we train the  better is the result
We now download the fully trained model for our use.
We then create the client part of our app in Flutter 
then to create the functionality of the app we need a backend/server/API to pass our sketch from the 
flutter client to our server so that our server can predict the sketch based on our download model
and then send it back to the client for display.

# How To Run This Project

    Clone the repository.
    cd card_accumulator
    Do flutter pub get.
# Preview 

# Steps to Download:
Clone this Repo in your system
and also clone the FLASK_API for reality generator repo for the server part
Now first run the server(steps provided)
then the client.
PS:-Full build will be availabe soon

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


