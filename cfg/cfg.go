//Package cfg is a configuration model
package cfg

import (
	"os"
	"strings"
)

//Cfg is a configuration model
type Cfg interface {
	MongoURI() string
	MongoDbName() string
}

type cfg struct {
	mongoURI    string
	mongoDbName string
}

//MongoUri returns MongoDb server URI
func (c cfg) MongoURI() string {
	return c.mongoURI
}

//MongoDbName returns MongoDb database name
func (c cfg) MongoDbName() string {
	return c.mongoDbName
}

//New creates a new instance of configuration model
func New() Cfg {
	c := cfg{"mongodb://localhost:27017", "goservice"}

	for _, e := range os.Environ() {
		pair := strings.Split(e, "=")
		if pair[0] == "MONGOURI" {
			c.mongoURI = pair[1]
		}
		if pair[0] == "MONGODBNAME" {
			c.mongoDbName = pair[1]
		}
	}

	return c
}
