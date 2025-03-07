package main

import (
	"log"
	"path-traversal-server/internal/app"
)

func main() {
	if err := app.Run(); err != nil {
		log.Fatalln(err)
	}
}
