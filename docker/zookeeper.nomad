job "zookeeper" {
        region = "in"
        datacenters = ["dc1"]

        constraint {
                attribute = "${attr.unique.network.ip-address}"
                value = "127.0.0.1"
        }

        task "zookeeper" {
                driver = "docker"

                artifact {
                        source = "http://127.0.0.1:8080/zookeeper.tar"
                }

                config {
                        load = "zookeeper.tar"
                        image = "zookeeper"

                        port_map {
                                zookeeper_client_port = 2181
                                zookeeper_follower_port = 2888
                                zookeeper_election_port = 3888
                        }
                }

                resources {
                        cpu = 500
                        memory = 1024
                        network {
                                mbits = "10"
                                port "zookeeper_client_port" {
                                        static = "2181"
                                }
                                port "zookeeper_follower_port" {
                                        static = "2888"
                                }
                                port "zookeeper_election_port" {
                                        static = "3888"
                                }
                                }
                       }

                       service {
                               name = "zookeeper"
                               tags = ["zookeeper"]
                               port = "zookeeper_client_port"
                       }
               }
       }
