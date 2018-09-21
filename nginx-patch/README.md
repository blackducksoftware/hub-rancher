# Patching NGINX container
#

## Rationale

Nginx as it is curently written will not refresh DNS names. 
This creates a problem for the HUB in any multinode environment with DNS based service discovery.
If any of backends referenced by NGINX restart and acquire new IP address, NGINX will fail with HTTP 5xx error.

## Solution

To force NGINX to query DNS we introduce variables in the proxy pass statement, i.e. instead of

```
    location / {
       . . . 
       proxy_pass https://${HUB_WEBAPP_HOST}:${HUB_WEBAPP_PORT};
       . . .
```

configuration should look like: following

```
    resolver 169.254.169.250;
    set $webapp_upstream ${HUB_WEBAPP_HOST};
    location / {
      . . .
      proxy_pass https://$webapp_upstream:${HUB_WEBAPP_PORT};
      . . .
```

## Caveats

Resolver should be valid and able to resolve platform services
