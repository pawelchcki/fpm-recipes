marathon {
  port = 8080
  events = true
  bufferSize = 10000
  host = localhost
}

influxdb {
  host = "influxdb.service.consul" 
  port = 8086
  db = "mesos"
  checkLapse = 30
}

master "local" {
  host = "localhost"
  port = 5050
}

Slave "local" {
  host = "localhost"
  port = 5051
}

lapse=5
dieAfter = 12000
