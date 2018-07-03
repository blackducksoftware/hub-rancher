# heathcliff

Create healthcheck daemons from a sidekick.


## How does this work?
This is a data container that injects a custom entrypoint, and spawns the healthcheck daemon script as an HTTPD process.
It currently requires busybox HTTPD is available in the container you wish to healthcheck.


## Example usage:
```
  postgres:
    image: blackducksoftware/hub-postgres:4.4.0
    volumes:
    - postgres96-data-volume-test:/var/lib/postgresql/data
    mem_reservation: 3221225472
    links:
    - cfssl:cfssl
    - logstash:logstash
    user: root:root
    volumes_from:
    - healthcheck-helper-postgres
    environment:
      ENTRYPOINT: /hub-database.sh postgres
      HEALTHCHECK: /usr/local/bin/docker-healthcheck.sh
      WRAPPER: /opt/crate/heathcliff/healthchecks/wrapper.sh
    entrypoint:
    - /opt/crate/heathcliff/entrypoint.sh
    labels:
      io.rancher.scheduler.affinity:host_label: crate.host.name=agitated_fletchling
      io.rancher.sidekicks: healthcheck-helper-postgres
  healthcheck-helper-postgres:
    image: containers.cisco.com/chrhogan/heathcliff:v1.1.3
    labels:
      io.rancher.container.start_once: 'true'

```