package main

import (
	"errors"
	"flag"
	"fmt"
	"github.com/hashicorp/consul/api"
	"math/rand"
)

type consulData struct {
	serviceName string
	serviceTag  string
	dc          string
	format      string
}

func (data *consulData) validate() (err error) {
	if data.serviceName == "" || data.serviceTag == "" {
		return errors.New("serviceName and serviceTag need to be defined")
	} else {
		return nil
	}
}

func (data *consulData) getServiceParamsFromCommandLine() (err error) {
	flag.StringVar(&data.serviceName, "name", "", "service name")
	flag.StringVar(&data.serviceTag, "tag", "", "service tag")
	flag.StringVar(&data.dc, "dc", "", "Data center where service should be queried, defaults to current data center")
	flag.StringVar(&data.format, "format", "http://%s:%d", "Golang compatible format string of returned service URI")

	flag.Parse()

	err = data.validate()
	if err != nil {
		flag.PrintDefaults()
	}

	return err
}

func (data *consulData) getServiceEntries(health *api.Health) (entries []*api.ServiceEntry, err error) {
	options := api.QueryOptions{}
	if data.dc != "" {
		options.Datacenter = data.dc
	}

	entries, _, err = health.Service(data.serviceName, data.serviceTag, true, &options)
	return entries, err
}

func getRandomEntry(entries []*api.ServiceEntry) (entry *api.ServiceEntry, err error) {
	if len(entries) < 1 {
		return nil, errors.New("No service found")
	}

	return entries[rand.Intn(len(entries))], nil
}

func (data *consulData) formatUri(entry *api.ServiceEntry) (str string) {
	return fmt.Sprintf(data.format, entry.Node.Address, entry.Service.Port)
}

func supplyServiceUri() (entryUri string, err error) {
	config := api.DefaultConfig()
	client, err := api.NewClient(config)
	if err != nil {
		return "", err
	}

	health := client.Health()

	data := consulData{}
	err = data.getServiceParamsFromCommandLine()
	if err != nil {
		return "", err
	}
	entries, err := data.getServiceEntries(health)
	if err != nil {
		return "", err
	}
	entry, err := getRandomEntry(entries)
	if err != nil {
		return "", err
	}
	return data.formatUri(entry), nil
}

func main() {
	uri, err := supplyServiceUri()
	if err != nil {
		panic(err)
	}

	fmt.Printf("%s", uri)
}
