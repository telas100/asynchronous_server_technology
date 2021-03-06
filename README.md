# Project Asynchronous Server Technology

[![Build Status](https://travis-ci.org/docker-library/docs.svg?branch=master)](https://travis-ci.org/telas100/asynchronous_server_technology)

## Synopsis
This is a NodeJS project required for the Asynchronous Server Technology course at the ECE Paris. The project is centered around managing a key-value database owning
some metrics. Those metrics can be accessed by the registered users by requesting the server.

NB: The base project was expected to use LevelDB as DBMS but due to the lack of support for the Windows environments, the Redis DBMS has been prefered to manage the metrics.

## Requirements
- npm 3.3.6 or higher
- redis-server 2.4.6 or higher

## Project setup

git clone https://github.com/telas100/asynchronous_server_technology.git && cd asynchronous_server_technology/

npm install

redis-server

npm run populatedb

## Project scripts

npm run start => Run nodemon for the project

npm run test  => Run the unit test for the project

## Features
- Server owning metrics
- Client views
- Create/Login/Logout/Delete user session
- Get/Set/Delete metrics owned by user