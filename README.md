# Testservice

Testservice is a Go playground application with a potential of becoming a Telegram bot.

## Setting Up Dev Environment
### Requirements:
* Go language 
* MongoDb server

Go binaries are available here: https://golang.org/dl/

For writing code in Go it is recommended to use [VS Code](https://code.visualstudio.com/) with Go extension,
which will automatically install necessary Go tools for you.

You don't need to explicitly clone this project, you can get it into your Go workspace with the following command:

    go get github.com/soljarka/testservice

Run the application with the following command:

    go run testservice.go

## Deployment With Docker
### Requirements:
* Docker CLI with docker-compose and a Docker host

Testservice can be deployed to any Docker host with a single command:

    docker-compose up -d
   
Docker-compose configuration is located in **docker-compose.yml.**
It automatically builds the **testservice** docker image using the Dockerfile,
starts the MongoDb container with a docker volume for data storage,
then starts the testservice container with MONGOURI environment variable and 2333 port exposed.
On start, Testservice ensures that necessary database indexes are created.
