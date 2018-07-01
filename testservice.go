package main

import (
	"bytes"
	"strconv"

	"github.com/sheng/air"
	"github.com/soljarka/testservice/cfg"
	"github.com/soljarka/testservice/db"
)

func main() {

	cfg := cfg.New()

	database, err := db.New(cfg.MongoURI(), cfg.MongoDbName())
	if err != nil {
		panic(err)
	}

	err = database.RunMigrations()
	if err != nil {
		panic(err)
	}

	air.Address = "0.0.0.0:2333"

	air.GET("/", func(req *air.Request, res *air.Response) error {
		texts, err := database.Texts().LoadAll()
		if err != nil {
			res.StatusCode = 500
			return res.String(err.Error())
		}
		return res.JSON(texts)
	})

	air.POST("/", func(req *air.Request, res *air.Response) error {
		key, err := strconv.Atoi(req.Params["key"])
		if err != nil {
			res.StatusCode = 400
			return res.String("Numeric key is required")
		}

		buf := new(bytes.Buffer)
		buf.ReadFrom(req.Body)
		text := buf.String()

		err = database.Texts().Write(key, text)
		if err != nil {
			res.StatusCode = 500
			return res.String(err.Error())
		}
		res.StatusCode = 201
		return res.String("OK")
	})

	air.DELETE("/", func(req *air.Request, res *air.Response) error {
		key, err := strconv.Atoi(req.Params["key"])
		if err != nil {
			res.StatusCode = 400
			return res.String("Numeric key is required.")
		}
		err = database.Texts().Delete(key)
		if err != nil {
			res.StatusCode = 500
			return res.String(err.Error())
		}
		res.StatusCode = 201
		return res.String("OK")
	})

	air.Serve()
}
