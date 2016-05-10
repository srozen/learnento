# Learnento
----

[![Build Status](https://travis-ci.org/srozen/learnento.svg?branch=master)](https://travis-ci.org/srozen/learnento)
[![Coverage Status](https://coveralls.io/repos/github/srozen/learnento/badge.svg?branch=master)](https://coveralls.io/github/srozen/learnento?branch=master)
[![Code Climate](https://codeclimate.com/github/srozen/learnento/badges/gpa.svg)](https://codeclimate.com/github/srozen/learnento)

## What is it?

 Learnento is my end-of-course "thesis".   
 
 It's a chatting platform, with realtime messaging and realtime video/voice conferencing.   
 
 The project's name stands for _Learning English Together_, the final goal of this project is to build a service 
 to connect people wanting to make their english skills progress.
 
 As the main features are all the realtime side of this web-app, all the _english learning_ side will be build later.
 
## Current State

 I'm currently working on the realtime text chat, it should works kinda like the messenger.com like.
 
 Here's what I still have to do later :     
 
 * Voice/Video chat with WebRTC
 * Currently the user search is fairly basic, it should later suggest people depending on personal infos given by the user (hobbies, country, etc)
 * A lot of design, currently the website looks fairly bad
 
## Which technologies are used ? 


### Backend/Frontend

 * __Ruby on Rails__ : Used as the backend providing a RESTful API, serving the web-app, and also used for deploying and for the tests.
 * __AngularJS__ : Used for the frontend, providing a single-page app
 
### Realtime features
 
 * __Socket.io__ : Enables all the realtime features on the project
 * __Node.js__ : Manages socket.io client connections, and speaks with the Rails app through Redis
 * __Redis__ : This pub/sub service allows the Rails app and the Node/Socket.io server to communicate through channels
 