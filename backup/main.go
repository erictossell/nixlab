package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"os/exec"
	"strings"
	"sync"
)

func main() {
	if len(os.Args) < 4 {
		log.Fatalf("Usage: %s <api_id> <api_key> <config_file> [bucket_name]", os.Args[0])
	}
	apiID := os.Args[1]
	apiKey := os.Args[2]
	configFile := os.Args[3]
	bucketName := os.Args[4]

	// New check for the number of arguments to correctly assign bucketName
	if len(os.Args) > 4 {
		bucketName = os.Args[4]
	} else {
		var err error
		bucketName, err = os.Hostname()
		if err != nil {
			log.Fatalf("Error getting hostname: %v", err)
		}
	}

	authorize(apiID, apiKey)
	checkAndCreateBucket(bucketName)
	syncPaths(configFile, bucketName, 5)
}

func authorize(apiID string, apiKey string) {
	cmd := exec.Command("backblaze-b2", "authorize-account", apiID, apiKey)
	if err := cmd.Run(); err != nil {
		log.Fatalf("Error in authorization: %v", err)
	}
}

func checkAndCreateBucket(bucketName string) {
	cmd := exec.Command("backblaze-b2", "list-buckets")
	output, err := cmd.Output()
	if err != nil {
		log.Fatalf("Error listing buckets: %v", err)
	}
	if !strings.Contains(strings.ToLower(string(output)), strings.ToLower(bucketName)) {
		createBucket(bucketName)
	}
}

func createBucket(bucketName string) {
	cmd := exec.Command("backblaze-b2", "create-bucket", bucketName, "allPrivate")
	if err := cmd.Run(); err != nil {
		log.Fatalf("Error creating bucket: %v", err)
	}
}

func syncPath(sourcePath, destPath, bucketName string, wg *sync.WaitGroup, errChan chan<- error, semaphore chan struct{}) {
	defer wg.Done()

	// Acquire semaphore
	semaphore <- struct{}{}

	cmd := exec.Command("backblaze-b2", "sync", "--excludeAllSymlinks", "--replaceNewer", "--keepDays", "90", sourcePath, fmt.Sprintf("b2://%s/%s", bucketName, destPath))
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	if err := cmd.Run(); err != nil {
		errChan <- fmt.Errorf("error syncing path %s: %w", sourcePath, err)
	}

	// Release semaphore
	<-semaphore
}

func syncPaths(configFile string, bucketName string, concurrencyLimit int) {
	file, err := os.Open(configFile)
	if err != nil {
		log.Fatalf("Error opening config file: %v", err)
	}
	defer file.Close()

	var wg sync.WaitGroup
	errChan := make(chan error, 1)
	semaphore := make(chan struct{}, concurrencyLimit)

	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := scanner.Text()
		paths := strings.Split(line, ",")
		if len(paths) != 2 {
			log.Printf("Invalid config line (expected 'source,destination'): %s", line)
			continue
		}
		wg.Add(1)
		go syncPath(paths[0], paths[1], bucketName, &wg, errChan, semaphore)
	}

	go func() {
		wg.Wait()
		close(errChan)
		close(semaphore)
	}()

	for err := range errChan {
		log.Println(err)
	}

	if err := scanner.Err(); err != nil {
		log.Fatalf("Error reading config file: %v", err)
	}
}
