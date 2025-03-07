package app

import (
	"sync"
	"path-traversal-server/internal/httpServer"
	"path-traversal-server/internal/filestorage"
)

func Run() error {
	var wg sync.WaitGroup
	var mu sync.Mutex
	
	filestorage.Start()
	mu.Lock()
	filestorage.AdminDir()
	mu.Unlock()
	server := httpServer.Server{Mu: mu}
	wg.Add(1)
	go server.Start(&wg)
	wg.Wait()
	return nil
}