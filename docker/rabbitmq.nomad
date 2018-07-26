job "rabbitmq" {
        region = "in"
        datacenters = ["dc1"]

        constraint {
                attribute = "${attr.unique.network.ip-address}"
                value = "127.0.0.1"
        }

        task "rabbitmq" {
                driver = "docker"

                artifact {
                        source = "http://127.0.0.1:8080/rabbitmq.tar"
                }

                config {
                        load = "rabbitmq.tar"
                        image = "rabbitmq:3.7.4-management-alpine"
                        port_map {
                                amqp = 5672
                                http = 15672
                        }

                }

                resources {
                        cpu = 500
                        memory = 1024
                        network {
                                mbits = "10"
                                port "amqp" {
                                        static = "5672"
                                }
                                port "http" {
                                        static = "15672"
                                }
                        }
                }

                service {
                       name = "rabbitmq-server"
                       tags = ["mq", "rabbitmq"]
                       port = "amqp"
               }
       }

}
