job "testjava" {
        region = "in"
        datacenters = ["dc1"]

        task "testjava" {
                driver = "exec"
                user = "testuser"

                config {
                        command = "/bin/bash"
                        args = ["-c","cd /opt && java -Xms1024m -Xmx3072m -XX:+HeapDumpOnOutOfMemoryError -jar testjava.jar"]
                }

                service {
                        name = "testjava"
                        tags = ["testjava"]
                }
        }
}
