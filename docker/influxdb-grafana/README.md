# Introduction
collectd, influxdb and grafana can be utilized for performance metrics collection of host, jvm etc.

**collectd** - It is a daemon which collects system and application performance metrics periodically and provides mechanisms to store the values in a variety of ways.

**influxdb** - It is a time-series database which can be used to store the metrics collected by collectd.

**grafana** - It is an open-source dashboard and graph editor for multiple datasources including influxdb.

# Installation

## collectd

### collectd installation on CentOS 7
Install and enable EPEL repository from the default yum repository by running the following command:

```
yum install epel-release
```
Once the EPEL repository has been installed, you can install collectd by running the following command:

```
yum --enablerepo=epel install collectd
```
Now, start the collectd service and enable the service to start at boot time:

```
systemctl start collectd
systemctl enable collectd
```
### collectd configuration
By default there are many plugins enabled but we will just watch cpu, disk, load and memory stats then disable remaining plugins.
```
server-1:~$ sudo nano /etc/collectd/collectd.conf

# Enable just these
LoadPlugin cpu
LoadPlugin disk
LoadPlugin load
LoadPlugin memory
```
In addition to above, enable `LoadPlugin network` then add block below to the bottom of the page.

```
<Plugin "network">
    Server "192.168.2.10" "25826"
</Plugin>
```
IP address above should be of Influxdb host where Influxdb will be running.

## Influxdb
No additional installation & configuration is required for Influxdb as we would be using docker image.

Run through following steps to start influxdb docker container:
- Create a folder, example influxdb
- Copy types.db and influxdb.conf
- Execute following command:
```
docker run --name influxdb -p 8083:8083 -p 8086:8086 -p 25826:25826/udp -v $PWD/influxdb:/var/lib/influxdb -v $PWD/influxdb.conf:/etc/influxdb/influxdb.conf:ro -v $PWD/types.db:/usr/share/collectd/types.db:ro influxdb
```

## Grafana
No additional installation & configuration is required for Grafana as we would be using docker image.

Run through following steps to start grafana docker container:
- Create a folder, example Grafana
- Execute following command
```
docker run --name grafana -p 3000:3000 -v $PWD/grafana:/var/lib/grafana --link influxdb grafana/grafana:3.1.1
```
