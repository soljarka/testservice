package db

import (
	"context"

	"github.com/mongodb/mongo-go-driver/mongo"
)

//Texts handles a collection of texts
type Texts interface {
	Write(key int, text string) error
	Delete(key int) error
	LoadAll() ([]document, error)
}

type texts struct {
	collection *mongo.Collection
}

type document struct {
	Key  int    `bson:"key"`
	Text string `bson:"text"`
}

type documentKey struct {
	Key int `bson:"key"`
}

//Write adds a new text to a collection of texts
func (t texts) Write(key int, text string) error {
	d := document{Key: key, Text: text}
	_, err := t.collection.InsertOne(context.Background(), d)
	return err
}

func (t texts) Delete(key int) error {
	_, err := t.collection.DeleteOne(context.TODO(), documentKey{key}, nil)
	return err
}

func (t texts) LoadAll() ([]document, error) {
	cur, err := t.collection.Find(context.TODO(), nil)
	if err != nil {
		return nil, err
	}
	defer cur.Close(context.Background())
	result := []document{}
	for cur.Next(context.Background()) {
		document := document{}
		err = cur.Decode(&document)
		if err != nil {
			return nil, err
		}
		result = append(result, document)
	}

	return result, nil
}
