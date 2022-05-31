package main

import (
	"context"
	"log"
	"time"

	v3 "go.etcd.io/etcd/client/v3"
)

func main() {
	cli, err := v3.New(v3.Config{
		Endpoints:   []string{"http://127.0.0.1:20000", "http://127.0.0.1:20002", "http://127.0.0.1:20004"},
		DialTimeout: 5 * time.Second,
	})
	if err != nil {
		panic(err)
	}
	defer cli.Close()

	testKey := "/test/key"
	testValue := "I love docker"

	_, err = cli.Put(context.Background(), testKey, testValue)
	if err != nil {
		log.Fatal("Put failed:", err)
	}

	res, err := cli.Get(context.Background(), testKey)
	if err != nil {
		log.Fatal("Get failed:", err)
	}

	kvs := res.Kvs
	val := string(kvs[0].Value)
	log.Println("result:", val == testValue)
}
