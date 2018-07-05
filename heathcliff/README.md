# heathcliff

Create healthcheck daemons from a sidekick.


## How does this work?
This is a data container that injects a custom entrypoint, and spawns the healthcheck daemon script as an HTTPD process.
It currently requires busybox HTTPD is available in the container you wish to healthcheck.


## Example usage:
```
  zookeeper:
    image: blackducksoftware/hub-zookeeper:4.6.1
    environment:
      ENTRYPOINT: docker-entrypoint.sh zkServer.sh start-foreground /opt/blackduck/zookeeper/conf/zoo.cfg
      HEALTHCHECK: "zkServer.sh status /opt/blackduck/zookeeper/conf/zoo.cfg"
      WRAPPER: /opt/crate/heathcliff/healthchecks/wrapper.sh
    entrypoint: [ "sh", "-c" , "/opt/crate/heathcliff/entrypoint.sh" ]
    mem_reservation: 402653184
    links:
    - logstash:logstash
    volumes_from:
    - healthcheck-helper-zookeeper
    user: zookeeper:root
    labels:
      io.rancher.scheduler.affinity:host_label: bdhub.group=cattle
      io.rancher.sidekicks: healthcheck-helper-zookeeper
  healthcheck-helper-zookeeper:
    image: murkm/heathcliff:0.0.2
    links:
    - logstash:logstash
    labels:
      io.rancher.container.pull_image: always
      io.rancher.container.start_once: 'true'
```
