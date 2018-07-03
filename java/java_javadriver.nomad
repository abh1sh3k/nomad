job "testjava" {
        region = "in"
        datacenters = ["dc1"]

        task "testjava" {
                driver = "java"

                config {
                        jar_path = "/opt/test/testjava.jar"
                        jvm_options = ["-Xms1024m", "-Xmx3072m", "-XX:+HeapDumpOnOutOfMemoryError"]
                }

                service {
                        name = "testjava"
                        tags = ["testjava"]
                }
        }
}
