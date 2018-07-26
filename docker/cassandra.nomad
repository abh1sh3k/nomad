job "cassandra" {
	region = "in"
	datacenters = ["dc1"]

	task "cassandra-node-1" {
		driver = "docker"

		constraint {
			attribute = "${attr.unique.network.ip-address}"
			value = "127.0.0.1"
		}

		artifact {
                        source = "http://127.0.0.1:8080/cassandra.tar"
                }

		config {
			load = "cassandra.tar"
			image = "cassandra:2.2.12"
			port_map {
				gossip = 7000
			}

			volumes = [
				"/opt/data/cassandra:/var/lib/cassandra"
			]
		}

		resources {
			cpu = 500
			memory = 1024
			network {
				mbits = "10"
				port "gossip" {
					static = "7000"
				}
			}
		}

		service {
			name = "cassandra-node-1"
			tags = ["cassandra-node-1"]
			port = "gossip"
		}

		template {
			data = <<EOH
				CASSANDRA_BROADCAST_ADDRESS="{{key "service/cassandra/node1/CASSANDRA_BROADCAST_ADDRESS"}}"
			EOH

			destination = "secrets/file.env"
			env = true
		}
	}

	task "cassandra-node-2" {
		driver = "docker"

		constraint {
			attribute = "${attr.unique.network.ip-address}"
			value = "127.0.0.1"
		}

		artifact {
                        source = "http://127.0.0.1:8080/cassandra.tar"
                }

		config {
			load = "cassandra.tar"
			image = "cassandra:2.2.12"
			port_map {
				gossip = 7000
			}

			volumes = [
				"/opt/data/cassandra:/var/lib/cassandra"
			]
		}

		resources {
			cpu = 500
			memory = 1024
			network {
				mbits = "10"
				port "gossip" {
					static = "7000"
				}
			}
		}

		service {
			name = "cassandra-node-2"
			tags = ["cassandra-node-2"]
			port = "gossip"
		}

		template {
			data = <<EOH
				CASSANDRA_BROADCAST_ADDRESS="{{key "service/cassandra/node2/CASSANDRA_BROADCAST_ADDRESS"}}"
				CASSANDRA_SEEDS="{{key "service/cassandra/node2/CASSANDRA_SEEDS"}}"
			EOH

			destination = "secrets/file.env"
			env = true
		}
	}

	task "cassandra-node-3" {
		driver = "docker"

		constraint {
			attribute = "${attr.unique.network.ip-address}"
			value = "127.0.0.1"
		}

		artifact {
                        source = "http://127.0.0.1:8080/cassandra.tar"
                }

		config {
			load = "cassandra.tar"
			image = "cassandra:2.2.12"
			port_map {
				gossip = 7000
			}

			volumes = [
				"/opt/data/cassandra:/var/lib/cassandra"
			]
		}

		resources {
			cpu = 500
			memory = 1024
			network {
				mbits = "10"
				port "gossip" {
					static = "7000"
				}
			}
		}

		service {
			name = "cassandra-node-3"
			tags = ["cassandra-node-3"]
			port = "gossip"
		}

		template {
			data = <<EOH
				CASSANDRA_BROADCAST_ADDRESS="{{key "service/cassandra/node3/CASSANDRA_BROADCAST_ADDRESS"}}"
				CASSANDRA_SEEDS="{{key "service/cassandra/node3/CASSANDRA_SEEDS"}}"
			EOH

			destination = "secrets/file.env"
			env = true
		}
	}
}
