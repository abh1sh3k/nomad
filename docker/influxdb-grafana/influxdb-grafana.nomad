job "influxdb-grafana" {
  region = "in"
  datacenters = ["dc1"]

  group "influxdb-grafana" {
    task "influxdb" {
      driver = "docker"

      config {
        image = "influxdb"
  			port_map {
  				admin = 8083
  				http = 8086
          collectd = 25826
  			}

  			volumes = [
  				"/opt/influxdb:/var/lib/influxdb",
  				"/opt/influxdb/influxdb.conf:/etc/influxdb/influxdb.conf:ro",
          "/opt/influxdb/types.db:/usr/share/collectd/types.db:ro"
  			]
  		}

      resources {
			   cpu = 500
			   memory = 1024
			   network {
	           mbits = "10"
             port "admin" {
              static = "8083"
             }
             port "http" {
              static = "8086"
             }
             port "collectd" {
              static = "25826"
             }
         }
      }

		  service {
			   name = "influxdb"
			   tags = ["influxdb"]
			   port = "http"
		  }
    }

    task "grafana" {
      driver = "docker"

      config {
        image = "grafana/grafana:3.1.1"
        port_map {
          http = 3000
        }

        volumes = [
          "/opt/grafana:/var/lib/grafana"
        ]
      }

      resources {
			   cpu = 500
			   memory = 1024
			   network {
	           mbits = "10"
             port "http" {
              static = "3000"
             }
         }
      }

		  service {
			   name = "collectd"
			   tags = ["collectd"]
			   port = "http"
		  }
    }
  }
}
