package main
import "fmt"
import (
	"github.com/hashicorp/consul/api"
	"time"
	"sync"
)

func validFailingCheck(check *api.AgentCheck) bool {
	return check.Status == "critical" && check.Output == "TTL expired"
}

func storeValidFailingChecks(oldAges failingCheckMap, checks map[string]*api.AgentCheck, ageQuant int) map[string]*failingCheck {
	rv := make(failingCheckMap)
	for checkId, check := range checks {
		if validFailingCheck(check) {
			old := oldAges[checkId]
			if old != nil {
				old.age += ageQuant
				rv[checkId] = old
			} else {
				rv[checkId] = &failingCheck{0, check.CheckID, check.ServiceID}
			}
		}
	}
	return rv
}
type failingCheck struct {
	age       int
	id        string
	serviceId string
}
type failingCheckMap map[string]*failingCheck

type system struct {
	client             api.Client
	failingChecksC	chan failingCheckMap
	failedServiceEvent chan failingCheck
}

func newSystem() system {
	client, err := api.NewClient(api.DefaultConfig())
	if err != nil {
		panic(err)
	}
	return system{
		*client,
		make(chan failingCheckMap),
		make(chan failingCheck),
	}
}
func (s *system) fetchChecksStatus(wg sync.WaitGroup) {
	defer wg.Done()
	ticker := time.NewTicker(time.Millisecond * 1000)
	critChecksAge := make(failingCheckMap)
	for t := range ticker.C {
		fmt.Println("Tick", t)
		chks, err := s.client.Agent().Checks()
		if err != nil {
			panic(err)
		}
		critChecksAge = storeValidFailingChecks(critChecksAge, chks, 1)
		s.failingChecksC <- critChecksAge
	}
}

func (s *system) produceFailedChecks() {
	ageThreshold := 5
	for ages := range s.failingChecksC {
		for _, failingCheck := range ages {
			if failingCheck.age > ageThreshold {
				// as value to specifically use a copy
				s.failedServiceEvent <- *failingCheck
			}
		}
	}
}

func (s*system)deregisterFailedServices() {
	for chk := range s.failedServiceEvent {
		s.client.Agent().ServiceDeregister(chk.serviceId)
		fmt.Println("Deregistering service ", chk.serviceId, "after check failed", chk.age)
	}
}

func main() {
	sys := newSystem()

	var wg sync.WaitGroup
	wg.Add(1)

	go sys.fetchChecksStatus(wg)
	go sys.produceFailedChecks()

	for i := 0; i < 10; i++ {
		go sys.deregisterFailedServices()
	}

	wg.Wait()
}
