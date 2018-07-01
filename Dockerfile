FROM golang

RUN mkdir /go/src/github.com
RUN mkdir /go/src/github.com/soljarka
RUN mkdir /go/src/github.com/soljarka/testservice
WORKDIR /go/src/github.com/soljarka/testservice
COPY . .

RUN go get -d -v ./...
RUN go install -v ./...

EXPOSE 2333

CMD ["testservice"]