//Package db is a mongodb adapter
package db

import (
	"context"
	"fmt"

	"github.com/mongodb/mongo-go-driver/mongo"
)

//Database is an interface for database operations
type Database interface {
	Texts() Texts
	RunMigrations() error
}

type database struct {
	client *mongo.Client
	dbName string
}

func (db database) Texts() Texts {
	collection := db.client.Database(db.dbName).Collection("texts")
	texts := texts{collection}
	return texts
}

//New returns an instance of database interface
func New(uri string, dbName string) (Database, error) {
	client, err := mongo.NewClient(uri)
	if err != nil {
		return nil, err
	}
	err = client.Connect(context.TODO())
	if err != nil {
		return nil, err
	}
	db := database{client, dbName}
	fmt.Println("Connection string: ", uri)
	fmt.Println("Database name: ", dbName)
	return db, nil
}
