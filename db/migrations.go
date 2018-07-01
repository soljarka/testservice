package db

import (
	"context"
	"fmt"

	"github.com/mongodb/mongo-go-driver/bson"
	"github.com/mongodb/mongo-go-driver/mongo"
)

type textsIndex struct {
	Key int `bson:"key"`
}

//RunMigrations executes db migrations
func (db database) RunMigrations() error {
	fmt.Println("Run migrations")
	defer finished()
	err := db.runTextsMigrations()
	if err != nil {
		return err
	}

	return nil
}

func finished() {
	fmt.Println("Migrations finished")
}

func (db database) runTextsMigrations() error {
	keysDocument, err := createBson(textsIndex{1})
	if err != nil {
		return err
	}
	optionsBuilder := mongo.NewIndexOptionsBuilder()
	optionsDocument := optionsBuilder.Unique(true).Build()
	indexModel := mongo.IndexModel{}
	indexModel.Keys = keysDocument
	indexModel.Options = optionsDocument
	err = db.createIndex("texts", indexModel)
	if err != nil {
		return err
	}
	return nil
}

func createBson(model interface{}) (*bson.Document, error) {
	bsonEncoder := bson.NewDocumentEncoder()
	document, err := bsonEncoder.EncodeDocument(model)
	if err != nil {
		return nil, err
	}
	return document, nil
}

func (db database) createIndex(collectionName string, model mongo.IndexModel) error {
	collection := db.client.Database(db.dbName).Collection(collectionName)
	indexView := collection.Indexes()
	res, err := indexView.CreateOne(context.TODO(), model, nil)
	if err != nil {
		fmt.Println(err)
	}
	fmt.Println(res)
	return nil
}
