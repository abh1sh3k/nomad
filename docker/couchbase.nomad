job "couchbase" {
	region = "in"
	datacenters = ["dc1"]

	task "couchbase" {
		driver = "docker"

		constraint {
			attribute = "${attr.unique.network.ip-address}"
			value = "127.0.0.1"
		}

		artifact {
        source = "http://127.0.0.1:8080/couchbase.tar"
    }

		config {
			load = "couchbase.tar"
			image = "couchbase:community-4.5.1"
			port_map {
				http = 8091
				connect = 11210
			}

			volumes = [
				"/opt/data/couchbase:/opt/couchbase/var"
			]
		}

		resources {
			cpu = 500
			memory = 1024
			network {
				mbits = "10"
				port "http" {
					static = "8091"
				}
				port "connect" {
					static = "11210"
				}
			}
		}

		service {
			name = "couchbase"
			tags = ["couchbase"]
			port = "http"
		}

	}

}
